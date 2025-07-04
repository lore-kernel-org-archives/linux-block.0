Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4B33E1
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643263; cv=none; b=m8v7spFcvmQTyJUt/DZeymUgzmVkSDFLiN1qFURrsequ1TfXvKUisbdIW8tQiBdCAVbuySIBQGIDXF1Dv461fg6foHVIJsib2xkQwAXEgMeUT/1KoCHLP23c5bafwk76cDQF7zO7VnLT57SP3kH1jQo8S2I0C0GrWWVPs70+KwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643263; c=relaxed/simple;
	bh=lxsXsG7h/UHCxzG7awBAPAsMt2frmmQcaLQkKM4tVZo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Gx+vnmTSg/gDm654z1TyW7BCaYhT4dJJcLhhAveyJmLKML8VwgMUsaLAyIimtkhrlvAeeS2oTxeHeWrmEJsCKD3H5wLgi2CXFcDTPQf4DmFBn3Oqao86iA2OfM70/GBGvO4c/Mh8Mu0kvOfPLfwUVo7vcX4OOn3DV1QVmFt+3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mqbDLZaA; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mqbDLZaA"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-87694a21617so28376839f.1
        for <linux-block@vger.kernel.org>; Fri, 04 Jul 2025 08:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751643259; x=1752248059; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkmFnOVLTiRvsjSsoKZdQ0LwtOTZ4NIebQUqL+wW+cw=;
        b=mqbDLZaAUnvXnztS8VR0zpun2GStQdUBvjaFYHIewLhfhp/kijG97G3RLpUf0RuSbp
         A2vxVv7G5HGhMpSlNGDmdQhinaVJmLUcD+ZKGu2v2FiJYn43LF5lQQ9B6ROz5SR5ioZL
         4uHx9qdXbsh3b77nZ6T4bRN4tSjCUmLc0KH5N0sDTYWdpkEwA6HF5nn9TfDw+wrRzRDl
         RBPsQI4P10/lKF8zcurTV4aLnU/7g9w3aFv+BjK0kVQnh7RJH0RCmJMeHA6WCoopBO8w
         RxaQmz6oYvkWJIL0ySTWpWvToYaqYw91E1RgPvwpio/K/ag5JTcy0wPca9y/ro/CP5I/
         ISrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751643259; x=1752248059;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mkmFnOVLTiRvsjSsoKZdQ0LwtOTZ4NIebQUqL+wW+cw=;
        b=SrZg1VOUWW1OgVoCJQ5uNoTOC+xM3OmU+UhLhTFwSFabl2ZjjdFJnq8oLbfUtdERXW
         3fFtfA/Wmtgb+9CDuFuPpydnjsrdS5c+It0Wca72JGS3hSoUbra4GzPQryO1nsA2VeDd
         gcIl55/udMDTWzU6M1TZqvrMLHWDgl2VdawzCBl/C+UZ1vSHpRB3TEkaivKHv4rAFDpm
         x5eSmUYwSEbnBy2YG048UMpCnTtGWuCBb8vyk7+z1BvMTdUhNGdUqQM0tHnSAATIjhqE
         V6TjNMQa1mKtQcmrSB5RkWzgKYVW162SVtpKJ45n0FwyUEuZ/MJfiUQwhONhsv8dBfkX
         Kdew==
X-Gm-Message-State: AOJu0YxFLRJMAbNF9QN0KSYbiyTrOhYBnSiydgGtA9CFJu8QKj7sEIxw
	4tI5TXDOtw4iRPlaN1+ZjCis67DtylfI+LHQGQPjObV/tp6FSrgv5mt0tlB+2efF9YfbukQgBVt
	J0DRp
X-Gm-Gg: ASbGnct2ze1XqknSSrTg1Z5Wxbyjy7c9qJ9D0jNUg59hBIqRDXTV8Qh6ctTt3abkJUX
	sRAffYbHv2B4EyZyzcdbZJssX/Xv6mvXaCe/l719m9mYsjZyYdYRdBs7E1FYomqWV6sSAJcVpsn
	d6gNoA617gMrssU0Scum7MNdSsnAloQT68pyxoD0O21N2y49El9eElIrkbJXdQoNkys6CCbAkdP
	tLTRLuINIq4qAdRDefmgkt+xdrqzMfIE0dN/0r5rderM0PKyWXlF+HMn9GD12sMhhnDZaNARYFL
	Gj/GnITYwfYsF00Qhjs4sCO3eW9qUP52S+EdXbg8jfKkLM9NsEdftMWc96Q=
X-Google-Smtp-Source: AGHT+IFt+d7Yr2Z0spSs6m+rPLhOVRmOpUlr4XYpH+aPaBb5+2wzeBjQfa97qDD7Y67t+rcuEe8/rw==
X-Received: by 2002:a05:6602:820e:b0:876:737:85da with SMTP id ca18e2360f4ac-876e089488fmr201688639f.0.1751643259086;
        Fri, 04 Jul 2025 08:34:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b5c0f7f5sm431586173.106.2025.07.04.08.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 08:34:18 -0700 (PDT)
Message-ID: <67e6b4d7-0eaf-410b-94c8-a9ee2cb09de6@kernel.dk>
Date: Fri, 4 Jul 2025 09:34:17 -0600
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
Subject: [GIT PULL] Block fixes for 6.16-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.16 kernel release. This
pull request contains:

- NVMe fixes via Christoph
	- fix incorrect cdw15 value in passthru error logging
	  (Alok Tiwari)
	- fix memory leak of bio integrity in nvmet (Dmitry Bogdanov)
	- refresh visible attrs after being checked (Eugen Hristev)
	- fix suspicious RCU usage warning in the multipath code
	  (Geliang Tang)
	- correctly account for namespace head reference counter
	  (Nilay Shroff)

- Fix for a regression introduced in ublk in this cycle, where it would
  attempt to queue a canceled request.

- brd RCU sleeping fix, also introduced in this cycle. Bare bones fix,
  should be improved upon for the next release.

Please pull!


The following changes since commit c007062188d8e402c294117db53a24b2bed2b83f:

  block: fix false warning in bdev_count_inflight_rw() (2025-06-26 07:34:11 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250704

for you to fetch changes up to 75ef7b8d44c30a76cfbe42dde9413d43055a00a7:

  Merge tag 'nvme-6.16-2025-07-03' of git://git.infradead.org/nvme into block-6.16 (2025-07-03 09:42:07 -0600)

----------------------------------------------------------------
block-6.16-20250704

----------------------------------------------------------------
Alok Tiwari (1):
      nvme: Fix incorrect cdw15 value in passthru error logging

Dmitry Bogdanov (1):
      nvmet: fix memory leak of bio integrity

Eugen Hristev (1):
      nvme-pci: refresh visible attrs after being checked

Geliang Tang (1):
      nvme-multipath: fix suspicious RCU usage warning

Jens Axboe (1):
      Merge tag 'nvme-6.16-2025-07-03' of git://git.infradead.org/nvme into block-6.16

Ming Lei (1):
      ublk: don't queue request if the associated uring_cmd is canceled

Nilay Shroff (1):
      nvme: correctly account for namespace head reference counter

Yu Kuai (1):
      brd: fix sleeping function called from invalid context in brd_insert_page()

 drivers/block/brd.c           |  6 ++++--
 drivers/block/ublk_drv.c      | 11 ++++++-----
 drivers/nvme/host/core.c      | 18 ++++++++++++++++--
 drivers/nvme/host/multipath.c |  8 ++++++--
 drivers/nvme/host/pci.c       |  6 ++++--
 drivers/nvme/target/nvmet.h   |  2 ++
 6 files changed, 38 insertions(+), 13 deletions(-)

-- 
Jens Axboe

