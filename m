Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2728030E
	for <linux-block@vger.kernel.org>; Sat, 17 Jan 2026 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768621987; cv=none; b=BOIyYmP8GG4EGKYZk8eLdfKSECaWOdKFXvP414DJXFyp6Ok0Na9lSnujF/i6ngFx/+XVtRTUPckJz7HsSMK0aoxkgiCQyQEfD2r2We1ZqvbxmMM1tKAn00WbMRlt+KN+vh741nR1pdZq7RgdL5/zQ+iiPkz9Qfc+jkhpaTkeVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768621987; c=relaxed/simple;
	bh=H0DAI8HuDKxJXhamfV2OweGIMjoVGIGacA+haK+JPCw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cERiRo+rk30NH9wLMBuZNr4t5Mc8bCb88ZIvD1Ny3gXfY4Ow/CB6H0rO0Efc2tNv5rfubU+LSktEMDR1KPrmG96qBO3ojT2PqPujvATakxV7NbucjH9/EYRyxzekMk04vp4t7kiFzdyJeL/F+U/P2+pg5vbnIGvNCZHRCHfrL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YCTkWOmd; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YCTkWOmd"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfcb5b1e2fso1759603a34.3
        for <linux-block@vger.kernel.org>; Fri, 16 Jan 2026 19:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768621984; x=1769226784; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2pkI3a52PPBfsI8Bbv3eUa0XcIvzWNTb6mPIU9j5eI=;
        b=YCTkWOmdloaXX6NiPFKx27zadf8WFscUHMksiI+Ma6pnl19ZxOBhEVfSQXC+PL7PLc
         oW3o9t9VN437m5oNGE8wSknyX4QC1jGcBCmmTE5ugcmzMCBOW5qaii6QAWaHNj4mygl4
         n5soXcHZnxN3c5Tg+PnukCrRiMUjrUKVvuCJWtBb69Y1iTXLT136wEA++UqzGiA/TyB7
         ALPKjYCoQohTPabQRHWztv3gHNIYfQbUDuXgsuN4M1Iw/i1wC5iO7lHIUvgVXfWNxaVr
         qLtSTeyywosJfwrAmiRljdCSSg8D0FumpWyTelXi3wsV9LUO2EwjH5F7KB07wXOXzQeY
         ubXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768621984; x=1769226784;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2pkI3a52PPBfsI8Bbv3eUa0XcIvzWNTb6mPIU9j5eI=;
        b=igth+5KtM8pL0ILS9g5bEryBeKgxP7e10D1IF6+yYyOKC7tNtzyKTczTbjfhcPIxWV
         vlqUICZquVPDLYFD3KEb8oPYXlqkIj2kdaiczHrUMBsogrLeB+59nKslpQVUKOSW3X86
         Nm5z5q5GuMefm9KFPoGEZlqe0IqBHEcICOfYjUEyND1+fwuHFmOLKKskdnn4KGQlwjne
         33i7ltwpVGwE2MowQLHRZfZmXPFg8BR0KOJK7ERclE/Azy5heVRqtmvJQ03RCCFsqAQ6
         znOsEDcE0xiIv4Qn0dNsYyysTItvlEwP9C5gNS93rNeqIT4bPPHc7JFBefp4ksA7gxam
         nztw==
X-Gm-Message-State: AOJu0YwGIaB1LfKX2wQYqcTjLmjmjRvF5O4t003nXMxqVFp9Qdgtmjnd
	vIgyqDFlkAOOLiscewHD9/igF3WOnjA6rvkfMU9AB2pA7tqapaiTu+M9XqFQPbGeAtQ=
X-Gm-Gg: AY/fxX4E5rwlJfii2NtDzybCpQBZjMcWTrLWiJ+jSQ7HueKxO1cFMToQDKNzYScCX5a
	Y0XUr90d61GxTW/LMQ5KWFrF23zQ9q1hv/16PjAUos3PpnpWsLK56E5+cqc1DMTbCZivtNLhy73
	hdAkl1lBb83LCXRqXa24ac5mEm/F1IBDDoUsi/yrOBU7ZCP0YUGLIPAPibCT11MeVECa9QHLKye
	Il0IHlz/r6wWFgme+6eU79Ss1Gs+igBDKXJahxZK5NbCpX9eFP2wPsu5GGwDWaUp8olxUdk2i4i
	SALZ9/QPk8MRU+7OXNYb05ssQdcEC2ogS9cf1rjNLUM2vOiBlCWvYwvhSz5GqvyjguiexRDsqwF
	WL/9tdlzfhZ4qP6dB7PRgOz81U3V9o7Yf01Z2HGjpDj38m7v9CqPlZPkeAhkAAAWZHTlWWy7Q3A
	b5v//IRTZVBdNEDpzsGnnqHYp/E4ebUKimn56cYJwaxMT4nRDbx5rU6EosLzaTaOE70fn/dw==
X-Received: by 2002:a05:6830:2a94:b0:7cf:ddee:686f with SMTP id 46e09a7af769-7cfe0123adbmr1837381a34.22.1768621984442;
        Fri, 16 Jan 2026 19:53:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b59e2sm2927703a34.30.2026.01.16.19.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 19:53:03 -0800 (PST)
Message-ID: <4e5e1aba-adc4-4414-bc86-35d3c8d9f653@kernel.dk>
Date: Fri, 16 Jan 2026 20:53:03 -0700
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
Subject: [GIT PULL] Block fixes for 6.19-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fix for the block area that should go into this kernel release. This
pull request contains:

- NVMe pull request via Keith
	- Device quirk to disable faulty temperature (Ilikara)
	- TCP target null pointer fix from bad host protocol usage
	  (Shivam)
	- Add apple,t8103-nvme-ans2 as a compatible apple controller
	  (Janne)
	- FC tagset leak fix (Chaitanya)
	- TCP socket deadlock fix (Hannes)
	- Target name buffer overrun fix (Shin'ichiro)

- Fix for an underflow for rnbd during device unmap

- Zero the non-PI part of the auto integrity buffer

- Fix for a configfs memory leak in the null block driver

Please pull!


The following changes since commit f0d385f6689f37a2828c686fb279121df006b4cb:

  ublk: fix use-after-free in ublk_partition_scan_work (2026-01-09 06:55:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260116

for you to fetch changes up to ec19ed2b3e2af8ec5380400cdee9cb6560144506:

  rnbd-clt: fix refcount underflow in device unmap path (2026-01-15 07:22:09 -0700)

----------------------------------------------------------------
block-6.19-20260116

----------------------------------------------------------------
Caleb Sander Mateos (1):
      block: zero non-PI portion of auto integrity buffer

Chaitanya Kulkarni (2):
      nvme-fc: release admin tagset if init fails
      rnbd-clt: fix refcount underflow in device unmap path

Hannes Reinecke (1):
      nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()

Ilikara Zheng (1):
      nvme-pci: disable secondary temp for Wodposit WPBSNM8

Janne Grunau (1):
      nvme-apple: add "apple,t8103-nvme-ans2" as compatible

Jens Axboe (1):
      Merge tag 'nvme-6.19-2026-01-14' of git://git.infradead.org/nvme into block-6.19

Nilay Shroff (2):
      null_blk: fix kmemleak by releasing references to fault configfs items
      nvme: fix PCIe subsystem reset controller state transition

Shin'ichiro Kawasaki (1):
      nvmet: do not copy beyond sybsysnqn string length

Shivam Kumar (1):
      nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_build_pdu_iovec

 block/bio-integrity-auto.c     |  2 +-
 drivers/block/null_blk/main.c  | 12 +++++++++++-
 drivers/block/rnbd/rnbd-clt.c  |  1 -
 drivers/nvme/host/apple.c      |  1 +
 drivers/nvme/host/fc.c         |  2 ++
 drivers/nvme/host/pci.c        |  7 ++++++-
 drivers/nvme/target/passthru.c |  2 +-
 drivers/nvme/target/tcp.c      | 21 ++++++++++++++++-----
 8 files changed, 38 insertions(+), 10 deletions(-)

-- 
Jens Axboe

