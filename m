Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E74C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 13:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6217360232
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 13:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhHRNYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhHRNYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 09:24:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55229C061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 06:24:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n12so1808668plf.4
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wG0Jsk1J07jpKpJSfxE2x1g+CeG4Hcc15pP5LaOetew=;
        b=iQwolJeKqd+VyevgcX3xE+f9wOK/AsPbqlKCg565RYfUuC95BhVQ1FR2TxcDdqWCJI
         gT1UoTFE8YrKBGnD7uzXD7LSFgg5vs3TueA3apeGEKi1UJi8EZKbOLP78mtTeKd938e/
         E5iJ0epPcPFA9ggyVj7aZL8zibzRrw3XcrQhKI65RJNbK8iPTWAptbEesJ5QdsNjwogc
         s7DtdNHStzH7YEEKey8CV5rHCI608ehPIwK+Qftqc4iqJkDlXvZQ6M8TyrmctMB3bWtk
         iLwrE6maxveUXwhc/8Edrca/YhrNveH92cI/W0DgGnsKwu0shZpIWBvwUSSlTT47LKsI
         yJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wG0Jsk1J07jpKpJSfxE2x1g+CeG4Hcc15pP5LaOetew=;
        b=Lemw/4/deacHc0qe1LJyWOpOwHxBgwMszM+8mtL4WvTk43QHR3j3CWxI+onnZ0NwV1
         2pw7iy7ptiqx5woDMG5UqXj/thhevHnJCODGGx6hXANOPvC+gMcTwaWBR/sguG9Qy5Io
         E8jZvQuWdbgwBhawbXglNNZcArQX2EIvW3tcx3/eqbUgKwQ693StwiQfTHEoAktlBiYi
         WgO1PbJI/wmP0GvNPJuNuSigIIXQBREMtdHtHsmbng30e4rdpTkL/cWGSStkHRzzDMe2
         GG1I5BgidEnYP1xm4G6fl0Q/BfPZ4BNWozKoWioNpx2aXQ5ItQziLQLg/YiWme9eWqUJ
         EVkA==
X-Gm-Message-State: AOAM5333b4Dn7mIl/hFv+5BAVMiBuVBOQyeQoUh2HELEJ01a2+u1Lweh
        B6GouUALWMtkeQatbUdWdnuIzQ==
X-Google-Smtp-Source: ABdhPJx6mkK1HEgeioEM+efuhhVDx/bR4NWxut/EUJTWBN8nm2olTPV1U1LosI3J3LSaVcNoI2m7lg==
X-Received: by 2002:a17:902:7c87:b029:12c:8f2d:4238 with SMTP id y7-20020a1709027c87b029012c8f2d4238mr7389520pll.50.1629293051791;
        Wed, 18 Aug 2021 06:24:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id ne3sm5428108pjb.51.2021.08.18.06.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 06:24:11 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] IO priority fixes and improvements
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e998936b-5452-1048-80f2-4161bb77b3de@kernel.dk>
Date:   Wed, 18 Aug 2021 07:24:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/21 9:36 PM, Damien Le Moal wrote:
> This series fixes problems with IO priority values handling and cleans
> up several macro names and code for clarity.

Applied for 5.15 - note that I dropped the lightnvm change from 6/6,
as it isn't strictly needed and lightnvm is deleted from the 5.15
drivers branch anyway.

-- 
Jens Axboe

