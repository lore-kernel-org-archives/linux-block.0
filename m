Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD51474A0
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940506; cv=none; b=FzJ+J/YA36GExg1thp8r2P/lZtKQZPuvJ+OaaaC0+1q8ZwrrOFGOwZzcT8yk44gWKudmB7O5povx7KLY3WhlJccRj464srFJLd1b6PMkq39JaQU9gLoM8vECf0TxaNEJ4XXkqre23a637xhw6tvlKaqW6DgqCbQ1EKpaS3RzAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940506; c=relaxed/simple;
	bh=iTsH36V306ZXMqMRxtdn2e+83oodpY3xenWhxKl6o30=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eA2scB+pyPrnlPn02PamLN/30HjFn1HqC8A83McJ8/UG/tk2d5uBiKOefjsOumNXwHRbMJoRDVU+JaXOZI80D87ulL9SPs43S2TDNUDgi+Nv2ZWWzTY7KPpOB9jDakhC/X6cg4ufuutPsDBBldXWw5MqfYt626prC2Db1A0v4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0MhF526k; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0MhF526k"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36b07e83a76so103475ab.0
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712940502; x=1713545302; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiQw+fvmDG5SW9XRYFQYiidFbbbudx0BfQ1uqiJaUAU=;
        b=0MhF526k48feukQBQMiWKHM2kI5mtMwsOC2VpQlhZ3qPpMOFw3e+PtL/RQ96U9/sHj
         XNrZU5jOy0frKl/HH4TjAi0LSJUYvsprEnjaVcN+7Uftt+V8vOq7SN12aiRL8tZz84iI
         tUFq700Jio7Cf2DOmBUQ0BfPV6ZvWlffYkDtlVqaACTKPaXPe/OIcxRs+YxTuAOu6pfh
         GPQJsTlgZSl4Wv77KIZ+j6TPlqnZrY7qihP/mvCUFf1ljE5yh00Ry5FrgCE8fcDIUmC+
         FeKNi78AO4X34iFQPvPagErc6yscHU02XF35nLqg53zv8KDGDU0vL9kbsMUcQZIhK+Wy
         yDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940502; x=1713545302;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BiQw+fvmDG5SW9XRYFQYiidFbbbudx0BfQ1uqiJaUAU=;
        b=PcAFn2VA24KIv7of1pLQnfs8Vi17jnbyNc4wZWIGW531ciegz2JsQtyrWDwHrSciOh
         RBRlOmbZj8l6d74Bku7S/+Dv9VqW62iJFsA/mrJGhHUnl4xujjNEf0igQwlz8gOxXqkS
         IunV6Sekx4iVwMb6kMwi+u7UK+IUY0wX+WidQSr0ooc22a8CF8zuUA+nlRaIGNPBT6VW
         Sao1aR8Yf61g42sjKCuU5gkV6KfOKnE4YcY5ok3WPARyzCG/Z0wBbo/Oe9ubv6UiM31K
         HZ3mQ1fI1/Snn/oT/Q4OopTnwsWsYLCaeoWsqRM1eSV0tq87kHi1LL6Y0/3Uur3Q/zUa
         Fhiw==
X-Gm-Message-State: AOJu0YxzLpeI4QzB5h3aaYKTdopC2ZZKupIL6KNDrDPIMq16uGHX+pDi
	x4i294CNjtXJ0AlfFc5+QmxWJthJgjkrDmBvVZ215cB4kmZxDthTfz6BaQwvjubNNya6nZrOG3b
	o
X-Google-Smtp-Source: AGHT+IEq8R8QYPgD2lAPvFa9DX1o2/4kkbGNniM5xw96Ve11Lc5BaUgzsR1IT4QVuH0a8AKP3j4e/w==
X-Received: by 2002:a92:4b01:0:b0:368:80b8:36fa with SMTP id m1-20020a924b01000000b0036880b836famr2852949ilg.2.1712940501679;
        Fri, 12 Apr 2024 09:48:21 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ay32-20020a056638412000b004829e8e9456sm1153530jab.20.2024.04.12.09.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 09:48:21 -0700 (PDT)
Message-ID: <6c52c906-677d-43de-b5bd-a0a213097de2@kernel.dk>
Date: Fri, 12 Apr 2024 10:48:20 -0600
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
Subject: [GIT PULL] Block fixes for 6.9-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Some fixes for block storage that should go into the 6.9 kernel release:

- MD pull request via Song
	- UAF fix (Yu)

- Avoid out-of-bounds shift in blk-iocost (Rik)

- Fix for q->blkg_list corruption (Ming)

- Relax virt boundary mask/size segment checking (Ming)

Please pull!


The following changes since commit 9d0e8524204484702234e972a7e9f3015080987c:

  Merge tag 'nvme-6.9-2024-04-04' of git://git.infradead.org/nvme into block-6.9 (2024-04-04 13:23:21 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.9-20240412

for you to fetch changes up to 3ec4848913d695245716ea45ca4872d9dff097a5:

  block: fix that blk_time_get_ns() doesn't update time after schedule (2024-04-12 08:31:54 -0600)

----------------------------------------------------------------
block-6.9-20240412

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'md-6.9-20240408' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.9

Ming Lei (2):
      block: fix q->blkg_list corruption during disk rebind
      block: allow device to have both virt_boundary_mask and max segment size

Rik van Riel (1):
      blk-iocost: avoid out of bounds shift

Yu Kuai (2):
      raid1: fix use-after-free for original bio in raid1_write_request()
      block: fix that blk_time_get_ns() doesn't update time after schedule

 block/blk-cgroup.c   |  9 ++++++---
 block/blk-cgroup.h   |  2 ++
 block/blk-core.c     |  3 +++
 block/blk-iocost.c   |  7 ++++---
 block/blk-settings.c | 16 ++++++----------
 drivers/md/raid1.c   |  2 +-
 6 files changed, 22 insertions(+), 17 deletions(-)

-- 
Jens Axboe

