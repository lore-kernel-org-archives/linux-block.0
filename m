Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610143;
	b=P85+tilgu9AzlM/mjSJ0xqwedjNV/cVXleJr1vpThZ6Y8PEJ6bDhKwOsXUW5TUVpVYcs
	 qhlmjFUf5HyjXVa+YWlsHDdf/xpzFGyezk/RDRMMFZXPfQrshTK2jCRFnkIyYB0HJNMPn
	 QszEC9jkX8FCREh+1F4h+DOrifgfp7SN3AEoF7ioihnNDilxtYtrUnB7S1MFxu58apr7F
	 GsSZtUWj0y7ROzh/hVkr3jk+1BJP14nss3PAXZ41yjHQ5tF+Ph4knXRlx1PxTPmLSVahf
	 d11Xn9olKov/M7JxntDprwSp+CnkHiUr3/nvvCWHHwbl3BnJq7BfrbzgQ2idBBVjdig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yJCWLcVlTtiQVfwuNd4Ug+QWJeJEHbdAzaMQBdZ49Qc=;
	b=JhH3z1B69L9KIUvme8ceNe/XJ/DsSqUmdTj8EnnDXRfCr9p2De32bevJmjzaOtNPnayb
	 DqFc+eZ8k4OZdQ/VgNGwA3VoV/ANckepUKnCAHn0ga6pcYGiUpyZGymvawIKPT5h0RqgB
	 wLeMpcRYPcIUxOLL3q5kSrA2+DC4kXcseFqitR7WMFTsD9oJXQ5+gKVyrgQkJxUh4FnVy
	 3SEdTdJC/+fM2HuFWlEmnbWbqt/WByOUYZsR9rRqo4bGf03dpTSBXAHmO0DdiaD+nfeNU
	 N2KnrR6hEsCnI31cKPaMAGEMbJhdWc0sBx5MGbWfzECJ6ShZROFMiMRWC8bzZPX3AOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HKdXNGRd;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852E606A324
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 09:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D852E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HKdXNGRd
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e6d6e780fso1271882f8f.2
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 01:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793610141; x=1794214941; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJCWLcVlTtiQVfwuNd4Ug+QWJeJEHbdAzaMQBdZ49Qc=;
        b=HKdXNGRdXq7vMXqBG1gfBNIajHsmS++L02ycTN7DQLBoyMmSLPIda2fem0StuK97G6
         Ztw9wCzmv8IAn0bBvIKcutXR6Qgomor0OlkbooPphQlgheALka3rM3WWsG9slsNNVf8i
         RH2p76chU+R7fe2Tu396Q2ykpss24VunWqvtSke4b3YiXcqlAFio4f62IIjoUmcakC2w
         I6DQJ/zThJJeOk8dzIGaPHfUklnlk+qFyjx81g3mOzeb4lLXkqunNlOPkqw9pjiln7iL
         qw6SSydMRZ1w5E+kQkR8AFj9aW3Q7BXnjlOjc/h4dC/HVXQymS0hzZyi7Na6WgeQq8ul
         wufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610141; x=1794214941;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJCWLcVlTtiQVfwuNd4Ug+QWJeJEHbdAzaMQBdZ49Qc=;
        b=rQtgCt32cqTy87yLGtbJwL6s2M0/lkhSK2cSKBlk+Tm+t+zCIFb6BDKiC2MKvCp4MK
         13rx+fPddw+xIuZs/YgVEQHBrCfSV939GPnYPQxON3h3vbqO2/AqqjC7k3RkCxvUpsrX
         UfagisAq6l2qVwhvGzAgNpBfW0wyP2YlC/1Q6r22x4Wkbqx8fy69jI8fpcP3BST/hhOp
         xMqgTjlqUoNKVfxTcH5F3H+TWBFO+mZioZacI6fZnV7oQ4fbTtHNKV5F99H0uxtVeduq
         BbzlJ5p17pAwiw3XoHeYZtQYECspwi+0lMvBQNSKC4aQ9VES36dUHgK0i6Z74W0+cj7G
         zWjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVTdqsP2nYBZ7cyWoW11J6dH7bMRix9bgreeU8WWcN8HYDD/Z4Bg16+pB0/xvJOvMJbWhbU691qaigAQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z85c9yVZUjhQjdpT6u2pPwFySYzul7bW91ia3XvGLkHmoB19hS1
	joOCjTu6GoXqmrmqWR0u8mPTeoP4PYQA0FRP4zjLkoLhoS2akzZd0Fk91AbbSP3VRo5VJTtrxh/
	9qTfzaG/fEPCOflyG1wlRjL5t2p7HEbReAw==
X-Received: from wrox17.prod.google.com ([2002:adf:f0d1:0:b0:48d:f214:2440])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e001:0:10b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e6e30722amr15896125f8f.13.1793610140239;
 Mon, 02 Nov 2026 01:02:20 -0800 (PST)
Date: Mon,  2 Nov 2026 10:02:17 +0100
In-Reply-To: <20260918135120.1261150-1-sergiiushakov@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <20260918083557-mutt-send-email-mst@kernel.org> <20260918135120.1261150-1-sergiiushakov@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102090217.3324999-1-sergiiushakov@google.com>
Subject: Re: [PATCH v4] virtio-blk: clamp max_segments to virtqueue ring size
From: Sergii Ushakov <sergiiushakov@google.com>
To: mst@redhat.com, axboe@kernel.dk, stefanha@redhat.com, hch@lst.de
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pbonzini@redhat.com, sergiiushakov@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Michael, Jens,

Gentle ping on v4 of this patch:
https://lore.kernel.org/virtualization/20260918135120.1261150-1-sergiiushakov@google.com/

All review comments from v3 have been addressed. Please let me know if
anything else is needed.

Thanks,
Sergii
