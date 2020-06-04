Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C23C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DB220772
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 13:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOBHkax2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFDN3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgFDN3D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 09:29:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D044C08C5C0
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 06:29:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so6123251wrp.2
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XT1vLZYetGvuzk+KWrknQXupj0yTVynPBDswGPzGyA=;
        b=lOBHkax2QXNA01TVkwCpjfALj5k9W/3VgUUcIffr3Xtk+r8sTqCc7yqMifZjnAy3lp
         WLMua1FShdt4DH+reovg7xbM9A8n2uI4t/6xnR1hTFo9xnQ2igaddWr+JY1ew0+35V6u
         SlzGce2KGDBM3BIKZMgHqPSx6jvd87uLsMCaWCbstpukMt/y5pwajp7PqCB+ZYPqo9Ih
         LS+LFg09golYEdbJm1EkgtNmBG1x7qf6CaVBlqD2YIFIr4iRmeBft7G1zA4dDnR4Lj23
         wpDsJCaZUAiefesWqvVzohtaM1L4wvb3kmKLsy+Uq+WeTT0XLj6T4oBRWPY4WW5/GLLj
         e4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XT1vLZYetGvuzk+KWrknQXupj0yTVynPBDswGPzGyA=;
        b=MYho2TzZ+1EkPZPq/5nxYgKXvpJtIu8sZFj+j6jesyO2QWmiSQ7ys15IsfEh49Ol4o
         7AFvic2z5VpLU+78J5fAehxKTba2Ip+Eb/mR1HB5eAtngpQL7ddNygyMDmSRAdG8AkRx
         +FNmg6iF+3n53AKwzxyqY5yyHIM6L/eibRg7RX0x0bphQkrImb47zy0ecpjgnZS/uRF3
         YcXVg7aYAkWSuV/WOeyZ327eEvnas7mGSVMqp7bmXFy8lLQ4D5u5UGZmuoMHHAxdABOT
         B3Uo8Ydpj6EtrSMMVLwD/qGWtZtV4wkavXnxVo2LIoaSg5rfpyMh62C7WnBGupyt8kT3
         AJVQ==
X-Gm-Message-State: AOAM533PJmHUJk7TH1kTxNAau4UJ+Wh0QE9isEn+fwyIy12e58hZBbzQ
        msnPGnUmLxWflCAx/RoO26ovEnCfhKNKGb7+K6U=
X-Google-Smtp-Source: ABdhPJwFy+SnEGO9CauBSyZwmxpZ50TtMRcgWl8a1Et8EmYPTQnCrk7gjIpgrLULP2UkdpYcF3PWeWe3kbbrSrn+yys=
X-Received: by 2002:adf:e544:: with SMTP id z4mr4493207wrm.317.1591277342373;
 Thu, 04 Jun 2020 06:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200603105128.2147139-1-ming.lei@redhat.com> <20200603115347.GA8653@lst.de>
 <20200603133608.GA2149752@T590> <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com> <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590> <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590> <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
In-Reply-To: <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 4 Jun 2020 21:28:50 +0800
Message-ID: <CACVXFVPb7eF_kWdE5HJ9y54-zOaTeK7QjSsebaZKF2CKwwwipA@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 4, 2020 at 8:50 PM John Garry <john.garry@huawei.com> wrote:
>
>
> >> That's your patch - ok, I can try.
> >>
>
> I still get timeouts and sometimes the same driver tag message occurs:
>
>   1014.232417] run queue from wrong CPU 0, hctx active
> [ 1014.237692] run queue from wrong CPU 0, hctx active
> [ 1014.243014] run queue from wrong CPU 0, hctx active
> [ 1014.248370] run queue from wrong CPU 0, hctx active
> [ 1014.253725] run queue from wrong CPU 0, hctx active
> [ 1014.259252] run queue from wrong CPU 0, hctx active
> [ 1014.264492] run queue from wrong CPU 0, hctx active
> [ 1014.269453] irq_shutdown irq146
> [ 1014.272752] CPU55: shutdown
> [ 1014.275552] psci: CPU55 killed (polled 0 ms)
> [ 1015.151530] CPU56: shutdownr=1621MiB/s,w=0KiB/s][r=415k,w=0 IOPS][eta
> 00m:00s]
> [ 1015.154322] psci: CPU56 killed (polled 0 ms)
> [ 1015.184345] CPU57: shutdown
> [ 1015.187143] psci: CPU57 killed (polled 0 ms)
> [ 1015.223388] CPU58: shutdown
> [ 1015.226174] psci: CPU58 killed (polled 0 ms)
> long sleep 8
> [ 1045.234781] scsi_times_out req=0xffff041fa13e6300[r=0,w=0 IOPS][eta
> 04m:30s]
>
> [...]
>
> >>
> >> I thought that if all the sched tags are put, then we should have no driver
> >> tag for that same hctx, right? That seems to coincide with the timeout (30
> >> seconds later)
> >
> > That is weird, if there is driver tag found, that means the request is
> > in-flight and can't be completed by HW.
>
> In blk_mq_hctx_has_requests(), we iterate the sched tags (when
> hctx->sched_tags is set). So can some requests not have a sched tag
> (even for scheduler set for the queue)?
>
>   I assume you have integrated
> > global host tags patch in your test,
>
> No, but the LLDD does not use request->tag - it generates its own.

Except for wrong queue mapping,  another reason is that the generated
tag may not
be unique. Either of two may cause such timeout issue when the managed
interrupt is
active.

Thanks,
Ming
