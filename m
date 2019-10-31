Return-Path: <SRS0=XfYF=YY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B46CA9ECB
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D1D208E3
	for <linux-block@archiver.kernel.org>; Thu, 31 Oct 2019 19:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cnJ75Phx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfJaTaV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Oct 2019 15:30:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40926 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfJaTaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 15:30:20 -0400
Received: by mail-io1-f67.google.com with SMTP id p6so8072295iod.7
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2019 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5CaFlXjtkuWrqgObk1xIFzdL468BAaElg04+Ot6PxZY=;
        b=cnJ75Phxa94kDFKMeodveaEb6dSA8BSCWSR3btI4oKmF1D7j2hiM6pxpsza6RHPngF
         /pnjS5RzUUXoxtHaNJ+knYm4HVm9m7XP6MZNuTB0Ky7wnj2InxNjuskMw3DNmq3Fr2AU
         TsSV/TRc+2LOGeHa2Lkeo8MPpPF0Tbae6k2S8LwH/9+dZzKvaEysMTGONwqm28lbKtP7
         wPoNa3IMWxQAkTLwQ7DQV3LiNR8sgIgbzNrJ0BhScEymRNb2K/JoNYy/8iypASdEpPIt
         W/mXrilrYZHGgazV0bp0yDUw1uzJ7/qHHvYwewrDclbdeP1HXTFJkMKXybekgoeLOgt0
         tRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5CaFlXjtkuWrqgObk1xIFzdL468BAaElg04+Ot6PxZY=;
        b=akN0FiWY653Cd5AlCfCJqk/TWBlIhpHvJlECCeJe8mgk+u8fkNbatfqIGvjxqfB0wo
         OqnqxUMflMu6c9HJ34UTPBwggmYVps6+o2AnUhmQqk+GfT88G6FPGqIZGVGF5N0UsPyq
         3snwgu7+PA9Rm+6XyniZtUHiamjtUPgKUqS4xvhSafupg4ukbp8XXS4eUADmVbKP5B25
         MZwE8b8Oc7PcVPcfMh2l5d4amoNnEDHQe9lGFEIx3I+wqqrE8A5gW+Iuca5qe96rQzBL
         2besjsGdD+/seVxVwOhFvmjOKAZ3P8igMea3PEMqSioy8TBnSbXWqJ4Ev1cGFakH12vp
         wN5g==
X-Gm-Message-State: APjAAAWjAGm3DxaB3s1pTG8LHURw1EpDhXOkely+duSvQ8Kca/vK5iKJ
        MGPfexkf+J6YFEkU1iIzZlFRJp/zUZO9Yw==
X-Google-Smtp-Source: APXvYqz6d0/5QKsPZLekkIbIa0FqohAazvtWQQG2gSk1poMS9o7Y2c1jYXIJiZshkSY9n3DLbv+/Nw==
X-Received: by 2002:a6b:6106:: with SMTP id v6mr6832147iob.79.1572550219625;
        Thu, 31 Oct 2019 12:30:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x17sm681319ilh.22.2019.10.31.12.30.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 12:30:18 -0700 (PDT)
Subject: Re: [PATCH] block: retry blk_rq_map_user_iov() on failure
From:   Jens Axboe <axboe@kernel.dk>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c8718f10-0442-de4f-edfc-ecc6fe28b768@kernel.dk>
Message-ID: <fec5226c-d13b-a7ef-cb3a-217b26a1aa22@kernel.dk>
Date:   Thu, 31 Oct 2019 13:30:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c8718f10-0442-de4f-edfc-ecc6fe28b768@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/19 1:26 PM, Jens Axboe wrote:
> We ran into an issue in production where reading an NVMe drive log
> randomly fails. The request is a big one, 1056K, and the application
> (nvme-cli) nicely aligns the buffer. This means the kernel will attempt
> to map the pages in for zero-copy DMA, but we ultimately fail adding
> enough pages to the request to satisfy the size requirement as we ran
> out of segments supported by the hardware.
> 
> If we fail a user map that attempts to map pages in directly, retry with
> copy == true set.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I did actually add comments to this, but apparently sent out the version
without comments... Current one below, only difference is the addition
of the comment explaining why we retry.


diff --git a/block/blk-map.c b/block/blk-map.c
index 3a62e471d81b..4ca7c5db7d78 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -137,6 +137,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	else if (queue_virt_boundary(q))
 		copy = queue_virt_boundary(q) & iov_iter_gap_alignment(iter);
 
+retry:
 	i = *iter;
 	do {
 		ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
@@ -154,6 +155,18 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	__blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
+	/*
+	 * If we fail and we're in direct map mode, retry once with copying
+	 * enabled instead. This can fix the case where userspace wants to
+	 * do a large IO, but fails because the application memory is
+	 * fragmented and we end up exceeding the number of segments for the
+	 * request. With a copy == true retry, we aren't at the mercy of
+	 * application memory layout.
+	 */
+	if (ret && !copy) {
+		copy = true;
+		goto retry;
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_user_iov);

-- 
Jens Axboe

