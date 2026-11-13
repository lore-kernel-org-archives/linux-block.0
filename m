Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574454;
	b=Wu10gJmawvhQfbEzQo5fvuUDcsdImsEYpkDqcomlA2GkxoUoG8aIm4r5lPNhdFIsU68V
	 39Yx+Or8ueNzBkLt/pL7lHLAIQv3m/xNOgB8Q9XaLcYKsiI48o3I48NSOZ2XSbfc/xxaz
	 JPAK/cfx8M9D0NIaLo7KN8T7B076/CK2V2oN7J1xn5lCTlipZuwPxgp+l7ZtyP5wWeE3u
	 cBODXa8+N1kS6NZ6olb1stegZarT07NJxCpwzKsjytrxTLLSRrZerxYA3rJk5VT19IJd2
	 hmqQX0jurmdE0Ui+ziEKV6fR29YW/mv2ADeOvoobjnFQJPUoTawwnS6J09BpkI1PqIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=b+1VJnlfxsjl88kTV49DQ6+3IXyjbC/a8ZL2/u6nNYQ=;
	b=q4XkkwUvV21R0J369dZ8KOHzZ7mD7cF4e0XBdST8IOW63qtz/qLt8jte59YnSkCyGmCh
	 V9koNyolQMNWmMj4IDXCNreXvbxrsbJI/Z//GNullm3zeBtV1SO+Vv2XEKcK8bEedKtTZ
	 ZzAhFk+eTsFOyOyA7vORBy+vMDGD+o2C4zXyw9OnDjEkHQpJaYITKF6PBiMHkvf9yaIH5
	 bHVNMQF9BxZoAYGTL6XuAu3tuvrVzUHTyF7bBJDldtIfspwI+rl4zDARx9egdEQz0OJxh
	 dca1D25SFcwBgW+uBywBa+pmaD0wuBD2JJ7DzkRRzM5ReZ2CEwlx2i3FK9R1e0m5/dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RcQm8mm9;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D72606A323
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 12:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5D72606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RcQm8mm9
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso2567414c88.0
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 04:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794574453; x=1795179253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b+1VJnlfxsjl88kTV49DQ6+3IXyjbC/a8ZL2/u6nNYQ=;
        b=RcQm8mm9uBGBNQ+1m/unj2F6MN1XNckgBcZBj7Hsa+StkbqAKCnU9Hb1oYUZHzbs7R
         N4U7qpfqqLSlw+dWDdh9DqGDFESu1ViDTS2TKa4sGXhtJfH+V+QlJfLu77qZT4GqpheG
         60VveE/gYsayLwV56S/5u6pNToV/ESBV1nFDIt6HxbeUPf8mkcWeRQm2ZO3pRfjLTGkg
         DekNVQ0K1ugaCYyg0XtwHJxa9WSfDaDRiy6wklIxRbEWvtYUlWsL/aKDlIYLJ7KgNOP7
         9+PiMfdqCndpGjeNPTRXPJWSQRVhuOCbYRC7ce6/Ptwv51PtgTe3Mn1J3QTD0OT+tU8/
         lZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574453; x=1795179253;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+1VJnlfxsjl88kTV49DQ6+3IXyjbC/a8ZL2/u6nNYQ=;
        b=mxUcGg1+ePZ3V6K3RvF59UQyYIovVGyjQQ9OZx2QfH25Kw9FVQ/N2awjUlBQ2HbBY5
         1jol5Ro5aVE/UHWZRoxM3Ra/8OtAo3SQupNufPzf0XmQmTpihl4JVG+uPxDJ24dEBVAB
         dnMPBFL539FChYvLzNPF+sUjUkys6NMkuhFY/tNs0CyVyUmUEVNpUa8rl5w283gLDyGX
         gBCAaTHWcS5qH8tA9xFb/dp/EeMSqKcjdq2WDhipZvt2QsDvIa0oXsEClmmHGCRhvUVa
         zNzIa2SoJF7Vohae8a98uVNkiVhHHEGOuv9cFyTwm0yDgfa/j66nqlZUMpHdE+kQcAxd
         Gj2g==
X-Gm-Message-State: APuU4Z8jWkBviPFHJPFnyTiv6D0ul54T3JWXztKQbMQkuoORxs1Oan1r
	tskGiKObY55nPbgZi7ye2mrPmMjfBWpY+DbvIy6LjJsmezYJQTyKY/nC4D0m7w62dicjXCwcpK9
	2LJ1rgU0=
X-Gm-Gg: AYBFou1qvSny6n/gYHlW25YNPUozkrgDv4jJuvsu57ZlkesP4JZCw3jzaew3BUzhjzb
	kd2WP+SsA2i8P9IgJQ3f0+QestHahkQyn14RUEilcfco9H8/bEfBBJA0Uk2bk/J85C23baVnXga
	H8sRcS1Z1trwVFrm7ptq5xMC9stUHN9hhhdnzj+qClKIWdbj6OzonI49Pp/HH1iu9FsOu68KqSy
	0H6/pIscRdvU6qS+bzePnUQ9RImDVy3U6S4dDbC4Z2g7UOb8QaXYs/L+k4T/MvqjzOEoaIPiyye
	4HE/4Q8Dk1YGU80jSLNcfT/yZ0MkGxH0HZnaHd4GslTDeEWx0IwAnlm/UzwnRmXXEwkdiIC3el5
	3lM6DSqU/gAk2P/UZDILFJ9fWSWoPeVrNvEap9w12VDtjNZLKXPuzSuCrABGJvcz7a1g1JB8hMy
	kgDe4l34HR+/sPywQFrZCl3LHbdGz4HI/5eSl6hT87AJn3Egmq3CzO3QTgWgd+Ls8yMyewYAu/o
	JqwGS55appRjOldeq5+pPPRBXh1XX2Dx5qpqfxnDsgr73SAnyReJ+nUnjOtOFOXtNBTwLr35fiU
	J0TPpeNY1tKd/U4R7wbkMzgCoZ3mUZW6W9Ypk1gntcP8RQ2jyRf+nlx3BedroPS97v+jC02itvm
	ojxN9aHe8MKxkUuAKvsBNoM4Jl9EpCOGz8Q==
X-Received: by 2002:a05:701b:4648:b0:19b:1202:77f8 with SMTP id a92af1059eb24-1b503192303mr2479316c88.32.1794574452807;
        Fri, 13 Nov 2026 04:54:12 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm7692474c88.14.2026.11.13.04.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 04:54:12 -0800 (PST)
Message-ID: <0c3fd1a8-c530-44c9-9dd0-3dec5a6dea11@kernel.dk>
Date: Fri, 13 Nov 2026 05:54:11 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block fixes for 7.4-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

block fixes for this week. This pull request contains:

- ublk fixes: don't publish a new device in the idr until it's fully
  set up, and don't hold ublk_ctl_mutex across device removal, as a
  stuck filesystem on one device otherwise blocked ADD_DEV and DEL_DEV
  for every other ublk device.

- s390/dasd fixes: re-initialize the RCD buffer magic before every
  request start, fix a wrong free and refcount leak in the check_tcw
  error path, don't trust the userspace-supplied result field in the
  format check, and a typo fix.

Please pull!


The following changes since commit 28f7d31c2aeb350df9a0116093fade0a840fb4ce:

  Merge tag 'nvme-7.4-2026-11-05' of git://git.infradead.org/nvme into block-7.4 (2026-11-05 13:47:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux tags/block-7.4-20261112

for you to fetch changes up to 7cc2dda4f7aaf596c1796184649007151ff98f8d:

  s390/dasd: Don't trust userspace-supplied result field in format check (2026-11-12 09:18:12 -0700)

----------------------------------------------------------------
block-7.4-20261112

----------------------------------------------------------------
Mark Korenberg (2):
      ublk: publish a new device by its id only once it is set up
      ublk: don't take ublk_ctl_mutex in DEL_DEV

Stefan Haberland (4):
      s390/dasd: Fix typo 'immediatly' -> 'immediately'
      s390/dasd: Re-initialize RCD buffer with "V1.0" before every start
      s390/dasd: Fix wrong free and refcount leak in build_check_tcw error path
      s390/dasd: Don't trust userspace-supplied result field in format check

 drivers/block/ublk_drv.c        | 66 ++++++++++++++++++-------------
 drivers/s390/block/dasd.c       |  5 ++-
 drivers/s390/block/dasd_alias.c |  2 +-
 drivers/s390/block/dasd_eckd.c  | 69 +++++++++++++--------------------
 drivers/s390/block/dasd_int.h   | 17 +++++++-
 drivers/s390/block/dasd_ioctl.c |  4 +-
 6 files changed, 90 insertions(+), 73 deletions(-)

-- 
Jens Axboe

