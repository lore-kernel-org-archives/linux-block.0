Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6417B50A
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005650; cv=none; b=XEh60IH1wtOJIWzI1dizUMMXSHzHrY5vsB0SZcMOfNV0BFRAkMHNvBEvvhxFIZaNuSmg+jLcofkVHqCAELtHRpmBe8oKSm5BqTf6SYcf3/Bb/5xI6y4396OrqVeFdyEZZwHLds5+Dr2HSZyCEcHFE4ibtACkyXThbHK3NMeHZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005650; c=relaxed/simple;
	bh=J9Ld9x0FerJUUfhgNjWZRFrM0pc7Iaid6LOvXGnkuio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHfAdHXftwKZYsR+4MEDvp/hRWLNVN0mA771JbC6nwycRdk1dPnuhUlSNT5K3nIcAi1x1YbQvGyEj3GhUHvNSysQdWCIl3iPr8YXWuU8kGa0JC6gLyrrhnMR7l5rsSk29kglFO++4msRLLlmTjTCWjalbELzzyGPx70+t3AFvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pfqma1Xm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pfqma1Xm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738005647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+8R7XrLPo3OtDW62lIO0QU1wUpoT+3fFURlZ+FCeic=;
	b=Pfqma1XmvKHc6AD17O2z61Xcyoz4jxFwAisSC7doHQ/82LmAjD7kt9iS+lnMUhoGfnjXRr
	eNq1qTKtQXf87jSHeNpoY7isheHQdp1b+qQQ2gHo5b5ZPenzDrS6zjYVfQ25WhKukUrscr
	dxcH9Z0SHYzyuULbUoM8hp/SiposG/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-QkpuKAQNNY-8zFPEVR9bqg-1; Mon, 27 Jan 2025 14:20:45 -0500
X-MC-Unique: QkpuKAQNNY-8zFPEVR9bqg-1
X-Mimecast-MFC-AGG-ID: QkpuKAQNNY-8zFPEVR9bqg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so26222835e9.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 11:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005644; x=1738610444;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+8R7XrLPo3OtDW62lIO0QU1wUpoT+3fFURlZ+FCeic=;
        b=e9GGj9ULVxqBx3g223BRQhNcQE2CZkSvKcNz1A05pBj5gjrRix57OFgXhuy2O8hmiM
         rneHw56VtxHb2+/z4BGNFp2cqusJXGy8e0521iWzYKMlma3wwjt87TAQFGZA94FXfnb6
         AksnD5kVDFoyJmxmLNluZMtPclUvk4rkkLw5zlTMJF7m/I2M3V0eGgd6YbFf2V+15Yvv
         v9DAPPnYghzxSEit+gU9MOVwBwA0+JAYIVDvAs+xvEO5jBqAn8bqOF6PXN4fIR58Gzas
         Br4H/FAMEenUUpYU3rR88Ne2IGC2N0hoKoqvnsIzwrz2KEKXm5tEEDCS6eDQsjtM8/S3
         /8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlbHS7VhMGMfrz39hk0bwBL/VMJg34yXMHwBUN2QELBvalIzKdhjhthTCbZSLmJ0rR3Um7a1riylWxNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlvFynj67lqi4Bc9bjinb6ppPomOlcwvMAyBEEe2JGZc+A0x7
	Y5ANpvgV0k1FRjxZxD/0l9wYkN0y2mf6hMlkwQIIzrsAb9QnLGCxcXZIh9YfSYKiGyKAusmWsFM
	+09yc/HXo6LX3vr95DJ1Owd2LMKXbhyKyqTqfNmuTP/X/zetgWAAXaFzcNCvWrtrfEStEZjA=
X-Gm-Gg: ASbGnctz3RICjg40ZwnirT8PnAYZrmj/OFTY/ye163X3fDiUUyWB/Pt+RE1eW3My5Xn
	QgvILWpxzcJvM5Yd1TDulLRrDpN90Nxuh0sVD+Gz2bv9h5QyBrZHSnK/FC44drUWY7kys2TXsnW
	aG13Q8MiaVmeCb/tUh3jpioft5hH1aWvEP6vaBsKXUT3FjYYfEdxpyRIRDqI9GX3JTc1DhR/9t+
	LCaDAGaxrhVGw/tYDsuHk9Lo0CcN52UkTFpZEm1uUmxGUU9JaGV4+uc24KoyMywN9l5h3oIUZ4u
	m1mgNVndOVisfclhV2TQpECEp/dqo6QEbKmu4/ptm2S6DzwhKiHDNMQd5QXOZoE2kLKzXWRqJLD
	ORSiTJQsLrcUzP8QmQbKr4VpMsdiH0dkD
X-Received: by 2002:a05:600c:450c:b0:434:a91e:c709 with SMTP id 5b1f17b1804b1-4389145145fmr339222285e9.28.1738005644527;
        Mon, 27 Jan 2025 11:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE71Hb4CqPQKpkvShDriyZvslj57JxR0E6S5UA5j86UPY5xzedYcuYXgqse5phY7+vcZEkC4A==
X-Received: by 2002:a05:600c:450c:b0:434:a91e:c709 with SMTP id 5b1f17b1804b1-4389145145fmr339222105e9.28.1738005644181;
        Mon, 27 Jan 2025 11:20:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54c0ecsm144033105e9.30.2025.01.27.11.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 11:20:42 -0800 (PST)
Message-ID: <4a75d25f-bcb9-42b6-aa9e-1e63e4be98e3@redhat.com>
Date: Mon, 27 Jan 2025 20:20:41 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Direct I/O performance problems with 1GB pages
To: Andres Freund <andres@anarazel.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Jane Chu <jane.chu@oracle.com>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <w7vcs35omcdqkaszcc6fzvakzdoqkzjwtvdsc3lelcnjgzytib@siim7yk4qjrf>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <w7vcs35omcdqkaszcc6fzvakzdoqkzjwtvdsc3lelcnjgzytib@siim7yk4qjrf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.01.25 18:25, Andres Freund wrote:
> Hi,
> 
> On 2025-01-27 15:09:23 +0100, David Hildenbrand wrote:
>> Hmmm ... do we really want to make refcounting more complicated, and more
>> importantly, hugetlb-refcounting more special ?! :)
> 
> I don't know the answer to that - I mainly wanted to report the issue because
> it was pretty nasty to debug and initially surprising (to me).

Thanks for reporting!
> 
> 
>> If the workload doing a lot of single-page try_grab_folio_fast(), could it
>> do so on a larger area (multiple pages at once -> single refcount update)?
> 
> In the original case I hit this I (a VM with 10 PCIe 3x NVMEs JBODed
> together), the IO size averaged something like ~240kB (most 256kB, with some
> smaller ones thrown in). Increasing the IO size further than that starts to
> hurt latency and thus requires even deeper IO queues...

Makes sense.

> 
> Unfortunately for the VMs with those disks I don't have access to hardware
> performance counters :(.
 > >
>> Maybe there is a link to the report you could share, thanks.
> 
> A profile of the "original" case where I hit this, without the patch that
> Willy linked to:
> 
> Note this is a profile *not* using hardware perf counters, thus likely to be
> rather skewed:
> https://gist.github.com/anarazel/304aa6b81d05feb3f4990b467d02dabc
> (this was on Debian Sid's 6.12.6)
> 
> Without the patch I achieved ~18GB/s with 1GB pages and ~35GB/s with 2MB
> pages.

Out of interest, did you ever compare it to 4k?

> 
> After applying the patch to add an unlocked already-dirty check to
> bio_set_pages_dirty() performance improves to ~20GB/s when using 1GB pages.
> 
> A differential profile comparing 2MB and 1GB pages with the patch applied
> (again, without hardware perf counters):
> https://gist.github.com/anarazel/f993c238ea7d2c34f44440336d90ad8f
> 
> 
> Willy then asked me for perf annotate of where in gup_fast_fallback() time is
> spent.  I didn't have access to the VM at that point, and tried to repro the
> problem with local hardware.
> 
> 
> As I don't have quite enough IO throughput available locally, I couldn't repro
> the problem quite as easily. But after lowering the average IO size (which is
> not unrealistic, far from every workload is just a bulk sequential scan), it
> showed up when just using two PCIe 4 NVMe SSDs.
> 
> Here are profiles of the 2MB and 1GB cases, with the bio_set_pages_dirty()
> patch applied:
> https://gist.github.com/anarazel/f0d0a884c55ee18851dc9f15f03f7583
> 
> 2MB pages get ~12.5GB/s, 1GB pages ~7GB/s, with a *lot* of variance.

Thanks!

> 
> This time it's actual hardware perf counters...
> 
> Relevant details about the c2c report, excerpted from IRC:
> 
> andres | willy: Looking at a bit more detail into the c2c report, it looks
>           like the dirtying is due to folio->_pincount and folio->_refcount in
>           about equal measure and folio->flags being modified in
>           gup_fast_fallback(). The modifications then, unsurprisingly, cause a
>           lot of cache misses for reads (like in bio_set_pages_dirty() and
>           bio_check_pages_dirty()).
> 
>   willy | andres: that makes perfect sense, thanks
>   willy | really, the only way to fix that is to split it up
>   willy | and either we can split it per-cpu or per-physical-address-range

As discussed, even better is "not repeatedly pinning/unpinning" at all :)

I'm curious, are multiple processes involved, or is this all within a 
single process?

-- 
Cheers,

David / dhildenb

