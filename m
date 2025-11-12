Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D26192D8A;
	Wed, 12 Nov 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931774; cv=none; b=Dp+DxwRKcLI0vuwUNgkF29QQyRGM2axlJK2BJqZAeD2gfTVZpBOdZhkwPNqLLsjoDo3RlfFAYG9AGcTtrp8C1aJXSrrTNvXylKQZnWWOPFma55/7PsG9HWRhQ4l3fWhhvw/Uf/bmkt7bDejaqITYsNlr8Sf2fYr/ZWwPp3CK4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931774; c=relaxed/simple;
	bh=Xcv2+AJm4TH1a1rjdj3gcabqSWqME7NMMLUOioPIm0c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=guakrllMasXjKq3skS9Vl1xssWowsWU/6SEE1oVhQS6RpEi1B3gdaC+pTEtjpVpSqJXQXgFX5CvilA2mzTQgNj4VpS5AXFiUP+H2ep9iJznUiOvFoWL4mHrdBer41XJieP+chne6IPDJDkKqinO2ZL+0Vw9kXX5Tx7l4ZjuM/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qmwnyyFV; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qmwnyyFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1762931463;
	bh=aI1DtojJ3uIlfMHHyo3gbCN97mQw0Es8Q9FMf59dQ/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qmwnyyFVudo5FNg9tNff7bxheDeVYTJqfAdyFs6X9aYV4msYHJQb3eLVzlVLCluVz
	 HTDvR29e+jHVxoMXA3wAhyPIZLB9CIyfYCW1wcgBTPms2fQCh254YnOpkUiqMygpep
	 jfC6LdxDUAhQDqWxNnKUUi8DlqgHYvZbGeqoodoY=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id E6C29EB1; Wed, 12 Nov 2025 14:57:44 +0800
X-QQ-mid: xmsmtpt1762930664t3r16dqsu
Message-ID: <tencent_17B2F3A0BCCBAFD3AE942235EE98F1595707@qq.com>
X-QQ-XMAILINFO: N7qqMxIPUfzlejnxzQ6ythel/a3Tm6mb1P8jrwVKo9It+HgpxUwJ7p6FhD9GwW
	 6sBlZtFDtxdbIzunrvVRbintL1eAuUABZFf0n53X22tNuayQs9oQxTDv2W/AK/DqtfSHBbNrPo4Y
	 6iIhsknA5vUgM+gsCHBaIS/vhyfq7Pg5KVbi60NeM8hgYDrswKYGAb3G8G1DJcEEDn/RbACj/49h
	 ahWpe8BBeN5mxSXnNmOHInBw+1agxhJ9kxWyroctg9a7s4e1NG1Eba3fF3G2jg9c6J5ygMJxvc6L
	 CpxtoRng7XOMwMjELhQqWlntGmfGXsb6Qnxt8tyHvYuIPRA+z4/btPyyASqe009XJqCGXPUe1lhX
	 K4+hzj3JZqHdaD62ZSP2uUuP7jqksebAO2TdEm1ogqkUuKHNSBhIeTjpKleanyLp36y3nZMKWbbl
	 GCbE7GiGeZTtkNL8CFJD1B2ZZhtGSQWYIj/AaLnQnmu+v/lgjUTKBUGUwKfIRMt3ERFUpggU5wYq
	 HY765VN84IXnzkSpL9nrXooj4uc5Ii56oNPhQzmIX7jkajnI9BMpIfxRUixAGCY5bAXUbTFh2DPq
	 bXLjZeSDOYkUunhZz/191z2XPgIeGvyJcG/sGtdoPS1GlQvLz/8bjQV/MKTBS0+UPg1aOMudWthG
	 tiHPrq2dwEC3XbRMxLcj6sCMOLyU+aSKgTVOP/GQFaahImw768ahfc/tbTnUBFdgwOYJpLw+JcXe
	 yKEPn9og42iS5B4GXJylvMjvt1jBkW9tFPBZjCJBab9RH2Oyyy+69/sI1cJozfWaM77sh7GQ82Cr
	 htbvbHmUT26eD5W8HTVtSgE1xDZN1lL2qqmShYao3CRQnt+0id80CpFpR8b4FpwQ19tIa3GfFkNR
	 odsT3BvrYGN8uvaIFmBqExAR+FG4EEsQFUUMXYUSAY/Cyhwh0nFoBIk0ZK7SA2uCQLuhOYazcGc+
	 ZDNOa+ipxNAu1XEaXtGj1VwR1k3WsAa2t5FiEh2XHhwPzuXeKI5OQ1y0W1KC1fVZGqbr2sztBLLO
	 ggSopnFNvrKVCJj2/wcuhybO16fLU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liumartin@google.com,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Date: Wed, 12 Nov 2025 14:57:44 +0800
X-OQ-MSGID: <20251112065744.3293306-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <htycvrcqbnkk7ldhpaqxesy7uhz3lssymwqm7nzkhyhnid3krm@mfju626njxvb>
References: <htycvrcqbnkk7ldhpaqxesy7uhz3lssymwqm7nzkhyhnid3krm@mfju626njxvb>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Nov 2025 14:16:20 +0900, Sergey Senozhatsky wrote:
> The thing that I'm curious about is why does it help for flash storage?
> It's not a spinning disk, where seek times dominate the IO time.

1. For flash-based storage devices such as UFS and NVMe, the Command Queue
mechanism is implemented. Submitting multiple random write requests can
fully utilize the bandwidth of their buses.

2. When we submit consecutive pages separately instead of submitting them
continuously together, the write amplification problem is more likely to
occur. This is because there is an LBA (Logical Block Addressing) table in UFS.

3. Sequential writing has lower requirements for the bus bandwidth.

> My next question is: what problem do you solve with this?  I mean,
> do you use it production (somewhere).  If so, do you have a rough
> number of how many MiBs you writeback and how often, and what's the
> performance impact of this patch.  Again, if you use it in production.

We haven't deployed this commit in the product yet. We're now deploying
it on mobile phones running the Android system. Our ideas are as follows:

1. When an app switches to the background, use process_madvise to swap out
the app's anonymous pages to zram. When the system is idle, cache the app
to the external UFS through the writeback interface.

2. When the system memory is tight and the IO load is low, use the IO load to
improve the memory release speed.

On Wed, 12 Nov 2025 14:18:01 +0900, Sergey Senozhatsky wrote:
> Why do you do this do-while loop here?

When there are no free zram_wb_request structures in the req_pool,
zram_writeback_next_request will return NULL. In this case, you need
to retry once to obtain a zram_wb_request.

