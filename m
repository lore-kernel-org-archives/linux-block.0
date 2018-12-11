Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566EEC6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AB42084C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lpV5JZ75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AB42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLKXTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:19:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46259 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXTc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:19:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so7620627ply.13
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 15:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GP7ZqagonEWPWHRcHBE/il5Ha+dVE6uvxO7MQumM4Z8=;
        b=lpV5JZ750K36SBb1sDh5+U3sXcUtyKL3uUTdPzmmHJ144J6aC81fShziaOJvGCRpGp
         PUDWhDd2P0+avxazGGmjB/kL0IrM1ffAhoILTXUJcV62gjuPAGu3IrxaS7ze/P6Qgsmh
         JGUY06RIDP8Yb2IpS6xhCTwduXfBQjd3tP3kOD1SgJ/I8s0HT3QPbg3TkLLH6TDBqsOj
         EHieV4aj+TntEPHGcRgT3i3ARvg0OPYeIHk63AsOA8/huGvzbFti/sRd6Cz9lwiHWh1h
         iMw6yuAM4dx0enHJZh0GTYgBfNUhW+24aVr4YdHqT69T9jE8eQunFykgwrqe5uARch6X
         8AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GP7ZqagonEWPWHRcHBE/il5Ha+dVE6uvxO7MQumM4Z8=;
        b=C6PnKDQAdwIP8/DqGrhTb+z+Pfi36uMZnNcbbHXPFdApcBx3gyUJwtAiI0JmPVOQGY
         Cu54E5gUpAZeQWMR7dnqd7yodo41opBiviOIQHjzBtgQ/0ORbyECjFlu65jwLe5jidfa
         HiIIqXd1Cn6uTIKlQ6NZjM3A6Z7oSJvsUPZ2iksRRWS3GfAyCOOhxx0CV+8j369IazYi
         5N79PT847Z9SlMaqCOoSvVfhVaweIpMW+zQmVwMRuU6YegYOGLaVIH4ciNxyPNCY+9BB
         8+LaLnXeeDuStcbpxFGFCsPui+t4/1izy8yQ0EjuC09QwhHPjDeEBik1gtLGdxcPRVz2
         AKmw==
X-Gm-Message-State: AA+aEWYdUnrfyvWv8vtw64/k1K2naV+tG/hu0XuT1u2mOsFciBfP2IVp
        3uv2c+wi7G0/N926ZU64DIgp1vZKGP2Hww==
X-Google-Smtp-Source: AFSGD/V0daLfC9mefaJaEFytfz8wCwwENcBwv+Ze3x/snsRvFyRC1QhnSaNljaySQ2HbW9BoSQFtCQ==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10mr16604064pls.303.1544570371268;
        Tue, 11 Dec 2018 15:19:31 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a18sm20532446pgj.30.2018.12.11.15.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:19:30 -0800 (PST)
Subject: Re: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
 <35b326a9-e428-7195-06ea-fc6c5d201ef1@kernel.dk>
 <BYAPR04MB58169F997AEC920DE8E3D022E7A60@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <511098e4-47fb-cd00-51f7-9892077a5485@kernel.dk>
Date:   Tue, 11 Dec 2018 16:19:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB58169F997AEC920DE8E3D022E7A60@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 3:55 PM, Damien Le Moal wrote:
> On 2018/12/11 22:44, Jens Axboe wrote:
>> On 12/11/18 5:08 AM, Shin'ichiro Kawasaki wrote:
>>> null_blk_zoned creation fails if the number of zones specified is equal to or is
>>> smaller than 64 due to a memory allocation failure in blk_alloc_zones(). With
>>> such a small number of zones, the required memory size for all zones descriptors
>>> fits in a single page, and the page order for alloc_pages_node() is zero. Allow
>>> this value in blk_alloc_zones() for the allocation to succeed.
>>
>> Looks good to me, this looks like 4.20 material.
> 
> Yes, this is a fix for commit bf5054569653 "block: Introduce
> blk_revalidate_disk_zones()" that was included in 4.20 merge window.

If only the patch already had a Fixes tag!

Queued up for 4.20.

-- 
Jens Axboe

