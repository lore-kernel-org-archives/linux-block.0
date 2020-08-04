Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7001C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B3B2086A
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 09:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VZOV890D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgHDJ16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgHDJ16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:27:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459AC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:27:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x69so37806140qkb.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=cPlNNpjyiTBikq1bl8KaReTGTuo/mBW8l6LZ+Qu9Pms=;
        b=VZOV890DtOTCchaixXqCraKQuyAwJ3kbbD1EEpSRVy/D1rUmLZy/yb2lothc+1HD6f
         ra5X5ZcQ28d97t6UY5t9m58S6yyRk/O39YZwR9pDcYySxXtATVFp4sPAJSHkHlgTJe3N
         e1iAwaGzM07iJWlLpiFvJzSWlWCfg+IBYsD8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=cPlNNpjyiTBikq1bl8KaReTGTuo/mBW8l6LZ+Qu9Pms=;
        b=sjF01RpIIpih1MvnBT6h9R3aJSE+dMkCR+eo5kM5SKJ3PO518U3+ZP5FndZi0SaVCr
         frh3jZlgR/SobzR/WXNJTaQHUkzjSpLZXfXessIzR/WnSGKCzDh3mGAn/MdkYOk2houm
         TQi5zxym3S0sPCRsy1IZYGztp5DKIsm7uggzmCnWqdU6bYcFbUv7b02wxlHEY8ii8kLf
         Ctm+VvURF/ruONL+gVJzh+Ke9KD32T1KPGxEaUIRoYmaCopnqA9lRGzLT5l4yx5NINYO
         S02bm84Ww6GlWvph3bxBePI1weGvTeKZ6+9BEZeA+Fy/uqfiniUNA1Vso6wIJ/IMSYm6
         eFTg==
X-Gm-Message-State: AOAM53006MIGRdXMbxXD4JAATritkbSpXYyDMoD4x4jHldEWBOdaRskw
        swnfRAjgo5XZap8d+mUTnqBF0oLZOPP0nSagVrDsTQ==
X-Google-Smtp-Source: ABdhPJzUiPNNhJ5LRPS0CJFuFwW6tIIfKOEJ9HeIXF8yVrxHPDEOGsdU+NUbZIvHd2oAxyM/p63UaK56GVNru9v6gKs=
X-Received: by 2002:a05:620a:9c6:: with SMTP id y6mr19113266qky.27.1596533276677;
 Tue, 04 Aug 2020 02:27:56 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20200722080409.GB912316@T590> <fe7a7acf-d62b-d541-4203-29c1d0403c2a@huawei.com>
 <20200723140758.GA957464@T590> <f4a896a3-756e-68bb-7700-cab1e5523c81@huawei.com>
 <20200724024704.GB957464@T590> <6531e06c-9ce2-73e6-46fc-8e97400f07b2@huawei.com>
 <20200728084511.GA1326626@T590> <965cf22eea98c00618570da8424d0d94@mail.gmail.com>
 <20200729153648.GA1698748@T590> <7f94eaf2318cc26ceb64bde88d59d5e2@mail.gmail.com>
 <20200804083625.GA1958244@T590>
In-Reply-To: <20200804083625.GA1958244@T590>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJmEWWiA+zHQjWZm0OGQGb5QSh7zQFGdip8AjEYQFIAWf0H4wE/+OJyAP0zBfADIyO/DQIQ6BN/Af8DR5wB98/f/wIl0wtMp31jMFA=
Date:   Tue, 4 Aug 2020 14:57:52 +0530
Message-ID: <afe5eb1be7f416a48d7b5d473f3053d0@mail.gmail.com>
Subject: RE: [PATCH RFC v7 10/12] megaraid_sas: switch fusion adapters to MQ
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, Sumit Saxena <sumit.saxena@broadcom.com>,
        bvanassche@acm.org, hare@suse.com, hch@lst.de,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >
> > > However, it looks a bit
> > > complicated, and I was thinking if one simpler approach can be
> > > figured
> > out.
> >
> > I was thinking your original approach is simple, but if you think some
> > other simple approach I can test as part of these series.
> > BTW, I am still not getting why you think your original approach is
> > not good design.
>
> It is still not straightforward enough or simple enough for proving its
> correctness, even though the implementation isn't complicated.

Ming -

I noted your comments.

I have completed testing and this particular latest performance issue on
Volume is outstanding.
Currently it is 20-25% performance drop in IOPs and we want that to be
closed before shared host tag is enabled for <megaraid_sas> driver.
Just for my understanding - What will be the next steps on this ?

I can validate any new approach/patch for this issue.

Kashyap

>
> >
> > >
> > > >
