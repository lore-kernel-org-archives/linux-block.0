Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8BC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKPUIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiKPUII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 15:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A765E51
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 12:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668629236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyb9R3Z9t9f8WkvXA0nuu3YJepmBztVFz76Ik7BRpJA=;
        b=Oje2vdl243QdqRpz32MAAxiIkhR0Ie6Fte1eXt27Xahfh18I/0XRDe3fUYwx0u7bSN6pT0
        Gb5U6LYnZ5UIOwhLpuXv4UdnpaxC3/+bQlEphfLBoYZdhL5N1X9x68NkpBv0TWFBm9Xwn3
        4hfN9eWstQskGBZBrZG/8frdAlfrn6U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-244-tw-pJqfQN3mSt1YLcqXRVQ-1; Wed, 16 Nov 2022 15:07:14 -0500
X-MC-Unique: tw-pJqfQN3mSt1YLcqXRVQ-1
Received: by mail-qt1-f199.google.com with SMTP id gc12-20020a05622a59cc00b003a5444280e1so14011138qtb.13
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 12:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyb9R3Z9t9f8WkvXA0nuu3YJepmBztVFz76Ik7BRpJA=;
        b=2HYzcEwklkRFqNcDqvnCoOMlXZXwLsBfHayyWUm5RWEKmG9jS4KMg8r2gVNcKv4wJD
         9Xzcbmr3zm/vHRaYpVKXhklsm3ZUoEo/LAOOBUh8LCmMpPOVaTIWjKFWpPzpnJJqlbGZ
         MeVwKPzZtq3qnl9t2QBULT+3o11qElSRVmvMQvoozsAhRaiVZflDSI42ToIQLwqQsDHx
         N8BDJxW/+rR6sDZrFqxEUJOd9pPOW61v17/TWXKRayIS/JkuRCu23fJh9sI/ENlqQupp
         eAhOhhwKpltN/bOxJhL04uNOFq7b4UbP2a9O1c0+/FB70GhUSqay5F64fQXrqTh8xt0r
         kEHA==
X-Gm-Message-State: ANoB5plvxiGCx2D9S1G4ujvpMUiAQOpI3ZSIoiCa+Kv3vyz90VniaGG1
        Gntx/OgVPjlJm3p8BH5UHyo62wHKWslW/VchRs3PRHehbFkZ2Q4Hkq0/9L0BPQljD65Q7XIkfe1
        wWcrgqm9C9jBXc0vG3oPfjg==
X-Received: by 2002:ad4:404d:0:b0:4b1:166:bd26 with SMTP id r13-20020ad4404d000000b004b10166bd26mr22167362qvp.21.1668629234531;
        Wed, 16 Nov 2022 12:07:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7NSDvq8EIsPma17Eq/R3cpKE8X0kD6fDGjVmLxSHuH7Ap7Fm5PIdEa0EcdSMfpGQIjfXQKYg==
X-Received: by 2002:ad4:404d:0:b0:4b1:166:bd26 with SMTP id r13-20020ad4404d000000b004b10166bd26mr22167342qvp.21.1668629234296;
        Wed, 16 Nov 2022 12:07:14 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b003a527d29a41sm9173559qto.75.2022.11.16.12.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:07:13 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:07:12 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        mpatocka@redhat.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 5/5] dm-log-writes: set dma_alignment limit in io_hints
Message-ID: <Y3VC8MQaIN4oc1+V@redhat.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
 <20221110184501.2451620-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110184501.2451620-6-kbusch@meta.com>
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

