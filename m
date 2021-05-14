Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171EC43616
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCD961451
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 14:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhENPA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhENPA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 11:00:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F5C06175F
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 07:59:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so33928ilb.2
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GzynzZ+rXRsfhWtJSmTNBxQob7k+raOQQzgjWUhQlb8=;
        b=Wi/clFw7/zAXKPe4NpK+FbiqdcakrHonQNzAjH+eAQREiOtXah0W6AkXP2OP5V9J9l
         tynl7tLCpxl+4bZBWgxhfcetcvpkwO3BPZBK7F+iVVnXpMxf/BLTT5JdbXhTvPzDmDkK
         8kV0/h86OkRCw5hSRkjXiVKxbOOMt6xEuT87cnB856mrAAi7kZ44RkLwsBOLQyOUS0p1
         oEzOoimdxSXWlocQUodntTzM543UOplh/c5AGCR2Ys4FS5Z254Ha6sMJcrkReeMpLc0U
         qJWGjhDERgSqLOpo8rt2iqd0ERr90wa5GkoKMhfC0iUajE99O3LNPJGwd0h9ZtZDuH1/
         ooeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GzynzZ+rXRsfhWtJSmTNBxQob7k+raOQQzgjWUhQlb8=;
        b=sWImJVEiOQnzTgiEl9rEk9W80qp1oLBA4lHGmhSotin+zsi13RFHioB3UQuhGe//e+
         uoIWWYj+1xY1AuyM+yVLZrX3uvRSmpGzTkog7JJZq9GBR2QKofYeYPVOQHam3XM2Piud
         mCE8Drtd10wsWIRQVmAcQaOiVh963WlaUcrGcehPy9ldagdx51bCWGJ/utnzYGvKsNfn
         uhRjmhXPk9O2Wdc2rA70ZIX2UGiZFxKDX/fJz+6p1nxCv1WuursnboeSROT1YZFrSjVn
         Iht+ZQz2K5Bc2ERWF3s1wdGcrymrmt3Tu3OtKXfGCagv1Yown386ER0yrH3qA/1REj7F
         5utg==
X-Gm-Message-State: AOAM5323qDKI6dkQEClu7h5FBII/hEAXKENsXFxMQaeFOKBhR2z/i1oo
        qAXGQFzedcmY+z3dPWuJAod2jw==
X-Google-Smtp-Source: ABdhPJyhtNYPD7IA8NrXTsQJrJ53f81y+54eGOTOTYerMSzg8qqSGrhx4EHigc5SklCuztumFAF+EA==
X-Received: by 2002:a92:c0cd:: with SMTP id t13mr31767488ilf.280.1621004384568;
        Fri, 14 May 2021 07:59:44 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r6sm2718730ioc.5.2021.05.14.07.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:59:44 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Swap two calls in blk_mq_exit_queue()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
References: <20210513171529.7977-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d1b1f123-9b47-8805-0b86-2fa9f6b19bb5@kernel.dk>
Date:   Fri, 14 May 2021 08:59:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210513171529.7977-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/21 11:15 AM, Bart Van Assche wrote:
> If a tag set is shared across request queues (e.g. SCSI LUNs) then the
> block layer core keeps track of the number of active request queues in
> tags->active_queues. blk_mq_tag_busy() and blk_mq_tag_idle() update that
> atomic counter if the hctx flag BLK_MQ_F_TAG_QUEUE_SHARED is set. Make
> sure that blk_mq_exit_queue() calls blk_mq_tag_idle() before that flag is
> cleared by blk_mq_del_queue_tag_set().

Applied, thanks.


-- 
Jens Axboe

