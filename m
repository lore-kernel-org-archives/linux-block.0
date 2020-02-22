Return-Path: <SRS0=8cuF=4K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA48C35666
	for <linux-block@archiver.kernel.org>; Sat, 22 Feb 2020 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650FE20702
	for <linux-block@archiver.kernel.org>; Sat, 22 Feb 2020 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yXogiE0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBVRDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:03:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36677 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgBVRDE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Feb 2020 12:03:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id 185so2992997pfv.3
        for <linux-block@vger.kernel.org>; Sat, 22 Feb 2020 09:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kF8JhkX2HWh1Npv57QwkjDRzaCi9+na52tWfqhkE7eM=;
        b=yXogiE0SyCnqpPyHUdgH3qNUQvWA0UjkyFFsOx9WPdqvnhVYAnnOaCfjnIr6CRKj17
         q+hwkaEVuy/PdBYFtKgc04sb7fJxOn+7iC5jtO0nFyxJ3/KLyJYrWXQxzlukqS4GPvYm
         hBmQo4V2dWMdhSgi9JhcqIs9/vdNLlCfaW6AiR6XRs5Gu6twTl1pUmcwPU+3gM+F4n2P
         IRGDZj0M7u7hr3bfqxFtWa3m10v5RbwM757eyqqCGX1hrddvniCFLgdUYcF1jO1OYS69
         VfCrsrs8LX4+xgO2mpU/K9e23kRXvBU6CnFgegb3GMT7etXwZUmP2kZ2lgQQ047s/6EK
         4oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kF8JhkX2HWh1Npv57QwkjDRzaCi9+na52tWfqhkE7eM=;
        b=plGKjuynttvBq4cQfo/0ZdCxzwQ577xg5DTpJpCA4gmL4pevtXw1cG3ayGA7SHY1l2
         4tm2GKhV6GRtqnzSKdKhpSf79VWr6v3O8iZ7SIlCYvEDv9hkaMnpkPIt8sS1a5hkmkJD
         JAHU0JDC4ppA33vhrMrnCsWa56VZeF7lAQqG4BRf3UOeUAQSq5frNOKPI1XKmqURrcKn
         yvY8160JnCm6Gg2ChM/I0DhxMCwY2X2ZWUEiI45q90DdQG6pCAg275tHzllZtrSxYsPl
         btcp3k36YlMCtOLKfjhe9A8MohnATGqAfm4hYtSv5Ykayp69vnQ2rxLBoCp02F++XOSr
         P7LA==
X-Gm-Message-State: APjAAAWIjSP7kaRuuzhId4cXyJf24feajuC9Rr0G/sdZLQHbomUMTbpR
        zbjbrti/DrtK683qHKn8NbSe+ykiNzc=
X-Google-Smtp-Source: APXvYqz3z8jhhPJgEAtkVhG00ujd5ZNMyCTSyhh197A8gz3DCGS88xVF2YE5VX1RcQQIK+q6Y8D1pA==
X-Received: by 2002:a63:f757:: with SMTP id f23mr3341616pgk.223.1582390983939;
        Sat, 22 Feb 2020 09:03:03 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a99e:da38:67d8:36ae? ([2605:e000:100e:8c61:a99e:da38:67d8:36ae])
        by smtp.gmail.com with ESMTPSA id r3sm7045330pfg.145.2020.02.22.09.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 09:03:03 -0800 (PST)
Subject: Re: [GIT PULL] Block fixes for 5.6-rc3
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6afcdd61-2d0c-3059-4baf-4814c26c5885@kernel.dk>
Message-ID: <27c2d71a-948b-0333-8a81-bc7f8cedac0f@kernel.dk>
Date:   Sat, 22 Feb 2020 09:03:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6afcdd61-2d0c-3059-4baf-4814c26c5885@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/20 10:02 AM, Jens Axboe wrote:
> Hi Linus,
> 
> Just a set of NVMe fixes via Keith, please pull!
> 
> 
>   git://git.kernel.dk/linux-block.git block-5.6-2020-02-22

Forgot to push the tag, right pull URL is:

git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-22

-- 
Jens Axboe

