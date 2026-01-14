Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D80389452
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383649; cv=none; b=uKGS9EVawgHZ1jBcF5FIryc/JTMUkqE8qPC1Ig34Gemm7R7H17aMlqjlrt9nzHEyOP8RHzXuKPGV+uXtSdH3+5McCXhTXQfZiA4V/NIdO54MkdC1Pyab+TP8nClw9AreQaIPngCac0CcZ81pDx6h3P57Y8LvWidReRxIQYL6tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383649; c=relaxed/simple;
	bh=nMJDsM/X4wvAEnzGtYm+OaIiKJhQSbm87ViQjIHqr1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyloICMKB3w7nvARjHm2+L/xoyvRxnLVpZDaUrDCq8HpCJBe55ewfDKyPHMyG9pmUNLjnFW0TWEMmsD63d3NwcJsg0Spl7LAvpYJajLPKl0pRsibUOpRyR32sjf8k5Ht/pMY4xxJqjQGzwyR0nGAaulMlp+UMLJWkEN9c/K94sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=XcLYYcsw; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="XcLYYcsw"
X-Virus-Scanned: Yes
Message-ID: <4817253e-2cec-4cf8-95c4-6292e758fb8f@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1768383643; bh=nMJDsM/X4wvAEnzGtYm+OaIiKJhQSbm87ViQjIHqr1M=;
	h=Subject:To:Cc:References:From:Reply-To:In-Reply-To;
	b=XcLYYcswYgefT3rNfQPaezZVd4WN54pAL+QdJWSzyPCGwc113nezbIeVNTPk/yr4G
	 gxTklLs8Nu8fOgNfLL1leyEsWua7FqMhLDebDCJuBrii8VJ8rlCUiaLFmJdZyl726A
	 TVD3jS5n2OFVMswy5XL9REdF6Mt0j5OR46wkEszBSueZMg5+/ZNbH/owGUZzkywCoc
	 wSoGpyScP3QgcEcBunCidPsYV2pxqwETtgREvr8l41P5PMJjHFlcSlW8ZpQ2rCkdgm
	 MlNMF6cJ9v4OePXg6PAJq+MXk5L9X/ee+DuP7VTFD07KlPQgg5ADDquXiz/95CXmF9
	 jQXLcvCwNLGFPmIITZ3TvRQ5VXUiMP5e4jN0flZ8AqGNh44psjVK9VcJwzYTVOI5Yn
	 XrhAwWrMsacPPy11pcWi/I+xTaJSkekt8d3lD61TkDejpA9IiahW/CDvkVoYH/muUZ
	 cBrB8dx+8cC3it/FJB2gcV3OeNMWAAgkuVfhcj6pSk2F5AJSECo9tZQOOWCOzc3Hw4
	 1HJ/s6BVHbX2bT7VLFXAYGhDGECCFHm/ZLKdX8PmcvPDf8qN7n8AylwHGu4f2BM0mZ
	 tarqEJKsl7FNg3yVm11x5faL/H7bOtwKfS5cksK5lEKR/gM8DwvaYQZBCwAWCu3xq4
	 xvNLS3+/1ErMJUxXyQsA93ls=
Date: Wed, 14 Jan 2026 11:40:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
Content-Language: en-GB
To: Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 fengnanchang@gmail.com
Cc: linux-block <linux-block@vger.kernel.org>, Ming Lei
 <ming.lei@redhat.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
From: Alexander Atanasov <alex@zazolabs.com>
Reply-To: alex+zkern@zazolabs.com
In-Reply-To: <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Yi,

On 14.01.26 7:58, Yi Zhang wrote:
> On Thu, Jan 8, 2026 at 2:39 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>>
>> On Thu, Jan 8, 2026 at 12:48 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 1/7/26 9:39 AM, Yi Zhang wrote:
>>>> Hi
>>>> The following issue[2] was triggered by blktests nvme/059 and it's
>>>
>>> nvme/049 presumably?
>>>
>> Yes.
>>
>>>> 100% reproduced with commit[1]. Please help check it and let me know
>>>> if you need any info/test for it.
>>>> Seems it's one regression, I will try to test with the latest
>>>> linux-block/for-next and also bisect it tomorrow.
>>>
>>> Doesn't reproduce for me on the current tree, but nothing since:
>>>
>>>> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
>>>> Merge: 29cefd61e0c6 fcf463b92a08
>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>> Date:   Tue Jan 6 05:48:07 2026 -0700
>>>>
>>>>      Merge branch 'for-7.0/blk-pvec' into for-next
>>>
>>> should have impacted that. So please do bisect.
>>
>> Hi Jens
>> The issue seems was introduced from below commit.
>> and the issue cannot be reproduced after reverting this commit.
> 
> The issue still can be reproduced on the latest linux-block/for-next
> 
>>
>> 3c7d76d6128a io_uring: IOPOLL polling improvements


Double linked lists require init, single lists do not (including 
io_wq_work_list). iopoll_node is never list_init-ed. So init before adding.

Can you check if this fixes it for you? If yes, i will submit it as a 
proper patch - no way to test it at the moment.

-- 
have fun,
alex

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index cac292d103f1..fba0ae0cbf7b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1679,6 +1679,7 @@ static void io_iopoll_req_issued(struct io_kiocb 
*req, unsigned int issue_flags)
                         ctx->poll_multi_queue = true;
         }

+       list_init(&&req->iopoll_node);
         list_add_tail(&req->iopoll_node, &ctx->iopoll_list);

         if (unlikely(needs_lock)) {


