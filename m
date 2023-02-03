Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4AC61DA4
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 18:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjBCSBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 13:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjBCSBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 13:01:06 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178C72A16C
        for <linux-block@vger.kernel.org>; Fri,  3 Feb 2023 10:01:06 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id d2so2110908pjd.5
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2023 10:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOlXCfgXIzcD6djWuvVKMsZ0ZeVutGV7OHPUHXItt9U=;
        b=Jlt1Cd+JiaS2YnO6etkc6bYVULfJrvKnbAf7CggiIwSUobnS9Gy3b36cbuaMuJWvRp
         3Wr8kfiF+/z5nOYSQDGssTcUdBIGg/kSLt0AgTC+Xgs33F32+FjBFm7FOwGuDphrPrGD
         F5dXlTNOYvzU0k235at5JruapfmubEZJ0sHhFtMfWffh44MSw45Fw4T3BXV5CV6qRfE4
         ckK+g5wPUOLo5mt5bX0CUNqwWJAXEX25Yh4yKT8wER6lguA9PQxlKE62anNvB0dMsNjP
         5DzbCbTVgSM1h2RVyelIYWwI6ZkY8AafprGouXY04nNSiX3yWXlJi3dNbG39I2mBA4se
         WbTw==
X-Gm-Message-State: AO0yUKXvwj128Mvp8pSkIkj3/Z3xD902ZVrj/JMrDyHrtxmC7N7hegnT
        I7XxQSZZgqbNPY0zWDEYddb9feEH1YjJFg==
X-Google-Smtp-Source: AK7set83GPBWrjqBGcFl+X489UJvUgATJuVphzWtmbDHujgTlmtUMOPbVGMGw/iI2Lfi+h2q2p0J1g==
X-Received: by 2002:a05:6a20:5485:b0:bd:1058:29b2 with SMTP id i5-20020a056a20548500b000bd105829b2mr14126092pzk.58.1675447265469;
        Fri, 03 Feb 2023 10:01:05 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:b752:5d03:ec5e:7be5? ([2620:15c:211:201:b752:5d03:ec5e:7be5])
        by smtp.gmail.com with ESMTPSA id x8-20020a63b348000000b004efd4393c1csm1684619pgt.84.2023.02.03.10.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:01:04 -0800 (PST)
Message-ID: <135496cc-48c6-c0f7-8191-352639493479@acm.org>
Date:   Fri, 3 Feb 2023 10:01:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: stub out and deprecated the capability attribute
 on the gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20230203150209.3199115-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230203150209.3199115-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/23 07:02, Christoph Hellwig wrote:
> The capability attribute was added in 2017 to expose the kernel internal
> GENHD_FL_MEDIA_CHANGE_NOTIFY to userspace without ever adding a value to
> an UAPI header, and without ever setting it in any driver until it was
> finally removed in Linux 5.7.
> 
> Deprecate the file and always return 0 instead of exposing the other
> internal and frequently renumbered other gendisk flags.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
