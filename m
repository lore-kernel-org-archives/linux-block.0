Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FACEC10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DB8206A3
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NCQxT6yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfDVOUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:20:41 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:52557 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDVOUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 10:20:41 -0400
Received: by mail-it1-f180.google.com with SMTP id x132so18039819itf.2
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cwhcEj4eB0a9TMWvDIOsvP1F5w2eXks3djvHmn1f/WU=;
        b=NCQxT6yLJQFOBan9xlWVVsz9p0zqeB4kko4oHUtqFxMFu0qnxeUnIBPLhBKOmdwW+D
         iw+pdqI9u0Z/qu2wKOzRD0Z/XKLxaFtdkAptUoyZVWpgPt+nVkL/Lj2O3ht4kAn2otHF
         mx7vtfKUWNsvbtuRiPOM3/McAkjz/jD2HeWqj7EHE0fdMxTOsbxm9T1YUXlh21dz/bOA
         350Lz6iYTA3EXujBnH+XujuY/Ha9BXH4gngvE0CM48r0d3MdJkHpcldQnDX/K1Z51jRy
         bO8m1SWE/VZ5FEGO9SbdAb810gWAZESPjhEDJo0VMG4xqJRtkl8kFN8XUn0yLzQXWyrh
         tUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cwhcEj4eB0a9TMWvDIOsvP1F5w2eXks3djvHmn1f/WU=;
        b=Cm3Sd7JFHsP6qQaHG1LNMd/bqEc8ERfmafecaBTbQqNsZgd7oeZWt1+kr8Fc45cESs
         iBhN3XwgKXjlLSaUWCiqs0GZoZ+kVFKOPk5RKZIr9Y8MkEVqTf9rd/yetYS7KB9MfkVa
         sSRoTaykCdRArCZ0k+0qv7pGnyFattMM6pMmqM/RMgXOKzNrg0qtLJ3e++KX8RyQUOAs
         Dzjfrf3y2IWML1QiPVnwCOFwXDmj09OL0k+x+OQLyIqfGfGRCzGv42WcM+Dy2TIMJV5Q
         IWUqCpiYG5MhS6+HWUnPJvaRAXsk4VbzW7APBib+IfFLG6+/VrKHNbt5Parzl4yrXbxH
         TOVg==
X-Gm-Message-State: APjAAAUqjIa62eWdbqq1+XwrxAUEeLaJfobYMeoXiEZHGXlSBa/qd893
        OGbCgc/6iZAXyySaKVfP8CIUS2v2JnBzUQ==
X-Google-Smtp-Source: APXvYqyhtIWpe9obiLogZf+xlOzAdLYl5XyjlwiebiYxSIl1ezcQxpjf2j1SiCjPmXFJUEATPeYRcQ==
X-Received: by 2002:a24:65c8:: with SMTP id u191mr14424514itb.137.1555942840197;
        Mon, 22 Apr 2019 07:20:40 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z11sm4576074iom.73.2019.04.22.07.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:20:39 -0700 (PDT)
Subject: Re: [PATCH] brd: re-enable __GFP_HIGHMEM in brd_insert_page()
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20190422132321.100156-1-houtao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <19d700d6-f293-0c21-d75b-44cdae0513de@kernel.dk>
Date:   Mon, 22 Apr 2019 08:20:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422132321.100156-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 7:23 AM, Hou Tao wrote:
> __GFP_HIGHMEM is disabled if dax is enabled on brd, however
> dax support for brd has been removed since commit (7a862fbbdec6
> "brd: remove dax support"), so restore __GFP_HIGHMEM in
> brd_insert_page().

Applied, thanks.

-- 
Jens Axboe

