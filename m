Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13CC43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 19:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiFNTbn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiFNTbm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 15:31:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8973C1D0EB
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 12:31:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e11so9438509pfj.5
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q6OTJob8vIl7OODLdgfc1ydKz9RBvsEiHyUohJfg4o4=;
        b=Cd2Hkartfv1CsL+/MtJzuCQeYzSpIXKO1EM7gsSKez2NODdPuDwXUBP2Xtda2SCP7/
         TjjANmffnsbHAzMyAhDGCME6dycBvs4XiauKXjAUx/vsHK9ZREDyvEZ9+kMKuUtmbi0n
         g4RbOLQ4LOGOa1XyckZvDCFid8HLmYvH0KMq1FtIp7LTVirU5EfdojpTu++JPGL59drl
         XR72FDEbj4GXkcvGkn36Mp5JLFhvq4xiaGOK2qSW8CdkHqicy5ZgijrSxkO8rFW3MCZF
         j0l/yc55ozvOoi+43Ns7HMZ1L+JOrz5Bw/A6Z//FWdSwyK1wQdw706Jua9oFOKIFk/JV
         dBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q6OTJob8vIl7OODLdgfc1ydKz9RBvsEiHyUohJfg4o4=;
        b=XxHLPv5qSLCL9KMRweAbWeJq7YtjFzwMrFOD+hdiNnWvzQSJl4PMkFh1SVb2tswi5n
         bma9a1qte5JotvBc87Gs87Qk8EdjLZaZAGV955qazK4Da9tjdXAwvvpIlTgCB5mSBvOE
         D/+PUeGxaCiX796oBDJu6/fUiiW3Xljw2lSR0aNb5PVhwy4CFgJFQQmcOy505reYFhkw
         GvavPOhHDd1lXzc7y1DrQ03Uqmv/4feGO8uN43iKbCeqzEk8W2w8UcrVQ02Y+NKrdcu3
         neshVfCfNiMWf3QPpbyNeyiTVdymEXWXFr0hLKbdsStSA2oBkILr/V82mm+DT0s5Vham
         qHyg==
X-Gm-Message-State: AOAM532R7Zda6HrAD4kmaS7O2jMPM70RMsx8F2aVdakUfOD1JB7lfc8A
        QUVSI2zaFOwi4Ufch5lDixlDBD97Rq3FKg==
X-Google-Smtp-Source: ABdhPJzPwd/dKv+tN/cOqQE0iNvL5PSAzG6wKthqZFnZevSvdz9eIvy95esCqEc/+Odi/iK8ctDtxQ==
X-Received: by 2002:a63:82c8:0:b0:406:59b2:b5b2 with SMTP id w191-20020a6382c8000000b0040659b2b5b2mr5906048pgd.302.1655235101006;
        Tue, 14 Jun 2022 12:31:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l13-20020a637c4d000000b003fc5fd21752sm8197347pgn.50.2022.06.14.12.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:31:40 -0700 (PDT)
Message-ID: <365606bf-bc4b-dac9-d17a-efacd99de054@kernel.dk>
Date:   Tue, 14 Jun 2022 13:31:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] block: Specify the operation type when calling
 blk_mq_map_queue()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20220614175725.612878-1-bvanassche@acm.org>
 <20220614175725.612878-4-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220614175725.612878-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 11:57 AM, Bart Van Assche wrote:
> Since the introduction of blk_mq_get_hctx_type() the operation type in
> the second argument of blk_mq_get_hctx_type() matters. Make sure that
> a hardware queue of type HCTX_TYPE_DEFAULT is selected instead of a
> hardware queue of type HCTX_TYPE_READ.

Just reading this commit message, it only states that we need to make
sure that a write vs read queue. But not why that is important. Can you
augment it a little bit?

-- 
Jens Axboe

