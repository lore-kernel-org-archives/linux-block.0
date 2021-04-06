Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11473C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82BF613CB
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbhDFPXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhDFPXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:23:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76244C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:23:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p10so2562360pld.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MfFf/98q40uDaDC3s5dBDadxudtK5f15xA3Kd03jsbQ=;
        b=HEUR4qP4YKjNgemehB/URA5app8TZBaHWMyTqDA/xHOFE24f/j1oTEVpcakXAsT85Y
         j1Bb63EATcp92CInSVqzDnndjMZFQAlYA5OKzt54XAFTSY/N06kDS9R3b/17jqoQ4J9o
         UYw5v3dwDwyTj8N6I7Fpsy/RCTx/a3rUTOIRKA47vBoNw8Jtv8yJanMo1qkgGkx1hKwA
         lsNaB/hSA47vjf80R+anEsEZSjVcXxA8GBxWi20ms+azi5NNzatoswANoaij1dSdZC7/
         8jAV7QuqCw+SEbZRgAZfouhpOyMd8UKxOnqUABeHM3tcsj+3o4wYA/dTauPAsCFQIasJ
         eM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MfFf/98q40uDaDC3s5dBDadxudtK5f15xA3Kd03jsbQ=;
        b=DU4fipaH4HgfoHVtrQc901dgLgJdTHGqS5FrTSzrcAmoPCld2tKn3aybrJPEMB63bR
         l6jJTXmTS5AvbU0PwBGLOY9o8vK2+tfBmKV8ip7paB2tyc2lhdldFnRCahrOHHoStCYa
         JLeR+qjpsaycj6AJPSNxQySRrsXgoEE2rs6Zq7swBM1kHrpbVSM0L/iD0TGXioJ6QS2X
         MXVqA9jC05e5q7IqcsQrhdBdW4IcfkTEKIWKh42S/M4OfAYDfDxQEwwIvTRoTEDf1iz4
         BDXNAY833YdfhZhfZd7/odM3uael3eLWNS5Z5ihin7v4V1DcypUoxe9HUo6uqZr79AdM
         s4GA==
X-Gm-Message-State: AOAM531DLMSTj9gM5hE4/RdlWoUwZkDPkTSB8r9Sy+rB9nBK3b0smTlE
        mfC7FrJz/HfDftmA2VeWHQiQTQ==
X-Google-Smtp-Source: ABdhPJwDBJIVLl+ZGgwLX+V/X4M5jI7GmFRnTR7uOXiCkZEMeBmjvzfKCdk46XgycamP9VjuMXTwIg==
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id p6-20020a170902a406b02900e678c471c8mr29018477plq.17.1617722613018;
        Tue, 06 Apr 2021 08:23:33 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d6sm18599405pfn.197.2021.04.06.08.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:23:32 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: add sysfs entry for virt boundary mask
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com
References: <20210405132012.12504-1-mgurtovoy@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe2f2229-0bd1-ef9b-b4fd-12c736414e13@kernel.dk>
Date:   Tue, 6 Apr 2021 09:23:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210405132012.12504-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/21 7:20 AM, Max Gurtovoy wrote:
> This entry will expose the bio vector alignment mask for a specific
> block device.

Applied with page fixup.

-- 
Jens Axboe

