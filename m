Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731D6C433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 16:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A684207DE
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 16:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0AE+6gwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgIGQYH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729939AbgIGQYD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 12:24:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B9C061574
        for <linux-block@vger.kernel.org>; Mon,  7 Sep 2020 09:24:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m5so8234405pgj.9
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2020 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4YsnN1303DLyqvh22K/u/PKzYPbQQRqVlMMHZW3C9us=;
        b=0AE+6gwetZYIhZkP/Gn/AbnsMQFQJXBsA2WB6QCghlw0FcJWNQJA1qs4qh5J42bl1p
         pGhd6WQ/1r1vyg9aXGVG1TrnqpDlQ9tMVlDqMVGdNSLLfcvhuegRgHvXecypW09fh9n0
         suXHGxAfp93zhwMKmeTUPzS/Vm6nTDf9/hHhkvAIHzr9kLIMVmBifDJDrcZ4KiR4tHYy
         +N1xNNq7iFsQhL8RbxevbOYzrzsZKDwMIiHTwkCemNcV02Z6tzGqeS0Dt+bOsuzhX6Uz
         ptshVA0CiE1SnNMUyXI0mVCaHShXOnDZ7KeG3WF1/T8snIoDJwwEA0wn15P0EkchJCku
         9GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4YsnN1303DLyqvh22K/u/PKzYPbQQRqVlMMHZW3C9us=;
        b=ht7qt80m1ipfzJrpQOdmRiU5b+OQClxf9JAo4nt0jxJaPlL4DSzili8hH5yG1L2MGa
         C65hz2pcAFHGDIB2loM8epFP4nmjLgY5FNYeaP2FLgSY4F7S/SroEPSx127arRMKze4H
         a6BYU5+CAyhX+qQ+SLHV4OelQzBmxlgN+/VUyY0mWhLQt9O55xSgRH6HB8iWq+UUSNr5
         wNMJgrUQCuz4XeeKKuBlSz7/MYKHoIcE4iOPUcu6oaTSVBJQhR/kGu7euCMaZSItaPm+
         ozrfhPou8hlw3V3laeswuyHMbAT9AwwntFBrAflBPBchp3//EYUoxsV0lFUkkAfirB70
         SBYA==
X-Gm-Message-State: AOAM531ZxknbPGKCLPmwFhK8GsxSWHs1V1F9wzKUFXPZIr/G3+/wR+eL
        zneKR9gpOhz5gHxIkxA8q/rZAJpU9FUoBGLT
X-Google-Smtp-Source: ABdhPJyf5lAcbJjqkGAPLEJQb7OQRjLOQ1ubkkJGzJM97V4uSwDx153D5PuXUiROK9hbytjzCGMh2Q==
X-Received: by 2002:a62:6845:0:b029:13e:dcd:75bd with SMTP id d66-20020a6268450000b029013e0dcd75bdmr8381274pfc.12.1599495842666;
        Mon, 07 Sep 2020 09:24:02 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id nu14sm12450081pjb.19.2020.09.07.09.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:24:02 -0700 (PDT)
Subject: Re: [PATCH 0/2 v2] bdev: Avoid discarding buffers under a filesystem
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        yebin <yebin10@huawei.com>, Andreas Dilger <adilger@dilger.ca>
References: <20200904085852.5639-1-jack@suse.cz>
 <20200907103549.GA20428@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e287fe0-b963-0143-2a3f-617f32a67f76@kernel.dk>
Date:   Mon, 7 Sep 2020 10:24:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907103549.GA20428@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/20 4:35 AM, Jan Kara wrote:
> Hello!
> 
> On Fri 04-09-20 10:58:50, Jan Kara wrote:
>> this patch set fixes problems when buffer heads are discarded under a
>> live filesystem (which can lead to all sorts of issues like crashes in case
>> of ext4). Patch 1 drops some stale buffer invalidation code, patch 2
>> temporarily gets exclusive access to the block device for the duration of
>> buffer cache handling to avoid interfering with other exclusive bdev user.
>> The patch fixes the problems for me and pass xfstests for ext4.
>>
>> Changes since v1:
>> * Check for exclusive access to the bdev instead of for the presence of
>>   superblock
> 
> Jens, now that Christoph has reviewed the patches (thanks Christoph!), can
> you pick up the patches to your tree please? Thanks!

Yep, I applied them for 5.10. Thanks!

-- 
Jens Axboe

