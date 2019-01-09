Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A38C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9D206BB
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JvZ9Veal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfAIRGj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:06:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33813 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfAIRGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 12:06:39 -0500
Received: by mail-io1-f66.google.com with SMTP id b16so6616299ior.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLs8rbpdT+9wp7vzUb5y9un4CY9VNlQGGtrc/mNlnUs=;
        b=JvZ9Veal7f674t7GFefN2425mUlgTbU7JM3HQBozUyTPIGXpYNH8dc7atLynfHce1F
         oVx1Nu6YXhm1eViuloSzE6oVRSvl/s3iy8m9vsp4Ywg6OxK4cQQLA8YTIfSDQVAs1683
         +qY3l0QOYkChzxhD2qF4X2SmutbeIfLdv+3Alz0dokqmCkzFLY7jEA9MaUhPvCgQEhX6
         WTOUGFKuiwF5ZynfCnLTcnlrfFOvEIKf66q7y27b35YtGzlaSIc/QcAxm4G+i6ZMnWz7
         G9bPj9jo7MiOIHZzRlv5Ur5vDO+FvnaRzkS7JnZiYKURlaUuoDHU5C5TUZnsZ08a9buQ
         r/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLs8rbpdT+9wp7vzUb5y9un4CY9VNlQGGtrc/mNlnUs=;
        b=tLU7MESB4ojNqR2r/pLb+HVDxXOx9+bVwxUT7uagGHQ9GapDKbqGJwz6Mrqxf0BudG
         GdsbfF2mPSrE5acc/wHvxctlaT94CXBZlDllincC3H9JMJSAqpbah3DMMwIKTZX7tmhL
         zfSpVSI2NNstk16xrEGSgVwOfAKy6E+o2jFAp/bRgJ1IF8YI3fOioBYTJ+BM3Jb8hJta
         jmx83nf/JehB+bQ1V2KN7VMCeIfXXNNyab9UDNN3Xk+rSLzITV2uY96q7C7VlY0piHfU
         TvGEwjusHMX0Z8TuoMuYIvZfHcFYdk+Gi6JEvwnLO+EnaynPut0955R2sZtxcoxLC4lX
         jaCQ==
X-Gm-Message-State: AJcUukeOGQgPFUwujpnnXJ7yGmeZc36d9EDUcByfjLnP+I3W2J/BtVZt
        80fIYmldIL4KQoTQDU43AIoJJw==
X-Google-Smtp-Source: ALg8bN4IZbR2PzPiqTasczSxHTY1uraVokwxU+tnjq94anuVLIULH6rK8OXTAM8RaSKXU1GCPekHrw==
X-Received: by 2002:a6b:6919:: with SMTP id e25mr4200482ioc.119.1547053597914;
        Wed, 09 Jan 2019 09:06:37 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l186sm6323218itl.22.2019.01.09.09.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 09:06:36 -0800 (PST)
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190108165645.19311-1-axboe@kernel.dk>
 <20190108165645.19311-14-axboe@kernel.dk> <20190109121638.GE13779@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c6797e8-c517-3d03-0837-ad68a729a733@kernel.dk>
Date:   Wed, 9 Jan 2019 10:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109121638.GE13779@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/19 5:16 AM, Christoph Hellwig wrote:
>> +static int io_setup_rw(int rw, struct io_kiocb *kiocb,
>> +		       const struct io_uring_iocb *iocb, struct iovec **iovec,
>> +		       struct iov_iter *iter, bool kaddr)
>>  {
>>  	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>>  	size_t ret;
>>  
>> -	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>> +	if (!kaddr) {
>> +		ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
>> +	} else {
>> +		struct io_ring_ctx *ctx = kiocb->ki_ctx;
>> +		struct io_mapped_ubuf *imu;
>> +		size_t len = iocb->len;
>> +		size_t offset;
>> +		int index;
>> +
>> +		/* __io_submit_one() already validated the index */
>> +		index = array_index_nospec(kiocb->ki_index,
>> +						ctx->max_reqs);
>> +		imu = &ctx->user_bufs[index];
>> +		if ((unsigned long) iocb->addr < imu->ubuf ||
>> +		    (unsigned long) iocb->addr + len > imu->ubuf + imu->len) {
>> +			ret = -EFAULT;
>> +			goto err;
>> +		}
>> +
>> +		/*
>> +		 * May not be a start of buffer, set size appropriately
>> +		 * and advance us to the beginning.
>> +		 */
>> +		offset = (unsigned long) iocb->addr - imu->ubuf;
>> +		iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs,
>> +				offset + len);
>> +		if (offset)
>> +			iov_iter_advance(iter, offset);
>> +		ret = 0;
>> +
> 
> Please split this code in a separate helper.

Done

>>  	if (unlikely(!file->f_op->read_iter))
>>  		goto out_fput;
>>  
>> -	ret = io_setup_rw(READ, iocb, &iovec, &iter);
>> +	ret = io_setup_rw(READ, kiocb, iocb, &iovec, &iter, kaddr);
> 
> And I'd personally just call that helper here based on the opcode and
> avoid magic bool arguments.

Then we can also fold the switch cases, cleans it up.

>> +		down_write(&current->mm->mmap_sem);
>> +		pret = get_user_pages(ubuf, nr_pages, 1, pages, NULL);
>> +		up_write(&current->mm->mmap_sem);
> 
> This needs to be get_user_pages_longterm.

Done

>> +	 * We don't use the iovecs without fixed buffers being asked for.
>> +	 * Error out if they don't match.
>> +	 */
>> +	if (!(p->flags & IORING_SETUP_FIXEDBUFS) && iovecs)
>> +		return -EINVAL;
> 
> I don't think we need the IORING_SETUP_FIXEDBUFS flag at all, as a
> non-zero iovecs pointer is enough of an indication.

Good point, no point in that redundancy. Fixed.

-- 
Jens Axboe

