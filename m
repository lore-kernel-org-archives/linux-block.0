Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98506257846
	for <linux-block@vger.kernel.org>; Thu, 11 Sep 2025 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571301; cv=none; b=qh598TjST0LGQSBdLMxCLNFR89ALzfyB3lfowXLSGQvwWdqw9m5uOzPQaFiR3Lri1IljOIDp/fApuu0zZ+SfSeBFIk+OMeYf7p4G80EVyI2UcEbGZe52T2BikYVasGJ3rLaROzy9iTjwBsMLSHgXTXz+VIfg9/+fjMUq9xYPNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571301; c=relaxed/simple;
	bh=dN/q7sJWCljQHT9+clm4lkMdi/kG2zsZas+V/CrbBC4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tVtq/k5zVZNzayR45cFc4c7Z1hw4gbK1Cks4XoKamWpESAaBanSNDN8lQB/YqL2u9l+UJiWjRpG8wy9Q9JdQauLMhSlwfoAL5XPZ59SjGv0ZT34BTEAsc/LS5QymxUTLXw5tHsqcWR8onFPqsgQBcfywpT6kDc3KaW8gNhFr5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6dWU4DQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6dWU4DQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757571298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=a3c1ZuibKcvEiHD4iO6HtDiOiRjsNM1kz+Nrfa0YOZE=;
	b=b6dWU4DQ23aakNo/ehBCO5xYyXknr2GHUBabAp7afoAI/+kMpIFBGxVqUaNcBJZhjJNR1c
	t9XsHpv6+4N8FBjvxEPErsJ04UVPOxbXBLQQ4gxdfnSzLDmevdvLDSYKTMoKwOhI44ocVm
	NoovCcxbSObguqu9n5PY3hcHkfdNTNw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-uIrbAMXBNourQdwvML6XEw-1; Thu, 11 Sep 2025 02:14:57 -0400
X-MC-Unique: uIrbAMXBNourQdwvML6XEw-1
X-Mimecast-MFC-AGG-ID: uIrbAMXBNourQdwvML6XEw_1757571296
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-336a33789d3so1449771fa.3
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 23:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757571293; x=1758176093;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3c1ZuibKcvEiHD4iO6HtDiOiRjsNM1kz+Nrfa0YOZE=;
        b=An2sr0YUo6ak2bUnQRKTDFSTC+0+4MfxTzq891omRUX/C5USVLwpnO92Vx92U/gQPo
         7uCC27R1Ia0e7b3l3Fx4DxL2EAdeeJT6tAT3FcNwm9gBGGBrxbbRBTwNgq8qE7tjiTlv
         v1f9EYC++awGTfFaP0V3scPyIYHIpVz9vnU5SqjtsSrucIrVyNzrt2UeOHI0sI3I/Cg+
         7Bx2UApNCIrg7LcZqCJc1kBBskrNxfEtR99YS/KyynHuRIx1yY3dxKKKgdewQbsGWgrv
         Ai/mfWE/e776xm0OuIlIx4NluP9VT4vcalis3FsvQKXJ+FSnZ1Cy5DM0kdj/wSNUlaK3
         OQNg==
X-Gm-Message-State: AOJu0Yy2coioMhNqfxQNK7ptBAEg/xjXF6ypmIKV5ViPQQAPz5leDrge
	pgbQvgUBnS/zkbJAP5+3LEub4/S9GnifxbLNWbgR3wn1rBtwv9oD1Tsph7IiuQLSTLMCkrhVDy5
	cbmT1Luen6ri52fHhTWYM66b6eAXzpOMsHBCmfMufSDDXs4kVqQ7G3kqMu5wZfE9AoFkuKhWHMc
	4fzUCOlbScwnWiDJJBO6u2+2Z0cGdt0T9Vi7KOawgixj5XbjPu5ZbJ
X-Gm-Gg: ASbGnctzYqhzXrv2+H+bSOBaaVruUI1MjZs6h09dl4DLHLEhh+Y/mQal+UACuphuZtl
	Hzzm/bMKV4GWvFr/2FBxT5j7KFmTTpJKw3RP1TemjfEIirktHWtGjlz9lZRUVzkYLhZxvYY0Gzx
	LfmkbhKstlmLN0B5hug/gWkQ==
X-Received: by 2002:a05:651c:544:b0:336:df71:e560 with SMTP id 38308e7fff4ca-33b58fa314emr52542621fa.3.1757571293107;
        Wed, 10 Sep 2025 23:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSSiFmGqk/VV5bdYz/DaoVvh8QlQX5MceuSSufUzQ6LmIfnASahoAZTibzQQ1tF3PALZ+V69ws+sQW1+lxQeA=
X-Received: by 2002:a05:651c:544:b0:336:df71:e560 with SMTP id
 38308e7fff4ca-33b58fa314emr52542511fa.3.1757571292672; Wed, 10 Sep 2025
 23:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 11 Sep 2025 14:14:40 +0800
X-Gm-Features: Ac12FXyGj4aLYPwBA4dk7TMrg755g0SnYN3PcEMXnMTeciuSjDaWvCDmoPSZ-6A
Message-ID: <CAHj4cs-p-ZwBEKigBj7T6hQCOo-H68-kVwCrV6ZvRovrr9Z+HA@mail.gmail.com>
Subject: [bug report][regression] blktests throtl/ triggered kmemleak in blk_throtl_init
To: linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi

The following  kmemleak issue was observed in the latest
linux-block/for-next, It seems a regression issue. Please help check
it and let me know if you need any info/test for it, thanks.

unreferenced object 0xffff888160f75c00 (size 512):
  comm "check", pid 29719, jiffies 4302480465
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 5c f7 60 81 88 ff ff  .........\.`....
    08 5c f7 60 81 88 ff ff 18 5c f7 60 81 88 ff ff  .\.`.....\.`....
  backtrace (crc dc08e6b1):
    __kmalloc_cache_node_noprof+0x3b1/0x4d0
    blk_throtl_init+0xa2/0x6a0
    tg_set_limit+0x5ac/0x720
    cgroup_file_write+0x1ab/0x670
    kernfs_fop_write_iter+0x3a3/0x5a0
    vfs_write+0x525/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x94/0x8d0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888111280c00 (size 512):
  comm "check", pid 30240, jiffies 4302503636
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 0c 28 11 81 88 ff ff  ..........(.....
    08 0c 28 11 81 88 ff ff 18 0c 28 11 81 88 ff ff  ..(.......(.....
  backtrace (crc 2d0490fe):
    __kmalloc_cache_node_noprof+0x3b1/0x4d0
    blk_throtl_init+0xa2/0x6a0
    tg_set_limit+0x5ac/0x720
    cgroup_file_write+0x1ab/0x670
    kernfs_fop_write_iter+0x3a3/0x5a0
    vfs_write+0x525/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x94/0x8d0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888187ac6400 (size 512):
  comm "check", pid 30484, jiffies 4302512625
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 64 ac 87 81 88 ff ff  .........d......
    08 64 ac 87 81 88 ff ff 18 64 ac 87 81 88 ff ff  .d.......d......
  backtrace (crc 4a3a862a):
    __kmalloc_cache_node_noprof+0x3b1/0x4d0
    blk_throtl_init+0xa2/0x6a0
    tg_set_limit+0x5ac/0x720
    cgroup_file_write+0x1ab/0x670
    kernfs_fop_write_iter+0x3a3/0x5a0
    vfs_write+0x525/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x94/0x8d0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff88822cbf3800 (size 512):
  comm "check", pid 30715, jiffies 4302520405
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 38 bf 2c 82 88 ff ff  .........8.,....
    08 38 bf 2c 82 88 ff ff 18 38 bf 2c 82 88 ff ff  .8.,.....8.,....
  backtrace (crc 7eb87e87):
    __kmalloc_cache_node_noprof+0x3b1/0x4d0
    blk_throtl_init+0xa2/0x6a0
    tg_set_limit+0x5ac/0x720
    cgroup_file_write+0x1ab/0x670
    kernfs_fop_write_iter+0x3a3/0x5a0
    vfs_write+0x525/0xfd0
    ksys_write+0xf9/0x1d0
    do_syscall_64+0x94/0x8d0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e


-- 
Best Regards,
  Yi Zhang

