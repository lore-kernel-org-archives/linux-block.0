Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926CD3C8C65
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073733; cv=none; b=caxezdASrbieBiQCgVjI0pH6HRuZP9cuOpA/B2Ev3kN47BRR5b+oDx8TBJvoUOA8WtUk7sZ2wuhzUAu28zJdg49n8R+rveD8uCTPWtLeD7t6kYrU1gJC0GmW016Z1DdKCQ7PkbLMQuecvJGmKIqj21In0P6Vt/VDcCZ5BYSmqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073733; c=relaxed/simple;
	bh=+IQPGIwLYqvXsJqCN6VhyEqpKbVenm0hH3MftI0zwx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dwBp6GHOAaK5ojncVolsq1PoO+xUOB2lBWXSdQrN4moQ++AptVHeXKAq0/8vdTKdtvBxcaHaQWkwCu2m3MXaejkYfTtwDDmh4nmtQL2a1NDzZYM4lm2qgMg11d2CQJnA2HlttaWTGSQdGJYEiaVHJLGtEZ4ARBkxqdTvJ1bALsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=KKx5LDh0; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="KKx5LDh0"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7fccd4c3f36so178830a34.3
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073728; x=1789678528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24PnjIv2e3Qe4pGninNHOu7n10wogA5QDlxPKFi6KAk=;
        b=KKx5LDh0Wp0y3GKzvb6UjlJZPu5UXan0W0wcy4xCGFoLXxMpoSWdrDOS/8o7LV/trF
         6Vd/2ML/2UKomnS3uBrgmzRAYs8V1G8EI3yItjn9Lkxpm6Shf0qRvaX1EqMMQHqcckvi
         7eaFCHXiTdc6TXw5nSyExXLZq5XqRoommPALLxn4F7v9wFNDuURffjw1CEClNtydM+B6
         1aJ7Z7ICMJNhFpLn0UlNli+6EVp/kL3WHQ8RY0Eg9NfDX4hXGuh/TgcLk66+6uHrcmGv
         9fT0w9NaKtYhNwVDdRn1MBBmcX8CvYnyekEcy/gtFykCJGyeZq8FIUFsgmdl1la+SU6y
         p0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073728; x=1789678528;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24PnjIv2e3Qe4pGninNHOu7n10wogA5QDlxPKFi6KAk=;
        b=OA/ysQGQWzGTz+4gNs31+G8coPCYGolvudY3GWlP02Lg5Kz4fLrgHxOXlo1RpLhxq8
         46ghDpQzXM0B6WSJUELLDWncZ2PsvxlA61LngZmX5gWUfdtshb0vJ/YnawMeN9kZLWrY
         zeteDlQHGbVMsAANPFX3HfBJS710ewIlzXYAfEaV5euWfs6b4y4bkKf1xLMc/C4gVRkq
         UPtlBr+v4LG61KWG3jtIkkJiZJIYnCqVw72kNQo/aIpaWfMuVDRwAcewhvUVGo7uMao0
         W1+VLzg8MEtITpngcmZ8ZeDD7BHseTtTUJw1qwCNkbwzcRKas9tsVGwUzRnWuBDbf1zS
         34Wg==
X-Forwarded-Encrypted: i=1; AKwUvBwPOtGr22YJjLLwEWBzqXRPz1MD1DEBxKM4iwnWkaVFzOfGTi7lfQp/3XgFWhWfc7XivsPXI9a7OCXuSg==@vger.kernel.org
X-Gm-Message-State: AFuF++mtrPuHHakIYi4TaVxrHTORR1G2Wo4jfHu9akKU5n0KZ85IXolL
	lXVxXzqg7Gm8jWEOYzqQRu5/0zCS/mtYy1kSeuHDG3+Z0lLa7iTwmSGd3Bw+75lieSA=
X-Gm-Gg: AYBFou19o1qPQOulQIHSMZDQWV2E90SAb2vA58HAckUA9TuB3t00fwN8scK91X1Q/ZU
	hlE7hZ536mYtAZBaDDWpX87lC7DKRFa4aSQS8Gi0hIv0arUTOvBRNG87NNdptVnJuSDgINtsb5n
	K0lw6fognKMw9cFv/MauP9hz9+tvYdu+Fmww+jYtnysYFPrm/wrQvgRpAUIOpYvoEjx1JZfteCs
	BnkNB8/9u3FiwgyUzhWaLk2s9vAhpLMhDlP4qX3OTWL7Vq2QDhkr8jq/tXiIqfTs62p6RNxpHZ/
	lXfVUkmY0emFKBNcgbXSyGBS883+ByjRfjnIDxTBu/7+VgxyYySoNqvmEFHlTMNmAglfwk1Fn5O
	iaWZhuzPVVCEmtpZPVtlbbjv8mf0nNuC+rrFcm+TnXI39OdBGODbvth1pY7nBBWEg+OuyqupeBZ
	1nZjaEunGu+TAsVCV9w9+RWrgdV9uJSiLBje8gvaF91Ju/D548OhHqx5eoS04BiG3PmLPG/jGos
	sklzxUf8+m0JdKvvvgBwKGr/OQaZXvr4Ea6yy7sz+J18qtGO8RCvZ38ZUKM9Q==
X-Received: by 2002:a05:6830:920:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-803fa7dc0eemr999678a34.0.1789073728657;
        Thu, 10 Sep 2026 13:55:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <1667275.1788941191@warthog.procyon.org.uk>
References: <1667275.1788941191@warthog.procyon.org.uk>
Subject: Re: [PATCH v4] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-Id: <178907372695.484803.16149783487967985464.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 09 Sep 2026 09:06:31 +0100, David Howells wrote:
> Commit 14b007e17881 added an address check using iter_iov_addr() and a
> length check using iter_iov_len() to iov_iter_extract_bvecs(), but these
> cannot be used so and are unsafe in this circumstance as the functions have
> hardwired assumptions about the iterator type.  They should only be used
> with ITER_UBUF or ITER_IOVEC-type iterators; they shouldn't be used with
> ITER_BVEC, ITER_KVEC, ITER_FOLIOQ, ITER_XARRAY or ITER_DISCARD iterators.
> 
> [...]

Applied, thanks!

[1/1] block: Fix start and length check added to iov_iter_extract_bvecs()
      commit: b0d8d56b7c93ed767eb4f2be9988e7b9dc023566

Best regards,
-- 
Jens Axboe



