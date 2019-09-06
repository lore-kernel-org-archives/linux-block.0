Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE472C00307
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578A208C3
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OBMSFHpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbfIFUeW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:34:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33779 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392014AbfIFUeW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 16:34:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id t11so3741221plo.0
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 13:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jG4+RgP/pviUKJ8QbJcP8qw2XnaK/vU+SiEUpD2jM1E=;
        b=OBMSFHpUBrpgwRkuVSPuBXbTZeB7AfzZ02OBd9Cgdn1S+8h270Jx/KJtcH8H2re6K/
         QknBx24vAAsFHkJy9KIFbcB9pHKUvQoYsGTRPYmsbO301vXvzn3C32XPJki9Yc9mYaPr
         M4RSGBUaA7CAlN6Kupdt8WteuEj7jN26aRtadlJ57R/wGEm5knMLk2IHvMlHwOhuJ/CQ
         3pMYOyWHvBo/daB2+3QR4DK7BVvaFF/QuYl/SvP4fKHkFXgMuTbiRj5QzgSU6thfzqsK
         n9lUD14fI+mG59+DGd61uprySi1oepwNw6B7eqNFFeFptt9dhedT82pelGc+watqkcWU
         TP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jG4+RgP/pviUKJ8QbJcP8qw2XnaK/vU+SiEUpD2jM1E=;
        b=hMDnO+XVOvrClj4jRLZ/HegBxCAS65oPJWCR7nKujszXa0gntEzzWvgNSN2EZCb3GK
         RDRS7qK6Q18g4nsPreMQkaD0kQyMlnwtlduJlvyENNojyjrC9bF6JSeznHIEcCTA9RqK
         ZI9/nHpHrniKXn6oSTnKYu+emgpLJYW/Ck/QY8dRZear+tIWrgDZQjpRZ56oag0Qp0i0
         +UkCHlm/BHiDAqpKcW3kKZ15+0gzDX19kPSXGcpIZ3Y8CaO+cdQQLhZtbbggurRgO4dJ
         yOZllxsPlFlXjua92uu/YMHsIVaVEPODdrARV8QP3krpTrAo03x5Sr9jjoFJ9G4tyZkb
         R3GQ==
X-Gm-Message-State: APjAAAUta1ZuVYZzNj8RdEiIkgBZX1wKw/xMRrRuElug6ttH4gwhApU3
        z6eA5qTAnLh78FjKsSrBU0GkShZXqH4=
X-Google-Smtp-Source: APXvYqxCMyfMPGhJ+8OxvxljdQJNFJZh4UuGqj9+wa3Gv7L3n/x6Nwh1/cnKvuvHVhsl2AZ1md1NYQ==
X-Received: by 2002:a17:902:20cc:: with SMTP id v12mr10443768plg.188.1567802060586;
        Fri, 06 Sep 2019 13:34:20 -0700 (PDT)
Received: from ?IPv6:2600:380:774b:941b:9c06:647e:785b:f82f? ([2600:380:774b:941b:9c06:647e:785b:f82f])
        by smtp.gmail.com with ESMTPSA id 64sm9025671pfx.31.2019.09.06.13.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 13:34:19 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Implement BFQ per-device weight interface
To:     Fam Zheng <zhengfeiran@bytedance.com>, linux-kernel@vger.kernel.org
Cc:     paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <437c831d-179e-f8a3-5687-f93459d28b53@kernel.dk>
Date:   Fri, 6 Sep 2019 14:34:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/19 9:54 PM, Fam Zheng wrote:
> v3: Pick up rev-by and ack-by from Paolo and Tejun.
>      Add commit message to patch 3.
> 
> (Revision starting from v2 since v1 was used off-list)
> 
> Hi Paolo and others,
> 
> This adds to BFQ the missing per-device weight interfaces:
> blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
> implementation pretty closely resembles what we had in CFQ and the parsing code
> is basically reused.

Applied, thanks.

-- 
Jens Axboe

