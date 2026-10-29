Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267837;
	b=xHkWrhhqwZtSvWFJPDUupp/bU8pQEW6DADSI0/O33sHjZZASwQ9hKb3tj/b9x/d3kEWE
	 rsILCemW4dKSCIpOrHm8OAIZcuETVyN+vpzkNpc0IyTd0R9qlcyybHHLttanVFIk4wlBG
	 Y7tx9nYD7DXHEJafGEeIvZ9qVvvJCp1Jf7vaTtZvoCm5FqtDapR+TWWE+fj6IAKcV03kT
	 fqUk/92v1braHx12QwfW0c8F4T4jU4Z0l5FUOQH2z4ZRrwexnnmfPDYs5Kibs8rOhFaQ0
	 TXg42lO9+42VIeAeJL4vYLVZIJuSmpLLkqLTxTKSXt2afS5fr18XFga8gcqx9BO93dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267837;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hWaXPrGDhyWCEUeKdoM63o7PKlFaYUkm9xCkqBAxeQ8=;
	b=pjhabSzIepCcJb0iJLIcfDdcxXpm0xQQkC1LO/BD9zOcfcRHXO3hA3DUF83VKX5ihY1u
	 v885AHUvEM1a2hDip0zEXCySX9HT1FwQs0q2pJPzRkhnxab28+fruayu/R3Z09Mpcy9yw
	 /gXozriKMtiZ4L1N/u3o0Lyoq5538TyveR8NlyEcjMMHYbHTJ2zvlrW8tGrzP6gAgRaZH
	 TWbK3SbqH6fjYcbnT5NmOJ6IOzYBdQ+mdFu7kDFHaYbsDY4GbB8/qNPE5L3e/dTI0Rzx3
	 7rmdu2MYxeCw6YLrBLtTYqk3UsSw8Ls6DmgODQXfe5sUa4PTBSXisMRjJF40anyZw/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W+8t3+4h;
	arc=none smtp.remote-ip=95.215.58.247
Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9803606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 09:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9803606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W+8t3+4h
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Io8Za75LZDFiHR23Q0ReXlDPmUPWVZA1pjzJJhGltWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793267835; v=1; x=1793872635;
 b=W+8t3+4hzBuvDinHlL4/EKDxfKXJ4cubc1EvEM0vXLoktC0n9sSWJmPduSJC7rgYYU5smwZQ
 cSW/Bh7BxQrBADVQivNj+JWahrOFiESZrj9Jr4N8UEwkwbshany87jIUJB9D8FfYbLD5aTZGoO+
 WzvPqaCenb7HrvGiHq/D6bi0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1cb8ab88aefdeb15;
	Thu, 29 Oct 2026 09:57:15 +0000
X-Mizu-Trace-ID: 1cb8ab88aefdeb15
X-Migadu-Flow: FLOW_OUT
Message-ID: <9145109e-0030-451b-9cca-d23eab30a826@linux.dev>
Date: Thu, 29 Oct 2026 17:57:05 +0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, josef@toxicopanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 linux-kselftest@vger.kernel.org, cuitao@kylinos.cn, ameryhung@gmail.com,
 alexei.starovoitov@gmail.com
Subject: Re: [RFC PATCH v11 0/5] blk-iocost: BPF struct_ops cost model
To: Tejun Heo <tj@kernel.org>
References: <20261028143534.135968-1-cui.tao@linux.dev>
 <07deddf44be391f58d6c3f2e4843582b@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <07deddf44be391f58d6c3f2e4843582b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

Thank you for the review.

在 2026/10/29 04:09, Tejun Heo 写道:
> Hello, Tao.
> 
> Besides the restructuring agreed in my reply to Alexei, dropping
> iocg_init()/iocg_free() and moving everything into blk-iocost.c, the
> series still has problems, which I replied to on the patches. 
I'll rework the series accordingly: drop iocg_init()/iocg_free(),
remove the detach freeze, fold everything back into blk-iocost.c and
drop patch 1, reducing the series to four patches.

The cover
> letter is still long and narrates mechanics, and it still carries the
> v9 and v10 changelogs.
> 
I'll shorten it, focus on the motivation, and drop the v9/v10
changelogs.

Thanks,
Tao

> Thanks.
> 
> --
> tejun

