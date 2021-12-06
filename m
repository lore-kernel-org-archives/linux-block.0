Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA0AC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhLFQht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346166AbhLFQhh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 11:37:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D6C061354
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 08:34:08 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z26so13591505iod.10
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xk31PphXoMoIH/ehoy/CT9pHIKKPfGZ3GFu0zDuVzVg=;
        b=TwDfZv/n8StAAgFVS/+H8P1RDGfrj2D99UPrFWXLxtihrzqI/pEW75KJ6YGnmIkjnm
         7bCPsJLtdwYtWrPEFaOga66g62lx8pyzW6ccrlO31uF2LJaS+8A4IC+uF9Sro3+xrYZe
         VAu09N2Yd+a6ea1mdmAYmzuX6i15YTPOHwaEuXtLlioi9Djs8IA/+B1J/FGRmDiaESh9
         dqLluI0ed1mSSFP0ima/no4GP6scnyRKTxh6K/kIMd/lnSPmX6drgDTbiO20HNQQyLyn
         jK20n339CpykNilHy+urXjchkW2hmogNzTyVzhLIO0MEa8UcxIdcNySsVRkS68raIs+C
         LA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xk31PphXoMoIH/ehoy/CT9pHIKKPfGZ3GFu0zDuVzVg=;
        b=RJva8VA0nD/vYzs3YVdIA32FR29b4eJTiILYv5TuogGiAP6Q4rYTB+sLqDgT6UAmP/
         rW6P3VII9EPeSGG23yU03tUK8/hNiZUycMhroS48EE3wPXwjJgQ8e2AKSoUH/5A5WqLx
         AFmTnIeP0N+f6QZWGlLPQoOh6jkdAdoTAMSvJy8yReElNHqL3sj267D5GUrRKe5OAZ+q
         9sdt93jpupNlcMZJxRCakL8tYOELokOYP8GJNoo7ud9PJByJ8tkCt4kYBGHRgbogBfQG
         O85ZCyRil3l5pUBdWDeyMbzwt7vTgcwxVESKGXwKfMLtcgrW+ii9fEEQqwNi43n9ttqL
         9l0Q==
X-Gm-Message-State: AOAM532M5z7QA8P8yWhBBptj5uKgl99Uv2oWgJkTxAwy7xOfaQal8trn
        VlXbR5sSg2eHGYpYHWad/3PDuehi+QTu2HkJ
X-Google-Smtp-Source: ABdhPJyp9wBjPHAPtAD+wy5f2rNHnIz16twtbAp/y48m0rYs3+5WFnH+6tFhpLiljJ9FNQ+AZNzoPA==
X-Received: by 2002:a02:a91a:: with SMTP id n26mr42646695jam.46.1638808447570;
        Mon, 06 Dec 2021 08:34:07 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h1sm7975827iow.31.2021.12.06.08.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:34:07 -0800 (PST)
Subject: Re: [PATCH] block: avoid clearing blk_mq_alloc_data unnecessarily
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1ba89cb7-e53c-78c3-1fe4-db9908851e63@kernel.dk>
 <Ya20vUb8cldTe4kI@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55daad21-0da7-d6ab-cdc9-3f8f509ec91a@kernel.dk>
Date:   Mon, 6 Dec 2021 09:34:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya20vUb8cldTe4kI@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/21 11:59 PM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 08:48:09AM -0700, Jens Axboe wrote:
>> We already set almost all of what we need here, just the non-plug
>> path needs to set nr_tags and clear cached.
> 
> How does this avoid clearing?  All partial initializers zero the rest of
> the structure.

Yep this is garbage, I'll just drop it.

-- 
Jens Axboe

