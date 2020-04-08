Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A67C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 14:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4D420787
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 14:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K46bTvro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgDHOuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:50:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgDHOuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 10:50:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2571801plk.7
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I8FzH7EebZtU80iu8VKOhofG02voMqpeLU7mMA/1duw=;
        b=K46bTvroOv0b5L2EiCyrJPdIos+MKgPHL/VqLYrdtCQSNgcnLYRNJmrLU3UrZSBPb/
         zQGA+h9UFp4oKK3OBipnhxnix9RrOyoaJD4iFvltAz67T8HEQoMrxDXo0GamnvwBdsyM
         LQP2fZUxR3BV7EkxFbo1LQbP40qKCHspkcJLnC2uo7Yu+P4u3+J1OrO3qSNaSkuyqaEc
         zXkGcJ2a8Uc9+P8n5Lqs291INdThk0a/PvMF/sktuMhmdZgjEqWovor5cQjVPsTui1nv
         H8FrFi/+A3CRKM3oCDLaqPNKUuRxx7lVmowZSDhR6Pz7fi4ltPxnxpClknR1ThbRSgnw
         AZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8FzH7EebZtU80iu8VKOhofG02voMqpeLU7mMA/1duw=;
        b=j0XMK9iJgCDoltzQ2HZYolvULrfYyJaloMuVK9dNN2+K1o5hMARnWSKblWIPcvl8V9
         W0WdfWi86M1lIz/lX39JKQZNjm8/C4meM0QKr8YZyiou/aogBzgrvamu/9ptnCw5bYN7
         EeP9gtweE4FWsSaJUoux+CLGyRu8lC9AFcRJAWIlry86RAZUdGJtlUCOeCsRaDNm9MzU
         QuiCQjmWPCQ4DM13U/Ht1aobnROdLEwf44K9mUCGOG3vV1Xe5LpyOlZ9vynGsj+/LYV0
         4lmCTD5T6U0bErSxZPwpe7ofA4seteOmO5GW95efE/Lc1XuNyhd3q8j9cLS1haJ0H8po
         Dykw==
X-Gm-Message-State: AGi0PubEWPnQc68SjcfD7q+1MKmpembjr6PP8WwUpn8JpFKIXxfKMxYf
        qUaR2wFOO23JwN88b99U++e+zBqs3JPdlw==
X-Google-Smtp-Source: APiQypLx/xljiVY4tkyNO5Z6jOqqaJGZZ9DaV7MRYO/RbCEZlAbtLkD3YztpKMrblyNBSsvzCICYsg==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr48219plo.336.1586356917092;
        Wed, 08 Apr 2020 07:41:57 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4466:6b33:f85b:7770? ([2605:e000:100e:8c61:4466:6b33:f85b:7770])
        by smtp.gmail.com with ESMTPSA id x188sm15772384pgb.76.2020.04.08.07.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 07:41:56 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.7
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kbusch@kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20200408062131.GA212017@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <795e9c03-4213-8d98-3d18-791c3a97efe3@kernel.dk>
Date:   Wed, 8 Apr 2020 07:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408062131.GA212017@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/20 11:21 PM, Christoph Hellwig wrote:
> The following changes since commit 458ef2a25e0cbdc216012aa2b9cf549d64133b08:
> 
>   Merge tag 'x86-timers-2020-03-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-03-30 19:55:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.7

Pulled, thanks.

-- 
Jens Axboe

