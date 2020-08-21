Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A79CC433E3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AED820FC3
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 14:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WZPAanfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHUOpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgHUOpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 10:45:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC86C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:45:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c6so1566329ilo.13
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C90nSWF13UnmUXT/t6zouheV3b/caGvmm+rEBKqVpdg=;
        b=WZPAanfw3FhXa7h3fxpfrymu1+iAfN7jYZZcDC1ZwufOlcLwlqqC5JQ2Jdaa7axmC/
         AuKMmUn6G9SHn8uiHiSKtQMcKmXt4qJnS6XfrG5tH/F6ZqV3GjPWYDc8S9VMsqwuj4fV
         6+e5S2jm62HjwvxTNFR+qtMpHYZegRDCQMV3NIelDb+CZcphTnuK8QJcZnufxa59Xgzw
         6LY26EQ0sduFkqL66yNRVSu0VnzkIRq8w0QDD/s+udlfz3bK6/yqg7LAN3a8nAsf0Nuw
         +g0YGzid/aIb0K/qP+EjYkCkDGRtudkM4AUj2vRZDEX+cRQXswzarbNLHhDu+3bRbWns
         eC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C90nSWF13UnmUXT/t6zouheV3b/caGvmm+rEBKqVpdg=;
        b=M338GC/bOwlYBGvLGcuEbBRP80iicPgYwoBykTbQpM/G+LGhnRXoPyRT0RW/vrMt66
         jT+h/aCkMJ3qs0ycDfJIqI5XZLC3eY/oSsiUnJlHIvqDr/wCq11/X8HZ0IWHw9/zm7Ox
         2Dii9+dESTuY5SS0wuZpYYqXk/mYt72E439QXE+Pb1xaiM531yIXVcb+joIXrH+ih1NC
         OaAI4eK2gJCo6wA8SrGXZGFpADJ+mRIDxaUy/+h0qpE1fKhBWaHUvI2QY6Ei67wP8Fg/
         mI7wIDJH2o2oZzR1IaybsSyWdvOAGI/P3xzDY/dmGIHAzzyQOfp94swEXtGZp3XmetH/
         BGpg==
X-Gm-Message-State: AOAM532AS6s78emt0SgBsE+ft24aNbfR/Em+KGOaa32X9Q0ACz6WbNGG
        FD0gGq3YEuFKFgDD1sxk8FKtXA==
X-Google-Smtp-Source: ABdhPJzv5Uro5gqLH9Madfn+I7njnS1pYD1IAyxJA8wxLh1cPMqD/A08/j+1u985vO8tNXtdISywww==
X-Received: by 2002:a05:6e02:d44:: with SMTP id h4mr2812734ilj.296.1598021104562;
        Fri, 21 Aug 2020 07:45:04 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u89sm1313919ili.87.2020.08.21.07.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:45:04 -0700 (PDT)
Subject: Re: [PATCH] virtio-blk: Use kobj_to_dev() instead of container_of()
To:     Tian Tao <tiantao6@hisilicon.com>, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d6b9b5b-cf44-6d77-8d3c-7a9f6063d457@kernel.dk>
Date:   Fri, 21 Aug 2020 08:45:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597972755-60633-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/20 7:19 PM, Tian Tao wrote:
> Use kobj_to_dev() instead of container_of()

Applied, thanks.

-- 
Jens Axboe

