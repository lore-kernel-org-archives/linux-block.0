Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2533429CFA
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325572; cv=none; b=niE3I74RoK+xnRUoPeSfAQwRM+YDsit1tOX4HmAYckBD/qPDzdaBmSmq1+jO2kK16y5y3QYcPdNvwPHu5kDHj2vcWDna58HkoCOx+6QFHw1E+HU5aPwdfY/JR8/QIRUbXVpYodDdIt94auBOH6tSf1cA9HSTCDY0spHg7bfBCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325572; c=relaxed/simple;
	bh=wYq/i9KhASJIbtNcdRJPIPtUhLDMmjpqz3feaFDSSx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmhTa/Z3V5oC+4BExlbfnImaKjgJaKBC1O1BlZARI8dAg4sUXl37R7AmkGU7JQREj2jJPWYaDDO/jMCDVJZsrolug3AKBGqgTPfapaUXCa+k+C0I1b4qNP/hKxSQHpGJ/KgulC+8m0rk0+0JN4OVCj8O/IH78MOPFXjaEEP8PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4tOmr3N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4tOmr3N"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso3780525e9.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325568; x=1785930368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
        b=Q4tOmr3NPrKlHbunO+WGW5tksNDRut0JzIrMssPFekJ8X9lIPuMDhroEwWKfBheT7l
         ir7lZheWSAUWya+TtSg+psDb7MIsaCY1h77JNK2glnfIFQ5TYjZBnquo8eKZffr4JMHa
         icbuyAij8m20iYdhp9VGYpvGCDeBAvxHi2WeoP4uO+eWfnSY7qFtJJZj6L3489hntzZ6
         sp7FREGcuncaPPnHQUO0X3hEr6RZ+RCUM9zoUVsgp0EBbJwgwnSfhmCP7E/H6VpYpo/A
         RcPuT7Ci+D0HiR2WH8sQOqDGg2PE0TTd5p/dfGykxHv0Yy66c6L0QoTm3VFjU/nf58kQ
         QKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325568; x=1785930368;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
        b=UMRICWmSWT8a/exazzG4Vp6lau2r8tXQj4D2FpqClK+umeQiM8YlSrg8d2N2jpd93y
         iuhDslndruQqPmCHc/YgEPKZ2Z4yfQEwJFPJgQVl7bZHiEHGBtBBWyDBxY7o+p6mF5VU
         /erBsPL8JN6x2VFd5JjK8QfmiF0sVaXK30CJc/bcV1UtHLV3L+PbpruqSh+gJc4kFadu
         45xpzjzHzEJ/91dRLrYTdM96xT5F3d4cIW3EKoeapZRPySTDZNnd/hNnJaudityFCtMb
         Knra0+eaB3dFqaIjp0Dme/DdWBAWgMR9KeIII0yS4X6yPC/gtNXRoIh2pBHW6EDG6Ffz
         x1HQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUs63Pa4NmeuZMC856CyCqxglyWh9RVdrxryxgGvcwdp8npwp08twOl31bSQcGBwmCx4IFV+7LDr8o3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBXu4UdORIEmeJwnzJ8Klx7kmGFPHZqV3ZuTo1ZR5zJbfT1kC
	uFUjq2w/HJjMRlCu2hbvqiVMCl56iGbZRK/keTH44haTqwEPWyNJk6dU
X-Gm-Gg: AR+sD11FXeDCArYeQ0YTQnCQGZfe+Smb/nSdWxeLJJoUh0z6UOuVFrSi9FPsbWYBXCi
	1F+rsOT9WU7bUStq9EWEpVhpCx6zULzPTClD2gprE5yxVj3AG3IaGzLOXmRe13F3MRqU/L/Wfz8
	29B40QI7+i9zvrE8XLuapCNKy+L6ru1yerJ2k3n8b94Pj/0HarGyLW+1DybCLs3wD2iO4xYzP2l
	WlyCRQVpeCQEJRQz5oQ4UOJhI8VkXZ/Su+xKC9h1eRjjolmTrYHGuCYI0ZXyBv6FBjo5NdZMJk7
	75Xye5yPC/qutovr1DcjygYvtaep7ILr/EKxWdMFCd3WcUYh4A+TmUSLysd943Xez/hGKUfI8uT
	FoNbwnQdUY9VAZIOKGxWePjC7BssjXT4nj1UA/8DKxFuS0tVj0BKy+Zwz3bP95qDHywivmpTBhL
	/k3L8uzW315L3OGpXtqa7iOGUK7RMIe+/TGWam8cBD9o3ByOGob8E1pzWvo9l0YEUaQLUhMRYlx
	XxWU9PG+rARzj/eahhYLxGkvTk10luEZF3PNXvVLmu76rX+GE6BKceQMN+VET6BUQ7I/YhRbr27
	htpl/8STBy4y05HjB9oAQLD7Fl4a0Q==
X-Received: by 2002:a05:600c:470d:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-496c6431d1fmr69913135e9.14.1785325567969;
        Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-497fecfccc7sm26554895e9.12.2026.07.29.04.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Message-ID: <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
Date: Wed, 29 Jul 2026 12:45:47 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>,
 Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, cpgs@samsung.com
References: <cover.1785274111.git.asml.silence@gmail.com>
 <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
 <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com>
 <20260729072117.GI9534@lst.de>
 <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
 <20260729113108.GA31120@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729113108.GA31120@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 12:31, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 03:47:23PM +0530, Anuj Gupta/Anuj Gupta wrote:
>>> But I also don't understand what the use case for this function
>>> is to start with.  struct sg_table tells us how many segments
>>> exist on the DMA side in the nents member, which should be just
>>> fine for the SGL threshold calculation.
>>
>> sg_table->nents covers the entire exported buffer (<=1GiB), while a
>> request only covers a subrange[bi_offset, bi_offset+payload). Using
>> nents would overcount the request's segments.
> 
> Urgg, yes.
> 
>>>> +	if (!entries)
>>>> +		return BLK_STS_IOERR;
>>>> +	if (entries > NVME_MAX_SEGS)
>>>> +		return BLK_STS_AGAIN;
>>>
>>> Given that the block layer enforced data in rw/command and the
>>> max_segments limit, why do we need the extra check here?
>>
>> A dmabuf bio reports nsegs=1 (bio_split_io_at) to the block layer, so
>> max_segments isn't enforced against the SG entries actually spanned by
>> the request. Hence the explicit check.
> 
> We'll need to expose the actual nsegs to the block layer and split
> based on that.  Otherwise I/O might work or fail based on the device
> capabilities.

It was exposed in early version as I was passing a [{dma,len}, ...]
array, but we moved from that. Maybe I should put the minimum
segment size in the map structure, and (possibly over) split using
that for now? Keith had this chunk in his patches:

+		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
+
+		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
+								PAGE_SHIFT;
+		if (bio->bi_iter.bi_size > max_bytes) {
+			bytes = max_bytes;
+			nsegs = (bytes + offset) >> PAGE_SHIFT;
+		} else if (nsegs > lim->max_segments) {
+			nsegs = lim->max_segments;
+			bytes = PAGE_SIZE * nsegs - offset;
+		} else {
+			*segs = nsegs;
+			return NULL;
+		}

-- 
Pavel Begunkov

