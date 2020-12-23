Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0DC433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0168022D57
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 16:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLWQ02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 11:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLWQ01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 11:26:27 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BA0C06179C
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 08:25:47 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so10642250pfu.4
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FCNtsZYBFLDT8cP1bh+6isWEIlEdtCc9b+ja9RvHmTE=;
        b=PJAYCnEwqVQvC1oI3hhQpDH9apfycos6rpUuLunhJzxN0h2SvtM51UBhsD8V4PLCBs
         rDGxoPVyo/rA3WFHIwWoLbfD8UwmwOQE5uoZ8Ntx6YGLCvQxLxpH4boqLtWJ3zjQtmy/
         Qky+LtpGthhFPHywz3m/yYeXLolQjIfQ1LPvDNdEYO3CInEaYPoX/5uan+00i5x4Nb3t
         GBdGzBfkDyMGxtF6KYgByQW6j/tVziGi2ibr2qE2HIsZDaHEvckUgU/GPKjW3YQMkam6
         1L5KuBr4lhjVVtBmVQbFg+5z9tnYgIz3x/fmlLVYtD2/Jmnqn9foprfzhbyChc+oFF4C
         LaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FCNtsZYBFLDT8cP1bh+6isWEIlEdtCc9b+ja9RvHmTE=;
        b=l2v3bwbdego7GvEkbbZbILNAL9ZjmEPsYGUzNk59lV6XYzaf7DHJXyCgMUhmmHUf4/
         Rgtfb61HXKC+YFLsmzql0kjerHlCB/YD7Qmd+9pVCyvBUS18hKaEspspZ9Ba3xKwcSbu
         9tOjyJ4OEzzTt182TtjEeetCUlonYd/uF5/WI5y0gnO8MShNBPaOu1WWFFV9vNzsdvZ6
         HJRCvPuzGSPewjvgmrCbH6FqA47GB6TkBKAcarTyCDs2Zz1q9B9yk4ZIBUdEMPlR1zrl
         CV+eMpa7CWA6obwTLIm2lbmTZOLokN8MJzJzRdaaKu8r5m5KlYcOtTjvyLaCl+sI2VUr
         iGFQ==
X-Gm-Message-State: AOAM530dPQyVKKKb+R/0pbXRrwfsJrpDo1bD4NUQQtp4C4an96NedC/f
        9HrnrddqyF+Qtqkg+0WMGOBnMxhAnqYoEw==
X-Google-Smtp-Source: ABdhPJwTdNDn7R/hReho8BPBuUGavwmnVredKSMtoQo4DQXNkNRCEm9L73NLyFIYuRXNHF7qiU2IuQ==
X-Received: by 2002:a63:f512:: with SMTP id w18mr25104185pgh.154.1608740746859;
        Wed, 23 Dec 2020 08:25:46 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z2sm13717758pgl.49.2020.12.23.08.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 08:25:46 -0800 (PST)
Subject: Re: [PATCH 0/2] bcache second wave patches for Linux v5.11
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20201223150422.3966-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <566237e3-2086-e143-f9dc-c29edc6e8aba@kernel.dk>
Date:   Wed, 23 Dec 2020 09:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201223150422.3966-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/20 8:04 AM, Coly Li wrote:
> Hi Jens,
> 
> Here are the second wave patches for Linux v5.11. Especially the patch
> from Yi Li is a fix of a regression in this merge window.

Applied, thanks.

-- 
Jens Axboe

