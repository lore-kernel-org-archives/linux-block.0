Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D972CC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 21:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A56207CD
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598047139;
	bh=Yuil3UoycPZpla9fCnlcXaKdoipDBblk7nWoyySP6q8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nqf17rN+plg/I4S74G/TNBM57V0tEEi54WQfmVbUjAlswDpJBV/LyYi24B4tA4UGs
	 da69GdqN4L17tqROCzBM98wFAFP+cRcPnM98PbrsjWWZsroQVulezqTuxffE4WWchs
	 m1mUqiI/ysmMttEeiTeBta9cDtHir/SLgoT3j/Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUV67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHUV66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 17:58:58 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77BC061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 14:58:58 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x64so682484lff.0
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42hqi9Ypg1RVsDIK89J1EK5FGUUq2YZJcxCoWPtUn7I=;
        b=X3m12EvjEp1qu/D+ml6Toava1BD6Sdii6Ap3bWyCYXbxxUctqvfuFWjjGPI1eLr/Bd
         aJLreMODLNfn3obhcl6bXe0ID6++mSSSONcZoBUrQ5i2SboyaQUOhCDW7IExJmVwT9sr
         HonVHhzIDfMOYN3Oh1GHO9+wuzovDa2QCkBgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42hqi9Ypg1RVsDIK89J1EK5FGUUq2YZJcxCoWPtUn7I=;
        b=fCUlrKUe2xtrbJwO6c+cFEzCaqaP8HW7xMH8ORH/OrqYNMn6KJET2nemsO7vmR0m1G
         FASKb31g2c2zsbAv+SQAcgzVDRs9Lk1caSWD/FsfGrEuf2PE2LR01a5IiUVRay6XPe0W
         IUY9Rb4n6nWopSlBfYZ3ujlfztC96yDmb8ZeZ0iMInMBPE3lbXL32f4CFpH2aOVLnG60
         Lau5/q/kcrv6d0qgkliacwCLdAOSw2xW+yoa8U3MTSuKA1lZe3jDS2bqerH/4B5ZRdDT
         ULGt6LXJWNtc/xFkRMJ4tVpj147pPRZa51Tnc/42+agAdrT6oZ+59QaZ7DskRWUp5jPK
         ohZw==
X-Gm-Message-State: AOAM5303NZJScZ0g0UVYSgOKqUHhlm+bnKtkrPwGhzEfBAF66+5Q9Tzd
        piXRWC6qy99qXnjlWT8AYeWWFR8YoWSlGQ==
X-Google-Smtp-Source: ABdhPJx/2Wq0q1/78qH6147qgN1vBgDeugbgBP/lPPkyAxdDuy/x8oZaNCkFYZpWED9xP2tkuTArhA==
X-Received: by 2002:a19:cc4c:: with SMTP id c73mr2295047lfg.60.1598047135946;
        Fri, 21 Aug 2020 14:58:55 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id e15sm632387ljn.49.2020.08.21.14.58.54
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 14:58:55 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w25so3413580ljo.12
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 14:58:54 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr2261791lju.102.1598047134601;
 Fri, 21 Aug 2020 14:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
In-Reply-To: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 14:58:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
Message-ID: <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 1:51 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
> Some general fixes, and a bit of late stragglers that missed -rc1 and
> really should have been there. Nothing major, though. I

Pulled, test-built, and unpulled.

This crap doesn't even compile cleanly.

It is printing out an 'int' using '%ld', so nobody could possibly have
compile-tested this.

And as I've said elsewhere - compile-testing doesn't mean "show it to
a compiler".

It means "look at what the compiler says" too. Otherwise it's not
compile-testing, it's just throwing it away.

So send me a properly tested and *MINIMAL* pull request. because I
will not take this crap, and I will not take anythign that *looks*&
like this crap.

Real fixes, and fixes ONLY.

                   Linus
