Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A5C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 03:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45476113D
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 03:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhJEDXf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Oct 2021 23:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229659AbhJEDXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Oct 2021 23:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633404104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xk/7YbIZQF2rW5bq7XOVF5+Z1qU2pZKVc4y/DpCoUKU=;
        b=Hylp2lp5iCWoEQ67dKkCEoh0zmCpF+p/LSUgtRkSU65YjCpyE3s6jBGkFlA4bQahRTIxbT
        yt02gPaFR7fIGWvbs7SIU+fiLJsRRkVaQHHp49ErGfoDWddNz9akeu5oWGFxmVnAYrv/Gd
        FBLqPN71D8O79PPnHZ6blm8mb6P8Gm4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-9p6AuGcpMVaXzv6gnZSOVw-1; Mon, 04 Oct 2021 23:21:42 -0400
X-MC-Unique: 9p6AuGcpMVaXzv6gnZSOVw-1
Received: by mail-yb1-f198.google.com with SMTP id 83-20020a251956000000b0059948f541cbso26506465ybz.7
        for <linux-block@vger.kernel.org>; Mon, 04 Oct 2021 20:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk/7YbIZQF2rW5bq7XOVF5+Z1qU2pZKVc4y/DpCoUKU=;
        b=ArSbUpj3OcbtfgNQmQtmuO6d1revNWxDYVGUKKnosLX3ekUj3h5+QPJ+bO6H/VC6W8
         igR+iwnLDhX/7ObksjFO2g3wOGl+AZB2sl8OjSLxRMnt4AtqVJAb5dSsQOaimVHhJ658
         HqVAeEPPQsBuoxnraIfqNpa/FyyLj05fmO6TNdcdG0RzY+s5d0i1DI1bpynBjJb+pWHV
         V1tLOJoUMie5zMQMj5WXBmHU/5eRB/JyswYoJzxm1s6oDPE5rPwfwXVLh/KD81eM2BSw
         y9IpOHO0UgvQvIDwJcz4PMahBrZ89daakC/E1C0zCWYZBAG7++NMxw+mdZB7amn8Ru+3
         Vmuw==
X-Gm-Message-State: AOAM532S+UbDHQJZvmMAuQHCRZsCiSQzCGtZvL/1JJfPDMBlyj+QS6Gb
        i+v6kVoa5F05jnKTYCS8KnyWTn6vgvLSUCth7/q4+X8kt23m2ru080xnVSWzB3z8ylPgGKr4FYi
        3+Cu9am9smwI2uNEsoMNCbOxIPiDugekLtrodsmI=
X-Received: by 2002:a25:2208:: with SMTP id i8mr19236374ybi.86.1633404102168;
        Mon, 04 Oct 2021 20:21:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvxWboVZDPTjHx/SzBtkcYuB29eNb+iTvhUe9n6Gz1CBDsDL88nFugHhLm/qFAN/yGBmBVv5NaLIO0hXacmVQ=
X-Received: by 2002:a25:2208:: with SMTP id i8mr19236359ybi.86.1633404101936;
 Mon, 04 Oct 2021 20:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8XNtkzbbiLnFmVu82wYeQpLkVp6_wCtrnbhODay+OP9w@mail.gmail.com>
 <059007be-03fa-5948-d86d-d1750587e894@acm.org> <c5db85b3ecb9730d848b2c37c975b72acd8a2413.camel@redhat.com>
 <CAHj4cs_8KbMJ+HU22E4-e_zYuPj8TfGOzxNtzQqxqKig9S=gQg@mail.gmail.com> <491cab4b-1f5b-2881-5ba2-943c23d407ff@acm.org>
In-Reply-To: <491cab4b-1f5b-2881-5ba2-943c23d407ff@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 5 Oct 2021 11:21:30 +0800
Message-ID: <CAHj4cs_6DkGwj3UJWi3YJYJxuzGST-Yi8x4EVrO4YsHP+Pk=7Q@mail.gmail.com>
Subject: Re: [bug report] blktests srp/013 lead kernel panic with latest
 block/for-next and 5.13.15
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 2:07 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/27/21 10:10 PM, Yi Zhang wrote:
> > Hi Bart
> >
> > Bisect shows this issue was introduced from bellow commit, btw, this is always reproduced on the s390x kvm environment:
> >
> > commit 65ca846a53149a1a72cd8d02e7b2e73dd545b834
> > Author: Bart Van Assche <bvanassche@acm.org <mailto:bvanassche@acm.org>>
> > Date:   Wed Jan 22 19:56:34 2020 -0800
> >
> >      scsi: core: Introduce {init,exit}_cmd_priv()
> >
> >      The current behavior of the SCSI core is to clear driver-private data
> >      before preparing a request for submission to the SCSI LLD. Make it possible
> >      for SCSI LLDs to disable clearing of driver-private data.
> >
> >      These hooks will be used by a later patch, namely "scsi: ufs: Let the SCSI
> >      core allocate per-command UFS data".
> >
> > (gdb) l *(scsi_mq_exit_request+0x2c)
> > 0x8d7be4 is in scsi_mq_exit_request (drivers/scsi/scsi_lib.c:1780).
> > 1775 unsigned int hctx_idx)
> > 1776 {
> > 1777 struct Scsi_Host *shost = set->driver_data;
> > 1778 struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
> > 1779
> > 1780 if (shost->hostt->exit_cmd_priv)
> > 1781 shost->hostt->exit_cmd_priv(shost, cmd);
> > 1782 kmem_cache_free(scsi_sense_cache, cmd->sense_buffer);
> > 1783 }
> > 1784
>
> Hi Yi,
>
> Thank you for having taken the time to run a bisect. However, I strongly doubt
> that the bisection result is correct. If there would be anything wrong with the
> above patch it would already have been noticed on other architectures. I
> recommend to proceed as follows:
> * Verify whether the reported issue only occurs with the stable kernel series or
>    also with mainline kernels.

This can be reproduced on both stable kernels and mainline kernels.

> * Work with the soft-iWARP author to improve the reliability of the siw driver.
>    If I run blktests in an x86 VM then the following appears sporadically in
>    the kernel log:
>
> ------------[ cut here ]------------
> WARNING: CPU: 18 PID: 5462 at drivers/infiniband/sw/siw/siw_cm.c:255 __siw_cep_dealloc+0x184/0x190 [siw]
> CPU: 1 PID: 5462 Comm: kworker/u144:13 Tainted: G            E     5.15.0-rc2-dbg+ #7
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> RIP: 0010:__siw_cep_dealloc+0x184/0x190 [siw]
> Call Trace:
>   siw_cep_put+0x5c/0x80 [siw]
>   siw_reject+0x13c/0x230 [siw]
>   iw_cm_reject+0xac/0x130 [iw_cm]
>   cm_conn_req_handler+0x4f1/0x7d0 [iw_cm]
>   cm_work_handler+0x885/0x9c0 [iw_cm]
>   process_one_work+0x535/0xad0
>   worker_thread+0x2e7/0x700
>   kthread+0x1f6/0x220
>   ret_from_fork+0x1f/0x30
> irq event stamp: 11449266
> hardirqs last  enabled at (11449265): [<ffffffff81fc4248>] _raw_spin_unlock_irq+0x28/0x50
> hardirqs last disabled at (11449266): [<ffffffff81fb7e44>] __schedule+0x5f4/0xbb0
> softirqs last  enabled at (11449176): [<ffffffffa06d142f>] p_fill_from_dev_buffer+0xff/0x140 [scsi_debug]
> softirqs last disabled at (11449168): [<ffffffffa06d1400>] p_fill_from_dev_buffer+0xd0/0x140 [scsi_debug]
> ---[ end trace b23871487c995b72 ]---
>
> * Use the rdma_rxe driver to run blktests since at least in my experience that
>    driver is more reliable than the soft-iWARP driver.
>

I would suggest reproducing it on s390x platform since it was easy on
that platform from my testing.
And from the CKI tests history, it also has been reproduced on
ppc64le/aarch64 with rdma_rxe.

BTW, I've verified this issue with Ming's patch on s390x, thanks for
looking this issue.

https://lore.kernel.org/linux-scsi/20210930124415.1160754-1-ming.lei@redhat.com/T/#u


> Thanks,
>
> Bart.
>


-- 
Best Regards,
  Yi Zhang

