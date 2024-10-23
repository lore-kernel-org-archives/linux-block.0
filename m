Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981E1AAE3B
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724593; cv=none; b=jhHRZNz9Bt2w2sl+gzK0fgiDdw/M7Lj68132FUfC4mGhvEkmye4IcHekRgy3Oc2OCrETvi6pvSXYK2rIRHdFCV6nzQU3LK/lyrzz3HizT39pAT99jqIznqXcfRm4EvBNoU3AOKucFeFpLoEuALgqNx7tM8P3dFMub1JKV69f4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724593; c=relaxed/simple;
	bh=8iaR87DSiZDQHIj0hRXeOhuNJpqqaWvaXScWU1ZA/Ok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fEr+xfXaPuG2uQsZBa3GK3mt0oXXCjB++6Ylpimm7qsvJ4dNdS6iSlhMqm8YH0v9r/ReH4YXdGyO/Qcpmcaxew2xX5la+/0OTRb5aldRezz86xEO+/0mkqkE2GTmUyNE7Dg//KpjvdlLAoGuH65UWNa2tU9MzCBnQkzQKinAGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZB7PP1f5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZB7PP1f5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca388d242so1858635ad.2
        for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729724587; x=1730329387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5tLdyQ0XMkQZ33gsUpvCOdju4I7tbYewdpOJIWKkmM=;
        b=ZB7PP1f5Oxix5+XdxdBiLQDCvQJcM2eDakv3Fi+JElpRPHdQk10E5eEtWeFA5m9RJE
         SAcFkE5qvQ8hqhneuBdOr44ULSIW6ayOa5nb2VyZCwlKTBDC1yJqftlcpB9/F/iWpMzS
         VbIfrsMSbyIWCB3791zDDLb7Asex4eA109qwuKncQ9uAjGQSOHH6unvjoKgKEhf4raSb
         cIxuhPZPTsl141C/ZzOy1dadtqOJJZQn1/qE6v5Xs8aNtLz6xrGX9FrMMYOhp8wOuW/e
         Px9nxk4foiZGm8svWVn4x3/tr6rCQXDbZSLSn6cVjLTp39k1ozLvnFDleNWCRP916sty
         NSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729724587; x=1730329387;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5tLdyQ0XMkQZ33gsUpvCOdju4I7tbYewdpOJIWKkmM=;
        b=XaPuAG5EJ5PEd3b1f3llE02YAA6vqfF0uOHkyvijLGjVG/b61RFgl9kN7L2PXV2QH2
         jPxW0z67D3sy9DDCR1WoyGnLEderx0GvtoYd/wIN1rbzAQLyS8SDkjzN222joERwhXg5
         OfVlgth2cOFeS9XeAreoELl4U7fjltL0zUNSa4CrzQV9mLTWhweFedCRw6BHWJk7c5cQ
         4KU0bD61ZMADSjJRijmcrnF6QsJpkQyzB6sYII3vjUca9mW0xsZ838kFG4PF+ssu13eK
         r0iQjdVVkELxNbrb9Ov5TX1DqAhpaIMYMkPMDWi9Bt899t8d68/EPdzKWjRdwPaG0CFS
         Y8Aw==
X-Gm-Message-State: AOJu0YyG2r25SdwVdvEDGQEEkMcBL16PuXgm5H1i5IPpULEuNAPanrPm
	y2Uue5Oia7b45ilGp2stIsIeVYnQed2Q3h7adAL06JTYIN/aMFJyyL6/CxcVsYI=
X-Google-Smtp-Source: AGHT+IFNy1LodwI2WH6VeOp/oBllcieiUzQ0Fn//MrG7uII2c/MqzaNcNefVhw0s5CS5fWULtY5CKw==
X-Received: by 2002:a17:90a:d41:b0:2da:88b3:d001 with SMTP id 98e67ed59e1d1-2e76b6056f3mr4444053a91.18.1729724587302;
        Wed, 23 Oct 2024 16:03:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e57f619sm37257a91.45.2024.10.23.16.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:03:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
 Christoph Hellwig <hch@lst.de>, Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, Xinyu Zhang <xizhang@purestorage.com>
In-Reply-To: <20241023211519.4177873-1-ushankar@purestorage.com>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Message-Id: <172972458632.1178003.15358016231071464295.b4-ty@kernel.dk>
Date: Wed, 23 Oct 2024 17:03:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Oct 2024 15:15:19 -0600, Uday Shankar wrote:
> blk_rq_map_user_bvec contains a check bytes + bv->bv_len > nr_iter which
> causes unnecessary failures in NVMe passthrough I/O, reproducible as
> follows:
> 
> - register a 2 page, page-aligned buffer against a ring
> - use that buffer to do a 1 page io_uring NVMe passthrough read
> 
> [...]

Applied, thanks!

[1/1] block: fix sanity checks in blk_rq_map_user_bvec
      commit: 2ff949441802a8d076d9013c7761f63e8ae5a9bd

Best regards,
-- 
Jens Axboe



