Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30761C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0554F613AB
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 15:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhGBPez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGBPez (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 11:34:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BDC061762
        for <linux-block@vger.kernel.org>; Fri,  2 Jul 2021 08:32:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r20so7136376oic.2
        for <linux-block@vger.kernel.org>; Fri, 02 Jul 2021 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p1KKwjIwJuRlfgq9IyIhK/wDuJEbYDzojPvG5ko7oVg=;
        b=cMrk3iOVQPDxqLEtjt6/N+W0xkpV4O4IZj4isQAHqvgfMuoZjyt/U470UrYuEnDWU5
         epE01VFIKdyhYyRS+I4T0sgb1xw1USOjOPxTn+QHpkjecCpEOE7ogv54d79cjOQf1L3O
         VMIKQtscNKMUEbsvePe08XTjSI6SNrpjM4l9SzCHwKgIvtwD3NxPbLUs+u6imMN26aMq
         k2E+0tTSV36wrnonuqeylqXXeZURsO2bZxbHONembAuvRPmBOemvNXyMRHaXYMtlbsGw
         HDar4zdjsMsAM4brXLI3QkXEGNIz5Pbxg9tX2LbcQ5DPKzA9ajXfRyTBAb8+QioCawv4
         +/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p1KKwjIwJuRlfgq9IyIhK/wDuJEbYDzojPvG5ko7oVg=;
        b=LRQwdmz58pW9p/DcRD/8hBDEFgTWsfUlT5CggoLY23wANsXWGVOMU+5y9sh2j7TzGs
         P9hjMRtqdZn/WJwULUBWeB2KIsww4O2tNPpa8bOntM96YY7MN+rHqTyBKqJwaorD4rP5
         F2lx8inkmhycnzbCW9O/bEflj4XT7Ig/8PLWLxXIOcIB2YjDrAk1i0zqXI7M5M0OvbJo
         U2p95h+Tu0HEB0PGmERuUWZulqfgOoeAQut906eB4/2ZnWiihdu7ki7VfYp87DvpGaaR
         ah+q2JZI8Piddx085y360lRnE4X6tfGDNxQqiqS1lFF0EeXJhtwArxRU0DzUmKAt4D1m
         1r6A==
X-Gm-Message-State: AOAM530tGh/QTabzXhJSXtFL3C9fwL3t6UfwMywFuJi9V21zVi0qgVal
        VCwfWV64gMjSw9uEL0O3ik2rjwErUeYxtQ==
X-Google-Smtp-Source: ABdhPJxZZcUNL/XEQOe+55t8WLws2cez9otFwpJi8qowJZrwv45KKY6QxX59eagj5VufYAlVKGZLLg==
X-Received: by 2002:aca:b2c3:: with SMTP id b186mr127330oif.65.1625239941311;
        Fri, 02 Jul 2021 08:32:21 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id c14sm757640oic.50.2021.07.02.08.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 08:32:21 -0700 (PDT)
Subject: Re: [PATCH] loop: remove unused variable in loop_set_status()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
References: <20210702152714.7978-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <bb8c95b3-b062-131a-d963-5422a0e7933a@kernel.dk>
 <20210702153121.GA20689@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c089e4c-32d9-9e4f-2349-85b28feea8d4@kernel.dk>
Date:   Fri, 2 Jul 2021 09:32:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210702153121.GA20689@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/21 9:31 AM, Christoph Hellwig wrote:
> On Fri, Jul 02, 2021 at 09:29:26AM -0600, Jens Axboe wrote:
>> On 7/2/21 9:27 AM, Tetsuo Handa wrote:
>>> Commit 0384264ea8a39bd9 ("block: pass a gendisk to bdev_disk_changed")
>>> changed to pass lo->lo_disk instead of lo->lo_device.
>>
>> Applied, thanks.
> 
> FYI, I also sent a patch on June 25th for this..

Oops, looks like I missed that one.

-- 
Jens Axboe

