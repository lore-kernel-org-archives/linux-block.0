Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5768F5E
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911150; cv=none; b=f8jspMzNO0unhNrEbthxhWOXi8xImcqdwRNBjji34rPtaZTIew6MYSvEWOYo7bpDvG6cCjidCRbt825dP8hUaenXP1FPAW+pSwlZ1hZBrfbVwiX+LnVNA9k6bfIrETYye0o6EW+nzeQUcemtv5Kivgpqy+VSxg8+OUbO6Fml5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911150; c=relaxed/simple;
	bh=v2VjevhVXzh8QpTnbCoQXLZqAICMzSLG9opg9XNnQpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fl7Y1lZMKv9fK82ZQet5RIfvwB9ZMwF/XDbnWuFGwCI7TjpWzcCM/A4ZMQuwC1NPcNn7WXi+LJ6SNWWDvziP1yImGdo6MT9g9ENeF2ZDROJNF00w4TOhjjCb1AYja6RdCmUCfKCuJMa5I7fXV2MDHDYHLbpksFiz9GkLcM7tzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c1A+4F4Q; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c1A+4F4Q"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df2f937370so12661145ab.3
        for <linux-block@vger.kernel.org>; Mon, 07 Jul 2025 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751911147; x=1752515947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhZK2HlfHzmT43eXpD1PkZFU0qhnofuZXFPCZ+mclVs=;
        b=c1A+4F4Qv7G0FMiDcM5bTq4pHYctSe+JajfKiLVcqw15jWdABd3pNy/oLHY/rhefMJ
         e8Lwr+yViofDhZDqoQbRQH0aAzUsI7KKisnOKfV/thUKjlqP8kMobFhNd1PsWmcosZkt
         HHWRYVx7k8/eknlVpq467VroH8GFPF3Ds5dh24NHHdOMgcF+sVDo+ZgNLvM7zWLClP8G
         IXJ9K/WXxvSIom/bXGTHD18u31DAn+rURf+Olx+qb0HrbRA4lNJzSBCXSc+K2OLAFoJM
         4iR/qD8Tmo2Bsw0u9n34JJJ+wRL1pTvc3BGLA2gGIqZ/VFy4t4x4v3+EbcJOvlqM8zMS
         WNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911147; x=1752515947;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhZK2HlfHzmT43eXpD1PkZFU0qhnofuZXFPCZ+mclVs=;
        b=jrkEiMlUmJ8BZ3w+KnJU5dqwSJHhT94cwo+QoswIXlGwUFoCD2pNimrsdH8rK7XjZB
         7pnajw2t5A+Eufo4Xl1kpqHIRIc8j0kHNKmIfBlqQunbzOr/cO+fUq1oEUX9/wkEErHJ
         cOrrSro5lFgfgMgPNUb7l1NQRbVLR/0GUOMZ6g9vokTjEK5zrDyEBpgW4aD/TL2QQ+82
         VlbznXnCv/5TaH05PFzXZliJTTp1sNZd4Yu+71CgQ/Dm6tV2nM072bfgvGrK7IbP1Jj5
         rzLGMLkT/kWRhCW8fqrgwzOmTzujBQ6S0KKu7w/cmcLKEmKUpv0yfAfW+y4LZXPsqvQJ
         S2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVO0ghBk1qMJvczFcPMl0Pyhxc1KOxbaAFeD0uvT4xJY/fnCzE1E1KCxKKYE4ioZ7rx9RG5DMwT6qdMMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjmcgcrFR8lgLWtpABzIxQOPlltj2FsC3OqdjSAXzMRf+7TNZL
	RhrzdphzY1ijKkH2/cDbuMSQ6HjdysZSYNfJvW0Elv6mAUA/mRJrowmnojbkN/KxXAGBa1KOBeC
	U757N
X-Gm-Gg: ASbGnctEfj8CmRkB/AX10YXfr21FeAAT7ZE3I4ysIz+uD2b6aypFsUOqzPEK4zppPpH
	KFzTojktyN1hgHASWBKc64miNiH/bk0sAgo4U8BIcARW7JaJlEpmKzWsP7CnBFJyzXpuU1Vt+yh
	bzL+a6JMsuUQOMqhRHED98ikAiDs8XZyjOPWjgWm3UI3uapASu2CwnCRJ5C/pFq5GyfAqp8xhO7
	yvT26n5zNMAXbb6GTQF5b32Ft+6rvgav04sx8LhlOoujwP4asd/aCHT1qp2thtJk0bUx9lZonU5
	nhAYY5rqnZfKeZG+xw3xNHCDUimsZz2Sz2LN6XanVgtOqNM+i74C
X-Google-Smtp-Source: AGHT+IF6NCJtC9aWhvRfxqn2m1pWQfWS83WIrF+2LPxTT0ePPKhktletHOeY1ElRsxWnDJLxci9SeQ==
X-Received: by 2002:a05:6e02:12e2:b0:3dd:f1bb:da0b with SMTP id e9e14a558f8ab-3e1539172b6mr6831125ab.7.1751911146968;
        Mon, 07 Jul 2025 10:59:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0f9b90650sm27172245ab.25.2025.07.07.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 10:59:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>, Hannes Reinecke <hare@suse.de>, 
 mcgrof@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de, 
 Christian Brauner <brauner@kernel.org>
In-Reply-To: <20250704092134.289491-1-p.raghav@samsung.com>
References: <20250704092134.289491-1-p.raghav@samsung.com>
Subject: Re: [PATCH] block: reject bs > ps block devices when THP is
 disabled
Message-Id: <175191114597.897893.10689486110694082166.b4-ty@kernel.dk>
Date: Mon, 07 Jul 2025 11:59:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 04 Jul 2025 11:21:34 +0200, Pankaj Raghav wrote:
> If THP is disabled and when a block device with logical block size >
> page size is present, the following null ptr deref panic happens during
> boot:
> 
> [   [13.2 mK  AOSAN: null-ptr-deref in range [0x0000000000000000-0x0000000000K0 0 0[07]
> [   13.017749] RIP: 0010:create_empty_buffers+0x3b/0x380
> <snip>
> [   13.025448] Call Trace:
> [   13.025692]  <TASK>
> [   13.025895]  block_read_full_folio+0x610/0x780
> [   13.026379]  ? __pfx_blkdev_get_block+0x10/0x10
> [   13.027008]  ? __folio_batch_add_and_move+0x1fa/0x2b0
> [   13.027548]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   13.028080]  filemap_read_folio+0x9b/0x200
> [   13.028526]  ? __pfx_filemap_read_folio+0x10/0x10
> [   13.029030]  ? __filemap_get_folio+0x43/0x620
> [   13.029497]  do_read_cache_folio+0x155/0x3b0
> [   13.029962]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   13.030381]  read_part_sector+0xb7/0x2a0
> [   13.030805]  read_lba+0x174/0x2c0
> <snip>
> [   13.045348]  nvme_scan_ns+0x684/0x850 [nvme_core]
> [   13.045858]  ? __pfx_nvme_scan_ns+0x10/0x10 [nvme_core]
> [   13.046414]  ? _raw_spin_unlock+0x15/0x40
> [   13.046843]  ? __switch_to+0x523/0x10a0
> [   13.047253]  ? kvm_clock_get_cycles+0x14/0x30
> [   13.047742]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
> [   13.048353]  async_run_entry_fn+0x96/0x4f0
> [   13.048787]  process_one_work+0x667/0x10a0
> [   13.049219]  worker_thread+0x63c/0xf60
> 
> [...]

Applied, thanks!

[1/1] block: reject bs > ps block devices when THP is disabled
      commit: 4cdf1bdd45ac78a088773722f009883af30ad318

Best regards,
-- 
Jens Axboe



