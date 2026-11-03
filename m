Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716289;
	b=F1XXbS0t+cCej2qhXuSwQxBMiK+Ox3iFXN2XumJZjhwCrf9r3xnCp6rk+xmvN1TVSH9u
	 k5+9FDeB1E8cE1NvlhNfq5V0eJMm5Nop+lArhQLB7rnyWo8wR3madrXhhTpG/DrHz+s0g
	 QK5gJK9cwc8ehY06ufbpmAYjuUIYE5ShgZu9WxUpsKf5FoI4py9NAkZSkpTkJKP3t1y4P
	 h8Y5maMlB6YVq+NrUAOmOAllgqLR51ANT8vfwOXjzQ4Ya9QAEbI4r1BImfqLqvfxkCMt4
	 3VSeDWxxdXc4b8PmaMDu4rwPnHgo4Vm7+glNFY3IiAjnaUryMvvSN5oKXxeISoBcrYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=wk9IlcGYhsSNWUuj3B81ByEUkAlft9P2T8KxXmSzXGY=;
	b=OwmAEaUEzsk09twNRJ9TOk82WAfkjwbcMFA5V2a6Ka8fE9lg9oGtZIc6IQ4EDen8U78h
	 KB3A7RC25WDXaWe/dBXb8G9DIwbc7Q4ddiVRcAmkYQLaBadN4rdQTI7Pb8r6MwVNQNx0P
	 SIPn8yNBku+HJNCjjvuDFuJoqyL78kZSFZkuqFXgfPyjHeNetvrhUdJSr90ZoFzOYMpgL
	 PhySzchjqf1FsKBX2WKxj0bHaE1+vGLQ7FobGaNW1F0gkc9536AOk0CcwYwguNULz4JjZ
	 6wtML98e9WPFPQiMPwafoD+Ql9rvt/a0T/jry9oLjIMj7i29CJ0mGkS49IT8uUIV4Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hIUixbZZ;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE5608362C
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFE5608362C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hIUixbZZ
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2761c69fbso7218784c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716288; x=1794321088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wk9IlcGYhsSNWUuj3B81ByEUkAlft9P2T8KxXmSzXGY=;
        b=hIUixbZZe0qdnf8pPESb/h9zqO50ERtOAYOuuUckq0Fj+Sn4+GYvDGk02FSgIp6RB+
         5QlfWVSXg8mZx3FMt9qctveJsziRYuGcSZje39lQkrMYegEEmYemAg41kUAWexfbf0l9
         Cw9IuPCjrP5hkr4da4o7C2ucLV5C3Qn6Y92HHn11jC8i38k8h06zIVuOcO165DcoWUdf
         RKeyJNApxTmS3ZY/bxIDZf3nRZNPw0aTKqtoFJCa5GmMr86/fW2CKmPe1HuEKmN30svt
         qCfusX+8hAGEnufNp5z+V5P+ogYldZshqvaQ1wAZF92F2p3+Tmr+aKoJo5m3lek32AOc
         C+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716288; x=1794321088;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wk9IlcGYhsSNWUuj3B81ByEUkAlft9P2T8KxXmSzXGY=;
        b=F0sJjSMAe44vaUsJBwfPCMaaakueagZtf4NRBpczBWOMzTsBwjVBkRDVPWpfdP4XnJ
         9BCsm61AiRneMysp+Yr3O4caRXvm2N0Zwx0/vmBFq/xABm3iFdh+E/ZzCeTUOguhE/gF
         YWyCCFualKED9RcjKWoRjnmc7KCsKECIIcJ8QHPM6s7zkav5kr20n7rA/4Gdnd1CpAFQ
         umbtwr/vuWx+ZQAGH7nGi2OkQsokVxeiKL4rbeaXs9UmCMVsd7yv+BHXwUO5nyg8mbY9
         CEXafevHqwnmc4cYTA9Be9g0jEp7zwnIb+6kWtLuO/VV/wgUwUk2RO+92o+bW1vvIowx
         ydcA==
X-Forwarded-Encrypted: i=1; AKwUvByuZDd8zTuXQElnzWSQ2tk/CZQ6Z9BMhlYeQE9nrzfrxS0zPX7aOXsrTGXhRtmYCNVUWV4pushgzBxx1Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+tovvwVKmRBrLKt8TtRHN6iR34Rzy8AeoPJR/aPZuCUMRjmQNU
	wrr5ileCP4zp6vPqvcacprqzghJrozDJi6DXd/mn/2NnTK8sYtwChU5tRPd4Pj6EGhc=
X-Gm-Gg: AYBFou1FECNFvZDdYeBnAzQ71SxJVBJeiLNvEFGLQ9rwwa22Go4hO3gPKBmC8lym9Ku
	GXMkSpGZM5xAthvaGGWj85CmZ2kXXiYptDXJbsaRoNerZUzxx5X7ydsWTOhYjYwiBI013VW3qyo
	DrxQQTEJb5yk+1yXQkqpEuRTF/cGCFkDYH/+Kl7dakUsU2e/HYE6E1IsnpC9Xj+RHSM07c8d3UN
	Mr7tFcpf4A9VoIFkP6eZD3OwTbr43mTatJFSb1IL+GF5e0fxXD6ztG18Aw6v2ZbMCjj/2Y8oz0n
	c+fR/DbPqnyDVDGGTctOpq0gNqQa/8P7aU/AZhXRVQQPuBU1PwxxxHWcqOpTp/Lh8hOcvxDuFVR
	zS6QKsxueQBFlftRgp+skCODQS2f8NOM+tChzsX1Gfdwc8UAxFca3LAMlmsr5lmDv9LtjlJaNIS
	r9CXCHo23x+h90OzRpCXpI2FF2Ljk0KfWHobplyMNymYORZ+/w0KorUX5RpwWsEvdrhXppP1XiB
	BVcZJjOTDCsqnyaLQBJAX/g2T3eWpLNPjC30/gqEqCv6Scfzh3oNKyGnlffwk3qIzLBGucISRtb
	wo7esOIm6ToSwpJmjlJVRC5GJ3be6M7QZcpMYVZeyBwxtV3bk+ez341an81M/a3E/AaWIE/h9VU
	SQSzN0fNbYs+3
X-Received: by 2002:a05:7022:f517:b0:193:9aa3:4758 with SMTP id a92af1059eb24-1ac55968b07mr19882618c88.4.1793716288267;
        Tue, 03 Nov 2026 06:31:28 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Yunye Zhao <yunye.zhao@linux.alibaba.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
 virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Ferry Meng <mengferry@linux.alibaba.com>
In-Reply-To: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
References: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
Subject: Re: [PATCH] virtio_blk: freeze the virtqueue layout at probe time
Message-Id: <179371628704.3691261.225757712594968612.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:27 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 02 Nov 2026 21:37:40 +0800, Yunye Zhao wrote:
> init_vq() reads the writable num_request_queues and poll_queues module
> parameters both at probe and when recreating virtqueues after suspend
> or reset. However, virtio-blk does not update the blk-mq hardware queue
> count or queue maps on restore.
> 
> Increasing poll_queues can therefore remove the completion callback
> from a virtqueue still used for interrupt-driven I/O, leaving requests
> uncompleted. Reducing the effective request queue count through
> num_request_queues can instead leave existing hardware contexts
> indexing beyond the reallocated vblk->vqs array.
> 
> [...]

Applied, thanks!

[1/1] virtio_blk: freeze the virtqueue layout at probe time
      commit: d53c1a12ff1cfdb12770ddcfdf5603915d0ba0d8

Best regards,
-- 
Jens Axboe



