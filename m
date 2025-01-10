Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8E211269
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519531; cv=none; b=JRmfIxsyYPBFevdfI1I5T52qPSeEEYvo/+6migTKTTXcbNXJBXEh6zTYTlBsoPxomnLrJ9/6qI8LG5fVQ0dIEodi3zBvekMTMtOXN8TBEkqwccZxKlx+N12GNkQKzv3VnFYI3l8kGYhXvrmm3HnBRGoh1jr0mNQq3pAj7oDpETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519531; c=relaxed/simple;
	bh=wjl2kyvrQokdftdcDT7iv1DznyqTSmhketBgodBglC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GrFP7wyUibNYGS/eUyP3lYNd/zxp0oXta7s9tI4b6oaQY+9wG6YJA76eYOW9s8BzRBd+MDuuALEYjsvA8VIa18cJfZjGOMKHrnkNgK+d5LNKyuxSpjPiKEqC/xpE9Lfqk3ZAO9Esp9YLm43OwPxAasnPPk1LrySoJSLbpnw4HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xNZS1KKt; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xNZS1KKt"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844eb33827eso64778239f.2
        for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 06:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736519528; x=1737124328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/gcAKNkCa46sAJjco4x4Dt7XCwnmRxnbzpikJ5Iyr8=;
        b=xNZS1KKt2shh4V2lOhN52MWj23/hDMmFzIAvaV6Au0Ls4ndjQBec43c4swbYhFNDhg
         DW2gYzwxXQVQ/P+f62PjW8B1U3CcbCmX28vhxGn0+k8yLKjr75e15wvx1UZEDAicxMp4
         IWCn3uOHCa+FyzYYwnaPAzom9dbWMrFcbXHQSQkqVg6Qw6bq/zFVcLiYJOT6j9izDeX/
         gnYre9xzmfk03jNlqG1krw91ufxGuLhjd5N6koPznbIJisLq1CZQRl7FFp41hSRd9SsU
         n1NnZgY4SiIxL+YwoS7sSz6uowAUz8n9yUgdMdEJMDknlIDzompy+oZs0ogPJKelDC2c
         BAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519528; x=1737124328;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/gcAKNkCa46sAJjco4x4Dt7XCwnmRxnbzpikJ5Iyr8=;
        b=U22diyRsmvZOzNUIyLiaIEPM4qpbH+evb3E3iAtBWA48EAeJVsX5BoUNjkBGUrAg6x
         Rjq55TPFH3b7qo9+i0yMBELxMGe2qbFW5yKNHTS6oWSTHt5F8jmIRxjs6m3kLNL/rRnB
         KIHZWZ51QlhA9uDIyXD81bMsl/fDQAGeBk4BddKFkfIKP2RojcLuxhUIbbwWKt78A8lv
         vSqvWtO34FCCMIfyRfGT9ZJl4l3sDxL/rzPZp/ElXX8yuzZSHto4oWjW6s1wvF/JVxrZ
         fLlNw/2tRac1Ey0Dah49Ejyd7IPWo262Yy/5Fh1JgmAnIfbWxZ8ebJBcf9I39anMze4P
         AABw==
X-Forwarded-Encrypted: i=1; AJvYcCU2wZ6fblYfDki7REdTjr91CLKIQ0Gt78uDdu4eFvGt8tj1+Kw8cHyMerylTRsM+T8ONcpIKL55JJ6+xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlN0S97IzBl64C6Ziwg5GLwebIrHo15ycS1SM2yjfi5fADQgy
	t9C8cLuTDyxOlZ586u+Hu+GzNrqvNohXtb6GwUw2PrYLaYYtGDzL2TkFtLtxtXQ=
X-Gm-Gg: ASbGncu84wKdlWMgEywOCiQwFK8R0J8pEcSZhbykMcYMlhbCSjP0wuwabWTjb6DZZnN
	I3wrtFsuQtOzepGWfkfPW06Al2xTZ+4eP8+jPOJJIusXviZfMsRSWOxXU/PoJq2RZaBvixeWc+X
	Tmj3jjPn7Hzxb5gZj8iwDFs3v4gjzmQ7VTpwWzHL4lD5JUz5FGVf4xU4LJ1JamFZSz8qJS987Ll
	bOMv2aS167M+WwEZS6FpmLodd57DO9DZLxDs78w6vh2KiU=
X-Google-Smtp-Source: AGHT+IHH04d6dGti7fVXw+0NaZh/+tDlC2458jxoW49T1h/PFC0T6YfGUhNP11btFhq4QTA6+HtDyA==
X-Received: by 2002:a05:6602:3585:b0:84a:51e2:9f93 with SMTP id ca18e2360f4ac-84ce00c49f8mr971265339f.9.1736519528352;
        Fri, 10 Jan 2025 06:32:08 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fc84dasm91086539f.46.2025.01.10.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:32:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>, 
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, nbd@other.debian.org, 
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
In-Reply-To: <20250110054726.1499538-1-hch@lst.de>
References: <20250110054726.1499538-1-hch@lst.de>
Subject: Re: fix queue freeze and limit locking order v4
Message-Id: <173651952702.758529.3309066666363818120.b4-ty@kernel.dk>
Date: Fri, 10 Jan 2025 07:32:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 06:47:08 +0100, Christoph Hellwig wrote:
> this is my version of Damien's "Fix queue freeze and limit locking order".
> A lot looks very similar, but it was done independently based on the
> previous discussion.
> 
> Changes since v3:
>  - more comment fixups
> 
> [...]

Applied, thanks!

[01/11] block: fix docs for freezing of queue limits updates
        commit: 9c96821b44f893fb63f021a28625d3b32c68e8b3
[02/11] block: add a queue_limits_commit_update_frozen helper
        commit: aa427d7b73b196f657d6d2cf0e94eff6b883fdef
[03/11] block: check BLK_FEAT_POLL under q_usage_count
        commit: 958148a6ac061a9a80a184ea678a5fa872d0c56f
[04/11] block: don't update BLK_FEAT_POLL in __blk_mq_update_nr_hw_queues
        commit: d432c817c21a48c3baaa0d28e4d3e74b6aa238a0
[05/11] block: add a store_limit operations for sysfs entries
        commit: a16230649ce27f8ac7dd8a5b079d9657aa96de16
[06/11] block: fix queue freeze vs limits lock order in sysfs store methods
        commit: c99f66e4084a62a2cc401c4704a84328aeddc9ec
[07/11] nvme: fix queue freeze vs limits lock order
        commit: 473106dd3aa964a62314d858f6602c95e40e6270
[08/11] nbd: fix queue freeze vs limits lock order
        commit: f3dec61d7544a90685f1dd9a87fd4afc751996d0
[09/11] usb-storage: fix queue freeze vs limits lock order
        commit: 1233751f7df722435bb93e928d64334db260b90d
[10/11] loop: refactor queue limits updates
        commit: b38c8be255e89ffcdeb817407222d2de0b573a41
[11/11] loop: fix queue freeze vs limits lock order
        commit: b03732a9c0db91522914185739505d92d3b0d816

Best regards,
-- 
Jens Axboe



