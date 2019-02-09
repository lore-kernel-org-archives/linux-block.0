Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA86AC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 14:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECBA20836
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Qazc3TwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfBIOTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 09:19:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42548 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBIOTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 09:19:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so2842185pga.9
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6z72CNgzBNY98q/tdpcO9UY9KN5I+PsQMf9tAqBLzUY=;
        b=Qazc3TwZlPVAYIEEegBEeIyxoWpHTpBpmyG4hMdsBz1cRq5i77HDxMzmfAHRE/ECeZ
         XhCpsYHcZPqOHVptMMSq6qFg86NVYDBsxrfinfKNDtW1iHnNc2nIZSvnqpts9rHI1I3w
         bKPWKX8LzFzlDzdmOguj0aXVSG/hT3zEBEkG9BRNdZ9LExlL9Jpf4qGb0i4YU64+on2z
         1Ru5HQHOdje3QBm0814EMcMrTXj0fplfCFUHiEMnrCdbrXHqAgQ448L/iTSZ1So2RXD/
         bXh1KMuzndnXAlwlcI4BiALIGEM5H1QLMcG4hj2+TSCDka/LGnovnCX0+Xx3rJcEbhKu
         kWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6z72CNgzBNY98q/tdpcO9UY9KN5I+PsQMf9tAqBLzUY=;
        b=qfjthLXG6DScaUUko0qgH5OQ6Og/XpWehEYqoDIx3hf+J+roctljSXFIetojRMIE7W
         JZTvRQNLfdDgX5LnN3Ye/1tWi2islWOFmZzqrj5HC1sBHapXa4hqoeEXk43nJC1LGO8Z
         JpzPlIb4r3snd52T/BjXAnxEM0rhT1ycAhEtK0oZGU1mdxEVh9kbvSR/m3tQE3tRPKKj
         uXXCYbo/l2qlfnioz8DKWvnwCN6MTthsWH1qCxdCKGBCUCZtVZSGKKL6+09xPnnz6J1q
         Phi6kcxxvRRpyvPTO2e8ik0u1ltuD2TO7shCyPWWSfYqibeeHl730FcVwLO6hPa1amGd
         9Arg==
X-Gm-Message-State: AHQUAuZEAPaB5LVHW8lJWEweVegZ9pQIu31CLKlQNqoHde5sFDQcysAf
        ngRNjls39e16U6lt4QcG2e129PUYmMUmvg==
X-Google-Smtp-Source: AHgI3Ibc5apd/AN0hn4TOS8xL/2OuuUOGSDd89vTwTgyAFPLlCAPFUOPmL6wxq1sWNbyLQPtc3zuPg==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr25105424pgi.217.1549721950917;
        Sat, 09 Feb 2019 06:19:10 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c9sm13321196pfc.92.2019.02.09.06.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 06:19:10 -0800 (PST)
Subject: Re: [PATCH 00/19] bcache patches for Linux v5.1
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20190209045311.15677-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07b04069-cf94-47c9-3778-3c1e56a4f364@kernel.dk>
Date:   Sat, 9 Feb 2019 07:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190209045311.15677-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 9:52 PM, Coly Li wrote:
> Hi Jens,
> 
> This is the bcache patch set for Linux v5.1 merge window.
> 
> In this series, we have 4 majour contributers for 19 changes,
> - Colin Ian King contributes a patch to improve indent format.
> - Danial Axtens fixes a bug by not caching DISCARD/TRIM bio onto cache
>   device, to avoid an oops in block layer code.
> - Junhui Tang contributes a fix which removes a bogus BUG_ON() panic
>   by stale and dirty keys.
> - I fixes a series of input overflow issues in bcache sysfs interface,
>   and export backing device uuid and name for user space tool. There
>   also is a patch to fix caching read ahead metadata issue for XFS.

Applied, thanks Coly.

-- 
Jens Axboe

