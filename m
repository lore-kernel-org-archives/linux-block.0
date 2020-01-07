Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B84AC33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3E62075A
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 04:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cjULPnN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgAGECD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:02:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43760 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgAGECD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 23:02:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so26823874pfo.10
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2020 20:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RR8e/NlvB7jdmN26lALy0C0cTtjRvEF3yevD6G7bV+Q=;
        b=cjULPnN2HmFli+pWTB2KJwN9dRs7aeOIjuh9ZpCy1SFdwBTBD2oyGz53iB7gTgrsOF
         4szQ/hp0VgYhPc2lcH5WOeCgBNSznmIQBLBlyk4eTUON5C+cQeAdbHWyhQfTuCQn3M5o
         UGUXhTfXNBlBNz4draN2NOONiW/5uiUaKOzoeiDPfFSm4LKMAJ9WtLLx/+EuVJZ/OmzM
         pUvakE/yVZCnh6Yoz3j/+fPgqKw84nIRepkzxCZlC3aEFimAx/aDOtJS9da1phvcitMZ
         RlvAl7Q75HraPVQnpPQyaHtSXBufHi+9e6pluijI6FgDsu56J9NEtobTeqffolMUZ8gq
         WuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RR8e/NlvB7jdmN26lALy0C0cTtjRvEF3yevD6G7bV+Q=;
        b=VO/43sw26/FfbrA2kYJwW+7mV/OFxaFxu43mRFIu6g7Shz8Cp4wEhFdUw/ygQiI1aR
         PI4EUAcUd/qYSaG3WiMqTkpsgvYhaa8IugiV0njhd8MigxgWBghKV8FpBEWhmY1EiSvZ
         fNGK2qHGLuE3Ac6zhS32qv02Dk88Pe03zAsAt9MKlZH1h2fbD6krdS7iJ5kBzWZG4PWV
         pGjjzXN0jhq8jqT4siJGLWPsICsZ2vQOMCKAjkhpF24KRV+jtJSF+ZmsII2gNFNeu3LU
         GEd8HPFU1tk7qF5LUPT3gGB7G5qRvs3K0d4FlqmErOPqVZwi/LBwxVzWvfoHekwhbH0c
         0UTw==
X-Gm-Message-State: APjAAAWQGbG8RAGw83GgMkDRH/+0zphJaSk49eSI2GSY9XQn8Z+6BlnM
        tqvZC/3GviRaH+1tCQ0cFsNcXg==
X-Google-Smtp-Source: APXvYqyIIJ9HWIbRPiInZT/nn71zThA0LiVv+zpElg5NW8xFu9mCKsnP3x62CUHZ2bZ3BRGNvrmP3w==
X-Received: by 2002:aa7:874a:: with SMTP id g10mr94017274pfo.205.1578369722826;
        Mon, 06 Jan 2020 20:02:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y7sm72626836pfb.139.2020.01.06.20.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 20:02:02 -0800 (PST)
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linux-block@vger.kernel.org, jens.axboe@oracle.com,
        namhyung@gmail.com, bharrosh@panasas.com,
        renxudong <renxudong1@huawei.com>
Cc:     Mingfangsen <mingfangsen@huawei.com>, zhengbin13@huawei.com,
        Guiyao <guiyao@huawei.com>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4175ce74-ec06-c1c4-4733-00f7dfe2d545@kernel.dk>
Date:   Mon, 6 Jan 2020 21:02:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/19 5:17 AM, Zhiqiang Liu wrote:
> From: renxudong <renxudong1@huawei.com>
> 
> Blk_rq_map_kern func is used to map kernel data to a request,
> in which kbuf par should be a valid kernel buffer. However,
> kbuf par is only checked whether it is null in blk_rq_map_kern func.
> 
> If users pass a non kernel address to blk_rq_map_kern func in the
> non-aligned scenario, the invalid kbuf will be set to bio->bi_private.
> When the request is completed, bio_copy_kern_endio_read will be called
> to copy data to the kernel address in bio->bi_private. If the bi_private
> is not a valid kernel address, the system will oops. In this case, we
> cannot judge whether the bio structure is damaged or the kernel address is
> invalid.
> 
> Here, we add kernel address validation by calling virt_addr_valid.

Applied, thanks.

-- 
Jens Axboe

