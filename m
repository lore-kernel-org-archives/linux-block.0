Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575E7CA9EB0
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138512067D
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 14:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1htIFD4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfKCOxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 09:53:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45211 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCOxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 09:53:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so4373715pfn.12
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2019 06:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2fiagJc2+nOe6bfgem8yyIYi5HxzKXM2yzPhpurgz9c=;
        b=1htIFD4tzMjP0Pnsz9CCRD/m9C2ureDH5N+/CfXmrNwZXfT9Cr7sKlKTxGL0OyLtLx
         tdAfELiYNrsov1m4qT4voxo09gZIOjZ+By1ogHT/SrvbjzqQ4o3l6ljFYr/Lacw3YcXo
         906PDpK9g9/fxOLQdCHhnsCouUt1CYEkesJd8xIx9GyQj6dnp+GVqAvCqaaNee331P4C
         LK3/hHOGfur9ux2QLS3OeBncP2ZFL/YtA2b2vQ0UEV5HmXG3vXOq+nwzKRg2g4VuhHHt
         slgaRTPtWFQclW5YJh/xMefz1hbOngH6A9rd/UCBx8UsO9L2DEN0q72qfi0JzR4cEhnm
         P29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2fiagJc2+nOe6bfgem8yyIYi5HxzKXM2yzPhpurgz9c=;
        b=VIIoCXGCWvKmwwDGG8SMBFv4rDGDc0twOqPuuPpNwOiTAQ34lbYSa8pdWZ1Ba9tXw/
         47oKeFqIZ+IOY3zL0r3zet+S9DBSpLqdR+bEtuWD7Md6C89Z3RcRgC5ORtkToozrFJ+J
         lG141uP16wzDKVExfWlZdpJTxNk8KhUK4wj7WMHx3qBoZLeXzEG6o1jDO9b+6UNNNLv/
         lIn+rxGUAcneu5lNAJtk3nEwRVGbqn+YviSmZCBn/T8YzcxIACXjQA0IicO9MG46gfOQ
         p9q5NoxyJyhkKjfK6q5kpIsBIsOFubY6UuaPwrnCgftHHqcfOZI3f8yzdng2EtHdRtnY
         mwxg==
X-Gm-Message-State: APjAAAXhsR+mwYVdQYq4WxYTQejh5KztTe5WNpEAwq+VSbpPb7xltDy4
        GNvDt/dow2U28Nr9Jd1Pc7wu9yl4ZiF6iA==
X-Google-Smtp-Source: APXvYqxSf+6qep4EilA9SwtXRsdjlB3xzPsWr4Uh97n3js+htrK+JacY+THNgYBKeEqjiyS/cEiDrA==
X-Received: by 2002:a17:90a:32e5:: with SMTP id l92mr28132904pjb.40.1572792793406;
        Sun, 03 Nov 2019 06:53:13 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c69sm11033228pga.69.2019.11.03.06.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 06:53:12 -0800 (PST)
Subject: Re: [PATCH 0/2] bdev: Refresh bdev size for disks without
 partitioning
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20191021083132.5351-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdc9f71e-09ea-9a4c-08fd-d5b60263f11d@kernel.dk>
Date:   Sun, 3 Nov 2019 07:53:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021083132.5351-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 2:37 AM, Jan Kara wrote:
> Hello,
> 
> I've been debugging for quite a long time strange issues with encrypted DVDs
> not being readable on Linux (bko#194965). In the end I've tracked down the
> problem to the fact that block device size is not updated when the media is
> inserted in case the DVD device is already open. This is IMO a bug in block
> device code as the size gets properly update in case the device has partition
> scanning enabled.  The following series fixes the problem by refreshing disk
> size on each open even for devices with partition scanning disabled.

It's really confusing to have different behavior for partition vs whole device.
This series looks good to me, the size change code is really hard to follow.

I don't see any serious objections here, I'm going to queue this up for
5.4.

-- 
Jens Axboe

