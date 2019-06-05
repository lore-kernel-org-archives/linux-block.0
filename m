Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E4C28D18
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51C20684
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yyD4roMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfFEOWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:22:40 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:44346 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfFEOWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 10:22:39 -0400
Received: by mail-pg1-f170.google.com with SMTP id n2so12471831pgp.11
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+IcDP8xywihziIgb7p/GLXZhp4cLmigR0A3EK7XJW0=;
        b=yyD4roMK8IUzMUzyYYIle4EboYZB9IzE6GPQGoQtFvfggOvviH/3vpHFMwjPy6yMS3
         WxYPl11RTtZxvEJUCaC/UF43bEUALvX5Jk2kEr+il/5OgV4GM+OFmk9/m42A9JOpmE6t
         X693rS571KV6xsvo170fRaAsVnujNlNuVARoPovwK38pFU0LPWSWkSb0t7tvlC3EJMIN
         eDpNXXsudC8vHx1QCZRIKcbDBuaPLij83tVhhdPWlQlSMuoQH3MGwO0CZCn+9E76qPum
         wesb7zyj/jsBaJCnnLkw77Pw1DmaVxfI/cQMUYdV9YXCeSCdZlgInhZJ+2eM2++wOOzr
         dRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+IcDP8xywihziIgb7p/GLXZhp4cLmigR0A3EK7XJW0=;
        b=gnEDiu7olcJDXaFF4T8v6xBJTtH8yfgo1lTmP+hAEmyH/JWldnrv+rzm+lc8knSU3o
         xzsa+nJsbAb9sK+mIBm399iQvr+qLDAYw1IP8Z861G+zr/aqOYNcm31ad5L4wxnf5YDE
         pi0mQZ1HCWLXROlsIbPxGiqxLWVyQaFk7hSlLQbh78HEPJyXdt/8qVEOvl4LRg/UB3GJ
         //jooKovzQCcIL+9KKIvV+3B6I+hGukvhhvUzdXOVIi1+lcPo+BJOK3kZVBansPoB9dk
         hslk00G54h5ohXHyPFmvVjbb+Qku7Aw+Ro/hOV7LI1dxdViw/Kf5AnrmpFqADXgBkN26
         zk+Q==
X-Gm-Message-State: APjAAAXhIQ+JXrQzfrLLAQYaHUMwuSkWwhWb70fmsb6rmVlFs/ly48a3
        d+OdZ7xKStRvGDjJFGoKNFDGKCYkAok=
X-Google-Smtp-Source: APXvYqzeH4OGyObX0kyEFIyVLA5zY2ImKmCvMnoXbBNx09B0/gTQWHMF/IVXvqQWeh4fp7YF5zmshg==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr46913713pfc.189.1559744557582;
        Wed, 05 Jun 2019 07:22:37 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d9sm17865159pgl.20.2019.06.05.07.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:22:36 -0700 (PDT)
Subject: Re: [PATCH] block: Drop unlikely before IS_ERR(_OR_NULL)
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-4-wangkefeng.wang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5142de36-e834-1514-a63c-4addea773c41@kernel.dk>
Date:   Wed, 5 Jun 2019 08:22:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605142428.84784-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/19 8:24 AM, Kefeng Wang wrote:
> IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> so no need to do that again from its callers. Drop it.

Applied, thanks.

-- 
Jens Axboe

