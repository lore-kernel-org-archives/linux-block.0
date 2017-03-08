Return-Path: <jack@suse.cz>
Date: Wed, 8 Mar 2017 14:21:25 +0100
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170308132125.GD19740@quack2.suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
 <7734fd93-e4fd-65a7-bf32-08012de83c1e@kernel.dk>
 <20170222102425.GB23312@quack2.suse.cz>
 <20170301072528.GA9377@vader>
 <20170301072653.GB9377@vader>
 <20170301151109.GI20512@quack2.suse.cz>
 <20170306203818.GC16893@vader.DHCP.thefacebook.com>
 <20170307135730.GG2578@quack2.suse.cz>
 <20170307162823.GA20922@vader>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n2Pv11Ogg/Ox8ay5"
In-Reply-To: <20170307162823.GA20922@vader>
List-ID: <linux-block@vger.kernel.org>


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 07-03-17 08:28:23, Omar Sandoval wrote:
> On Tue, Mar 07, 2017 at 02:57:30PM +0100, Jan Kara wrote:
> > On Mon 06-03-17 12:38:18, Omar Sandoval wrote:
> > > Unfortunately, this patch actually seems to have introduced a
> > > regression. Reverting the patch fixes it.
> > > 
> > > I'm running a QEMU kvm vm with a virtio-scsi device and I get oopses
> > > like this:
> > 
> > What workload do you run? Or is it enough to just boot the kvm with
> > virtio-scsi enabled? Can you send me the kvm setup so that I can reproduce
> > this?
> 
> This is just while booting. In fact, you don't even need a virtio-scsi
> disk attached, it's enough to have the virtio-scsi-pci controller. This
> is my exact command line:
> 
> qemu-system-x86_64 -nodefaults -nographic -serial mon:stdio -cpu kvm64 \
> 	-enable-kvm -smp 1 -m 2G -watchdog i6300esb \
> 	-netdev user,id=vlan0,hostfwd=tcp:127.0.0.1:2222-:22 \
> 	-device virtio-net,netdev=vlan0 \
> 	-drive file=Silver/Silver.qcow2,index=0,media=disk,if=virtio,cache=none \
> 	-device virtio-scsi-pci \
> 	-kernel /home/osandov/linux/builds/virtio-scsi-crash/arch/x86/boot/bzImage \
> 	-virtfs local,path=/home/osandov/linux/builds/virtio-scsi-crash,security_model=none,readonly,mount_tag=modules \
> 	-append 'root=/dev/vda1 console=ttyS0,115200 scsi_mod.use_blk_mq=y'
> 
> My kernel config is here:
> https://github.com/osandov/osandov-linux/blob/master/configs/qemu.config

Thanks. I was able to reproduce. Do attached two patches help?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--n2Pv11Ogg/Ox8ay5
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-block-Allow-bdi-re-registration.patch"

>From 60623ea9de6309f7717fc3536e3594b079735af0 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 7 Mar 2017 18:01:51 +0100
Subject: [PATCH 1/2] block: Allow bdi re-registration

SCSI can call device_add_disk() several times for one request queue when
a device in unbound and bound, creating new gendisk each time. This will
lead to bdi being repeatedly registered and unregistered. This was not a
big problem until commit 165a5e22fafb "block: Move bdi_unregister() to
del_gendisk()" since bdi was only registered repeatedly (bdi_register()
handles repeated calls fine, only we ended up leaking reference to
gendisk due to overwriting bdi->owner) but unregistered only in
blk_cleanup_queue() which didn't get called repeatedly. After
165a5e22fafb we were doing correct bdi_register() - bdi_unregister()
cycles however bdi_unregister() is not prepared for it. So make sure
bdi_unregister() cleans up bdi in such a way that it is prepared for
a possible following bdi_register() call.

An easy way to provoke this behavior is to enable
CONFIG_DEBUG_TEST_DRIVER_REMOVE and use scsi_debug driver to create a
scsi disk which immediately hangs without this fix.

Fixes: 165a5e22fafb127ecb5914e12e8c32a1f0d3f820
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 6d861d090e9f..6ac932210f56 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -710,6 +710,11 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 	 */
 	atomic_dec(&bdi->usage_cnt);
 	wait_event(cgwb_release_wait, !atomic_read(&bdi->usage_cnt));
+	/*
+	 * Grab back our reference so that we hold it when @bdi gets
+	 * re-registered.
+	 */
+	atomic_inc(&bdi->usage_cnt);
 }
 
 /**
@@ -857,6 +862,8 @@ int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner)
 			MINOR(owner->devt));
 	if (rc)
 		return rc;
+	/* Leaking owner reference... */
+	WARN_ON(bdi->owner);
 	bdi->owner = owner;
 	get_device(owner);
 	return 0;
-- 
2.10.2


--n2Pv11Ogg/Ox8ay5
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-bdi-Fix-use-after-free-in-wb_congested_put.patch"

>From b9a6424cabd0eb4a663a1faeb11afef268faebc6 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 8 Mar 2017 13:24:47 +0100
Subject: [PATCH 2/2] bdi: Fix use-after-free in wb_congested_put()

bdi_writeback_congested structures get created for each blkcg and bdi
regardless whether bdi is registered or not. When they are created in
unregistered bdi and the request queue (and thus bdi) is then destroyed
while blkg still holds reference to bdi_writeback_congested structure,
this structure will be referencing freed bdi and last wb_congested_put()
will try to remove the structure from already freed bdi.

With commit 165a5e22fafb "block: Move bdi_unregister() to
del_gendisk()", SCSI started to destroy bdis without calling
bdi_unregister() first (previously it was calling bdi_unregister() even
for unregistered bdis) and thus the code detaching
bdi_writeback_congested in cgwb_bdi_destroy() was not triggered and we
started hitting this use-after-free bug. It is enough to boot a KVM
instance with virtio-scsi device to trigger this behavior.

Fix the problem by detaching bdi_writeback_congested structures in
bdi_exit() instead of bdi_unregister(). This is also more logical as
they can get attached to bdi regardless whether it ever got registered
or not.

Fixes: 165a5e22fafb127ecb5914e12e8c32a1f0d3f820
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 6ac932210f56..c6f2a37028c2 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -683,30 +683,18 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
-	struct rb_node *rbn;
 	void **slot;
 
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
-
 	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
 		cgwb_kill(*slot);
-
-	while ((rbn = rb_first(&bdi->cgwb_congested_tree))) {
-		struct bdi_writeback_congested *congested =
-			rb_entry(rbn, struct bdi_writeback_congested, rb_node);
-
-		rb_erase(rbn, &bdi->cgwb_congested_tree);
-		congested->bdi = NULL;	/* mark @congested unlinked */
-	}
-
 	spin_unlock_irq(&cgwb_lock);
 
 	/*
-	 * All cgwb's and their congested states must be shutdown and
-	 * released before returning.  Drain the usage counter to wait for
-	 * all cgwb's and cgwb_congested's ever created on @bdi.
+	 * All cgwb's must be shutdown and released before returning.  Drain
+	 * the usage counter to wait for all cgwb's ever created on @bdi.
 	 */
 	atomic_dec(&bdi->usage_cnt);
 	wait_event(cgwb_release_wait, !atomic_read(&bdi->usage_cnt));
@@ -754,6 +742,21 @@ void wb_blkcg_offline(struct blkcg *blkcg)
 	spin_unlock_irq(&cgwb_lock);
 }
 
+static void cgwb_bdi_exit(struct backing_dev_info *bdi)
+{
+	struct rb_node *rbn;
+
+	spin_lock_irq(&cgwb_lock);
+	while ((rbn = rb_first(&bdi->cgwb_congested_tree))) {
+		struct bdi_writeback_congested *congested =
+			rb_entry(rbn, struct bdi_writeback_congested, rb_node);
+
+		rb_erase(rbn, &bdi->cgwb_congested_tree);
+		congested->bdi = NULL;	/* mark @congested unlinked */
+	}
+	spin_unlock_irq(&cgwb_lock);
+}
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
@@ -774,7 +777,9 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return 0;
 }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
+static void cgwb_bdi_destroy(struct backing_dev_info *bdi) { }
+
+static void cgwb_bdi_exit(struct backing_dev_info *bdi)
 {
 	wb_congested_put(bdi->wb_congested);
 }
@@ -905,6 +910,7 @@ static void bdi_exit(struct backing_dev_info *bdi)
 {
 	WARN_ON_ONCE(bdi->dev);
 	wb_exit(&bdi->wb);
+	cgwb_bdi_exit(bdi);
 }
 
 static void release_bdi(struct kref *ref)
-- 
2.10.2


--n2Pv11Ogg/Ox8ay5--
