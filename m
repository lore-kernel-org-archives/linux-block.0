Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05341C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbiESQyW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbiESQyV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 12:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6229A66232
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652979258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EzEASw2XF8h0URz7BLtCcvA5dhn1aysC2rhH4z0rEd0=;
        b=Xov7SWVfbKDeq1KpKSlcVVl9U7e+gfY83zF+0ektyYgOuKfVp2jnW8Kms2IkQQCw+PP1bD
        c2Vzek0VqNQDwVZdIAveH8/x7VbYad0JI/hyJcrbKTJZSHqH5MiXYKM7CP0q1IrcQHZ5s3
        SeN5j59nYaciw7kePvgsQepGI0E+0i0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-FUfXnAxnO5-lL6Bg1eRcGg-1; Thu, 19 May 2022 12:54:17 -0400
X-MC-Unique: FUfXnAxnO5-lL6Bg1eRcGg-1
Received: by mail-qv1-f72.google.com with SMTP id t10-20020a0cd40a000000b00461c0375015so4806226qvh.0
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 09:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzEASw2XF8h0URz7BLtCcvA5dhn1aysC2rhH4z0rEd0=;
        b=g0+Uortw8lF8mlt45UeCMBx0pYlgddV+8Vh+2I9GnGWAV8nxL33kQGF6w/+10xNe9Q
         s21PfIPnwPU/InIEcnDdxm0v5JNGGpnCoU81Ds9ivoLu0kklMiIeIJ448YE+9uL8fktJ
         gwdMqkHCSIs11544KW5p2T0r32jRySUPctDB18Es8YTmRNVmVKHXgEOLDQ6Qxi8yJ1Xh
         7cyjXzFishxyk7qI0M0Q7YIo1ijKzDc1PfJaUiuXq3Y6SAVG5AAAzyc/auzx/dvU89vo
         LHu1czpvVhU1sPbfy1RWQECWjjG+wxZRwRvfSH4Pvm+/JUeMu0CKmjOaCxeufEIfJtUO
         dntw==
X-Gm-Message-State: AOAM530n/TkwD3tNXJdwqH08sRHYbcEZxb4NUt9mNmvMKmeWSpB3U0Cd
        NDshJQ/dDdxCkDzJZGti+dESVipSJVDKGoYFEfgAsxMzCAcjel92AJXAHrmZLJJyoCQiUXOtX40
        kdxrVSZN5fsQTww8erob0ZRc=
X-Received: by 2002:a05:622a:283:b0:2f3:f50f:9f4f with SMTP id z3-20020a05622a028300b002f3f50f9f4fmr4610698qtw.648.1652979256526;
        Thu, 19 May 2022 09:54:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3vXwH7z++fNNxFBomDJMCfgBV/hLy80U24vPIudufOoLOD4mWkZxqt9RFshqp+sfO7pV43g==
X-Received: by 2002:a05:622a:283:b0:2f3:f50f:9f4f with SMTP id z3-20020a05622a028300b002f3f50f9f4fmr4610683qtw.648.1652979256307;
        Thu, 19 May 2022 09:54:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 139-20020a370591000000b0069fc13ce24fsm1555408qkf.128.2022.05.19.09.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:54:15 -0700 (PDT)
Date:   Fri, 20 May 2022 00:54:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220519165406.ig2cgqiqnagt4ogu@zlang-mailbox>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
 <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
 <YoZq7/lr8hvcs9T3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZq7/lr8hvcs9T3@casper.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 05:06:07PM +0100, Matthew Wilcox wrote:
> On Thu, May 19, 2022 at 11:44:19PM +0800, Zorro Lang wrote:
> > On Thu, May 19, 2022 at 03:58:31PM +0100, Matthew Wilcox wrote:
> > > On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> > > > Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> > > > downstream testers maintain their own "testing data/config", likes exclude
> > > > list, failed ratio, known failures etc. I think they're not suitable to be
> > > > fixed in the mainline fstests.
> > > 
> > > This assumes a certain level of expertise, which is a barrier to entry.
> > > 
> > > For someone who wants to check "Did my patch to filesystem Y that I have
> > > never touched before break anything?", having non-deterministic tests
> > > run by default is bad.
> > > 
> > > As an example, run xfstests against jfs.  Hundreds of failures, including
> > > some very scary-looking assertion failures from the page allocator.
> > > They're (mostly) harmless in fact, just being a memory leak, but it
> > > makes xfstests useless for this scenario.
> > > 
> > > Even for well-maintained filesystems like xfs which is regularly tested,
> > > I expect generic/270 and a few others to fail.  They just do, and they're
> > > not an indication that *I* broke anything.
> > > 
> > > By all means, we want to keep tests around which have failures, but
> > > they need to be restricted to people who have a level of expertise and
> > > interest in fixing long-standing problems, not people who are looking
> > > for regressions.
> > 
> > It's hard to make sure if a failure is a regression, if someone only run
> > the test once. The testers need some experience, at least need some
> > history test data.
> > 
> > If a tester find a case has 10% chance fail on his system, to make sure
> > it's a regression or not, if he doesn't have history test data, at least
> > he need to do the same test more times on old kernel version with his
> > system. If it never fail on old kernel version, but can fail on new kernel.
> > Then we suspect it's a regression.
> > 
> > Even if the tester isn't an expert of the fs he's testing, he can report
> > this issue to that fs experts, to get more checking. For downstream kernel,
> > he has to report to the maintainers of downstream, or check by himself.
> > If a case pass on upstream, but fail on downstream, it might mean there's
> > a patchset on upstream can be backported.
> > 
> > So, anyway, the testers need their own "experience" (include testing history
> > data, known issue, etc) to judge if a failure is a suspected regression, or
> > a known issue of downstream which hasn't been fixed (by backport).
> > 
> > That's my personal perspective :)
> 
> Right, but that's the personal perspective of an expert tester.  I don't
> particularly want to build that expertise myself; I want to write patches
> which touch dozens of filesystems, and I want to be able to smoke-test
> those patches.  Maybe xfstests or kdevops doesn't want to solve that

I think it's hard to judge which cases are smoke-test cases commonly, especially
you hope they should all pass if no real bugs. If for "all filesystems", I have to
recomment some simple cases of fsx and fsstress only... Even if we can add
a group name as 'smoke', and mark all stable and simple enough test cases
as 'smoke', but I still can't be sure './check -g smoke' will test pass for
your all filesystems testing with random system environment :)

Thanks,
Zorro

> problem, but that would seem like a waste of other peoples time.
> 

