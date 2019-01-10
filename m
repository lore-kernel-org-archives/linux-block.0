Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F71C43612
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 03:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB594214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 03:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yukE8Hb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfAJDwF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:52:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35107 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfAJDwE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 22:52:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so4688188pfi.2
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 19:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2+vHvsEswnBkY4ZyVuy5c6Xn7Z/8KCLpBDXEtDWvuoQ=;
        b=yukE8Hb77/vOvyCa5t+8iZjNEN4SX2JS1JqfzY78tJZsjWoKLApP0ceHbhA25ZiZi9
         ulASRONcJufFuqnB58eEEmV5ljoSU2OOmE51Nnth2X/KRbn9lpqbyf7YaFVLVsPtNMwX
         fXErgaffChuleE0ED4jlG+B2Qa6d3RCdmKz7sij8SXt57p6jMJa+ZJ5FxPYBdHgrV4AX
         3ZcBbUl3G6/zEh4sm0a3SALZWEF0DdvD0Jb7SCu9AshNtaYPoSgElvDKR/gCCR9wPcuC
         9PABOfx9AMbepr5pZstyK1ek3TdOtMxKxgCnWmSKEyiIY5l0f3xYMDO6WWlNXRkmGfDs
         FBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2+vHvsEswnBkY4ZyVuy5c6Xn7Z/8KCLpBDXEtDWvuoQ=;
        b=CazBZKMk7r5kEPxL4RvBGV2FowW5hU8EHzO2+8Bkp6Q9by3n7idG6dNt7wHS+XzLgj
         ITKl4Z1T2g+yPcQRcLg+nRFj3kuneLLFVHPWLWQITd987ihpayHRCQeAdx7Co3AXUpTx
         69PsFDi2CXVauZFJK43BA8NcdPUptlU9dDRmjrJAI7tsBt7trXVO0W9HRKgxSDcTBXur
         Boxx5Z3VRmRaZoiMzIK6JmcFFpAGGLtCFy01RqRaGTegyVRkBAlRQ/XrtOATNR5w2sjX
         8RlBs6yIHuczQbOvSmcDHT7BhbmhveaWzUpqsE3fJPN8zO2LHGhSiCuIS9mwIEvU+xKW
         IcLQ==
X-Gm-Message-State: AJcUukehUzZBqgHcPOKrGR5s1Vj4eCwhCNSZb1qtIZ2fNA09oSToyqzK
        5DN5mTDwZHM/Cl1vpNTUSHrkIL6UId6D4A==
X-Google-Smtp-Source: ALg8bN52jy7kTjrMmLYZtuFA09WODumtBZsSpkm/3htgGNyhFuU5VKN612Kkh1zrHA46PPTgh/2Mew==
X-Received: by 2002:a63:101:: with SMTP id 1mr5724678pgb.152.1547092322428;
        Wed, 09 Jan 2019 19:52:02 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s130sm140726717pgc.60.2019.01.09.19.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 19:52:01 -0800 (PST)
Subject: Re: [PATCH] loop: drop caches if offset or block_size are changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-block@vger.kernel.org
References: <20190110031714.39000-1-jaegeuk@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
Date:   Wed, 9 Jan 2019 20:51:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110031714.39000-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 8:17 PM, Jaegeuk Kim wrote:
> If we don't drop caches used in old offset or block_size, we can get old data
> from new offset/block_size, which gives unexpected data to user.
> 
> For example, Martijn found a loopback bug in the below scenario.
> 1) LOOP_SET_FD loads first two pages on loop file
> 2) LOOP_SET_STATUS64 changes the offset on the loop file
> 3) mount is failed due to the cached pages having wrong superblock

Applied, thanks.


-- 
Jens Axboe

