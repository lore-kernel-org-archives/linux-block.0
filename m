Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1890C3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 13:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3792186A
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FEGIAzyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfIDNEz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:04:55 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44107 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfIDNEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 09:04:54 -0400
Received: by mail-io1-f48.google.com with SMTP id j4so43949576iog.11
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9jyl31An5bKk7OjshhN+TO4dsZtYfXJnLAcTRvIesNw=;
        b=FEGIAzyfoYgaRMP/7N2DIKwM4fjVKOcUJwsC48nUi77PcNVr8FkyC4hQWSz9HlZ625
         u3qA9JVSUIqST7Mq47DlfABkiKH2DnSX3UE84JyCw6qor9d2DdA1veQzfPm1DLLw+zYo
         QrxH3TGQQTirJBNeE0bG5PzaQSmLR+iEd7JR+TK42Tqf5es2g2y+Yu7cjZFwR7GKSQ7R
         sSOWAVKoAJjltlFAPFjbwkEGzaydja5UjgvKrsUp1WwrkSbvO/NVxYkQRiOIz/IWPjuh
         EWUmJfDjKrSOUnDJSDP9VpaBNufEEVE3LsluSxHBo+bHFGQdSdYp/gljgeVsnrnf+0L6
         zKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jyl31An5bKk7OjshhN+TO4dsZtYfXJnLAcTRvIesNw=;
        b=nNEbsOOtxsrDkTzGQ+He8zRETy0xTm+SAa8JfWofwxauQ03hdbgqjvDV8ExSwA/bM3
         C70pC8dsawltbhCjaDh3DR7UEhVM/CwzZeAdw7/yHdGQJm5XUcgCwqbE/1ZkVZbK1iju
         zrAoeaCaYrUjQxeoQGoOxm/tV0ZXNT9w/laqe2gljcOJ5nsw2n589F9f+EkgDsD7hSC9
         jt5FxvIiFWwm+jojWvQYg4p/HadU950iWV7oTJ5kGebKtSu2oFHxqlUYA0m2CRXZP0uN
         uH7Nt1utueAlSzl29IQXCL9Ix8MQ1DB5Bkv6axodFh0V5TtlR2r6i7GY+xI2A37cGWad
         7r6A==
X-Gm-Message-State: APjAAAWiN36slRgg6MvP/M6B+YXSh7q8zSbhrqt5wqewVNOPodHReoz1
        wI/2A98haRvF83lf69sJqn9K7g==
X-Google-Smtp-Source: APXvYqwoT/gMGbjjkFqcfF4H1l6m64Hh+EbhywKVv62NUyQ2G/ku0JLr+dxpXmfy00JoMy8lguTsNg==
X-Received: by 2002:a6b:c38f:: with SMTP id t137mr1660970iof.137.1567602292603;
        Wed, 04 Sep 2019 06:04:52 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l19sm1105056iok.14.2019.09.04.06.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 06:04:51 -0700 (PDT)
Subject: Re: [PATCH] paride/pcd: need to check if cd->disk is null in
 pcd_detect
To:     zhengbin <zhengbin13@huawei.com>, tim@cyberelk.net,
        linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <1565695392-140970-1-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e8c479c-9c5f-6822-a9f3-9f73b1d1cea6@kernel.dk>
Date:   Wed, 4 Sep 2019 07:04:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565695392-140970-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/19 5:23 AM, zhengbin wrote:
> If alloc_disk fails in pcd_init_units, cd->disk & pi are empty, we need
> to check if cd->disk is null in pcd_detect.

Applied, thanks.

-- 
Jens Axboe

