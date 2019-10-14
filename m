Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C77C4360C
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 01:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAFA20815
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 01:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIZKug/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfJNBZQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 21:25:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbfJNBZQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 21:25:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id v8so17670972wrt.2
        for <linux-block@vger.kernel.org>; Sun, 13 Oct 2019 18:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiMjcf1bS2IBcNmRYOyuncQPeK3vZ+ZPyD2XjAcxu0Y=;
        b=EIZKug/6eGvWvIOpcyYMovT1VorYbUuO8vB6TiN4QwTnkecgL8aZunS/wnzekX+gLh
         ky9hPdJ8IHKY2p+ZgTcIRGEkiQwc+5C8NvuBoPsSVuTLBAUSukbe52UAMoiDuVcDq8Sp
         pXOe1cCtUeJK0IjgB9szA1lsQxLXQVfC0rmLBpADq2tcWysxkpe2FryY0p3+4WPWCYHv
         1ryPUG29/R+5Sf0O/gdL7qwGI94OaZrmSQpvvyIofBVx5HygkKUGrEWI1yblklpKiUjo
         6ELAo69pFns5OnVc1Cfp7oM7spvUOFFQRT3DbXBAqnpA28Fopt8Ml9MP5/yckpO+Cz8J
         +rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiMjcf1bS2IBcNmRYOyuncQPeK3vZ+ZPyD2XjAcxu0Y=;
        b=X5F4cHU4cgB1If5hCF/PjRO3pe7oxvgnU5Uus8+BYMKXepNP2FWQRxsBAsuDkDiR1H
         VlRQKWj7hYEeUomCnC30Ys6c71cxWcvGPhxbAM7MdLQ5mrCBPaBGhwl/uLxMJxq0CPYy
         sF1dCAjii/+t5wTIgKL9LXV7Qea0M2DMimWYf3evRdtufSDw2KmowNpJ2vGAgacbaLCj
         AHpxaPKXquPLP15N5mfJRk+jcAL06eN1jyJJGcYhfpaSJmlfOXg4YbUuFzmJeZSNrG2A
         LYICSyseHdcnZaxQ8jmTrV7wTh7RsNP0jGiueIRDpDyMR/lNInTTO00UJUhetJF4qPqS
         QYDQ==
X-Gm-Message-State: APjAAAUiH4TMgtvRZmK/bBe6hcc1iRAe9bJN4jM93jU+mOPOyz7JB7EG
        mMJXQxJSXZoBLBbV3+TOuX+L7ybORI2hzwK0l8c=
X-Google-Smtp-Source: APXvYqy2e5M6zM6bYkdFqf36QfvdxUmQlw4RgqYVtOPkcn4lk2K6bSpkbc48Mo+PhCgt/H7/Vp/PoKSM5zsJQuvlbbE=
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr22485893wrv.168.1571016315004;
 Sun, 13 Oct 2019 18:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191008041821.2782-1-ming.lei@redhat.com> <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
 <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com> <20191009083930.GE10549@ming.t460p>
 <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com> <20191010103016.GA22976@ming.t460p>
 <41b9185d-f780-f08f-dd63-9ad02a6976d4@huawei.com> <2c0b5542-de7c-ff84-0aae-086cfd6075b7@huawei.com>
 <CACVXFVN2K-GYTdSwXZ2fZ9=Kgq+jXa3RCkqw+v_DcvaFBvgpew@mail.gmail.com> <b1a561c1-9594-cc25-dcab-bad5c342264f@huawei.com>
In-Reply-To: <b1a561c1-9594-cc25-dcab-bad5c342264f@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 14 Oct 2019 09:25:03 +0800
Message-ID: <CACVXFVNGCfFrh9Q=Cmj0fWCNQiqPDwHKzrSrkZJxNpVtuyEwgw@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] blk-mq: improvement on handling IO during CPU hotplug
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 11, 2019 at 10:10 PM John Garry <john.garry@huawei.com> wrote:
>
> On 11/10/2019 12:55, Ming Lei wrote:
> > On Fri, Oct 11, 2019 at 4:54 PM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 10/10/2019 12:21, John Garry wrote:
> >>>
> >>>>
> >>>> As discussed before, tags of hisilicon V3 is HBA wide. If you switch
> >>>> to real hw queue, each hw queue has to own its independent tags.
> >>>> However, that isn't supported by V3 hardware.
> >>>
> >>> I am generating the tag internally in the driver now, so that hostwide
> >>> tags issue should not be an issue.
> >>>
> >>> And, to be clear, I am not paying too much attention to performance, but
> >>> rather just hotplugging while running IO.
> >>>
> >>> An update on testing:
> >>> I did some scripted overnight testing. The script essentially loops like
> >>> this:
> >>> - online all CPUS
> >>> - run fio binded on a limited bunch of CPUs to cover a hctx mask for 1
> >>> minute
> >>> - offline those CPUs
> >>> - wait 1 minute (> SCSI or NVMe timeout)
> >>> - and repeat
> >>>
> >>> SCSI is actually quite stable, but NVMe isn't. For NVMe I am finding
> >>> some fio processes never dying with IOPS @ 0. I don't see any NVMe
> >>> timeout reported. Did you do any NVMe testing of this sort?
> >>>
> >>
> >> Yeah, so for NVMe, I see some sort of regression, like this:
> >> Jobs: 1 (f=1): [_R] [0.0% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta
> >> 1158037877d:17h:18m:22s]
> >
> > I can reproduce this issue, and looks there are requests in ->dispatch.
>
> OK, that may match with what I see:
> - the problem occuring coincides with this callpath with
> BLK_MQ_S_INTERNAL_STOPPED set:

Good catch, these requests should have been re-submitted in
blk_mq_hctx_notify_dead() too.

Will do it in V4.

Thanks,
Ming Lei
