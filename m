Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B750C32771
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 23:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIUX2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIUX2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 19:28:36 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B6A2229
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 16:28:35 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id c198so7495780pfc.13
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 16:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=CAw+9AuFEWSukEedcTM9/NulYbkJdxAeV/Qc5+U49Iw=;
        b=2LvBe6Y9B47xejK+H68aYfInBhu6KiOcall3Fbixdt8FA2p+T2v4jBJBk+6SHfzpy9
         eZLgi52pxvrp/LcPRxn1sZKx77OLeJ2eegZDbnheYf2RCMcd+7eWuR/GMdG5Q7L5W50J
         xpq1rfw9Xy11jd26tLrKJZZ5pPRNqr9NRmzIPUuqV12CqUKQtWW6KZ11Cwxk8x6iWCIr
         sQuuNBLdNbXTepGVmse18uzki956C06VjTZ/thSgelFsf3/8CPdZv74hQmhriC9ffJpl
         GRx/L55A5mu1NaHe40NQdzGekVBKFQmyrIrJzGYJVDUSdr4TnTku3CGXx5POQ//dvgtv
         ONpA==
X-Gm-Message-State: ACrzQf3dfdRkXbzoOBUFxijr0gOOx1gVRGqYLVXlZYwdPoXdIYHDQzMG
        FxwKqJ7aaIruMuJ4oip3k40=
X-Google-Smtp-Source: AMsMyM6XAhzcvAeXfTUqhZK+ZzGsg6zZnOGrWYHzvLP3fqRRKyHdI8fb/T5TfPiRqCh0Qz9CTn9rBQ==
X-Received: by 2002:a63:da03:0:b0:439:dcdd:67f4 with SMTP id c3-20020a63da03000000b00439dcdd67f4mr527858pgh.27.1663802915336;
        Wed, 21 Sep 2022 16:28:35 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c9bf:64e5:a87:42b9? ([2620:15c:211:201:c9bf:64e5:a87:42b9])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090322c200b00177fb862a87sm2646946plg.20.2022.09.21.16.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 16:28:34 -0700 (PDT)
Message-ID: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
Date:   Wed, 21 Sep 2022 16:28:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Supporting segment sizes smaller than the page size
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Christoph and Ming,

As we know the Linux kernel block layer does not support DMA segment 
sizes that are smaller than the page size. From block/blk-settings.c:

void blk_queue_max_segment_size(struct request_queue *q,
                                 unsigned int max_size)
{
	if (max_size < PAGE_SIZE) {
		max_size = PAGE_SIZE;
		printk(KERN_INFO "%s: set to minimum %d\n",
		       __func__, max_size);
	}

	/* see blk_queue_virt_boundary() for the explanation */
	WARN_ON_ONCE(q->limits.virt_boundary_mask);

	q->limits.max_segment_size = max_size;
}

I have been asked to add support for DMA segment sizes that are smaller 
than the page size to support a UFS controller with a maximum DMA 
segment size of 4 KiB and a page size > 4 KiB (my understanding of the 
JEDEC UFS host controller specification is that UFS host controllers 
should support a maximum DMA segment size of 256 KiB). Does anyone want 
to comment on this before I start working on a patch series?

Thanks,

Bart.
