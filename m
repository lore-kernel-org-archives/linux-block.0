Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F37CC433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53369206C0
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uYjq6whv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIAW4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgIAW4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 18:56:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC8C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 15:56:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h2so1318313plr.0
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wdddzQ5ODBbxY93ddYlX64d9dvvfA9bkx38Bc7zOkeQ=;
        b=uYjq6whviW7disu4Vbxn29EcAQrFTo396f3kyvPnz4btgKnx5cdPG7PUWUp3LfvrwR
         9aG7JIi01IaysRUw0798gBgHKxj6fASv8SynERW+3LYeeaPjV92YeR4GAybOto1t8L2p
         P/NsA4SUhznuXjKWvlQKIgSANxtpwNGW5SRz8Rclr7pJP4jCLLktjls3sYBwpgVbz/me
         mNe5AUAOwzu8Jf2tSyrgLKyZtRo/nmeO00qzJS5RCj0Ov20vqo4IfYCegk5FVhPBt4O3
         PabY4PIHxj59PRHtmMBmGbgULsNLA2/gjzD1HpBpKFoqOIe6NOjYDkOpReRi8ZqjWSSR
         pDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wdddzQ5ODBbxY93ddYlX64d9dvvfA9bkx38Bc7zOkeQ=;
        b=UypdHhW9+juFZjIRS7kbmKDcbPoT3/Nec3Zb3TaHdeRx+1rIfbetWDyyqUUcbXI17+
         69qbA89tE8P5Y8dR12LUEiJrQ8rNrMzs3z9XHw7OVjfUvciUfOcI/x77auuF4SRt95E8
         Q9C85vN8w05RlEeoKWgu/YHMufXLPPz8kQBboQgzw63/ZDVXEOqHDNXxjXz2mH/B/a4c
         O86ZKdcDYO5CTKYMSk/tJ+OIiTgUtwqAJ/4cX+CQciGJsRzAzXmto9FVW0g6jFrnpley
         4uvs+ikpi7QW0VhvwsEgOZlUlLwh1Syhdf7Ghdw8uIS56N1wC6laSeslbpU+qODXtPJf
         2X7A==
X-Gm-Message-State: AOAM530UvKPLLBa7xggt8EypjEIdTolljADqIA99GLVKBLmwRXDYA7el
        uaD08EeRLG7konSQqJ1EOkGTYYgb3JGqN73A
X-Google-Smtp-Source: ABdhPJwX1TPWGfslrMA7Nls+06CcNQ7Qv+XSc9C7Ip0BvXuuzFVvaP0yhZog2Zwbe8a3KmKedhg5PQ==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr3611449pjv.108.1599001005910;
        Tue, 01 Sep 2020 15:56:45 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i1sm3103164pfo.212.2020.09.01.15.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:56:45 -0700 (PDT)
Subject: Re: Return BLK_STS_NOTSUPP and blk_status_t from
 blk_cloned_rq_check_limits()
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9610fd6a-9542-61f9-767b-5f3dbfad199c@kernel.dk>
Date:   Tue, 1 Sep 2020 16:56:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 2:17 PM, Ritika Srivastava wrote:
> Hi Jens,
> 
> I applied the following patches on 5.10 branch and there are only line number changes.
> 
> [PATCH 1/2] block: Return blk_status_t instead of errno codes
> [PATCH v4 2/2] block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
> 
> I am resending the patches applied on top of 5.10 branch.
> 
> $ git log --oneline --decorate -n 5
> 5749f24 (HEAD, for-5.10/block) block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
> bb79f6e block: Return blk_status_t instead of errno codes
> 9493111 (origin/for-5.10/block) block: remove the unused q argument to part_in_flight and part_in_flight_rw
> 8eeee76 block: remove the disk argument to delete_partition
> 7f201bc block: cleanup __alloc_disk_node

It failed for me again, but upon looking closer, it's actually b4 that
isn't pulling in patch #1. Hence #2 obviously fails. I've applied them
by hand, thanks.

-- 
Jens Axboe

