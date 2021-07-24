Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16531C4338F
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84BA60E91
	for <linux-block@archiver.kernel.org>; Sat, 24 Jul 2021 16:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGXP0C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Jul 2021 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXP0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 11:26:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84DC061575
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 09:06:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l19so6721774pjz.0
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ef1QbYv2Z4GwpSSuoVAw1PT+hfS6KHdDDbOuJkIPzqY=;
        b=p09soylh4QDlMFNY43WitFUCCTCvkTeYCgmfr3gQigJiqxoD/kV7GqrlR1rSK3uPFD
         8kXtudhRivxuf4IJrj2iPA75ucVw4w7jCsqhYlEFUZ4Kp02VV9tmFNpU204JnrDD076j
         zL3fhXvFPUFRx8fUBYodix6r6gFUTB0BgB3r5mTpnBg1OYhT75JWSWhhX93C2WpryHUY
         9/j29yix7MS2f2P8VY0GlyygEimyW2hOZDF2axdXmt79xG9KJ2xuZ2OajY5seSnZ+r77
         ka0Ix9cdowVUDMWg5stW0U9DTy90jY7C4NHTju+y41Vcpb8g/FG9RWnScuT1U6HBYh6t
         aRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ef1QbYv2Z4GwpSSuoVAw1PT+hfS6KHdDDbOuJkIPzqY=;
        b=b29OUBz9Qt1moZuVl5GxFdPp2KaP8YZFW/pINsp87inBsNRCuWST8rxw1fEK3bShGg
         Ma7N42QaRke+yGHp4hGNi8m1jBPo9opo05nKjh5RtT62olvmP8tlh9FpMGImeAWTjpaQ
         Cu8+dQ1+2tXYAp1ALWx9WTe9KCGC4ieHH1V2FrXau+n5V32ucfUSXKngPnQLyrvjd0aK
         e3nqzNsNMh9sCssQDfvbE5blO3Jt58IBpu5dHAcQ/XqBChTy3qnXTRk2CQGG8i5KXICw
         YPFhk5YXKj3zt2D0N43CIAmWe3opPX8mKQhphQ/wSlcxyDrIm7U48rky/odxPfvz2Cqf
         mc8Q==
X-Gm-Message-State: AOAM53323MWpy5CWWFv2lMvefQ9UtrdHQNiuktLX7ToIqUM4zkwakEBJ
        OS+4/CMGXJ1yY9LPG0bDNnSKGw==
X-Google-Smtp-Source: ABdhPJzxeF4nm5dwJcfROSDmQcfrM6MKpYcIBqKF7Vo9n1/dekIapcugoZ1Muxbqb34bUFNWww0zFQ==
X-Received: by 2002:a63:e14c:: with SMTP id h12mr9974926pgk.431.1627142793682;
        Sat, 24 Jul 2021 09:06:33 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d22sm30478628pfl.201.2021.07.24.09.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 09:06:33 -0700 (PDT)
Subject: Re: fixes and cleanups for block_device refcounting v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210724071249.1284585-1-hch@lst.de>
 <20210724072223.GA2930@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <718272a2-de67-c849-7c6e-2232f8762b23@kernel.dk>
Date:   Sat, 24 Jul 2021 10:06:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210724072223.GA2930@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/24/21 1:22 AM, Christoph Hellwig wrote:
> On Sat, Jul 24, 2021 at 09:12:39AM +0200, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series fixes up a possible race with the block_device lookup
>> changes, and the finishes off the conversion to stop using the inode
>> refcount for block devices.
>>
>> Note that patch 1 is a 5.14 and -stable candidate.
> 
> Oh, and patch 7 is on its way to Linus via the btrfs tree.

Shall we get patch 1 queued up for next week, and then look at the rest
for the 5.15 block tree once the btrfs fix lands in mainline?

-- 
Jens Axboe

