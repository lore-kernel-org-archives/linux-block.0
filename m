Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8871CD2E
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417170; cv=none; b=SNRgLKqkNggORxp0qe9UWvIUqq2nc8Rprbj0ZMhLA1u2fDXN8NNBPK40yQiZZ1dcNQ3qG1C3BOF5lq8cNv1pG4LYAKX13xHkuEmOijlQLeFa0i/LqgNq5Zl/raUYqWW9o5oIUGWnoGq5A0dT78ZM7QB4HR9rLRYIWCeELO0/Vuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417170; c=relaxed/simple;
	bh=wHrLFJRfnNXUeGVogN8+9OPpwE8Sci1mCOxtvg4QYxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tWDUYl+m56OgOvETNgW93SzGR0L53ydb7Ho9P+lhP0D0ixsyz6iK4WPVt4Q7QKFpxBSmYZbPpBgho31Svp80whNeiB+XH/lmt4xukEQBJzejZKxbyeFTS0SvUU48xW4va0++V1EXFFut7mTQ5GOCggQrwdgUEnp0ljnnO4PPtcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HdjSLlSo; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HdjSLlSo"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7c3e06c8608so581539f.1
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707417168; x=1708021968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOhSHI8k2xKwemaGiMogUyPw3fznz8Z4LeXfby4qFPk=;
        b=HdjSLlSowB6EaPGTBSkJxvmtcH53csRnXfB3MTItR/HL0drWyrhznWOkzGRovoZ+Sw
         PTdh73RmckYlm8bjG3nQD5Aw07+mMyVmnlA++4N1Pr/Q6Kb+VGRZxTRMQCw+Cu16ZWUd
         056x3ilF2gA/BlSTYWiombr5Zy0qZAkpfREZglO6yEnSMgdzE2MMjV1Bk3DG7fdaSNCp
         Cr+tSloTqUyerCV0LIE+sUJC0pK02Uaqo5Po22ZLWa8yaQaoH+zR0JC1KGS2YrgcqJF+
         AUM5tmCjd8ZyNsuSeq0h7EeInGNSV63m0WY9uQADLBCsNxqo/DY9K6Md5onzbFcQ50wX
         IHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707417168; x=1708021968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOhSHI8k2xKwemaGiMogUyPw3fznz8Z4LeXfby4qFPk=;
        b=f23EF1EgfKz+AwmFaqtYMGeU7z5PSo4M6H4BycFKqCbT7Y9dH+VHpOJiseVB6/9AFt
         XT36RTCaRgcnH2es+xqPRZv6UydNrUgFKWNANxY6mExTIfJgj6NMuEmYHA/+f/FpxhOr
         a3G2dDZbKEqbF01Q27qGFLTVVkasPjoBtmPbJKX8rQbYVh3yqqqe1BZ5pADSDCSOICAw
         2gKxdztcelEjBPp86GQGxjdns1L+IlDgZA8HsZPiMt3mgKOjhP73nlaGdWYDkTqlbzJB
         /7Yy2nhMMNgZ7pRg9Z+cOtcxGwWF6GO+p8HiaVUNqcAOSK7z1BVuskwQlRdoQ96eKzFK
         +rXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhJEOD4x0cARBK0qjCUsq0xjYm477AFGnS5NztGaIiGwZu9WvKjqjEhljNhDElg8KcVThUy6cvqbBDG0ud6aNEWDCGXzT+zY7tykg=
X-Gm-Message-State: AOJu0YzKteu+wqyAy4ALbvSJKx3Pus0C8i4umUDor+DrJzQ/6gS0GPr5
	s4BQt9kSdwWO2JdVYyc9CzkQEmN9P3hlmVETGLf6aqrGoDMuB9DsclnTvg63JYYl52OHwCoeDpM
	effM=
X-Google-Smtp-Source: AGHT+IFUz3Bw6ISDd3GciQ1PkFFh8jMes3QifdbnhSrBnemaIeE1jkbp9UgMWYTHjwPHgVAExcNiZg==
X-Received: by 2002:a5e:c00f:0:b0:7c3:f2c1:e8aa with SMTP id u15-20020a5ec00f000000b007c3f2c1e8aamr525375iol.0.1707417167749;
        Thu, 08 Feb 2024 10:32:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFN35oyK3P1Kl19g4DVSeOHdJqd7hNO/fEF+Zn4banyLzmAsUB9dGTmHJlmPGk8rbasaMLmyBct6zafrB+IPmSrFNfMSJmIjvgqC6BIW/sXung/TkbPIraqxtSnUKoxgCzcR1eTIU2rXeLNPkRpe+cBazdeEfW3xUzPh50tskx/g83+xSWNhgagQt8yuHn0rXntnK3Hom2LBu+VnXBS1N6c9T8kjDFqLuqg0OPZQtOqUj4jiLTWT2sLAdc7ngzJBCXRJoTClL/ugYT05us0HGmMECzo0pJ6mIeZnRw6bKwhdGg7yG7Qu64tHQhCjlYr8CdWDwNWF5cl8j0vwggM4B50jjH0wskBEp31CDh/xkNOz6MhRJ0GX6rk+Dv+jWMWPU=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a6bdb0d000000b007c3fbe781f2sm50823ioc.5.2024.02.08.10.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 10:32:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
 Yi Sun <yi.sun@unisoc.com>
Cc: sunyibuaa@gmail.com, hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com, 
 xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, 
 virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240129085250.1550594-1-yi.sun@unisoc.com>
References: <20240129085250.1550594-1-yi.sun@unisoc.com>
Subject: Re: [PATCH V2] virtio-blk: Ensure no requests in virtqueues before
 deleting vqs.
Message-Id: <170741716688.1391883.2946265788968193577.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 11:32:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Mon, 29 Jan 2024 16:52:50 +0800, Yi Sun wrote:
> Ensure no remaining requests in virtqueues before resetting vdev and
> deleting virtqueues. Otherwise these requests will never be completed.
> It may cause the system to become unresponsive.
> 
> Function blk_mq_quiesce_queue() can ensure that requests have become
> in_flight status, but it cannot guarantee that requests have been
> processed by the device. Virtqueues should never be deleted before
> all requests become complete status.
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
      (no commit info)

Best regards,
-- 
Jens Axboe



