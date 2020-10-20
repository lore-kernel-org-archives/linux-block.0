Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F385C4363A
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912FA2224A
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 21:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vz2AkNUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438710AbgJTVf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438708AbgJTVf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 17:35:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CEC0613D3
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 14:35:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so4914773ejy.11
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2020 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYeGwSIoad54GydKSNZgZE6g2uU5cfbPFHvZ08BT6RM=;
        b=vz2AkNUQj4/8TjPt9jfB06mE5lh3/rlUf+7TZCmQybUg2w9Uy6vQWbxXQCV3LtCDo6
         8NrtKsKDpJKbo08xxZc3HVsXDnUkKREszdVB2trWrs/2AdrZ3mckGXVRO6A2eIKS2906
         Z3RSSNONukymyOXsAGQm4R3ZP6mqVzcK95g/x/1IMvf8wVgCEz66GYAsUm+U916t5qMV
         Ud4Q2SPAHqkVMkhaMoeNEEg/w+QWIpXZYUr+Go78/SEGrUm7J3KqYmBLlQo51CR7KtRg
         TEmUrewGCc0Mw15SfxVDhlxCP3L6jNmETWroPevOTLaxA96Bn4Xgyce/T0RK/mgi2IXd
         /x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYeGwSIoad54GydKSNZgZE6g2uU5cfbPFHvZ08BT6RM=;
        b=E/lXKH2REBwBMsg1uC4qDrrfwAaJeTGwNL4J5XjBd6z/9bGUaMUqtn/+xp0dCdh/ih
         EdfvpZ0ziVyA5O4NZxyrzw4GpUjueubanoQgyAfm8JfpTivgA/lo0MSQrlhsCX6iqnuu
         dGc2zIN2MTMYXWygkD8Ij2scQ/QBrShmW5hpoZV4fa9Mmf8K5etfznEhcYuz/RnPZwYj
         od+1eb+tJ8pSVbdolyYfZsXH3QxHg7iYjyvbDkfM3ZaQrZlfIun2UHdcTvYX6uYb/Ubp
         cMqrxT5wqScNGJZ4gzXPRRlnaqpJcwWFlIzI7F9b/i9C+SOco+TDmvmpSQ81EpSAxiBl
         5Edg==
X-Gm-Message-State: AOAM530B66St57Kw0q5getSKCKQzsOK+3xs39Ab1gj65Dob7VEXgRkI7
        u0mYz8uSm+/zbExWwtrPpIDJkztfC7diuOz+yRbgVg==
X-Google-Smtp-Source: ABdhPJxdsFzso6n0bhQlIsaXXdnNPz55lLRK+7wVqKJ60Myp6XphIfmevRWnAF5iTVW1mTgE1+z4eTNT633n3PsqwaQ=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr155804ejz.341.1603229755722;
 Tue, 20 Oct 2020 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com> <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Oct 2020 14:35:44 -0700
Message-ID: <CAPcyv4iYOk3i0pPgXxDTy47BxWCXqqXS0J6mrY5o+1M_41XoAw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 19, 2020 at 3:30 PM Nabeel Meeramohideen Mohamed
(nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> Hi Dan,
>
> On Friday, October 16, 2020 4:12 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> > (nmeeramohide) <nmeeramohide@micron.com> wrote:
> > >
> > > On Thursday, October 15, 2020 2:03 AM, Christoph Hellwig
> > <hch@infradead.org> wrote:
> > > > I don't think this belongs into the kernel.  It is a classic case for
> > > > infrastructure that should be built in userspace.  If anything is
> > > > missing to implement it in userspace with equivalent performance we
> > > > need to improve out interfaces, although io_uring should cover pretty
> > > > much everything you need.
> > >
> > > Hi Christoph,
> > >
> > > We previously considered moving the mpool object store code to user-space.
> > > However, by implementing mpool as a device driver, we get several benefits
> > > in terms of scalability, performance, and functionality. In doing so, we relied
> > > only on standard interfaces and did not make any changes to the kernel.
> > >
> > > (1)  mpool's "mcache map" facility allows us to memory-map (and later unmap)
> > > a collection of logically related objects with a single system call. The objects in
> > > such a collection are created at different times, physically disparate, and may
> > > even reside on different media class volumes.
> > >
> > > For our HSE storage engine application, there are commonly 10's to 100's of
> > > objects in a given mcache map, and 75,000 total objects mapped at a given
> > time.
> > >
> > > Compared to memory-mapping objects individually, the mcache map facility
> > > scales well because it requires only a single system call and single
> > vm_area_struct
> > > to memory-map a complete collection of objects.
>
> > Why can't that be a batch of mmap calls on io_uring?
>
> Agreed, we could add the capability to invoke mmap via io_uring to help mitigate the
> system call overhead of memory-mapping individual objects, versus our mache map
> mechanism. However, there is still the scalability issue of having a vm_area_struct
> for each object (versus one for each mache map).
>
> We ran YCSB workload C in two different configurations -
> Config 1: memory-mapping each individual object
> Config 2: memory-mapping a collection of related objects using mcache map
>
> - Config 1 incurred ~3.3x additional kernel memory for the vm_area_struct slab -
> 24.8 MB (127188 objects) for config 1, versus 7.3 MB (37482 objects) for config 2.
>
> - Workload C exhibited around 10-25% better tail latencies (4-nines) for config 2,
> not sure if it's due the reduced complexity of searching VMAs during page faults.

So this gets to the meta question that is giving me pause on this
whole proposal:

    What does Linux get from merging mpool?

What you have above is a decent scalability bug report. That type of
pressure to meet new workload needs is how Linux interfaces evolve.
However, rather than evolve those interfaces mpool is a revolutionary
replacement that leaves the bugs intact for everyone that does not
switch over to mpool.

Consider io_uring as an example where the kernel resisted trends
towards userspace I/O engines and instead evolved a solution that
maintained kernel control while also achieving similar performance
levels.

The exercise is useful to identify places where Linux has
deficiencies, but wholesale replacing an entire I/O submission model
is a direction that leaves the old apis to rot.
