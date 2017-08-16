Return-Path: <chrism@mellanox.com>
From: Chris Mi <chrism@mellanox.com>
To: netdev@vger.kernel.org
Cc: aditr@vmware.com, stern@rowland.harvard.edu, agk@redhat.com,
        alexander.shishkin@linux.intel.com, alexandre.bounine@idt.com,
        alexander.deucher@amd.com, oakad@yahoo.com, ast@kernel.org,
        elder@kernel.org, adobriyan@gmail.com, alex.williamson@redhat.com,
        AlexBin.Xie@amd.com, viro@zeniv.linux.org.uk,
        amd-gfx@lists.freedesktop.org, amitkarwar@gmail.com,
        andresx7@gmail.com, andrew.donnellan@au1.ibm.com, afd@ti.com,
        akpm@linux-foundation.org, anil.gurumurthy@qlogic.com,
        anna.schumaker@netapp.com, acme@kernel.org, arnd@arndb.de,
        dedekind1@gmail.com, ashutosh.dixit@intel.com,
        ath10k@lists.infradead.org, Bart.VanAssche@sandisk.com,
        bhaktipriya96@gmail.com, bjorn.andersson@linaro.org,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        bryan.thompson@unisys.com, cgroups@vger.kernel.org, 3chas3@gmail.com,
        chrism@mellanox.com, christian.koenig@amd.com, ccaulfie@redhat.com,
        chris@chris-wilson.co.uk, david1.zhou@amd.com,
        cluster-devel@redhat.com, colin.king@canonical.com,
        xiyou.wangcong@gmail.com, cyrille.pitchen@wedev4u.fr,
        daniel@iogearbox.net, daniel.vetter@intel.com,
        dasaratharaman.chandramouli@intel.com, airlied@redhat.com,
        dsa@cumulusnetworks.com, airlied@linux.ie, david.binder@unisys.com,
        dhowells@redhat.com, david.kershner@unisys.com, dtwlin@gmail.com,
        dave@stgolabs.net, davem@davemloft.net, teigland@redhat.com,
        dwindsor@gmail.com, dwmw2@infradead.org, dennis.dalessandro@intel.com,
        devel@driverdev.osuosl.org, devesh.sharma@broadcom.com,
        devicetree@vger.kernel.org, dick.kennedy@broadcom.com,
        dm-devel@redhat.com, don.hiatt@intel.com, dgilbert@interlog.com,
        dledford@redhat.com, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, elena.reshetova@intel.com,
        edumazet@google.com, eparis@parisplace.org, ericvh@gmail.com,
        ebiederm@xmission.com, evan.quan@amd.com, felipe.balbi@linux.intel.com,
        Felix.Kuehling@amd.com, f.fainelli@gmail.com, fw@strlen.de,
        frowand.list@gmail.com, fbarrat@linux.vnet.ibm.com,
        fujita.tomonori@lab.ntt.co.jp, gbhat@marvell.com,
        geliangtang@gmail.com, kraxel@redhat.com, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux@roeck-us.net,
        gustavo.padovan@collabora.co.uk, hal.rosenstock@gmail.com,
        hannes@stressinduktion.org, hare@suse.de, ishkamiel@gmail.com,
        hans.westgaard.ry@oracle.com, ray.huang@amd.com, mingo@redhat.com,
        inki.dae@samsung.com, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        ira.weiny@intel.com, jinpu.wang@profitbricks.com, jhs@mojatatu.com,
        jejb@linux.vnet.ibm.com, james.smart@broadcom.com,
        jani.nikula@linux.intel.com, jack@suse.cz,
        jarkko.sakkinen@linux.intel.com, jarno@ovn.org, Jason@zx2c4.com,
        jgunthorpe@obsidianresearch.com, jasowang@redhat.com,
        javier@osg.samsung.com, bfields@fieldses.org, jlayton@poochiereds.net,
        axboe@kernel.dk, jens.wiklander@linaro.org, jiangyilism@gmail.com,
        jiri@mellanox.com, jiri@resnulli.us, jlbec@evilplan.org,
        joro@8bytes.org, johan@kernel.org, johannes@sipsolutions.net,
        hannes@cmpxchg.org, john@johnmccutchan.com, jonathanh@nvidia.com,
        jon.maloy@ericsson.com, joonas.lahtinen@linux.intel.com,
        jy0922.shim@samsung.com, jbacik@fb.com, Jerry.Zhang@amd.com,
        jsarha@ti.com, Kai.Makisara@kolumbus.fi, kvalo@qca.qualcomm.com,
        keescook@chromium.org, krzk@kernel.org, kgene@kernel.org,
        kvm@vger.kernel.org, kyungmin.park@samsung.com, jiangshanlai@gmail.com,
        lars.ellenberg@linbit.com, lucho@ionkov.net, lee.jones@linaro.org,
        leo.liu@amd.com, leon@kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-ppp@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, logang@deltatee.com, majd@mellanox.com,
        manfred@colorfullife.com, tpmdd@selhorst.net,
        marcos.souza.org@gmail.com, marek.vasut@gmail.com,
        mario.kleiner.de@gmail.com, markb@mellanox.com, mfasheh@versity.com,
        elfring@users.sourceforge.net, martin.petersen@oracle.com,
        matan@mellanox.com, mawilcox@microsoft.com,
        mporter@kernel.crashing.org, mchehab@kernel.org,
        maximlevitsky@gmail.com, mst@redhat.com, mhocko@kernel.org,
        michel.daenzer@amd.com, mike.marciniszyn@intel.com,
        rppt@linux.vnet.ibm.com, snitzer@redhat.com, mszeredi@redhat.com,
        minchan@kernel.org, tom.leiming@gmail.com, monis@mellanox.com,
        Monk.Liu@amd.com, nbd-general@lists.sourceforge.net, neilb@suse.com,
        nhorman@tuxdriver.com, nab@linux-iscsi.org, nicolai.haehnle@amd.com,
        nicolas.dichtel@6wind.com, niranjana.vishwanathapura@intel.com,
        nishants@marvell.com, ngupta@vflare.org, ocfs2-devel@oss.oracle.com,
        ohad@wizery.com, oneukum@suse.com, osandov@fb.com,
        ogerlitz@mellanox.com, pali.rohar@gmail.com,
        pantelis.antoniou@konsulko.com, paulus@samba.org, paul@paul-moore.com,
        peterhuewe@gmx.de, peterz@infradead.org, pmladek@suse.com,
        philipp.reisner@linbit.com, pshelar@ovn.org, rjw@rjwysocki.net,
        richard@nod.at, rlove@rlove.org, robh+dt@kernel.org,
        giometti@enneenne.com, rogerq@ti.com, roman.kapl@sysgo.com,
        rminnich@sandia.gov, rmk+kernel@armlinux.org.uk,
        sainath.grandhi@intel.com, sameer.wadgaonkar@unisys.com,
        sean.hefty@intel.com, seanpaul@chromium.org, bigeasy@linutronix.de,
        sre@kernel.org, nsekhar@ti.com, selvin.xavier@broadcom.com,
        sergey.senozhatsky.work@gmail.com, sw0312.kim@samsung.com,
        p.shailesh@samsung.com, shli@kernel.org, shaun.tancheff@seagate.com,
        syeh@vmware.com, sparmaintainer@unisys.com, stefanr@s5r6.in-berlin.de,
        sboyd@codeaurora.org, stephen@networkplumber.org, swise@chelsio.com,
        sudarsana.kalluru@qlogic.com, sudeep.dutt@intel.com,
        sumit.semwal@linaro.org, target-devel@vger.kernel.org, tj@kernel.org,
        thierry.reding@gmail.com, thellstrom@vmware.com,
        timothy.sell@unisys.com, tipc-discussion@lists.sourceforge.net,
        tomas.winkler@intel.com, tomi.valkeinen@ti.com,
        tpmdd-devel@lists.sourceforge.net, trond.myklebust@primarydata.com,
        v9fs-developer@lists.sourceforge.net, varun@chelsio.com,
        virtualization@lists.linux-foundation.org, vdavydov.dev@gmail.com,
        vyasevich@gmail.com, linux-graphics-maintainer@vmware.com,
        longman@redhat.com, weiyj.lk@gmail.com, wsa@the-dreams.de,
        huxm@marvell.com, ying.xue@windriver.com, yishaih@mellanox.com,
        yuval.shaia@oracle.com, lizefan@huawei.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com
Subject: [patch net-next 2/3] net/sched: Change cls_flower to use IDR
Date: Tue, 15 Aug 2017 22:12:17 -0400
Message-Id: <1502849538-14284-3-git-send-email-chrism@mellanox.com>
In-Reply-To: <1502849538-14284-1-git-send-email-chrism@mellanox.com>
References: <1502849538-14284-1-git-send-email-chrism@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

Currently, all filters with the same priority are linked in a doubly
linked list. Every filter should have a unique handle. To make the
handle unique, we need to iterate the list every time to see if the
handle exists or not when inserting a new filter. It is time-consuming.
For example, it takes about 5m3.169s to insert 64K rules.

This patch changes cls_flower to use IDR. With this patch, it
takes about 0m1.127s to insert 64K rules. The improvement is huge.

But please note that in this testing, all filters share the same action.
If every filter has a unique action, that is another bottleneck.
Follow-up patch in this patchset addresses that.

Signed-off-by: Chris Mi <chrism@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 net/sched/cls_flower.c | 55 +++++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 052e902..071f0ef 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -68,7 +68,6 @@ struct cls_fl_head {
 	struct rhashtable ht;
 	struct fl_flow_mask mask;
 	struct flow_dissector dissector;
-	u32 hgen;
 	bool mask_assigned;
 	struct list_head filters;
 	struct rhashtable_params ht_params;
@@ -76,6 +75,7 @@ struct cls_fl_head {
 		struct work_struct work;
 		struct rcu_head	rcu;
 	};
+	struct idr handle_idr;
 };
 
 struct cls_fl_filter {
@@ -210,6 +210,7 @@ static int fl_init(struct tcf_proto *tp)
 
 	INIT_LIST_HEAD_RCU(&head->filters);
 	rcu_assign_pointer(tp->root, head);
+	idr_init(&head->handle_idr);
 
 	return 0;
 }
@@ -295,6 +296,9 @@ static void fl_hw_update_stats(struct tcf_proto *tp, struct cls_fl_filter *f)
 
 static void __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f)
 {
+	struct cls_fl_head *head = rtnl_dereference(tp->root);
+
+	idr_remove(&head->handle_idr, f->handle);
 	list_del_rcu(&f->list);
 	if (!tc_skip_hw(f->flags))
 		fl_hw_destroy_filter(tp, f);
@@ -327,6 +331,7 @@ static void fl_destroy(struct tcf_proto *tp)
 
 	list_for_each_entry_safe(f, next, &head->filters, list)
 		__fl_delete(tp, f);
+	idr_destroy(&head->handle_idr);
 
 	__module_get(THIS_MODULE);
 	call_rcu(&head->rcu, fl_destroy_rcu);
@@ -335,12 +340,8 @@ static void fl_destroy(struct tcf_proto *tp)
 static void *fl_get(struct tcf_proto *tp, u32 handle)
 {
 	struct cls_fl_head *head = rtnl_dereference(tp->root);
-	struct cls_fl_filter *f;
 
-	list_for_each_entry(f, &head->filters, list)
-		if (f->handle == handle)
-			return f;
-	return NULL;
+	return idr_find(&head->handle_idr, handle);
 }
 
 static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
@@ -859,27 +860,6 @@ static int fl_set_parms(struct net *net, struct tcf_proto *tp,
 	return 0;
 }
 
-static u32 fl_grab_new_handle(struct tcf_proto *tp,
-			      struct cls_fl_head *head)
-{
-	unsigned int i = 0x80000000;
-	u32 handle;
-
-	do {
-		if (++head->hgen == 0x7FFFFFFF)
-			head->hgen = 1;
-	} while (--i > 0 && fl_get(tp, head->hgen));
-
-	if (unlikely(i == 0)) {
-		pr_err("Insufficient number of handles\n");
-		handle = 0;
-	} else {
-		handle = head->hgen;
-	}
-
-	return handle;
-}
-
 static int fl_change(struct net *net, struct sk_buff *in_skb,
 		     struct tcf_proto *tp, unsigned long base,
 		     u32 handle, struct nlattr **tca,
@@ -890,6 +870,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	struct cls_fl_filter *fnew;
 	struct nlattr **tb;
 	struct fl_flow_mask mask = {};
+	unsigned long idr_index;
 	int err;
 
 	if (!tca[TCA_OPTIONS])
@@ -920,13 +901,21 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		goto errout;
 
 	if (!handle) {
-		handle = fl_grab_new_handle(tp, head);
-		if (!handle) {
-			err = -EINVAL;
+		err = idr_alloc(&head->handle_idr, fnew, &idr_index,
+				1, 0x80000000, GFP_KERNEL);
+		if (err)
 			goto errout;
-		}
+		fnew->handle = idr_index;
+	}
+
+	/* user specifies a handle and it doesn't exist */
+	if (handle && !fold) {
+		err = idr_alloc(&head->handle_idr, fnew, &idr_index,
+				handle, handle + 1, GFP_KERNEL);
+		if (err)
+			goto errout;
+		fnew->handle = idr_index;
 	}
-	fnew->handle = handle;
 
 	if (tb[TCA_FLOWER_FLAGS]) {
 		fnew->flags = nla_get_u32(tb[TCA_FLOWER_FLAGS]);
@@ -980,6 +969,8 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	*arg = fnew;
 
 	if (fold) {
+		fnew->handle = handle;
+		idr_replace(&head->handle_idr, fnew, fnew->handle);
 		list_replace_rcu(&fold->list, &fnew->list);
 		tcf_unbind_filter(tp, &fold->res);
 		call_rcu(&fold->rcu, fl_destroy_filter);
-- 
1.8.3.1
