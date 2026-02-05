Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3E42B744
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306948; cv=none; b=nysoGjVOllWGtlttsx/iiatwAn7KazQQcKzCTbaFKftgknFChTlzN3hZJ0yr/Cd27dPWmNCJmY6DwqUWPRnlyxot4vWPbXIW2osJZnWoJ3Yjf7lE6BgY+lEGw79dO74lYxHSs6JrL810OxTPyR3fN/03QfLdgltg7eqLL+/AybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306948; c=relaxed/simple;
	bh=iV9sP5mmSmfGZcR7FJWYVF06mIRJL+lwHuJxYRv4oiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6iMsJd07IlDWtqw0+nw+ESwMXn8KejfwPdRZn211NTm04ZPkofFo8WtSf8zA/SoJAuezuLZPexMdwsBo7e9gEAyE9bn30QI1Ti062cyR5N1sYbzGaMg+RJkdjFOILCKO161VKLcDKR1XwLgVzYKXm+m1m0u5qQuEykkGaroZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l2sHb/or; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l2sHb/or"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso895068a34.2
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306947; x=1770911747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvT4BB7laPBurfcYuu1QzQTlY+sAIOn6S7atHkXFEm4=;
        b=l2sHb/orD4vF710SEM2UOPHDGjxpMaH1l65bhosCmABahKXCff+kSxpaJbwevQF/Sh
         zCdASbW/6rL9A/qs59svrVWKEzEQvSvovG40hRp65EL0NzwIuiVxA9/MzMRaiiY7wXnd
         EgqPIczGrbIkomrqJ7UplVZhVseVLQPrLu6ABBgs6fP+IbbUPL4550BPEnlSR6bclxxL
         WaD3tTmMozYqfwF+RIqEs5Ir5NMQhQ7UXTOyu6DgEIde7P51ye9Jr5p5ggXBGoEaWgpL
         /kweFs2b8F85QFYtYPSOCk01UXUe4bBmRVdsGLaPv+FOOcgKjmjx0F0UjzfC7Cd5pnml
         ERzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306947; x=1770911747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvT4BB7laPBurfcYuu1QzQTlY+sAIOn6S7atHkXFEm4=;
        b=SRM+27Xepa9FpM52wsXyTbz4YC90bYiV/jC6fPXvQwTTnQLd1wli5NpPMFP0QznGu+
         4EvNOYNhWH1W928CioM2fpqhvuMU3fHT1BYsdfMRpXxN8B/IPYljQwVzL7ypBLX5LaYG
         SoRc5Db3WPEVmmSoxY0E09JPjN7Om6kSH9enoBlko6mxW5JAZzHlxHwuMjHmLV+BTl3N
         jnaz+OzNnZOUjoIZSmwujyN+v7tFuCglAhKuTt+DYXpfnQqDAchcKNcb1+ESefHE7r2h
         lIUCy6/VUWmEA/nA0asliSQGvyMIdOi1LUNm/ZrW3nk3JPCGgZpzazRkdaXOxQe95Fm1
         heqw==
X-Forwarded-Encrypted: i=1; AJvYcCXWqeoY3zMBYyWe+GexFXSVvWE+jJHc2Uq3rGprqiDjyElnavPUbiCHQOC/C36wgP5Eq0XVZfM0oGdu+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsbULy8QclyC4Nz6y8yGJE9ncidnOECTSr6WyNp4K3lh5zrUkt
	g3siRMiSKH6GoC6g2RoduQ0S8If1pAnELQ1qcXYZTDruQSo9CxG9veEFocDIDVuCEsANf9+BOQF
	KPHnz0ew=
X-Gm-Gg: AZuq6aKzviYvAjff4OtXsiCznbP+sASS7eqxzOs5joVGPEziMG68bKlDgHd5aPlQJhz
	nPSBT1w5Wv4JF95RosjPyXNrqjtJYQa9O2kfj36x3eFdwmzkzQYHfyAfQbch2Gkk6eiRf3PnRh7
	GNGuHxhv9GGFx290FvSraZYVCuJygMFHoXDUcf7QEuBGAx+9FmHtsRQIfDodrX0YN9tvGtM6TS4
	m+lKkYRk8hFFt/Z0Gtr99wR8WKRc3T41AEOJYChteVZb2sjKbNkUrhb+gZ6gTDdtjm4ugj/DWem
	ei6BlpEAPCCTZd8uLaNgMPDcAJ5RPiBiA8LFseBMY6ZyZ+h0QNW9b+npOhbkORFz1iUGaJjGc8k
	JUvuyY6z4HMAJBJMptlVNx6FmpiLyzSXSV7XNuE1rnjrfFGbeDiXxsIHREZf82W7Z7sgWZXz/LQ
	WpN0mI1y2piJtp9w9JyKlrtg3vljv9Bm2dywEnzuSn4OlXA40o+sqHVC72lkueKt73YEj2Smatd
	0L346/0
X-Received: by 2002:a05:6830:2690:b0:7cf:cd4c:347 with SMTP id 46e09a7af769-7d448accbb9mr3451279a34.30.1770306947375;
        Thu, 05 Feb 2026 07:55:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4492017b6sm3814774a34.15.2026.02.05.07.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:55:46 -0800 (PST)
Message-ID: <91c3fbcd-dd8c-4633-96c4-9b60022cb857@kernel.dk>
Date: Thu, 5 Feb 2026 08:55:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
 <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
 <ded8f99f-2d4a-48fc-9cff-02aa317a1c25@kernel.dk>
 <aYS9KeAYcTh9GIaJ@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aYS9KeAYcTh9GIaJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 8:54 AM, Keith Busch wrote:
> On Thu, Feb 05, 2026 at 08:49:35AM -0700, Jens Axboe wrote:
>> On 2/5/26 8:47 AM, Jens Axboe wrote:
>>> On 2/5/26 8:38 AM, Keith Busch wrote:
>>>> Hi Jens,
>>>>
>>>> Some late fixes for nvme that should go in this release. One for a pci
>>>> regression that causes a kernel panic during certain dma conditions. The
>>>> other fixes a vulnerability in the tcp target.
>>>>
>>>> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
>>>>
>>>>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
>>>>
>>>> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
>>>>
>>>>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
>>>>
>>>> ----------------------------------------------------------------
>>>> nvme fixes for Linux 6.19
>>>>
>>>>  - Fix NULL pointer access setting up dma mappings (Keith)
>>>>  - Fix invalid memory access from malformed TCP PDU (YunJe)
>>>>
>>>> ----------------------------------------------------------------
>>>> Keith Busch (1):
>>>>       nvme-pci: handle changing device dma map requirements
>>>
>>> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
>>> will trigger a compiler warning...
>>
>> Actually this is only true in the 7.0 based branches. Should be fine
>> for 6.19, I'll add a commit for the 7.0 merge.
> 
> Yeah, I initially applied this to 7.0 with it removed, but we decided
> this was a nasty and easy to hit bug that 6.19 is better of having fixed
> on release. I had to leave the 'iod' in for the 6.19 port, so looks like
> we'll have a merge conflict for the next cycle.

It actually merges cleanly, but you then end up with that leftover
iod. If it hadn't merged cleanly, I would've seen it before building
it :-)

-- 
Jens Axboe

