Return-Path: <ming.lei@redhat.com>
Date: Mon, 30 Jul 2018 19:50:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tomas Janousek <tomi@nomi.cz>, Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180730115002.GA6972@ming.t460p>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
 <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
 <20180730075949.GA1755@xps.pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730075949.GA1755@xps.pks.im>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 09:59:49AM +0200, Patrick Steinhardt wrote:
> On Sun, Jul 29, 2018 at 11:41:31AM +0200, Tomas Janousek wrote:
> > Hi,
> > 
> > On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> > > Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
> > > triggered on your machine.
> > 
> > While Patrick did miss the following patch:
> > 
> > * 765e40b675a9 ("block: disable runtime-pm for blk-mq"; July 2017).
> > 
> > there is at least one other way to trigger it -- enable laptop-mode-tools
> > or tlp which enable runtime-pm for all devices.
> > 
> > The "disable runtime-pm for blk-mq" only disables it _by_default_, but doesn't
> > prevent it from being enabled again from user-space, which it is unless one
> > manually blacklists sd devices from runtime-pm enablement. It's bitten a few
> > people already: https://github.com/rickysarraf/laptop-mode-tools/issues/123
> > 
> > (I found this thread because I'm also getting the NULL pointer dereference at
> > 00000000000001a8 on resume from suspend.)
> 
> Huh, I did send out some more details on how I reproduce the
> issue, but it seems like my mail didn't get through. While I
> don't use laptop-mode-tools, I do have some custom hotplugging
> scripts which do in fact enable runtime-PM for most devices.

Now runtime PM is still enabled for sd/sr, and I believe the following
patch is needed until we figure out one perfect way for supporting it
well:

diff --git a/block/blk-core.c b/block/blk-core.c
index 03a4ea93a5f3..090b782df129 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3769,9 +3769,11 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
-	if (q->mq_ops)
+	/* Don't enable runtime PM for blk-mq until it is ready */
+	if (q->mq_ops) {
+		pm_runtime_disable(dev);
 		return;
+	}
 
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;

Thanks,
Ming
