Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963BBECAAD5
	for <linux-block@archiver.kernel.org>; Mon, 12 Sep 2022 06:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiILGMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Sep 2022 02:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiILGMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Sep 2022 02:12:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD3D22534
        for <linux-block@vger.kernel.org>; Sun, 11 Sep 2022 23:12:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so10244660wma.2
        for <linux-block@vger.kernel.org>; Sun, 11 Sep 2022 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=grrTW+RaMaOwOYe75YF4nf2REprHXMshlrnMxopZgJI=;
        b=5tANbZJsxjI04rBPeXgR8HOX/F/1nhWoQNSekYF0mKNA2/8DXYUIooTNuOo1ey0X9F
         HFc9UX6mSzE7WBm82mRx9rSzvm7Im/T7GK469cDdawvwu8/9aDNazk6EhzzrZ+7R6exi
         YqC3dD16SxxDcI0aZ3yt+3i/lbGXk2p7v+LrHmXk1xHm0oJyyBdn3CHoP4k7CLVmbgiV
         Hu6r/FE0i49zVZtebdzQMMwhxSGL0c+/M7X6CI3LaIl+jkNXM6xYlwqgu9GIWpJ1P0qV
         Te52a2dCGGqF9u3TjM1ipZ2+csqkCTUgarpwo6Tb1JoNyLFJKjzYxSTUQqlvLmPNZKUa
         +eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=grrTW+RaMaOwOYe75YF4nf2REprHXMshlrnMxopZgJI=;
        b=p3TUzwG8MKcjdQiuWUXz5d3EzKD2c11OhVnsNknLGNWIVOGH2yzhY28FhJFiMeNJ4C
         MLolFfS1OkpzSMHD5xzh6ikFjFNN9i4xPXlzASSDKvNmVYvLvCogsN7EtsIPRDVI3Olu
         9cSCZHHRxi/VsNnOMMVbqFiw+J4GyWGiF843Qp/GRP1kuhxZEISc3fOoM24mtbTaxFe2
         /eSDKjpR242oX6665dW3Gl4HGueo1r/dO81io8TbI/zh63clLSlXxL1cyrJxS8oGo2/U
         ge6TyAnpnEs/2ZvftwudeHnX7DORtF3IG/JLwVM29MpR0mDDqMviB/9yA4ZQ7Zv8zRLd
         Sa9A==
X-Gm-Message-State: ACgBeo2yyhcwXAEVUKs/5LLOFoRhGo0Vo15lEZJNnh1eNIrPdCqgcy8x
        GbjV8fLaihb+PSFVrJaeRBfg/A==
X-Google-Smtp-Source: AA6agR5lpsZeyODZriWY/w6LwDd3hyoc2qLzL7D7AQjKVlguVyynGd9u/7Srne6VwU6Pnt1APzEJqw==
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr12533144wmb.91.1662963139547;
        Sun, 11 Sep 2022 23:12:19 -0700 (PDT)
Received: from [172.16.37.121] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a54d610e5fsm9360635wmq.26.2022.09.11.23.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:12:19 -0700 (PDT)
Message-ID: <3167eb0e-2aca-a57d-ea7f-0d42292caf66@kernel.dk>
Date:   Mon, 12 Sep 2022 00:12:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] block: remove unneeded "default n" options
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220909194545.85603-1-jingyuwang_vip@163.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220909194545.85603-1-jingyuwang_vip@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/9/22 1:45 PM, Jingyu Wang wrote:
> Remove "default n" options. If the "default" line is removed, it
> defaults to 'n'.

Since this code isn't upstream yet, nor in my tree, it should go
to the owner of that patchset and get folded in.

-- 
Jens Axboe


