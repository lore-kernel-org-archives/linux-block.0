Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17020C3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D756F2073F
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 13:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o+0TO2k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfIDNAv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:00:51 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:43884 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDNAv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 09:00:51 -0400
Received: by mail-io1-f43.google.com with SMTP id u185so40145923iod.10
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kHvsYIPVyPrUtgXpVzAKmikiV88yaoyBN+SV18aGzfc=;
        b=o+0TO2k8SoJIAwfT9TRLi5C8byPw+7nvaqcYwe//baieUHhw5qm83ledVB/SjoRISi
         wSDkbN8Punu6GfZw4fS9hNjrmMAprZp7f+wNzZ5nVpIbpEEjXrX1V3PI5ax/As5jkk9l
         jsFM23M6x/vqubYu9FQUcz4Dg5GWWbT3sDl2IHjSdOvELeq6v2dhe9bExAbPmDLaxcgK
         GE2qema3nwelZ2WtfghharRGbklxGQxjzgRIG7qNmRFUDeAtaJmATCDnbzP4N3DARmRo
         +q9jlPRI9YCTEUA1UwVU2MFFnJLu35W4v/3tWihfIiQ8566gPdSkHR6R9RFEp62UveLl
         Tssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHvsYIPVyPrUtgXpVzAKmikiV88yaoyBN+SV18aGzfc=;
        b=f24JhaRRpWS85yXKQOOhw+WbPE1J/M7U7VqTqKKLh5suVqhPznqObKz79Nb3iN/6ze
         HsBAv8NILgUP6Xvgp6+uykk2/GEHuEQ0kKRp4JCIOxCnUQo88yBSa0xpD1OKjrJEaVPd
         1bJFMzsur3XjPIIryhq8acCqi/Mp6cUC+6vbyKvWYQ4BB+nTmDAEPnGMAaOGguXP9llx
         vCke4fNQKcw7hvZWmPRYILpunXk7gwphwafgwb3aLxSGu5pMvxwqFiqkOP9ygQOdC1YG
         2Xa4gc10NxVjVTNeOmlzR7Q+W+pmwDlse1VYeOTEwCJaCgFJtj1dOHjcO2TjUU0w/wfl
         HOYg==
X-Gm-Message-State: APjAAAVzw6G8LTdxplN92VcndztJKRX8vqYlXHzjZj4IlhpCS06MXule
        NsO8mYJqbBmpMvj9092Y87jzkAzd3bkAnQ==
X-Google-Smtp-Source: APXvYqyWF+7bVvowkNAZ+b7/sOOvaLn03RkgWOK2E18DVwlXndUmwpT8RGqc2PvD0B5p4bdk1HGwdA==
X-Received: by 2002:a6b:7e45:: with SMTP id k5mr43254533ioq.178.1567602050373;
        Wed, 04 Sep 2019 06:00:50 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s5sm17295423iol.88.2019.09.04.06.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 06:00:49 -0700 (PDT)
Subject: Re: [PATCH] paride/pf: need to set queue to NULL before put_disk
To:     zhengbin <zhengbin13@huawei.com>, tim@cyberelk.net,
        linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <1565686784-50375-1-git-send-email-zhengbin13@huawei.com>
 <1565686784-50375-2-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b830da4-eeae-f2cf-22e5-5fe706b23040@kernel.dk>
Date:   Wed, 4 Sep 2019 07:00:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565686784-50375-2-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/19 2:59 AM, zhengbin wrote:
> In pf_init_units, if blk_mq_init_sq_queue fails, need to set queue to
> NULL before put_disk, otherwise null-ptr-deref Read will occur.
> 
> put_disk
>    kobject_put
>      disk_release
>        blk_put_queue(disk->queue)

Thanks, applied.

-- 
Jens Axboe

