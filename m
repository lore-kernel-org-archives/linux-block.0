Return-Path: <SRS0=rsSL=Y2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9305BCA9EC7
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC5B2080F
	for <linux-block@archiver.kernel.org>; Sat,  2 Nov 2019 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TRgUnVcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfKBODq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 10:03:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45019 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfKBODq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 10:03:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id e10so8218185pgd.11
        for <linux-block@vger.kernel.org>; Sat, 02 Nov 2019 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rtuDPqJZ0XL0I3niBJJ+k2E1GedQ1MMy4bRevHQ+bw4=;
        b=TRgUnVcByAkYuvAlQNyPJkaDxxox1KYzIF5hquLLmn0AzhQt8aFInkbMxUqlURVXiB
         9QU50KrAmHGHmTDL2tmOXlQb86gQ8unGF489aAc1bnZiHQO++EHlyIys5M3tf0eQW9+S
         gg1W4vqdPvVdaWzmfeQ440jYVaDjpPXZg1yOKdsWpoEedXp/TNJt7FA5ldPmWon+k/XW
         AVtsx8+ydQQGGUia1foFd5z5v2GNXn1TjrQKrKvuG+IgqthJA0asa59G72PtTabQpuZS
         fkQZn/uW1mjGIFz/k+Lkvy3z1+ZXGXUEjy7troJE0PnxRbIL4ZUCFFIhPwkvQGiYkQEy
         CaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rtuDPqJZ0XL0I3niBJJ+k2E1GedQ1MMy4bRevHQ+bw4=;
        b=Fei0BJibHXy0NUmdbEWaruk6Z1Jw8IWInrsq0X11U9+p30yD958X6P3WcTRZ4j4rD8
         b4VtAcRqYHr9nP8id3OYrRNGmuY4VxcoxlZ9/Sd02sEGmW+HtPw6yjxiPagFXbGH/uqb
         XGIqTpMP173/sArqQrPChBTumeDgVp/TyV0ghczU/UdrHI2+1w1ofVTrPleLe/KJcLbn
         E1Ilua7fH28L0+dSrp1KnT9M0sEGdGKKMf0NL11Yin28GAsrkxEZzsCmbvY+lTEE80RW
         J8WwTXMtwqlaiV1tgnij1ZvW9ESF8G4tiGXnsTruZcB29ApmTDeHCby4zdrdnV8PORKR
         FRgA==
X-Gm-Message-State: APjAAAUs7a3WyPFv5D3K5haPXUuN+DFx182uF+qKXe9gUK4mmtUbsBns
        2d/twoyZZf5PmjwvflLEXSOvew==
X-Google-Smtp-Source: APXvYqzAGyaSRBGFZuWmHK1zrMVvhmAYfeg6v+AAzMTYsYhCLLu7ILJkm2DMFJVLiC4rb8ZjP2u+9g==
X-Received: by 2002:a65:6290:: with SMTP id f16mr20439011pgv.40.1572703425334;
        Sat, 02 Nov 2019 07:03:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x20sm9174065pfa.186.2019.11.02.07.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 07:03:44 -0700 (PDT)
Subject: Re: [PATCH V4] block: optimize for small block size IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-bcache@vger.kernel.org
References: <20191102072911.24817-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <606b9117-1fb6-780b-8fb1-001c06768a2e@kernel.dk>
Date:   Sat, 2 Nov 2019 08:03:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102072911.24817-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/19 1:29 AM, Ming Lei wrote:
> __blk_queue_split() may be a bit heavy for small block size(such as
> 512B, or 4KB) IO, so introduce one flag to decide if this bio includes
> multiple page. And only consider to try splitting this bio in case
> that the multiple page flag is set.
> 
> ~3% - 5% IOPS improvement can be observed on io_uring test over
> null_blk(MQ), and the io_uring test code is from fio/t/io_uring.c
> 
> bch_bio_map() should be the only one which doesn't use bio_add_page(),
> so force to mark bio built via bch_bio_map() as MULTI_PAGE.
> 
> RAID5 has similar usage too, however the bio is really single-page bio,
> so not necessary to handle it.

Thanks Ming, applied.

-- 
Jens Axboe

