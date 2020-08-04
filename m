Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F135C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EFC22BED
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 21:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="QLPy+316"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgHDVDd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHDVDc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 17:03:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7047AC06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 14:03:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so3270938pjd.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9lOSfvVtzJUEAw8IQ4iZRkSXBEtwS/4UEQY0Pa8U78=;
        b=QLPy+316qH850JqpKpSL8sJjsxPFJ9j9Kijl0gy/bbo08yJoh9GYZuhuZ7mK3iJJRt
         JpccNv9zSNcQGexbzIAYPH5YcegHPoQDOHZqpGwePftq5iRgFxlPwWmXMvnmPCf+m/W3
         3tuOWukP42nqk+JlJXCVAhhwTzB7YdgYD6cvFM2dkcyfNzHXCGKmPTMrcddNUxAivaax
         Oknk/ofic9RzjSzCKOyw/bhdWz++M25Rlc1aXOkXp6+oy3XZc3JuqyBsoGbW24kKRIPn
         mwcEjbdsg5ft7XVuuz6tJxQQRz7X+SqAjPtDfJm4Qx3maSvO121uRBFuIFMCXVK6IjbG
         NV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9lOSfvVtzJUEAw8IQ4iZRkSXBEtwS/4UEQY0Pa8U78=;
        b=cTGdTFNKuw9OKMXd3z46UqbKV9c5atSJPnX3Z3iRO4NDyWfyBqSqVQ4FtyJWIbtA2P
         rHbzBTW467PaQNougvjMuKqUWBEcjRZezxxl4Clh1ugTwEav/j2elWn2TG0S1EkKALxI
         SyesRtdY94vh3tNAURTwktHyxlT3OG/sfw1zZF0y41mGYFgg82EIUtBP/b/0CBovEBTB
         aMH8QdSbbB5sA/67a7Dvc027eY0Ml1hzAGKTf44piAyJaXwcitANmYiJOrF9PWSwR+MF
         lJzBsdPxDVCPjU2TqQQPMAoUrka5SbEQdu+KVLeRQA8LWRRQoL94v+01w8nFBQSaQnzd
         g2sQ==
X-Gm-Message-State: AOAM533xApmthO+nhUzrTSW1i5/VL7CE9H/9I3awsrXTzOsNHAfpFv2m
        T9Nbj8LaMaCddWoKLZ5QvlFnuQ==
X-Google-Smtp-Source: ABdhPJxQCE9KTWDNvLCOoRin69FB+zqHo8YNZ1E/QRonlsacSYIdYh2B4K5A2EspkpJX43WV3COa6A==
X-Received: by 2002:a17:90a:ad4c:: with SMTP id w12mr32778pjv.129.1596575011868;
        Tue, 04 Aug 2020 14:03:31 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:1cba])
        by smtp.gmail.com with ESMTPSA id d24sm3195405pfq.72.2020.08.04.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:03:30 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:03:29 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 0/5] Support zone capacity
Message-ID: <20200804210329.GA7852@vader>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 07:14:47PM +0900, Shin'ichiro Kawasaki wrote:
> Kernel 5.9 zone descriptor interface adds the new zone capacity field defining
> the range of sectors usable within a zone. This patch series adds support for
> this new field. This series depends on recent changes in blkzone and fio to
> support zone capacity.
> 
> The first patch modifies the helper function _get_blkzone_report() to obtain
> zone capacity of the test target zones. Following three patches adjust test
> cases in zbd group for zone capacity. The last patch fixes a test condition
> issue found in this work.
> 
> Shin'ichiro Kawasaki (5):
>   zbd/rc: Support zone capacity report by blkzone
>   zbd/002: Check validity of zone capacity
>   zbd/004: Check zone boundary writes using zones without zone capacity
>     gap
>   zbd/005: Enable zonemode=zbd when zone capacity is less than zone size
>   zbd/002: Check write pointers only when zones have valid conditions
> 
>  tests/zbd/002 | 16 ++++++++++++++--
>  tests/zbd/004 |  6 +++++-
>  tests/zbd/005 | 11 ++++++++---
>  tests/zbd/rc  | 35 ++++++++++++++++++++++++++++++-----
>  4 files changed, 57 insertions(+), 11 deletions(-)

Thanks, applied!
