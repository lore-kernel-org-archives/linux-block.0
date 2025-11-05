Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856932D0E6
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356386; cv=none; b=XcNTiBkfITFdSQwrtUcmO2ciLMB7rWjbsJoQ+jCWRocNorC4WopjsJFvkaTeY2Sp2e/6k5cxqy8w0U//PNbpHLttDGgCgD4kj9Ok4hSWIrPKPgpd+8r9AViVaMnut8yMitOi9SwdctBKwtOkYSVpclQoZb+5WkWNUvpIKU8QoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356386; c=relaxed/simple;
	bh=5ue5tL8Jb7H7Gv3Q/MlTFY91FC7k7XwAJqyggs6Au6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c58RggHnG/+bLKcWheRsou75z0gngZ8vKgiF8cPoRkTSCRTeIq5+8gvImHVzkzgFB0faMeewqwIy6p3MP4Cvbmm4hg/zAFzh3Owq4sHEYMLScUBK8NDz1yyz5148yoMP6h5nsx8Ty2ozuxMnbkIJMlJ+bgYGU+0tnHp7PG7+wkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pv2RJGvq; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pv2RJGvq"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-433261f2045so35412135ab.3
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762356384; x=1762961184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJMw23ag07d9YyGaAXQZB3LwsXKp0Eq82MOZSboYNLA=;
        b=pv2RJGvqqlS6qwKxPM2/MUYvyx4JbywtIfIkm80E8mWJF1SMUBMqT35cxKcA9ayzPl
         46iD1ySEe94AvJSnMzzfq4DGbHtPV0kZU4zBxnwUR9oKzw7jeGmEaLwCRCQ1NncpJbxL
         N9vwF4+oe1bZVzsBvUT7S0w2dCgSWq7U14wVEoUGhuodwcQBnFV51exHDfds+6aesg2h
         F9DP89jla99t0+HXPqG2eepAzjL/hnS5kOpUUgc8j9GuQM3FY1Mov2kAsKammdG/PJ+R
         rkTr5FVY2n1p2h+7G3L9f1NvIwyXHwqIlH1ozkcAI6T4Jjxk2J84au1MgK5haYiMErg1
         pfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356384; x=1762961184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJMw23ag07d9YyGaAXQZB3LwsXKp0Eq82MOZSboYNLA=;
        b=bZIZPClxK7GYUocykhoK9Gl6NQ9iPiNIx0D7h57Kq/m2Tefq1E/+DbJzdham/rY3DR
         0ll7kQWnm550jYvUaKQ/NR7C/BrPdia8Zu3hBf0gLnc0vsDCO7+8VpoWfao9VKp4pUjs
         3xSu8S9mIl1XvBGrd+BweYsjyvZ7FtjeBY6fKpaNaOEf/odpg2gHtZV9H2wRFM8CHNQR
         o3VQzIU9kjDB1tvttPEsKSXX5GoUofRTST5STvZNWy3w8zJPmsiTJDL6/diZNhUUn3HE
         IFrTTWMKbuhGikJo3zZuGFTLOL307Fe+wRJZ+xUfN3lZSK49BEMtPqOAB3xlXYV5Sj6+
         Zx7A==
X-Gm-Message-State: AOJu0YwffyLqUiGh4TZnhVOvsH0XiO858ZCCtNbxykxg1umY1WC6FMRR
	WpK/Pj+BbSiQp+03Djjr86eguA+9tWN8QUNNM5O9mGcVNOQRnkDWC9clqhpNbBIGW8A=
X-Gm-Gg: ASbGncubusoKa0kixMTTSYFxUWc/qfPPyJAvO1D83g8C+M3RS/P6AoErjskCzWfAVjV
	7BHbt9s3+8r8TvXR61l9yirWVtmlgbqYBT2y03GpZ5+5YWiAHtw1q38sf3Sw5thiAyyC+G5/M8p
	QBhu+bZlNY9OH/wDblSvTiW3KqlYjADUTo+GlqfFVp7aWw6U7jCtz9bOoquR+MiS6mJ71PQ+NSy
	PdQLLSlPrAYggS+xnwcpZgP6KqopWH0b9ul1VXzglSzPbWsHgm6JRldNPZ5g6tnDwJdZ4f1/Usw
	lMiEid+oQOkGuu8Bdl2U08aJB8XZc6MmVLyq3vNZ8QWRu8/3L1DbhDXJNEUErfGTwA4CbQOiDf/
	taJG3mS44zG8XUJi1m+0CVhyzhhJ4WmSyWwXePsHmEjAxSb051VBZ/Jz2qIVOio0a5rfOXWFhUD
	/TZXBioWU=
X-Google-Smtp-Source: AGHT+IFOCqH9vMp8Y+tbAbwhk4CARwNNBKaPtY2QKZEvv3tWyjN4/HIZU+2nmwOokQud2POY49dJtA==
X-Received: by 2002:a05:6e02:164f:b0:431:f7df:f026 with SMTP id e9e14a558f8ab-43340753584mr55884735ab.2.1762356383969;
        Wed, 05 Nov 2025 07:26:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335aafb84sm26538755ab.16.2025.11.05.07.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:26:23 -0800 (PST)
Message-ID: <34e94983-3828-469b-bb87-6a08061c101a@kernel.dk>
Date: Wed, 5 Nov 2025 08:26:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031010522.3509499-1-csander@purestorage.com>
 <aQQwy7l_OCzG430i@fedora>
 <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
 <aQVAVBGM7inQUa7z@fedora>
 <CADUfDZqKV2SzbWoe4gr4aSPaBtr+VwmEgEidZKo=LQBU9Quf2Q@mail.gmail.com>
 <aQqs2TlXU0UYlsuy@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aQqs2TlXU0UYlsuy@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 6:48 PM, Ming Lei wrote:
> On Mon, Nov 03, 2025 at 08:40:30AM -0800, Caleb Sander Mateos wrote:
>> On Fri, Oct 31, 2025 at 4:04?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>> On Fri, Oct 31, 2025 at 09:02:48AM -0700, Caleb Sander Mateos wrote:
>>>> On Thu, Oct 30, 2025 at 8:45?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>
>>>>> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
>>>>>> ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
>>>>>> iov_iter_get_pages2() to extract the pages from the iov_iter and
>>>>>> memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
>>>>>> Switch to using copy_to_iter()/copy_from_iter() instead. This avoids the
>>>>>> user page reference count increments and decrements and needing to split
>>>>>> the memcpy() at user page boundaries. It also simplifies the code
>>>>>> considerably.
>>>>>>
>>>>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>>>>> ---
>>>>>>  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
>>>>>>  1 file changed, 14 insertions(+), 48 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>>>>> index 0c74a41a6753..852350e639d6 100644
>>>>>> --- a/drivers/block/ublk_drv.c
>>>>>> +++ b/drivers/block/ublk_drv.c
>>>>>> @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fops = {
>>>>>>       .open =         ublk_open,
>>>>>>       .free_disk =    ublk_free_disk,
>>>>>>       .report_zones = ublk_report_zones,
>>>>>>  };
>>>>>>
>>>>>> -#define UBLK_MAX_PIN_PAGES   32
>>>>>> -
>>>>>>  struct ublk_io_iter {
>>>>>> -     struct page *pages[UBLK_MAX_PIN_PAGES];
>>>>>>       struct bio *bio;
>>>>>>       struct bvec_iter iter;
>>>>>>  };
>>>>>
>>>>> ->pages[] is actually for pinning user io pages in batch, so killing it may cause
>>>>> perf drop.
>>>>
>>>> As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
>>>> pinning entirely. It calls copy_to_user_iter() for each contiguous
>>>> user address range:
>>>>
>>>> size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>>> {
>>>>         if (WARN_ON_ONCE(i->data_source))
>>>>                 return 0;
>>>>         if (user_backed_iter(i))
>>>>                 might_fault();
>>>>         return iterate_and_advance(i, bytes, (void *)addr,
>>>>                                    copy_to_user_iter, memcpy_to_iter);
>>>> }
>>>>
>>>> Which just checks that the address range doesn't include any kernel
>>>> addresses and then memcpy()s directly via the userspace virtual
>>>> addresses:
>>>>
>>>> static __always_inline
>>>> size_t copy_to_user_iter(void __user *iter_to, size_t progress,
>>>>                          size_t len, void *from, void *priv2)
>>>> {
>>>>         if (should_fail_usercopy())
>>>>                 return len;
>>>>         if (access_ok(iter_to, len)) {
>>>>                 from += progress;
>>>>                 instrument_copy_to_user(iter_to, from, len);
>>>>                 len = raw_copy_to_user(iter_to, from, len);
>>>>         }
>>>>         return len;
>>>> }
>>>>
>>>> static __always_inline __must_check unsigned long
>>>> raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
>>>> {
>>>>         return copy_user_generic((__force void *)dst, src, size);
>>>> }
>>>>
>>>> static __always_inline __must_check unsigned long
>>>> copy_user_generic(void *to, const void *from, unsigned long len)
>>>> {
>>>>         stac();
>>>>         /*
>>>>          * If CPU has FSRM feature, use 'rep movs'.
>>>>          * Otherwise, use rep_movs_alternative.
>>>>          */
>>>>         asm volatile(
>>>>                 "1:\n\t"
>>>>                 ALTERNATIVE("rep movsb",
>>>>                             "call rep_movs_alternative",
>>>> ALT_NOT(X86_FEATURE_FSRM))
>>>>                 "2:\n"
>>>>                 _ASM_EXTABLE_UA(1b, 2b)
>>>>                 :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
>>>>                 : : "memory", "rax");
>>>>         clac();
>>>>         return len;
>>>> }
>>>>
>>>> Am I missing something?
>>>
>>> page is allocated & mapped in page fault handler.
>>
>> Right, physical pages certainly need to be allocated for the virtual
>> address range being copied to/from. But that would have happened
>> previously in iov_iter_get_pages2(), so this isn't a new cost. And as
>> you point out, in the common case that the virtual pages are already
>> mapped to physical pages, the copy won't cause any page faults.
>>
>>>
>>> However, in typical cases, pages in io buffer shouldn't be swapped out
>>> frequently, so this cleanup may be good, I will run some perf test.
>>
>> Thanks for testing.
> 
> `fio/t/io_uring` shows 40% improvement on `./kublk -t null -q 2` with this
> patch in my test VM, so looks very nice improvement.
> 
> Also it works well by forcing to pass IOSQE_ASYNC on the ublk uring_cmd,
> and this change is correct because the copy is guaranteed to be done in ublk
> daemon context.

We good to queue this up then?

-- 
Jens Axboe
