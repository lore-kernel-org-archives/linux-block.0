Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC317C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6078D208E7
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 12:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nA2WpLhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6078D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeLNM4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:56:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45931 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNM4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 07:56:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so2706380plm.12
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 04:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cM8zt69uA3qYyoUS6R3jtvDzEtIWKSVBqZKitx3vK5Q=;
        b=nA2WpLhTvtdpLqR149qIohwrg8U4ez0DEAExdfntHGHrZHK/sJ9p9aDGPp4K+At4ct
         EzY8fS8WxQZG2ZqG1q6c/XLM/Qcc1AEnqpDTs5XgY/nQoIB8joxpQ4byC9Xm0Iv5K8YK
         nAgC6WNpArS5+NcSx1jSA/4ui/2QIjM5SApMf9NEHywdKNBgbkYUIVmiPZiuseySuX2S
         p0RSR4+VCtHVhQhu5+QV3qoYW11vdwoVf2dYqMGXWJ9BopVDAj0+hm7UBEeoZgXdkZS/
         uNy8X06UjCBOra4vjTzaKawU43llychweXB4nWm1h+qUbe3O3pzQT3QxINKwMqbpKEIC
         7Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cM8zt69uA3qYyoUS6R3jtvDzEtIWKSVBqZKitx3vK5Q=;
        b=etHwz5O/6ITD6kRs1oUAeYc5krIcTfI7sdd9pZRRkduTT56AXqPrWl5RYr5cp1QeMb
         mvlFUzvNjDZq18eQg2DV7LSaWnngaysPJ/Hj8cpVJ6he7De0sqM12F9mlT1rOp9kLBXZ
         eEpjlvUS8Tjxli6fgwpyTLtqylxJI4M55TWkAbQSahjToN8QF4T1rHI2s/vZjsPZcPfB
         4MB/5naifR4922fDm+dzAGFuq+SrK3xK229vkLEay597Twh3svEQSHUuqsemu3DzcuJd
         1l+G21HBqcX0e+NmDznDEhShmquDYTEmzTT58rXPIfCOErTTmaIMSdgw3f+zRf2Mkhy6
         AI8g==
X-Gm-Message-State: AA+aEWaLZktneJcE4RTTElSIHo3jTa+zagT7pLctHaojOmARbaBX0F5Z
        clSa5CI7pDH2utVqXHSfxlMe7h0WqN+FJg==
X-Google-Smtp-Source: AFSGD/UhmF8+rgvdSZXekTz+Qguu+BJ6X7HD+aBuERscQt9ibuxyepwt/ymA7jDC5zYYgE1m+B4M9A==
X-Received: by 2002:a17:902:2867:: with SMTP id e94mr2824050plb.264.1544792202527;
        Fri, 14 Dec 2018 04:56:42 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b68sm8357508pfg.160.2018.12.14.04.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 04:56:41 -0800 (PST)
Subject: Re: [PATCH 0/2] block: support debugfs on rq_qos & wbt
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20181214113926.7451-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b672db2c-f42e-5d74-531d-3b540febfb84@kernel.dk>
Date:   Fri, 14 Dec 2018 05:56:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214113926.7451-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/18 4:39 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch provides support debugfs on rq_qos.
> 
> The 2nd patch exports blk-wbt's internal states via debugfs.

This is great! We do indeed badly need it, not just to diagnose
hangs, but also to get a better idea of what is going on. I've
got a wbt-trace script that I use, but this is easier for a quick
inspection.

-- 
Jens Axboe

