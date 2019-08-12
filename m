Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F0EC31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33A1206C2
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfHLNzv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:55:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47090 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfHLNzv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 09:55:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so12320546pgt.13
        for <linux-block@vger.kernel.org>; Mon, 12 Aug 2019 06:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LmC97YXGnZTSjxmeoZi/iLf2BGh3V1ch9DlmzSBB7ac=;
        b=fVDWk5JZSnp68BVr+d3pqtxJOvB4Jbl25zUUo6CISSbqfIBMJZoY+fKSnJANuA2VOf
         aQ7AA0TGG6kGUdTHNNH82CuEtWYZpCD7HJ+AROOjp7YNk8GTJZnlfm4fo4nU5f051hoM
         YHLZmJECURck+tBZveAaUzDTZ9BxcHa+8lIvXPebM7ZQiwmJrq3ozRenJm1pSEsie9x5
         nTJo6nR2k0lzITU+8rkqquzDf1syUwthbRCddGj6TKLsgMEkcJkNrErQoRzhCOSlgaaQ
         yRtQcwMmielw/u275SUA+XCOH17mugpd2an6+QnA+srzOftll9++3vrRUXzt5i2X523J
         Qh2Q==
X-Gm-Message-State: APjAAAVB2s2BiUNrR5uKJoyNkgWtgCJqImM0GhxRDLOT+ZSkiBbBcvYJ
        gSYS77001U9Vnlz/UNax2uw=
X-Google-Smtp-Source: APXvYqzymYfa25Gey+g2OGtWvwEl0NYsg9/Tlj9PQ1vfL28V1r16OU/ehqdhtX7jt4Yje6EBsUesZA==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr35763777pfd.19.1565618150603;
        Mon, 12 Aug 2019 06:55:50 -0700 (PDT)
Received: from asus.site ([2601:647:4000:7f38:138a:21ca:d24:734b])
        by smtp.gmail.com with ESMTPSA id a10sm13212694pfl.159.2019.08.12.06.55.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 06:55:49 -0700 (PDT)
Subject: Re: [PATCH] liburing/barrier.h: Add prefix io_uring to barriers
To:     Julia Suvorova <jusual@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
References: <20190812123933.24814-1-jusual@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <592fe38c-1fa2-9ba5-cd6c-da69c95edb33@acm.org>
Date:   Mon, 12 Aug 2019 06:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812123933.24814-1-jusual@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/19 5:39 AM, Julia Suvorova wrote:
> -#define mb()	asm volatile("mfence" ::: "memory")
> -#define rmb()	asm volatile("lfence" ::: "memory")
> -#define wmb()	asm volatile("sfence" ::: "memory")
> -#define smp_rmb() barrier()
> -#define smp_wmb() barrier()
> +#define io_uring_mb()		asm volatile("mfence" ::: "memory")
> +#define io_uring_rmb()		asm volatile("lfence" ::: "memory")
> +#define io_uring_wmb()		asm volatile("sfence" ::: "memory")
> +#define io_uring_smp_rmb()	io_uring_barrier()
> +#define io_uring_smp_wmb()	io_uring_barrier()

Do users of liburing need these macros? If not, have you considered to 
move these macros to a new header file that is only used inside liburing 
and such that these macros are no longer visible to liburing users?

Thanks,

Bart.
