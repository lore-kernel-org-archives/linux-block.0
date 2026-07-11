Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5972AD35
	for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783744353; cv=none; b=QTMwQqFfy2fHY0azbwASQbsCrJFGneq2YEbSi5JdHNNcfow0+dBPhc/RiXjlENniGty7BQv6fCBJU/1sHLXxsKM9gbjK7R8bJzEPpLVGYlhXBuzFAuvjkTCtcUM9EHNesz/IVIYIkIPW3v+p1EIkSm+tQj/4o8nG0IOVDUjyOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783744353; c=relaxed/simple;
	bh=7a3BK9bqkOK9uEclsmSw5ilYT7tcjQzR+scw7XxHigM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OmBkpNRlYYiHbEg2w6flTnLECnpYTByeT/UpuN1Vkv6OqwfgQ7W2yAaHBpiL4KxJAnqgaJhScnQ6erDYmx0iBQkNuwEOS1302jCI5ha4mMmgumN8lNOS7C5SgJQfNfu7ga1YQ7gspcxSsh9R6CY4g4YYp6S4b6+WRuuzdc51Fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=zT7K0DE6; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="zT7K0DE6"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9f6b94a49so736022a34.3
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1783744350; x=1784349150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WgTL0pGzPNjD3iIV3XWFXqoGHSmyLgOEI9kzhzVqGJU=;
        b=zT7K0DE6BTWo4PXg2yKR5vdYMOTlyeuAPrGWzkShUecMgw8KUd4rZqGEUQR1Tzy6uG
         puIeUpfRUf4/Yt+AKxfA24HoTLqapTMrNsp5lSCkhpXcXssfGVmROpjlJABEIyzSqub6
         7R99y+fRDuGjDMTyyfG/LynPhw8iJpCtvcSa2IIUVlrx32gOXgB5url9r0WaPghZ4bMY
         wH7Dr4+/01ia3B2zLMW+ty5FlIxjN5tWDpDwqsrzNFBxOjIjprlY/TOpD3pxJX43K2dS
         XMpbeGh+3lG2IQEitdjeKO8gdLCcKMfS/IXASB6zVeGLHxfTvVTTT4bQIc+SKnc1s9sz
         gTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783744350; x=1784349150;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WgTL0pGzPNjD3iIV3XWFXqoGHSmyLgOEI9kzhzVqGJU=;
        b=JkTk85js5t5HcQyIvY0VfJVTjAbyR/LjMPaST7UJDLL80qEkRdRgkqE/8SyGHpHHWc
         5mhPlwpuMUioQl2kzHXCUSudiJlfY3IJ0AnMQebMLjN6qTIhDEZz81aMJq5JG6pjKm0Y
         PPdTskXzc/oc9aKogd+CtUgIEIVo5258/m2l74Fhpu3HLLJGtTZL/fbDDNq/tz4Bbu0w
         sQvtH8vgFIGM0MxlTzUDzDyvOuU6UnFl2whtK4MpIP/BfOP5eQwLYgaE5vexdCK400Vz
         l0LQTaDMHDCU4x+AQrQrfyNDl41+pb88kb+Q+GzCuxprB/L7U1D5wVquDL+jSmStXd5n
         h4Mw==
X-Gm-Message-State: AOJu0Yzi2NNCewUdt9zEnbK4phH8/Vlsqm5/JhDrDI5v2wdOTXTdTT48
	jmBrJK5PZcZdHBMcHR+JjqxeY2poZrbyTEWQvo6pgYuubO8Fg0lztn4zqsRwIetNga50vNYsXrl
	zmY5l6n8=
X-Gm-Gg: AfdE7cl+ktX1sU7Ph2HGKK+3pDB6jK+HYEy8uSIeB4rB+YBDSmFldSUdvYk3oEizzFu
	wxzLUfzHMy6hTzV2R3wFN8vhLddphgQ50lFclDTNr/27V5JrneB6ToFQFppKo0Bas798uWdA92r
	hc7LBdtKE5y3v2m1vgUJjAd/3Q3N445GsL5GtHXpVN0vvf5iDxc/f7mfhX5p4te3Mlakn0oAlIy
	ZCbWfIDdfpZGQMLBiCFbdoVT7ybkvs7awGABN4z/e6OkPj2xCdrH4Tb74b2vBM+WXV4SNCt29TJ
	KRQooKHdDh8Ms1Qgs8cKGIMZ4f0077SrANltejl2AhV3GXE+UxVWEq6fEmJS0QT1HfTfGjAS8DZ
	IrRE0XroHWdtb4cRbaNmToUylRGwEklQ3efJBOo5RnEEQpw38/cLWICOAjhFE+UaOh9MnikKvZC
	Lj7/5EwVNptdGdFzfzUd4r/4FRXS68WpSyFStvT3zkDgOimjkw1a8RLrq6+58WRCsGkNOrGeg=
X-Received: by 2002:a05:6830:700b:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-7ec094401bfmr998002a34.0.1783744349784;
        Fri, 10 Jul 2026 21:32:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf77ba4sm8059800a34.9.2026.07.10.21.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 21:32:28 -0700 (PDT)
Message-ID: <b7a2570e-321c-4a27-b97f-d95b3d2b8a16@kernel.dk>
Date: Fri, 10 Jul 2026 22:32:27 -0600
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
Subject: [GIT PULL] Block fixes for 7.2-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A set of block fixes for 7.2-rc3. This contains:

- Limit blk_hctx_poll() to one jiffy. Prevents buggy drivers from
  spinning for too long, hence triggering a stalled RCU read secion
  warning.

- Avoid a potential deadlock on zone revalidation failure, which could
  otherwise trigger a lockdep circular locking splat during a SCSI disk
  rescan.

- Remove a redundant GD_NEED_PART_SCAN set in add_disk_final().

- Make writes to queue/wbt_lat_usec honor the WBT enable state.

- ublk fix to snapshot the batch commands before preparing IO, so that
  userspace can't change an already processed tag and trip the
  WARN_ON_ONCE() in the rollback path.

- xen-blkfront fix for a double completion of split requests on resume.

- drbd fix to reject data replies with an out-of-range payload size.

Please pull!


The following changes since commit a1c8bdbbd72564cebb0d02948c1ed57b80b2e773:

  block: handle REQ_OP_ZONE_APPEND in __bio_integrity_action (2026-06-24 06:53:25 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/block-7.2-20260710

for you to fetch changes up to 181bb9c9eae4f69fe510a62a42c2932d0314a800:

  block: remove redundant GD_NEED_PART_SCAN in add_disk_final() (2026-07-10 09:08:50 -0600)

----------------------------------------------------------------
block-7.2-20260710

----------------------------------------------------------------
Anuj Gupta (1):
      blk-mq: bound blk_hctx_poll() to one jiffy

Connor Williamson (1):
      block: remove redundant GD_NEED_PART_SCAN in add_disk_final()

Damien Le Moal (1):
      block: avoid potential deadlock on zone revalidation failure

Doruk Tan Ozturk (1):
      xen-blkfront: fix double completion of split requests on resume

Guzebing (1):
      block: Make WBT latency writes honor enable state

Michael Bommarito (1):
      drbd: reject data replies with an out-of-range payload size

Yousef Alhouseen (1):
      ublk: snapshot batch commands before preparing I/O

 block/blk-mq.c                     |  3 ++-
 block/blk-wbt.c                    | 21 ++++++++++++++++++-
 block/blk-zoned.c                  | 42 +++++++++++++++++++++++++-------------
 block/blk.h                        |  4 ++--
 block/genhd.c                      |  6 +-----
 drivers/block/drbd/drbd_receiver.c |  5 +++++
 drivers/block/ublk_drv.c           | 13 +++++++++++-
 drivers/block/xen-blkfront.c       |  9 ++++++++
 8 files changed, 79 insertions(+), 24 deletions(-)

-- 
Jens Axboe

