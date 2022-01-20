Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DBC433EF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiATRxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:53:49 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:46929 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiATRxt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 12:53:49 -0500
Received: by mail-pj1-f54.google.com with SMTP id n16-20020a17090a091000b001b46196d572so6455823pjn.5
        for <linux-block@vger.kernel.org>; Thu, 20 Jan 2022 09:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bW21sZp1EbNoTXfTox1CrDTu68JnEQ/L0AiwmQmbAXQ=;
        b=Wfu/Lxq42rLp1Kwz9dy6L8VfaUI+AGgC5DifliaOgMmdj1WAIutDXS2SKcDWc5c1X5
         jCYZE5nbLba4p+9ald7+OLUgFkM7IAxAE/fzO2gCzp0lE8mPgpt1r12DDzdvgygGqABc
         YE+KHINc+/DYV23NMezXjEE26QBeMXuWZFWnBm+RHYgb+ThpRuYHoOTwsDFRcjFSaFBD
         G0Exii7JJb+yLeSD1nkLEX+I2JP9Qhmu/rDlE5ud5XFfroarfOATJDw2pSO31vxfj+6M
         Q5GppyP9ka2GYei5zkEKdr5WJP7fpQWIkOz38A4XO9UHa0yQeUL2M72WPx+gGGPueOEi
         Rqvg==
X-Gm-Message-State: AOAM530Dy/xV3awG6STOFQN/gkPFPeEzkCwCt8+leA+7YuKlm4YzLg1y
        fP1N+O5H4nlP+TAIdmJZ57pJWlPK+Iw=
X-Google-Smtp-Source: ABdhPJxMaosQECmVSCgqXGBizhs1zzqZT+XqdfYk0Ma7fHFigYQuG++NRXg4xrxW1Yg1wkKxunc5dQ==
X-Received: by 2002:a17:90b:2252:: with SMTP id hk18mr97035pjb.53.1642701229041;
        Thu, 20 Jan 2022 09:53:49 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 14sm9484132pjh.45.2022.01.20.09.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 09:53:48 -0800 (PST)
Message-ID: <cb8e7e51-d4f1-0109-83b2-6b686305043f@acm.org>
Date:   Thu, 20 Jan 2022 09:53:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] block: fix async_depth sysfs interface for mq-deadline
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f8b01f4c-f8d5-8fcb-dba4-6d37f0db5622@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f8b01f4c-f8d5-8fcb-dba4-6d37f0db5622@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/20/22 09:30, Jens Axboe wrote:
> A previous commit added this feature, but it inadvertently used the wrong
> variable to show/store the setting from/to, victimized by copy/paste. Fix
> it up so that the async_depth sysfs interface reads and writes from the
> right setting.

Thank you for having fixed this.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
