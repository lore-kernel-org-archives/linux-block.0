Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17F33555D
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357286; cv=none; b=N8dKptHwGMK1glnnzvoq4CayEZM+XK2zXB1Fw8b/L2ZAZBGsj8vCUeYt/PaWUl65eNFtXj0UgtrU3/8RsNdcKVe+dpUqRwEpWqSUhR28FXDWlsSUVLVgQa9jz9VmkmUMiLi3Oz65zmyHVrVHmxRzhf/6PLeT8qEzuhlPbkBussI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357286; c=relaxed/simple;
	bh=WWdgnlYMw90LCL0sOM+NWiyg55fdDmZw3uhKokOGJhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbmcJj45GbSotASMs6Elucfo0SijqUqnqcfKwrRb8PjUN1SSDjmNSlhadi8PFvnyYvAnQ9Eru0EHykWu8RVEHEWG0gE8HDftfY46EKPePwy8QOkY00OFbIRu6OLxMlTOYenwEFNftu5U+Mi10s+8GzknXzbobhYcPFOFlW7h3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FT5fR9Gs; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FT5fR9Gs"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-948673fdc47so56502939f.3
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762357282; x=1762962082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dei5ft9lh7BiYmYlcirRqQdpPJqIr6mJAal+oui800Y=;
        b=FT5fR9GsdxwsIk4U+plWGH+YbTRNVONclGW32z5u+4Z4pUxR5xT80ZMJQX6jXdpNxt
         gdax1gRvaOFVnTQFOCHeNscL1OubmZ3KXshQXUq8SFkFLvLX+imFmxUHlq4Takq5PxDF
         TAI0P5qGAGwboAMkDf9YOL0QpSP/JM7DfQ7DOc2+ffF3iYAPsWUl3Ud7YAgpDepOq+bV
         BpT2ndimYv2w2RYSezv5x4wVwzsOCLrvDwJ3KlTSpylea0cfjgqu6ZZ0H+5hcg1LHfoX
         T43R7XepIEqNER4h6iqhId8Nq0XU54JswQTjRgDfABV9z1VjLEXFFijbhwTCU94LrPme
         YtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357282; x=1762962082;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dei5ft9lh7BiYmYlcirRqQdpPJqIr6mJAal+oui800Y=;
        b=l+DBFnBylRFPf6yszdXU6hl9nEWeeND9q0tsBh5tpQDjadehl5KOsHnOU+AIu0DReB
         W/ML/+0LMkGiyJarzSDd5nrndF0z/Hxn2vmpxOJjhQAEOV33ZSk5Ul9taqXXICz+pUBb
         /N4Xva/BDt4wJeFHfvw8U2hQXpSvHeXu16cck9Zmu4YzReCFs9bNrzCdzVhBAXRRg018
         TIbv/xb9T7+ceDIDxvBMBrLn/Ct1lM5B1DZ0vmegZ116tDLy3JB9uTfUn1MNHnDfRpgn
         TRPOl5YzpexMGR+TDz76GwrxbRKoyD6//4je6n4ywaYioFEYXvw+AU0xSshym1fCuGYY
         qdwg==
X-Forwarded-Encrypted: i=1; AJvYcCXSSvFn9+a/oixF2CYJ8AbQA0Kj/2efalBarE1OL/K4MFL/7KSOUPLHcKUFXRZd2XnCc4aAVZCl30O3ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kQOUBD6fSYaJ9BGwSXo1KFbdC2wcNBPF3f14D30inXaeWg9L
	X34xeqTP4JNJOL/4uZ41wPeMy5ge2UK4rbSQl1j2dGU5WJmbQFuQn+gC5F/IKpgFp3s=
X-Gm-Gg: ASbGnctf3NAS8cHqafLx/H2lZCBJPq6z2DBbCVi7H1vGplmV+1hmAvvTe/+boTYQaby
	AF0sAa9EAcgLtoCtKX60VFVaWunkfODu9QW4/rQyym8HJZSUN9Mw5wqLZ+W5QswDrFMQjnXHNkm
	DN5LldAIYQfigWb9WWHRBThxiIQL720UI6eymG6bMmBcj/xRh0c/gLG+2UpZRbNq9s+m0XxSsxq
	Nx2B++H+bBAyiP0/sE2gGxjGKJl6VfbBU2GC1VlHD+eYiLR5QnRB5W1SVMQ2d68mUmILV/UNV1Q
	FkS1gVRfebGdWseZDqqT8P8B+dIdk4MnTdB69Xa6+wCsY3YXTGcrO3e0w72xBVUuh2amKyksqTh
	MuV+ugVbcCYaLsC5MbavvrHUzhxSBzpguBy8TJUuMfE+s1hpX4FMDMMFgiM5FexxR7KT5JWXy
X-Google-Smtp-Source: AGHT+IGWblcfhx5IiHozJJeYsYKpNJZtrbXbMWvFd8+xTrM5+68lZz8nwj9HLvAACX003YP8SXR4iQ==
X-Received: by 2002:a92:ca47:0:b0:433:3487:ea29 with SMTP id e9e14a558f8ab-43340769974mr58182975ab.6.1762357282002;
        Wed, 05 Nov 2025 07:41:22 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335aae9e5sm27227225ab.15.2025.11.05.07.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:41:21 -0800 (PST)
Message-ID: <87cdfaa6-68a4-4c99-8959-7610a879facc@kernel.dk>
Date: Wed, 5 Nov 2025 08:41:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora>
 <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora>
 <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <aQqs2TlXU0UYlsuy@fedora> <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
 <CADUfDZrY7v93aDtZbD4-qKAaJHcGUbWTQinEVRG4Tiiy6m2BFA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CADUfDZrY7v93aDtZbD4-qKAaJHcGUbWTQinEVRG4Tiiy6m2BFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/25 8:37 AM, Caleb Sander Mateos wrote:
> On Wed, Nov 5, 2025 at 7:26?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/4/25 6:48 PM, Ming Lei wrote:
>>> On Mon, Nov 03, 2025 at 08:40:30AM -0800, Caleb Sander Mateos wrote:
>>>> On Fri, Oct 31, 2025 at 4:04?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>
>>>>> On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
>>>>>> On Thu, Oct 30, 2025 at 8:45?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>>>
>>>>>>> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
>>>>>>>> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
>>>>>>>> iov_iter_get_pages2() to extract the pages from the iov_iter and
>>>>>>>> memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
>>>>>>>> Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
>>>>>>>> user page reference count increments and decrements and needing to split
>>>>>>>> the memcpy() at user page boundaries. It also simplifies the code
>>>>>>>> considerably.
>>>>>>>>
>>>>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>>>>>>> ---
>>>>>>>>  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
>>>>>>>>  1 file changed, 14 insertions(+), 48 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>>>>>> index 0c74a41a6753..852350e639d6 100644
>>>>>>>> --- a/drivers/block/ublk_drv.c
>>>>>>>> +++ b/drivers/block/ublk_drv.c
>>>>>>>> @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
>>>>>>>>       .open =         ublk_open,
>>>>>>>>       .free_disk =    ublk_free_disk,
>>>>>>>>       .report_zones = ublk_report_zones,
>>>>>>>>  };
>>>>>>>>
>>>>>>>> -#define UBLK_MAX_PIN_PAGES   32
>>>>>>>> -
>>>>>>>>  struct ublk_io_iter {
>>>>>>>> -     struct page *pages[UBLK_MAX_PIN_PAGES];
>>>>>>>>       struct bio *bio;
>>>>>>>>       struct bvec_iter iter;
>>>>>>>>  };
>>>>>>>
>>>>>>> ->pages[] is actually for pinning user io pages in batch, so killing it may cause
>>>>>>> perf drop.
>>>>>>
>>>>>> As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
>>>>>> pinning entirely. It calls copy_to_user_iter() for each contiguous
>>>>>> user address range:
>>>>>>
>>>>>> size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>>>>> {
>>>>>>         if (WARN_ON_ONCE(i->data_source))
>>>>>>                 return 0;
>>>>>>         if (user_backed_iter(i))
>>>>>>                 might_fault();
>>>>>>         return iterate_and_advance(i, bytes, (void *)addr,
>>>>>>                                    copy_to_user_iter, memcpy_to_iter);
>>>>>> }
>>>>>>
>>>>>> Which just checks that the address range doesn't include any kernel
>>>>>> addresses and then memcpy()s directly via the userspace virtual
>>>>>> addresses:
>>>>>>
>>>>>> static __always_inline
>>>>>> size_t copy_to_user_iter(void __user *iter_to, size_t progress,
>>>>>>                          size_t len, void *from, void *priv2)
>>>>>> {
>>>>>>         if (should_fail_usercopy())
>>>>>>                 return len;
>>>>>>         if (access_ok(iter_to, len)) {
>>>>>>                 from += progress;
>>>>>>                 instrument_copy_to_user(iter_to, from, len);
>>>>>>                 len = raw_copy_to_user(iter_to, from, len);
>>>>>>         }
>>>>>>         return len;
>>>>>> }
>>>>>>
>>>>>> static __always_inline __must_check unsigned long
>>>>>> raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
>>>>>> {
>>>>>>         return copy_user_generic((__force void *)dst, src, size);
>>>>>> }
>>>>>>
>>>>>> static __always_inline __must_check unsigned long
>>>>>> copy_user_generic(void *to, const void *from, unsigned long len)
>>>>>> {
>>>>>>         stac();
>>>>>>         /*
>>>>>>          * If CPU has FSRM feature, use 'rep movs'.
>>>>>>          * Otherwise, use rep_movs_alternative.
>>>>>>          */
>>>>>>         asm volatile(
>>>>>>                 "1:\n\t"
>>>>>>                 ALTERNATIVE("rep movsb",
>>>>>>                             "call rep_movs_alternative",
>>>>>> ALT_NOT(X86_FEATURE_FSRM))
>>>>>>                 "2:\n"
>>>>>>                 _ASM_EXTABLE_UA(1b, 2b)
>>>>>>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
>>>>>>                 : : "memory", "rax");
>>>>>>         clac();
>>>>>>         return len;
>>>>>> }
>>>>>>
>>>>>> Am I missing something?
>>>>>
>>>>> page is allocated & mapped in page fault handler.
>>>>
>>>> Right, physical pages certainly need to be allocated for the virtual
>>>> address range being copied to/from. But that would have happened
>>>> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
>>>> you point out, in the common case that the virtual pages are already
>>>> mapped to physical pages, the copy won't cause any page faults.
>>>>
>>>>>
>>>>> However, in typical cases, pages in io buffer shouldn't be swapped out
>>>>> frequently, so this cleanup may be good, I will run some perf test.
>>>>
>>>> Thanks for testing.
>>>
>>> `fio/t/io_uring` shows 40% improvement on `./kublk -t null -q 2` with this
>>> patch in my test VM, so looks very nice improvement.
>>>
>>> Also it works well by forcing to pass IOSQE_ASYNC on the ublk uring_cmd,
>>> and this change is correct because the copy is guaranteed to be done in ublk
>>> daemon context.
>>
>> We good to queue this up then?
> 
> Let me write a v2 implementing Ming's suggestions to use
> copy_page_{to,from}_iter() and get rid of the open-coded bvec
> iteration.

Sounds good.

-- 
Jens Axboe
