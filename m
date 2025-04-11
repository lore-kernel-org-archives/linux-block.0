Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1351FA85A
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384056; cv=none; b=kZGtEqi5DVixmf3sDDT3A8TnXLBuH4bv2Np/q/iGVrdrp23zh4d2Zl4hnAdn2IB6B16/4I2XauaU3rRrj4IdElrF6qwqX1ygL5bSAG6q93nkcmuknKaBgbpfrK/ob3r76Vxg6Hsw74xtpLAHIZYA3CelJsNV0reu4TVhwtt/AU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384056; c=relaxed/simple;
	bh=GrUAYb1t15pw2oc3lNLkj2qL1Q8m0DUX54WRC+Eqev4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eYv6kR28GKvsWx5uxAOHN2IPrkbf8DOOcz+Hc4WP2cIbr+dkz73wmPAmFkZ43bqxDWd1m+QIYfSudrwo8VkTQzthnAEMEReocaykPHJJuamJKlEN6Upatx33dQP1NQpOWtp2sAMr4dHRSU2INVAr4pM2hl1rMqwDLyE2VLoEXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=k6b+TUBO; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="k6b+TUBO"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d45875d440so9641195ab.0
        for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744384053; x=1744988853; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBfkfoq/pvt7aKpd/xo7r0z1ZjJBAli5ujUD2cyV2uU=;
        b=k6b+TUBOQ4pF6WcxC4hi0RJa2JDCb9w7nHhVwhqf0KaAGxcDsG4ZJh+2KM7GZHNmIN
         JXqT1Qq0gCHXxbkq2Z1H9dCTaJwXG6LK5XKFx1+Of2DNMB00t2ljXayuOUXCzN0YtqD9
         pqihjJb/Yb6QvlEoGAyD8OrzLPDpD72DMczNeVfU5C4+Vq8VESYoZFzENbRwDlJU5dwW
         b4CKhrdZx44pIyOiFChG7eYOMqZL9zbD9gUqOHvgI3h/nHMNIsWNfuD3PhveuZk4dPO5
         vgmoUUcT6P/6Wc+8JJ2n/+x3zecJd3oDG8/oKkHyWLXJpQ+pfZ3oIhQZbi9wVP00cu/d
         dlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744384053; x=1744988853;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BBfkfoq/pvt7aKpd/xo7r0z1ZjJBAli5ujUD2cyV2uU=;
        b=GZx/8Oo2jw9Bwx7Q1Xp02Cy05GVtQ3qzvKvLRTwr8vOc+Q/ZnjtPTU/rH8O3VLYxMt
         lFjRiv6xhC++RLzht0YP6yC49Mjf7dsCtVYCdTS5KPz5wapvWv0ln/T4XjxFAajnTszO
         hgSEEmZMBZpIexNyn7WjArx8ZhYby+gLwLx9xOQDQsoIIisN3tTsfFT7hVxgRlI9NEIs
         yuN50fLo9v0/Ou+9AyjphByvIZQglVBWgMmoEFxcRqdsSaHi8q2aIXDJT18aK2bqAKIk
         6wruhwWmocqkmBiFO1/NSBM3CTDmAnVY4AWzKNxZ1W+avEWiYmbEVt89PLwx3fGOHuNc
         i82g==
X-Gm-Message-State: AOJu0YyFe29WZJtzsLUG4+w6WF2BhfRZGwGiJ/+e85JrnL/WdnmteB6i
	j7NCawv8nZ5IvLGGevJd8vkwoYGHDN1WBimmx7dGF8SuiPNRwLBEJYYd/+emjNYkDFsY6OXELMW
	k
X-Gm-Gg: ASbGncsKky4+KR92vgAV9+7K+9Akkn0GmoqXpi7csFLdHlfUxGzXWME4VAHpf5XIgna
	92Ti2c9z6AHSq0f1dVgWwbCeKjg1ambYjBoyzJcmgJwhH+fyhkkwSKWhwjvDVTnpsoghjrfOHAd
	6negC+KceeCktbEaTX/h7+0rBgEFeLiVFPHMED/M/y9esgkBIllXcbGefGBy9DoC/BFLLUsxegc
	2yP/XWkMbfyDd3D/IKMLx5iEq7hzgYtmtVXmM31I+kKu2sCtr517fLnodRtH30DbOsPiSkvpcvc
	vhiP5l0pBUUSj89kuXR+t1Qs1Sfc/LxNUziL
X-Google-Smtp-Source: AGHT+IF8w2AgK4CsgflgzoSpJc7SJ7ZT4PNtiMJU+0bg11rW0E+QNRWsiHrQKSwpJLOcuarBCQm/gg==
X-Received: by 2002:a05:6e02:3804:b0:3d6:cb9b:cbd6 with SMTP id e9e14a558f8ab-3d7ec227bf0mr28992845ab.13.1744384052509;
        Fri, 11 Apr 2025 08:07:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dc5828cesm13263605ab.47.2025.04.11.08.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 08:07:31 -0700 (PDT)
Message-ID: <8d3e5d98-09b1-4274-af25-124c91342b7a@kernel.dk>
Date: Fri, 11 Apr 2025 09:07:31 -0600
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
Subject: [GIT PULL] 2nd set of block fixes for 6.15-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Apparently my internal clock was off, or perhaps it was just wishful
thinking, but I sent out block fixes yesterday as my brain assumed it
was Friday. Subsequently, that missed the NVMe fixes that should go into
this weeks release as well. Hence, here's a followup with those, and
another simple fix.

This pull request contains:

- NVMe pull request via Christoph
	- nvmet fc/fcloop refcounting fixes (Daniel Wagner)
	- fix missed namespace/ANA scans (Hannes Reinecke)
	- fix a use after free in the new TCP netns support
	  (Kuniyuki Iwashima)
	- fix a NULL instead of false review in multipath (Uday Shankar)

- Use strscpy() for null_blk disk name copy

Please pull!


The following changes since commit 843c6cec1af85f05971b7baf3704801895e77d76:

  ublk: pass ublksrv_ctrl_cmd * instead of io_uring_cmd * (2025-04-09 07:58:04 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250411

for you to fetch changes up to 3b607b75a345b1d808031bf1bb1038e4dac8d521:

  null_blk: Use strscpy() instead of strscpy_pad() in null_add_dev() (2025-04-11 07:10:46 -0600)

----------------------------------------------------------------
block-6.15-20250411

----------------------------------------------------------------
Daniel Wagner (8):
      nvmet-fcloop: swap list_add_tail arguments
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: put ref when assoc->del_work is already scheduled

Hannes Reinecke (2):
      nvme: requeue namespace scan on missed AENs
      nvme: re-read ANA log page after ns scan completes

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-04-10' of git://git.infradead.org/nvme into block-6.15

Kuniyuki Iwashima (1):
      nvme-tcp: fix use-after-free of netns by kernel TCP socket.

Thorsten Blum (1):
      null_blk: Use strscpy() instead of strscpy_pad() in null_add_dev()

Uday Shankar (1):
      nvme: multipath: fix return value of nvme_available_path

 drivers/block/null_blk/main.c |  2 +-
 drivers/nvme/host/core.c      |  9 ++++++
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/tcp.c       |  2 ++
 drivers/nvme/target/fc.c      | 60 ++++++++++++-----------------------
 drivers/nvme/target/fcloop.c  | 74 +++++++++++++++++++++++--------------------
 6 files changed, 73 insertions(+), 76 deletions(-)

-- 
Jens Axboe

