Return-Path: <SRS0=EL0S=PV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178ACC43387
	for <linux-block@archiver.kernel.org>; Sun, 13 Jan 2019 16:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DEB20854
	for <linux-block@archiver.kernel.org>; Sun, 13 Jan 2019 16:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h9BCgz12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfAMQWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:22:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45853 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfAMQWV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Jan 2019 11:22:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so9194667pfd.12
        for <linux-block@vger.kernel.org>; Sun, 13 Jan 2019 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xGTUGaUsnkrHE3I4ytaWS6tuX9Ef328HUPpl0Zip+JA=;
        b=h9BCgz12uXcjyXiN19LiCb0lSGdfKtJ+KsvKDmu8XuK7K/zZsG/OSHKTGif4h9EH7c
         BXNm7eIQuUG7GQVQBuC1HqSmgyWtw+GNKghvU2fIvWsVza9UhYlMrT6at/SeTiCv3Pfe
         hOypNja0ktrzn6CVWx1MKd5cTllDBdOu5yymi1cdvCG4Z1mFsdkuqiZ7mwiblGGcT33t
         OiIJFu/Wt8kirJvhdpH8u+LPsIQzgi0yBiiX2GCFKkaoFDMYnqTofgE04Q1dwzJWZWp1
         I6Nx2Izvh66ZpBThxiJ2HlywkbIl3CtxMeYppSxVkb8z8o1xNoUOtWMWapQB7ju4dlqA
         CqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGTUGaUsnkrHE3I4ytaWS6tuX9Ef328HUPpl0Zip+JA=;
        b=PXdcLdsSumJRS+feumnM89D3F+JoiMOsh4bIZLeTBpP2GJhP+PRpsKzxcyXx1bf/iO
         gYT6SnqbD/lhGGCgNg8gFjLCRT3pe7B9YqEoNi708fMLElBbneDTvBaIJqJfuD6jQfr2
         wyWvB/m81VlPaVziJ4IBIVcqBTFZHRlpbZEREG9YmKGhxP2GMr8HEqnhQaK0RqzCmddM
         dxVx1lLEmDwtLd6zUmu/8FDoXTKRmDiySGCMKCBZpqWYUBVAxaUEj7WAE9l7h63cekMH
         jdxHcjXeKeKKgbODcPXRZjPnRRI0uHKfS3dRKDI9GXpVm+QhRi9xuSJ0pHN8rBVMf1wS
         0abw==
X-Gm-Message-State: AJcUukfj0PHjaDFXQaqOLdxPwlyvHb7F/coGG0M7zdRBnk1Ss7MyLxyh
        /PX2vfX46zxlIJqmpWCxxaNNFQ==
X-Google-Smtp-Source: ALg8bN43/u+99uzhQ/tJtqNbJtgZ7cajVfkImzFThqWf5uC+iqK6E5cQjQq3Ov1aoO3/7n98SvSVMA==
X-Received: by 2002:a63:314d:: with SMTP id x74mr19887928pgx.10.1547396540496;
        Sun, 13 Jan 2019 08:22:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e187sm106139906pfa.130.2019.01.13.08.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 08:22:18 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From:   Jens Axboe <axboe@kernel.dk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-6-axboe@kernel.dk> <yq1sgxzys3s.fsf@oracle.com>
 <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
Message-ID: <54976aac-bef2-880f-dc10-e3030189a08a@kernel.dk>
Date:   Sun, 13 Jan 2019 09:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/19 11:34 AM, Jens Axboe wrote:
> On 1/11/19 11:19 AM, Martin K. Petersen wrote:
>>
>> Jens,
>>
>>> +struct io_uring_sqe {
>>> +	__u8	opcode;
>>> +	__u8	flags;
>>> +	__u16	ioprio;
>>> +	__s32	fd;
>>> +	__u64	off;
>>> +	union {
>>> +		void	*addr;
>>> +		__u64	__pad;
>>> +	};
>>> +	__u32	len;
>>> +	union {
>>> +		__kernel_rwf_t	rw_flags;
>>> +		__u32		__resv;
>>> +	};
>>> +};
>>
>> A bit tongue in cheek and yet somewhat serious: While I'm super excited
>> about the 4 x 64 bitness of the sqe, where does the integrity buffer go?
>> Or the 128-bit KV store key. How do we extend this interface beyond the
>> flags?
> 
> For integrity buffers, how about we stash them on the side? The newer
> series has an extra system call, io_uring_register(), which is currently
> used for registering files and buffers for IO on the side. You could
> trivially tie an integrity buffer to an sqe through that.
> 
> For KV, I thint that's an actually interesting use case (sorry,
> integrity), and we might just want to bite the bullet and extend the sqe
> to full 64 bytes.  We're currently at 48 bytes, which leaves us with 16
> bytes of space for KV, and other use cases.

I bit the bullet and bumped the size. 64 bytes is a nicer size in terms
of cachelines anyway, and I really doubt that 48 vs 64 bytes makes a
size consumption problem for anyone.

The buf_index is only used for the fixed buffers, which means that we have
16 bytes / 128 bits that we can grab for things like KV.

-- 
Jens Axboe

