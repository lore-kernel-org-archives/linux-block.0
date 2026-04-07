Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B882222AC
	for <linux-block@vger.kernel.org>; Tue,  7 Apr 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568867; cv=none; b=iAcTITxzqezkg2uE3YrvDzZp+wuH6E9eAsqnm9SlfBydqdMn0CJNNfJmIfmRNS4CKJsMiBUDjZTEg5L84jS3Of/MDacznUzHuEoIK5PlOm9hHXZfZ23VtjnIDAFs3ynEunAGr++QsuUJPvAseVL12sVU3SGM44HTCTUQDJZR/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568867; c=relaxed/simple;
	bh=ZiZiHu1SkgMcTk/MNiN1vQSyW1+PTV8IUZGEOiZu0xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL0nno8n6jw5LJM5CLxrBMXi2HMxQ+aQ3J4sCcQsE0F6fMPwZIgeS1XL0WJr5NXiYCqZBH3Y7Q2cLy2dSTdyiaadSnK/0Udl8inQRGfzwceBb9LxSKi8e65BCDY9dAjMCpLrP1UI97Dr1PWlFt2Ch1RXt/lxB4HnI/seKWrw3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=SFi8TrP1; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="SFi8TrP1"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7f09aa39fso6207110a34.0
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2026 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775568864; x=1776173664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j07h/M+SXjw5sXeZxtAMbOhbQxhLtODjhZgc59Ujo38=;
        b=SFi8TrP1a5XIdmSUV+bzx32BELYWGacRSCeV9iCBKIaSiprtQI6sawOL1svumS+ExB
         UB/NkudmOyJkobWvlGS5EKKs9j3qYOrTyUIs41D32LeXv0yelHdDexSm33ARXIwdO7CK
         WUaRUOtURDXWLSWDxXooO0bLw78QkI4rqtANHiYeKL/8yvZgWfkgyT3CMdShWvGic1AG
         JgMIsu/J+X05ixIW437fHIeg1b72mRkcriDdlFAGW7w7zG50nqz0ogQsxf6i179tMIwU
         PlM9fCS4e8RjfdYqW2IzHEHojr31xMAQ0kRliizTrvybLNIRohIl0DC6oYvQDcDrsmSc
         hXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568864; x=1776173664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j07h/M+SXjw5sXeZxtAMbOhbQxhLtODjhZgc59Ujo38=;
        b=CVjMYMZYqJvQI3k+Oj1PJTaohW8YzuAKYf/E7dWw1sqzRnxOY6Y4hdhWRQ74dvvjR6
         OLGbJbitxnJexerDITtnaiAz14jfoLKPGYpjoIh70/TZEcIDl16TeDR/Ve+ippuKekG4
         SJactGUnwFXnF72g3Tw80HZ+zk5knWMhDjnbCIA3WFCSZMAPQdPMhszyvVSlg45FDHhf
         R9PKZxpjfbwx/e4r+p0mp4h+QUNj87dylOwa2TtO/7Qk0wrN+Ktyc6RT8iv+9wN1wNLC
         WAwDC3G41zBFeyykNzgYt2hOMVQ1hgWr9ETz++b2vhwPrGJ0f0ClbUlzUyYenr8jSFkC
         Ze8A==
X-Forwarded-Encrypted: i=1; AJvYcCUOWKgJfNJ2P+yavfvGmrytsuCR9A3RU95QdplbzbfY5c4wiawmevCW+0ieMmbGJD+dH0tMApGi3v2iWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsnAiQnzbeJuJwwjFLV6XjLoxb01rvBDnyoVaG/mkNYYXgeF2
	DFXIFYUirOyCK5eLp2G4M6ZqBoq3+dPug682yYerI5LvEC7Bb/fLLb9yI92rxSiCizCHtnqu14p
	RviD2
X-Gm-Gg: AeBDiet/uIhuEexjeOxUvCHUkX9QJ8mDJQSX52ubxjYFvx1XLGOTk0zfXoeWIDROdrJ
	n+oKpsH6JtBtis0T+TRIY5kNyHg1tkPgzgxf/f6vuAxiHbS167cuuDlrDscix9n5tplI9S2CRUq
	/o2kh3jRLvst9jJyswehBnAa1Zc2HIFJVzIyz8ON8C/1MR00+VfriPCapms6LXN75X76MHVgx1D
	6D6L6/N+HtqvYUyGkhtF+9rDMOpxHns5g7MMl2aW4rfUmjLlSdHUy5qoA0WbcjU/WFWUonw0WVk
	NZNiPhtstnWlA4lTyiLVN7DmxWQeEgRp+2fZXOip+R8ko/sldGdXSWZ2UyEEuGj5nXGUL3uEhut
	73cGFmWkES6ivl25eOUa87PAhJVRfh9Z5I0bYftzV/d9DcUV3W4w/D0UgN0NCKRYzeVg3DavS5+
	f6llrBQu3RQaFD5W4n/B9S3g+8yWaIh/NjyZ09x5plC7NL3ZL58HMpWqaUhbhm6TKBxllCnmcOo
	8d6ECv8
X-Received: by 2002:a05:6820:818d:b0:67b:cc71:c4fc with SMTP id 006d021491bc7-6821db6ae82mr8220377eaf.23.1775568863932;
        Tue, 07 Apr 2026 06:34:23 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-682b375bc28sm7431374eaf.9.2026.04.07.06.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:34:23 -0700 (PDT)
Message-ID: <acabb7a1-b6f0-4188-9055-ba59954042f6@kernel.dk>
Date: Tue, 7 Apr 2026 07:34:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] ublk: add shared memory zero-copy support
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>
References: <20260331153207.3635125-1-ming.lei@redhat.com>
 <adRuN7V2KDbTJLqd@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <adRuN7V2KDbTJLqd@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 8:38 PM, Ming Lei wrote:
> On Tue, Mar 31, 2026 at 11:31:51PM +0800, Ming Lei wrote:
>> Hello,
>>
>> Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.
>>
>> The ublk server and its client share a memory region (e.g. memfd or
>> hugetlbfs file) via MAP_SHARED mmap. The server registers this region
>> with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
>> builds a PFN maple tree. When I/O arrives, the driver looks up bio
>> pages in the maple tree ? if they match registered buffer pages, the
>> data is used directly without copying.
>>
>> Please see details on document added in patch 3.
>>
>> Patches 1-4 implement the kernel side:
>>  - buffer register/unregister control commands with PFN coalescing,
>>    including read-only buffer support (UBLK_SHMEM_BUF_READ_ONLY)
>>  - PFN-based matching in the I/O path, with enforcement that read-only
>>    buffers reject non-WRITE requests
>>  - UBLK_F_SHMEM_ZC feature flag
>>  - eliminate permanent pages[] array from struct ublk_buf; the maple
>>    tree already stores PFN ranges, so pages[] becomes temporary
>>
>> Patches 5-10 add kublk (selftest server) support and tests:
>>  - hugetlbfs buffer sharing (both kublk and fio mmap the same file)
>>  - null target and loop target tests with fio verify
>>  - filesystem-level test (ext4 on ublk, fio verify on a file)
>>  - read-only buffer registration test (--rdonly_shmem_buf)
>>
>> Changes since V1:
>>  - rename struct ublk_buf_reg to struct ublk_shmem_buf_reg, add __u32
>>    flags field for extensibility, narrow __u64 len to __u32 (max 4GB
>>    per UBLK_SHMEM_ZC_OFF_MASK), remove __u32 reserved (patch 1)
>>  - add UBLK_SHMEM_BUF_READ_ONLY flag: pin pages without FOLL_WRITE,
>>    enabling registration of write-sealed memfd buffers (patch 1)
>>  - use backward-compatible struct reading: memset zero + copy
>>    min(header->len, sizeof(struct)) (patch 1)
>>  - reorder struct ublk_buf_range fields for better packing (16 bytes
>>    vs 24 bytes), change buf_index to unsigned short, add unsigned short
>>    flags to store per-range read-only state (patch 1)
>>  - enforce read-only buffer semantics in ublk_try_buf_match(): reject
>>    non-WRITE requests on read-only buffers since READ I/O needs to
>>    write data into the buffer (patch 2)
>>  - narrow struct ublk_buf::nr_pages to unsigned int, narrow struct
>>    ublk_buf_range::base_offset to unsigned int (patch 1)
>>  - add new patch 4: eliminate permanent pages[] array from struct
>>    ublk_buf ? recover struct page pointers via pfn_to_page() from the
>>    maple tree during unregistration, saving 2MB per 1GB buffer
>>  - add UBLK_F_SHMEM_ZC to feat_map in kublk (patch 5)
>>  - add new patch 10: read-only buffer registration selftest with
>>    --rdonly_shmem_buf option on null target + hugetlbfs
> 
> Hello,
> 
> Ping...

It generally looks good to me. You have a few mixups of struct
ublk_buf_reg which is the old name, and should be struct
ublk_shmem_buf_reg, and similar a function name changed and the doc not
updated. I'll sort these out while applying.

-- 
Jens Axboe
