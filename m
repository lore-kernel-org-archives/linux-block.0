Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D69353356
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424739; cv=none; b=h71ekBFAaukTZrB17ZM483oyhMce4+CcCTsi5arU2n0DzEGrupsf+HGUVe/gkhcFcLM4RN89YMmafzwfPLYjZgcU7o00teg1AcW4Jv/nfi1plFd/Hmk6/zbQMDRrEHeP2FQGYm7LeNhPt7YV4iQ50Ys7nPqNxZuAmD0reRkcJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424739; c=relaxed/simple;
	bh=hkagkYSn8JCIKje4opj+ZWhB95aqsDfPnVS7kaY2IQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JM4SxtkcWS5O7umuiasKfRpJUCciUGL7FTYr+EQttNcY6pWhxFo97me6L+Ry1u8Cc/obN8i4kqcIJnazp4XSCnhics9eEDhe8wA58apdxBRy+0rHXYUQyMBapSIcnu+uGuIg49UoE7HONdjjPhR3lHpNE6+WI7tIg0VIhfYrIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=07HN/Kh0; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="07HN/Kh0"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88758c2a133so519122439f.0
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757424737; x=1758029537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO59olxiRg1XK9XpYrLC+/QiojSbULiCcu8M5YdCEYE=;
        b=07HN/Kh0QkSNklSttlAwuVw0Zy7rx3Vk4lCustIfbo4NA7UVeFLOQeDLnNSBgV13HA
         hI/p7sXx5nxxTYiynuLbftkxm3mRCLSe8JeGLhRKNGcYQmviGOXnBuZ3FtkFNnbUfUBc
         DQa9KodnuYrC/J4XV4bEAcby471GU6Y805tsjesTGYvwBfmEBXpPMp2PXzZ+AFTa2vqB
         zkq/kb5wgi78QQU1COgrvV5lZ61waBQ+uhB9tInL59mM+aWSZ+hAtce42KSGBgW2yX4A
         WKZx3KCvON/TyscoCbRn2FDpAb6gau5tMOtMmFIOgF6C/SA0802scfuhURCpcb7GKCjM
         kpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424737; x=1758029537;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO59olxiRg1XK9XpYrLC+/QiojSbULiCcu8M5YdCEYE=;
        b=Ef7x+OhaEKOaTP4O9QkTkWQl3jwjoV0sOzcFqjruG3a4gAkOLirK85tnJffJJTn+RZ
         41LWSKYop6iVDQJTmdnaYptm7urg0q1MkoNghgd04Bgx+KFBrVoETcRYryENc70Bn+22
         2iI5vL8xqBJw+BBFi32FGWdfFhvdgifgcAlSRSef/V2oK7Y+gn8TeC+5mdEYKjchASwy
         dkz3ZHdzUZ9ZVhM/1fFXrRGJd5TisO2oowIfT++8wUQsml4drWbJiBdiwC5A7xa18CAG
         3AgaAQinPXHEaC4ypUkrmwf7Kj9tIU7bKaRCAJ9yH86S8oLpv0wF6UGt9qTNJ9PFCoWM
         04oQ==
X-Gm-Message-State: AOJu0YzwvRelxZrHGiU2YDpLniWw7LTK9wkULjwgBOX4ftwF/+6GKHFI
	qalM+2fL555vCSasi7ukSDWwn5Y145us2JzTLIVCPHTH/SlQY+xXkSucefYIQqvJ5qG25DaMr7j
	K30QN
X-Gm-Gg: ASbGnctOrdb13pe8FLcRAiIze5fWTZFdvIOlY8rTjupt7igyHpZMAQVYT1jDXVcylkW
	pUrq/DZZNewMgeU9IxXw2O4OGZoOZIx+ShzJEtVmvz2ouCvurSvxAgaGCyk8BINx33BNFOh8IBA
	rmJR42EvHj1aexmAsp7e2iQWCv5hDflrWJJbw3IlvF8pKq0ofmPyDRzVXavnU7SWIDOClMVASMB
	x4430W37Lx0XpwSxtcoZlbtme3WYyO+PCPBSsoWbqWoC9UmkINcM4kevCxaimKV/ZeP0L4oty1s
	OgcBLgDdS+rAHJ66dRPiLgfaM5dTkZ+t4aXidU+J+1UOEaYTOFbU1xkS4pXSzPbFojieUEz6ECE
	Mrh3Evk9W3yil5Mc+73ELRwsw
X-Google-Smtp-Source: AGHT+IFRgx8SXH+61I5ht3ylw3r3rKrFFUhy+QHUQResarsL2INHTZU94tdJ3saaPxvTkCDTmKcaAA==
X-Received: by 2002:a05:6602:6c0c:b0:881:94db:6c1a with SMTP id ca18e2360f4ac-8877753bfbfmr1794053539f.5.1757424736548;
        Tue, 09 Sep 2025 06:32:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8875d8791dasm577204439f.8.2025.09.09.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:32:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250908105653.4079264-1-hch@lst.de>
References: <20250908105653.4079264-1-hch@lst.de>
Subject: Re: remove the bi_inline_vecs field struct bio
Message-Id: <175742473605.75938.8479854785092722671.b4-ty@kernel.dk>
Date: Tue, 09 Sep 2025 07:32:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 08 Sep 2025 12:56:37 +0200, Christoph Hellwig wrote:
> the bi_inline_vecs causes sparse to warn when a bio is embedded into a
> structure, but not the last member.   This is a bit annoying but
> probably not a big.  But it can be easily fixed by just removing the
> member and doing pointer arithmetics in a helper, so do that.
> 
> Diffstat:
>  block/bio.c                        |   10 +++++++---
>  block/blk-crypto-fallback.c        |    3 +--
>  block/blk-map.c                    |    8 ++++----
>  drivers/md/bcache/debug.c          |    3 +--
>  drivers/md/bcache/io.c             |    3 +--
>  drivers/md/bcache/journal.c        |    2 +-
>  drivers/md/bcache/movinggc.c       |    8 ++++----
>  drivers/md/bcache/super.c          |    2 +-
>  drivers/md/bcache/writeback.c      |    8 ++++----
>  drivers/md/dm-bufio.c              |    2 +-
>  drivers/md/dm-flakey.c             |    2 +-
>  drivers/md/dm-vdo/vio.c            |    2 +-
>  drivers/md/raid1.c                 |    2 +-
>  drivers/md/raid10.c                |    4 ++--
>  drivers/target/target_core_pscsi.c |    2 +-
>  fs/bcachefs/btree_io.c             |    2 +-
>  fs/bcachefs/data_update.h          |    1 -
>  fs/bcachefs/journal.c              |    6 +++---
>  fs/bcachefs/journal_io.c           |    2 +-
>  fs/bcachefs/super-io.c             |    2 +-
>  fs/squashfs/block.c                |    2 +-
>  include/linux/bio.h                |    5 +++++
>  include/linux/blk_types.h          |   12 +++++-------
>  23 files changed, 48 insertions(+), 45 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: add a bio_init_inline helper
      commit: 70a6f71b1a77decfc5b1db426ccbe914b58adb38
[2/2] block: remove the bi_inline_vecs variable sized array from struct bio
      commit: d86eaa0f3c56da286853b698b45c8ce404291082

Best regards,
-- 
Jens Axboe



