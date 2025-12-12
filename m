Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E62877DC
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504573; cv=none; b=cnOCltvqnF5BMR+yfs4AdzKcqYlPnmS/lc7kRpAtcxCCgiHKufG5iAnZ0E32euWegK4adBTVbHLJ2J9h5CYKgzcQLgJlAcevg6Hh+X/nKZWb/MGzSA6BzAnbucGxO0N/S0fHVYbkE2wmJG0XVPyub70+d2qPabUHcS8IA6ZtiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504573; c=relaxed/simple;
	bh=YN2oZNmZdtxBobbMK58uZROnBIWaMV+gLny5VUocsy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0rws5JkVgSxr4giQ6zTRib1Uv0relMkDYlUXa4xdiYogGHqxXNsKMg8828yKoXPIuuX7mFzZ5WTda0lfQhpHUc8psCpM8HaeulR/Q/VxV5vHnIJO3iBKdNhhQDTbIQNTB+wltsIRbBgIdiTH3hLSEDPoIlXX7t8HO7L/AkBwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNkpr9h8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNkpr9h8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29845b06dd2so8562635ad.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 17:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765504571; x=1766109371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJsiZe/XqcKJjkVqYeKzXPFPwj1/tSmTc15CXhIwXUk=;
        b=JNkpr9h8tzSgD/ITtuuSPYoPvuKOxTQ+uj9Dd23MtZVSBKijHQkNaEqPUIaerLHbFN
         jJn/AkTDwdrL2GQkuLZxBpl1I4Funxh83g4z/yd9PKb5P3d82bdxOdElZaan3mi8MYYi
         Ip7zzxAfHApGTvHpcog4XUR+f3FNfjQ4gO1rZ4mT2YpNpKcugbHUqsIqxQpZ4YhvHK6t
         0wPJlvUs9Dt8fdrsh5k1fvhH7O1Ws8H2W1Qn5qmUBbSOKgm2ZHkw1atlzL5wbJWvpy+C
         jQdCPrNbo5wh1+IkjuGRXMl0ZFrOwt+eBWGj9F4kn8ym3WC4brSu1I++jkFefmV2x2UG
         UzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765504571; x=1766109371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJsiZe/XqcKJjkVqYeKzXPFPwj1/tSmTc15CXhIwXUk=;
        b=p+cFhBdds6oVa4Tqme4sUKzYiyp6y07PqYf9uIHzv43ZCw4lCZWOwTxKAyVjG/NTIg
         y0+GkX8nlMPwfYtiw+1+4nbf355c3rxOsiA+CWk6XBKVYVS3HNbd1LDxv6UV0Sag4Nmb
         ltP1KKnBXyhAC3HuT77y2eo6u1gg3y1su71FomeKiSEDVbdI4pT5E53/YpVb60+siCRR
         gsllkReogEcGk+O1oHqjXBiXjUiZkyVgYOHor00gd2x0RHzFpCtNNVix7CGSDVNVM6zC
         kZK7BWlVThZ+fa/0IctqnDokQthEmZKGtxbKcudzBkzjzrcjclkDHjH4sxpYqZJHykcm
         IQqw==
X-Gm-Message-State: AOJu0YxQFh5UnLOzQmXdNuJBRWqVEDI1avmA6FzovgCb3CEkUPl/GGVA
	L8wqRuK8VDpsgC39KxobLNs9iHU/AWiPJXwe3SbPW25HqBJAuRykSqSiXWnkxW8V
X-Gm-Gg: AY/fxX7gX8OnjIyuKndUkzyy5gqL7aQNLydgORqhx5gNwqcwbKfNKjsaFQVpACUj4jO
	Ws7zCX7+XyTK4J8ULp3Slpml0/vLxQwe/HMnokTCxEouKG+X9Ry8rmY957SvQi40AdwM7YuhFtg
	MB7s8z18VeuNk50LHrh/xzUKcX3mHMoP++yGLmoh01h317qQETMSpKCNBsBBoE+ZTDqk1Ct5dyC
	yfqSvKqNFRlnVxl1UJqJcqjUsdiUaF3oPfjlReQagWfxJdGry8aG7X92gQZ6Bewb2prWs1nOFV5
	RTwo7R97U56swJiyXQ5inrqZLqMoBA7EObjd6z7IHxpKYyqfUW38anq7wuD5uYk1scnFnCzB6BO
	cI7r0fNJX/ViSmJOTzrBzzA+bSMXB5MOs/8g45596PvfqCbNl7yL2vaAlUaDUDqzeKPI9WM6O3M
	eGdKUI0Zc7Me0B1wP6TfosWBcVo2e8cLjq9VbJvjJ6H8QV59J4ZcCor2fIvg7Nnbm+A0NB7frrH
	C5MPU5IpOS+pfKEaT1wQGw3Qm56jfxNW7XS/jqAAmU5M0xbLo8=
X-Google-Smtp-Source: AGHT+IHrNZHNZ799rRWGx+LvO7XaRwwtcVkWXSf4q+3pQ1pJSMCA4DafAXljIyZfD2BV+qpIbTHyew==
X-Received: by 2002:a17:902:d4c9:b0:29e:ba45:350e with SMTP id d9443c01a7336-29f23cd48c2mr6283765ad.44.1765504570758;
        Thu, 11 Dec 2025 17:56:10 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016ac2sm36260535ad.49.2025.12.11.17.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:56:10 -0800 (PST)
Message-ID: <eb72c089-a6ba-48df-a215-af35d5dd808b@gmail.com>
Date: Fri, 12 Dec 2025 01:56:16 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <aTFo-7ufbyZnEUzd@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFo-7ufbyZnEUzd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 10:56, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:25PM +0000, Pavel Begunkov wrote:
...
>> +	struct request_queue *q = bdev_get_queue(file_bdev(file));
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return ERR_PTR(-EINVAL);
> 
> Shouldn't the O_DIRECT check be in the caller?

If the interface will get implemented e.g. for net at some point, it
won't be O_DIRECT. If you want some extra safety for fs implementing
it, I can add sth like below in the common path:

if (reg_or_block_file(file))
	// check O_DIRECT

> And a high-level comment explaining the fencing logic would be nice
> as well.

I'll add some comments around

...
>> +static inline
>> +struct blk_mq_dma_map *blk_mq_get_token_map(struct blk_mq_dma_token *token)
> 
> Really odd return value / scope formatting.

static inline struct blk_mq_dma_map
*blk_mq_get_token_map(...)

Do you prefer this? It's too long to sanely fit it in
either way. Though I didn't have this problem in v3.

  
>> +{
>> +	struct blk_mq_dma_map *map;
>> +
>> +	guard(rcu)();
>> +
>> +	map = rcu_dereference(token->map);
>> +	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
>> +		return NULL;
>> +	return map;
> 
> Please use good old rcu_read_unlock to make this readable.

Come on, it's pretty readable and less error prone, especially
for longer functions. Maybe you prefer scoped guards?

scoped_guard(rcu) {
	map = token->map;
	if (!map)
		return;
}

...
>> +blk_status_t blk_rq_assign_dma_map(struct request *rq,
>> +				   struct blk_mq_dma_token *token)
>> +{
>> +	struct blk_mq_dma_map *map;
>> +
>> +	map = blk_mq_get_token_map(token);
>> +	if (map)
>> +		goto complete;
>> +
>> +	if (rq->cmd_flags & REQ_NOWAIT)
>> +		return BLK_STS_AGAIN;
>> +
>> +	map = blk_mq_create_dma_map(token);
>> +	if (IS_ERR(map))
>> +		return BLK_STS_RESOURCE;
> 
> Having a few comments, that say this is creating the map lazily
> would probably helper the reader.  Also why not keep the !map
> case in the branch, as the map case should be the fast path and
> thus usually be straight line in the function?
> 
>> +void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token)
>> +{
>> +	blk_mq_dma_map_remove(token);
>> +}
> 
> Is there a good reason for having this blk_mq_dma_map_move_notify
> wrapper?

I was reused it before and reusing in the next iteration, maybe
v2 wasn't for some reason.

> 
>> +	if (bio_flagged(bio, BIO_DMA_TOKEN)) {
>> +		struct blk_mq_dma_token *token;
>> +		blk_status_t ret;
>> +
>> +		token = dma_token_to_blk_mq(bio->dma_token);
>> +		ret = blk_rq_assign_dma_map(rq, token);
>> +		if (ret) {
>> +			if (ret == BLK_STS_AGAIN) {
>> +				bio_wouldblock_error(bio);
>> +			} else {
>> +				bio->bi_status = BLK_STS_RESOURCE;
>> +				bio_endio(bio);
>> +			}
>> +			goto queue_exit;
>> +		}
>> +	}
> 
> Any reason to not just keep the dma_token_to_blk_mq?  Also why is this
> overriding non-BLK_STS_AGAIN errors with BLK_STS_RESOURCE?

Yeah, it should've been errno_to_blk_status()

-- 
Pavel Begunkov

