Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC363C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C087B208E3
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xeioNt8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfF2Pkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:40:53 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:46878 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF2Pkw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:40:52 -0400
Received: by mail-io1-f45.google.com with SMTP id i10so5219441iol.13
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8xmYoRSf8xUeqL5ashg05ILdLvPJtROoB7oEhGSMprk=;
        b=xeioNt8X4RcLcpH4BDEhyzp8TtnN5/E97UT9BgAUeKUJZiJ/FkR1ApXJLzGUybIzzJ
         bD4m3KsGHgjEkw+8fU1YSVwifxHaX3915zDr5BF9e2hFZERxFlC7LL39HnRBOexnZAHC
         5BU99X0HzOp9u9nZvNALa1Myiq54IJX5Wh43f7HrWdkkKdcChZyf3CByuZYLlPmm6WQ3
         QHSdnbug2J/5uKLLSDn7+UWqHrqyJ/0aA2rxfSQvl4CCb/HNDeEnrO13hTm409xagP/o
         XNEGEEnEU5NCJyrop+N65IHyxyHpMUwPVB9JoNf9nyuybEv/Qt1diGYq7ZgtTm55YZZB
         5L2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8xmYoRSf8xUeqL5ashg05ILdLvPJtROoB7oEhGSMprk=;
        b=DVzs0hkDOyXnt4WbElRkRMXB/8+hNeywQ8u7sjcFLf8U9uVhSqt+GXdU4ZvpT2X1D3
         /aboZTECEsvRG2mYL1ivBDwdenX9BL4ebGdp/Sl2l9VkYMoCpGaJS8UC56/wTdA/L1uP
         KSHK9aPtELabprbGMPWoEb9demesjb/CaQJKkQKLob4S0TydhIoXm7jrpZ95jfQqk+M+
         7iVsu7oi/VGIzM5X8wVHWWVF8Ovk/6oSDZoKCRvstzTC/FRUlWrSut4MpGCP0GDy6hKj
         TUR8aqE1SKXSSYtgj2ymdpTp0yB4z4dzFxqmLYsqloewRvxJlDyQfwrDICYz4STUkleD
         yD4w==
X-Gm-Message-State: APjAAAXu8F06AcUOyUOQdoCPF8uVGOpYci5l6cYgJDyL+U651aKsNzAy
        DhC4pC2Qnu2lSYmGsw1E5RBZ0G+85kPHIw==
X-Google-Smtp-Source: APXvYqzKQFNV9tBUtaLAbUbyys8/t3ghjx3cK4XhZgDtDUP3QP/XpqH81+Rpe/t/qMOXZb1DJnHfpw==
X-Received: by 2002:a02:84e6:: with SMTP id f93mr18548263jai.73.1561822852077;
        Sat, 29 Jun 2019 08:40:52 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t4sm4476744iop.0.2019.06.29.08.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:40:51 -0700 (PDT)
Subject: Re: [PATCH] block: sed-opal: PSID reverttper capability
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
References: <20190627223002.8094-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a60ce160-7c6d-6474-344c-8e47bd71afc4@kernel.dk>
Date:   Sat, 29 Jun 2019 09:40:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627223002.8094-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/19 4:30 PM, Revanth Rajashekar wrote:
> PSID is a 32 character password printed on the drive label,
> to prove its physical access. This PSID reverttper function
> is very useful to regain the control over the drive when it
> is locked and the user can no longer access it because of some
> failures. However, *all the data on the drive is completely
> erased*. This method is advisable only when the user is exhausted
> of all other recovery methods.
> 
> PSID capabilities are described in:
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set_PSID_v1.00_r1.00.pdf

Applied, thanks.

-- 
Jens Axboe

