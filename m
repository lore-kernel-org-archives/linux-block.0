Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98473C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621A364DDC
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhA1OkF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhA1OkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:40:03 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D36FC061573
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:39:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id md11so3970827pjb.0
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=elXqOkdzl4udn8HSEe57l5ER6cuSOpRYBg1OVS6mG1Q=;
        b=AzDlByGtQ9HYrwj44yj35jkbRZYzpqbVroxCuEk2XV9JU+lQd+jLf0+jDfB+qlurmJ
         GJyP1+qZQ87No9skU1/wQ9TBdCpLuJaBOU4hjz/dfhnSHr1Znoh32kySWDze/CiCPTq+
         2xTS2FZzCwXH9RSLcHdrfdi3Sv5sRRYGqRgWIQekygRezpGBzYqIPJbJR15EmxSfTZat
         xyAB0uKyZSYm1Nh9sDsPiOBwXyZ0OfrCucC4tyzVzNFC7ccTIW/bnXF8y2c9m09w2YVQ
         KAlqk4ue267G19j6FDo+amEUNN+9d/9JYN3mLTCfGNB0rlTruMYmMcJGe864/fBQvMKz
         FCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=elXqOkdzl4udn8HSEe57l5ER6cuSOpRYBg1OVS6mG1Q=;
        b=Edev8EsQ8A3K89UJptzp3+zxpKcUBjTggp+nCPb73jfPYRktbmg8IKHrj1pARuCypT
         r5UZVp9g4gXpbm6SQm0THcHC2ZefOs9WdCvn2HGNXQxlUEd8RzDr5gC6MtRL9Z9lfx3N
         twKkbWGRJ4T2ncTJD8y5jVVd79w3YSdBwD3AwTMMZ0y5gnlOYZiGKd2JBRxjRG4SUqBr
         UeqB7sYSuZXhowaZHFqGs3N8OGLwFjIDv3vls3W4lRId9Pu5YwrAmsk3cGUjF9nxLlkG
         y1g36EnrKdOARHjwVMfXRmtB3+32/oJHmmNlTANrSMc3wUmB67EIEswFWapUI9nWUOvH
         gPcQ==
X-Gm-Message-State: AOAM532eX+EHgEErYBFd1qdeZQIZdyd+O371cVwuPRzYL4gyzV2aQfOJ
        ktXqfdRQB4zlRKKse9M4sPmMNmd2VEDeEw==
X-Google-Smtp-Source: ABdhPJwaUmvQvL5GSaAN7dilnZHUnYUVkP2D4Q1nXQTjXZzp//ZHOsLU4Gdw1DqHkjatkkamHRFd/w==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr11374115pjr.156.1611844762334;
        Thu, 28 Jan 2021 06:39:22 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j5sm5333519pjf.47.2021.01.28.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:39:21 -0800 (PST)
Subject: Re: [PATCH] block: fix bd_size_lock use
To:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org
References: <20210128063619.570177-1-damien.lemoal@wdc.com>
 <20210128143723.GB2043450@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fbbeb94-64ee-6a80-05ce-c919de390376@kernel.dk>
Date:   Thu, 28 Jan 2021 07:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128143723.GB2043450@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/21 7:37 AM, Christoph Hellwig wrote:
> On Thu, Jan 28, 2021 at 03:36:19PM +0900, Damien Le Moal wrote:
>> Some block device drivers, e.g. the skd driver, call set_capacity() with
>> IRQ disabled. This results in lockdep ito complain about inconsistent
>> lock states ("inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage")
>> because set_capacity takes a block device bd_size_lock using the
>> functions spin_lock() and spin_unlock(). Ensure a consistent locking
>> state by replacing these calls with spin_lock_irqsave() and
>> spin_lock_irqrestore(). The same applies to bdev_set_nr_sectors().
>> With this fix, all lockdep complaints are resolved.
> 
> I'd much rather fix the driver to not call set_capacity with irqs
> disabled..

Agree, but that might be a bit beyond 5.10 at this point..

-- 
Jens Axboe

