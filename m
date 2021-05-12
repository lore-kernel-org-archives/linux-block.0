Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0679C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98721613AA
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhELJs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhELJs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 05:48:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFDC06174A
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 02:47:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w3so34073186ejc.4
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sv961MJyocNObPGcZa967XLagc7KlobuPCBUYNDEQvo=;
        b=xIOvEfAOy7t8SB+dFMOMRDVmUL/m6ixXM4m6TxkP4uzUmVfp2IIPBPyTl8YrmElxbX
         QAFyAea8LnhvGo0kdytldq5/dC1fCII0ocXGObB6fXysMIcHLueqcBmWNw9o1aMvMm/S
         E68bLKHOUj0Geap5G3MlovyTuTCUGcMUs0q8CuxBXH500GD5DPAe8LZguZqhe0ML96CP
         iiqV3ZrRkA4pAOj/baoMr3DEfD5ZXtSOAtb3loRmRxXDQOPnIrKXXeMUVUBvnXKyRZnX
         Oc06UhFG1b2CAX9zVCbLC691Iv8Po9CTcrWW+n+lM0f1bqM9/P3HkaTYGRjQEehDPbgj
         eYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sv961MJyocNObPGcZa967XLagc7KlobuPCBUYNDEQvo=;
        b=aBujMS3rS1Dz3F0VYi/MqlDAaLknzvMLkxPEzvoCUOxyTiXocVnay4xBau7Sy1cIGI
         y1/WcJm8ttatJgIt8VfbWX5vFenpkGuKT2JgZe6GbSpThwRPCT4KH60zmt0aCPf52aSk
         slRpxYmiT4OHrH+96M/R6wZwvGtm+TeJ/SIi3MgSUSO3CaUy7bc3xKAyXkeb3k6M86LA
         qeG9KFdEFu5tJIhsj5XXtm+EqGvyN6clFoIlI1RJUB+lE90mrST8bhmmJJZdlSrhI3sF
         FqaPy0r5b2JIOUiw5PfVpNslwKEfkN1oyARuCMJSRx/50mDTwcH4UpDhOVVkY3+ZlGrt
         Dksw==
X-Gm-Message-State: AOAM530WuGA1gwXXq5KC1L0LdngiGSB4hCVda/TgvVVLwk94zAmhV8YY
        x/cFDp3xJOOBk1L8fl4tNjoVrrZRZqsTF6Yp
X-Google-Smtp-Source: ABdhPJyuzUgQJa4i7aUIDYkPuuUXGAkzqLoSi3I21f/iXc8hYGFWTCS2oi1FMNXFSiS1nJC6MOo3+g==
X-Received: by 2002:a17:906:d145:: with SMTP id br5mr35836821ejb.452.1620812839886;
        Wed, 12 May 2021 02:47:19 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id d25sm13572340ejd.59.2021.05.12.02.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 02:47:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: block, bfq: NULL pointer dereference in bfq_rq_pos_tree_lookup()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <abe6426476d4e87bd3977079380bc7c3f508328d.camel@gmx.de>
Date:   Wed, 12 May 2021 11:49:34 +0200
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB1E4403-5102-4D01-A8F6-2F12191F7761@linaro.org>
References: <8c38408d27f1032f2a664838e523376c5da09a80.camel@gmx.de>
 <9732EA9F-E15B-48E1-9B92-2D74F75C6331@linaro.org>
 <e0ece2e6349e92adc3da6d8c2ae6ff8a4172e4ad.camel@gmx.de>
 <abe6426476d4e87bd3977079380bc7c3f508328d.camel@gmx.de>
To:     Mike Galbraith <efault@gmx.de>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 8 mag 2021, alle ore 06:49, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Mon, 2021-05-03 at 14:41 +0200, Mike Galbraith wrote:
>> On Mon, 2021-05-03 at 11:52 +0200, Paolo Valente wrote:
>>> Hi Mike,
>>> I've waited a little bit before replying, because I've worked on a =
dev
>>> patch series, for debugging another crash. I'd like to use
>>> this series for your failure too, as the OOPS you report
>>> unfortunately does not ring any bell :(
>>>=20
>>> So, could you please try to apply this patch series?  If it doesn't
>>> apply, I'll rebase it.
>>=20
>> This bug isn't deterministic, but I can wedge your set into my devel
>> trees, and see if anything falls out.
>=20
> What fell out was not the least bit useful.  After days of box working
> just fine despite bug being given ample enticement, it didn't take the
> bait.  I then build master sans patch set, which exploded on its very
> first distro build, after which bug (snickered mightily and) went back
> to into hiding.
>=20

Not easy to debug this way :)

At any rate, I've just posted the fix contained in my debug patch =
series.

Thanks,
Paolo

> 	-Mike
>=20

