Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1567AC77B73
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 18:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEXSSe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 14:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjEXSS3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 14:18:29 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1C12E
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:18:27 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d341bdedcso965796b3a.3
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 11:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952307; x=1687544307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jKck6ijump9JmntC42pZMB9sPx/5XihCaVA8jg7M2Q=;
        b=SdedccFOfvM/FZ7M+WMksASEWpDtPeh8DfpDQlzo68JU0cBQW1bTCCkvfwxH1FHNVY
         rEdieoLJCZgegBI7MESh0iy7NdTeImTrFSHn+P3pPX5Tb9DvRObbR4HARvYg5yeVGrAn
         iSIVvefaqZ5jUdWegZ6VZlOeaRI4t1TiDkMQTX0NEWTV9hRBB8a5i8w77js0nJgSrbrA
         qd5whiKnrDkuIZb3B0jCuRsei2qUNlZJX16QdXW2Z5z56XcJFvDFG+cwVITNQJGKY/Ei
         GpbKYo+8uT8dow7ROFzyZhUgcaQT/YLRmuXF8snPm3qtxSv869ENzvAN+cja8WteJviU
         bUqw==
X-Gm-Message-State: AC+VfDy2IEuojppDmQ2Cg7HjEvKlE8yCKV8nqXEtCzbh89aCCSgN2B9t
        49dNWF7w+N8iekpazBtW0bo=
X-Google-Smtp-Source: ACHHUZ5jhWj/GAPLMmz6U17x71P+ImXHw9BforwwfH8t9O1Szzc0F2Fb8cvoWbw42um023f7tkfdKw==
X-Received: by 2002:a05:6a00:22cb:b0:63b:5496:7afa with SMTP id f11-20020a056a0022cb00b0063b54967afamr4715381pfj.11.1684952307323;
        Wed, 24 May 2023 11:18:27 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b005d72e54a7e1sm7679766pfo.215.2023.05.24.11.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:18:26 -0700 (PDT)
Message-ID: <1f67783b-721e-3e5e-0bf7-b2b94a88d848@acm.org>
Date:   Wed, 24 May 2023 11:18:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 3/7] block: Requeue requests if a CPU is unplugged
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-4-bvanassche@acm.org>
 <CAFj5m9+dhpqYSOVBQ+H0tCb1Y2i1wpFqn_anbDsfs=mYCTqgCg@mail.gmail.com>
 <8b1d876b-fd37-5a0c-1e9d-253bf96e718f@acm.org>
 <ZG1butYP/ZVEyR7R@ovpn-8-17.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZG1butYP/ZVEyR7R@ovpn-8-17.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 17:35, Ming Lei wrote:
> blk_mq_insert_requests() is only called for inserting passthrough
> request in case of !q->elevator.
Hmm ... blk_mq_requeue_work() may call blk_mq_insert_request() to 
requeue a request that is not a passthrough request and if an I/O 
scheduler is active. I think there are more examples in the block layer 
of blk_mq_insert_request() calls that happen if q->elevator != NULL.

Thanks,

Bart.
