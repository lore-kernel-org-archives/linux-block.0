Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2018 09:00:10 -0800
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Fix race between resetting the timer and
 completion handling
Message-ID: <20180208170010.GP695913@devbig577.frc2.facebook.com>
References: <20180207011133.25957-1-bart.vanassche@wdc.com>
 <20180207170612.GB695913@devbig577.frc2.facebook.com>
 <1518024428.2870.35.camel@wdc.com>
 <20180207173531.GC695913@devbig577.frc2.facebook.com>
 <1518027251.2870.53.camel@wdc.com>
 <20180207200724.GD695913@devbig577.frc2.facebook.com>
 <1518047297.2870.80.camel@wdc.com>
 <1518052193.2870.90.camel@wdc.com>
 <20180208153940.GM695913@devbig577.frc2.facebook.com>
 <1518107501.3611.19.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518107501.3611.19.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Thu, Feb 08, 2018 at 04:31:43PM +0000, Bart Van Assche wrote:
> > That sounds more like a scsi hotplug bug than an issue in the timeout
> > code unless we messed up @req pointer to begin with.
> 
> I don't think that this is related to SCSI hotplugging: this crash does not
> occur with the v4.15 block layer core and it does not occur with my timeout
> handler rework patch applied either. I think that means that we cannot
> exclude the block layer core timeout handler rework as a possible cause.
> 
> The disassembler output is as follows:
> 
> (gdb) disas /s scsi_times_out
> Dump of assembler code for function scsi_times_out:
> drivers/scsi/scsi_error.c:
> 282     {
>    0x0000000000005bd0 <+0>:     push   %r13
>    0x0000000000005bd2 <+2>:     push   %r12
>    0x0000000000005bd4 <+4>:     push   %rbp
> ./include/linux/blk-mq.h:
> 300             return rq + 1;
>    0x0000000000005bd5 <+5>:     lea    0x178(%rdi),%rbp
> drivers/scsi/scsi_error.c:
> 282     {
>    0x0000000000005bdc <+12>:    push   %rbx
> 283             struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
> 284             enum blk_eh_timer_return rtn = BLK_EH_NOT_HANDLED;
> 285             struct Scsi_Host *host = scmd->device->host;
>    0x0000000000005bdd <+13>:    mov    0x1b0(%rdi),%rax
> 282     {
>    0x0000000000005be4 <+20>:    mov    %rdi,%rbx
> 283             struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
> 284             enum blk_eh_timer_return rtn = BLK_EH_NOT_HANDLED;
> 285             struct Scsi_Host *host = scmd->device->host;
>    0x0000000000005be7 <+23>:    mov    (%rax),%r13
>    0x0000000000005bea <+26>:    nopl   0x0(%rax,%rax,1)
> [ ... ]
> (gdb) print /x sizeof(struct request)
> $2 = 0x178
> (gdb) print &(((struct scsi_cmnd*)0)->device)
> $4 = (struct scsi_device **) 0x38 <scsi_cmd_get_serial+8>
> (gdb) print &(((struct scsi_device*)0)->host)       
> $5 = (struct Scsi_Host **) 0x0
> 
> The crash is reported at address scsi_times_out+0x17 == scsi_times_out+23. The
> instruction at that address tries to dereference scsi_cmnd.device (%rax). The
> register dump shows that that pointer has the value NULL. The only function I
> know of that clears the scsi_cmnd.device pointer is scsi_req_init(). The only
> caller of that function in the SCSI core is scsi_initialize_rq(). That function
> has two callers, namely scsi_init_command() and blk_get_request(). However,
> the scsi_cmnd.device pointer is not cleared when a request finishes. This is
> why I think that the above crash report indicates that scsi_times_out() was
> called for a request that was being reinitialized and not by device hotplugging.

I could be misreading it but scsi_cmnd->device dereference should be
the following.

    0x0000000000005bdd <+13>:    mov    0x1b0(%rdi),%rax

%rdi is @req, 0x1b0(%rdi) seems to be the combined arithmetic of
blk_mq_rq_to_pdu() and ->device dereference - 0x178 + 0x38.  The
faulting access is (%rax), which is deref'ing host from device.

Thanks.

-- 
tejun
