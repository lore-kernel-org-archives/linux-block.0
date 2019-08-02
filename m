Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB38AC433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 02:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A788E20840
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 02:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fEkUMSb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHBCx6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:53:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37843 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfHBCx5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 22:53:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so33069926plr.4
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BvkY4aVBVPfmgyNrK1xBM8Fg1dpebDjbELoJMy6SXxI=;
        b=fEkUMSb8f0VAD/xcGka5xQk7/E6jRDQogO9opCbYglQs6NjrKOX44pm2RKm+zwT1W4
         Mqvow+9ZBifiKM8Bhf4C2nAVjnTcvkJIldn+kS5xB3NVmk5dGX++Bcr87eLoX0L1kdY4
         hmNwPudcy8RJlOL+HDls7F+LHPUB84lhlq4edLEVljT8UyPFE2p46H63IiD+LZj70ZxQ
         A2G/tonzfkrMXh9QYsx5TWYHDcz9QrLqibOfR6qAWA8O4om8CYrBPBL2jVzxRX+Z6Wzy
         chtYca2cRhes4z2MK5kKL7JUi00FDWFvcjAi/bgpO6Exv2DUhZcxUELO7ikwGTT5tLL4
         rfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BvkY4aVBVPfmgyNrK1xBM8Fg1dpebDjbELoJMy6SXxI=;
        b=ti460CU9//7P+KCUveocp68KSADtOhfxkcLQSfwe1RTyTQHkyDOF6XwSgaPBquZkNz
         Fw2RNZQqD5NE00BjZMOaEXCp48IQ99MzEWzVGuh3b11jL9fDoi91PHHKhv+O3y6t/B2i
         FBvMurHxAXn9bMqG7amwSZ3n5QyXkrStKSoG3OKNJkoRikBYMBNfss8KoDQUQcqc39gv
         9NINkhzg6TqH1mp1WST2A1MKHOaMg5nea3qi6PJ5Zl/oMmbalhvynxwSS8XDqcDw+sZT
         B4X0jxPoCzoJHqvdYeUTybBSn4u2NCJ2Sia8qVViUcjphvGpZ/po6QvQYuDAIpNWS2+O
         OKLQ==
X-Gm-Message-State: APjAAAWA0/WNmikH8jx0UYR2I6Ip6/dmB/Cty/8kW9kutxAvyivJvTsH
        depvS5SrRcYQMWsXQdjfybQ=
X-Google-Smtp-Source: APXvYqy8GNhUeLTLw/HJEURnHibq3O3UhDOV9vTMK2iJwmC7Cez4RItwvtxsxOo4Vsu7fmErZFtYVg==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr128929986plm.199.1564714074979;
        Thu, 01 Aug 2019 19:47:54 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id p2sm100756471pfb.118.2019.08.01.19.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 19:47:53 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390/dasd: fix endless loop after read unit address
 configuration
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, gor@linux.ibm.com
References: <20190801110630.82432-1-sth@linux.ibm.com>
 <20190801110630.82432-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20c4971d-68cd-b4d0-fb40-deef771602b1@kernel.dk>
Date:   Thu, 1 Aug 2019 20:47:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801110630.82432-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 5:06 AM, Stefan Haberland wrote:
> After getting a storage server event that causes the DASD device driver
> to update its unit address configuration during a device shutdown there is
> the possibility of an endless loop in the device driver.
> 
> In the system log there will be ongoing DASD error messages with RC: -19.
> 
> The reason is that the loop starting the ruac request only terminates when
> the retry counter is decreased to 0. But in the sleep_on function there are
> early exit paths that do not decrease the retry counter.
> 
> Prevent an endless loop by handling those cases separately.
> 
> Remove the unnecessary do..while loop since the sleep_on function takes
> care of retries by itself.

Applied for 5.3, thanks.

-- 
Jens Axboe

