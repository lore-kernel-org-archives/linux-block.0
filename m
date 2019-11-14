Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8114BC432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C87206D8
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RA7v7ikh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNOol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:44:41 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:38529 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKNOol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:44:41 -0500
Received: by mail-il1-f175.google.com with SMTP id u17so5551040ilq.5
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ADPstWN7XNqk2D3Z/6arxgDRYwL1lVKXj/5T7iJkTkw=;
        b=RA7v7ikhHyI5R001zRHpdNHi+xRAIHKJYoD0OyMKxYwQs63RcEkcfdgq5RaCHhI0RV
         PQmLrg5AbUUiXLg+jy376cg97inXPEZB3JvMbwrvFPPULe9bmTKpSnQCEdn1QLOYqIdT
         /3IS6HLQPUixTWjDfpzTTZ4QHiNDdsIq9NPUTPKdQbSbqd1kD32I9i/kPchg+T1RwNaX
         72zWDtFaGbkKgCM3v0aS4+VCtmGRu3zMK/xJFT8AAt8UZ9LOIUD564qmQ3SWtAeAYNp+
         EKdzIJ8uPPZFrGvDuRM207NYhCFM2dl8RWdj1lmIfXSq3R/iAQZpRY3BlenZoo7QUziF
         mGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ADPstWN7XNqk2D3Z/6arxgDRYwL1lVKXj/5T7iJkTkw=;
        b=VKk+5Ck9TKZcz37+cvYYi8FsWvpIkmRMn/6rfnoGDk+zhxiQeSJyOpBt2roNvAF3GV
         NRxdbDio0CpGb8dbtJ50fLkXvy/rYwmgIBSYY2V+20P2G9leVIjOVymSWVkMYpyKC8MO
         UI+w7kCmadewCIrUgxKyY8R/ApZRKyK0Dku2PPHXYLjc3jkt5t/AlXAXJgqooMRS+iOG
         BF75KgBmadXwHSTGZzVdZRZzvAdQ6suo6poIk3h/Ttq+FsJNb0CSjKRcX63sGgmFVzom
         qKb4pNwmzOZpYsNRZtjKDc4y9XM3x9mWKyZwXGJh6yrjDtvcW1FfIuuqccjWgZfp/GaB
         avHg==
X-Gm-Message-State: APjAAAWxpNd/7NToc2cdIBYUMT7UhMkUNaWk52KoRUZ51xLBi3cMjO3M
        jBIqaVKpjnsGqIERaKvMGZRqmg==
X-Google-Smtp-Source: APXvYqwL/ZYZ3r/XCkgmpVkdlTYTAXHO8wASbNOYcIDy3XlAGojjl6i+3UBjpw4hz0xQC0tPoXqgjQ==
X-Received: by 2002:a92:83d0:: with SMTP id p77mr10091426ilk.116.1573742680801;
        Thu, 14 Nov 2019 06:44:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c73sm763672ila.9.2019.11.14.06.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:44:39 -0800 (PST)
Subject: Re: disk revalidation cleanups and fixlets v2
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20191114143438.14681-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10175732-a3f0-510d-e423-f7f7072fef2b@kernel.dk>
Date:   Thu, 14 Nov 2019 07:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/19 7:34 AM, Christoph Hellwig wrote:
> Hi Jens and Jan,
> 
> this series takes the disk size change detection and revalidations
> from Jan a step further and fully integrate the code path for
> partitioned vs non-partitioned devices.  It also fixes up a few
> bits where we have unintentionally differing behavior.
> 
> Changes since v1:
>   - rebased on to of for-5.5/zoned
>   - fixed a commit message
>   - added two new trivial patches

Applied, thanks.

-- 
Jens Axboe

