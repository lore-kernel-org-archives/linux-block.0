Return-Path: <axboe@kernel.dk>
Subject: Re: WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527
 nvme_setup_cmd+0x3d3
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <45f93661-da0d-94c5-1740-85242df8776e@kernel.dk>
 <0872b361-157b-a876-20af-3d7a4ee7ff31@kernel.dk>
 <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0b7686b3-f716-49ba-c7c4-929d84905569@kernel.dk>
Date: Wed, 31 Jan 2018 08:29:37 -0700
MIME-Version: 1.0
In-Reply-To: <8fd916ab-42d7-c654-5a01-8f1eb4be730e@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/30/18 9:25 PM, jianchao.wang wrote:
> Hi Jens
> 
> On 01/30/2018 11:57 PM, Jens Axboe wrote:
>> On 1/30/18 8:41 AM, Jens Axboe wrote:
>>> Hi,
>>>
>>> I just hit this on 4.15+ on the laptop, it's running Linus' git
>>> as of yesterday, right after the block tree merge:
>>>
>>> commit 0a4b6e2f80aad46fb55a5cf7b1664c0aef030ee0
>>> Merge: 9697e9da8429 796baeeef85a
>>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>>> Date:   Mon Jan 29 11:51:49 2018 -0800
>>>
>>>     Merge branch 'for-4.16/block' of git://git.kernel.dk/linux-block
>>>
>>> It's hitting this case:
>>>
>>>         if (WARN_ON_ONCE(n != segments)) {                                      
>>>
>>> in nvme, indicating that rq->nr_phys_segments does not equal the
>>> number of bios in the request. Anyone seen this? I'll take a closer
>>> look as time permits, full trace below.
>>>
>>>
>>>  WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527 nvme_setup_cmd+0x3d3/0x430
>>>  Modules linked in: rfcomm fuse ctr ccm bnep arc4 binfmt_misc snd_hda_codec_hdmi nls_iso8859_1 nls_cp437 vfat snd_hda_codec_conexant fat snd_hda_codec_generic iwlmvm snd_hda_intel snd_hda_codec snd_hwdep mac80211 snd_hda_core snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq x86_pkg_temp_thermal intel_powerclamp kvm_intel uvcvideo iwlwifi btusb snd_seq_device videobuf2_vmalloc btintel videobuf2_memops kvm snd_timer videobuf2_v4l2 bluetooth irqbypass videobuf2_core aesni_intel aes_x86_64 crypto_simd cryptd snd glue_helper videodev cfg80211 ecdh_generic soundcore hid_generic usbhid hid i915 psmouse e1000e ptp pps_core xhci_pci xhci_hcd intel_gtt
>>>  CPU: 2 PID: 207 Comm: jbd2/nvme0n1p7- Tainted: G     U           4.15.0+ #176
>>>  Hardware name: LENOVO 20FBCTO1WW/20FBCTO1WW, BIOS N1FET59W (1.33 ) 12/19/2017
>>>  RIP: 0010:nvme_setup_cmd+0x3d3/0x430
>>>  RSP: 0018:ffff880423e9f838 EFLAGS: 00010217
>>>  RAX: 0000000000000000 RBX: ffff880423e9f8c8 RCX: 0000000000010000
>>>  RDX: ffff88022b200010 RSI: 0000000000000002 RDI: 00000000327f0000
>>>  RBP: ffff880421251400 R08: ffff88022b200000 R09: 0000000000000009
>>>  R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000ffff
>>>  R13: ffff88042341e280 R14: 000000000000ffff R15: ffff880421251440
>>>  FS:  0000000000000000(0000) GS:ffff880441500000(0000) knlGS:0000000000000000
>>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>  CR2: 000055b684795030 CR3: 0000000002e09006 CR4: 00000000001606e0
>>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>  Call Trace:
>>>   nvme_queue_rq+0x40/0xa00
>>>   ? __sbitmap_queue_get+0x24/0x90
>>>   ? blk_mq_get_tag+0xa3/0x250
>>>   ? wait_woken+0x80/0x80
>>>   ? blk_mq_get_driver_tag+0x97/0xf0
>>>   blk_mq_dispatch_rq_list+0x7b/0x4a0
>>>   ? deadline_remove_request+0x49/0xb0
>>>   blk_mq_do_dispatch_sched+0x4f/0xc0
>>>   blk_mq_sched_dispatch_requests+0x106/0x170
>>>   __blk_mq_run_hw_queue+0x53/0xa0
>>>   __blk_mq_delay_run_hw_queue+0x83/0xa0
>>>   blk_mq_run_hw_queue+0x6c/0xd0
>>>   blk_mq_sched_insert_request+0x96/0x140
>>>   __blk_mq_try_issue_directly+0x3d/0x190
>>>   blk_mq_try_issue_directly+0x30/0x70
>>>   blk_mq_make_request+0x1a4/0x6a0
>>>   generic_make_request+0xfd/0x2f0
>>>   ? submit_bio+0x5c/0x110
>>>   submit_bio+0x5c/0x110
>>>   ? __blkdev_issue_discard+0x152/0x200
>>>   submit_bio_wait+0x43/0x60
>>>   ext4_process_freed_data+0x1cd/0x440
>>>   ? account_page_dirtied+0xe2/0x1a0
>>>   ext4_journal_commit_callback+0x4a/0xc0
>>>   jbd2_journal_commit_transaction+0x17e2/0x19e0
>>>   ? kjournald2+0xb0/0x250
>>>   kjournald2+0xb0/0x250
>>>   ? wait_woken+0x80/0x80
>>>   ? commit_timeout+0x10/0x10
>>>   kthread+0x111/0x130
>>>   ? kthread_create_worker_on_cpu+0x50/0x50
>>>   ? do_group_exit+0x3a/0xa0
>>>   ret_from_fork+0x1f/0x30
>>>  Code: 73 89 c1 83 ce 10 c1 e1 10 09 ca 83 f8 04 0f 87 0f ff ff ff 8b 4d 20 48 8b 7d 00 c1 e9 09 48 01 8c c7 00 08 00 00 e9 f8 fe ff ff <0f> ff 4c 89 c7 41 bc 0a 00 00 00 e8 0d 78 d6 ff e9 a1 fc ff ff 
>>>  ---[ end trace 50d361cc444506c8 ]---
>>>  print_req_error: I/O error, dev nvme0n1, sector 847167488
>>
>> Looking at the disassembly, 'n' is 2 and 'segments' is 0xffff.
>>
> 
> Let's consider the case following:
> 
> blk_mq_bio_to_request()
>   -> blk_init_request_from_bio()
>     -> blk_rq_bio_prep()
>     ----
>     if (bio_has_data(bio))
>         rq->nr_phys_segments = bio_phys_segments(q, bio);
>     ----
> static inline bool bio_has_data(struct bio *bio)
> {
>     if (bio &&
>         bio->bi_iter.bi_size &&
>         bio_op(bio) != REQ_OP_DISCARD &&   //-----> HERE !
>         bio_op(bio) != REQ_OP_SECURE_ERASE &&
>         bio_op(bio) != REQ_OP_WRITE_ZEROES)
>         return true;
> 
>     return false;
> }
> For the DISCARD req, the nr_phys_segments is 0.
> 
> dd_insert_request()
>   -> blk_mq_sched_try_insert_merge()
>     -> elv_attempt_insert_merge()
>       -> blk_attempt_req_merge()
>         -> attempt_merge()
>           -> ll_merge_requests_fn()
> ----
>     total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
>     // total_phys_segments will be 0
>     if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
>         if (req->nr_phys_segments == 1)
>             req->bio->bi_seg_front_size = seg_size;
>         if (next->nr_phys_segments == 1)
>             next->biotail->bi_seg_back_size = seg_size;
>         // total_phys_segments is int, it will be -1;
>         total_phys_segments--;
>     }
> 
>     //total_phys_segments is -1, so it is false here
>     if (total_phys_segments > queue_max_segments(q))
>         return 0;
> 
>     if (blk_integrity_merge_rq(q, req, next) == false)
>         return 0;
> 
>     /* Merge is OK... */
>     // -1 is set to req->nr_phys_segments which is a unsigned short
>     // finally, we get a 0xffff
>     req->nr_phys_segments = total_phys_segments;

That's a great analysis, and it looks correct. The problem is that
blk_phys_contig_segment() pretends that the segments are contig
if none of them have data, which is correct from the point of view
of not needing a new segment to be mergeable. But it fails pretty
miserably for this case.

How about something like the below?


diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8452fc7164cc..cee102fb060e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -574,8 +574,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		return 0;
 
+	/*
+	 * For DISCARDs, the segment count isn't interesting since
+	 * the requests have no data attached.
+	 */
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
-	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
+	if (total_phys_segments &&
+	    blk_phys_contig_segment(q, req->biotail, next->bio)) {
 		if (req->nr_phys_segments == 1)
 			req->bio->bi_seg_front_size = seg_size;
 		if (next->nr_phys_segments == 1)

-- 
Jens Axboe
