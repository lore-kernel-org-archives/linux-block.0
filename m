Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1185FC83004
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 15:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20FF20575
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 15:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nmi2EE2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD2PR1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD2PR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 11:17:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CBC03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 08:17:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q124so1139567pgq.13
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7LBRYnSEHN8/9ozE3Fpi9B5Vz1QMTvJQePwLGiVb2d8=;
        b=Nmi2EE2CIfhX6sOm71+cWqtQud5YQxla+RbCKM8JHnNd2Rj2S/Pr4MnQLBDaLp6VmN
         f7aWETEeeVC5rXn7/eFl5fMxZAPuQbYR/E7WFvzFtsrZ/qzPGtrlKrnFmB9vbCqzOhbq
         8Ic2n6rCma1NQa3ishaDzngxUdGFgiqXvzophzg+IUW+f5eRo0/1sDsAfCb8akKEHm5G
         iHtGYAN11+1ntqgDa7UrGehH0cwo0hB3eRYb+jwHv8r7qWbOgWJA28ONGlK+rWhKilIB
         mAk0Kq/K/r0equh7n7mmOevwstUptg4lpvUnmbpklJ16ZSBphqJvuwPx2lSiaibK0haW
         y1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7LBRYnSEHN8/9ozE3Fpi9B5Vz1QMTvJQePwLGiVb2d8=;
        b=ThT1khzWRSypLyR2Z7kWrpAuaFRDBtQ1PegimTs3sgsmQYmco4ejjJsMSeU9CtAn88
         5odwioR2ck0zuxNv7sUqd3GRnUOBXIRFySxsbrT2LHeWDrq9OZFuhd/CebMJJwhTQTlC
         WcRsnAxdxBviEx1EO5+SuoQUnrB9yQqjcOWKqJFpz5NQQboq+ikcYeD5hrnaL8YNQj+H
         pVrWHQG6OeE5lSvPXtju89Objlo+L9cT3VmL5xAiEP4SVH4wEgYc67xpbBJTlsdfbw2s
         XvXjI++5h/tMyc2w7WcdjZW5GN08zfg3kz4PiVDQlJg2NXYqH3vL+B+DfBLAtzfkdULM
         7MVQ==
X-Gm-Message-State: AGi0PuaQkPuF1PhoJP6Qayk2G8dGGEF2nVbyfXi2sY3qs987w++3bXvX
        1Wfs8WxbUZTt5RHMNavIolzNIWrDDKKXgw==
X-Google-Smtp-Source: APiQypJX4vQbx6d0f9xV3oZJDxKkndW70Af/q+LEbTX1f/z1XK+PoLyBBVhrpHnkQClTHI4ibnyTqA==
X-Received: by 2002:a62:2bcb:: with SMTP id r194mr9286553pfr.26.1588173445515;
        Wed, 29 Apr 2020 08:17:25 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c14sm1268682pgi.54.2020.04.29.08.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 08:17:24 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: make function '__blk_mq_sched_dispatch_requests'
 static
To:     Zheng Bin <zhengbin13@huawei.com>, linux-block@vger.kernel.org
References: <20200429013632.38276-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9040122-2430-90cc-cc81-31d093070712@kernel.dk>
Date:   Wed, 29 Apr 2020 09:17:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429013632.38276-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/20 7:36 PM, Zheng Bin wrote:
> Fix sparse warnings:
> 
> block/blk-mq-sched.c:209:5: warning: symbol '__blk_mq_sched_dispatch_requests' was not declared. Should it be static?

Applied, thanks.

-- 
Jens Axboe

