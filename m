Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16974415B96;
	Wed, 19 Aug 2026 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166842; cv=none; b=RLDB9IhTo6g0bVcdolaQHAz5IhblpLqgJpyGaxkTt/Y6WHL2pl0jKYmMqrhwpXPYRd4VSNlAbEXaghuXq3LXgJJHhdbTu5fREaaSWXsSrXh9mP3HSxAw741Glz9uGcmVk+tdq3+m9j/1OD2NuEbxNDujGdK7dbu28RfHIjrWMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166842; c=relaxed/simple;
	bh=S7yb51zhItrMKUucHbqqPPPNOptoo/Mc3djq27EeI28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aOOjxwl/UcQEkayjklMLputhB5rzEnxp04Sngu7UMtu4QY038FJXV3EoE4xqFHKTQw3BsZsZFFaHI0CZr80Lv2Af1hn5yH9x8VfznWvbLfPdK42EVgu6Vq1hyLRm/0Y1DxjfqxA7IYopGdGM+rGEvNNLlLTxDn9Qq2KG1pe6QuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oi5rBexQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oi5rBexQ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC6CF408C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1787166837; bh=famj7FLnkubFO0AFCJCjqD5kiwyTkL+nNMiRzcA9+j8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oi5rBexQ4akANZcIp47ujezBJpEBD0i221V8c29s1y84QSLG9UgcrAfWCg5nHMngz
	 qeEYjsdELd0lKXtL5rkP1FC1MtiOK/pJ/468LXhTuJEz37/N+EDJGZTEE4D4qxVF5v
	 /Ffcp0zbkesxqRQeGLSI5ixw6Gb8nRQOj5367wLdrwvY5Hh0ZuV49CYeDZoHjXkTS3
	 zJJZ/4D+mfttmMbpsddUxZRTg0xB6ClYh3csUM5im6L4Bx/6A2IZacPm/7DWIbh0oB
	 QEc2eNyjdCFCkPS4ROZWXI3OUQeiMBvhOO6fqI6QBwJZW0Fy9sjWarZfqujMNkLKZm
	 yI1ryOoVhWdKQ==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EC6CF408C4;
	Wed, 19 Aug 2026 19:13:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jenson Johnathon Reggentin <mail@jregg.de>, Randy Dunlap
 <rdunlap@infradead.org>, Haris Iqbal <haris.iqbal@linux.dev>
Cc: axboe@kernel.dk, linux-doc@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] docs: block: fix dead http link in blk-mq.rst
In-Reply-To: <7a09f4f8-bf07-4117-b8b6-0ba683d60e86@jregg.de>
References: <20260819174635.37505-1-mail@jregg.de>
 <b49648fd-33a2-4469-95aa-1946ed8a4bb4@infradead.org>
 <24515711-f64f-4335-b17e-70f844c85b7d@linux.dev>
 <08c89377-a6b8-4f9d-9f47-7c6faf99d535@infradead.org>
 <7a09f4f8-bf07-4117-b8b6-0ba683d60e86@jregg.de>
Date: Wed, 19 Aug 2026 13:13:56 -0600
Message-ID: <87cxvd7wjv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jenson Johnathon Reggentin <mail@jregg.de> writes:

>> Yes, adding "www." works for me. Thanks.
> For me too. Should I send in a correction as Patch v2?

Yes, please send a version that actually works.  There is no hurry; the
merge window is open, so action on it is going to be slow regardless.

Thanks,

jon
