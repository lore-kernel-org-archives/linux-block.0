Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870022E62AE
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719160; cv=none; b=e3MOjKV7KJnwOCmYhEWO/SP/UjuNWmzbLZdZiJ3LrSlnhaqcZn6CBQwcXYkJARvTKxoKOfG/GQFAjspbGwAbxvXZ1dAEkVGX2XDrR9vcJXozY4h6zldy+8NGX9Hr4ZilBL3l32fTg0pYavfjGZtCzKUFFo7a6XYK5S/wazACvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719160; c=relaxed/simple;
	bh=k4fjeeaRoGPxNiwsaZ3PT+0XkDRMps+Y46E1VBS0Mek=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hdn7T5+ArNBJJZRRD60YaeneZRlhC9Pd9c1PzackG/CDj9t9a95I1uywVlBQtjbjw8cEWNH4JsuyQbpzFYIzI/JiKPJYHqdSVU6rlVJsyz8t+0IMBz7TkmNQ/Al/b4YWG1eZ6N6boUvrheWP+LY5AmkQkdWcmA27DNFzVXf6km8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VFccl0d2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VFccl0d2"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d5eb0ec2bdso4789115ab.2
        for <linux-block@vger.kernel.org>; Thu, 03 Apr 2025 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743719156; x=1744323956; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+TjnAX+4DHr8l3uZ+EqCX2hVt076+5v8E8TdoE/zT8=;
        b=VFccl0d2WNmf73NkxDPemz7hBnLfQ8mVFoVo91xpu33a7wulMqN2zrSgob4eWqSGZa
         zW1pyqMceOCMiEHxlEBSfRsuDSYpapd3GT/q0Rm1UEoORpAANecJXtMPLoM4U5ejsUxo
         42uaws/YbXi6Jf1dbqJbgxlr/EdM97HAc1WiGA9R1oqmTo0F9xzVMC6/aW3DU3xM4y2R
         JaPp6rdNHqf1GYK0woVQHl+yNogGgIHKyYB06WzpyvznBU2eT2/cMYbj43qeRzd6LWEM
         6A6f4F72+9aiUK3wu9nJaG/kh/4SUrReAUbKwjMPx4C1HfZ+CE4/VBpYZmuADt3OlKvE
         Fm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719156; x=1744323956;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W+TjnAX+4DHr8l3uZ+EqCX2hVt076+5v8E8TdoE/zT8=;
        b=frjJj23I5g2ifgUgE29CZhAlreINFfCxUdRG/JxfWozGG0Le1NGIrte8I6aWlcySjd
         rjUFGo/KrogmmDqdHiQ/aTYmbHRLm1m6K8BZAF0nEN3x/pqXe2TIy7GuqR+wRgDzowkB
         fEXNafx3w+14Gp7zLcfpddfraJ1qgzgRlMWcR+Agm1t9+P+gwo0M0bUPhQd5UUECHf7S
         wKrHrvAEL3j9SOG1huY7D6/a0wurB2jY0elXnub2rr2DzJWjRb2OqHtXrdBwCMZgWuO6
         sTyooIHitcs3xKzhTGYMtN605fxLckKsQT07Bgc4z6Z/6oaJ1bxQwZ4UxHqSi+Q5Qavd
         r5qw==
X-Gm-Message-State: AOJu0YxwQgD0txDdcFjOPRsmpwb3Oap6pR+3QvnchgScdKkumhAjv/XI
	EN4efv/mDlGbRihEjdj0micW1vIt6WILYIDLfd+InOqXRBoXCcr6jF7/jRYo3LSvgC8CxRCMifD
	X
X-Gm-Gg: ASbGncvxkiKlyQ/SCvYOsp4KgABR+dn59iNgM4+sL3htXfr20hlCXw9+abrdiRji8C3
	VnULYVThp30ehcCAa1uFz9+cSPuu/+frm/nhfXtLtjFsELZvuhu+7vqqpFW8oYf7NrMtQ96W8MT
	wb+Lf8Kccz5EPBQuYf5Ol3fIaXm/Sjq25wluBWecpLnxDI/QU1b8KyqpVOpzFsgIcPa3hFEQ6bo
	57BKwnLNAcFjqNVjkOnSXT7e5B2CPwZlnqQsGFRAMl1Ipbb3F8DLmuYJwwRfz416lreZpczo91t
	gnVC1vdJVtRg2E9oWauesbqtS8DkBCHyDZNWF0Twpg==
X-Google-Smtp-Source: AGHT+IFb7eXXe4mk+qgAwz5BDBr8xe4XgOwBIYDhXVgpDAt6e+muEMw7epF6CxaEN9WDPDd0GzR+aQ==
X-Received: by 2002:a05:6e02:398d:b0:3d4:2a4e:1272 with SMTP id e9e14a558f8ab-3d6e599cb42mr5666295ab.19.1743719156496;
        Thu, 03 Apr 2025 15:25:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5d409cbsm498226173.107.2025.04.03.15.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 15:25:55 -0700 (PDT)
Message-ID: <59ee82bb-7d4f-4a5a-8769-120c9dfdcc4d@kernel.dk>
Date: Thu, 3 Apr 2025 16:25:55 -0600
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
Subject: [GIT PULL] Final block updates for 6.15-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of updates/fixes for block that should go into the 6.15-rc1 kernel
release. This pull request contains:

- NVMe pull request via Keith
	- PCI endpoint target cleanup (Damien)
	- Early import for uring_cmd fixed buffer (Caleb)
	- Multipath documentation and notification improvements (John)
	- Invalid pci sq doorbell write fix (Maurizio)

- Queue init locking fix

- Remove dead nsegs parameter from blk_mq_get_new_requests()

Please pull!


The following changes since commit 08733088b566b58283f0f12fb73f5db6a9a9de30:

  Merge tag 'rust-fixes-6.15-merge' of git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux (2025-03-31 18:39:59 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.15-20250403

for you to fetch changes up to 01b91bf14f6d4893e03e357006e7af3a20c03fee:

  block: don't grab elevator lock during queue initialization (2025-04-03 08:32:03 -0600)

----------------------------------------------------------------
block-6.15-20250403

----------------------------------------------------------------
Caleb Sander Mateos (3):
      nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
      nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
      nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

Damien Le Moal (1):
      nvmet: pci-epf: Keep completion queues mapped

Jens Axboe (1):
      Merge tag 'nvme-6.15-2025-04-02' of git://git.infradead.org/nvme into block-6.15

John Meneghini (2):
      nvme: update the multipath warning in nvme_init_ns_head
      nvme-multipath: change the NVME_MULTIPATH config option

Maurizio Lombardi (1):
      nvme-pci: skip nvme_write_sq_db on empty rqlist

Ming Lei (1):
      block: don't grab elevator lock during queue initialization

Nitesh Shetty (1):
      block: remove unused nseg parameter

 block/blk-mq.c                | 29 +++++++++++-------
 drivers/nvme/host/Kconfig     | 13 ++++++---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/ioctl.c     | 68 +++++++++++++++++++++++--------------------
 drivers/nvme/host/pci.c       |  3 ++
 drivers/nvme/target/pci-epf.c | 63 ++++++++++++++++-----------------------
 6 files changed, 94 insertions(+), 84 deletions(-)

-- 
Jens Axboe

