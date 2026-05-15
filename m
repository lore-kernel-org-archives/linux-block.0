Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF04C77BA
	for <linux-block@vger.kernel.org>; Fri, 15 May 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863994; cv=pass; b=tdFTkxmsw/tOHsVhPCZuO2gtI1nCZ/b7R5OrT5/kn0bnYtLtIVDlZlrs/CMKGDG0JEjOBKlFvkMY/nqFw95nddfepa5Z+Bx3IWC8OMEDjYT21GJJrKQIPZrk5aauZFJcSdno9LQITkHZzo8WcxKsQ7SQzSPR/luz6086+kkIBsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863994; c=relaxed/simple;
	bh=oour2uG5iRfmu2ayrytJIqDx9R0+oLFFwOaMHB+gtAU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MFDkYSA3Fz7yNvJhWhSAJh0VV5vQr3K0+W0gB+Z6qWciZT0OaZMEvPG+OCaUkCB1CKjdLxHNvJIYz9hJr0WnRZ/Wp/zpBCjIMfrmV4dgdoxDMMSN9tjJ+smNxXGF5uH9W7thMnOaTXuxK4gjoEHKeDWmY0OxmDjiN5oWfa8mt3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMKaEt+M; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMKaEt+M"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a86fc85e05so507454e87.2
        for <linux-block@vger.kernel.org>; Fri, 15 May 2026 09:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778863991; cv=none;
        d=google.com; s=arc-20240605;
        b=R7tUTbzr5OX5DutCiryyDKCfzgt6HaI8A8YO6xqowAUwCZfR8CoqlqFNuZhx5rO1d6
         k4rGl/YSIfkhn9BzM2S6B80fBNuRGdMJ87EM3nqvh3c1ojOqUKP9t3GP7btRVCxSxEoy
         ff0rwuqZ+bu4xPl02QtPiuvteEmYaw5UC5igAAlPm7RHg36rwS9l5OVK7YzmFMxdkH+C
         RlXkyXms3TcMUb5dLWlX6CoFlzlBWP0M/3ARo3lqMKODM7WYC4XVhJM5XwlM8fk+jIPP
         xiyKbjlsnvEHLqDx6sj2WZ1Nn6o8IHcUyTsxuGBV7FG7dA5sfQrqfoOYNbrt4fpWWkvf
         pCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QyIEXMzo0LLWlJtxbIVaApvLffeGdlkhSdDar+auJNA=;
        fh=4ETQmVbjnQUgJnesfzuJj3gtO1U994OwjCPz0G+g//0=;
        b=W58gZfhH5OePFYzGLrRjwIgUqz1XKNZjZ3+q0irffnzCl6iiPoF6a/MYrAJz7Y8+XI
         yWGKU1+0iJTdIKR1uVYToAjwqMD0AkT8/eFnxW63uW40ISTsrkuCjzmpf6Utcsu4dYvL
         pjsWLA9EDcebv6cBWAgEN+9tumSCxJqk4sOqUtgKyqRILwe/ne3lGbwGtjx3YFxcpKmC
         g6TRRBtRHvs6LL9BSuVNcVwgb33Iq71JAzlfkDtrxhBEzEPDpf7GNuiNqeo8kFab2Wgh
         gF6Ace2OKoq9vyd0fmLXgv/dv7wYNLujm+aVN03eQJ2/mLqh3lXvTKkZcVpworOdEJVv
         K2sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863991; x=1779468791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QyIEXMzo0LLWlJtxbIVaApvLffeGdlkhSdDar+auJNA=;
        b=NMKaEt+MyqGDHZWvALdik1ENydXqfR1JpamuHQR35ud6ml7oPptZSzVA+g7YP3591u
         ptea/n3+AJCvDA1tm4J/E8S1OUtrNN5oXZOa3NFUA+k7jGS8L6vI6mWA6P0/geecc7kj
         QwgN2zx2p9PFIBJIQKxPiqJDeORWIp2HdJAU1liN5+5V9CzK+9lB3gUoAv7cCN9sZkW1
         mnVFpN92r2fFSUmEo0hkvre9eKZbGIbgox8jhZsavoIw70txa9ggCpkRW5HQzaVjdfj7
         ISglf2Z1EgJkugoMKQq/IyMwmf82qwVrOvHBFOzdHhK1N/y3W2uBV1K9Ni3D81hQXzbY
         8VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863991; x=1779468791;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyIEXMzo0LLWlJtxbIVaApvLffeGdlkhSdDar+auJNA=;
        b=o7pTNLp5o8LZWisB6Gu7qAISU+neAOLeCGrbk6c6H4OJJRm/XlkeB++6i7jYJZE+tb
         rvjY0Fke3kyS5ByTD2WXibESgqrxT0+FYMc4fPOzm8Jx4L4VfxkYHSUkskHDVJM+z6Tq
         OjChvyMkncm/So7wVXHOINirvoDsu5enRDVV1UhjRehHZj5x4N0M+3G52njKuFM20fjL
         aNFn9ahiKsCO1J4/zFuNN8j4TAVEQ0n0oTKIp4KFkuQDTgGk1Ujq5jbMJYqYtdKxlBLb
         gklbjSCZbM1+DQpK5YmrE/2FsXJXBeVDmTBtRv0VXtoO0oQ9fGzg3HbmLVUqyfcui34i
         Jk/g==
X-Forwarded-Encrypted: i=1; AFNElJ9o/YhcH3L/NSld+MRrK1Md1u2k1CfazCa5eggoGU85wnCCH6mPnEDUkj8IMp8K3ZFe1uzZ1RtbbzJPEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQbW81Bmr7nX+lPZ/ZN9hWUhaKVmJd14osCvlv+q4brLUuyqIT
	95pZf6IixPfK3zsfyQGaH8+oEtdo2QezIZJ3ebbyA16IRG6bq452DYesyRL1sK9jRaeNUJiuVC3
	Lu0jxFUnjuCwYMZub2ydXTp6yNrOtqz8=
X-Gm-Gg: Acq92OFAOiTTOjw13wacxM+lPs3LccVp+DslDb3zIEtNaQAdfe1X+CVx4prFjd/TGMi
	md2YDMXGndbtWbCJdrmxgsb5WfZ+XzALfhaYI7fk1ElHrZxM3EybWlDxgC1rGP8htRZVF2mX/H6
	WoJCF++QYt82b9H5zQsUjbtHPRO52MMIkaUSBDf4P2cvBqcECAYbEHBrE2nx5ukaQaW6dzACqCg
	9yxM7TZ+/X++GmBMGsuJ64Y5PSLFOFpVzmrY8E0+w+eLK3Vld6n6FKgg2Ttb1EzTiI+sCxAH0MC
	t2LK8ZA=
X-Received: by 2002:a05:6512:108a:b0:5a4:19de:eb77 with SMTP id
 2adb3069b0e04-5aa0e74c40emr560236e87.3.1778863990648; Fri, 15 May 2026
 09:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vjaceslavs Klimovs <vklimovs@gmail.com>
Date: Fri, 15 May 2026 09:52:59 -0700
X-Gm-Features: AVHnY4K5KLdo5SUY6rORreRp5hLSJu5MynIgl0mmY702h5swQNzKJAuKAe4ZMPI
Message-ID: <CAC_j7i1R7oy+nRhxEjCTba=DUgn02w9X+p94DCu0aHv5+5tKnQ@mail.gmail.com>
Subject: [REGRESSION] block: virtio-blk + LVM raid1 spurious sector-0 read
 failures on libaio/threads submit since 5ff3f74e145a ("block: simplify direct
 io validity check")
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Summary
-------
On v6.18, starting a libvirt/QEMU guest with virtio-blk backed by an
LVM "--type raid1" LV (drivers/md/dm-raid.c stacked on
drivers/md/raid1.c) makes md/raid1 register read failures at LV
sector 0 within seconds of "virsh start" and mark rimage_0 Faulty
once max_corrected_read_errors (default 20) is exceeded. Reads
succeed via the redirect path so guests boot, but every guest disk
ends up degraded on every VM start. Same workload on legacy
"--type mirror" (drivers/md/dm-raid1.c) crashes the host: a
zero-length READ reaches the NVMe controller, is rejected with
"Invalid Field in Command", and the dm-mirror recovery path oopses.

Symptom on dm-raid raid1 (post --type raid1)
--------------------------------------------
Per LV, at virsh start, in host dmesg:

  kernel: raid1_end_read_request: 95 callbacks suppressed
  kernel: raid1_read_request: 95 callbacks suppressed
  kernel: md/raid1:mdX: dm-58: rescheduling sector 0
  kernel: md/raid1:mdX: redirecting sector 0 to other mirror: dm-58
  kernel: md/raid1:mdX: dm-58: rescheduling sector 0
  kernel: md/raid1:mdX: redirecting sector 0 to other mirror: dm-58
  [... 10 rescheduling/redirecting pairs ...]
  kernel: md/raid1:mdX: dm-58: Raid device exceeded read_error
threshold [cur 21:max 20]
  kernel: md/raid1:mdX: dm-58: Failing raid device
  kernel: md/raid1:mdX: Disk failure on dm-58, disabling device.
  kernel: md/raid1:mdX: Operation continuing on 1 devices.

  dmeventd: WARNING: Device #0 of raid1 array, vg0-iris_boot, has failed.
  dmeventd: WARNING: Waiting for resynchronization to finish before
initiating repair on RAID device vg0-iris_boot.
  dmeventd: Use 'lvconvert --repair vg0/iris_boot' to replace failed device.

Subsequent "lvs -a":

  WARNING: RaidLV vg0/iris_boot needs to be refreshed!
  See character 'r' at position 9 in the RaidLV's attributes and its SubLV(s).

dmesg | grep nvme is EMPTY on this path. The NVMe driver is not
involved in producing the error; the failure originates between the
virtio-blk bio submission and raid1_end_read_request().

Symptom on legacy dm-mirror (pre-conversion --type mirror)
----------------------------------------------------------
Same workload on drivers/md/dm-raid1.c reaches the NVMe controller
as a zero-length READ and panics the host through dm-mirror's
recovery path:

  kernel: operation not supported error, dev nvme1n1, sector 935446535
op 0x0:(READ) flags 0x0 phys_seg 0 prio class 2
  kernel: nvme1n1: I/O Cmd(0x2) @ LBA 935446535, 0 blocks, I/O Error
(sct 0x0 / sc 0x2)
  [... 10+ identical bursts at same timestamp ...]
  dmeventd: Primary mirror device 252:58 read failed.
  dmeventd: vg0-iris_boot is now in-sync.
  [kernel oops in dm_mirror recovery path, full trace lost to console flash]

The "phys_seg 0", "0 blocks", "sct 0x0/sc 0x2" trio (NVMe Generic,
Invalid Field in Command, NVMe spec 4.1.1.2) is unambiguous: a bio
with bi_iter.bi_size == 0 and bi_vcnt == 0 left the block layer and
hit the controller. dm-raid raid1 hides this by retrying on the
surviving leg, but the upstream-of-md trigger is identical.

Bisect
------
git bisect, v6.12..v6.18, 16 deterministic GOOD/BAD steps, no skips,
~104 minutes:

  5ff3f74e145adc79b49668adb8de276446acf6be is the first bad commit
  block: simplify direct io validity check

  --- a/block/fops.c
  +++ b/block/fops.c
  @@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
   static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *iocb,
                                  struct iov_iter *iter)
   {
  -        return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
  -                !bdev_iter_is_aligned(bdev, iter);
  +        return (iocb->ki_pos | iov_iter_count(iter)) &
  +                        (bdev_logical_block_size(bdev) - 1);
   }

The dropped bdev_iter_is_aligned() used to walk the iov_iter and
reject per-segment misaligned/degenerate vectors at the blkdev fops
entry point. The replacement only validates ki_pos and total length
against the logical block size. Cases that now pass that no longer
get rejected:

  - iter with iov_iter_count(iter) == 0  (degenerate; total length is
    "sector-aligned" since 0 % 512 == 0)
  - iter where total length is sector-aligned but a segment isn't

The commit message justifies the removal with "The block layer
checks all the segments for validity later". This is true for the
io_uring submit path (which enters __blkdev_direct_IO directly and
does its own validation) but not for the libaio aio_read/write_iter
or the worker-pool sync read/write_iter paths that enter via
blkdev_{read,write}_iter() -> blkdev_dio_invalid(). For those paths,
the segment check has no replacement.

Reproducing
----------------------------------------------------------

The trigger requires QEMU virtio-blk's specific submission shape AND
a non-io_uring submit. Userspace libaio alone, userspace
preadv-in-a-thread alone, and QEMU's raw-driver open probes (which
qemu-img info exercises identically) are all insufficient. The
combination that hits the bug is "guest-driven I/O through
virtio-blk-pci with cache.direct=on and aio in {native, threads}".

#regzbot introduced: 5ff3f74e145adc79b49668adb8de276446acf6be

Thanks,
Vjaceslavs Klimovs
