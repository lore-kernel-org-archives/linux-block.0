Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C5C433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C822619EE
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhCXM6g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhCXM6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:58:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2001C061763
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 05:58:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r17so14584645pgi.0
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7nSXLa0g4vdV8/W+gRepcbbFbJlq08ZTsV+Xug3aA4s=;
        b=aw6tknWNgO6BmFU7+3w3hHNXz/DW4bxRF9dkU8+QTFcwB/We2rUb4EAflmRJQMof5b
         dPM18ozI0XDuj7jTSu2dHCVjTHHkJsDqpNrUiC6zwCmWje/xd1FyqGHjDopeUffKHR+s
         jrWeGw3u4CEpIJirg+PCyfJ1bI1KcJvcW85/VulPCemLZsULXWvJfFc9D/MHCCAwhz/j
         imN7X5xfhaWuUnsQkrMaFSyLXZst8eYTgxxZ7yrt/JfNQKGfhzdtG1j8iDpUdH0C4OGC
         qH8ATONV75P15OldfTAuLUp0vQhab8Xtz9R65DkH+no6kGtiv19cw9DmGwgM2Z6iAxv2
         /hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7nSXLa0g4vdV8/W+gRepcbbFbJlq08ZTsV+Xug3aA4s=;
        b=Az+qn9lkTVvkhsxDzmXA2UUT05SKUMJpPirbn/6vY2FWTQMhZXAMKh/OkTSVFKhThH
         OU4qdigM6nYiAmAO5piJ+pF6+4e0I2T2IKpMjmhJp/ea8VetHxSuqX7GkrMSNLS4TSAu
         UKc6QfEipp57thSjHxBThuxUmQsSk1zG365AXltdwREodEu5hZtLAr4UdIqXKwkIwLlL
         5jLfL1GYo5AqT5DOazVQQRgS89Zi+eVzPEEczEIiYTjtytHcb/Zy8kkChtHqI4+JUBth
         YO1tJlxX697+jI6oDovFthEc7QX3sdwAbCD87n+agpvE8Fb59LnU7wMICkiBHbBmja/6
         ef3A==
X-Gm-Message-State: AOAM532YXMulREZ/BnJ3Kh1ElToiHuXc84XSl6cfZDAQJ62vXwM2WoHG
        xlmGC4BZKJV3+STG6fU+tfU/zQ==
X-Google-Smtp-Source: ABdhPJwpGeN2T5LtbiDg8g8v70tn9qDxiWZvdMTlcMYpWXGZfHom+RikYLm7E0qSV24l5h7cMsVkYg==
X-Received: by 2002:aa7:96f0:0:b029:1f3:97a4:19d2 with SMTP id i16-20020aa796f00000b02901f397a419d2mr2808767pfq.73.1616590687184;
        Wed, 24 Mar 2021 05:58:07 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 27sm2505726pgq.51.2021.03.24.05.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:58:06 -0700 (PDT)
Subject: Re: [PATCH] drivers/block: Goodbye BLK_DEV_UMEM
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dbueso@suse.de, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
 <20210323190710.101888-1-dave@stgolabs.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f6626a2-863c-06d9-836f-2c837494c2ce@kernel.dk>
Date:   Wed, 24 Mar 2021 06:58:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323190710.101888-1-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 1:07 PM, Davidlohr Bueso wrote:
> This removes the driver on the premise that it has been unused for a long
> time. This is a better approach compared to changing untestable code nobody
> cares about in the first place. Similarly, the umem.com website now shows a
> mere Godaddy parking add.

Applied, thanks.

-- 
Jens Axboe

