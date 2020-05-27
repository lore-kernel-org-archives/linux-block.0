Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A322C433E1
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5995620873
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qmgUq0I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgE0LWI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 07:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgE0LWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 07:22:07 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABB9C061A0F
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 04:22:06 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t16so10016196plo.7
        for <linux-block@vger.kernel.org>; Wed, 27 May 2020 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7gJxdvCpfrIue0RzTQk7obMxzbW3P/jexa322JS6jTk=;
        b=qmgUq0I63dQ2fxzbhTuUO1HPoFuKTJDCCKA0uUwXHJ02CVggXfImEsCyjOw5g1M/B6
         7uy1TbpqSl35DbJJihbShNSfLZWbB5jnC1Q1PHaGWrWF6b3dqqaamxAu8bWXgvdpgeG/
         vGqr7Bh47yvhhjrMyN7G8WxeAZvNQTAkGbFMiMxL304wcD/RlC2ouNW9QkIfbjmT9NG6
         HNDCRMhO+sl+dvr3KX0ePD7uimis7UAIGumlrG7i2AhQ2gF6HpcMYe/fkUJBrA8y8l2f
         hl8lGM/7kjKwl/LsGgfh/4F/KON7ZiAbCb0V/K4votERrdvFnmbuwtmnVkXRCyro4/+p
         YcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7gJxdvCpfrIue0RzTQk7obMxzbW3P/jexa322JS6jTk=;
        b=GnoL1Iwg4RiRhttjqcrN71GB+VoxvK1jYyNG932v4yDhPiQZVnYCawjCw2h8Xyv+OO
         9jVkLdXBKAUhti0bE033A/hlZMAee7uNtMMKtaj0igMrQxcB65Prr5avtRvif5q2jO4D
         k9HO1mi1qH15HmMpynPHP4n8g1SZDFfLfQ5BInLhlvP5R/XrafFlwocbbojG1odd3fwr
         J44+267oGmKeYLdxBYMxJn/xxjJU1X1v1wGXtzpDQP5GHmHdKWwMNfbfVPWw2KmBSG6x
         9q6ucx1pzNkCLfTbOig5cT/t6RKQz/lDjjvYtBl5PuiQNE7f/U83AuAve9v4a+nTSWq0
         D4ag==
X-Gm-Message-State: AOAM5307KJbj5CO8rXPM3Iv4+NcfJePDIFf+Jx3MjYuB6ziM7CmnRExZ
        WygcOK91DujRJK49GtIMavuGMA==
X-Google-Smtp-Source: ABdhPJy6PZ//6S2JWbZAJxsDE8wE3cmlRBZk4jwdGJuMizvUypFmxI08dabu3vfsUXeWFY3+3DUfDA==
X-Received: by 2002:a17:902:d3d4:: with SMTP id w20mr5510652plb.3.1590578526110;
        Wed, 27 May 2020 04:22:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:2cc3:8599:f649:862c? ([2605:e000:100e:8c61:2cc3:8599:f649:862c])
        by smtp.gmail.com with ESMTPSA id a16sm2317879pjs.23.2020.05.27.04.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 04:22:05 -0700 (PDT)
Subject: Re: block I/O accounting improvements v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20200527052419.403583-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e807976c-4a6a-ac93-17b4-a6a7dfc438be@kernel.dk>
Date:   Wed, 27 May 2020 05:22:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/20 11:24 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> they series contains various improvement for block I/O accounting.  The
> first bunch of patches switch the bio based drivers to better accounting
> helpers compared to the current mess.  The end contains a fix and various
> performanc improvements.  Most of this comes from a series Konstantin
> sent a few weeks ago, rebased on changes that landed in your tree since
> and my change to always use the percpu version of the disk stats.

Applied, thanks.

-- 
Jens Axboe

