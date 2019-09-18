Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35564C4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077F521907
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z5UmmcvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfIRRUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:20:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46823 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfIRRUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 13:20:51 -0400
Received: by mail-io1-f66.google.com with SMTP id d17so897886ios.13
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cpj4iGHwAA/3x4db5t6dJPlXbtcL3fprc7a10Upb3q0=;
        b=Z5UmmcvMGbcNj/80yk8GW5DC+a8of4K2Zu12rX0lamnBsWGEagIo8m1OjQU64aYENj
         nBviFPshdW90u2mXJYlc5sgD4ikRZEN0W0t7BZS5iH4FbObxEv1jrtKzwFTDN/UZmZ5J
         aN9+G4R9rL+4YNBI7gkpW/jjdoqHofWOrFSG9OJAT6bCFHtKzaR+sCSVLoBtfe4RsRUk
         wEhtV8MabP8IJERIMo5wJAIxZhCDr430fpCGr6VnW139bjcdmnfz8dKvbdrLGXYS7zs9
         xoKkmu3rE5P7CH1sV9b930G49XGoxAm4W9uOYPw36dgNLOZ3DsbSyAcbFF2HEnCOC9ss
         YYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpj4iGHwAA/3x4db5t6dJPlXbtcL3fprc7a10Upb3q0=;
        b=e5n/BLBGu60LyWAnS1wm/4E8A3/xCXdSlVeFg6B0JjFTF+OxlKhxM+H4cuz7SutN5+
         zKAEDdNAXq6QDJb5r32ZsyqHr0xSNC3x+rn7OIb/Np/QhIs69I2VMayLuq8mDm2VYamd
         7AdMk6/2svjTRXxKdpjHabuAaqXIC5BdztFjQUzwt+7IpLqihiO1fs/PB1kySuuxyu08
         Dbmj3OFz826EtkOiMZEh1du+bPxOUvtta8Tsark2rljRIeqJ1uRLAFGpyprYMaktcAEw
         t1zk+KEnW2WNgbDm5bdLxF8EGbudR7mudQn+zaporqTiMS45J4R2jqEIsxFX8Ekrp539
         7ZKA==
X-Gm-Message-State: APjAAAUdwqS6clEsHzNxjkuZKCw+4pcuac+3JcI1RndEpd3oROZfthbw
        fgaMMkBlxfan/LhDb3duEhUHaykBT4/tAg==
X-Google-Smtp-Source: APXvYqyy4d1SQETkluMDQ3kUUga5UbHCQuej9l1hceAFv7y51sskjflwZyj+S673O2JZMCgtIIuskQ==
X-Received: by 2002:a5e:d50a:: with SMTP id e10mr6255472iom.273.1568827249956;
        Wed, 18 Sep 2019 10:20:49 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l186sm9765977ioa.54.2019.09.18.10.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:20:49 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix potential crash issue due to io_get_req
 failure
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1568798752-214257-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0411d3a3-ca89-f33a-c9b1-1362ba9f8716@kernel.dk>
Date:   Wed, 18 Sep 2019 11:20:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568798752-214257-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/18/19 3:25 AM, Jackie Liu wrote:
> Sometimes io_get_req will return a NUL, then we need to do the
> correct error handling, otherwise it will cause the kernel null
> pointer exception.

I think that'll only happen with error injection on allocation?
In any case, we should have this check. Applied, thanks.

-- 
Jens Axboe

