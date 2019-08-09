Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BDC31E40
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879FF20B7C
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 13:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1e5gSlgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405948AbfHINjN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:39:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43570 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHINjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Aug 2019 09:39:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so46089338pfg.10
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2019 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4mLbV3+IIPFRVOOTtY625mFctKb4+0bNW5BuMGIIWco=;
        b=1e5gSlgswt/OZba0NZEBKx58NWnHk92juUT7wscb3N0Rn7EJOsIB0GEOdYQgdpIC+J
         T7cxxnelfY2WhaNmUJ7ZQ+CuJFbCOkOCKAgPZcEkCWfeF8UdVTDtwaXtn7GUHXSgMg8w
         wj5QTJPT3F8FI4r1wGRYmCnC2U8leefeHQhxuHrUxvr7kgGSuT9GmfeuCLDq7VkEIzil
         MEELbCP0ujfbcfhkuYXLe06gcw+IwnVLWZ9j035nw5vFzwLr9kczOLoKOsvTdf5qxLcg
         mEFlx/9MTGU9MibYMFErNgGgJDssaXL7BzlDp9oKUtsiHofKBPI0ZD+dM6bnaBvnma/8
         rKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4mLbV3+IIPFRVOOTtY625mFctKb4+0bNW5BuMGIIWco=;
        b=i8I+u2/Hof7TyFZ3vrX4cBMmrU3DZNQLoH66LYgBKM7tg6qM7xFG6Bqj5+UUmqB7rA
         QsfJUJyDkwgKcnsHlFUAOBcxumWIz6PrfgHJ9tptfmdQ4i1Nm7rmfGDiwxGelo1RJWcY
         ot36mKK//oTIyTeFaOAD9e35hjF2L7WO56Ycki7fLwoxdx7Qzs0QsCBOrshMpW8qkZBi
         JvV9QVz7UTyHnmvjJn//KPokGHyZwkEDGnIfebUVp3WM/lfqhMU17CsA0FOKgRr+QYoH
         CnuN5JJjD5kzpyo+HOt+WVLKlsyVkcYMkFHLtnrTp8V/ARzsc8QUL8MjxuyBdrckdbo4
         nBGQ==
X-Gm-Message-State: APjAAAWhoVEhI3MISQtl5MZTRZn6TeHHZSsWu4FVbUpJyQqcS8Om5Xaf
        k/MWyHaYUi5pMTIpqa50rIVTwvfNKIETpg==
X-Google-Smtp-Source: APXvYqxqHhwnZezreygykpD+dDVAUBdIBkf1MltaJ+uvBHcI3YkbW8v4U4AxcNIf9METEct77K9jnA==
X-Received: by 2002:aa7:9407:: with SMTP id x7mr22225946pfo.163.1565357951682;
        Fri, 09 Aug 2019 06:39:11 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:80e5:933f:36b7:b13c? ([2605:e000:100e:83a1:80e5:933f:36b7:b13c])
        by smtp.gmail.com with ESMTPSA id b16sm161676193pfo.54.2019.08.09.06.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:39:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/1] bcache fixes for Linux v5.3-rc4
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20190809061405.73653-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff3a984c-f9f9-de23-adcc-32a702c7c075@kernel.dk>
Date:   Fri, 9 Aug 2019 06:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809061405.73653-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/19 11:14 PM, Coly Li wrote:
> Hi Jens,
> 
> I have a bug report that is frequent happens in product environment,
> the problem was introduced in Linux v5.2, we should have the fix in
> in Linux v5.3.
> 
> I add the missing 'Fixes:' field for the patch in v2.
> 
> Thanks in advance for taking this.

Applied, thanks.

-- 
Jens Axboe

