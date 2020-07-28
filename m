Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6993FC433E3
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362FF206D8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SjJiTDuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgG1PNq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730767AbgG1PNY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE79C0619D8
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 08:13:24 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z6so21147890iow.6
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2020 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HOC0oXvIyvE6KttCDt/CbtN/HJvMFJl4oDpiBuHY7GI=;
        b=SjJiTDuOZHstMuwXfFYckHeUHNa0ICqOpro1jIfGeyfWiPj19s4EtgU714r7i7Xk42
         WCe5ViYANBL6RTJ5S/ak/0Q3Y0bPhvOq+CmTRlx3T6+czqGhvV6yJs5XAX75HJkdLZQN
         QBX/FjPje38PNFKgDKNCNc/1VpvSHCcrNugPg+jZ5XSiSFiHJzG+05nuJCLzhd4JP2oN
         bz/kbJSwcsB+aDZz+lfB2I5WHaEu3AXNmBk3IisKI7iHAeWgNzMKYIz/fSVSoimSkVZO
         +ENNFO+WKGwOw2lAmvR/k+5G3Zs3Ksl36+s5xzLQ11Fx+rFJYuN0kHZJtbr8UhEJdY22
         osgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOC0oXvIyvE6KttCDt/CbtN/HJvMFJl4oDpiBuHY7GI=;
        b=h0qcpCE1ZR3SFYdoefuJzzBJnxVnaOz9mB54iRC8F4iLSaA0lecTbfJvnTVnJHHoG1
         6/fAWRJB/WR7LC4sRyFL7iD8VYka4gT4nWfLE0dm6FsBcNnVhFpn+Sr4s/YGGG0UPUow
         G/IOVJBahvzXECe9EfU5SO2ReF66oWnP1e5XpeQANg5/kruoP02sv6x8aIk/9gAoYAkT
         sORDzMDBWAq9CfMSjYZKRrMslqYSXLOQdf/vgVsISnkXMK+rT8+9vuDb3kcn3TnXEiJP
         yhNB5Rsvr06COlefbvQlxPLIOHA4KPD7VInF+28YzV0wms4mCAu2Po7eomBKbu/FCOdy
         XD1w==
X-Gm-Message-State: AOAM531fKlsUZiB/+x7TYS+0lqHtpUx83Ba4v4W7kC1vmZ2Omj0TozMs
        CnTAYF+G5iXsnORMmX+ZptuZBg==
X-Google-Smtp-Source: ABdhPJxW+HHdsVIIX/Zc8qBmbj4X32if8/I8c+9DvSvEbcsttgQbGehT7VOxO/KNrM4ZDTIMjBvsYA==
X-Received: by 2002:a5d:9347:: with SMTP id i7mr29320069ioo.40.1595949203940;
        Tue, 28 Jul 2020 08:13:23 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm4135064ili.34.2020.07.28.08.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:13:23 -0700 (PDT)
Subject: Re: [PATCH 00/25] bcache patches for Linux v5.9
To:     Coly Li <colyli@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
References: <20200725120039.91071-1-colyli@suse.de>
 <bbc97069-6d8f-d8c5-35b1-d85ccb2566df@kernel.dk>
 <20200728121407.GA4403@infradead.org>
 <bcad941d-1505-5934-c0af-2530f8609591@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e799acb0-6494-dca8-9645-f44dc018dbeb@kernel.dk>
Date:   Tue, 28 Jul 2020 09:13:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bcad941d-1505-5934-c0af-2530f8609591@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/20 6:40 AM, Coly Li wrote:
> On 2020/7/28 20:14, Christoph Hellwig wrote:
>> On Sat, Jul 25, 2020 at 07:39:00AM -0600, Jens Axboe wrote:
>>>> Please take them for your Linux v5.9 block drivers branch.
>>>
>>> Thanks, applied.
>>
>> Can you please revert "cache: fix bio_{start,end}_io_acct with proper
>> device" again?  It really is a gross hack making things worse rather
>> than better.
>>
> 
> Hi Christoph and Jens,
> 
> My plan was to submit another fix to current fix. If you plan to revert
> the original fix, it is OK to me, just generate the patch on different
> code base.

That's fine, just do an incremental so we avoid having a revert.

-- 
Jens Axboe

