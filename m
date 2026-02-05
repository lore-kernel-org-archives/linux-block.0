Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E33263F4A
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315216; cv=none; b=EZABa2n9Mg5kDijmzoJqm8F+AzrmKe93kRtC9Y0Vad/tThGU+OmQ5sAzFtyzZv0JFVrf6kNPJMneRqOWn5UvKVFLbsUJViJstRUPrNgLtGVSUUVVe4cSTRlLfdFTW0X3gjYAP0aFDVYujw7v6Oi3SDYWqs9dQBducRmMnP9wnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315216; c=relaxed/simple;
	bh=o/o1F1p96xxSNwlR+KUbEXWGnJNwQJAGUizzA2xVzBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onY3YxsHdX7uBAK4q0/cPd6bBfREIbK95TLFZMSotbJ0ocJbYdChk3vFEfvhgo2qBwDi6b17Up3F6OAgPw+fvU5sClSsXVB667exWyjK3+ze716BN86Ch3/0kqW30lyI1iD4for+w1w1hjDZPBD4M6KcoTBBVvIXuD6tXlNG8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMRJfTvg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMRJfTvg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so12355015e9.0
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770315215; x=1770920015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOIgzh7F0/asMA4wYQkOAKt2bxR52YWhKTa5Hn1hbLY=;
        b=JMRJfTvgHK4258VXuMgLxrXiRjiSJnQ/B/YJAF3SwPm/SzwDDwp0pUoJEVuHtWWJEK
         u6TbYtFofMI40OTP52gBjcDuju4NTR8gmwulkoaNLWEHZp1HuB9Hi0i/vtkleMIk3Bog
         TgTKwZnn5yOB4xreLHTsYJ+LEeFM2cPlv+7StToff0Y3ko5i/FWY/p+323tAbbVIdsZD
         k5FNyyqrsevzJIxtCpYAcFFPxIbSLZEWSXvSttSfTDDoiTsoi+RuOeAiDySpOE1Tw81s
         j5JbrnY1O7OXyNV537qD1jtyrhi149wEM8nDOv4V8OTmZN5pJe9KY214kxTf8YwJ5eLJ
         S+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770315215; x=1770920015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOIgzh7F0/asMA4wYQkOAKt2bxR52YWhKTa5Hn1hbLY=;
        b=xQWt5D2jb4hgaFDjBiwMph9iLX935i5oDqFotBt5Z/blUuq6VovgbzrFWZ5bPYE8Jz
         bG0RK3aph+9zfElZrGqqpkKHa0IwYbtD4P4GDln1/LhdUvBGhmwmir39mnvXwRcOl4Tj
         Pj/ZCrrf49qx4CQYjE/VJgYV/0bDEpJiTHioBF1vTdeeU/Jesa50DFY2wUSk93rIOoYU
         pdOl0rBTe/z+BOl4MC4hencJ2LgxQr4YY2BxNnBOakTBNggVct72Tn5+YQLjrAjGrOwu
         EcB8wF/XDnqL3tjc3MBRpcPXIFM8ZhWL3EJ3W7AHtFntP2xGt8N7zpHqzPd8XJqXxTVr
         PHUw==
X-Gm-Message-State: AOJu0YxihwQB2yP99t2sT5PZWFbYx7YXB/hJO7HBaWNORfDLkl38zKiR
	4A1JbOn9LUHyvLNbLRLQKEBUcHOTHolyFNHjSVSg3CzL3ODtar+8HO95
X-Gm-Gg: AZuq6aKbUJaAJa+0lGI5X+Kb4yOgb8W6hhp/ba2XWg0eVGzkOJwFqO4abOqWyogq50X
	khWz2YUWluPe+lG6xO7jGYh/zkRhon3OLm1zZ8f2BpbaK5YDAsMAxCtglMfGbuyMStv0aEhAdW1
	YywMydxD6s9SnMNyuHpyt+RWo69WkuanJg1M1xNjkRi1Ao2Im45U4LEVHBS2WXzKnzeXUvxwdJX
	tVOf9QjcGtPYwpv2TrW5kL3ve3RzSgt7iV71LzY5ELboj6GlKP4W/HqYujZ6UAmBP8z6sxB4CHy
	y/LilP4vSccwSXrwrC7Ot+PW8NyJW/hwtTmkqlyuNgTOv9F/nP1izM/u/l8tDM5YhGrDDHSPD6h
	qldM3WfvylTNKBR+ih5En25rPmK/Hm4FCXDl9O3f2c1EmtGWLpRyh84OLuuObMHv8a3gQZpZpPm
	xaKokks1yPVpWzvn6my4uSelELb+NBYoKIJ64cKFZXCiQNmWCwZFwpfcWqCKbMPew5BR/deXStv
	kSb8z0c3R3n2lf4NdIbAKJ2RoBYAujanpIWXYj5Tnne3uFh3l1wnPjew9Jsiz+K/A==
X-Received: by 2002:a05:600c:2eca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-483178ebb2emr36092105e9.6.1770315214446;
        Thu, 05 Feb 2026 10:13:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2085asm76942305e9.1.2026.02.05.10.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 10:13:34 -0800 (PST)
Message-ID: <2403ae2a-0e9e-4b7f-a507-232dc951155d@gmail.com>
Date: Thu, 5 Feb 2026 18:13:30 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <aYQKhcnTJLimnbEn@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aYQKhcnTJLimnbEn@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/26 03:12, Ming Lei wrote:
> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>> Good day everyone,
>>
>> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>> and there is growing interest in extending it to the read/write path to
>> enable device-to-device transfers without bouncing data through system
>> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>> useful to mull over details and what capabilities and features people
>> may need.
>>
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping. The actual mapping
>> creation is delegated to the target subsystem (e.g. NVMe). This
>> abstraction centralises request accounting, mapping management, dynamic
>> recreation, etc. The resulting mapping object is passed through the I/O
>> stack via a new iov_iter type.
>>
>> As for the user API, a dma-buf is installed as an io_uring registered
>> buffer for a specific file. Once registered, the buffer can be used by
>> read / write io_uring requests as normal. io_uring will enforce that the
>> buffer is only used with "compatible files", which is for now restricted
>> to the target registration file, but will be expanded in the future.
>> Notably, io_uring is a consumer of the framework rather than a
>> dependency, and the infrastructure can be reused.
> 
> I am interested in this topic.
> 
> Given dma-buf is inherently designed for sharing, I hope the io-uring
> interface can be generic for covering:
> 
> - read/write with same dma-buf can be submitted to multiple devices
> 
> - read/write with dma-buf can cross stackable devices(device mapper, raid,
>    ...)

Yes, those should be possible to do, IIRC Christoph mentioned it
as well while asking to change the design of v1. The
implementation will need to forward registration down and create
a dma-buf attachment for each device.

-- 
Pavel Begunkov

