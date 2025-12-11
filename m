Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEE173
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765493206; cv=none; b=Hmwq+/MidPCWl5Y/pMVLt51LbNJJOFaXOXurwWOEFO7DitjMY5KPoJvb11vfnXTP2V0qGoCdXIlKDhPMQRTEGw8quFDZ3eQvjbtRxdPL0pz681C6GFEZqS7sKlJSnyYl0wrxMAeJX5GY74RgdvwCMMqCnPrjseMR4u2/1beiL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765493206; c=relaxed/simple;
	bh=qSqxTk8vw2RQFrrQ+HTmy7NNvBBKQaqKf3EuVTvhqMk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mXQaSZawCuSs6zXRYbxs7VZ2PO8QeGSP5h+OKkFaETDpt+zieAz3mUK8XqRlWgS8PS/t6N91oFn3XJ6CTR7GBWUput8fPSHcKWvfci1ACjFLxiL2hB2QCkw7B4IfbN0VnkgKWBzduDE6iZgQ87t6ULOut15ekO1gM7maLciUMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JJY5nJqa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JJY5nJqa"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c03e8ac1da3so513576a12.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765493203; x=1766098003; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+pP+Ii/tVSE6WIs3V1a2M7kIOlFoqJay+NwL8jb984=;
        b=JJY5nJqaEuRN9l5tag3Gd3f+Tn4mOr1qmZex5TmKly93hO2ZaWYEQPtnBP81SNdiJi
         K6e4bFBjbbim2DutrCXcuiQ4J3AuXx63jzW/rrXodafZ+pQNJ5LvIteJcZPG9sM/goSN
         HFHTJyVruBQBqgsEsyiYV8Ad0ZI1dbe5Xe8tFNwLZsSluEl3kkqGeDkW2NxNY6qDpvQ/
         LSNuTahq38xYEUpbzt8fz04HtIioeRyuqtebkMwDgLuKYvVpmM4yqYY8uuBUm7sOxxar
         oDgNAl33AkIulC+s3JejBZ5DlLgDpHSbuQ9A1TAHisLTdGP5l0aJmUP+GdUIwtWshn/J
         7LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765493203; x=1766098003;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+pP+Ii/tVSE6WIs3V1a2M7kIOlFoqJay+NwL8jb984=;
        b=t3fU2TAgre5AMfV/+YsReorDHDZJ6rEmydD8ixXqDtuHRo/2AVYjBqBz0KN4l7gaLj
         UIHQBOEoZiGDQ6v1UparbQpEu2UZAAbzIM6RQxix/KSHOIlqlU+7IHdaTBy6COK1EGcY
         wWMguv0fAA6vQh28Di87Y/P3KnrSp1a9jqxEXuFf13G/YRrud3BqfUN8bKimjZBU5ZzZ
         8p44sQvXLGoJCX8sjQJZkfLTC6xVzIhdTpj2pJdlsULehNEm6tdjvUIC0EitjgtMbA0E
         qP7zfMw6PIs8eoTY247b13xeNPtiUsdcUDJ4uQl3Ya5XClXyPbEtbbsSHHpPDBiRf/XD
         gU7g==
X-Gm-Message-State: AOJu0YzDmgdx5YqhHpkN6RXNAmIiilkYv/ePyR4xjkUyle/deVs51e+G
	d8rjY+TyvKgZqnl6lUt9Xy5+TYwUyrB0FPacyQRwjqdUdZInouaJTQ6VpQBSs5rMbbEYdl68fGO
	+vkMS5+L91Q==
X-Gm-Gg: AY/fxX7lf9kLZIkR4nZ7F56wdiAX2YTwmqzljep8kiBpOHMLllDWV0IKgFpZELiR52+
	fOTUlWgkgrZyl7fURLXUO2keXB6dXUARJ2M/l1M6SzGD3qlMvnZ9I/apbKreyD/1KPZhj6MyBxx
	EBdIzF+ROhXfbbpH3V5fIQflfJBAmkjfEyZ3RUbFyrCX0uRQ9FWbTdKtb9DDawypaXE28W1YYRR
	u2KvwAKFxg2jJgG4g0FhaYbXRppxk/QKy35HwZ2lvazA5S/G+5cdiIAI+I/eVC44R1O9Zd2WCHK
	LD3h9eeBvuScvFzr7bMbbJA3vZE8NmBeVqGyJHqLl54BNaPQ1XAIiL3dhpbpQRGibAomLcf8LgT
	Eg3vRZu4V9CM3T1TrPfAWzyd6TpdQ4T7DqD46cygfNrUpgs4Iw26pOMmQ+2HkG11eYz5j6TGj+I
	TzrUTG8MVTm+7WPD6bbskTT+nNBC800om1293qrBkI2/Yj+yNFOw==
X-Google-Smtp-Source: AGHT+IE1pii6EcDxSobAERQ5GYMOL/kzNeLezvGEsxOs9s/+6eVPYgePh9sqc7ba2SKBNcgje9jTaw==
X-Received: by 2002:a05:7301:1625:b0:2a4:4e38:9a39 with SMTP id 5a478bee46e88-2ac3027e061mr146934eec.34.1765493203152;
        Thu, 11 Dec 2025 14:46:43 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac1923a917sm8536462eec.6.2025.12.11.14.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 14:46:42 -0800 (PST)
Message-ID: <3d7381eb-9258-4743-86b3-5f4cfdab06d7@kernel.dk>
Date: Thu, 11 Dec 2025 15:45:32 -0700
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
Subject: [GIT PULL] Final block fixes for 6.19-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Linus,

A bit of a mixed bag in this pull request, but a few important fixes
that should go in - hence let's flush these changes out before -rc1.
This pull request contains:

- Always initialize DMA state, fixing a potentially nasty issue on the
  block side.

- btrfs zoned write fix with cached zone reports.

- Fix corruption issues in bcache with chained bio's, and further make
  it clear that the chained IO handler is simply a marker, it's not code
  meant to be executed.

- Kill old code dealing with synchronous IO polling in the block layer,
  that has been dead for a long time. Only async polling is supported
  these days.

- Fix a lockdep issue in tag_set management, moving it to RCU.

- Fix an issue with ublks bio_vec iteration.

- Don't unconditionally enforce blocking issue of ublk control commands,
  allow some of them with non-blocking issue as they do not block.

Please pull!


The following changes since commit 0f45353dd48037af61f70df3468d25ca46afe909:

  Merge tag 'nvme-6.19-2025-12-04' of git://git.infradead.org/nvme into block-6.19 (2025-12-04 20:58:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-6.19-20251211

for you to fetch changes up to a0750fae73c55112ea11a4867bee40f11e679405:

  blk-mq-dma: always initialize dma state (2025-12-10 13:41:11 -0700)

----------------------------------------------------------------
block-6.19-20251211

----------------------------------------------------------------
Caleb Sander Mateos (2):
      ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue
      ublk: don't mutate struct bio_vec in iteration

Fengnan Chang (1):
      blk-mq: delete task running check in blk_hctx_poll()

Johannes Thumshirn (1):
      block: fix cached zone reports on devices with native zone append

Keith Busch (1):
      blk-mq-dma: always initialize dma state

Mohamed Khalfella (1):
      block: Use RCU in blk_mq_[un]quiesce_tagset() instead of set->tag_list_lock

Shida Zhang (2):
      bcache: fix improper use of bi_end_io
      block: prohibit calls to bio_chain_endio

 block/bio.c                 |  6 +++++-
 block/blk-mq-dma.c          |  1 +
 block/blk-mq.c              | 29 ++++++++++-------------------
 block/blk-zoned.c           |  2 +-
 drivers/block/ublk_drv.c    | 28 +++++++++++++++++++++-------
 drivers/md/bcache/request.c |  6 +++---
 6 files changed, 41 insertions(+), 31 deletions(-)

-- 
Jens Axboe

