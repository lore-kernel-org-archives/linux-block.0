Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBF2C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 21:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E9420883
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 21:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YZMpPxXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDIVgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:36:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34732 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfDIVgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 17:36:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id n68so11283725qka.1
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xk1yFLTE0k7l2bzRkG2k5Qpy+I1cGdbvKin44r0TQGc=;
        b=YZMpPxXVMzIfBJCgbpgkvQQ91vDJg4sDPSnrCP1mFF404HD5mAMSWVbdmnlsKMTOr9
         Lvylbd1XtsNK6kf7ri/ITf0gehPL+Cia7GbKVHOutc0Nhh4O+S2RDMwFIUoAKxzI5IRy
         cIUJV1ZEtHer9q5OgwpQT9Mwr51kHmdxbujKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk1yFLTE0k7l2bzRkG2k5Qpy+I1cGdbvKin44r0TQGc=;
        b=fyWkHc1vwa/VlpyjSrctb4C/P+ExFDTpsIJHPZ/bSAeSRO3gx7PqnQx9WrabdCpTvw
         IUI/qGKMHemsbo+V/K/hPmL8uXXR9R/neXcKOH1InEAa4auJv7XQy5K55FuVMuAKhmTj
         N8pJM07h67744nfNm4fS3lMSBz790U70lUvd7DYYNFtFAS82Dxe6eRoDowb/ygEIEGEe
         A/QCkGRIsdT3FPAPKKspl3j5KwN48c+QDUCk4bCoPS9d9RFTnD7VEJwVj0GcEshZEAXT
         rQpJNodak0RscT5NwTy9eBCZZgB/OSFbRUGR7n9E1OzXsaCU+8O0rMi6hR9Y8B+cheS9
         Vrbg==
X-Gm-Message-State: APjAAAWgfugTm96c1uoPkBsmXnleg1TcyGMJ4rRzS26qjqp7dhlZRTbZ
        EgjVtsaGE168HMV4J2yc7JiVGiLmQ5tZjMC2YSoxjw==
X-Google-Smtp-Source: APXvYqyLWhn/5Xj0HlMmazNP9lr6R1rg8cOsdKZjtggtmene5Y5+QCJ6YcdBkqMkFIpk1SMRyZL8zIbctMrMywpSzUE=
X-Received: by 2002:a05:620a:14bc:: with SMTP id x28mr30815857qkj.221.1554845799135;
 Tue, 09 Apr 2019 14:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJX3CtjkBYRa21OetDfCZ0W5UZyjzCwBw8C9ZnBKnDOcrKJP3A@mail.gmail.com>
 <b3b72ebf-3402-1dfc-5dd6-fbaca65171ed@interlog.com>
In-Reply-To: <b3b72ebf-3402-1dfc-5dd6-fbaca65171ed@interlog.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 9 Apr 2019 14:36:28 -0700
Message-ID: <CAJX3CtgZw7Tcz5mzzmy2QuULJTp+2LP4W_oYjwnHiJH26YSJHg@mail.gmail.com>
Subject: Re: [bug report][scsi blk_mq] data corruption due to a bug in SCSI
 LLD error handling
To:     Douglas Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thanks for the comments.

I tried to run sg_write_same over sg device and I am seeing the same problem.

The result is as follows:

0. Kernel configs
Version: 5.1-rc1
Boot parameter: dm_mod.use_blk_mq=Y scsi_mod.use_blk_mq=Y

1. Normal state
: (As expected) The command succeeded

$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
$

2. Immediately after bringing down the iSCSI interface at the target
: (As expected) Failed with DID_TRANSPORT_DISRUPTED after a few seconds

$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
Write same: transport: Host_status=0x0e [DID_TRANSPORT_DISRUPTED]
Driver_status=0x00 [DRIVER_OK, SUGGEST_OK]

Write same(10) command failed

3. Immediately after the DID_TRANSPORT_DISRUPTED error
: (BUG) The command succeeded after a few seconds

$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
$

: Kernel logs
Apr  8 18:28:03 init21-16 kernel: session1: session recovery timed out
after 10 secs
Apr  8 18:28:03 init21-16 kernel: sd 8:0:0:5: rejecting I/O to offline device

4. Issued IO again
: (As expected) The command failed

$ sg_write_same --lba=100 --xferlen=512 /dev/sg5
Write same: pass through os error: No such device or address
Write same(10) command failed

Let me upload my fix for this and please give me some comments on that.

Thanks,

Jaesoo Lee.

---------- Forwarded message ---------
From: Douglas Gilbert <dgilbert@interlog.com>
Date: Wed, Apr 3, 2019 at 2:06 PM
Subject: Re: [bug report][scsi blk_mq] data corruption due to a bug in
SCSI LLD error handling
To: Jaesoo Lee <jalee@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, James
E.J. Bottomley <jejb@linux.vnet.ibm.com>, Martin K. Petersen
<martin.petersen@oracle.com>
Cc: <linux-block@vger.kernel.org>, <open-iscsi@googlegroups.com>,
<linux-scsi@vger.kernel.org>


On 2019-04-03 4:18 p.m., Jaesoo Lee wrote:
> Hello All,
>
> I encountered this bug while trying to enable dm_blk_mq for our
> iSCSI/FCP targets.
>
> The bug is that the sg_io issued to scsi_blk_mq would succeed even if
> LLD wants to error out those requests.
>
> Let me explain the scenario in more details.
>
> Setup:
> 0. Host kernel configuration
> - 4.19.9, 4.20.16
> - boot parameter: dm_mod.use_blk_mq=Y scsi_mod.use_blk_mq=Y
> scsi_transport_iscsi.debug_session=1 scsi_transport_iscsi.debug_conn=1
>
> Scenario:
> 1. Connect the host to iSCSI target via four paths
> : A dm device is created for those target devices
> 2. Start an application in the host which generates sg_io ioctl for
> XCOPY and WSAME to the dm device with the ratio of around 50%
> (pread/pwrite for the rest).
> 3. Perform system crash (sysrq-trigger) in the iSCSI target
>
> Expected result:
> - Any outstanding IOs should get failed with errors
>
> Actual results:
> - Normal read/write IOs get failed as expected
> - SG_IO ioctls SUCCEEDED!!

Not all ioctl(SG_IO)s are created equal!

If you are using the sg v3 interface (i.e. struct sg_io_hdr) then I would
expect DRIVER_TIMEOUT in sg_io_obj.driver_status or DID_TIME_OUT in
sg_io_obj.host_status to be set on completion. [BTW You will _not_ see
a ETIMEDOUT errno; only errors prior to submission yield errno style
errors.]

If you don't see that with ioctl(SG_IO) on a block device then try again on
a sg device. If neither report that then the mid-level error processing
is broken.

Doug Gilbert


> - log message:
> [Tue Apr  2 11:26:34 2019]  session3: session recovery timed out after 11 secs
> [Tue Apr  2 11:26:34 2019]  session3: session_recovery_timedout:
> Unblocking SCSI target
> ..
> [Tue Apr  2 11:26:34 2019] sd 8:0:0:8: scsi_prep_state_check:
> rejecting I/O to offline device
> [Tue Apr  2 11:26:34 2019] sd 8:0:0:8: scsi_prep_state_check:
> rejecting I/O to offline device
> [Tue Apr  2 11:26:34 2019] sd 8:0:0:8: scsi_prep_state_check:
> rejecting I/O to offline device
> [Tue Apr  2 11:26:34 2019] print_req_error: I/O error, dev sdi, sector 30677580
> [Tue Apr  2 11:26:34 2019] device-mapper: multipath: Failing path 8:128.
> [Tue Apr  2 11:26:34 2019] SG_IO disk=sdi, result=0x0
>
> - This causes the DATA corruption for the application
>
> Relavant call stacks: (SG_IO issue path)
> [Tue Apr  2 11:26:33 2019] sd 8:0:0:8: [sdi] sd_ioctl: disk=sdi, cmd=0x2285
> [Tue Apr  2 11:26:33 2019] SG_IO disk=sdi, retried 1 cmd 93
> [Tue Apr  2 11:26:33 2019] CPU: 30 PID: 16080 Comm: iostress Not
> tainted 4.19.9-purekernel_dbg.x86_64+ #30
> [Tue Apr  2 11:26:33 2019] Hardware name:  /0JP31P, BIOS 2.0.19 08/29/2013
> [Tue Apr  2 11:26:33 2019] Call Trace:
> [Tue Apr  2 11:26:33 2019]  dump_stack+0x63/0x85
> [Tue Apr  2 11:26:33 2019]  sg_io+0x41e/0x480
> [Tue Apr  2 11:26:33 2019]  scsi_cmd_ioctl+0x297/0x420
> [Tue Apr  2 11:26:33 2019]  ? sdev_prefix_printk+0xe9/0x120
> [Tue Apr  2 11:26:33 2019]  ? _cond_resched+0x1a/0x50
> [Tue Apr  2 11:26:33 2019]  scsi_cmd_blk_ioctl+0x51/0x70
> [Tue Apr  2 11:26:33 2019]  sd_ioctl+0x95/0x1a0 [sd_mod]
> [Tue Apr  2 11:26:33 2019]  __blkdev_driver_ioctl+0x25/0x30
> [Tue Apr  2 11:26:33 2019]  dm_blk_ioctl+0x79/0x100 [dm_mod]
> [Tue Apr  2 11:26:33 2019]  blkdev_ioctl+0x89a/0x940
> [Tue Apr  2 11:26:33 2019]  ? do_nanosleep+0xae/0x180
> [Tue Apr  2 11:26:33 2019]  block_ioctl+0x3d/0x50
> [Tue Apr  2 11:26:33 2019]  do_vfs_ioctl+0xa6/0x600
> [Tue Apr  2 11:26:33 2019]  ? __audit_syscall_entry+0xe9/0x130
> [Tue Apr  2 11:26:33 2019]  ksys_ioctl+0x6d/0x80
> ).[Tue Apr  2 11:26:33 2019]  __x64_sys_ioctl+0x1a/0x20
> [Tue Apr  2 11:26:33 2019]  do_syscall_64+0x60/0x180
> [Tue Apr  2 11:26:33 2019]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> According to the analysis, it seems that there is a bug in propagating
> errors for iSCSI session timeout (i.e., session_recovery_timedout).
> Compared to this, legacy SCSI queue handles the errors in
> scsi_request_fn by killing the request as can be seen below.
>
> 1872 static void scsi_request_fn(struct request_queue *q)
> 1873         __releases(q->queue_lock)
> 1874         __acquires(q->queue_lock)
> 1875 {
> ..
> 1886         for (;;) {
> ..
> 1893                 req = blk_peek_request(q);
> 1894                 if (!req)
> 1895                         break;
> 1896
> 1897                 if (unlikely(!scsi_device_online(sdev))) {
> 1898                         sdev_printk(KERN_ERR, sdev,
> 1899                                     "scsi_request_fn: rejecting
> I/O to offline device\n");
> 1900                         scsi_kill_request(req, q);
> 1901                         continue;
> 1902                 }
> 1903
>
> I am not sure in which layer we have to fix this, LLD or scsi_queue_rq().
>
> Could someone please take a look? Or, could someone guide me on how to
> fix this bug?
>
> Thanks,
>
> Jaesoo Lee.
>
