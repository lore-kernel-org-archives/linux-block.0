Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4ADC125
	for <linux-block@vger.kernel.org>; Wed, 20 Nov 2024 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068448; cv=none; b=c2CTsED68gK4qwCvpt3lktikk7QAYNku/jZNI22t7AwiAaTFj8Cd5nA+KRGd8p5LlLc9V4iG178j8hQCTgtXct6JE+0Zt1vmFF9I9DDbr6pQIpF2/gNOi22imwjk3NgKRsC3KJdHk1zY/lUlCF/x61WgrWxseTJBr/kl5b9R/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068448; c=relaxed/simple;
	bh=N8mZD2sQAoSwrm0mXZHEv0GMPz3LfeOhsm7OcnGoTGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tUi0v7LO++ZIEOz2nt84dzqJjYr/GrMypL/ebrFiYnxRY9LEQN1YX4gVEoI2UlR6VM3NUK+zHL628VIclhFpA0L2pW6A45L9SbD7r1UBiGARtx8/0C54+EDmzoDVGnNo/DnVDlvETzmaCwm122a1ShSX/7XffXu+0ixJ7JdgoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HdBPT3dm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HdBPT3dm"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cdb889222so48026835ad.3
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 18:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732068447; x=1732673247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aA/8vtvFg4zvImJ/zLlmkaNmpAGB+mCxPZWX7eCvK8=;
        b=HdBPT3dm08eSMQ/4FK+1/2a5k8ST5xxe99G0LaEcgQIJ7v4mlxUPvnIH+IlCS9AItI
         NsTSrhwvLq7zZjAhLGU50USFckMOzr4ZEnMNCVMdrF/2u0nWczq30X0PqRteCv4fC5d8
         UMBkNQ7bBUA59jEntF9X84+8MgYNDzJEAYfx/M3nxxXLiCreHcM1nohTcyc/zlzSVU//
         g5MnKqcZ81co8Pf9k9kfz+P9r5SH5Ov0D6xSH0+C7EJpMRNzyn5LZHvBiKHARADg/VmB
         YdXAN66SZqrObe5zOLq3Qw0nnheAxqY8o3beqmhu4DRx1GOu2aEcxHNZyOWC9FygwMdh
         cdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732068447; x=1732673247;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aA/8vtvFg4zvImJ/zLlmkaNmpAGB+mCxPZWX7eCvK8=;
        b=JL5Lx89GSxLwfE4saVoJDh7tBydh6VXZhUu6BFAGmmqPjge/xVnfXjjAm4o3vIbFLt
         /PlEhaavToiv3Qurk0mhIf/ejxsHjTFFDhkHJs8pVjEXNuzEnh8efVaLDduuLB8ltJih
         Kc+XsZ41MOEd52MDh83MvZ4hyntnahm3zn9pFAp+w+ofjxcUKBEa79NX8iiuhUPt6DwR
         IL+YbtW54NvbwlFaKw8PzJ0wy4mTgAGSzHmFIrPNbGa0zPh3W8KOlbGJfwBn5UAAfAg4
         4C7mS41e6n/gU5A87/tMVK6CXwcYkVCpS1pO8nSZAZniX+3sxu3IXnDKNvH/64H2hznn
         +Sag==
X-Gm-Message-State: AOJu0YxEQJ+WZRv3La7AHSemxRsRWjqlhIRAjzQ9LcVAboZGmNjCCUs8
	1KTUPjhfINhyZ6t2wNDRNjhvGLfJ2kDDDcOr0hOwZyKfGXrn2zE2B3rIx6asAqla+a7cJLXxqQs
	MrSE=
X-Google-Smtp-Source: AGHT+IGFJgvCEysNvTRZNtAzK2QrLw0y4Kz00x54gLPKEvb4NzophfUZB0ug6GLkijZYrdSBxWwEBg==
X-Received: by 2002:a17:902:ef0d:b0:212:4739:27b2 with SMTP id d9443c01a7336-2126a333db7mr11238125ad.5.1732068446644;
        Tue, 19 Nov 2024 18:07:26 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21270d53ab1sm798625ad.258.2024.11.19.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 18:07:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20241119160932.1327864-1-hch@lst.de>
References: <20241119160932.1327864-1-hch@lst.de>
Subject: Re: more int return value cleanup for blkdev.h helpers
Message-Id: <173206844545.184430.10119111000096401754.b4-ty@kernel.dk>
Date: Tue, 19 Nov 2024 19:07:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 19 Nov 2024 17:09:17 +0100, Christoph Hellwig wrote:
> as John pointed out there are a bunch more helpers in blkdev.h
> that return int when the underlying value should be unsigned int.
> Thid series fixes those, and also switches those that return boolean
> values to bool and drop a duplicate prototype.
> 
> Diffstat:
>  blkdev.h |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> [...]

Applied, thanks!

[1/6] block: return unsigned int from bdev_io_opt
      commit: 5a9d1b83e5334915c651604648c20a9fc64d47a3
[2/6] block: return unsigned int from queue_dma_alignment
      commit: ed5db174cf39374215934f21b04639a7a1513023
[3/6] block: return unsigned int from blk_lim_dma_alignment_and_pad
      commit: e769489a54401d0c89555f7ad8672038b5c2b767
[4/6] block: return bool from blk_rq_aligned
      commit: da77d9b23700708d0d22a4407d32a8755a3596e8
[5/6] block: remove a duplicate definition for bdev_read_only
      commit: e888810bc4f471f85989a0991aff28d2ac9f783b
[6/6] block: return bool from get_disk_ro and bdev_read_only
      commit: 766a71ef65bb217ed8bf1c068ac14c7d3c15d487

Best regards,
-- 
Jens Axboe



