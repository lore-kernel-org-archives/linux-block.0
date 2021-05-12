Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C1CC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 14:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20536613BD
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 14:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhELOoE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhELOoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 10:44:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65DC061574
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 07:42:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v191so18637078pfc.8
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UirbY6lxN8Jzb57kXaKy+LkPAyfcN95Fxx30BqluHI=;
        b=0ose4SAhg1I5qKEKEcVMb7ymxoyI9/Hg4OryPbTqcFMggjrx0q2IWLxCZ0rVbTW44J
         mz7yqbArVH8DLeQhntDCg3pFuDvBymAmf5OAgXVrTyZUvG/tkQGfhKKaVLuTQ1h2PqDt
         2zg5lhkqe7MNRg8Ggu2G3HOYI0KLqJXIFiANsPHpD2NddZmfePSOxGLegEWzlPiwvWfJ
         49HaHzXQj2s6P0pU6MasZPC377orOaybGabrc4vTbhNN3nNJc0O6Vvnaz9iUKK4Qq8to
         cvM9zu/D6f8DXR2onh+lxXap4+euA0miF4Y1oEB6pnUtlUE5KMKiBCo/lC8xl2TxTmTY
         OE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UirbY6lxN8Jzb57kXaKy+LkPAyfcN95Fxx30BqluHI=;
        b=JAYRn0Lj0fHCky9UBKH9oGQD9lhuppl2IePH7Fc1ri65gnD2W94ob09KABb3hRLNfk
         zD3M93bJ9LcbhhkZexV2kPql8EhtaRkFCLqwvDsojwgY2zjYKf/Lgs/GnLvgxHGze3Ca
         wRdtAMN4niwZuhVhXm+YCFZgqAuglULfuMYDKzrCImAclja5V1jMr0Qms4t5HPSM0Zsb
         QSUZOsVYfub1yvA/ZnkcR1qSV2krPj5cfjTdE0WREWSNMYjl6IAguoh94nVMNOBrng02
         subpRyGCXpwOlMvElhsx0lf0KtjaB4nCu0vlHkm72LRDrXbMNRKT14fJmSeU82TJRgwF
         Gh3Q==
X-Gm-Message-State: AOAM531szFRBr2FXxzSXTz+UY7kEmsDKaJUHXQ0vBWJnsyVtNDzpALue
        UloIOI+WAE6P26fE0VcSAjttGA==
X-Google-Smtp-Source: ABdhPJzPhS2CIOVzPw8qvsFuRca1NX77mw4hBIAMHNySwWOzhdg09kxFDd0g2e5VDnxDnjKiRxqDEQ==
X-Received: by 2002:a63:904:: with SMTP id 4mr9588621pgj.64.1620830574139;
        Wed, 12 May 2021 07:42:54 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e20sm4766519pjt.8.2021.05.12.07.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:42:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] fix a NULL pointer bug and simplify the code
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210512114331.1233964-1-sunke32@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5196e425-c073-25e7-b53c-34ffab1fc1f1@kernel.dk>
Date:   Wed, 12 May 2021 08:42:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512114331.1233964-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 5:43 AM, Sun Ke wrote:
> fix a NULL pointer bug and simplify the code
> 
> They should have been applied for 5.12, something was wrong.
> So, send them again. 

Applied, thanks.

-- 
Jens Axboe

