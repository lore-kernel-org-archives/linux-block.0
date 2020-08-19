Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD771C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90FBA2054F
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RK3qgkhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgHSNEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgHSNDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 09:03:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47882C061757
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 06:03:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nv17so860262pjb.3
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ejN3I2ZufYX6NBqQUqeno+sm8YT/7Lwa4+bx/+FXbdA=;
        b=RK3qgkhvRM2gvw0S8x5GDoJP8wGn2aiJDGRVphrf/MgMgy+YwgLX+dNT1C3wt6zrZg
         zmUjFjUiuQ2TuCyjfBnDEy/K637MzELUaKf3W+14o3gGTFR8bC3vfmcNycj2vODDJt5R
         02hxuPxiycQ3DqUe7rW4Rb/Dyv0/7NgOvf9Gww0kvS2mDoV9HeOcIRlcQ0cLS/hkF1oe
         AsZZczxpJZ5MQvzlRZ0O5Gfyii3+Eu7Ee5CTvtaHrbdFescaR+ZyDvaLIUlkNB9dRo56
         6xVVOHS9VdqXuXu1XcEQh35cyLIiipbGoV80IY2VS+QF+grdlkLFV8WzRLhohfzZ5Olv
         UCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejN3I2ZufYX6NBqQUqeno+sm8YT/7Lwa4+bx/+FXbdA=;
        b=Ox4pNVcMRvB4Ezy16fS+F/GZUucQfDywwnlhtAnfNYIDnksHutvhAPMvHovriE/I6d
         v4Bu08DcY9pM06+RQh+JDriMKYBxlbwFuzNChyo2/7l/zEx4FmHHnzQiT4HSz5iinymA
         r2OVMG00//fiUUQKUe+B9vkccdZDOFxtGxgHk/HVIz5stII4G4KHgfC/ZwJjVwrWxUE8
         s7J9ZCBJOP1vcyPxMlt3j+O5FNvsTnHx4iRl1VotD8KW3dJKGlK/ivKcjZxjgOA5HDhP
         BTmHQopSknUcbzOEI/sXGrCVXusArrb9ZVnFnwNLWFSLqTdq+8RCrHCxXdzxeKNYaVsC
         6iJA==
X-Gm-Message-State: AOAM530Pxg1n5xFmmIAmmVNK2P3hBqvDXfHCssz2ASDqt74PBf958GLZ
        4EvUSs7n2pydAq2LcSiVylTxVQ==
X-Google-Smtp-Source: ABdhPJzAxffViDj0kPIe6fi+J185UwCphUfnLI8xm2PJkJtQFETAiC9HfWQrFY9NWmRPeyH+Wm/7fA==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr4089822pjb.228.1597842218449;
        Wed, 19 Aug 2020 06:03:38 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x9sm28536071pff.145.2020.08.19.06.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:03:37 -0700 (PDT)
Subject: Re: [PATCH] block: Convert to use the preferred fallthrough macro
To:     Miaohe Lin <linmiaohe@huawei.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819085044.41887-1-linmiaohe@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <035265c0-29e5-059a-0625-ea27609fa38b@kernel.dk>
Date:   Wed, 19 Aug 2020 07:03:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819085044.41887-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/20 1:50 AM, Miaohe Lin wrote:
> Convert the uses of fallthrough comments to fallthrough macro.

Applied, thanks.

-- 
Jens Axboe

