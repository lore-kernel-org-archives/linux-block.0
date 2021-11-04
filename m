Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7333CC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545D961157
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 19:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhKDTFe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhKDTFe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 15:05:34 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7EC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 12:02:55 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so6472654otv.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x8CpLDYsjX9BcxM+LMx7FoMj2wvh77Z39cZa7FhHd4c=;
        b=gyJqA1WSHUf49yp/kGxMYC/XZFrUDOBP/PZgZjDF7KBKdlNNBLq7d7jnvizJYsBXY4
         8kF/JiP8dg5PEyHvSRC5f1WBNVx0WaET2lCOzoeyg2Ix1Xtf1hQ/M6CmDA+0SNvYim2Q
         3ncaWJlI9hv3cL9cmUiJdMXWuCF26QwsRNjHdMkF1jg63QkIqAyLodV1rLEKBnbADoyT
         X6cbOOipQnrfmavY1W6PvvrbDyFveU8xfuF5B9sXulCE3HhrxHTWNX7H0gPbw3hKM5iQ
         1D3/jFe0bYoawUrHXGromJVW8OAw72yW2nZ7asw4AlOj9H8G09OXt0AEwp1+t2Sule9W
         ob0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8CpLDYsjX9BcxM+LMx7FoMj2wvh77Z39cZa7FhHd4c=;
        b=3eCgUzxAm6wQYmL5lQGCLAoKIRwRHz4cEqyFRcuw4kFMIG9toC4O8qfYKbTdC1MoYC
         IBYv6vHFjogMnVFq4Ff6TGzB+CZ1CZo73DLnUWJXoRqVvP1H6K0WLBsUji0mNlPCIeN8
         VXPjdJ4JO8XEVIiH3ri1i0cG8T4Sx2cuzaY7oGjPZVDZ1x+77SXsyLPvxEt+hTmOvPYr
         /lEdIUapqtGBR4uW56d8D404En8n8YpvKWY/DBopxptr4N0+yatRIZZaNJvMkA3sAMP1
         T4Q1WelaFOz36dAPwp+HzTT0fpHYG9fYm+DbQaUr4U6ol/5DQgWvxDFDsVakOcc/oXev
         qt3A==
X-Gm-Message-State: AOAM530325ukRFB6Pb63Xz64jn9LaqOVj46i//cRzm28EJrUrrLpJ2Ez
        U2RF7V3dj3lYnhHXuiTFjPrAz3nNboS6bA==
X-Google-Smtp-Source: ABdhPJxEJDBjZo/8IBP1TlGhUy8XirJgVqdzN6JwIbfOpuWpz+Oylrd54GLjd0AyAF1MBk7G7jOU/g==
X-Received: by 2002:a9d:155:: with SMTP id 79mr9944276otu.143.1636052574849;
        Thu, 04 Nov 2021 12:02:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y28sm1673452oix.57.2021.11.04.12.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 12:02:54 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
Date:   Thu, 4 Nov 2021 13:02:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQr3jl3avsuOUAJ@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 12:52 PM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

So these two are now:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96

which is the one I sent here, and then the next one gets cleaned up to
remove that queue enter helper:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b

Can I add your reviewed-by to this last one as well? Only change is the
removal of blk_mq_enter_queue() and the weird construct there, it's just
bio_queue_enter() now.

-- 
Jens Axboe

