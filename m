Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3626FDBB
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501323; cv=none; b=ZkVYrnLPCizQ1WtUfgA46EJTm3geW931DbNYl3MYTQE5zRcqG6fDjprQKL+kA6tUYqJwSLbgdGEAUqA6no0BdsPHItkUMcl2x8r+ZwNZnRNHeA1upgmhnDhVW/4SnzaPE9/tKsrr07RejR4D5G9xLk/HEEYOdM15SbjWmy1agpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501323; c=relaxed/simple;
	bh=yjTz9N1XnY76DvE5bcGPlvLqbXen/pl4og5ZynCkays=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuKh6BknngzKr7NA0PVmQI7zpF1gViOqzFkHyN94EO8CMIj2hr/kqcyCgvrQNBxT1rjcVXRS5Sm0wpfV84vV+8wG3wf4T2ZZYW2o9LXlRtl6qRvKpAO87w7nQoFeNwswyA0ObdUZZuunIr7w9fdSPHqS+PqNjuPqjVGFFuS81Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIe0zEWO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIe0zEWO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7baf61be569so801720b3a.3
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 17:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765501320; x=1766106120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiqT1y0DQKTCKplE+X4RtztJVQKRqPD52kbRIZIB4Kc=;
        b=mIe0zEWOhKI4U9y7ZGHmoHnn9HlPYwG1u3dzSpG27lFusenPgMQaop0WsHh82S9K32
         ibTUsc7Tqo0HBmmHetIvsFh8C4moGVobhEDzFgXL+e+qJ7UGnCaHPQQkZw3NHSZGeKOt
         OdqkbWC4mq3AMmTu+1ZmEutP3AWH1qYgGOGhS/gcEc+RGtMbDegyLHkZbq5GGcsCNI6d
         Q+DUai5SxF5/eKeIGhwbRZlFy0M1YFSYBIGEdvDbQogDgD+qbQEvlJRcNnzUDezwAdc7
         1le/zBt2FNQey8IoPMHjkRXwEkgjmY2tpMppumGngsaHpEqwxU5yKjE/EPdOYqO0Wt4e
         icbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501320; x=1766106120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiqT1y0DQKTCKplE+X4RtztJVQKRqPD52kbRIZIB4Kc=;
        b=CsB7cWgfNeVLNoX/tcTNVrdnLsWfSHXtU6YQKNjEO5UMUHisAVEGVllZW81VR8dEkx
         vdFERHDH4p2AiZZKBSQyIFNrCTBxGlf7f39uiu9oQcflevsrPgj54le0Trz2SwhtXI80
         KSW9yFs3Hpt4SfNig2/bsK7l6qwCYh4vNLkbR5BmspRiGYeQpBjho8/ldPitMKaOd4JU
         kLIJtbu4cX42fGz7fxic1biNwEZmd1wDa9wMjhNXsSwXRGvUJUpeecHFaV+OQ7LV7t/C
         6LGn02OIwKUV+qiB5AhrY75SxIC7tWf9V1J5XPYqxC18+tubr1Z1UCedwcTmTOyAVlmp
         OjOg==
X-Gm-Message-State: AOJu0YzUUUfl+a2DxEps+l0OZkU1ZJHU4be4BX+JYCgzXkFa7P1uPT8X
	rU6BR9/p/Myl2o79/sPSW+NBLDcUZGYbLCW7aFtWSKD247mMClHy75ib
X-Gm-Gg: AY/fxX5F5+DYw6jmbNUxiD8G64rknCkFoI2A0nUjeQyFN4wEOSUNtd/4qYj8mZXd01I
	ne2x+KVgX8CQYMYmFzLuDq8i7BJR6PufiUX7eRuKFyJHkMCdXtc0nMgHeUB2g8m/tjIJ7eoNpEy
	DSV1kSMNjFTyrBQnX8bbqGWTzOANQMtwrkzSv/7HhwhVR/CdWx3ljhtSRID6S7Oq2usUSiFj9ZT
	VglCgisqK+uqz2rXo9Z1PlFJTRtfWRDUlBA0kMytm3nuvjVve0e62k/HpaMjsSvfJ/K2bt/Cg/e
	zx9texp576OARQrESTpfvOGhXbbgWH7W79RjmC1ZrN8htPXUyIMhIO/WP4cLff11pP7rLmnKILO
	hVUsGJm9evXLEE/S3SuCd1TNsLSTuSDnrhFUnsyxoUD6qwVBo2wSNT/uRU86rqJddC7fdDp9iRO
	Zxi9OSnEKqaWXHKq9Z8Oyk1bMO8KcCPzCJ27n4V5yYIGD/v0BDqXwocK6SAWPLR4dxgaEr2MOvl
	jWTfSNt6F7A1aIoMPgW93IU0WA8q9651CpWk2WKSzlzBsfnzhWKD+Y/LofAnw==
X-Google-Smtp-Source: AGHT+IG0+NAokoVmG4o76ltchxh72cgR5S6czK8w8NPqiA4lCkRSaBrc+e6H5PWtVLyiGmX8KUNYIA==
X-Received: by 2002:a05:6a20:1584:b0:35d:7f7:4aac with SMTP id adf61e73a8af0-369afa01e9emr370191637.47.1765501320420;
        Thu, 11 Dec 2025 17:02:00 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2b9d8a2bsm3358325a12.27.2025.12.11.17.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:01:59 -0800 (PST)
Message-ID: <fb1abb05-ac8a-4130-a6a9-1a1089df441d@gmail.com>
Date: Fri, 12 Dec 2025 01:02:04 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
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
 <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
 <aTFllxgsNCzGdzKB@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFllxgsNCzGdzKB@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 10:42, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:21PM +0000, Pavel Begunkov wrote:
>> +static inline struct dma_token *
>> +dma_token_create(struct file *file, struct dma_token_params *params)
>> +{
>> +	struct dma_token *res;
>> +
>> +	if (!file->f_op->dma_map)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	res = file->f_op->dma_map(file, params);
> 
> Calling the file operation ->dmap_map feels really misleading.

agreed

> create_token as in the function name is already much better, but
> it really is not just dma, but dmabuf related, and that should really
> be encoded in the name.
> 
> Also why not pass the dmabuf and direction directly instead of wrapping
> it in the odd params struct making the whole thing hard to follow?

I added it after I forgot about the direction and had to plumb
it through all the layers. In a draft of v3 I had I already
removed it as dmabuf is passed with the token to drivers.

-- 
Pavel Begunkov

