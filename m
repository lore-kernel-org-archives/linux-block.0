Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396363BFE25
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689685; cv=none; b=qWpOOGINjaOB/Lay6Jiyum6GeOpbSuabPGqXdZzdt3gQUIYX+HRtvInMvmt3tXe/XEsIsh0ZW/lnmkLJ/5p1wbYWO2Icv7byKeqATiKtcnEkk+FC5C8Cjqan03oh7nlBK7B/EzO69sxBP6vdNw/HIcMT7hEX6BV/uYIhbXTITWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689685; c=relaxed/simple;
	bh=wV59S+24SkoudTTg5Z0iOXTtP9iydoFQW4GbxHpzTJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWmrW19WV6VELY6lcb6yFNyGXr088/Cl6WU4BOEVgvPWh4fT0KrtVBgsxvuUzqsv8R0Ub9p2rucCli23CHwraSdax647ZfgEJcaeUxq/XVciCqGAvmLQYVItF4ZxERZ/XQVsV3lQZJfhHbFfCBdP4f5oSIBrw7pOjHLT9LBWY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MNt+f7qi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MNt+f7qi"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so7896930a12.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781689683; x=1782294483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QdQf/PXmxwBxJEfIxvzXn7CE5/BE6Ix7pQBqOp/bi/o=;
        b=MNt+f7qimkg84VIlsyYGR0SjoNvJiwmuHIkprTYRF4aajYUS9BG7VwIOUf5nMTUcLc
         YvlOd1oImn6vpCJ0N+Jk7of2jQxWWkYA2yQq3F1rtJL36sje/R+W4lSWrntnEoBrzZrl
         Wc430PTNEVCQ2HwJOVyqPUfc0sgdjNUd0iW3gyBYnVZhUSrOba/cXkw9riXfZY5LUyum
         uiqBN18mOosPrQ2VxJvAgvOMUVOdkXaYaUzZA+ykScnMs68pY61kRuXG+MtDMEbhlDdb
         0oQs6sS2EkGWH1FMtml5Bx/Xk1PBC5mIPPyha+l0809/7yCCqlOU5bJ+AuZ1nygDkYlc
         hRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689683; x=1782294483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdQf/PXmxwBxJEfIxvzXn7CE5/BE6Ix7pQBqOp/bi/o=;
        b=iCdjQgd1HOvJsHA60KZb1so4rUP628P8AI3cAaUjCyelmVgtAVsFWcXW4EF0jm2H96
         TkdkF7Q684C7ZwZM+QBj6lrlwI07MBwp4m0YAkv1Sw2N884M3uWw0OlGBBNm1XvIKp0F
         dn8BdKGzKxKUi4KUd6DpInE6nsczlJEOWZ1rFHNH2dlLLXwEZEw05+rOnDIvDwwpNjSk
         ZEy09C4HH9BkrgTQS3J7TmesxWPgF9fO+vy66TLwDDS2JYSiSn9ikN/oa+eCQQ8v6aE7
         /Snl7YmV8+dzTF5BR9oQaHcqxDqipWUZ7/PWNba+i6ax6DJxWnx2g/ejjAR/lDMg3AmH
         BeNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gwvmLJJ2A9cmD/XfusYeU00mILihybT84SMQfuW/YiM2E7F/JwsDNyscIXp5XFmJBpm0QGzbcF6nabg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoNqIvkQ/xU3DuXsqqahsvVQO+IiVoUEgORci7oc6RIVFpApx
	RT+OOSC09WeogQEysApO0XrA6s2bJt5mxpchvY7S3vc8OsWvi1VgWKzR6z2eSbXGXw==
X-Gm-Gg: AfdE7cmlvj7FbOlkDJ1hUAzFOx+J2PPcRjHa2gvFDBwLB211apis1UTE9/a60wvGKyV
	cgQKm7GOuUi/OcjgfiHUYDHtMaw/rGMAA7z7snRWKQrNy70sCO/fdidxOTE5kk3hTGpt6EiFpqG
	0fh69+dDVkj4hd1NBsgycl6pCsV5wXSVfzN0DuGGD2kPP2Cq/41105k3BHFWqELhFZF0NH35sfX
	sxyUc1ahLgPQ7ghLP6ejpW+g/6lws+EmsHRVdEaA8eLLdwqgsf36CN5ZF6xx2CkOJQu4QaBkYv+
	tL+LT7nwvZAPe3OyLWs9AXIbEazLQTaa1JfB7V49RzZmzkrxog40L6KJWckVjbnPozKnLOTlQ+D
	KQPeAEIdSKqHUdaoe3VUhbakwU+WsjxrzGq3vNiDL/Hom3zT68V/ZBhSUU5uiOs6nUhs+0mASHF
	meVpCC1LEex2Q3+AVnQqLGQc3/+LfP3WxVmodm9wlrqtI=
X-Received: by 2002:a05:6402:354b:b0:691:55d9:fff5 with SMTP id 4fb4d7f45d1cf-695475802dfmr1517281a12.10.1781689681924;
        Wed, 17 Jun 2026 02:48:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:6052:259b:70e8:45e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693794b36d7sm6592057a12.31.2026.06.17.02.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:48:01 -0700 (PDT)
Date: Wed, 17 Jun 2026 11:47:56 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: Landlock: LANDLOCK_ACCESS_FS_IOCTL_DEV bypass via io_uring
 IORING_OP_URING_CMD
Message-ID: <ajJtTHyqWTmX7lHo@google.com>
References: <20260616201633.275067-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616201633.275067-1-hexlabsecurity@proton.me>

Hello Bryam!

Thanks for the report!

On Tue, Jun 16, 2026 at 08:16:41PM +0000, Bryam Vargas wrote:
> Hello Mickaël, and Landlock / io_uring folks,
> 
> A task confined by a Landlock ruleset that grants READ_FILE/WRITE_FILE on a block
> or NVMe character device but withholds LANDLOCK_ACCESS_FS_IOCTL_DEV can still
> reach the device-command surface through io_uring IORING_OP_URING_CMD with the
> IOCTL_DEV check bypassed: the request enters the device-command handler (block
> discard, or the NVMe char-device passthrough) where the equivalent ioctl(2) is
> denied. The destructive completion and the NVMe-admin surface follow from the
> code -- see Impact.
> 
> Affected
> --------
> Any kernel with CONFIG_SECURITY_LANDLOCK=y and Landlock enabled that supports
> LANDLOCK_ACCESS_FS_IOCTL_DEV (Landlock ABI >= 5, since Linux 6.8) and io_uring
> uring_cmd for the device class (block BLOCK_URING_CMD_DISCARD; NVMe passthrough).
> Confirmed by source inspection on mainline (v7.1-rc7) and reproduced on Linux
> 7.0.11 (Landlock ABI 8). The confined task needs a writable fd to a device it is
> legitimately allowed to use (e.g. a partition/loop device or an NVMe namespace
> passed into a container or granted by the ruleset); no CAP is required to reach
> the io_uring path. The gap is structural -- Landlock has never registered a
> uring_cmd hook -- so it is present from ABI 5 (Linux 6.8) through current
> mainline (v7.1-rc7) and is not a regression tied to a single Fixes: commit.
> 
> Root cause
> ----------
> On the ioctl(2) path, the syscall handler in fs/ioctl.c calls
> security_file_ioctl() (its only call site on the ioctl(2) path) before
> dispatching to do_vfs_ioctl(); that reaches Landlock hook_file_ioctl_common(),
> which denies a device ioctl unless the file's
> allowed_access holds LANDLOCK_ACCESS_FS_IOCTL_DEV (BLKDISCARD/BLKSECDISCARD/
> BLKZEROOUT and NVMe passthrough are not in the is_masked_device_ioctl()
> allow-list, so they require the right).
> 
> io_uring reaches the same device-command surface by a different producer:
> 
>   IORING_OP_URING_CMD -> io_uring_cmd()   io_uring/uring_cmd.c
>    -> security_uring_cmd(ioucmd)          (the ONLY LSM gate on this path)
>    -> file->f_op->uring_cmd()             e.g. blkdev_uring_cmd() / nvme_ns_chr_uring_cmd()
> 
> Landlock's LSM_HOOK_INIT list (security/landlock/fs.c, net.c, task.c) registers
> file_ioctl/file_ioctl_compat but no uring_cmd hook -- only SELinux
> (selinux_uring_cmd) and Smack (smack_uring_cmd) gate this surface -- so
> security_uring_cmd() returns 0 for a Landlocked task and hook_file_ioctl /
> IOCTL_DEV is never consulted. For block, blkdev_cmd_discard() is then gated only
> by BLK_OPEN_WRITE; for NVMe, nvme_ns_chr_uring_cmd() reaches the admin/IO
> passthrough with no security_file_ioctl on the path. There is no shared helper
> that re-applies the IOCTL_DEV check.
> 
> SELinux and Smack hooking uring_cmd while Landlock does not is the coverage
> asymmetry; the Landlock documentation describes IOCTL_DEV as gating ioctl(2) but
> does not mention io_uring.
> 
> Reproducer
> ----------
> A self-contained PoC is available on request (it needs root only to set up a loop
> block device and open it; Landlock enforcement is uid-independent, so the
> confined child demonstrates the gap regardless of the setup uid). The child
> applies a Landlock ruleset handling READ_FILE|WRITE_FILE|IOCTL_DEV with a rule
> granting only READ_FILE|WRITE_FILE on the device, then:
> 
>   (1) ioctl(fd, BLKDISCARD, range)        -> -EACCES  (Landlock enforces IOCTL_DEV)
>   (2) IORING_OP_URING_CMD,
>       cmd_op = BLOCK_URING_CMD_DISCARD     -> reaches the block command handler
> 
> Observed on Linux 7.0.11 (Landlock ABI 8):
> 
>   [1] ioctl(BLKDISCARD)   -> ret=-1 errno=13 (Permission denied)
>   [2] uring_cmd(DISCARD)  -> cqe.res=-22 (Invalid argument)
> 
> A Landlock denial is always -EACCES; the io_uring path returned -EINVAL, which
> originates in a post-authorization check inside the block command handler
> (blk_validate_byte_range() in blkdev_cmd_discard()), reached only after
> security_uring_cmd() returned 0. So this run demonstrates the authorization
> bypass -- the request traversed the LSM gate into the block device-command
> handler with no IOCTL_DEV check -- and then failed a parameter check, not an
> authorization check. The destructive completion (an authorized discard with a
> granularity-aligned range) is the expected behaviour but was not exercised in
> this run.
> 
> Impact
> ------
> Demonstrated: the LANDLOCK_ACCESS_FS_IOCTL_DEV authorization is bypassed. The
> device-command request reaches the block command handler with no Landlock check;
> the only remaining gate is BLK_OPEN_WRITE (held, since the policy granted write).
> Inferred from the code, not exercised here: an authorized DISCARD with a valid
> range completes (DISCARD/secure-erase semantics, destroying on-device data), and
> the same missing hook leaves the NVMe char-device uring_cmd surface ungated --
> nvme_ns_chr_uring_cmd (namespace device /dev/nvmeXnY) -> nvme_ns_uring_cmd for
> NVME_URING_CMD_IO/IO_VEC passthrough, and nvme_dev_uring_cmd (controller device
> /dev/nvmeX) for NVME_URING_CMD_ADMIN (format, sanitize, firmware download,
> security send) -- both reach f_op->uring_cmd with no Landlock/IOCTL_DEV gate.
> 
> So the confirmed finding is a missing authorization (the confined task escapes
> its own IOCTL_DEV restriction); the destructive data effect and the NVMe-admin
> high-water-mark follow from the code but are not shown in the run above. The
> proven authorization bypass alone scores CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:H/A:N
> (6.5 Medium) -- S:C because the confined task crosses the Landlock policy
> boundary it was placed under, I:H because the bypassed path reaches a handler
> whose authorized completion modifies device data. With the device command
> completing destructively the projected ceiling is
> CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:H/A:H (8.4 High), the A:H component
> reasoned from the source rather than executed. No memory safety is involved.
> 
> Suggested direction
> -------------------
> Have Landlock register a uring_cmd hook that maps the device command to the same
> checks the ioctl path applies (IOCTL_DEV, and truncate where relevant), so a
> single chokepoint covers every f_op->uring_cmd provider (block, NVMe, ublk, and
> any future one). Mirrors how SELinux/Smack already gate this surface.
> 
> I am happy to send a patch for this if you would like.

I have read through the code a bit, but I am not sure I follow the argument of
this report. Let me paraphrase my understanding --

* LANDLOCK_ACCESS_FS_IOCTL_DEV is documented as blocking ioctl(2)
  commands on opened character and block devices.
  (c.f. https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags)

* One of many block-device IOCTL operations is BLKDISCARD.

* Block devices offer BLKDISCARD over io_uring as well,
  but io_uring does *not* offer a generic interface through which you
  can do IOCTLs.  It *only* implements BLOCK_URING_CMD_DISCARD in that
  place.  The header where that constant is defined happens to use one
  of the ioctl macros to construct the number, but points out that "It's
  a different number space from ioctl()" (see
  include/uapi/linux/blkdev.h).

So... while this is similar to IOCTL, and while this block device operation is
also available through ioctl(2), this is a different command multiplexer
than IOCTL and I am not convinced that that namespace should be guarded with
the same LANDLOCK_ACCESS_FS_IOCTL_DEV access right.

Do I understand correctly that the only operation affected in this report is
BLOCK_URING_CMD_DISCARD?  Or are there other operations affected by this
(through other devices)?  I saw you also mentioned the truncate right above,
but I assume that for this access right you have not found a way to side-step
it (assuming that this calls the more specific LSM hooks).

Thanks,
—Günther
