Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D952C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15B960187
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 16:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhA0Qf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhA0QfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:35:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786AC061574
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:34:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx1so1694815pjb.1
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LwOa5mhLaXrDlVZ7y1N0pASQsm7d4/OBObUTzGqDPgA=;
        b=s5UbS0im4j206cD2flPBaSsYXt7Pz5F1ruUNDn/hfmsDCYCK58dt5Wwbntnq5Q/0NW
         v99KEm9W3nga7/Gtx9aiPG0j947kF67B/xKEjVV9DGS+8IgtK21ExMGx88ceEpSUvFJd
         mnwM6RRfIGhAcrphnK1mTzVuDdrW30ydU+HNpjRj/5Zgivdh59BoUCUwBxIPFyGnERKk
         aB+4tFVzro/Oag8va0rMT4Dv8mVE4/9yAEaWDha9GmdxWsywxTSwoevJetL9b4/hCHD7
         ulB598fyJ+B4JOg0zwPaAboka8jpI5UiPyoWMOKyVxMnJ8zs1TDXaKp0A9bcrqm3g4mB
         Y/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LwOa5mhLaXrDlVZ7y1N0pASQsm7d4/OBObUTzGqDPgA=;
        b=I+Hr3AKdVOwpNTJ86s7Cdq9/kReIPOHIKFTWwPZvOuo69CDm+6Msr1OPQIoB0Yrj8v
         qWQ7GJzf6ycuNghzgv6cljzVtP2M1q8VS0U44qFYDOI9tP+dX92ztUbW86n7SuBBIceo
         jKFjaSDjTxtwukK0IjgKRWZycBysQgvzSZ69S5I5ZpolgVUcW5bBA1GBAOWUwVM6jZS1
         gle6sTQZlX5yP8QzaVDVMm4xecfJiTeZ2u5cljtatPujNaEMrFyLcLqPnorahuOuJsNA
         8/cTJ0lN2rFhmsk8zensw4P2g3qIVj/CYXG0apAKOBW0kdOdwsdW9vjzat2+7TgufMGI
         VC2g==
X-Gm-Message-State: AOAM532kAjkYV+Bfkk/iRd3WJHiyvAFKx0Yek7BK7DvB9Rd1LNi5jG2b
        uU5+TU8u2tsl35j7ECeTwvl+ZUmS1Lt2Qw==
X-Google-Smtp-Source: ABdhPJwu72vZw4Rvp6EbsllyTsc6G2fh9UxtX6o2Rj4y9aKcFm5WL6r+29C+hJadzIGoTT4ctEY9Ig==
X-Received: by 2002:a17:902:ba93:b029:e0:b6f:8a88 with SMTP id k19-20020a170902ba93b02900e00b6f8a88mr12198403pls.16.1611765269614;
        Wed, 27 Jan 2021 08:34:29 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id fy20sm2771517pjb.54.2021.01.27.08.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:34:28 -0800 (PST)
Subject: Re: [PATCH] zram: remove redundant NULL check
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1611739922-3365-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3536853-5b3e-2cfe-f7c3-1eac89326209@kernel.dk>
Date:   Wed, 27 Jan 2021 09:34:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611739922-3365-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 2:32 AM, Abaci Team wrote:
> Fix below warnings reported by coccicheck:
> ./drivers/block/zram/zram_drv.c:534:2-8: WARNING: NULL check before some
> freeing functions is not needed.

Already fixed/queued for 5.12:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.12/drivers&id=294ed6b9f00665acc22253044890257c5d9d18c1

-- 
Jens Axboe

