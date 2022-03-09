Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiCIBOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiCIBNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:13:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BF416921A
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 17:02:53 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t5so879496pfg.4
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 17:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lcKnxyTLjpTRP4WN0RiRep/EF/TdUUWhRlsbEAI4NOU=;
        b=hS4fsW1IpHbUZ4vmizwvhtipmPoCGMZyd84RjHFcf77BFaEGSGoBYFtNBbax6TnM3I
         ZOw4tdxrtemHTfEEBwuiAC3CrlLM1/blLXYbb+apasb0bHhmePZ9FMHX5D/axHnn0W9w
         +uhw+TzS9u26mwhcls5gKRNpv90HARgWjAYUt0iQ+w3RrpTyJNeBu/6U9v6yKJZryXtL
         fjcmsdEFYJVZpftXrih8slPFtXrRGoh0ft5ZOVYPvOTxNDYgsfQkSM2G+6iSOzQHqImi
         FfxvNp/FHSpk+FBbcrl1eWbka42TI4hYwmlm31sHr3M8PBgVamcit2rMpTN7JRj7412s
         Ci8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lcKnxyTLjpTRP4WN0RiRep/EF/TdUUWhRlsbEAI4NOU=;
        b=0VFpqyfkFCwbHZCGaJzZjtYpcH5vp4JcljpWl9C+XQ2XPiX+g0qmjVccszRMmapJ+D
         bmPCnF3kexyHWSJkgH47lu8VygYMeGHKR1Ycc/R5Mgq05lg9gyT+OdyiPX7Qvy9ovAlU
         y08XT++/2MpqFbxlFDMNVFbkDDt2oJzqBLCtCApouHb8c6tc0q2aWziL6nCgTiYXzVWi
         tLBxsEHhaWD542xg8HpDTc1D4jHaI3v3nEwdS+JY4TSkSMUZeqS2qdhCL24KfMd4/vN4
         /zd0uBuTix34u94PsWwO/i9T21vTIbqksk2RP4GtZMYOM7u6JMEuuZErF7EO3wba2zaA
         UAVw==
X-Gm-Message-State: AOAM532ZOFUnwgiIJEza73iax2Cjb4KhbNXGQpTbTNBvG92zMDeVFu8V
        JV4XLMEcza9eHQPXZUlKEMYaNw==
X-Google-Smtp-Source: ABdhPJxRlDuJlLr9rJPUjym5d8YWtRwaggHOPGKhzpMxmV4RfaDA8Xf1sz2n2oaCv8NU6Awb4GcEPw==
X-Received: by 2002:a05:6a00:3102:b0:4f6:b88d:9d45 with SMTP id bi2-20020a056a00310200b004f6b88d9d45mr21291400pfb.86.1646787772371;
        Tue, 08 Mar 2022 17:02:52 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b0036407db4728sm292925pga.26.2022.03.08.17.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 17:02:51 -0800 (PST)
Message-ID: <eac88ad5-3274-389b-9d18-9b6aa16fcb98@kernel.dk>
Date:   Tue, 8 Mar 2022 18:02:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 2/2] dm: support bio polling
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220307185303.71201-1-snitzer@redhat.com>
 <20220307185303.71201-3-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220307185303.71201-3-snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 11:53 AM, Mike Snitzer wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Support bio(REQ_POLLED) polling in the following approach:
> 
> 1) only support io polling on normal READ/WRITE, and other abnormal IOs
> still fallback to IRQ mode, so the target io is exactly inside the dm
> io.
> 
> 2) hold one refcnt on io->io_count after submitting this dm bio with
> REQ_POLLED
> 
> 3) support dm native bio splitting, any dm io instance associated with
> current bio will be added into one list which head is bio->bi_private
> which will be recovered before ending this bio
> 
> 4) implement .poll_bio() callback, call bio_poll() on the single target
> bio inside the dm io which is retrieved via bio->bi_bio_drv_data; call
> dm_io_dec_pending() after the target io is done in .poll_bio()
> 
> 5) enable QUEUE_FLAG_POLL if all underlying queues enable QUEUE_FLAG_POLL,
> which is based on Jeffle's previous patch.

It's not the prettiest thing in the world with the overlay on bi_private,
but at least it's nicely documented now.

I would encourage you to actually test this on fast storage, should make
a nice difference. I can run this on a gen2 optane, it's 10x the IOPS
of what it was tested on and should help better highlight where it
makes a difference.

If either of you would like that, then send me a fool proof recipe for
what should be setup so I have a poll capable dm device.

-- 
Jens Axboe

