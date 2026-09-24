Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211B4A5EA1
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265232; cv=none; b=Oc9cCuoctoewDDR/zmDRL2UHEQndNR22i7CPNUXhtc8qViI3dyX7m1HX96plWKDLWuFBnF1SFsJTXMIS5RLJOZ8IlmRoq5GtxtL7ZXqTpa1ZTByzsehq5lGJVx8v0OBv9iRLMZWBc8bTNS+vhD4TbwrVJ8tAVdkejwTjUrV94KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265232; c=relaxed/simple;
	bh=wMUbxl5vt/9aakHALUb0wzH/L2TqRFPYLffnV8Cgl4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwndrKopoTJjAXi1a8yXiAbzzKBM1iH/S/ocoq9wplhCwRbiSawPXXzOMVF5ARvK8rtrWfBNa/tDrOsxjhi+9zla0urQAIDMjmJ89443mqlgbLns5lGSNcTKf+sj9SHzrfpR5nhficPvfe5f2EpWX3tS+CE5RoNMoR+nS2kO9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCGQz2eS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCGQz2eS"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6aa13a28848so1600423a12.1
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265228; x=1790870028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
        b=bCGQz2eSkcQYMSbQNfLYFZiq45HlXMpEwZjtjh5ha94/5vOF0qLHpu9X/lZmf/vZXK
         DeUHu394OYCJ6Lj32I9RPjdNdKveIfOpfEWorZhCfIEYywR+cRALMykbVEFtub5oDS2O
         MpV7RU+rbkuShz+jA3asVlrDJ23iFlQ4iSPCrgC2ETXrn5yuRl21vE7rVYDSB5jygVhZ
         dyoViXu0rSJrHzN+ecwAoQ1pkTwqCTYP8kzclXNL+9EdUyS7bNOcgcXqSJPkcGLBQzc8
         HLItADMdjRIEMYD5rCPdt6ykQwa731k1tcla8CM/ahBbW8iD8Wx9Jtw/dlD8gEdJRYNb
         Lqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265228; x=1790870028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
        b=hPAIGnMYmJlGLsmU90TN/kU2N3kUJ0VprZ4uQrlK/8R1AQS+rmZs0dUBSHiAen6u2E
         VfZvXJIRzO2+6stnqF+OL0tdBGbXpyJv2lYSZebzaKDU0h2b30FQerlu4POXBPTf7vDk
         GL/+7V+6J/QfOfn7eqaM4nFS7tG5KjZ+6kYHc+s6jyar0BIXv0jwCLa0+ycUf5MpBhAU
         ZKC/2fKA8zG1NloSGZD4JPapH7ysBEzVobPO0jqtnHEm1MC6ZGK5Vg0HZlW3QjXWKOhY
         lqcjRC9I/oR3qEHz2haTKPepQEIRrZpu43mUJ7yi35Ah//vg2/aopIwAa6vN7eHEwcKb
         F0Qw==
X-Gm-Message-State: AFuF++mgQjPZLW3n72PewfuSQiHIjToClCN1h2SNyao0qJA7w4kDLP+9
	Vk1oG7HVWvhpa4fX+GBx7fkn21pBAuEyWCVRSEvp+37b3c1zYkidqrYo
X-Gm-Gg: AYBFou2uaKFYNsBUb9qzm+S7jhBFUPYKtsVYyXXV9TlG49pRsyXcZ00hper5ZsCmqpU
	y3Rmf1fDu3kyIFJKJ6DkxKVcm3oNYtM9YiFbNAc+sJ+q9s8+GuIXiLfb9LN331u5tqygATqS3sY
	jigt3DUrHhA+ustSP5t5qdx1sL4r/jVB3UHnoYJh/c/8HGh1/2ycUlPaWEGMrNpi7p/tK+YNRZI
	thG0Dpfe4X50vLuwWBdDKMbbCc5LcHw2OV5XkGcs2aYCS4UeTpqd7BNA0syC1k04r2mg9KRbJ2B
	nJk8/atHjmQ4ZN5k5EzU3/Uu3xacQj0GcxmV1Ewg2U2Wp1UEnjCAmoOneLZOQKH36E71pXRvNBW
	Bcz5A1rkMgkdCmBQMV/kAeVnMnk+3kDmt0oTk7nnl6D+swWKqJw80ZYH/j2ZZdMcEoVb3kPfTa8
	Xh3CIyQxT/UnCUQZ4Y6kzHH5w2d9zLpjePQ+IvhizeBD6BalhzdbIJH9nZjVbe+lTSWKnefmCvR
	rvIlAw+cFLnkFkK3savdBkzZUErYrkqb0d/xfEvwttuMrOMhZ3Gf+auEoPaEo+9xDg4jr+ZTFMY
	Xf//ILTL30mrsd7UiWu8ZRKCJEvK+vA4cIflJM2paXRWLdQpOQ==
X-Received: by 2002:aa7:d94b:0:b0:6a9:c9d8:b3b6 with SMTP id 4fb4d7f45d1cf-6aac8f0ae7emr1949690a12.6.1790265228473;
        Thu, 24 Sep 2026 08:53:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38b2fc5sm3815784a12.27.2026.09.24.08.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:53:45 -0700 (PDT)
Message-ID: <6d538f3d-dd83-4dfb-b091-9b84acf47c62@gmail.com>
Date: Thu, 24 Sep 2026 16:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
 <20260922132016.GA30684@lst.de>
 <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
 <20260923045505.GB26231@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260923045505.GB26231@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 05:55, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 02:37:08PM +0100, Pavel Begunkov wrote:
>>> Sashiko had a few comments, which I think are correct - if we use
>>> dma_map_sg to map the data, we need to use the sync_sg APIs to
>>> transfer ownership.  That only matters on non-coherent architectures
>>> with MMU, but we need to get it right.
>>
>> I've seen that and fixed everything locally that should be fixed,
>> apart from the sync. I wonder what we can do about that? I can
>> somehow replace it with the sg variant for now, but sync'ing the
>> entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
>> not wise.
> 
> If we'd want to fix this for real we'd need to add an offset to the
> sync by sg methods.  Or move away from scatterlists in dma-buf, given
> that they are a horrible API.  All of these are bigger projects,
> though.  So for now I think you'd want to do the sync all, and have
> the people who run high-performance io_uring code on non-coherent
> platforms suffer.
> 
>> And I can think of another place that does mix sync_single
>> with sgs.
> 
> Which one?

All the recent networking zero-copy / dma-buf apis.

-- 
Pavel Begunkov

