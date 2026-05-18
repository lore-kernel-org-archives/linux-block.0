Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E983EBF3B
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100209; cv=none; b=qKfmJC6Cv8dDcJDdqeEQxrYk+8IcFVjiwi92aEKd5UgtjsfgHOPzPaVmfNQB9YZpx9IyKClgcQBm8C4Er1UC9Rje4EplI/ueP+P27mepgHb5wp+LoW8zhbTeQsWghEwUxvia7C0GkqJdatWZxH3aWCMM3ZdGMnAAbWXaUfZNck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100209; c=relaxed/simple;
	bh=FbvAJUBaJSoNOddpm6KcOlO9qRGB7h6zbd7g73ujdLc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EzIe46M6tflUfhx3/bS6IL/rDVZ+AvO+RB+4bX6yFMSEkgithA9fQA8pP6pYC7ANU3fKLspyZQQLx4WwsP5aRIYcXOnyi3JLlvnwJFIvcyE5duzdxRWSKLUAYdub6mNE650fCJRxPCfOe7SqWI9yUpJh30nFzQ4AUymDEyx1QOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJQ4iM0Y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJQ4iM0Y"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4526a8170ceso831290f8f.2
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100196; x=1779704996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=;
        b=AJQ4iM0Y3atulw0PqPF8op4PRnWpRVYOty/GNjhKqmtpas6RAxpBy+PRn9KMn1Wno2
         qjZPw+EhhE0hOFeMi5Jmm2umUnXHc9uHE6Sc4jCIy8Ms4gDmWbAja3yDgp1f0sakvIzo
         mND0MAlV95AGumFfzHSvL6fn/HmzZMpLelmMNL/OqSMvfJdhoE33lGksAXwRGKhpz9y3
         MUxmm5rukKAQCGvtg3KEsHI7vG7ayeRK0NXm2lTRYxEUjs5WhyITg3Gsh7qemErQcLpo
         H/MeM/3buitXkpHJfEHCNh+4Lx9a+L/jbz0S914lIrMYWChf5levhxDB0NWAD/C8QyT9
         dHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100196; x=1779704996;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBM/MqSlhfscJgewJTDJnR/WZOfF3ZaH9qUvK+mYr0I=;
        b=YKqvxYHiQ7+PD243kpuD3R5XHJprNN5t0RH8n/WkPN2sxx1e2TC/4EahpgieBXYX8J
         /JcbaGTN7E/tx9cHdf8YGiqGl9ateNhjmJXkaGjzP09RcKIXiRVLqPOSrVcUBsmUjhk2
         0m7IR404npXvjJ/ey/80OjilHbYT2MHH1ip/yRBz28zvkTygAQlSoMnkx0QBRytcYL2u
         adJWVXmMEKIIl96/DPJ/nyJpSyQvp4R+PUP5b8FwivX6qAprthaBmDVoL0WiXYEdLF3O
         UJW1nxeqbZLtKwAocwC7GMoNCoqYsmoNF0g5xJLuCMchGZbrSVFQV41tb7F2uvjH8cbF
         XPNg==
X-Forwarded-Encrypted: i=1; AFNElJ9UBy0ltadoCXpLQuX4IULrILhOHPg6Iw1wStAaQXfWuseJaRcEpuQYuV7usnPrwdIiMz36ZV6hIHhATg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTSEX8Ba0Z9vWi39vn5FhkVQoEo5STkOY+qYTszUS0ApX2wMN
	MD0/os/rL6lIpHnNv6MPeauUzg+GB261fLd5UHjMGcDMw+1AX4Ik+esM
X-Gm-Gg: Acq92OHVz3qcpBowFsapr96RBIDGlp0f1ERl6G3Tbae0xRhvBY6hGqaCwJgOb9ygpqp
	acXxWohZVtvr4W4Ibfx2nr3XISi0yf/SPXK9NipkWVCzSG+oe85NRNZYKGejQBmbwhTL3zzQApf
	moRAhk2mXZJ9p7GKjP9VMDxlFPeGBtuRFbIZyJ7Z7ih7oqysbzPg40Gd4ogq97VVru4fSArRSTD
	rp/lKFid+NJnLb2lOXa84+K+/VLsALRItp4Gj08i9dohLHXq3GHgCTOx/ZMWurWdHPyeNVpd8vG
	hqm8EVU+F/nQNLppVWBk6Us1+L4Y+Va8WcFGgCBrXGJaQGXM0yCN5JtJxSoBpFWaJPft/V434n/
	yCzTxiDtDTc9c9NREjApeftpZf5v3REgkk/2pnjlGoZWIgLQcolTeucvJ618NHSVMs6ZMH3s79R
	M3M7CwFdW7yQ+DYYgUCQKDH0U9sELtltznnlP6oe/owhUkFscSWcnsyVN9WC4XiiBaEHi2MCFqm
	8aTaZdupbSFjXKktMp96ABHH5aNnNt/WrgQL4Ne9zyCN8UgjKqMM6whXBU=
X-Received: by 2002:a5d:5885:0:b0:43c:f7e5:817b with SMTP id ffacd0b85a97d-45e5c5cc2b5mr22613508f8f.19.1779100196106;
        Mon, 18 May 2026 03:29:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:ec20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm36537426f8f.34.2026.05.18.03.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:29:55 -0700 (PDT)
Message-ID: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
Date: Mon, 18 May 2026 11:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
Content-Language: en-US
In-Reply-To: <20260513081929.GD5477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:19, Christoph Hellwig wrote:
>> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>> +		bio->bi_io_vec = bio_src->bi_io_vec;
>> +	} else {
>> +		bio->dmabuf_map = bio_src->dmabuf_map;
>> +		bio_set_flag(bio, BIO_DMABUF_MAP);
>> +	}
> 
> This is backwards, please avoid pointless negations:

I can flip it, but compilers tend to prefer the true branch. E.g. this

if (cond) A; else B;
C;

can get compiled into:

jmpcc cond B
A: ...
C:
return;
B: ...
jmp C;
  

> 
> 	if (bio_flagged(bio_src, BIO_DMABUF_MAP)) {
> 		bio->dmabuf_map = bio_src->dmabuf_map;
> 		bio_set_flag(bio, BIO_DMABUF_MAP);
> 	} else {
> 		bio->bi_io_vec = bio_src->bi_io_vec;
> 	}
> 
>> +	if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>> +		nsegs = 1;
>> +
>> +		if ((bio->bi_iter.bi_bvec_done & lim->dma_alignment) ||
>> +		    (bio->bi_iter.bi_size & len_align_mask))
>> +			return -EINVAL;
>> +		if (bio->bi_iter.bi_size > max_bytes) {
>> +			bytes = max_bytes;
>> +			goto split;
>> +		}
> 
> Please add a comment explaining why nsegs is always 1 here.



> 
>> @@ -424,7 +424,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
>>   	switch (bio_op(bio)) {
>>   	case REQ_OP_READ:
>>   	case REQ_OP_WRITE:
>> -		if (bio_may_need_split(bio, lim))
>> +		if (bio_may_need_split(bio, lim) ||
>> +		    bio_flagged(bio, BIO_DMABUF_MAP))
>>   			return bio_split_rw(bio, lim, nr_segs);
> 
> The BIO_DMABUF_MAP check should go into bio_may_need_split.

Ok
>> +static inline void bio_advance_iter_dmabuf_map(struct bvec_iter *iter,
>> +					       unsigned int bytes)
>> +{
>> +	iter->bi_bvec_done += bytes;
>> +	iter->bi_size -= bytes;
>> +}
>> +
>>   static inline void bio_advance_iter(const struct bio *bio,
>>   				    struct bvec_iter *iter, unsigned int bytes)
>>   {
>>   	iter->bi_sector += bytes >> 9;
>>   
>> -	if (bio_no_advance_iter(bio))
>> +	if (bio_no_advance_iter(bio)) {
>>   		iter->bi_size -= bytes;
>> -	else
>> +	} else if (bio_flagged(bio, BIO_DMABUF_MAP)) {
>> +		bio_advance_iter_dmabuf_map(iter, bytes);
> 
> This is a bit of a mess.  You're using bi_bvec_done for something that
> is not bvec_done, which makes the naming very confusing.  That is even
> more confusing than the existing usage, which isn't great.  Also we
> add yet another conditional to heavily inlined code.  I'd suggest
> the following:
> 
>   - add a prep patch to rename bi_bvec_done to bi_offset, as even for
>     the existing usage it is the offset into the current bio_vec as
>     much as it is the count of byes done, as those must be the same
>     and it is used both ways
>   - add a prep patch to also increase bi_offset for bio_no_advance_iter.
>     It is not actually use there, but incrementing it is harmless and
>     this will avoid a new special case
>   - please also documet this new usage in the commet in struct bvec_iter.
>   - then just add the dma buf mapping to the bio_no_advance_iter condition

I'll take a look

>   - figure out what to do about dm_bio_rewind_iter, which pokes into these
>     things that really should be block layer internal

Need to check what that is, but doesn't implement the interface and
is not supposed to ever see the dmabuf iterator.

>>   }
>> @@ -391,7 +403,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
>>    */
>>   static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
>>   {
>> -	if (iov_iter_is_bvec(iter))
>> +	if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
>>   		return 0;
>>   	return iov_iter_npages(iter, max_segs);
>>   }
> 
> Please update the comment for this helper.
> 
>> @@ -322,6 +327,7 @@ enum {
>>   	BIO_REMAPPED,
>>   	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>   	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
> 
> Shouldn't this be a REQ_ flag as we should never mix and match bios with
> and without this flag in a single request?

Do you mean adding both and propagating it from bio to req? submit_bio()
takes a bio, so we still need to set it there before it reaches blk-mq.
And there might be bio-based drivers using it in the future.

-- 
Pavel Begunkov

