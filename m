Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491224;
	b=0JVkTN0eKVCsm6I1Cbwjb5MialNg4Eu05Wwyg1sSNY+gGGJ6Wn2+Qele5zezCi9OPTvD
	 YV9PMj2FrELtE0G/Prc3LA/KeStK8g66aBFzw/wuYTbi2dYrFDIGaHVuQf14/X+ogL4JF
	 Ho1YGiX2QUHOgInYx/T2yMryu1fIlWh56sKa8dxaLaqFwXgAPLDxyC4436j7xTnr4DYcD
	 WLSnoTv77JM1mNpu6ic/7Q8s9GguYZNUh+irViTov4ndEGD4aiqrBl1SBQFM+r/VDu59h
	 g16Kk1tCdqa5uQLcLmR4R+R3GSedz1ZNNJyKIX8dbHps1W/MvYhN/0EJ5fjRtiQojQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dERELiZSBaCRsX3GCJV7kxhJlGD+/7BqSxHY/qipGqI=;
	b=ogfJNtRqZ+W78/ZxPUQzkI1AACjFUk3wYTLBchj+gE+vOhNuIC5wdHwXSK8BLcIfz64c
	 cgUW9DT9aot+mAxo7LE7JVz0i+xCjrMNexUsvE140bH/N0i3hXKHwqBzMIyS1EnYDreUs
	 DPt8BZ2SQgpqXZ8ya5Ey7mqFYxRScUJAqTi4yDLryTlCqonuX7aCYKPrEd4OOHUHVEDNR
	 ZjHoVqbj7+2pdTQfkBYcHn6ad1zy/mFlYTr7xvGzLYDsnv1cIrr1FxwiW4YS9INOvf/9F
	 HtWL+SnJrZ25g3Vw3Kom80IZoygsHW14iRKUQ+6OVBHZZN4BFRCY/O4f95sWTGvVivA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloud.ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b="bvlw/b/K";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86A606A321
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 13:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A86A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.a=rsa-sha256 header.s=google header.b=bvlw/b/K
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4946589267bso132006f8f.0
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 05:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1794491222; x=1795096022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dERELiZSBaCRsX3GCJV7kxhJlGD+/7BqSxHY/qipGqI=;
        b=bvlw/b/Kno2uFKtJ+dXzbP/S8+wc8sflGs2KyqIU0upMpljHYo9DqBVQOR4XfDmCIv
         TQkD6s3vtpeVQzPPWheKAeZuiNU4NmIRFauGSGqUkEhY6ABkf7bzEhOU/FRSF2rbfA5C
         ug/E3vqmyE1MPj2b9qRq4lxmd6sairWVlygW/cVmXRPXih/ZOONUL8/yBPGymxujnhUy
         3RReL2rDPgQKCmxXVR1wlgYkbZzcLsVuHhYG/K1LWPd3YfbR4/1Mt68aJ6xoByINzmZw
         VNdp3JGEjqlOFEESHT0Bp6hRQ8/cnZadKdovZYYXMqOOYAaaumRqVVgeKPAxgXSa9Xti
         WdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491222; x=1795096022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dERELiZSBaCRsX3GCJV7kxhJlGD+/7BqSxHY/qipGqI=;
        b=2TIfxbUrB/S3gi3K9JmT7fY/QbmMFdxub+DU3ZuhdKkJaPUrkqCzWsLUcaKRmTLaii
         0woNqhgV7wWjp3BFno4ko8lB63kNGd22gIyuQIi7uoy42M4eB2ihHhKoPdsMSm3WPLLG
         PooLly4zClFQQz8lm1NpfM7IPKbkUuy7zlzQPXR5MQBxWidJ9xU4IOmutgKV9p5kn0va
         qeyaKpHzb5dYxJLzrgwJbUCYbXYtiPL0ySPWf+20t9EhE4jjKQQKAYhrLOlL8zWDImNQ
         nxSCbB9P80a2fuozZ/lXAnkyngCHUrutqLEYtVkxK8TMTlyE0+PjzSIcn50FZSAYMMBd
         FDIQ==
X-Forwarded-Encrypted: i=1; AL+hErE5sWeBWBN7l7ppnYav7x/CLEWFMrzFA4hDLZlIe8HgD1RlZ90RFQA/IZ/3wZ3gfvD+igdHv6pSPTMnUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+sHYodkjj0/OROsqSAQCnIphdQjpTLMmmQ3Ii82UDy0CqaQy5W
	r6kWMAX9ICWv8AlVERlFJldVCH2lyWvQQ5jgVVEi222hU6hMIy4U5NADBAbQe0kx2bM=
X-Gm-Gg: AYBFou2xYUllaGcwnCxV1UpnheMDJrfnqJs44dWcWxY0ohGyUEuKGmnNP67K31zsNJJ
	7zps0Rq/XLKPc7VoRk2eKoyNpgoS1ghK7RutKmUxdktAUzlA0EpTPb8zLhml3gPJ5MuT/FAm0MW
	CL58YPLVy3lbPjeERzeMmY/WMi6Ibd0VcIeul8sH7e5Em0BHXAV1b6OTsJteHUN1ZlrkZWpKzmS
	0KPKQKP69NY/v9JwZCADguEIg6Rhj93d5j3w/TPNf+oNeoKZfPubk8zTVCdeYMAOinaXrtVod/Q
	MYtcB1/ykrY1/PhMMilXRO/dXwZWyQR5jGOyJxaCGX/zFRT+z6Kcyw3kci5a3jme1HLFC53xCfX
	P1lahe6fRiEQutLzkn1/m8WOftVSmPFyayeXHwmZvXuGRGlb1uhniwIcD3e91fxVsrzVCnZIP9S
	XbUqe1VoONE0DZ7uV/gyetD8gPJ+mV0kS9meLkjwRcytizMlDpToxS7nwiNvBOpvhWtEJBNRYKb
	wBQaGKi9rmjkKy6KVax4UyEEHoZVp9iH1FnGKXCgRIMNrSR3nrYVW1w6nGL1ct8hiS1rpWTna0i
	vGpwTRQMO498FafPrZIfxUzDVNzfl5Xt5I77mlVBYznaJmyfmmDZ/8at/g2cFdxZGbgQnyzrUzq
	fxOASEg==
X-Received: by 2002:a05:6000:4205:b0:491:9a69:5ad0 with SMTP id ffacd0b85a97d-499c7d06677mr11144611f8f.5.1794491221773;
        Thu, 12 Nov 2026 05:47:01 -0800 (PST)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498367b99bcsm17665990f8f.51.2026.11.12.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:47:01 -0800 (PST)
From: Jack Wang <jinpu.wang@cloud.ionos.com>
To: Yu Kuai <yukuai@fygo.io>,
	Song Liu <song@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] block, md: suspend md around queue limits updates
Date: Thu, 12 Nov 2026 14:46:58 +0100
Message-ID: <20261112134700.372702-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Writing to a queue limits attribute of an md array while a spare is
being re-added deadlocks the array.  I reported this earlier here:

  https://lore.kernel.org/linux-raid/CAMGffE=heGA3y8FjQ0Sm1jj-kd-=H9Y54WozKASSEZhc9UNKjA@mail.gmail.com/

Four tasks, one array:

  udev-worker    queue_attr_store() holds q->limits_lock, waits in
                 blk_mq_freeze_queue() for q_usage_counter to drain
  fio            holds a q_usage_counter reference, parked in
                 md_handle_request()'s is_suspended() loop
  mdadm          suspended the array, waits for reconfig_mutex
  md_start_sync  holds reconfig_mutex, waits for q->limits_lock

Since commit c99f66e4084a ("block: fix queue freeze vs limits lock
order in sysfs store methods") the sysfs store holds q->limits_lock
across the freeze.  A bio parked in md_handle_request() while the array
is suspended still holds a q_usage_counter reference, so that freeze
never completes.

v3 froze the queue in mddev_suspend().  Review showed this deadlocks
against raid1d/raid10d resubmitting a split bio and against raid456 I/O
waiting on an interrupted reshape.  Following Yu Kuai's suggestion, v4
lets a bio based disk suspend itself instead of freezing its queue:

 - Patch 1 adds optional ->suspend() and ->resume() to
   block_device_operations.  queue_attr_store() and the integrity
   flag_store() call ->suspend() before taking q->limits_lock, commit the
   limits without a freeze, then call ->resume().
 - Patch 2 implements them for md with mddev_suspend() and
   mddev_resume().

The order is suspend, then q->limits_lock, as in mddev_update_io_opt().
A suspend already held by another task only nests.

Known limitation: md_submit_bio() reads the limits in
bio_split_to_limits() before taking active_io, so a bio already there
when the suspend completes can see a mix of old and new limits.
mddev_update_io_opt() has the same window.

Christoph, does a ->suspend()/->resume() pair in block_device_operations
fit what you had in mind?

v3: https://lore.kernel.org/linux-raid/20261102154847.198472-1-jinpu.wang@ionos.com/
v2: https://lore.kernel.org/linux-raid/e2c36f31-d198-40a7-a18d-156e1fd6fbb2@fygo.io/
v1: https://lore.kernel.org/linux-raid/20260909063029.GC29874@lst.de/T/#t

Changes since v3:
 - Drop the freeze in mddev_suspend(); add ->suspend()/->resume() to
   block_device_operations, as suggested by Yu Kuai.
 - Also cover the integrity flag_store() path.
 - Rebased on v7.4-rc1.

Testing: the reproducer below, 20 fail/remove/add cycles with fio in
flight and a loop writing queue/max_sectors_kb, on a 6.12 based kernel
with lockdep enabled.  No lockdep reports, no hung tasks.  That kernel
had the queue_attr_store() change only; the flag_store() change and the
rebase to v7.4-rc1 are build tested only.

A blktests case for this deadlock was sent separately:

  https://lore.kernel.org/all/20260910100916.1638378-1-jinpu.wang@ionos.com/

The reproducer:

  mdadm -C /dev/md111 --force -e 1.2 --assume-clean -l 1 \
        --bitmap=internal -n 2 /dev/ram0 /dev/ram1

  fio --direct=1 --rw=randrw --ioengine=libaio --iodepth=32 --numjobs=4 \
      --time_based=1 --runtime=180 --filename=/dev/md111 --name=repro &

  while :; do
      echo 128 > /sys/block/md111/queue/max_sectors_kb 2>/dev/null
  done &

  for i in $(seq 20); do
      mdadm /dev/md111 --fail /dev/ram0
      mdadm /dev/md111 --remove /dev/ram0
      mdadm /dev/md111 --add /dev/ram0
      mdadm --wait /dev/md111
  done

Jack Wang (2):
  block: suspend bio based disks around queue limits updates
  md: suspend the array instead of freezing the queue for limits updates

 block/blk-integrity.c  | 10 ++++++++--
 block/blk-sysfs.c      | 19 +++++++++++++------
 block/blk.h            | 20 ++++++++++++++++++++
 drivers/md/md.c        | 12 ++++++++++++
 include/linux/blkdev.h |  7 +++++++
 5 files changed, 60 insertions(+), 8 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
