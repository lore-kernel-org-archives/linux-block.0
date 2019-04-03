Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79BAC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C6920700
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 20:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="kfxKIjaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfDCUTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:19:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41788 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCUTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 16:19:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id w30so566702qta.8
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sBh8Tj/bJQE4+gwEMPu5uKxNDG0Gx/uZSnUVHxO5OYw=;
        b=kfxKIjaJEQOERkC70k4HHuOHpYYaXGDExEvaYrI8dKOFGB17oNtL5g2K2lJsOKW1h/
         I6tb+9ldOoh+pIs3KzQbj7hkTE1FKKG4VIAkT4sWhSU2CBEAnWbkUUwBbS3F1QV/6VdH
         UxGrHqSdrLAnZjzYALnZUtjxkPOdXSyKigQdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sBh8Tj/bJQE4+gwEMPu5uKxNDG0Gx/uZSnUVHxO5OYw=;
        b=ENP+Tf0/fmGn0V6xhN70rLA9CBDlQ13jqswhY8AM2FC+PNSCFANmRYkGe1nGLsUiE3
         +LZ7cJMxRiS9jKivv8f5MHSk53VPSQOZNQNNQjc+kLHVb9WrYOmggaBR+Tds7LMsIQRO
         3c0KR7qxGtOyen2rVXZYBF2NEDW3KswjXOECXifPzkcryLmD2wDxOSN3/plrubz8EavH
         W9Pb24IfdRlyNKaQjSn5DTKAB6k6NsKPssTn29/OohuTKWeK+F20lLGwmfrFa5fyHyp3
         2OqyC+ASFSbDDUpCwBkbjte4Nuhd2RfWQzorr5ZSbUJxeaqDLhBDosKqHNa8UhGEFb5o
         lMwQ==
X-Gm-Message-State: APjAAAUssNgnRu/LQACIjawffaY6hmx4DsD8pdwWNBrVsmd+bdpuJUjr
        hG9BuLu3LNpYrmZp/2+dWOPkjcpEdQPv+trlWvlpj3qCUrg=
X-Google-Smtp-Source: APXvYqxNx8PKCucyg4detrad8oS1/iK0Eo9RnFLLXYWej7AHZ+hjahRLQqs/krnVb7I2JB+1cc6IKk7/4jSfTslAbgY=
X-Received: by 2002:ac8:316b:: with SMTP id h40mr1831097qtb.39.1554322747184;
 Wed, 03 Apr 2019 13:19:07 -0700 (PDT)
MIME-Version: 1.0
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Wed, 3 Apr 2019 13:18:56 -0700
Message-ID: <CAJX3CtjkBYRa21OetDfCZ0W5UZyjzCwBw8C9ZnBKnDOcrKJP3A@mail.gmail.com>
Subject: [bug report][scsi blk_mq] data corruption due to a bug in SCSI LLD
 error handling
To:     Jens Axboe <axboe@kernel.dk>, Lee Duncan <lduncan@suse.com>,
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

Hello All,

I encountered this bug while trying to enable dm_blk_mq for our
iSCSI/FCP targets.

The bug is that the sg_io issued to scsi_blk_mq would succeed even if
LLD wants to error out those requests.

Let me explain the scenario in more details.

Setup:
0. Host kernel configuration
- 4.19.9, 4.20.16
- boot parameter: dm_mod.use_blk_mq=Y scsi_mod.use_blk_mq=Y
scsi_transport_iscsi.debug_session=1 scsi_transport_iscsi.debug_conn=1

Scenario:
1. Connect the host to iSCSI target via four paths
: A dm device is created for those target devices
2. Start an application in the host which generates sg_io ioctl for
XCOPY and WSAME to the dm device with the ratio of around 50%
(pread/pwrite for the rest).
3. Perform system crash (sysrq-trigger) in the iSCSI target

Expected result:
- Any outstanding IOs should get failed with errors

Actual results:
- Normal read/write IOs get failed as expected
- SG_IO ioctls SUCCEEDED!!
- log message:
[Tue Apr  2 11:26:34 2019]  session3: session recovery timed out after 11 secs
[Tue Apr  2 11:26:34 2019]  session3: session_recovery_timedout:
Unblocking SCSI target
..
[Tue Apr  2 11:26:34 2019] sd 8:0:0:8: scsi_prep_state_check:
rejecting I/O to offline device
[Tue Apr  2 11:26:34 2019] sd 8:0:0:8: scsi_prep_state_check:
rejecting I/O to offline device
[Tue Apr  2 11:26:34 2019] sd 8:0:0:8: scsi_prep_state_check:
rejecting I/O to offline device
[Tue Apr  2 11:26:34 2019] print_req_error: I/O error, dev sdi, sector 30677580
[Tue Apr  2 11:26:34 2019] device-mapper: multipath: Failing path 8:128.
[Tue Apr  2 11:26:34 2019] SG_IO disk=sdi, result=0x0

- This causes the DATA corruption for the application

Relavant call stacks: (SG_IO issue path)
[Tue Apr  2 11:26:33 2019] sd 8:0:0:8: [sdi] sd_ioctl: disk=sdi, cmd=0x2285
[Tue Apr  2 11:26:33 2019] SG_IO disk=sdi, retried 1 cmd 93
[Tue Apr  2 11:26:33 2019] CPU: 30 PID: 16080 Comm: iostress Not
tainted 4.19.9-purekernel_dbg.x86_64+ #30
[Tue Apr  2 11:26:33 2019] Hardware name:  /0JP31P, BIOS 2.0.19 08/29/2013
[Tue Apr  2 11:26:33 2019] Call Trace:
[Tue Apr  2 11:26:33 2019]  dump_stack+0x63/0x85
[Tue Apr  2 11:26:33 2019]  sg_io+0x41e/0x480
[Tue Apr  2 11:26:33 2019]  scsi_cmd_ioctl+0x297/0x420
[Tue Apr  2 11:26:33 2019]  ? sdev_prefix_printk+0xe9/0x120
[Tue Apr  2 11:26:33 2019]  ? _cond_resched+0x1a/0x50
[Tue Apr  2 11:26:33 2019]  scsi_cmd_blk_ioctl+0x51/0x70
[Tue Apr  2 11:26:33 2019]  sd_ioctl+0x95/0x1a0 [sd_mod]
[Tue Apr  2 11:26:33 2019]  __blkdev_driver_ioctl+0x25/0x30
[Tue Apr  2 11:26:33 2019]  dm_blk_ioctl+0x79/0x100 [dm_mod]
[Tue Apr  2 11:26:33 2019]  blkdev_ioctl+0x89a/0x940
[Tue Apr  2 11:26:33 2019]  ? do_nanosleep+0xae/0x180
[Tue Apr  2 11:26:33 2019]  block_ioctl+0x3d/0x50
[Tue Apr  2 11:26:33 2019]  do_vfs_ioctl+0xa6/0x600
[Tue Apr  2 11:26:33 2019]  ? __audit_syscall_entry+0xe9/0x130
[Tue Apr  2 11:26:33 2019]  ksys_ioctl+0x6d/0x80
).[Tue Apr  2 11:26:33 2019]  __x64_sys_ioctl+0x1a/0x20
[Tue Apr  2 11:26:33 2019]  do_syscall_64+0x60/0x180
[Tue Apr  2 11:26:33 2019]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

According to the analysis, it seems that there is a bug in propagating
errors for iSCSI session timeout (i.e., session_recovery_timedout).
Compared to this, legacy SCSI queue handles the errors in
scsi_request_fn by killing the request as can be seen below.

1872 static void scsi_request_fn(struct request_queue *q)
1873         __releases(q->queue_lock)
1874         __acquires(q->queue_lock)
1875 {
..
1886         for (;;) {
..
1893                 req = blk_peek_request(q);
1894                 if (!req)
1895                         break;
1896
1897                 if (unlikely(!scsi_device_online(sdev))) {
1898                         sdev_printk(KERN_ERR, sdev,
1899                                     "scsi_request_fn: rejecting
I/O to offline device\n");
1900                         scsi_kill_request(req, q);
1901                         continue;
1902                 }
1903

I am not sure in which layer we have to fix this, LLD or scsi_queue_rq().

Could someone please take a look? Or, could someone guide me on how to
fix this bug?

Thanks,

Jaesoo Lee.
