Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F557217F47
	for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729948767; cv=none; b=rxctNXd/3Bkzg1P/3zd+PgSfHujHjTF4gbCFWjef7OIwAwqEhubs3mfWmAIaYIZ4XHvF0fNB6I154PxHX+p22/BwjNTv4xnqc0+KIgQWTzs9KVrO+9Zj5KyG50BIwvBvYrBjmXgdwdmB91tD6a0mmE0Rm0mItx83ZSM2IbgT/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729948767; c=relaxed/simple;
	bh=J8IgOHWsC7P1bUEK9yQygQla+EiVcUe0DxUGK18bsOU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BfiDlmMUiQcAkXsvEeFyAJ1reLF4hSy40s3yXLlcmVsuVFflfEtIy4whzGiorv6s34M9dh424EI5RQLonqDrOy37Re4VLBRNAPqHeVPkWa3vnLFzVgDZSUKabbIBK4uQpHmZrN0DBoeGtGSEPpgzwV3YFNyYDqNROVNrVkbIAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wxyem3z4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wxyem3z4"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2117668a12.2
        for <linux-block@vger.kernel.org>; Sat, 26 Oct 2024 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729948763; x=1730553563; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwpRuPdTDpPd8oGNtQlteLTMaXM3vougR9ocdB99Nro=;
        b=Wxyem3z4ipg1jRhMEFzj7Jl6EJo4VPv4U7bknA/SGT9IkKIOJFOax+LnLFjB2pi04i
         Rw0GCfYQYgxFskw3WxNxM5vPy5BsLVx4t0ZmgYBSBkgEfFMZTXdbTw6qpKdxrCLeoaRN
         ExMwkgeSR6fWZbEAXrgNQLOa9Xpsv4uKKhFhRnQdA1spBHqLPYN6VGbHH+iyj9dIHO+w
         1fooMCZF71mouxS4MSNoTaILWy2YJHfFDblDrNhvkQrrePk3djgyC/XXtQjlak2GHDBU
         0ciqVBR+zcP4EmbvrcizKmI/4pJueZD+M9ELm/I59WxXYyGTtcRXNG+m2RMTMxh+E434
         OIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729948763; x=1730553563;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nwpRuPdTDpPd8oGNtQlteLTMaXM3vougR9ocdB99Nro=;
        b=h92Dc/bI/UIuDM9YtQudzB3YhsQMVSmWyEMzy1XAV/aV38aJGnkvFhuoVygegwgqon
         QqqPV6ChZjPnDcOyB0+Sflpyx5aHTDzcsPFqzTgFinaqKohGB7Cb2xK2xW/sR6Jq7I77
         FyKBBp/y0ypvKz5tyhsBeUx8dK+Kf9+LwhIsjSUmloWhzSRjIOOKIixSdFe62qnKEF/s
         Pp+HvNpkTChLcNqEp41NzrfgQ3J7zx7Tmwprkra8bk4Hb+qgpdzA8yP7UbOTW+MOY0JY
         KtoaXSdtZJd1E0sKbl6cNoakuXOVqyz3fXiqrCcIMsAcwzqC9pglBCghPiJqQTtUEcoy
         y6GQ==
X-Gm-Message-State: AOJu0Yzjm4ocBmSBLabI4ZB1nWRMtCUfVHsdY0zZ6WRQCMpMRfXzL7/t
	wsdsydmEMj7rbfLLCg/BtqFI1wlh0idVN2G9ksdds1C4BZ108lnGc/J6Hh/tzOmKIxmk4XYPoJF
	P
X-Google-Smtp-Source: AGHT+IEUsWLWzNpB1i6HkuT/Chl366nOUd17Zoh8+rQCLKpUp/Krs5gGDMApS7H/j39/BuwPCgse2g==
X-Received: by 2002:a05:6a21:3a41:b0:1d9:22c1:1235 with SMTP id adf61e73a8af0-1d9a8401c39mr3806452637.22.1729948763607;
        Sat, 26 Oct 2024 06:19:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c018sm2691258b3a.189.2024.10.26.06.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 06:19:23 -0700 (PDT)
Message-ID: <ed75a79e-3b85-459d-9aa0-859957e0f4f5@kernel.dk>
Date: Sat, 26 Oct 2024 07:19:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.12-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a few minor fixes for the 6.12-rc5 release:

- Pull request for MD via Song fixing a few issues

- Fix a wrong check in blk_rq_map_user_bvec(), causing IO errors on
  passthrough IO (Xinyu)

Please pull!


The following changes since commit b0bf1afde7c34698cf61422fa8ee60e690dc25c3:

  cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed() (2024-10-17 19:47:15 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.12-20241026

for you to fetch changes up to 2ff949441802a8d076d9013c7761f63e8ae5a9bd:

  block: fix sanity checks in blk_rq_map_user_bvec (2024-10-23 17:02:48 -0600)

----------------------------------------------------------------
block-6.12-20241026

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'md-6.12-20241018' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.12

Li Nan (1):
      md: ensure child flush IO does not affect origin bio->bi_status

Xinyu Zhang (1):
      block: fix sanity checks in blk_rq_map_user_bvec

Yu Kuai (1):
      md/raid10: fix null ptr dereference in raid10_size()

 block/blk-map.c     |  4 +---
 drivers/md/md.c     | 24 +++++++++++++++++++++++-
 drivers/md/raid10.c |  7 +++++--
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
Jens Axboe

