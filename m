Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D6FC49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03BF2067B
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H+xaKl8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfIPPBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:01:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46461 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfIPPBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 11:01:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so575908plr.13
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VJiHjQXkSvCrS+jTckU1P35l9SFt5+c8OTQowivUijA=;
        b=H+xaKl8Ys5y/fCTmn5Ye6W5ZY+/Lx1ksn/Eck5AgznrbtXbtpcriOL+pW3Ll2+Ky1W
         740uwrAhbHkuTR4CrLeNOI+1iLKn5s+M5iWWvvTj175A2VEbgZ7UeiUMVzRIS0WvCC+o
         FVI6IDTMOLQi9roahi0STUL+wM+DuiFxFjgU7rkGY/7DSv3sZBNEsPqze/JARp4WdPia
         ravMYckT7RqUrUsaAPOCiHunSC1na1oo34gpqo3CmrF1NDfV8BsOoi5cLFC7FQmf3mXH
         wVcvJgKROzfr1sZ3xvToVYR819AGTi5UgkAd/nMTAsU3Wx1kkTawBt0RAoHNoSwoH9zL
         VjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJiHjQXkSvCrS+jTckU1P35l9SFt5+c8OTQowivUijA=;
        b=Ww/iYCqjTsrFFrfWGdQPNr7KvH1LTQIDXutTASzOuts7OWvK9/vp+Un73VARRUZ0am
         BE6OqsxDpy+bovzD5v5+qxklzY6X2QxXzp5mhgmOsaZ1Bqe/+UsmS9CEIiaynJUSzyH/
         o1vZ7rJIIC2E433Mhbv4x84pp0S8nsAlkT2S4CeAG9WqlgCXuRAFc5rV8us9D110gQUl
         vMFCTZ4gmQRCaq21mw6tcKhCNWvbSNQ0g4STNsj4tQw3RC7jcHrxeJVMssr28Dwjo/yB
         7OZBv36zyw+y6gSZltxVN3ciiwzK5yLlWStBxNr3gVUYS9Oda2Ec7YzkMQI0IBlwXt9j
         A+1A==
X-Gm-Message-State: APjAAAUeJXSLbx8N3xU4aGLDE1t7/ukT06PrA5l1zrf9nRoNwBS2o8Ew
        KXe1lipMPxzzyaqkLpXtYxgUmQ==
X-Google-Smtp-Source: APXvYqwqOxx+LkfRUIEtl6/qo7Mwj89aqZdsYS8/kvRGjv5mudVZGrwxTFl+fLZCohJra2JTTBPG6w==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr170765ply.313.1568646106203;
        Mon, 16 Sep 2019 08:01:46 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:30f3:8cde:93f5:74f2? ([2605:e000:100e:83a1:30f3:8cde:93f5:74f2])
        by smtp.gmail.com with ESMTPSA id c8sm9226193pfi.117.2019.09.16.08.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:01:45 -0700 (PDT)
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
Date:   Mon, 16 Sep 2019 09:01:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 8:56 AM, Paolo Valente wrote:
> News of this change?  Can we have it (or the solution with the
> symlinks if you prefer it) for 5.4?

Coordinate with Tejun and bundle the stuff we need into a series, we
can definitely put that in 5.4. I did send out the initial pull request
for block, but I've got a few things lined up for a secondary pull
later this week.

-- 
Jens Axboe

