Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94176C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CCE2078B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 21:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="18LQyLoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgGHVmi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVmi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 17:42:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513C9C061A0B
        for <linux-block@vger.kernel.org>; Wed,  8 Jul 2020 14:42:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so145571pjt.0
        for <linux-block@vger.kernel.org>; Wed, 08 Jul 2020 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDdlqqViKy4NCWMYpbRbkVG8WrQZL6OuDPANlMIK/JI=;
        b=18LQyLoTvbAC6GnFTcC6drJgLAXGofZzdiN1mbx2ijUEH3DQWigQ64u0JpQJPOMEBT
         eumfGnUTryqlWU5Uwm0nweGFiTB3BrRTxALHN20vcmzaI4EY0vDbBCcjo8hdHL6julph
         dDF7O+Tzxqr26YIv/q2nDWRhjYjvH6SN7Bzx0AI+UOhpczQBbIAbkZ5SXsnjpzuB8w0i
         eAKAWXeSKeBTbAKQoUg1PgKDRXHg3hIRsA6UR/+DBidPV1mk31BeQWnA8yV9a4K09r8X
         1gUJlzZtKgfrg/eZeo0+STc9uJX7ku1z/pVfQCGTZ+NVAbhqHiTwIRTJeQ8dNa5oATQ/
         xpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDdlqqViKy4NCWMYpbRbkVG8WrQZL6OuDPANlMIK/JI=;
        b=hJ9K8DRUhnf/9ZA5BAb0QX6lgmDHX7crikwjtQKSOt4nqEp4/Yuz0IOvHisJi1f1o/
         6sxROTScs0OkOUAJA0c7imW/cZsLXospqH94FnwqXb9QDrBEhxPQAXLbXF4tT0kV3KC6
         3utRZS/hu2SHBjAskPF9SKz03AHdkM2X+c4Czb5GwchYjv4mgPWus1cpUU0tzfIWhc4j
         tnHGV4GzZu3RNCfeCO3JL86CwD2YMQRglvBl9E90NDyr9E9KmkQjkPXyrCz8ZvpAIW8B
         R8gde+Zffm/vw37g0XZWTkK8IzHn0FEQZQQNMt83e0mtu4XepgN7gddeE1jeW658XABm
         KtRw==
X-Gm-Message-State: AOAM532t7sfXFnzE6Wz/5zA00yqWidWDoZZ1N1hrCeaIEjNird+mwven
        HX14MgOts9zftNDYlji1Y5CpHg==
X-Google-Smtp-Source: ABdhPJz+O253nBtbQqfn85QqkbS32yMg4aWObX7KPy12N7UoJG4AJ3rXkgeNIooTOrDqHQ0PS3LAAg==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr11731466pja.180.1594244557753;
        Wed, 08 Jul 2020 14:42:37 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 207sm663258pfa.100.2020.07.08.14.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 14:42:37 -0700 (PDT)
Subject: Re: [PATCH v4] nbd: Fix memory leak in nbd_add_socket
To:     Zheng Bin <zhengbin13@huawei.com>, mchristi@redhat.com,
        ebiggers@kernel.org, josef@toxicpanda.com,
        navid.emamdoost@gmail.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <20200629012349.26641-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a7597c2-2d51-8382-5b60-73cd39e55fda@kernel.dk>
Date:   Wed, 8 Jul 2020 15:42:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200629012349.26641-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/20 7:23 PM, Zheng Bin wrote:
> When adding first socket to nbd, if nsock's allocation failed, the data
> structure member "config->socks" was reallocated, but the data structure
> member "config->num_connections" was not updated. A memory leak will occur
> then because the function "nbd_config_put" will free "config->socks" only
> when "config->num_connections" is not zero.

Applied, thanks.

-- 
Jens Axboe

