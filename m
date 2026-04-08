Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0919D891
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652772; cv=none; b=mfQV1sykylJZDJlnOkTdYjfnnfrfijbmZ6KLgdxlw1N2RCM8HmwokyFbBnaUaOWs+vgyUvi1bYi2AKi7fkzP9/IBS7cTphfQiw7xmc4VI1PamBlCMlU9flhsy2fCS5WvscTQc4HGJJx4rlh9F2JZ/0NDAWOmaLdOIKt3sKUxhGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652772; c=relaxed/simple;
	bh=jMHUnEc7ozp9lPL/vhHWDEXpeDEH4e8biCFtHC6Oz8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cdu9ukJOS1CG7ZgolxPao8SB8kTUK9UIlumwV06ahjEjkXaNO5iQ6qDPJAphoG6itfL82OV8v+H9vgmoorYiPyPlEaIeHp+3BWSIAfVRS57serdp22o8pWO+HxVnE/7UEIM8zHSyPHdfN1XUtV7wedhk/xILABejf/bq8UJIM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=b0cke84C; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="b0cke84C"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47018d341f8so3277600b6e.3
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775652770; x=1776257570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMvHJozPZKTx4bF/KPPAjbcsLgUIenY+IBJALpEYZYM=;
        b=b0cke84CI0yDwGDyzA+SXGeVHWX/O2rIzZtOoNH6EYNCDTRK6P3HEyhu9HbmqeX2g0
         4WtVZRsdEHulNEkfFQDLcPYaSjMcWo+4EJ/9NX8DZ7cljb7ZGmEf9liRROP3B9zz3Wb8
         09is53CqpPHXvcyKMrTjVtCeKGxazrgPiCIugd2e6xYJj/CxNLaB25ECTRWsfLU4Rqwg
         bF9mesI4l5HOuAptQIPqxF84izzmQm3+OC5OE+HOCSOA5i+v/648oyJ96MwkhmnwErru
         UXj4TDZP9y2BKu5jyFvEVSn1dlBZa65dZZNSJkptabMBGH/5wcr1VkJ1pIC0yMX5SvDy
         nQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652770; x=1776257570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMvHJozPZKTx4bF/KPPAjbcsLgUIenY+IBJALpEYZYM=;
        b=IKdAEgTDbb9MTBNPagi4+xgeX5r7WcQfk+b7MFKZ9ZUifvh320sW3OrKarVQV29bS6
         uMf6l3OyljOovJUUqgNILmqJ1pxwqhJyIF8bsvVtHNjQcRi+lmIsiMbHHHIKjTv+oFez
         wqg6ftdi5ilnhtkKOtAjX1GYV46o9DYPMnRnITxttb34x4DOIjdI972VJqKbKQSuIcwu
         as/dZfy5tUmYiafXm8xP/Uhd0tC3e6yFmkDv9BAyBGybZFIHSMWqPHy0R+5Cls7nbjfz
         yMhCccztchVklqUHoszOaKf9L6YafflRvk5n8m/1gZoKiNB9yjM6rRJaR06Uw1NQY/cb
         pvBg==
X-Gm-Message-State: AOJu0Yw+Eo+ZZooRaDh2ErNffYnKrmjEJGX65lzN/SdIMGeixJnSNMsJ
	dWqhexAtYodCA8xbc6ek0SQooatPXPygwVJ/n2p+oRGvhYe2zjx2Xp8oogeDwj2RlMA=
X-Gm-Gg: AeBDievkM4AAZ5QLf8NGXdtHSAnsaVJggW0ZqnSMWwRMXRuy9ps/akctBqtf633qE5r
	Bj4DS/6R/q4rEoLwR4QTLBDeg1oUKvhGXRjX9CE2Ug9tpNPpETYTvfShTyiR+PevG6k8eN7bKCr
	dvw51HF9+xIycY0KW5T1sg2BmhX9yW9wjwX4V1XAuXCCyYkG5425I5kZin2Ikh2pfDQYJUQOOaI
	O2CvlbbSC4nXLrTmoVDuyGUPQ1/9o2ovLNL4r3ohb9panKd2sva2/kIFlpKnQyY3ERCsem6IwR7
	YFadCw1/iNM6pkXS/q1OUGHlI6xTyrGGsB5Pdlp8VoguIKZQDIc0IC5J3HnRNIXKr2soad0B6Wu
	UeBUPhQD2x4PvvpaGJ9u9JgKqIFqWdCti7AvKTVTRl/XMc+gTxk0IBiUTKJlwzve47Yrh27MZTm
	5PXLt6liqtVxzpKkHaFBUBWc7sSNXmBeru++DMkDj/H/eNmFwxacjIVwxJs3jFtqsJW4c3LDVRl
	hWOhOmQdg==
X-Received: by 2002:a05:6808:130f:b0:46a:d8b7:1101 with SMTP id 5614622812f47-46efbbea0aamr12079919b6e.41.1775652769723;
        Wed, 08 Apr 2026 05:52:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c6abesm15509989fac.14.2026.04.08.05.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 05:52:49 -0700 (PDT)
Message-ID: <0f4ef4e8-ad8c-4ea6-9b86-04aad5fc84b7@kernel.dk>
Date: Wed, 8 Apr 2026 06:52:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
To: Ming Lei <ming.lei@redhat.com>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <adRuN7V2KDbTJLqd@fedora>
 <CADUfDZoGGUcZ1_ifsXrh_8uy-7DVH30xrbaA+sH8ftwYxB-0Hw@mail.gmail.com>
 <adXFm1dlDzcikarF@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <adXFm1dlDzcikarF@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/26 9:03 PM, Ming Lei wrote:
> On Tue, Apr 07, 2026 at 12:29:39PM -0700, Caleb Sander Mateos wrote:
>> On Mon, Apr 6, 2026 at 7:39 PM Ming Lei <ming.lei@redhat.com> wrote:
>>>
>>> On Tue, Mar 31, 2026 at 11:31:51PM +0800, Ming Lei wrote:
>>>> Hello,
>>>>
>>>> Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
>>>>
>>>> The ublk server and its client share a memory region (e.g. memfd or
>>>> hugetlbfs file) via MAP_SHARED mmap. The server registers this region
>>>> with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
>>>> builds a PFN maple tree. When I/O arrives, the driver looks up bio
>>>> pages in the maple tree — if they match registered buffer pages, the
>>>> data is used directly without copying.
>>>>
>>>> Please see details on document added in patch 3.
>>>>
>>>> Patches 1-4 implement the kernel side:
>>>>  - buffer register/unregister control commands with PFN coalescing,
>>>>    including read-only buffer support (UBLK_SHMEM_BUF_READ_ONLY)
>>>>  - PFN-based matching in the I/O path, with enforcement that read-only
>>>>    buffers reject non-WRITE requests
>>>>  - UBLK_F_SHMEM_ZC feature flag
>>>>  - eliminate permanent pages[] array from struct ublk_buf; the maple
>>>>    tree already stores PFN ranges, so pages[] becomes temporary
>>>>
>>>> Patches 5-10 add kublk (selftest server) support and tests:
>>>>  - hugetlbfs buffer sharing (both kublk and fio mmap the same file)
>>>>  - null target and loop target tests with fio verify
>>>>  - filesystem-level test (ext4 on ublk, fio verify on a file)
>>>>  - read-only buffer registration test (--rdonly_shmem_buf)
>>>>
>>>> Changes since V1:
>>>>  - rename struct ublk_buf_reg to struct ublk_shmem_buf_reg, add __u32
>>>>    flags field for extensibility, narrow __u64 len to __u32 (max 4GB
>>>>    per UBLK_SHMEM_ZC_OFF_MASK), remove __u32 reserved (patch 1)
>>>>  - add UBLK_SHMEM_BUF_READ_ONLY flag: pin pages without FOLL_WRITE,
>>>>    enabling registration of write-sealed memfd buffers (patch 1)
>>>>  - use backward-compatible struct reading: memset zero + copy
>>>>    min(header->len, sizeof(struct)) (patch 1)
>>>>  - reorder struct ublk_buf_range fields for better packing (16 bytes
>>>>    vs 24 bytes), change buf_index to unsigned short, add unsigned short
>>>>    flags to store per-range read-only state (patch 1)
>>>>  - enforce read-only buffer semantics in ublk_try_buf_match(): reject
>>>>    non-WRITE requests on read-only buffers since READ I/O needs to
>>>>    write data into the buffer (patch 2)
>>>>  - narrow struct ublk_buf::nr_pages to unsigned int, narrow struct
>>>>    ublk_buf_range::base_offset to unsigned int (patch 1)
>>>>  - add new patch 4: eliminate permanent pages[] array from struct
>>>>    ublk_buf — recover struct page pointers via pfn_to_page() from the
>>>>    maple tree during unregistration, saving 2MB per 1GB buffer
>>>>  - add UBLK_F_SHMEM_ZC to feat_map in kublk (patch 5)
>>>>  - add new patch 10: read-only buffer registration selftest with
>>>>    --rdonly_shmem_buf option on null target + hugetlbfs
>>>
>>> Hello,
>>>
>>> Ping...
>>
>> Sorry I didn't get a chance to look at this earlier. It looks really
>> nice, thank you for implementing it! I have just a few comments. One
>> is about the UAPI (can we just use virtual addresses instead of buffer
>> index + offset), so I might wait on landing this patchset until we've
>> finalized that.
> 
> Hi Jens,
> 
> Can you drop V2 from for-7.1/block so that we can polish up it in V3?
> 
> Or I am fine to cook up a followup for misc clean & fix?

Please just do a fixup series. If I drop it now, it's not going into
7.1, and the issues aren't that big of a deal to fix up.

-- 
Jens Axboe

