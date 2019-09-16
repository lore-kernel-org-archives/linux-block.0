Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53DC49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE57214D9
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l21eG8ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfIPQRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:17:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44317 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIPQRu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 12:17:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so258339pgl.11
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sg+rKbrnTJbgR+NJ8QZZaCm04HUmVdI27xNUqxqbc1I=;
        b=l21eG8ve4kGqoaP/uEZGS+srtJoVlzN8Aw0HF+n2pNPOXrRYFEPElZY2miEwEA9Hjd
         qOtr4Mj5hslg2qnanka7RFbRLUwnvKM7RsykdxKan/SsQaHmFW8R8D4534utgMumdCg0
         clnVrMGMNSQnKZBk+MAedYp13IKZhZhBUZ+9F+wLiihY6PS1m1uTKcKgw79kRmnfo1WS
         RzgrZu7Vy/gpqlenhiTU1d9jpTqqGQIFnL9TCikoCIougst1B5/uT1cZZVHprTkwyYXT
         av6KAyHt5Q/Gf98CN074DOlHxTlRBKUXR4HaVxmXlDQGDbU+lSPKgS73MgziTO/Btn+U
         XSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sg+rKbrnTJbgR+NJ8QZZaCm04HUmVdI27xNUqxqbc1I=;
        b=rdoHaK8P9O/7289vprEVP3J1tjmcBEttLHlHT1buMEQob0PC46/nO/enPQbzjmCfwk
         PcQ/QYCakyaGmAWAHefSgxc8+s1ZqzJ4iYV25T2AchttXT61c/L7vupyzkq/tcpG6qgR
         Dm8S6VmJ+ji7HsqP4hN+Q1lVCqhiD8F3p077eVys2ThcppCaICaMV+dEZrjmdm5CB4MX
         Ct5NMXjjWsh5uCY+80kfL+uzuL/Tb1UmMIEq9qtstVt6/vszEvDUo1nLu68M5YZNw5gF
         GguZgFmqzET4GYqeshq9yjdkAaS8CwxrxwIMaiHK20SGWjxELzmBuL+pYTA7e1eAEnO7
         4+ig==
X-Gm-Message-State: APjAAAWBeGR76gdAZvMD59ddUUjlak95Nqq4uz9OXUfrPGD67qe5zCPd
        LkgMLmLNd0ZL2epbdPTLxe1S0g==
X-Google-Smtp-Source: APXvYqyHwegb6ytoRKzWCa3UbHRvPgC8rPKLgmGGxsEIjFPXHQjLiqKa158WRJvNEqeL+kix0Bz9Kg==
X-Received: by 2002:a63:ed12:: with SMTP id d18mr5893619pgi.211.1568650669880;
        Mon, 16 Sep 2019 09:17:49 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:c484:c1a1:f495:ecae? ([2605:e000:100e:83a1:c484:c1a1:f495:ecae])
        by smtp.gmail.com with ESMTPSA id ep10sm1099575pjb.2.2019.09.16.09.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:17:49 -0700 (PDT)
Subject: Re: [PATCH 0/4] block, bfq: series of improvements and small fixes of
 the injection mechanism
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20190822152037.15413-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74a65657-a988-a1ce-04b1-93486c5fb08f@kernel.dk>
Date:   Mon, 16 Sep 2019 10:17:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/22/19 9:20 AM, Paolo Valente wrote:
> Hi Jens,
> this patch series makes the injection mechanism better at preserving
> control on I/O.

Applied, thanks.

-- 
Jens Axboe

