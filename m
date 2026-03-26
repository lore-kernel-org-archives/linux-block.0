Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E162BDC27
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562718; cv=none; b=LsfSeoYLONT/+vv8wYrdB47nlRZQSgeyQsctJ2RtLDvdRX6r3z4HAdmiKOufzTXfBMdiZ6xqLWr2NX5zSS9nGPhFyu7THuTcOwDpnotCjEqKmQyj2ek5vb1rPPvHks9dHaI5GlrG9ajlN+egq0w9n9N8d9H8QKzI+nXG5f3+tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562718; c=relaxed/simple;
	bh=pw4oIpJsw/eNjWtpWsvNA6eZYUwnDB/qbEt9Xw+fE30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bsfF2Cl+1i0x7r7vG4d/ewZlAyy3K3q/snZ3CgEpL13cutFJhvNd9PXzeo4RLfffVzKOIyFVj9PZCoSZ0ywC8hyU0I8ICJK3RhtCvw5oDDGooBE7dKjULyMO0MpS0/X+fAQ+wjOWJjbTb2k/gGtOjcDAumf8Sa1qthZoHXXeJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x4M1j4W+; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x4M1j4W+"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so914639fac.0
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774562714; x=1775167514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfghWZookPC3u1x/npY6NFL9na2jkGZMpNCSPrR61Ls=;
        b=x4M1j4W+plH4XRzsZRrUhBgkO1skw394ytTW4Gglz9JgtFhxTQpWZOZcW89/h7NTWV
         4zDq67vpzCIbX2TAjGkl54gonkCh6jl0N8bFW63ZOqi4iTXtTA5fAbbavCwgClx7Vo9Q
         49/RQmK9KOAI6vE6ijzdmlXs4R68+6VQ8M8wmoQLmBEXSlINiOztsU8n8pcqXFoAJb1l
         BIgkNXFqsk7wRkllFOq4g354fgAqp7DKdepXucW04YWXzEwob+l+uviU86CeKAMVsWeg
         hmKgpy6b22bjNkTeJCrHDd2qyCVCl2UDOSB3Yd0sVMyUhGwnNCYuiwKh343DuGALCGFn
         qUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562714; x=1775167514;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfghWZookPC3u1x/npY6NFL9na2jkGZMpNCSPrR61Ls=;
        b=CsrVJsvdV1hY5rgOw9D/d5wNBYVv32eLN+9qb7ZRMNZ98MG0yYDGdIcZ5JgwR4/H9R
         ALJ5MVThWmnSv4iyE9i++Rh0MRV50k512B13Ez6plgQEndD3o9mTjqahXmKQEElrEa8r
         evBt254Emotfa1GN1ODg8HVwRPXzZtFhYOhS/D5y72aOAUstdrclrznZViG5DNnVoLpf
         gsO5LkhZLBPXxSFm0pIM/tVKsFfWMIOKzhbIcjnjmmlD+HGSiwkJ2e7/s1DqN3q/C7jx
         X1gJ28pXawPYKdUJpErUXAa/FliNiSHS9qiZgEdCKGiw1vsvL+EhhzAKXpwPFTGyGhIU
         1A6w==
X-Gm-Message-State: AOJu0YzAy9q862apxYEqCqb/h3WizKURw0sCXDZQcFV88MjxSl9v+9yR
	nb2lspzDDtwqmfOSyGDV87t+FMK2T6WZMbSGDdzjjjhhH4wYENf0oeHEYKHt52lbOfAtPNylvZi
	H5YGX
X-Gm-Gg: ATEYQzydi6VL8GxbfW7FfPCI74Vch2Q/WHO6rYdOhRMtS9Vt9CbR8JOsxuZfWKzOcM9
	i96s9rJfsnDRjd3OScmhNOVpkMy7hSINsNiY/nX6IjjcocHvFmmYxewP5oGIUOjFwLOs4JJkVyJ
	fWrdYxZlFXDhZMRO0DRGSKS8BA9fap6Fyd0TtxH2J65KjwjFi8b7z/USYtvuQ71RwgPw2hgKtp5
	1mUjXJxT4ds77Vti9UMbABxl5MQcez7m4nUfCeGAxu1TlugVg2e4gFFtIzPU4upvOq05nssP5pT
	vXGPYn4Din0ZbNZAknWAc9tMFuJ7QKPH+Jz1YzSJewRmNn02RZ12axOSnnL59sDIr9rLHPy9JaK
	PZMYX8H1irliKOGTIGZcJqZWyYSJrMCRFjA6g4YuYGC63eONwsL5twQg7+RfPeQkoOMzuOEHTnK
	rBkLeDk5692ySyd+7DiK7+4t36PB5597f3HCbDZIxRzguDCSDRrBUCaXTJ23LJ3XC5ZxvmTYAa0
	Mll
X-Received: by 2002:a05:6870:ff83:b0:417:1347:8ec4 with SMTP id 586e51a60fabf-41cec452027mr7013fac.44.1774562714148;
        Thu, 26 Mar 2026 15:05:14 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc7b3e55fsm3519936fac.14.2026.03.26.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:05:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20260326214054.284593-1-bvanassche@acm.org>
References: <20260326214054.284593-1-bvanassche@acm.org>
Subject: Re: [PATCH] drbd: Balance RCU calls in drbd_adm_dump_devices()
Message-Id: <177456271312.177084.14797760001381378963.b4-ty@b4>
Date: Thu, 26 Mar 2026 16:05:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Thu, 26 Mar 2026 14:40:54 -0700, Bart Van Assche wrote:
> Make drbd_adm_dump_devices() call rcu_read_lock() before
> rcu_read_unlock() is called. This has been detected by the Clang
> thread-safety analyzer.

Applied, thanks!

[1/1] drbd: Balance RCU calls in drbd_adm_dump_devices()
      commit: 2b31e86387e60b3689339f0f0fbb4d3623d9d494

Best regards,
-- 
Jens Axboe



