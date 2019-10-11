Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A521C47404
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECBD2190F
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiZ8vNtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfJKLzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:55:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43502 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfJKLzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Oct 2019 07:55:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id j18so11580535wrq.10
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2019 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nxuuuvd35uqUqhRNYU8qJcG2HxM3uht7/OFpsGQua9s=;
        b=DiZ8vNtgzzdPZXTB3/LKuXSTIOgPrh2Iiw2dPnr8RSefDWIckGqkKqiB/BaaOWEYIW
         i6wWDwuNJwJn9hU/4UIToUTP6yLFWkf0L/Qq6TgK6ik/pFc2DTWpQbvrcHIjIN+nwPb2
         bxLrMdK66vH7kNt+bpsKlqh1Px6995UZxARI3PiaPn3qHjJuetqDemyfioFZJxejmnhs
         kh7q7HwMhrBsQDmivSAyC6TRm4i5ZLn9+7vQuCcJbjbnjgisoTI1pVZQA/6SNhH0Km1V
         QBFfJ5VcJBM4taNFf8eZdXysBaTgYpdYBtyJ6VoMZwktLhrDNZ/Zeo//fjdrqd+TZtko
         q9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nxuuuvd35uqUqhRNYU8qJcG2HxM3uht7/OFpsGQua9s=;
        b=l48CfSxVjZ+V24hzlF0YzLrbZUHA0Q4Gpd8Lordjo8X6dwbP8ezmlBaG4RtfxZ40VB
         iPFJ3yGrPbpJc7J4t60kVrKUIOZ/HJeUPFwKCdC9cU+RsAOrTbtJ6SuntuW3O/npFqrV
         7LNRv829DlmiMTH4PtXb4AcRT+jt5n+gy5yWA2O+yLJChxhKWKadZvMQym6wKX5ZbZL0
         DdYZeivsE3VvqMxfZs/DSvckPEV7aEo6ru5CN2qTPPw8Fj6OFv9e0XmLrQaWr00y1Yjb
         pgNj+cmNia5l9uBgpEXlTU/lM4OebnkM8OC9r9UPMWxv6JGccqgcjzRwGB0fl8BHdZnQ
         nOCg==
X-Gm-Message-State: APjAAAVsD3FIP3vWOioRRrlphycT8R9dDNqdyix7vwixKs4An6zktY4/
        95AA+8NGGYoB2DPU+OyVP5FrV0zQiMjv8CdLVEY=
X-Google-Smtp-Source: APXvYqy3dvXmTDuLOHVoNvsI/3EE7PZZWrjR3ghj7FSCOVSP1VYS9L43NY/CVTcddpzzSTSDTeBpkJyKTbZTqnJuAl0=
X-Received: by 2002:a5d:660f:: with SMTP id n15mr11799680wru.179.1570794938753;
 Fri, 11 Oct 2019 04:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191008041821.2782-1-ming.lei@redhat.com> <bf9687ef-4a90-73f7-3028-4c5d56c8d66b@huawei.com>
 <549bf046-f617-4c4f-5bf1-17603cc5f832@huawei.com> <20191009083930.GE10549@ming.t460p>
 <a30f6b45-0b89-7950-1e44-240630d89264@huawei.com> <20191010103016.GA22976@ming.t460p>
 <41b9185d-f780-f08f-dd63-9ad02a6976d4@huawei.com> <2c0b5542-de7c-ff84-0aae-086cfd6075b7@huawei.com>
In-Reply-To: <2c0b5542-de7c-ff84-0aae-086cfd6075b7@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 11 Oct 2019 19:55:26 +0800
Message-ID: <CACVXFVN2K-GYTdSwXZ2fZ9=Kgq+jXa3RCkqw+v_DcvaFBvgpew@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 4:54 PM John Garry <john.garry@huawei.com> wrote:
>
> On 10/10/2019 12:21, John Garry wrote:
> >
> >>
> >> As discussed before, tags of hisilicon V3 is HBA wide. If you switch
> >> to real hw queue, each hw queue has to own its independent tags.
> >> However, that isn't supported by V3 hardware.
> >
> > I am generating the tag internally in the driver now, so that hostwide
> > tags issue should not be an issue.
> >
> > And, to be clear, I am not paying too much attention to performance, but
> > rather just hotplugging while running IO.
> >
> > An update on testing:
> > I did some scripted overnight testing. The script essentially loops like
> > this:
> > - online all CPUS
> > - run fio binded on a limited bunch of CPUs to cover a hctx mask for 1
> > minute
> > - offline those CPUs
> > - wait 1 minute (> SCSI or NVMe timeout)
> > - and repeat
> >
> > SCSI is actually quite stable, but NVMe isn't. For NVMe I am finding
> > some fio processes never dying with IOPS @ 0. I don't see any NVMe
> > timeout reported. Did you do any NVMe testing of this sort?
> >
>
> Yeah, so for NVMe, I see some sort of regression, like this:
> Jobs: 1 (f=1): [_R] [0.0% done] [0KB/0KB/0KB /s] [0/0/0 iops] [eta
> 1158037877d:17h:18m:22s]

I can reproduce this issue, and looks there are requests in ->dispatch.
I am a bit busy this week, please feel free to investigate it and debugfs
can help you much. I may have time next week for looking this issue.

Thanks,
Ming Lei
