Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F043144
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225250; cv=none; b=fOL9nMpvYvkhHTLjVKj0dl8it46gMpeOQcIRtsincizp3hnSyj5hYCKf1U+eT4KZz0+eUvRt3ATruetYMcxWjHZo+95Dm9BV8iyrl9/CAMvC4FNjm6de+sQ2OWFGUMJ+XiaUnsYnA5+HaqkarN9AqZLvkHByvXDfQ3PHOM+5NDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225250; c=relaxed/simple;
	bh=qmPQuwlImEEfjyI8gy8DNsWQFjY4RJ+dDw6B58U/sy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hks2jv3FN0FQFPjR4jlvyJjF2svmSE2+a3XzzzcSTWLDq1oBSZG9LvTsWpb9YL1VxKW4rLOz4Iq/2Of1PG9erea3oysNXg92J9HC2Erwd81thkwxcghfF9gAq+cOGti/SMGa+GwbqlbvX4GZiR43XdHFUrKzmXwMrC6j0sQWqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3ChmlI6f; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3ChmlI6f"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e4feabe5efso44092a12.0
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718225247; x=1718830047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd1qAr8+twmvyfx7yBKkxrOM3VKy41NtLaMs2IgZ6c8=;
        b=3ChmlI6fX2Y2LuACMAmdHybd+dY6w+TLDYDnyyHUYBAckOv5PnltXsIRBRssP0CRj3
         BBEG1913/IiFkWwn0p3YSaKN1wDjh5M0dc5g4xCWLFn6Z0zTiUZDa5XpCXMO28SCrAoL
         LDn/ul3Yu2heZ4TGUXvQwxEvnXOAF5l/umLT0VlhI+ETG2efT1wJUGee0aScr5hK/uk1
         4zhEHzViRbtyg3RwabAnbge2ienbf81tXFRUJzlBmYmX+tr9G1v5zBPqXf/A/IFttsd/
         RhnhHcofJgXujCSXaevnjS5FVeUg8vlFTNZltIbSIT3IO+x/CqtGHjdRhiaPkrbUvI8s
         X57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225247; x=1718830047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1qAr8+twmvyfx7yBKkxrOM3VKy41NtLaMs2IgZ6c8=;
        b=ra6vCnqZ8N6qR0iPfFeorSszlP7hdNirDZHSK+Tv8LDmhMaSolU1f0pO4/BluWWpsG
         SedfUdkhSmm2nATCRqF6Z4w7vExgal7rl9W4c7GfOeHy0O0WfhPfXr0gfVX5sOgOz5Zj
         MMmrbXdV3d+okQ8GYmLqQKtcUewrEDfHteOPfFzGLQ778xfF6fwZQuKOxVmkN/ab2awR
         UmZ2wO/qtOKElAsEtcaiNcpqbrxkx+btougQsQPsFn3hclRBCPorWkONMu6sEwUTqnaC
         POhNhg9q1Kq7C4Tq8qbVzRs9CuqGXJihKuQVMJdKjLWrnlpADlhGpfm4T7loiyZ4UJJX
         bEFA==
X-Gm-Message-State: AOJu0YzDc9d1dmJcHh00fMDibIsCu0a1EmYvtoga7DyDH75q9k/0pzLR
	Sc6Bg9yxQSKQyw6S77L5iSPU2q/7ksPI00NKHmxxqf7iBXQwgaUuADd7RJ4/JjY=
X-Google-Smtp-Source: AGHT+IFDlBSISoWXazS1FIDpJGbcVX4OmcBIOPJ9kdQyaUplKjcmMQJEI5KwZM3gMgFXPJCY5NCozw==
X-Received: by 2002:a05:6a20:daa8:b0:1b2:53c5:9e67 with SMTP id adf61e73a8af0-1b8ab6615d7mr3449170637.4.1718225246874;
        Wed, 12 Jun 2024 13:47:26 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:728])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ac015sm3274a91.1.2024.06.12.13.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:47:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20240604221531.327131-1-bvanassche@acm.org>
References: <20240604221531.327131-1-bvanassche@acm.org>
Subject: Re: [PATCH v3] nbd: Remove __force casts
Message-Id: <171822524577.127701.13834488633984261452.b4-ty@kernel.dk>
Date: Wed, 12 Jun 2024 14:47:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 04 Jun 2024 16:15:31 -0600, Bart Van Assche wrote:
> Make it again possible for sparse to verify that blk_status_t and Unix
> error codes are used in the proper context by making nbd_send_cmd()
> return a blk_status_t instead of an integer.
> 
> No functionality has been changed.
> 
> 
> [...]

Applied, thanks!

[1/1] nbd: Remove __force casts
      commit: 957df9af723ccc570da835978cf7fe7863632842

Best regards,
-- 
Jens Axboe



