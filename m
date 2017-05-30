Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28603 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbdE3Rr7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2017 13:47:59 -0400
Date: Tue, 30 May 2017 13:55:49 -0400
From: Keith Busch <keith.busch@intel.com>
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-block@vger.kernel.org
Subject: Re: WARNING triggers at blk_mq_update_nr_hw_queues during
 nvme_reset_work
Message-ID: <20170530175549.GC2845@localhost.localdomain>
References: <8760giqnyb.fsf@dilma.collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760giqnyb.fsf@dilma.collabora.co.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 30, 2017 at 02:00:44PM -0300, Gabriel Krisman Bertazi wrote:
> Since the merge window for 4.12, one of the machines in Intel's CI
> started to hit the WARN_ON below at blk_mq_update_nr_hw_queues during an
> nvme_reset_work.  The issue persists with the latest 4.12-rc3, and full
> dmesg from boot, up to the moment where the WARN_ON triggers is
> available at the following link:
> 
> https://intel-gfx-ci.01.org/CI/CI_DRM_2672/fi-kbl-7500u/igt@kms_pipe_crc_basic@suspend-read-crc-pipe-a.html
> 
> Please notice that the test we do in the CI involves putting the
> machine to sleep (PM), and the issue triggers when resuming execution.
> 
> I have not been able to get my hands on the machine yet to do an actual
> bisect, but I'm wondering if you guys might have an idea of what is
> wrong.
> 
> Any help is appreciated :)

Hi Gabriel,

This appears to be new behavior in blk-mq's tag set update with commit
705cda97e. This is asserting a lock is held, but none of the drivers
that call the export are take that lock.

I think the below should fix it (CC'ing block list and developers).

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f2224ffd..1bccced 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2641,7 +2641,8 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
-void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
+							int nr_hw_queues)
 {
 	struct request_queue *q;
 
@@ -2665,6 +2666,13 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
 }
+
+void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
+{
+	mutex_lock(&set->tag_list_lock);
+	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
+	mutex_unlock(&set->tag_list_lock);
+}
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
 /* Enable polling stats and return whether they were already enabled. */
--


> [  382.419309] ------------[ cut here ]------------
> [  382.419314] WARNING: CPU: 3 PID: 3098 at block/blk-mq.c:2648 blk_mq_update_nr_hw_queues+0x118/0x120
> [  382.419315] Modules linked in: vgem snd_hda_codec_hdmi
> snd_hda_codec_realtek snd_hda_codec_generic i915 x86_pkg_temp_thermal
> intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core
> snd_pcm e1000e mei_me mei ptp pps_core prime_numbers
> pinctrl_sunrisepoint
> pinctrl_intel i2c_hid
> [  382.419345] CPU: 3 PID: 3098 Comm: kworker/u8:5 Tainted: G     U  W  4.12.0-rc3-CI-CI_DRM_2672+ #1
> [  382.419346] Hardware name: GIGABYTE GB-BKi7(H)A-7500/MFLP7AP-00, BIOSF4 02/20/2017
> [  382.419349] Workqueue: nvme nvme_reset_work
> [  382.419351] task: ffff88025e2f4f40 task.stack: ffffc90000464000
> [  382.419353] RIP: 0010:blk_mq_update_nr_hw_queues+0x118/0x120
> [  382.419355] RSP: 0000:ffffc90000467d50 EFLAGS: 00010246
> [  382.419357] RAX: 0000000000000000 RBX: 0000000000000004 RCX:0000000000000001
> [  382.419358] RDX: 0000000000000000 RSI: 00000000ffffffff RDI:ffff8802618d80b0
> [  382.419359] RBP: ffffc90000467d70 R08: ffff88025e2f5778 R09:0000000000000000
> [  382.419361] R10: 00000000ef6f2e9b R11: 0000000000000001 R12:ffff8802618d8368
> [  382.419362] R13: ffff8802618d8010 R14: ffff8802618d81f0 R15:0000000000000000
> [  382.419363] FS:  0000000000000000(0000) GS:ffff88026dd80000(0000) knlGS:0000000000000000
> [  382.419364] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  382.419366] CR2: 0000000000000000 CR3: 000000025a06e000 CR4: 00000000003406e0
> [  382.419367] Call Trace:
> [  382.419370]  nvme_reset_work+0x948/0xff0
> [  382.419374]  ? lock_acquire+0xb5/0x210
> [  382.419379]  process_one_work+0x1fe/0x670
> [  382.419390]  ? kthread_create_on_node+0x40/0x40
> [  382.419394]  ret_from_fork+0x27/0x40
> [  382.419398] Code: 48 8d 98 58 f6 ff ff 75 e5 5b 41 5c 41 5d 41 5e 5d
> c3 48 8d bf a0 00 00 00 be ff ff ff ff e8 c0 48 ca ff 85 c0 0f 85 06 ff
> ff ff <0f> ff e9 ff fe ff ff 90 55 31 f6 48 c7 c7 80 b2 ea 81 48 89 e5
> [  382.419463] ---[ end trace 603ee21a3184ac90 ]---
