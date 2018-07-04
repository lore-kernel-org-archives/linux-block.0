Return-Path: <kashyap.desai@broadcom.com>
MIME-Version: 1.0
From: Kashyap Desai <kashyap.desai@broadcom.com>
Date: Wed, 4 Jul 2018 13:29:50 +0530
Message-ID: <CAHsXFKHdhOE_USCASpiRd6dHzcNvo29ipeJ2LhVbEsxnyMow1A@mail.gmail.com>
Subject: [RFC] bypass scheduler for no sched is set
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000b90ba7057027d0ea"
List-ID: <linux-block@vger.kernel.org>

--000000000000b90ba7057027d0ea
Content-Type: text/plain; charset="UTF-8"

Hi,

Ming Lei posted below patch series and performance improved for
megaraid_sas driver. I used the same kernel base and figure out some more
possible performance improvement in block layer. This RFC improves
performance as well as CPU utilization. If this patch fits the design
aspect of the blk-mq and scsi-mq, I can convert it into PATCH and submit
the same/modified version.

https://marc.info/?l=linux-block&m=153062994403732&w=2

Description of change -

Do not insert request into software queue if BLK_MQ_F_NO_SCHED is set.
Submit request from blk_mq_make_request to low level driver directly as
depicted through below function call.

blk_mq_try_issue_directly


__blk_mq_try_issue_directly

                 scsi_queue_rq

Low level driver attached to scsi.mq can set BLK_MQ_F_NO_SCHED,  If they do
not want benefit from io scheduler (e.a in case of SSDs connected to IT/MR
controller). In case of HDD drives connected to HBA, driver can avoid
setting BLK_MQ_F_NO_SCHED so that default elevator is set to mq-deadline.

Setup and performance number detail listed below -

I have created one R0 VD consist of 8 SSD on MegarRaid adapter.

Without RFC - IOPS goes 840K and CPU utilization goes upto 11%. Below is
perf top output

   5.17%  [kernel]                 [k] _raw_spin_lock
   4.62%  [kernel]                 [k] try_to_grab_pending
   2.29%  [kernel]                 [k] syscall_return_via_sysret
   1.37%  [kernel]                 [k] blk_mq_flush_busy_ctxs
   1.29%  [kernel]                 [k] kobject_get
   1.27%  fio                      [.] axmap_isset
   1.25%  [kernel]                 [k] flush_busy_ctx
   1.20%  [kernel]                 [k] scsi_dispatch_cmd
   1.18%  [kernel]                 [k] blk_mq_get_request
   1.16%  [kernel]                 [k] blk_mq_hctx_mark_pending.isra.45
   1.09%  [kernel]                 [k] irq_entries_start
   0.94%  [kernel]                 [k] del_timer
   0.91%  [kernel]                 [k] scsi_softirq_done
   0.90%  [kernel]                 [k] sbitmap_any_bit_set
   0.83%  [kernel]                 [k] blk_mq_free_request
   0.82%  [kernel]                 [k] kobject_put
   0.81%  [sd_mod]                 [k] sd_setup_read_write_cmnd
   0.80%  [kernel]                 [k] scsi_mq_get_budget
   0.79%  [kernel]                 [k] blk_mq_get_tag
   0.70%  [kernel]                 [k] blk_mq_dispatch_rq_list
   0.61%  [kernel]                 [k] bt_iter
   0.60%  fio                      [.] __fio_gettime
   0.59%  [kernel]                 [k] blk_mq_complete_request
   0.59%  [kernel]                 [k] gup_pgd_range
   0.57%  [kernel]                 [k] scsi_queue_rq


After applying RFC - IOPS goes 1066K and CPU utilization goes up to 6%.

   2.56%  [kernel]             [k] syscall_return_via_sysret
   2.46%  [kernel]             [k] irq_entries_start
   2.43%  [kernel]             [k] kobject_get
   2.40%  [kernel]             [k] bt_iter
   2.16%  fio                  [.] axmap_isset
   2.06%  [kernel]             [k] _raw_spin_lock
   1.76%  [kernel]             [k] __audit_syscall_exit
   1.51%  [kernel]             [k] scsi_dispatch_cmd
   1.49%  [kernel]             [k] blk_mq_free_request
   1.49%  [sd_mod]             [k] sd_setup_read_write_cmnd
   1.45%  [kernel]             [k] scsi_softirq_done
   1.32%  [kernel]             [k] switch_mm_irqs_off
   1.28%  [kernel]             [k] scsi_mq_get_budget
   1.22%  [kernel]             [k] blk_mq_check_inflight
   1.13%  [kernel]             [k] kobject_put
   1.11%  fio                  [.] __fio_gettime
   0.95%  [kernel]             [k] gup_pgd_range
   0.90%  [kernel]             [k] blk_mq_get_tag
   0.88%  [kernel]             [k] read_tsc
   0.85%  [kernel]             [k] scsi_end_request
   0.85%  fio                  [.] get_io_u
   0.84%  [kernel]             [k] lookup_ioctx
   0.81%  [kernel]             [k] blk_mq_complete_request
   0.80%  [kernel]             [k] blk_mq_get_request

Signed-off-by: Kashyap Desai < kashyap.desai@broadcom.com>
---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4d1c048..ab27788 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1811,32 +1811,35 @@ static blk_qc_t blk_mq_make_request(struct
request_queue *q, struct bio *bio)
         blk_insert_flush(rq);
         blk_mq_run_hw_queue(data.hctx, true);
     } else if (plug && q->nr_hw_queues == 1) {
-        struct request *last = NULL;
-
         blk_mq_put_ctx(data.ctx);
         blk_mq_bio_to_request(rq, bio);
+        /* bypass scheduler for no sched flag set */
+        if (q->tag_set->flags & BLK_MQ_F_NO_SCHED)
+            blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+        else {
+            struct request *last = NULL;
+            /*
+             * @request_count may become stale because of schedule
+             * out, so check the list again.
+             */
+            if (list_empty(&plug->mq_list))
+                request_count = 0;
+            else if (blk_queue_nomerges(q))
+                request_count = blk_plug_queued_count(q);
+
+            if (!request_count)
+                trace_block_plug(q);
+            else
+                last = list_entry_rq(plug->mq_list.prev);
+
+            if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
+                blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
+                blk_flush_plug_list(plug, false);
+                trace_block_plug(q);
+            }

-        /*
-         * @request_count may become stale because of schedule
-         * out, so check the list again.
-         */
-        if (list_empty(&plug->mq_list))
-            request_count = 0;
-        else if (blk_queue_nomerges(q))
-            request_count = blk_plug_queued_count(q);
-
-        if (!request_count)
-            trace_block_plug(q);
-        else
-            last = list_entry_rq(plug->mq_list.prev);
-
-        if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
-            blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
-            blk_flush_plug_list(plug, false);
-            trace_block_plug(q);
+            list_add_tail(&rq->queuelist, &plug->mq_list);
         }
-
-        list_add_tail(&rq->queuelist, &plug->mq_list);
     } else if (plug && !blk_queue_nomerges(q)) {
         blk_mq_bio_to_request(rq, bio);

--000000000000b90ba7057027d0ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGksPGJyPjxicj5NaW5nIExlaSBwb3N0ZWQgYmVsb3cgcGF0Y2ggc2Vy
aWVzIGFuZCBwZXJmb3JtYW5jZSBpbXByb3ZlZCBmb3IgbWVnYXJhaWRfc2FzIGRyaXZlci4gSSB1
c2VkIHRoZSBzYW1lIGtlcm5lbCBiYXNlIGFuZCBmaWd1cmUgb3V0IHNvbWUgbW9yZSBwb3NzaWJs
ZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBpbiBibG9jayBsYXllci4gVGhpcyBSRkMgaW1wcm92
ZXMgcGVyZm9ybWFuY2UgYXMgd2VsbCBhcyBDUFUgdXRpbGl6YXRpb24uIElmIHRoaXMgcGF0Y2gg
Zml0cyB0aGUgZGVzaWduIGFzcGVjdCBvZiB0aGUgYmxrLW1xIGFuZCBzY3NpLW1xLCBJIGNhbiBj
b252ZXJ0IGl0IGludG8gUEFUQ0ggYW5kIHN1Ym1pdCB0aGUgc2FtZS9tb2RpZmllZCB2ZXJzaW9u
Ljxicj48YnI+PGRpdj48YSBocmVmPSJodHRwczovL21hcmMuaW5mby8/bD1saW51eC1ibG9jayZh
bXA7bT0xNTMwNjI5OTQ0MDM3MzImYW1wO3c9MiI+aHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgt
YmxvY2smYW1wO209MTUzMDYyOTk0NDAzNzMyJmFtcDt3PTI8L2E+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5EZXNjcmlwdGlvbiBvZiBjaGFuZ2UgLTwvZGl2PjxkaXY+PGJyPjwvZGl2PkRvIG5v
dCBpbnNlcnQgcmVxdWVzdCBpbnRvIHNvZnR3YXJlIHF1ZXVlIGlmIEJMS19NUV9GX05PX1NDSEVE
IGlzIHNldC4gU3VibWl0IHJlcXVlc3QgZnJvbSBibGtfbXFfbWFrZV9yZXF1ZXN0IHRvIGxvdyBs
ZXZlbCBkcml2ZXIgZGlyZWN0bHkgYXMgZGVwaWN0ZWQgdGhyb3VnaCBiZWxvdyBmdW5jdGlvbiBj
YWxsLjxicj48YnI+YmxrX21xX3RyeV9pc3N1ZV9kaXJlY3RsecKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPGJyPsKgwqDCoMKgwqAgX19ibGtfbXFf
dHJ5X2lzc3VlX2RpcmVjdGx5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDxicj7CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzY3NpX3F1ZXVlX3JxPGJyPjxicj5Mb3cgbGV2ZWwgZHJpdmVyIGF0
dGFjaGVkIHRvIDxhIGhyZWY9Imh0dHA6Ly9zY3NpLm1xIj5zY3NpLm1xPC9hPiBjYW4gc2V0IEJM
S19NUV9GX05PX1NDSEVELMKgIElmIHRoZXkgZG8gbm90IHdhbnQgYmVuZWZpdCBmcm9tIGlvIHNj
aGVkdWxlciAoZS5hIGluIGNhc2Ugb2YgU1NEcyBjb25uZWN0ZWQgdG8gSVQvTVIgY29udHJvbGxl
cikuIEluIGNhc2Ugb2YgSEREIGRyaXZlcyBjb25uZWN0ZWQgdG8gSEJBLCBkcml2ZXIgY2FuIGF2
b2lkIHNldHRpbmcgQkxLX01RX0ZfTk9fU0NIRUQgc28gdGhhdCBkZWZhdWx0IGVsZXZhdG9yIGlz
IHNldCB0byBtcS1kZWFkbGluZS48YnI+PGJyPjxkaXY+U2V0dXAgYW5kIHBlcmZvcm1hbmNlIG51
bWJlciBkZXRhaWwgbGlzdGVkIGJlbG93IC08L2Rpdj48ZGl2Pjxicj48L2Rpdj5JIGhhdmUgY3Jl
YXRlZCBvbmUgUjAgVkQgY29uc2lzdCBvZiA4IFNTRCBvbiBNZWdhclJhaWQgYWRhcHRlci48YnI+
PGJyPldpdGhvdXQgUkZDIC0gSU9QUyBnb2VzIDg0MEsgYW5kIENQVSB1dGlsaXphdGlvbiBnb2Vz
IHVwdG8gMTElLiBCZWxvdyBpcyBwZXJmIHRvcCBvdXRwdXQ8YnI+PGJyPsKgwqAgNS4xNyXCoCBb
a2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBfcmF3X3NwaW5fbG9j
azxicj7CoMKgIDQuNjIlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBba10gdHJ5X3RvX2dyYWJfcGVuZGluZzxicj7CoMKgIDIuMjklwqAgW2tlcm5lbF3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gc3lzY2FsbF9yZXR1cm5fdmlhX3N5c3JldDxi
cj7CoMKgIDEuMzclwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBb
a10gYmxrX21xX2ZsdXNoX2J1c3lfY3R4czxicj7CoMKgIDEuMjklwqAgW2tlcm5lbF3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10ga29iamVjdF9nZXQ8YnI+wqDCoCAxLjI3JcKg
IGZpb8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBbLl0gYXhtYXBf
aXNzZXQ8YnI+wqDCoCAxLjI1JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgW2tdIGZsdXNoX2J1c3lfY3R4PGJyPsKgwqAgMS4yMCXCoCBba2VybmVsXcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBzY3NpX2Rpc3BhdGNoX2NtZDxicj7CoMKgIDEu
MTglwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gYmxrX21x
X2dldF9yZXF1ZXN0PGJyPsKgwqAgMS4xNiXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFtrXSBibGtfbXFfaGN0eF9tYXJrX3BlbmRpbmcuaXNyYS40NTxicj7CoMKg
IDEuMDklwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gaXJx
X2VudHJpZXNfc3RhcnQ8YnI+wqDCoCAwLjk0JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgW2tdIGRlbF90aW1lcjxicj7CoMKgIDAuOTElwqAgW2tlcm5lbF3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gc2NzaV9zb2Z0aXJxX2RvbmU8YnI+wqDC
oCAwLjkwJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIHNi
aXRtYXBfYW55X2JpdF9zZXQ8YnI+wqDCoCAwLjgzJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgW2tdIGJsa19tcV9mcmVlX3JlcXVlc3Q8YnI+wqDCoCAwLjgyJcKg
IFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGtvYmplY3RfcHV0
PGJyPsKgwqAgMC44MSXCoCBbc2RfbW9kXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFtrXSBzZF9zZXR1cF9yZWFkX3dyaXRlX2NtbmQ8YnI+wqDCoCAwLjgwJcKgIFtrZXJuZWxdwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIHNjc2lfbXFfZ2V0X2J1ZGdldDxicj7C
oMKgIDAuNzklwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10g
YmxrX21xX2dldF90YWc8YnI+wqDCoCAwLjcwJcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgW2tdIGJsa19tcV9kaXNwYXRjaF9ycV9saXN0PGJyPsKgwqAgMC42MSXC
oCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBidF9pdGVyPGJy
PsKgwqAgMC42MCXCoCBmaW/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgWy5dIF9fZmlvX2dldHRpbWU8YnI+wqDCoCAwLjU5JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0PGJyPsKgwqAg
MC41OSXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBndXBf
cGdkX3JhbmdlPGJyPsKgwqAgMC41NyXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFtrXSBzY3NpX3F1ZXVlX3JxPGJyPjxicj48YnI+QWZ0ZXIgYXBwbHlpbmcgUkZD
IC0gSU9QUyBnb2VzIDEwNjZLIGFuZCBDUFUgdXRpbGl6YXRpb24gZ29lcyB1cCB0byA2JS48YnI+
PGJyPsKgwqAgMi41NiXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gc3lz
Y2FsbF9yZXR1cm5fdmlhX3N5c3JldDxicj7CoMKgIDIuNDYlwqAgW2tlcm5lbF3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgW2tdIGlycV9lbnRyaWVzX3N0YXJ0PGJyPsKgwqAgMi40MyXCoCBba2Vy
bmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10ga29iamVjdF9nZXQ8YnI+wqDCoCAyLjQw
JcKgIFtrZXJuZWxdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBidF9pdGVyPGJyPsKgwqAg
Mi4xNiXCoCBmaW/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFsuXSBheG1hcF9p
c3NldDxicj7CoMKgIDIuMDYlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2td
IF9yYXdfc3Bpbl9sb2NrPGJyPsKgwqAgMS43NiXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBba10gX19hdWRpdF9zeXNjYWxsX2V4aXQ8YnI+wqDCoCAxLjUxJcKgIFtrZXJuZWxd
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBzY3NpX2Rpc3BhdGNoX2NtZDxicj7CoMKgIDEu
NDklwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGJsa19tcV9mcmVlX3Jl
cXVlc3Q8YnI+wqDCoCAxLjQ5JcKgIFtzZF9tb2RdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFtr
XSBzZF9zZXR1cF9yZWFkX3dyaXRlX2NtbmQ8YnI+wqDCoCAxLjQ1JcKgIFtrZXJuZWxdwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFtrXSBzY3NpX3NvZnRpcnFfZG9uZTxicj7CoMKgIDEuMzIlwqAg
W2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIHN3aXRjaF9tbV9pcnFzX29mZjxi
cj7CoMKgIDEuMjglwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIHNjc2lf
bXFfZ2V0X2J1ZGdldDxicj7CoMKgIDEuMjIlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgW2tdIGJsa19tcV9jaGVja19pbmZsaWdodDxicj7CoMKgIDEuMTMlwqAgW2tlcm5lbF3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGtvYmplY3RfcHV0PGJyPsKgwqAgMS4xMSXCoCBm
aW/CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFsuXSBfX2Zpb19nZXR0aW1lPGJy
PsKgwqAgMC45NSXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBba10gZ3VwX3Bn
ZF9yYW5nZTxicj7CoMKgIDAuOTAlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
W2tdIGJsa19tcV9nZXRfdGFnPGJyPsKgwqAgMC44OCXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBba10gcmVhZF90c2M8YnI+wqDCoCAwLjg1JcKgIFtrZXJuZWxdwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFtrXSBzY3NpX2VuZF9yZXF1ZXN0PGJyPsKgwqAgMC44NSXCoCBmaW/C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFsuXSBnZXRfaW9fdTxicj7CoMKgIDAu
ODQlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGxvb2t1cF9pb2N0eDxi
cj7CoMKgIDAuODElwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgW2tdIGJsa19t
cV9jb21wbGV0ZV9yZXF1ZXN0PGJyPsKgwqAgMC44MCXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBba10gYmxrX21xX2dldF9yZXF1ZXN0PGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBL
YXNoeWFwIERlc2FpICZsdDsgPGEgaHJlZj0ibWFpbHRvOmthc2h5YXAuZGVzYWlAYnJvYWRjb20u
Y29tIj5rYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTwvYT4mZ3Q7PGJyPi0tLTxicj48YnI+ZGlm
ZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxrLW1xLmM8YnI+aW5kZXggNGQxYzA0
OC4uYWIyNzc4OCAxMDA2NDQ8YnI+LS0tIGEvYmxvY2svYmxrLW1xLmM8YnI+KysrIGIvYmxvY2sv
YmxrLW1xLmM8YnI+QEAgLTE4MTEsMzIgKzE4MTEsMzUgQEAgc3RhdGljIGJsa19xY190IGJsa19t
cV9tYWtlX3JlcXVlc3Qoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsIHN0cnVjdCBiaW8gKmJpbyk8
YnI+wqDCoMKgwqDCoMKgwqDCoCBibGtfaW5zZXJ0X2ZsdXNoKHJxKTs8YnI+wqDCoMKgwqDCoMKg
wqDCoCBibGtfbXFfcnVuX2h3X3F1ZXVlKGRhdGEuaGN0eCwgdHJ1ZSk7PGJyPsKgwqDCoMKgIH0g
ZWxzZSBpZiAocGx1ZyAmYW1wOyZhbXA7IHEtJmd0O25yX2h3X3F1ZXVlcyA9PSAxKSB7PGJyPi3C
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcmVxdWVzdCAqbGFzdCA9IE5VTEw7PGJyPi08YnI+wqDCoMKg
wqDCoMKgwqDCoCBibGtfbXFfcHV0X2N0eChkYXRhLmN0eCk7PGJyPsKgwqDCoMKgwqDCoMKgwqAg
YmxrX21xX2Jpb190b19yZXF1ZXN0KHJxLCBiaW8pOzxicj4rwqDCoMKgwqDCoMKgwqAgLyogYnlw
YXNzIHNjaGVkdWxlciBmb3Igbm8gc2NoZWQgZmxhZyBzZXQgKi88YnI+K8KgwqDCoMKgwqDCoMKg
IGlmIChxLSZndDt0YWdfc2V0LSZndDtmbGFncyAmYW1wOyBCTEtfTVFfRl9OT19TQ0hFRCk8YnI+
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX21xX3RyeV9pc3N1ZV9kaXJlY3RseShkYXRhLmhj
dHgsIHJxLCAmYW1wO2Nvb2tpZSk7PGJyPivCoMKgwqDCoMKgwqDCoCBlbHNlIHs8YnI+K8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJlcXVlc3QgKmxhc3QgPSBOVUxMOzxicj4rwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKjxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQHJlcXVl
c3RfY291bnQgbWF5IGJlY29tZSBzdGFsZSBiZWNhdXNlIG9mIHNjaGVkdWxlPGJyPivCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBvdXQsIHNvIGNoZWNrIHRoZSBsaXN0IGFnYWluLjxicj4rwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICovPGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChs
aXN0X2VtcHR5KCZhbXA7cGx1Zy0mZ3Q7bXFfbGlzdCkpPGJyPivCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmVxdWVzdF9jb3VudCA9IDA7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVsc2UgaWYgKGJsa19xdWV1ZV9ub21lcmdlcyhxKSk8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXF1ZXN0X2NvdW50ID0gYmxrX3BsdWdfcXVldWVkX2NvdW50KHEpOzxicj4r
PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghcmVxdWVzdF9jb3VudCk8YnI+K8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cmFjZV9ibG9ja19wbHVnKHEpOzxicj4rwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbHNlPGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bGFzdCA9IGxpc3RfZW50cnlfcnEocGx1Zy0mZ3Q7bXFfbGlzdC5wcmV2KTs8YnI+Kzxicj4rwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmVxdWVzdF9jb3VudCAmZ3Q7PSBCTEtfTUFYX1JFUVVF
U1RfQ09VTlQgfHwgKGxhc3QgJmFtcDsmYW1wOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJsa19ycV9ieXRlcyhsYXN0KSAmZ3Q7PSBCTEtfUExVR19GTFVTSF9TSVpFKSkgezxi
cj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJsa19mbHVzaF9wbHVnX2xpc3QocGx1
ZywgZmFsc2UpOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX2Jsb2Nr
X3BsdWcocSk7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08YnI+wqA8YnI+LcKgwqDCoMKg
wqDCoMKgIC8qPGJyPi3CoMKgwqDCoMKgwqDCoMKgICogQHJlcXVlc3RfY291bnQgbWF5IGJlY29t
ZSBzdGFsZSBiZWNhdXNlIG9mIHNjaGVkdWxlPGJyPi3CoMKgwqDCoMKgwqDCoMKgICogb3V0LCBz
byBjaGVjayB0aGUgbGlzdCBhZ2Fpbi48YnI+LcKgwqDCoMKgwqDCoMKgwqAgKi88YnI+LcKgwqDC
oMKgwqDCoMKgIGlmIChsaXN0X2VtcHR5KCZhbXA7cGx1Zy0mZ3Q7bXFfbGlzdCkpPGJyPi3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVlc3RfY291bnQgPSAwOzxicj4twqDCoMKgwqDCoMKgwqAg
ZWxzZSBpZiAoYmxrX3F1ZXVlX25vbWVyZ2VzKHEpKTxicj4twqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXF1ZXN0X2NvdW50ID0gYmxrX3BsdWdfcXVldWVkX2NvdW50KHEpOzxicj4tPGJyPi3CoMKg
wqDCoMKgwqDCoCBpZiAoIXJlcXVlc3RfY291bnQpPGJyPi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRyYWNlX2Jsb2NrX3BsdWcocSk7PGJyPi3CoMKgwqDCoMKgwqDCoCBlbHNlPGJyPi3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGxhc3QgPSBsaXN0X2VudHJ5X3JxKHBsdWctJmd0O21xX2xpc3QucHJl
dik7PGJyPi08YnI+LcKgwqDCoMKgwqDCoMKgIGlmIChyZXF1ZXN0X2NvdW50ICZndDs9IEJMS19N
QVhfUkVRVUVTVF9DT1VOVCB8fCAobGFzdCAmYW1wOyZhbXA7PGJyPi3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJsa19ycV9ieXRlcyhsYXN0KSAmZ3Q7PSBCTEtfUExVR19GTFVTSF9TSVpFKSkgezxi
cj4twqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtfZmx1c2hfcGx1Z19saXN0KHBsdWcsIGZhbHNl
KTs8YnI+LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfYmxvY2tfcGx1ZyhxKTs8YnI+K8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9hZGRfdGFpbCgmYW1wO3JxLSZndDtxdWV1ZWxpc3Qs
ICZhbXA7cGx1Zy0mZ3Q7bXFfbGlzdCk7PGJyPsKgwqDCoMKgwqDCoMKgwqAgfTxicj4tPGJyPi3C
oMKgwqDCoMKgwqDCoCBsaXN0X2FkZF90YWlsKCZhbXA7cnEtJmd0O3F1ZXVlbGlzdCwgJmFtcDtw
bHVnLSZndDttcV9saXN0KTs8YnI+wqDCoMKgwqAgfSBlbHNlIGlmIChwbHVnICZhbXA7JmFtcDsg
IWJsa19xdWV1ZV9ub21lcmdlcyhxKSkgezxicj7CoMKgwqDCoMKgwqDCoMKgIGJsa19tcV9iaW9f
dG9fcmVxdWVzdChycSwgYmlvKTs8YnI+wqA8YnI+PGJyPjxicj48L2Rpdj4NCg==
--000000000000b90ba7057027d0ea--
