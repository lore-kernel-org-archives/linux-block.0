Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A00BC43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2552173E
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 19:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cJo0KC7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393290AbfIFTav (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:30:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44039 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfIFTav (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 15:30:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so5152444pfn.11
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2019 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GyxPezVm29JdDb7VEucfmunQmYEsUqlRx3OlLTLH5Ew=;
        b=cJo0KC7b4EI5hCIyXM02y/aqTAWBocdXEANLreCjyknneTFy1JDYhjqkw/Xsc3VLA+
         ZwJXSdZh49hRGmLyAnsoRfVW3Sgie0FToVCYTqCXjLpRz3yWUUi5ZY3NfZGl0YOoeotr
         WsDPP2oIPF1iokVHZHZUMf9PwFz/qml/mCAzwbXdrM9SRQg4a1FdyB7vMP05O7+NT+7Y
         Go5XhsCUAv/aKQrORx8ODTubcb6fQKPG8MKytBdsvAlrD0UNCOV7nI/DQF2gTRRh4lRr
         Pqas+YR8wpQpCbYp7bpUwvOnxLl6lV2DtxANN6epnFa8zd+Wxcp+xhSYE0UXFs1FkRJz
         Tq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GyxPezVm29JdDb7VEucfmunQmYEsUqlRx3OlLTLH5Ew=;
        b=pVyArXp1EgXW8/xV6aj9v0Gu3jmdH2KrFbwbu0PFQF4EUEjkb4pCGEOFAxpMQxe6Oc
         yK3XcKzt+9pFOpprlFz8sQVDlxFiT4mWCTFeYWcFa615uAmk2Phu2EYiLbHkqdMAxwzQ
         6w5hIPtFWFXNXEBEDDqzL6Xde5BTyYFYABp3X6oD8G7omcv5Y49EfNbp7ydiZPdIaBap
         hyHtQiyIBr+47+gi0LtZ9RWP25n5zscHEp/oOv76gna6L3IliLAxGYhA3dqYnUsGCodT
         V3DvxV481CT79zpO1UXGYEnYj+SyZ9zyYOIOimlkzW8xuMXULovVp+2KBLTzKChRoKJc
         n4qg==
X-Gm-Message-State: APjAAAWkBwjelcvxQ1XsiFrETbc10NB8wvoESXs9frfryLdYSPoX8dPX
        tCSFAkHRBl7Sk/cYdjM/xlib3hpVLpXgQg==
X-Google-Smtp-Source: APXvYqwU6KT+J+Arf4M26OI+JlIc/MdyU+mw4QjZNzgIULRNc6EBYQUL+Gkr9kJOvwhnttAKqoJwUw==
X-Received: by 2002:a65:6904:: with SMTP id s4mr9361662pgq.33.1567798250386;
        Fri, 06 Sep 2019 12:30:50 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id l62sm12861869pfl.167.2019.09.06.12.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 12:30:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] liburing: Use the single mmap feature
To:     Hristo Venev <hristo@venev.name>
Cc:     linux-block@vger.kernel.org
References: <c0ab3b6a-3e30-8a91-512e-aed9218015a7@kernel.dk>
 <20190906191252.30332-1-hristo@venev.name>
 <20190906191252.30332-2-hristo@venev.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8fe8111a-6564-4266-e6ca-443575eb9ca2@kernel.dk>
Date:   Fri, 6 Sep 2019 13:30:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906191252.30332-2-hristo@venev.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/6/19 1:12 PM, Hristo Venev wrote:
> Signed-off-by: Hristo Venev <hristo@venev.name>
> ---
>   src/setup.c | 35 ++++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/src/setup.c b/src/setup.c
> index 47b0deb..48c96a0 100644
> --- a/src/setup.c
> +++ b/src/setup.c
> @@ -16,10 +16,30 @@ static int io_uring_mmap(int fd, struct io_uring_params *p,
>   	int ret;
>   
>   	sq->ring_sz = p->sq_off.array + p->sq_entries * sizeof(unsigned);
> +	cq->ring_sz = p->cq_off.cqes + p->cq_entries * sizeof(struct io_uring_cqe);
> +
> +	if (p->features & IORING_FEAT_SINGLE_MMAP) {
> +		if (cq->ring_sz > sq->ring_sz) {
> +			sq->ring_sz = cq->ring_sz;
> +		}
> +		cq->ring_sz = sq->ring_sz;
> +	}
>   	sq->ring_ptr = mmap(0, sq->ring_sz, PROT_READ | PROT_WRITE,
>   			MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_SQ_RING);
>   	if (sq->ring_ptr == MAP_FAILED)
>   		return -errno;
> +
> +	if (p->features & IORING_FEAT_SINGLE_MMAP) {
> +		cq->ring_ptr = sq->ring_ptr;
> +	} else {
> +		cq->ring_ptr = mmap(0, cq->ring_sz, PROT_READ | PROT_WRITE,
> +				MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_CQ_RING);
> +		if (cq->ring_ptr == MAP_FAILED) {
> +			ret = -errno;
> +			goto err;
> +		}
> +	}
> +
>   	sq->khead = sq->ring_ptr + p->sq_off.head;
>   	sq->ktail = sq->ring_ptr + p->sq_off.tail;
>   	sq->kring_mask = sq->ring_ptr + p->sq_off.ring_mask;
> @@ -34,19 +54,14 @@ static int io_uring_mmap(int fd, struct io_uring_params *p,
>   				IORING_OFF_SQES);
>   	if (sq->sqes == MAP_FAILED) {
>   		ret = -errno;
> +		if (cq->ring_ptr != sq->ring_ptr) {
> +			munmap(cq->ring_ptr, cq->ring_sz);
> +		}
>   err:
>   		munmap(sq->ring_ptr, sq->ring_sz);
>   		return ret;
>   	}
>   
> -	cq->ring_sz = p->cq_off.cqes + p->cq_entries * sizeof(struct io_uring_cqe);
> -	cq->ring_ptr = mmap(0, cq->ring_sz, PROT_READ | PROT_WRITE,
> -			MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_CQ_RING);
> -	if (cq->ring_ptr == MAP_FAILED) {
> -		ret = -errno;
> -		munmap(sq->sqes, *sq->kring_entries * sizeof(struct io_uring_sqe));
> -		goto err;
> -	}
>   	cq->khead = cq->ring_ptr + p->cq_off.head;
>   	cq->ktail = cq->ring_ptr + p->cq_off.tail;
>   	cq->kring_mask = cq->ring_ptr + p->cq_off.ring_mask;
> @@ -105,6 +120,8 @@ void io_uring_queue_exit(struct io_uring *ring)
>   
>   	munmap(sq->sqes, *sq->kring_entries * sizeof(struct io_uring_sqe));
>   	munmap(sq->ring_ptr, sq->ring_sz);
> -	munmap(cq->ring_ptr, cq->ring_sz);
> +	if (cq->ring_ptr != sq->ring_ptr) {
> +		munmap(cq->ring_ptr, cq->ring_sz);
> +	}
>   	close(ring->ring_fd);
>   }

Thanks, applied.

-- 
Jens Axboe

