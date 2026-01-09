Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EE2D9784
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984440; cv=none; b=rWWCSWFXdnUFqiUq40Qd/ongmCihEdQFslDn6wgO4/LdtlXXWhM21zpfl+tA3iIlTkSu3YjL5foIqZWOo5owjUnYf7cGxD6snhUV2sqKim6H73zqpVx64VKZnwd22hlBOmvCTX5BepJ/LsSaWmal5tvNklprskg2HHy57hhPjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984440; c=relaxed/simple;
	bh=jMBkoUpOCVWuIGOrgD2x2jHCpV+rJ7YjAJlWo5HRnT4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E79txsOe2Nzi1Mq/ROQQjMn1qRPe8dTrD/cmW/Girl1NQ1cOkl0FbXpHKyaRnDUagbnhUdljETYacvgQ2/vZUmjFM1k2jXFWvMYjRhzxDg0q3x/ZEdOj4s/tYRBWvAf+ueakdHk6/I4i9WoYeLzmkP3NgotLLS11L6d9flwnBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LHcZIOpn; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LHcZIOpn"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4557f0e5e60so2956541b6e.3
        for <linux-block@vger.kernel.org>; Fri, 09 Jan 2026 10:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767984437; x=1768589237; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfFY00zeV8Pe1hyFI46VV2bA6HkuDjfmTO/0MHrC22k=;
        b=LHcZIOpnaF0H1b8fv0kVLJintdls/KXlvld7N7+yYMircKTjN+yvAAbD/3RDwxyX4V
         WRH+CbYtWpysnokaUaX5Ve8M8jo6292oi01N8VuPZM7EXzGhfC5rvgSB1ymzvbmWor27
         gLXt6yH8dcEd/y0Z/3Vf3JHpQ6bQksz/p9h5/fsNvt463+BukpEfgvHUDsVvaOJSLLcM
         g/iYI4gL1zAbpGMNvTV5taXJgcU0OEg86fwbaNuAn6YFWmp5cuGayRaL8ECX4vgPes+F
         O9///HNVSxuQz1WZV0NBjvbAYSAMRy4soga0OzIEnjlsSGIa0EGvPXW7BybBy8zi9bsJ
         qRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984437; x=1768589237;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfFY00zeV8Pe1hyFI46VV2bA6HkuDjfmTO/0MHrC22k=;
        b=WYcPGHAvAonajLTSSMX07zHK8Yh6EKEPiY85fFc3FaRoJgo1FYk4xTs54eQwYicBvk
         7ABBdwQY7ywJLfqOg9+xtm1n0oDnuLN0zxUmcZHj7Zp5iej9N629M6x9o8QMHdpokDSL
         8kHKdW9OzSHtsjrSIRXdefiKSbst0Np+fOJZmOfy7FhfYK/RUO8f0kYweF150wFV59Ax
         eObBDB3ScCv/3awd/DZiQf1QQslfW5BxJLHzHy5gcR2t3epxYYJcIxf4VnZr5lq/2wNw
         UpNxYUQ9cAWtj0juR7DdTOz4jGY0N9lt/Xv1R3ON+LiBuf0Psl0nt1lST0QIJHFIiPvM
         1g2g==
X-Gm-Message-State: AOJu0YzifQRYRuIRyJntgCFUNoWWJZoAbXdxD/ExbIGlQWjqDhlRrwNJ
	MyXgN34sowtNfiyO5VbzldVQy6AvKoOLPIZa99hsptIKYTC6ZU2GUmXURi24EQNC5K9AjzoIqsn
	JgZwZ
X-Gm-Gg: AY/fxX68eS7GuN0omlSUKZIqYZdgF83B6r+Pgu9h2yXG20JjAAcawqKjYHcbgrVPhdb
	+VTRRqa6Pk5gj2w1DMy0HkoGx13MEizR5b68xo5Fw0/XeFRdoruiAfnuG8JcNjnmUq7IR1pSCPv
	GZTFTxN91fPxGEt2PzzqKE0hTAI8VPjqgm24W6hGj562GfhOj6IC2FfJ7vwVQskpQofeZ+6KAYg
	uZ/ZJd/s3mtue3kGi+Ch9HCXDN5vf29qYOp3ptszJbbBDGrFtUV/VHBHl/GOOath2GgWl6Q6PMO
	KCNgHP35rEaGEc0SnB6jrtYK0U5QTulm4keemyTXUT30Od9yWqZ/i1S5owRI8jK/uN3fWML//K9
	qqY+eYo2ecLibpf8iy6sHvDEjOLR1oFNPCTxYRpCap7TzPckoLbBuX0g34EOi9dB0aKzqMR2R+0
	VxEBgtmO0=
X-Google-Smtp-Source: AGHT+IEKUd3ETQYJiMNjOltUjSfoo/j1691QBytUQtcOwoFvYkYvqhVb0rwmpBoY8rceSW+0Yf+5yQ==
X-Received: by 2002:a05:6808:16a2:b0:459:f13f:1a51 with SMTP id 5614622812f47-45a6bccfae4mr5772545b6e.5.1767984436930;
        Fri, 09 Jan 2026 10:47:16 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a8c6b3fdfsm1117135b6e.17.2026.01.09.10.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 10:47:16 -0800 (PST)
Message-ID: <a4c67857-e36a-46f2-9912-bf2128392c52@kernel.dk>
Date: Fri, 9 Jan 2026 11:47:15 -0700
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
Subject: [GIT PULL] Block fixes for 6.19-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few fixes that should go into block for the 6.19-rc5 kernel release.
This pull request contains:

- Kill unlikely checks for blk-rq-qos. These checks are really
  all-or-nothing, either the branch is taken all the time, or it's not.
  Depending on the configuration, either one of those cases may be true.
  Just remove the annotation.

- Fix for merging bios with different app tags set.

- Fix for a recently introduced slowdown due to RCU synchronization.

- Fix for a status change on loop while it's in use, and then a later
  fix for that fix.

- Fix for the async partition scanning in ublk.

Please pull!


The following changes since commit 69153e8b97ebe2afc0dd101767a9805130305500:

  block, bfq: update outdated comment (2026-01-01 08:57:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20260109

for you to fetch changes up to f0d385f6689f37a2828c686fb279121df006b4cb:

  ublk: fix use-after-free in ublk_partition_scan_work (2026-01-09 06:55:30 -0700)

----------------------------------------------------------------
block-6.19-20260109

----------------------------------------------------------------
Breno Leitao (1):
      blk-rq-qos: Remove unlikely() hints from QoS checks

Caleb Sander Mateos (1):
      block: don't merge bios with different app_tags

Mikulas Patocka (1):
      blk-mq: avoid stall during boot due to synchronize_rcu_expedited

Ming Lei (1):
      ublk: fix use-after-free in ublk_partition_scan_work

Raphael Pinsonneault-Thibeault (1):
      loop: don't change loop device under exclusive opener in loop_set_status

Tetsuo Handa (1):
      loop: add missing bd_abort_claiming in loop_set_status

 block/blk-integrity.c    | 23 ++++++++++++++++++-----
 block/blk-mq.c           |  3 +--
 block/blk-rq-qos.h       | 25 +++++++++----------------
 drivers/block/loop.c     | 45 +++++++++++++++++++++++++++++++++------------
 drivers/block/ublk_drv.c | 37 ++++++++++++++++++++++---------------
 5 files changed, 83 insertions(+), 50 deletions(-)

-- 
Jens Axboe

