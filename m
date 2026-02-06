Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC02BD033
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406222; cv=none; b=STrXZwmJHMgte7FLiCY/8BIsB1vCrpokKZtsXS6tVI0P1huBiCEmiZFLP0vTbDP9SkcsKFVhawmlZjbniezgOsG/0OauXCiQKrO1AUcVmwp1eOt4tn4dPqIl6pgOga1plvCdCgJF8PSKxtqIszbWttLV3wgks8akdpQWxf/1B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406222; c=relaxed/simple;
	bh=G/aSCtJa6XpxlOctfizz1f0L16Yp3KoG8eQTiuN/u5Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PVCg30xJ7vyaIOfpzAtbCQUB8iG6UDjg4kVpQqRci3UWfrYMxn7VLRGBiCAYt6F+VnsZ1oXJSvtftXDRpSRenFPdV3EPgs/F5EtRU6Oqbe0LEwaVcTJwyOpbMxp27JwmUO7S8Y1VEoTKj8UXDQWk1lX7KXMcJ9HeYPESB/QDxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZbsVusq8; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZbsVusq8"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so964100a34.2
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770406220; x=1771011020; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0OmooSUBbWUPQrErIIyvJu8U6XJoXgVIxUM9j9ApKw=;
        b=ZbsVusq8g7mJwGWVU7mHCJxJ2JSU1Nbm37tkpcELiccVFt2GDBQYbYGDn9K7pQXzTb
         VviW/kc90/6GMhDx9TJm9nDaeIdjdg2ZPESFh7k7743NmfzdGkx5V+gAnZBOgw6brJzi
         cm+qsg/YDHfDZa/Cz6XcyvnOImp+/b++7FJKjqBO8BPVUhUBjNh6S0TS2lvtuWuftQIM
         QvCMbvUFJiHr/cCstmkMlToRPJTlvnSgo8lxC1WDAqRDplpojJMILOXs28iC4AuWeDUI
         ga/ts/tmT5hP5y8TG5kfQiCn5scgXljQbGgMpmW7D2PgHgsYo9Orv28gSUXhQh/8dyYg
         wCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770406220; x=1771011020;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0OmooSUBbWUPQrErIIyvJu8U6XJoXgVIxUM9j9ApKw=;
        b=xMSjUEIAK9TzXFhUDpqYIu/84UW60pqe4pLVTDNXTPDrtALbiu+Zfm/OuAfRhYWicW
         CIm0d8wchTOelrKstETXNw6Xp4y8SaE6aCiXf7Hp1RWSKkGXzyH9nUEBVDyWxpPkrIr5
         xm6NDrlNbODWhuOCBnZLyaGo7lTfZwjwRo4/E96QGwCgWBYfc7fGW/l9OsHPBL4ZfnID
         aRsNAWnppw2kp3yiavRyjJMxXlTq1u3QQbBIoXaOzgIyALhTBx6qeZ1sx3d12pr0qyhX
         oyQHYFM2rPJP26C3K7pXgQo1efwzX03oMh1rmUoGyPnyjen0UYlexuANbgKxk07ApE3T
         8qZg==
X-Gm-Message-State: AOJu0YwDzc+CVSPCob9Mo2+um0ug6GV+QKCBMO8GfTKcv3G0dhbGVl0o
	NEMjamMeGR+d5kXM1fWCstupB7H1KEFZa8adz8NyowrwzzKsCaqne9oewF00j78MYn1IaVMHJ56
	zFDU3O48=
X-Gm-Gg: AZuq6aIqlseoTaHz7nNwMtO5GWWjm3jNtRHCztxaukjhnuKAtHcrylmYcmClyRgNLO2
	ghoFPus7DAVncuqMrc4135WXI3U9BsJZpDdKg4TgNvgYcSdXPSaiGfRCm+zfwQFm3GrMLby9YK6
	VMZuJvsWoo9GS3ZWoy5ov9Ks2crcv/kHxiqx7r7zTa7927UzsNh27LOPpPtaWp/5eiW2f9vL+Bt
	87jn7tIjgg5rtU+RqTqG/s7o6NxpdOUtQMhEbpCEseuKIvHXpDebvOu+RfqfxceJfBGp78rUCFH
	TZ5uNTTuf9gHZVnGuG8fjNeaNo0lQT+v9lKVS3S4oz8xmS8SilbLUt62p3PwUNrOiq5o6tocFZS
	aif2Ii2lM5eTXicXiqglEQLEWTv23TlwkS3if/eLl3RYm5nWtMY9MUfxf4MUYWEuK8MNv/zCYhH
	tTaPJOePkeSuji7JVsNQELOWovjsbXift4E6gywfyViCQLJKtFcf8FAyOfwwDwDV3ZV6Kt
X-Received: by 2002:a05:6830:6d26:b0:7d1:91a7:8e15 with SMTP id 46e09a7af769-7d464689d2dmr2236916a34.33.1770406220230;
        Fri, 06 Feb 2026 11:30:20 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d464710c95sm2148746a34.12.2026.02.06.11.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 11:30:19 -0800 (PST)
Message-ID: <123a2a6f-7ab2-4ffa-82aa-7599d261da0a@kernel.dk>
Date: Fri, 6 Feb 2026 12:30:19 -0700
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
Subject: [GIT PULL] Bounce buffer dio for stable pages
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

On top of the core block changes, this is a feature branch containing
support for bounce buffering of dio for stable pages. This was all done
by Christoph. In his words:

This series tries to address the problem that under I/O pages can be
modified during direct I/O, even when the device or file system require
stable pages during I/O to calculate checksums, parity or data
operations.  It does so by adding block layer helpers to bounce buffer
an iov_iter into a bio, then wires that up in iomap and ultimately
XFS.

The reason that the file system even needs to know about it, is because
reads need a user context to copy the data back, and the infrastructure
to defer ioends to a workqueue currently sits in XFS.  I'm going to look
into moving that into ioend and enabling it for other file systems.
Additionally btrfs already has it's own infrastructure for this, and
actually an urgent need to bounce buffer, so this should be useful there
and could be wire up easily.  In fact the idea comes from patches by
Qu that did this in btrfs.

This patch fixes all but one xfstests failures on T10 PI capable devices
(generic/095 seems to have issues with a mix of mmap and splice still,
I'm looking into that separate), and make qemu VMs running Windows,
or Linux with swap enabled fine on an XFS file on a device using PI.

Performance numbers on my (not exactly state of the art) NVMe PI test
setup:

  Sequential reads using io_uring, QD=16.
  Bandwidth and CPU usage (usr/sys):

  | size |        zero copy         |          bounce          |
  +------+--------------------------+--------------------------+
  |   4k | 1316MiB/s (12.65/55.40%) | 1081MiB/s (11.76/49.78%) |
  |  64K | 3370MiB/s ( 5.46/18.20%) | 3365MiB/s ( 4.47/15.68%) |
  |   1M | 3401MiB/s ( 0.76/23.05%) | 3400MiB/s ( 0.80/09.06%) |
  +------+--------------------------+--------------------------+

  Sequential writes using io_uring, QD=16.
  Bandwidth and CPU usage (usr/sys):

  | size |        zero copy         |          bounce          |
  +------+--------------------------+--------------------------+
  |   4k |  882MiB/s (11.83/33.88%) |  750MiB/s (10.53/34.08%) |
  |  64K | 2009MiB/s ( 7.33/15.80%) | 2007MiB/s ( 7.47/24.71%) |
  |   1M | 1992MiB/s ( 7.26/ 9.13%) | 1992MiB/s ( 9.21/19.11%) |
  +------+--------------------------+--------------------------+

Note that the 64k read numbers look really odd to me for the baseline
zero copy case, but are reproducible over many repeated runs.

The bounce read numbers should further improve when moving the PI
validation to the file system and removing the double context switch,
which I have patches for that will sent out soon.

Please pull!


The following changes since commit 7c746eb71fc3737340c32f44c31b111f74f5632c:

  rnbd-clt: fix refcount underflow in device unmap path (2026-01-27 21:15:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-7.0/block-stable-pages-20260206

for you to fetch changes up to 3373503df025ab6c9a8ad2ce6b7febd2eb3c99dc:

  xfs: use bounce buffering direct I/O when the device requires stable pages (2026-01-28 05:16:40 -0700)

----------------------------------------------------------------
for-7.0/block-stable-pages-20260206

----------------------------------------------------------------
Christoph Hellwig (15):
      block: add a BIO_MAX_SIZE constant and use it
      block: refactor get_contig_folio_len
      block: open code bio_add_page and fix handling of mismatching P2P ranges
      iov_iter: extract a iov_iter_extract_bvecs helper from bio code
      block: remove bio_release_page
      block: add helpers to bounce buffer an iov_iter into bios
      iomap: fix submission side handling of completion side errors
      iomap: simplify iomap_dio_bio_iter
      iomap: split out the per-bio logic from iomap_dio_bio_iter
      iomap: share code between iomap_dio_bio_end_io and iomap_finish_ioend_direct
      iomap: free the bio before completing the dio
      iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
      iomap: support ioends for direct reads
      iomap: add a flag to bounce buffer direct I/O
      xfs: use bounce buffering direct I/O when the device requires stable pages

 block/bio.c               | 332 ++++++++++++++++++++++++++++------------------
 block/blk-lib.c           |   9 +-
 block/blk-merge.c         |   8 +-
 block/blk.h               |  11 --
 fs/iomap/direct-io.c      | 191 ++++++++++++++------------
 fs/iomap/ioend.c          |   8 ++
 fs/xfs/xfs_aops.c         |   8 +-
 fs/xfs/xfs_file.c         |  41 +++++-
 include/linux/bio.h       |  26 ++++
 include/linux/blk_types.h |   3 +-
 include/linux/iomap.h     |   9 ++
 include/linux/uio.h       |   3 +
 lib/iov_iter.c            |  98 ++++++++++++++
 13 files changed, 507 insertions(+), 240 deletions(-)

-- 
Jens Axboe

