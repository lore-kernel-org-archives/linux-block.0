Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A02C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 14:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCA62086C
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 14:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfBAOJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:09:29 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45862 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730073AbfBAOJ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 09:09:28 -0500
Received: by mail-lj1-f169.google.com with SMTP id s5-v6so5855148ljd.12
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 06:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcEYLNiru0tGYJVHv+5mm5kH5HbBwBqSd6cYpUnTjJM=;
        b=slF7ORQ/FR9lB8m7jNbd66FvNxj1/W6nWS9IbdamdydS/nLZmC7xrNRxo/J5QxmAbJ
         1y18OE6jUSVUP3F1YkTtTmIr5aHPqv1DvagKv6PnOJbQFxX/GoPjunpyv/Of1b/JLKC+
         wvORHhKue5scHaSlfBjm/VXOAEcuxpBHaAqZLv7gGe7igsZ2haNeb4/99NvDu/4p8rJO
         NYt/5DvD3kKezmZCH0IkaK/hSkCvsGvyF9BrJOXMyp5VVlxLWTabndEeMna9AG6+hWI0
         UaWmEUd1O4rOzZWPf7YbCOmz/Dv35BxrhlEBCcMhJduNiI1JQ7aCyo/KKVEt2or7xeUF
         AZeA==
X-Gm-Message-State: AJcUukdtp4mbD4TjK7JesQpu/0wRkcim+RQ+Nx4svn/Wr+PEUAi5HF8U
        YFuPz5pU0uTBBJCA392k1KCglXfF4b5jzj6nnzkH2A==
X-Google-Smtp-Source: ALg8bN6HCpHJV1nb4wuz2mMfRDdKKKBBfo42y+C51ZT0t94w6AgH2GkpJiBDU3Lb7zVSHLYu7xSOnI9KuMBFt3x1IbY=
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr30916132ljg.67.1549030166300;
 Fri, 01 Feb 2019 06:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
 <20190131103924.GA22503@infradead.org> <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
 <20190201073527.GA14758@infradead.org>
In-Reply-To: <20190201073527.GA14758@infradead.org>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Fri, 1 Feb 2019 09:09:14 -0500
Message-ID: <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I didn't know such a thing existed... does it work on any block
device? Where do I read more about this?

On Fri, Feb 1, 2019 at 2:35 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jan 31, 2019 at 02:41:52PM -0500, John Dorminy wrote:
> > > On Wed, Jan 30, 2019 at 09:08:50AM -0500, John Dorminy wrote:
> > > > (I use WRITE_SAME to fill devices with a particular pattern in order
> > > > to catch failures to initialize disk structures appropriately,
> > > > personally, but it's just for convenience/speed.)
> > >
> > > How do you use it?  We don't have a user interface to generate
> > > REQ_OP_WRITE_SAME requests.
> >
> > A not-checked-in test module, similar to Zhang Xiaoxu's reproducer,
> > exposing a sysfs node to trigger filling a block device with a test
> > pattern.
>
> Any reason you don't just use SCSI/NVMe passthrough directly from
> userspace for that?
