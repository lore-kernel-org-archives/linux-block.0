Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C463EFFDB
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691689; cv=pass; b=aHEn/s7IqLZIcsC7UAAHLL+jRlU7Vc+PSr1m+7P/J5swUKpNFLjrVR9mlLweRMCh3p0xyt621giATrMHrsvCSNo1SjLrrh70vd/FZIRdJYLp8jXkh0oYQHhOn99G0o6eQ3KX1hqDq4S5nz3hjrvyz8mbEiNx04mNAPqMB1Ozkf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691689; c=relaxed/simple;
	bh=jGPv/WJ2tQaD6NMijoNf02BtCjNltfB9PMOxlFyeMxk=;
	h=From:Mime-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=AnH4OStgRVqGaWFjPlQsTvWojN4bJ493GITPG37o3H4K9ElhIawQNx2xoMSlQscqZEUlyeEvTEu9d7bcgvHytNry7t5WPPlD58k1d6eA1MVbU4pmplQxfH4Fb2TdlKv96uc0QjdLywJWImvcbColSdmon0Ohztqby3oxxrxlSyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=L4Ykrb3Y; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="L4Ykrb3Y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso8107725ad.2
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 00:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786691684; cv=none;
        d=google.com; s=arc-20260327;
        b=PV+aHi46+M60UkG9e50CXiSMuCZ2fatJOkiSl1KBb+wM2ewAxFcbVXNcXs5nMn45aJ
         Pg1xjmvWdt1VA/+YMxYzTHG5sUEEggOXlzYx5NZBk+tlnjGhyKCv+1CFpwyFuCuEFoRr
         eGNB122oWn7az5CXzqkgJ5bKDNXxJTsUJPwO4A9CFnppuo6lxS9aH8i2sud59TOCoBC/
         XpADNs00+RIm1s82U5wcQ0oLJOIDPhpLGwxVmDLr5BCGylhC33JUpGTEBR8LZap2Huam
         VL5p4lS9CDhAOXKTzzNIFKZ6W6XDoLvj2RcRP0xKw/lo0G9CZSvmzITjxrIHUtfxVCuY
         OmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=43/cMfpbvC8YwPx22+mxX2743GMU5919wjNtAT0H+0s=;
        fh=rqVFvlbQIs/sUtkF1Ge4m5YJW/LtYnXdfWxWA8SO1HI=;
        b=WyQ/bzLVXSukoRm/LljFpKjVntZSxrGw980FCUXugHwxGRPeGH6F9NfZi7rBw0gbLv
         BmWFfczqeLn6yKfLe5AYcqb0lq5VeW6bKEvLdDJaHpvZ9byD8qVPLOXpP4X6ShFG8TFF
         aaEDezMoWed13FX3IT53eaY0fbzxCMRr6fOK97nB1GutQHjBUXoNaWX2xCAcI2WpDe4C
         vRGcaH9oRhDiHWImXIzBFeSPAwkwbazHICL29t6QVClFEME5yIuaue9Ct81fgblT0eWg
         ww1SwuGj9ERtTlBHANluQzrq0x5YtYZyeyetDRUi/HOOZMP0XMhIlSN4wA5nfUyQcNpk
         q2pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786691684; x=1787296484; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43/cMfpbvC8YwPx22+mxX2743GMU5919wjNtAT0H+0s=;
        b=L4Ykrb3Y0dryOiNDf5V2PSKx3Pm0yF6f/iVe/A3otyjf6LYFyASc7vfOM3gElg4oEF
         h/zXPep30C5OQjLO4y66FzfvjDC4XIn/VsLlGPeFADOJz+aj23Mk6F5Kt7yixBx1lmBR
         oH/UAvGkmN32plQWdv2ESG2epgGz19YOlpkmOh2f86njiVQV/UOw2Xx9YEtb6JeZ5Afp
         MkWMIX2tlmgvZtsICgiBVgSk7e0miKMqm+KdW4cw5vqr8G+FipMDaHN6rI3U6VC/Jjs/
         dz0DTeIP/qV9DoS5mCssKmae1cuKxteevkZxaHcH9WDAS7E9832y59hkjFxmSOZxg5rO
         fvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786691684; x=1787296484;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=43/cMfpbvC8YwPx22+mxX2743GMU5919wjNtAT0H+0s=;
        b=lmWkp+v9AyXJP9CfbG+btOGcKAo9xoWPR+htbMD3tV3nxpkoOnaniKqgLIlzaNzsn1
         WXaaYBE38x4P6pyUG1M+7f4XrGYBKTrwxNlXuXhwBPdL6dNReb2UYtUFW+qayek+uy67
         1fmibtckynnYxlkhkikMgkVR97MVPSfQgAE7Um/qlwRm85sESVwQgmfIQ0/Vumfd1/MC
         kSKjv6yoAkLsVpIqEYLpEAUeQTTTXtmzDciq+rJuiIJ5TJKCG7q1JkEsVHvM/UiKsXGG
         hPrAAuvu9WDNP7f9hhHBh/QrY/zqm06PnX/Xutcc/sqRC8Z2gNUGAykHbHYPlPIoJIal
         d1NQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro07xTYD34LDSkymQ2gki9+tf4BJAKSPH+ERWIPUhrLWgko9zioh2SA0EPP8diGrzqUn0xNSNF6hzXbUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOA+N70IAAxWPvwAV71Ocqx3xSNW261cVb0j7S9g+pG9A7vM1l
	OK/0mpzbTsV1zfNlkA1Wq+TRaR/BKqw8mhbQFNu80Vf+aP1kMiYhEDEWWPZ0z05e6hXX8NtLb5c
	8dccw8JX0zJMVkZCH0E5z6rpZuqefOFmSXXS7mVcSLQ==
X-Gm-Gg: AR+sD11dVaox6kPb13i6wuCp0r5Us0cRZeWT8fedsi2pwBBTsOCKGwWgNXquAhjl8ul
	O1k7zscW7bIgGOst25XIsy399V9xfLRYiCt4RbKs5JwLnXw1bFHYbwi8brQksfKGdzfNM8z7CgK
	izzmE7z+WttNSOixArOFf8mQFr9eDAqgFpiGG9gE8T5vujyY6p9AqDADfLl1x106IEFvK+rVC/U
	iisPo+CFLNQjSLzLy6l6Z3pMFn3TL/gGwjhaAkOn73iQ2rbpO8e7BEy9FF2ZsBt8J488KpaxXvy
	GyL4k9GrPnTa9oGP1HvLNPMOr56QACA/9vwAYrk3xZa/utEuPK4DbjNg
X-Received: by 2002:a17:902:da82:b0:2cc:777f:d67c with SMTP id
 d9443c01a7336-2d3b0d5ed01mr34760605ad.13.1786691684170; Fri, 14 Aug 2026
 00:14:44 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 00:14:42 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 00:14:42 -0700
From: Zhichao Huang <huangzhichao.1@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Zhichao Huang <huangzhichao.1@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Date: Fri, 14 Aug 2026 00:14:42 -0700
X-Gm-Features: AUfX_mxGxDt64_aoeUerAJgmbNobNSCaAYm7JFz25iPI9eQGDP5SmxkdvmEIqxk
Message-ID: <CANUnaiYZNj2n40HitJFJnzg1GSFg-VXZJSGEEHL5E7YqL3EHhA@mail.gmail.com>
Subject: [RFC] nbd: is the add_socket queue freeze needed on the initial
 (pre-start) connect path?
To: josef@toxicpanda.com
Cc: hch@lst.de, axboe@kernel.dk, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	huangzhichao.1@bytedance.com
Content-Type: text/plain; charset="UTF-8"

To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@lst.de>,
    Jens Axboe <axboe@kernel.dk>,
    Ming Lei <ming.lei@redhat.com>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org

Hi all,

This is a question / RFC, not a patch -- I'd like your opinion before
proposing anything, because the code in question is a deliberate,
stable-tagged UAF fix and I don't want to weaken it.

Background / motivation
-----------------------
We run large numbers of Firecracker microVMs whose block devices are
backed by NBD. On the VM-create hot path each microVM does an initial
NBD connect (netlink NBD_CMD_CONNECT), and we launch many of them
concurrently on the same many-core host. Profiling the create path
shows a large chunk of kernel time is spent in blk_mq_freeze_queue()
during the connect: each freeze waits for a full RCU grace period, which
on these many-core hosts we measure at roughly 35-50ms. Because several
connects run concurrently, these grace-period waits stack up and become
a visible tail-latency contributor on VM start.

One of the freezes on that path is in nbd_add_socket(), added by

  b98e762e3d71 ("nbd: freeze the queue while we're adding connections")

with the comment "We need to make sure we don't get any errant requests
while we're reallocating the ->socks array." I understand this freeze
fences the krealloc() of config->socks[] against a concurrent
nbd_queue_rq() -> nbd_handle_cmd(), which dereferences
config->socks[index] and config->num_connections -- i.e. it prevents a
use-after-free / out-of-bounds read, and it was Cc: stable. I am *not*
questioning that this is needed while the device is live.

Observation about the *initial* connect
----------------------------------------
On the initial connect, before the device is started (nbd->pid == 0),
nbd_add_socket() runs while:

  - capacity is still 0. set_capacity_and_notify() is only reached in
    nbd_set_size() after the "if (!nbd->pid) return 0;" early return,
    and on both the netlink and ioctl paths nbd_add_socket() runs
    strictly before nbd_start_device() sets nbd->pid; and

  - the queue advertises no write cache / discard / write-zeroes yet
    (those queue_limits features are also only set in the nbd->pid
    branch of nbd_set_size()).

Walking submit_bio_noacct() with capacity == 0 and no features, every
I/O op seems to be rejected before it can become a request that reaches
nbd_handle_cmd():

  - READ/WRITE with sectors: bio_check_eod() -> -EIO (maxsector == 0);
  - flush (REQ_PREFLUSH): !bdev_write_cache() path strips the flush and
    completes a zero-sector bio with BLK_STS_OK without dispatch;
  - DISCARD / WRITE_ZEROES / SECURE_ERASE / ZONE_*: not_supported since
    the corresponding limits are 0 / not set;
  - passthrough (DRV_IN/OUT): not_supported on the bio submit path, and
    nbd issues none itself.

The only theoretical gap I can see is a zero-length, non-flush data bio
(bio_check_eod() skips the check when nr_sectors == 0), but the VFS /
direct-IO layers don't actually submit zero-length data bios.

The question
------------
Given the above, is the nbd_add_socket() freeze effectively redundant on
the *initial*, pre-start (!nbd->pid) connect, where no I/O can reach the
driver? If so, would any of the following be acceptable, or is the
freeze intentionally kept unconditional for robustness?

  1) Skip the freeze only when (!nbd->pid && get_capacity(disk) == 0),
     falling back to the stock freeze otherwise (fail-shut);
  2) Some cheaper barrier than a full-queue-freeze RCU grace period for
     this "no I/O possible yet" case;
  3) Leave it as-is -- the "no I/O reaches the driver" property relies on
     a non-local invariant spanning bio_check_eod(), the flush filter,
     the pre-start queue_limits, and the set_capacity() ordering, and you
     consider that too fragile to build on.

My instinct is that (3) is a legitimate answer and that the invariant is
fragile, which is exactly why I'm asking rather than sending a patch. If
there's a direction you'd be willing to take, I'm happy to do the work
and the testing.

Thanks,
Zhichao Huang <huangzhichao.1@bytedance.com>
