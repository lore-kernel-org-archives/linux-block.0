Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5F1F09A5
	for <linux-block@vger.kernel.org>; Sat,  8 Aug 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786174985; cv=none; b=oDnK9zw0wiUTrwtDMcBt7XJIeZbIuYVDSY47hd40MB44w1kBqjMCw3e3mbNoyb5amXa8CqvIxLsbzth2I0GtJDjzTPNnlNo1NAgFLkxN/YiBDetwm1YTWImmZLR8SEh1SRZqnaA7NUmGVSny1d6Xie5FeyypeafFWOyzMdsrza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786174985; c=relaxed/simple;
	bh=MfmnU8YNJLwpfs49CXSqe/TGoI8poFdoJ4O3as++6bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrynhtNIvrMqGGfKa7+PgjrJZYVQOaRqV98yOUF5tnRZkCEGfnuewGDXtJRBtqW0sNRL51R26mVtPaXWrjWk4/JnS2HDx0/+CwH01Nn6YN322yk6pG4HD5nbPqjAfqRlW7mt2d/sx6BZgyyh8CYtGk3gFW3eiSUpFqumFR8YKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=K+cTBR4P; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="K+cTBR4P"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so282255a91.3
        for <linux-block@vger.kernel.org>; Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1786174983; x=1786779783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
        b=K+cTBR4PSttFVR7cXfwdM7Wcxf96D26huTsvWdscq3LUH8CqSXMsQ4zHA39r+uKFCy
         cOfUAJsoD8ByLh8RAzhBLMFgGVd3d/aCpALF65KxJuj8K07w/fyqhhGUc9iegk1sgxew
         AMJ5nQbgQugiuw9/SzL5BwjWdFnqHA+HvAuyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786174983; x=1786779783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TtyMmNLD5kYHkR25F4J0okBlAhxZuviH4rvHbsosVac=;
        b=Bp8Zjt06hohaZRKNCIrd62rupuiDhtIA3zaO2dmY9Ak4GoF2teqXWSffJ7p6DKG4Ke
         xfWNUhOscXUz0xvXdai6lE2b0K7Ze4SoqDNw9Swpl8u3dWgWiC4juU72nSCUO/sQYYBV
         NSwblD43ewgRBSH8sKVgf1fGBXi9AYNGp+UnEt5THE8rgjRXnxgtyD/4fJwk4yQnW4qw
         t9W7WyN/2TmX+oONTI3OJU9RO5nhNJhiKbRYLkSUkCHzf06LfweTaFODUPDWVW657IyM
         JZcdxvKokSXvDP4CXX7wq59RmmliqlmrkMLiyzGJecAr4TpByOjId31R/k7fmQv3HD0n
         ywXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoknQV8m1mEbHuuVSCny6NYI18ReNgsg62tYn3f/QDThORuqFAOar3Bi02zU5QJUwSUvmjcqu1LDn5hlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbdK561E3aL1LkTpaqFNxFCeGfdJeNNpd23TwY/hLqKTlQ4V7
	Pd5qKnX10SRA4oM6WqoO7VM3oVz3hn26ZVzg8wb7YUnm8m0DHG6d4jnYC8RX8uZn+Ow=
X-Gm-Gg: AR+sD11Ee1mAwDlPuEqw6gRra5JH5/HNeIY/eF4ydVGafoHCQi1Uf5f6ZA72ydyHJQs
	m3RpdvhucyJaugnri9rMdvPJSf8X5O0VSSSJ6dgsEd0ZPjxLTEASUcnxLWml0TULadxaRXvyS2P
	tbSFPQbNyli01Ady3v5M2tkc3Cpdz9aqQPfPi6WFdZSyEsObE6olBec4F247PIEY6h0JQvjUKVM
	4eL7lFkqglC61pl8stEctJK0lZmCw0FWCqRSfSTDfzGSWuzD2lg8kIM6O1KN8f6qZjZwRBn9P+l
	dil8OduLGbyrqnc2v47uNpelqia+blQYIM0153iSqTpmOCVekgcm67zDGoxM9rUQO2FYihSI3h+
	Mn/v7adLYINfwHbbkK/8xN8iD8tP4UORw6EgNoNDKrD9CIHM3ytCUUTbrNXWvt9gx7cuqOeGyYz
	6qn2PuE5F36a0AMwPhqB6+rVJKszTZ5xwUVMT2n5s+4z22ssuQ1QWAKkFGZh9P6J3p6FfHQzEjc
	A9Feahl081WSpdObUY=
X-Received: by 2002:a17:90b:4f4c:b0:380:540:d499 with SMTP id 98e67ed59e1d1-3903c5381e3mr26493795a91.6.1786174983338;
        Sat, 08 Aug 2026 00:43:03 -0700 (PDT)
Received: from localhost.localdomain ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39086164982sm7523449a91.16.2026.08.08.00.42.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 00:43:02 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	nj.shetty@samsung.com,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	tushar.gohad@intel.com,
	william.power@intel.com,
	phil.cayton@intel.com,
	jgg@nvidia.com
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O infrastructure
Date: Sat,  8 Aug 2026 16:42:27 +0900
Message-ID: <20260808074245.85757-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com> <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/1/26 16:46, Pavel Begunkov wrote:
> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				  true, 0) < 0) {
> +		dma_resv_unlock(dmabuf->resv);
> +		goto retry;
> +	}

Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
returns 0 for a still pending fence; only -ERESTARTSYS is negative.

Thanks,
Sidong
