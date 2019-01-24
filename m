Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34906C282C5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5E721872
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aji2HZTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfAXSMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:12:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50494 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAXSME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:12:04 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so6495980iti.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eXN0LRzqspv6vq0pUgTA+E2S/83VMzMlMSNsZgfsw1c=;
        b=aji2HZTVRCm3TOphUaOfdXOTvEoYobfUSoL3nybtD50MeVZFZVWUtQHeWAcVz0YJsR
         96KzFwvxy1MPN/O5S6TjO6MoYAdV/y8wJBTcBRn5ixdMGOYedZWOiSEVf3F5rYjV8CnK
         2OgdsqTo6MhCDW6AaPYUv2RLBfws2wiV/qMhnSMd9M+gRnIJm/UBubH3V8+UlIJ4QYbL
         xwmB99ZGbQPJTCXzPHO/2MfsxX1ZfvoXpXemyTtFIOfXWnEhc80JHm/rxfXoEtxCTzDD
         5xkyFrTSNpytP7RDc3vpvdGZCvbXCt3KEIGFmC62xlji6vpYKuEqsv2Xphq7MmApJpP3
         mITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eXN0LRzqspv6vq0pUgTA+E2S/83VMzMlMSNsZgfsw1c=;
        b=SOqw4wShM9hWpMak8P5StB95oHyRumsjOqlt0505ymYf/BvZTrdr3cMwTD/XE0o/O7
         TMDjrDfd7heBsqKuuc6ZadPg6qZPp/BUSHGVmnXen3noS2CzU1WdDIhcyLYHUlO0fXi7
         EDrD9M0aJcQaxGijhAByYWOPZmwt2C3vO45FJShxOZcf2uEz/CMXQCrJVKX1QQq1ViUt
         Z5T37/KjgqMJmx8Igp1wM9wtdNnFMuDJ1BF0Wvlxrsle0I8RAW5lK3jlmD/CmtNFRy2o
         9C+SlizJ1HFkI6tHHY1HMazP3ygGi6j1/HQWBlTcMQWOSjshCyXZnJL52So8Bes3zAL8
         kSMA==
X-Gm-Message-State: AJcUuke76vMb59BoR4Y6xXg5PjQzfc6iUow5bxdGQe5t/lj6YKZdM9MU
        swrsyaAu/MBPS0Pl+/MI5+vM5KV8jQ4=
X-Google-Smtp-Source: ALg8bN7RhWWDGravsxvuUSIEc5DFKSHwB9DO+6XKgrkh/AUKmh6+kd01ny+Y9lfEoQPhWQh52hTEew==
X-Received: by 2002:a24:d203:: with SMTP id z3mr1814398itf.156.1548353523121;
        Thu, 24 Jan 2019 10:12:03 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id p198sm11197766itb.30.2019.01.24.10.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:12:02 -0800 (PST)
Subject: Re: [PATCH] uapi: fix ioctl documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20190124092014.28656-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c46dc11-8f7f-f39f-4e6f-8345eed519ee@kernel.dk>
Date:   Thu, 24 Jan 2019 11:12:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124092014.28656-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 2:20 AM, Damien Le Moal wrote:
> The description of the BLKGETNRZONES zoned block device ioctl was not
> added as a comment together with this ioctl definition in commit
> 65e4e3eee83d7 ("block: Introduce BLKGETNRZONES ioctl"). Add its
> description here.

Applied, thanks.

-- 
Jens Axboe

