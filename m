Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A69C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 20:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKPUIK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiKPUHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 15:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B76587D
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 12:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668629207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyb9R3Z9t9f8WkvXA0nuu3YJepmBztVFz76Ik7BRpJA=;
        b=GNqO5Z/+wQXtnKKP7wFEweh9WETaI9P2vdBeMSSl/fPeSBLa+eY5AyHxcwsaokb9VB+wJY
        5Hp7aZOloJWSrfthzrWkFbDBj0R2JKu0I31xoro2mIPGLJphb3aMBWvFE2DHwiYdnC4e02
        4/JSuu+4irdC5M9zslivEwaNSRTKmdE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-3_mJ4w70Nl67zHIkOY4UsA-1; Wed, 16 Nov 2022 15:06:46 -0500
X-MC-Unique: 3_mJ4w70Nl67zHIkOY4UsA-1
Received: by mail-qk1-f199.google.com with SMTP id bi42-20020a05620a31aa00b006faaa1664b9so18276415qkb.8
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 12:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyb9R3Z9t9f8WkvXA0nuu3YJepmBztVFz76Ik7BRpJA=;
        b=1jT88LgsP+BjtCa1Ds6DfvLxevKaqG0zgJwAhI05mzqGWpPGyB3U0pyodyg3to0nsz
         JgGAbVWmejMbFDNG4rr5uMajYS0uCejvz0Wb1b+mC1+B1sCA0NWcVQRxirLJ6mbRV19e
         dTw6BbhKQalKuzwBI/RD1skIdpcpIl4nOS3zxa+1aGNGr7ZSKEYxiC5tHVb4Va5THKSZ
         Xav5THCf6FOlT/fCwKVBsRRyIER7ClKJOZbdISeWtCEqNkotArgcb4wTJn1x8rxpt7aT
         xFg455AkZ736pSr8ZAa0lqa8oUTCqKJJHt+do6PyItj9KHZ01Vtoo9Mp9lFIW1H13WvU
         iucw==
X-Gm-Message-State: ANoB5pmiRPIR5x1CdwhD9h6ELMgtX/jpixcGUReOoOW/DqTLmwXdQ5CN
        EsjiGaFWnN9ChXApTwkqndfHTZb/9LsYkuknm6CAjM4JJyMa16Rw8uEJgjiHRwTCMVXUoyxlygj
        TzeQpTdnmAXWbjhbFRH8ImQ==
X-Received: by 2002:ac8:709:0:b0:3a5:3553:7e67 with SMTP id g9-20020ac80709000000b003a535537e67mr22284472qth.221.1668629206204;
        Wed, 16 Nov 2022 12:06:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4OWVuDBpLPO+fnhKT+wtMfNpmU489QKC5Tg7OxemVn4jr7/6riPzlClyiHZynUmVUayzpIGw==
X-Received: by 2002:ac8:709:0:b0:3a5:3553:7e67 with SMTP id g9-20020ac80709000000b003a535537e67mr22284453qth.221.1668629206022;
        Wed, 16 Nov 2022 12:06:46 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id v14-20020ac873ce000000b003a5689134afsm9229620qtp.36.2022.11.16.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:06:45 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:06:44 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        mpatocka@redhat.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 4/5] dm-integrity: set dma_alignment limit in io_hints
Message-ID: <Y3VC1IPORgP4OBoy@redhat.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
 <20221110184501.2451620-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110184501.2451620-5-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 10 2022 at  1:45P -0500,
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> This device mapper needs bio vectors to be sized and memory aligned to
> the logical block size. Set the minimum required queue limit
> accordingly.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

