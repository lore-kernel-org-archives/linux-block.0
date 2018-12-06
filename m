Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F4C04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 02:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEDA214C1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 02:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a/2fi7aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEDA214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeLFCn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:43:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44784 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeLFCn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 21:43:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so11023909pls.11
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 18:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=awtN7Iu2uVgKnxeA042D8RB6Uszwiv/XyNHYSG1z+ME=;
        b=a/2fi7aTXnW1A2ASlvOBozZ7E1PJGijB9laFttugTIv4A+3GpJen2gN6fZx3WRj7f4
         3x9OChgQc7xVsRlP5svzFCisCZnT8Zgl9fQUCQLYQne2kqMgkTFINvNSrsjJHeTrv58R
         WiaBblCOnDgehlIVPBLp7C8Q13Cy2m0Q3oM7OhLu+Li7oFd0l0jV3kSqlpJEWGLUPb1/
         aNXRDYeicq1mhYhfyqLatqs1Aj9xmpZY4eGNc2Qky8NkK6NRYHLPBxpZiBkmQdWuovNM
         TXKgFBG+jAbWHp1hbrzBpzH4QCbpz1hdnp/rwqPYVNa4vyAbYccJElZU571Pj4TgNaeQ
         6NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=awtN7Iu2uVgKnxeA042D8RB6Uszwiv/XyNHYSG1z+ME=;
        b=M1uE87mru+TklZFMOK19YpopVcFa+Oqb2/SKB+P0a35ZVQQMuwJ4AtVBKiDfFq9JEz
         nWD6dO9A8TO++P1Rnt5mZv5pZaKpILCIuhdXEHGya8sEDNSrEz8G2/l0q2UlzEVzup1M
         wpbOsuWDSGZf7MHmOKFtqTvdLmYeng8YYdDwaHCFBvFXIqLG6cj07AHK6fIPHFZ895RC
         xUusFNTGNAlNNau7TwBtQE3ta/BGeJxnd2z+qUMluFftOyJCroDWLRO1qUtD5lBGdGb+
         n6lkiL4j1yhf7kb3WfUvtlMZeV6vC8uSbCqEkCKkpzDtiDR6oJ6Ync0u2D729blUbs/+
         YoTw==
X-Gm-Message-State: AA+aEWbVRMmaLK/pd4ssfV7gc+Vh0dxjxfPwY9LDArpoXSM8mx75yQIy
        GdFa+eA3I6ntZ/Oz13RYofcEPg==
X-Google-Smtp-Source: AFSGD/Xc75w81RQdAzS+YEJ//i8wG793NGYS/RzsjdaB1OB/2C+8+iV3Y5PwP8GoU8KBfTPBLCdVVg==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr27149121plp.34.1544064239036;
        Wed, 05 Dec 2018 18:43:59 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t3sm21280661pgv.31.2018.12.05.18.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 18:43:56 -0800 (PST)
Subject: Re: [PATCH v3 0/7] per-cpu in_flight counters for bio-based drivers
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d4f6fc4-5d17-294d-5d07-38a4b8a0c19c@kernel.dk>
Date:   Wed, 5 Dec 2018 19:43:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 1:24 PM, Mike Snitzer wrote:
> Hi,
> 
> This v3 adds "block: stop passing 'cpu' to all percpu stats methods"
> before switching over to percpu counters.

I gave this a shot, with the hope of being able to use it for blk-mq
as well. The tldr is that it's still slower than the tag iteration,
but that isn't a show stopper for a generic implementation. But
unfortunately it fails for queue size results, iostat just shows
0 for the average queue size.

-- 
Jens Axboe

