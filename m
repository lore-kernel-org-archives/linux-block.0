Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 20 Jul 2018 11:24:45 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720172444.GH4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
 <20180720155646.GE4093@localhost.localdomain>
 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
 <20180720161240.GF4093@localhost.localdomain>
 <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
 <20180720162321.GG4093@localhost.localdomain>
 <797120d19f5d15e7d98a3d2f90ce91ebf60690d7.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <797120d19f5d15e7d98a3d2f90ce91ebf60690d7.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 04:45:05PM +0000, Bart Van Assche wrote:
> I think that's a misunderstanding. If scsi_times_out() queues an abort
> asynchronously then it tells the block layer through its return value that the
> SCSI core still owns the request and hence that the block layer should ignore any
> completions that occur until the SCSI core calls scsi_finish_command(). That
> scsi_finish_command() will trigger a call to __blk_mq_end_request(). The
> scsi_times_out() return value I was referring to is called BLK_EH_DONE today and
> was called BLK_EH_NOT_HANDLED in kernel version v4.17.
> 
> This also means that I got the BLK_EH_NOT_HANDLED case wrong in "blk-mq: Rework
> blk-mq timeout handling again": in that case concurrent a blk_mq_complete_request()
> call should be ignored instead of triggering request completion.

I definitely think it's worth revisiting that for the longer term.

For near term, I don't want scsi error handling broken for 4.18, but also
not revert the changes that fixed all the other drivers. Restoring the
old behavior that scsi wants isolated to the scsi driver seems like the
lowest touch option.

My patch restores the state that scsi had in 4.17. It still has that
gap that may lose requests forever when the scsi LLD always returns
BLK_EH_RESET_TIMER (see virtio-scsi, for example). That gap existed prior,
so that's not new with my patch. Maybe we can fix that with a slight
modification to my previous patch. It looks like SCSI really wants to
block completions only when it hands off the command to the error handler,
so we don't need to have the inflight -> compete -> inflight transition,
and the following is all that's needed:

---
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 8932ae81a15a..902c30d3c0ed 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -296,6 +296,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 		rtn = host->hostt->eh_timed_out(scmd);
 
 	if (rtn == BLK_EH_DONE) {
+		if (req->q->mq_ops && blk_mq_mark_complete(req))
+			return rtn;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
--
