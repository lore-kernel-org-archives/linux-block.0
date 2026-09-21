Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322ED4A012E
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998248; cv=none; b=AZVOtH3SjaINW20gnMSnYLt+BoOTaifxlapzAFnUg9DSgR02nlMz6xYaOfzKWoeCXooQS5yt2LVpp4CNwG882958xNarEtq5xaK/1PJtx0NrRISBDm8jF7H/N32LFSx0lCxkpj0UvEdOZ95Coj+4RrKoMY7kdzSFhPAbqGWD/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998248; c=relaxed/simple;
	bh=Ffr27RNaF+FHzq3WbV+cwo2+VfRU0uuG7BksAI4Sf34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQ2F9vEPCgZXIM3Rso+ZM6QxmlugtAlhfvBfSp05at4XLsI/yjn5PefBFbF5G7T+SNhLfXDAcyq2W2XM4FTcD1lkoiPpKVpl5RazyjKcfvW7WVBt4b+X/ZKSJO7hbBXbmYTz9KLcldW8Y7073RjlJ9oKIdNEK79dK9gX9rs1x3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ041ULT; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ041ULT"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1da63791so3639711a12.1
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789998245; x=1790603045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=;
        b=WQ041ULTmn8oIfDDAPegB0ryOuulWBW8xTH6dy/FNnuTaIROw06zad9G8VOvA9jhCO
         nGwwGrtltQ9w/VNo6HxG32lzeR/pNHGDZmggvzI8SepHxo7M0yP04joHR59rBWJCTiRH
         QkNZUxrc9lEEj16orPpUTEQ78mHZatBMM8chhmaT5E3YJogMM2ovjFz0bZXboWOE2ZIE
         Osr3I6YtCh4efQp+KJAUcs5SmZvKjdKhNwDJYwBf3JWvn22WDgG4emGeXAoCo4POf/Bz
         BiNQsLFOrAOIU/O71fdUJYRIrhmzmMfW6krL508dEfCqYqrsx93B/mV17uYZrjf+PVRS
         VfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998245; x=1790603045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=;
        b=EWNU+0zTzJJv7TLV9pa/Wo2w0SEEvC22DK4vdWua+M7TsFQd5NaCBwLoBwNKDvzrAA
         fBOtJzZ5D9rL46Wb5yQrFyiOrOAa7GQuXcHl7F4mrNvDevTtiwbp/WwH3ZWdh6vrvjAi
         4OS96z77f5OTPRQ9rPnfD8It4nbcVNFc7So5LfWTvyKSxiHfSk5T+fZwqoaby5mRQsx4
         g40cqKifZtJkRm1HaXmQ1XKEYnPLyQBeUPRydGrZCz+aVxgksOVwVkHiZ6ycDTqRyUnR
         0bFT/W6QXfJdqnTUot52plNtYF3AbQNWqFhdZ5nRRoEdxxaaqdJJVU4+yGaF9IvOzk3w
         +JFg==
X-Forwarded-Encrypted: i=1; AKwUvBxOT9h+dnfADpiwJ0tcmcP31fz43ApTSaIfOipOJ7mnlIhikrPNlTMmlP3ncJyR5DUvg5OUPA5cQ6Ph/A==@vger.kernel.org
X-Gm-Message-State: AFuF++l7oZmZkiI8alFFo/lgJtQxRunoJ8K68ZWoJrqkkfCzUNwlTeyv
	HswS3f48zEEIGE7TmSTIiMIzHcTDjXHExurki1RuEqVfU+pKNlWcov3Y
X-Gm-Gg: AYBFou12vk6YAABpx3A7XsFJt2ug/+q/la6vkxXHWY5/7NJ/uhijzbb04ytQKjYLhKI
	KMqAlpMyUVd1geH3rw82WTLRW02XHQjjvhm5nGByDHs4/7wVK9sZ2xfxcCnWJs8TNac5o8eIqt/
	1DU1sNwAbwVaqx2tV81nwDj12f6i4rTWc1SvKZRGXpG/f7d1SO8GA0P8E5aDl4gmrJlzxlaqV+t
	eAUgbdy4J/6z5ffyQW9ty8bXuFKVbg7S9DsnuWblhZIhbxDmovWBvky3WISwCBzsXd899pd140r
	WtKVtUc2YH9RgTSeL9/h8X3wwBUiMjM4o9ooamoCa0cVbYxMBTW6D0/Rg+4HfRmkwRXPVDIzvES
	sywaMlH7QrldaZJ872VroYYjU5ukfjYrNvqqu6aO3aiynl3QGN8FbPSp602gzSaL92yez6vL9aI
	Vq/UHFAWhsM4N4oMykeqPgfthVXJLiuEKsk0X3uyE9vsj9YtQ8E9qfbakV+a590Zbm5yw0sqRzO
	PlfVw8GgjSQCEPuK+dPqUmYrCDXljC/Vsyfa9KXMUGIFPX+1nwBG8EwgBdE2t0FZG1XiKXf3Ouj
	8FILSpTBdpgCWFCxdmEz32geD9I5u8PRuiWfDw==
X-Received: by 2002:a05:6402:2355:b0:6a1:4458:7f2d with SMTP id 4fb4d7f45d1cf-6aa53104448mr8100478a12.5.1789998245342;
        Mon, 21 Sep 2026 06:44:05 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e0d3c5sm4417232a12.22.2026.09.21.06.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:44:04 -0700 (PDT)
Message-ID: <b3e1db34-45c8-4723-8d09-eabc28bb0988@gmail.com>
Date: Mon, 21 Sep 2026 14:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O
 infrastructure
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, akpm@linux-foundation.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, nj.shetty@samsung.com,
 joshi.k@samsung.com, anuj20.g@samsung.com, tushar.gohad@intel.com,
 william.power@intel.com, phil.cayton@intel.com, jgg@nvidia.com
References: <cover.1785596451.git.asml.silence@gmail.com>
 <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
 <20260808074245.85757-1-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260808074245.85757-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 08:42, Sidong Yang wrote:
> On 8/1/26 16:46, Pavel Begunkov wrote:
>> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>> +				  true, 0) < 0) {
>> +		dma_resv_unlock(dmabuf->resv);
>> +		goto retry;
>> +	}
> 
> Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
> returns 0 for a still pending fence; only -ERESTARTSYS is negative.

You're right, and this chunk is gone in v6

-- 
Pavel Begunkov

