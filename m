Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0573E51D2
	for <linux-block@vger.kernel.org>; Mon, 18 May 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095429; cv=none; b=aCkKO7oNj4OJ+QJb+V9i2rWRWt4I9GRTQ8vR63Z6OgUEHyILOJdRpLSvOnjfqC5LFwAuc9kZOVqBNBTx+Sxvugj1zhPhLyjiNmQMLCY3XBS+zT662edzvfG+6CdgEkZ+pvkxZs2Rvl+TKqVUtDgog61/SBSS2TzTqrNlF7qlmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095429; c=relaxed/simple;
	bh=JDf5tfG8fpD06t7iMggta6QbZxhroHbPF6Ww351Aud0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T3mqj2z4GxwSbU7sikPNq2RymayOwpYNhvSmWLKQftsCh4/AaGtBV49nLChbU31G1iBZrt2poN4BrAeQAoBUNRHGZF5yakuduaa7M/hZv6RYp22a+iwXNjAMUZ3RfbxugwnApz4Ax+EVuA2/LsvoDmCxf59aqtTPl0YkDrpqFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJPAkrMm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJPAkrMm"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso4350065a12.0
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095426; x=1779700226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=;
        b=TJPAkrMmxASGuDLSpftlKK9PV2MtAwT6+7Zl98Vv1r8yDlfkDFF/T+xJ88LhrcItVy
         ogY/zfhZ2Xnl5jlrZIb6sM4Mz3XxcicP7OiNGHUStVms8Gwjd5P8+TT6NAfBi73t5hZg
         0RQzv0FBgIFWDCSXCa+GlKsUl4aracaro5yu0WDXS0VvvSedi6zLP0ZXeFy0w52LN7k8
         XipxwpaOI/gdIFepZD0M2KQT9zlG3SAeoBBPX89ZVnTj0/aWa+P3LiXCRjYEu+4pc9c9
         vZ0R9gPdyLql3qAx7QemfDa+q25ncNE+TNIhhkPPbjwsPksLMjMxFooK9aFjxvyUC/I+
         Ombg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095426; x=1779700226;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=;
        b=e20Etwo6kR5m/Tlf7NyuflhUiTPBmRc5P75JUSAuwZ8OM07aWiA2zekDllq+iYXcTE
         mSd+2l7GmpfBuyJ8UVIeSQ/fLqozYU9MT0hWLYQwkLXCRLY93BmAZoJIWXiMDTUZYtig
         ZGUtJMTmFPMnkOhDRyG/OHagR/TARQzlkE3nhciFT/2qKiU7au+IlXzBrr1C15TDAHHW
         uU5UOTvqnGJrJj4hNPayRDlm4DI9H8wYPdSm5AfuSjyA1Pbv5wJuYs88qBArAKaTQmN3
         tSQNLr8NHhli5LUnCYhaGXlbMkGFB2f8q0B+7pdluZZD00nNwS3udh6BEqX7ZnjpWnyQ
         rxBA==
X-Forwarded-Encrypted: i=1; AFNElJ9+WK7cWRukAwQbcqwB64BGeyKbLuosJqV423+vdGe8+lMzIDDmEM94fFmdTROVXbQcV+9EC+zGb1ubiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRH4k6+y5VHIUJUzNwQYG/rSlwpfwhWHlQYZafSHbdXCVjIUsv
	P4rSDzuRUCTowh2G/jSU1qMIersLsu8AQxWUUw+E3oxjfNauf/SvTfb0
X-Gm-Gg: Acq92OFsquGAZvk1ZzXNvR0h5hjWGDJZDhF5AQl+6Kio8GUIXjqtcgLZqo61mPwGkEo
	PdPeuXiGcBtygCxXUR9AIPi+0pwiOwGgEunDYu9aZRDbAE4w31XSkSY50XKyj8tVA91wmWwY1UC
	dwoCgP6jflH/HRz07tk9qeOvfO6eRB1eN2NIIMJgZ5V0BdkIhS2vdlJpkJMPct+HWe+HFcqYdTm
	igZ1hq4HrRtWTqrxI/YrwoSCQz9vtliKQP2bBKeMb1VvkioAF0oflasg4hMGOj5y1yRtHGDjcPK
	eYQgZLVrx1GLsjCEFp0RloP2eZVOGR6Rzly5TgBSaKEiCkmZ5g3lHfJaFGVMTKNo7t0+UlV/sa8
	vmz1REB3PY2SSZk7Rk92gJam3rrWrxi1tp0GcSS6qZP94T43CFIjM/L1q4YIwqLxnZrVHsRx8tG
	pOGQmqoWIZ94SU6PQnJOzsB/JsLex1h8OO06sdCHJldiOZYxUtXnpz8C6E6T1Q1X6qKJIe0mIXJ
	iFUTnny6oONRT2q+FjUtqalRmeBSR4xWeVbLnclU5PYVQ+vM1tDeQG0h+r3IRATecp1Pg==
X-Received: by 2002:a05:6402:4150:b0:67e:153e:51cb with SMTP id 4fb4d7f45d1cf-683bcd9e33amr6611396a12.16.1779095426574;
        Mon, 18 May 2026 02:10:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b4069dsm4929655a12.1.2026.05.18.02.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:10:25 -0700 (PDT)
Message-ID: <d14967a9-979d-428e-8190-6a756da1c130@gmail.com>
Date: Mon, 18 May 2026 10:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 03/10] block: move bvec init into __bio_clone
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
 <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
 <20260513081238.GC5477@lst.de>
Content-Language: en-US
In-Reply-To: <20260513081238.GC5477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 09:12, Christoph Hellwig wrote:
> On Wed, Apr 29, 2026 at 04:25:49PM +0100, Pavel Begunkov wrote:
>> To quote Cristoph: "Historically __bio_clone itself does not clone the

Sorry for late replies

> It's Christoph.

Oops, typo, sorry for that

-- 
Pavel Begunkov

