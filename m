Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E55B39FD9
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551553; cv=none; b=k9aPpQRRB/zXqB307BcRhqMmTPSenAsod7zDYhcxQppzCvxr1nGMJ/fNM2vhgEos9d5JV5dL3EyzAydzbMzv+LWcQjtbDQ+y5hysyZXcaMR/ioomOg/Py3pc8QWRZjHy3Sfxt6CXILTc4+V6ZCOTUGEqQW1M+GuQ34oDfAhxQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551553; c=relaxed/simple;
	bh=uA9kSXqWmjiE1THg03LaDivdGzELSi5NT+E5zOtzdvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLrNl3V9Cq097N9NWle3uH7U5A37OoFSSE6n6YaehwBsmiu0gZZuRO7RtgN+qxdUlmS3Ifgm9yhz/HetvD0o9+/q9tTsG/bxMzNuL6x74xaRdlI72n0LZZHzG+BTR6i/CtXf6qCaWkNmCC4FWRkUf1slrSWe0wi/b6ECjQO1OzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB4uFiP6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB4uFiP6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38245e072e8so4634755f8f.0
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 08:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732551549; x=1733156349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSD3aRNDMkY4Pw4NIgjIzjJpElfB8e8RRBrwwFpvTOM=;
        b=RB4uFiP66dO9pa5MOwNdvHdiA133vHCJTQYh40hwoEXdECH9LdgbMV6DeFXrlSIipS
         GL9WhWQyYwL43lITdeLIKw4EA0hj+Qkrj28g41hOYbn23NIwa6n9TBZzeetDqSKbMx08
         KcObvCO5OeSuFDdIxgjMKcskYM11nUEaixTytxqlfwMJP1dEgPNOchglIb3UbVak6RD6
         H2ur7hwmxI2Z9URqwMNKbPVsW2QOUMl17a7oVxcEVw+VHZA0AOpKyH9jdRH3Z75FNg+c
         bP/+FrZuse622DipzqUiT7BAwAKq/nSGEKxOjh6q8TRK3dKl3YsCiYlxJf22qa3lI+V4
         tNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732551549; x=1733156349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSD3aRNDMkY4Pw4NIgjIzjJpElfB8e8RRBrwwFpvTOM=;
        b=iRkkqtDe1s+OXN6y8ndWeJaMAK3iJlqX9QHnqZnQPOuhYCW9xihNugIlsReCT5eroH
         HIylBUJS5Sp3NjK1MaKERmpW4azln98R+0eJlnh8BjnIXuSpCiuu4GKGfDsTt3sATuEx
         MdrFVtG17uTdYfo/rsqI138+zvtQmpXlGehUwf/nQIxHPWlVPgZqLMVRrOzYTQSxpwN9
         H/1KYrWIjhRxB+Sr6eHD2iuJvIpQo61m44OcsHYvMewrld9mPYzvkCCZsxd9b4vqXmGX
         QCihpBiR0RKck6pP7VeVPMqL7WFxF9/C5/8SpklECpUTeN2YMJGLjBpw8rx1xq85BPRf
         f8pA==
X-Forwarded-Encrypted: i=1; AJvYcCXOqEnP4JZ9ZzOFjK61DRBQAuw5F9lBmwTarkBRbn/mlBmsboVDdCcHTpElS5C6k2a8ebwDsDsUCLwtXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrjH9JR44ZBBn3814JG+W+wU3vs5xkJmToZEECSaI+DzaUZIb
	/8roBZIgjW27u6qMA4234VZMvuYF0u6E5iThVamzJhhQz68TuDRa
X-Gm-Gg: ASbGncuq7BtHpjStH6hsoP5MrzMpwa3MyCIIoB8kbKPCf8yIKyv3tzMdur9I+D6cOMc
	SFBlqlbbphexRMSLz4PzMkzLDrRUsspxsZho7iMakxUwXESt+HHv8JFo1CMVx4W1Rjz/yoUklZ0
	GKRf7eb0ZG1lwF+XWyHtto1PkiYVIEysnRak2ZIig4/Ozfn2meixNXzL0SLRlYf4ZwimCTNyijI
	M3vqMHsUMK6CgmUip5ulhpj+DJ+zn7bZA59BVc+dJTdf945ihMPxFWUghbfmi9m08eT/D6+w7dz
	5ds/eOG6xRAs/XUqu+I/sw/YoV0x1sl0BgrUu7eCOuvewA==
X-Google-Smtp-Source: AGHT+IEU8oz3NceCX8oxiMV1ikeXO5kPQP265M86hu0lxXMRzFnslgBobY2PVpUyxZ1t6RBGE4f6qw==
X-Received: by 2002:a05:6000:186c:b0:382:4849:d5c8 with SMTP id ffacd0b85a97d-38260b81082mr14217728f8f.31.1732551549028;
        Mon, 25 Nov 2024 08:19:09 -0800 (PST)
Received: from ?IPV6:2a01:4b00:b211:ad00:1c87:efae:a44a:15a7? ([2a01:4b00:b211:ad00:1c87:efae:a44a:15a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb25d74sm10936433f8f.47.2024.11.25.08.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:19:08 -0800 (PST)
Message-ID: <b6db556d-70e6-4adf-9ce1-d4e5af08e89c@gmail.com>
Date: Mon, 25 Nov 2024 16:19:07 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 4/4] mm: fall back to four small folios if mTHP
 allocation fails
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk,
 bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com,
 linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com,
 ryan.roberts@arm.com, senozhatsky@chromium.org, surenb@google.com,
 terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com,
 willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
 yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com,
 Chuanhua Han <chuanhuahan@gmail.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
 <20241121222521.83458-5-21cnbao@gmail.com>
 <24f7d8a0-ab92-4544-91dd-5241062aad23@gmail.com>
 <CAGsJ_4wL=CgXdCt+2QC+aSKPh1873QyD_4ZkRSBniUipKX9AVA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4wL=CgXdCt+2QC+aSKPh1873QyD_4ZkRSBniUipKX9AVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/11/2024 21:47, Barry Song wrote:
> On Sat, Nov 23, 2024 at 3:54 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 21/11/2024 22:25, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> The swapfile can compress/decompress at 4 * PAGES granularity, reducing
>>> CPU usage and improving the compression ratio. However, if allocating an
>>> mTHP fails and we fall back to a single small folio, the entire large
>>> block must still be decompressed. This results in a 16 KiB area requiring
>>> 4 page faults, where each fault decompresses 16 KiB but retrieves only
>>> 4 KiB of data from the block. To address this inefficiency, we instead
>>> fall back to 4 small folios, ensuring that each decompression occurs
>>> only once.
>>>
>>> Allowing swap_read_folio() to decompress and read into an array of
>>> 4 folios would be extremely complex, requiring extensive changes
>>> throughout the stack, including swap_read_folio, zeromap,
>>> zswap, and final swap implementations like zRAM. In contrast,
>>> having these components fill a large folio with 4 subpages is much
>>> simpler.
>>>
>>> To avoid a full-stack modification, we introduce a per-CPU order-2
>>> large folio as a buffer. This buffer is used for swap_read_folio(),
>>> after which the data is copied into the 4 small folios. Finally, in
>>> do_swap_page(), all these small folios are mapped.
>>>
>>> Co-developed-by: Chuanhua Han <chuanhuahan@gmail.com>
>>> Signed-off-by: Chuanhua Han <chuanhuahan@gmail.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>  mm/memory.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 192 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 209885a4134f..e551570c1425 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4042,6 +4042,15 @@ static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
>>>       return folio;
>>>  }
>>>
>>> +#define BATCH_SWPIN_ORDER 2
>>
>> Hi Barry,
>>
>> Thanks for the series and the numbers in the cover letter.
>>
>> Just a few things.
>>
>> Should BATCH_SWPIN_ORDER be ZSMALLOC_MULTI_PAGES_ORDER instead of 2?
> 
> Technically, yes. I'm also considering removing ZSMALLOC_MULTI_PAGES_ORDER
> and always setting it to 2, which is the minimum anonymous mTHP order.  The main
> reason is that it may be difficult for users to select the appropriate Kconfig?
> 
> On the other hand, 16KB provides the most advantages for zstd compression and
> decompression with larger blocks. While increasing from 16KB to 32KB or 64KB
> can offer additional benefits, the improvement is not as significant
> as the jump from
> 4KB to 16KB.
> 
> As I use zstd to compress and decompress the 'Beyond Compare' software
> package:
> 
> root@barry-desktop:~# ./zstd
> File size: 182502912 bytes
> 4KB Block: Compression time = 0.765915 seconds, Decompression time =
> 0.203366 seconds
>   Original size: 182502912 bytes
>   Compressed size: 66089193 bytes
>   Compression ratio: 36.21%
> 16KB Block: Compression time = 0.558595 seconds, Decompression time =
> 0.153837 seconds
>   Original size: 182502912 bytes
>   Compressed size: 59159073 bytes
>   Compression ratio: 32.42%
> 32KB Block: Compression time = 0.538106 seconds, Decompression time =
> 0.137768 seconds
>   Original size: 182502912 bytes
>   Compressed size: 57958701 bytes
>   Compression ratio: 31.76%
> 64KB Block: Compression time = 0.532212 seconds, Decompression time =
> 0.127592 seconds
>   Original size: 182502912 bytes
>   Compressed size: 56700795 bytes
>   Compression ratio: 31.07%
> 
> In that case, would we no longer need to rely on ZSMALLOC_MULTI_PAGES_ORDER?
> 

Yes, I think if there isn't a very significant benefit of using a larger order,
then its better not to have this option. It would also simplify the code.

>>
>> Did you check the performance difference with and without patch 4?
> 
> I retested after reverting patch 4, and the sys time increased to over
> 40 minutes
> again, though it was slightly better than without the entire series.
> 
> *** Executing round 1 ***
> 
> real 7m49.342s
> user 80m53.675s
> sys 42m28.393s
> pswpin: 29965548
> pswpout: 51127359
> 64kB-swpout: 0
> 32kB-swpout: 0
> 16kB-swpout: 11347712
> 64kB-swpin: 0
> 32kB-swpin: 0
> 16kB-swpin: 6641230
> pgpgin: 147376000
> pgpgout: 213343124
> 
> *** Executing round 2 ***
> 
> real 7m41.331s
> user 81m16.631s
> sys 41m39.845s
> pswpin: 29208867
> pswpout: 50006026
> 64kB-swpout: 0
> 32kB-swpout: 0
> 16kB-swpout: 11104912
> 64kB-swpin: 0
> 32kB-swpin: 0
> 16kB-swpin: 6483827
> pgpgin: 144057340
> pgpgout: 208887688
> 
> 
> *** Executing round 3 ***
> 
> real 7m47.280s
> user 78m36.767s
> sys 37m32.210s
> pswpin: 26426526
> pswpout: 45420734
> 64kB-swpout: 0
> 32kB-swpout: 0
> 16kB-swpout: 10104304
> 64kB-swpin: 0
> 32kB-swpin: 0
> 16kB-swpin: 5884839
> pgpgin: 132013648
> pgpgout: 190537264
> 
> *** Executing round 4 ***
> 
> real 7m56.723s
> user 80m36.837s
> sys 41m35.979s
> pswpin: 29367639
> pswpout: 50059254
> 64kB-swpout: 0
> 32kB-swpout: 0
> 16kB-swpout: 11116176
> 64kB-swpin: 0
> 32kB-swpin: 0
> 16kB-swpin: 6514064
> pgpgin: 144593828
> pgpgout: 209080468
> 
> *** Executing round 5 ***
> 
> real 7m53.806s
> user 80m30.953s
> sys 40m14.870s
> pswpin: 28091760
> pswpout: 48495748
> 64kB-swpout: 0
> 32kB-swpout: 0
> 16kB-swpout: 10779720
> 64kB-swpin: 0
> 32kB-swpin: 0
> 16kB-swpin: 6244819
> pgpgin: 138813124
> pgpgout: 202885480
> 
> I guess it is due to the occurrence of numerous partial reads
> (about 10%, 3505537/35159852).
> 
> root@barry-desktop:~# cat /sys/block/zram0/multi_pages_debug_stat
> 
> zram_bio write/read multi_pages count:54452828 35159852
> zram_bio failed write/read multi_pages count       0        0
> zram_bio partial write/read multi_pages count       4  3505537
> multi_pages_miss_free        0
> 
> This workload doesn't cause fragmentation in the buddy allocator, so it’s
> likely due to the failure of MEMCG_CHARGE.
> 
>>
>> I know that it wont help if you have a lot of unmovable pages
>> scattered everywhere, but were you able to compare the performance
>> of defrag=always vs patch 4? I feel like if you have space for 4 folios
>> then hopefully compaction should be able to do its job and you can
>> directly fill the large folio if the unmovable pages are better placed.
>> Johannes' series on preventing type mixing [1] would help.
>>
>> [1] https://lore.kernel.org/all/20240320180429.678181-1-hannes@cmpxchg.org/
> 
> I believe this could help, but defragmentation is a complex issue. Especially on
> phones, where various components like drivers, DMA-BUF, multimedia, and
> graphics utilize memory.
> 
> We observed that a fresh system could initially provide mTHP, but after a few
> hours, obtaining mTHP became very challenging. I'm happy to arrange a test
> of Johannes' series on phones (sometimes it is quite hard to backport to the
> Android kernel) to see if it brings any improvements.
> 

I think its definitely worth trying. If we can improve memory allocation/compaction
instead of patch 4, then we should go for that. Maybe there won't be a need for TAO
if allocation is done in a smarter way?

Just out of curiosity, what is the base kernel version you are testing with?

Thanks,
Usama 
