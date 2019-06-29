Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4124C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F288208E3
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 15:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="APDEavj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfF2PlB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 11:41:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42007 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF2PlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 11:41:01 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so10504198ior.9
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mZQ7ENm1LUT4XX2WWFNM1pod9o3EXImXcZrkWoMm/YE=;
        b=APDEavj9sTgJtYJqaFX+5RYWeVlZIElJZtIo3Q7g0e6/aIGtBzY+9SLtC5h3RLuQat
         gKsseyEIs1Oaam0/e2JAq8Ex6hJXLo11zY2Md0j6YtkvikjQkbU4vq5ai3vOspXUeQfq
         xzbm5Mom+sDGeLT0T4QhARA2bt3fCUxgpoVwLtLtXTeLdK4REnz1ur0LmJK9gKso4qVn
         NMQBF422pArP645beHlyXzeMcZEobQm69gG7KEazKDoEPzaPa5TpLK9+kCSTAGPv7adb
         SXVwltc55P1IeRqNfyp6hsoj7CpvG0AGcxV+fg8y4+t/nr2NKdMHzJ8zb4oC1VtIRdM6
         CcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mZQ7ENm1LUT4XX2WWFNM1pod9o3EXImXcZrkWoMm/YE=;
        b=NAaqg7SeE9ND2/Fk2cWiDmnKqHP1f+ClxjDZ0XVrkM+Wcr5a74YmxXwerop3aoe+Cn
         l62gPGC9SrqGDZ8SXZAco++Ald/UZ6P6mYWRgSuazvLxgnIxsi9MK9uB7JSF9SHsEpDg
         ATcAcWp3kVNztgeDv2zLdksiokgREf6cx2TFB5mFuf/dG+wcL6iEODW69HF2fpWa4ABq
         M6Br3WHIDqnU71tAwc6QJFCrF7eJNz4VBi5jR9Rp4Zdz+3Gx1Wk1GCqMcFPKwgg50OEs
         VqW+YIB0K6Cfx4ejY/vmBObqzfcUWMFHpFIIouJvXKphVJxnb+7mN7B1dg+fR13QFtqh
         8Wag==
X-Gm-Message-State: APjAAAVAw7SKZQhAfV6hDshpbXmBBwvlYCtv08KyJqVEY/Eg2evUMCM4
        +YQoENi6GuPr8PyK8QW2Lm2RDUHD1t0KpQ==
X-Google-Smtp-Source: APXvYqwC+A+W68kh+PaAlWvvdT8C14xyhO3eVmAsrUoqMio83wUprj2zelSWGEdcjPEJvkqIRb5MtA==
X-Received: by 2002:a6b:d81a:: with SMTP id y26mr16292305iob.126.1561822860110;
        Sat, 29 Jun 2019 08:41:00 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f17sm5123595ioc.2.2019.06.29.08.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 08:40:59 -0700 (PDT)
Subject: Re: [PATCH] block: sed-opal: "Never True" conditions
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
References: <20190627223109.8155-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <37b529d9-cdae-e2c4-24b5-968b2df64415@kernel.dk>
Date:   Sat, 29 Jun 2019 09:40:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627223109.8155-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/19 4:31 PM, Revanth Rajashekar wrote:
> 'who' an unsigned variable in stucture opal_session_info
> can never be lesser than zero. Hence, the condition
> "who < OPAL_ADMIN1" can never be true.

Applied, thanks.

-- 
Jens Axboe

