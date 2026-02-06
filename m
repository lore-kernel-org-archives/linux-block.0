Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC840FDB8
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770403377; cv=pass; b=YV/c+AHB0InMYAgepChlszxHa+yvxdC765KIE5sfqdhIDp6JlECbKhedZcgOeWA6odjgT5H9wH2huiAS//Sb7JgmMEGWMMexR0gns+a2krYEMKviVsry9Lgh9DfzFEISzZpC2k5CtsqteV/ovav0TnB1Yo0bmo8BabkNtr4a/ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770403377; c=relaxed/simple;
	bh=g8Y05MZTXiuFZYd64ykcy98HIVrpwYbXDId97ydkZYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mah8+TAzUogCuAkAti+3ZCR0iJTniYqpCTL6LTAM3EWa9ty+UDwLL/Ynei1lNxeniBir70IEqhtPAzvalEdj10idICQLewrizHE5U6+92jSrpN/HesxjwZTWjVQUBRH7lF5Pfvqr/SwGQQ307hu8jK3Pa5iSLGWKOVUmnEkq/NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E8yQja34; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E8yQja34"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so22834285e9.3
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 10:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770403375; cv=none;
        d=google.com; s=arc-20240605;
        b=arovaSBaA4tlK9DfR3a7++hHKLRFWtQyOUYrJKFfmFn2g4TUNvs5yuRl/8S/mtY3JJ
         Z3ay6hMH+QWpFKObV1P3qqdr2yN1mupV7B0+Qc4smbK2LN7LqgAtzLt56Lr46YGdp3KO
         ga2HwUG2U3bsPR33Tc8humtvZRCTkFs9PKnikHJ/owomTPRkzz12ggFUvAR5Fhe57rfr
         czR6hwNH1Jc6nAbT79VbfA7hmO0DGND0Jnk925xNxIi//cwgCPer3ockbiMv2Mfd8T4h
         ++NmHj2Y+6Qbm7fxzWHZ/Q2UUbg2oVwo+ng2t7DD3tzHx/6Faij7Vi0xoha+u5yt+mIK
         32dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sxa3uxhQCjgxX8L2FFCW63mMb6ghyNt+G2P+1nE+3T8=;
        fh=yj9Z+a7naWBEJo4Y1rbVIXXqbbXbjU77ojq2sL5+uoA=;
        b=YV+TEGH5AQ9PzgLTuv6N826A10xs1JuO8NufI7Is0lQxY557+ehpXGxmkmUGe2eilf
         nkRxrq+Om0VjUM3VQF5lpp0070rhBua0ZgrDlnMfgbjGahh/dL+DReHcnEJoBx0w7rNE
         r5monahlqbtZ/R2THcPAr+spNH4gPCXFSRKlXUMlsnwNHOCZacu6d4DT+R8uwu+/iEDr
         qWyfY1bu7+tVlEId4KvaDqCx/ZfIx6sUGZgSFy46s7aMdKP+xX/X8V5plF8bKY+blUZ4
         8GnSs4V3aKuYkqq2EITrFj4uexxuNEb3a7msyibfhaES8zLVVGx7LVx3HIZqM4p5xq6P
         Qrug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770403375; x=1771008175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxa3uxhQCjgxX8L2FFCW63mMb6ghyNt+G2P+1nE+3T8=;
        b=E8yQja34o1ZTqQjsLKMpplW253rLuzLMpB7gHSKNHCFgB4etc0KTFhal+BdTAgCwB/
         F+iw8gxD4FQz9NV00eWtyo5VwRDTXXaXzDiLXxg6AkGNao6DqtaRJD0O0oJQ6j83CC/R
         /EWpSD+HvRQCxV/6KpVUkiOY1eALHwFvyDHSmqf5Yhowj5lCQTUl7F1mauRVo/fWzJe8
         MfsLccPN/i3Br4IQuUfKjuQoywNxqMHq8wASvJCvC3DLydU1d7o6FsjHoWuVIzMfXbVY
         oFonGh7xgLSgsEDX97aMO9ZmajQmsIquyLJAX05HtuuHN6YHoYU526YVr+fuCm3kjMtQ
         Uu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770403375; x=1771008175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxa3uxhQCjgxX8L2FFCW63mMb6ghyNt+G2P+1nE+3T8=;
        b=O5Pkmny3s0IXEszdphf3KRHD0e4GpKMC6i7pl6H0RQGNmnfq2yEqC/TpAK06nnGsLx
         WIUSrhKf6ZWu/o29ZBgHmsC2OcG9W/1Vrpl0jnmFlh7MGeWHJuiKxix7yuo9lcseC2to
         fjvJDD8W8U2Up9OsovDvU5tw0FqH/EQf/NWv2wjvoWIqzbumJ07ynkJNWv/mVWWSmOAM
         yNSb+69qbtTzF0C2BntDGpu9clxGRUO7ajUTxAeJF7rsbNcAtjRYEuxAYYsoedW3X7G6
         r2YljsXzLhfBegSsgT3KPtknC3oDGRhlsBiPzw0R4ubIDjBaLMS7SyQ2JwU7IMekTQtB
         h67A==
X-Gm-Message-State: AOJu0YwNVaLfvpUqWaQ9RIjZWqOsL+Cy5Zm+pmP0ERlnXma4NBuuq27W
	HJ/okBMCsdfqkpDKBZVg5Vukd/EHa4MmenlT0XvRUmmmT8NPRmx58upLQkaWB7Csu7D/G240Qr3
	iRf9UKJBHQHK39AB2g4FBozAHUDIo5Tqo6hLsfzo/nTldJ/awNEDV
X-Gm-Gg: AZuq6aKSXa3mFoFA0Zwd+dbFsjOJ8Xu5SsbYYZozHzs4U9+FQCcbO6AZNJZ0rUaOp1F
	luGoxQy8sfWcA/YHNrp7a3IkZnQUnAowUOcADny+Chk9COTMKdw3YCsAp0bgH/yl2LcutHc9rYI
	a1Z4sCVE+J3D7f/x/tRwAxLPCXtGAPMaAdyqR18S4G0qJaTocw4BrBHf3MWYVXxP9NqufUx3/We
	L4LWKEMdGFuUikoMD6MQv+kUVwoV1N8Of8eLax7G/78B4MOBi2GO5iy80vJftA+2ur4cQhXw/TH
	x/cbh3lAUUaaAgQPgOpRbMGS+Cg+jRBGV4wuQQc2pFNMHiZ3TlORxMqId35YibzVbEMO
X-Received: by 2002:a05:600c:1d8c:b0:480:6873:b2f6 with SMTP id
 5b1f17b1804b1-48320216ce4mr47675115e9.20.1770403375319; Fri, 06 Feb 2026
 10:42:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com>
In-Reply-To: <20260206182336.1397715-1-neelx@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 6 Feb 2026 19:42:44 +0100
X-Gm-Features: AZwV_QjVbpQ8MRsr1Ro9fPeDc-ZyPEQuxPOuPcg2A5_GzI5Zx2BISHue62_Jkik
Message-ID: <CAPjX3Fc_VNNXoJaa4uYoX_EJ7YK_z2BVM84oOtfg1ME-8qyuDw@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>
Cc: linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Heads up,

I also have related btrfs-progs and xfs-tests changes matching this
series. But I won't be able to send them before my vacation next week.
That also means I will (most likely) not be able to get back to review
feedback before Feb 16. But for sure, any feedback is appreciated.

Thank you,
Daniel

On Fri, 6 Feb 2026 at 19:23, Daniel Vacek <neelx@suse.com> wrote:
>
> Hello,
>
> These are the remaining parts from former series [1] from Omar, Sweet Tea
> and Josef.  Some bits of it were split into the separate set [2] before.
>
> Notably, at this stage encryption is not supported with RAID5/6 setup
> and send is also isabled for now.
>
> There are a few changes since v5:
>  * Rebased to btrfs/for-next branch.  Couple things changed in the last
>    years.  A few patches were dropped as the code cleaned up or refactored.
>    More details in the patches themselves.
>  * As suggested by Qu and Dave, the on-disk format of storing the extent
>    encryption context was re-designed.  Now, a new tree item with dedicated
>    key is inserted instead of extending the file extent item.  As a result
>    a special care needs to be taken when removing the encrypted extents
>    to also remove the related encryption context item.
>  * Fixed bugs found during testing.
>
> Have a nice day,
> Daniel
>
> [1] v5 https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/
> [2] https://lore.kernel.org/linux-btrfs/20251112193611.2536093-1-neelx@suse.com/
>
> Josef Bacik (33):
>   fscrypt: add per-extent encryption support
>   fscrypt: allow inline encryption for extent based encryption
>   fscrypt: add a __fscrypt_file_open helper
>   fscrypt: conditionally don't wipe mk secret until the last active user
>     is done
>   blk-crypto: add a process bio callback
>   fscrypt: add a process_bio hook to fscrypt_operations
>   fscrypt: add documentation about extent encryption
>   btrfs: add infrastructure for safe em freeing
>   btrfs: select encryption dependencies if FS_ENCRYPTION
>   btrfs: add fscrypt_info and encryption_type to ordered_extent
>   btrfs: plumb through setting the fscrypt_info for ordered extents
>   btrfs: populate the ordered_extent with the fscrypt context
>   btrfs: keep track of fscrypt info and orig_start for dio reads
>   btrfs: add extent encryption context tree item type
>   btrfs: pass through fscrypt_extent_info to the file extent helpers
>   btrfs: implement the fscrypt extent encryption hooks
>   btrfs: setup fscrypt_extent_info for new extents
>   btrfs: populate ordered_extent with the orig offset
>   btrfs: set the bio fscrypt context when applicable
>   btrfs: add a bio argument to btrfs_csum_one_bio
>   btrfs: limit encrypted writes to 256 segments
>   btrfs: implement process_bio cb for fscrypt
>   btrfs: implement read repair for encryption
>   btrfs: add test_dummy_encryption support
>   btrfs: make btrfs_ref_to_path handle encrypted filenames
>   btrfs: deal with encrypted symlinks in send
>   btrfs: decrypt file names for send
>   btrfs: load the inode context before sending writes
>   btrfs: set the appropriate free space settings in reconfigure
>   btrfs: support encryption with log replay
>   btrfs: disable auto defrag on encrypted files
>   btrfs: disable encryption on RAID5/6
>   btrfs: disable send if we have encryption enabled
>
> Omar Sandoval (6):
>   fscrypt: expose fscrypt_nokey_name
>   btrfs: start using fscrypt hooks
>   btrfs: add inode encryption contexts
>   btrfs: add new FEATURE_INCOMPAT_ENCRYPT flag
>   btrfs: adapt readdir for encrypted and nokey names
>   btrfs: implement fscrypt ioctls
>
> Sweet Tea Dorminy (4):
>   btrfs: handle nokey names.
>   btrfs: add get_devices hook for fscrypt
>   btrfs: set file extent encryption excplicitly
>   btrfs: add fscrypt_info and encryption_type to extent_map
>
>  Documentation/filesystems/fscrypt.rst |  41 +++
>  block/blk-crypto-fallback.c           |  43 +++
>  block/blk-crypto-internal.h           |   8 +
>  block/blk-crypto-profile.c            |   2 +
>  block/blk-crypto.c                    |   6 +-
>  fs/btrfs/Kconfig                      |   3 +
>  fs/btrfs/Makefile                     |   1 +
>  fs/btrfs/accessors.h                  |   2 +
>  fs/btrfs/backref.c                    |  42 ++-
>  fs/btrfs/bio.c                        | 146 ++++++++-
>  fs/btrfs/bio.h                        |  14 +-
>  fs/btrfs/btrfs_inode.h                |   6 +-
>  fs/btrfs/compression.c                |   6 +
>  fs/btrfs/ctree.h                      |   3 +
>  fs/btrfs/defrag.c                     |  14 +
>  fs/btrfs/delayed-inode.c              |  25 +-
>  fs/btrfs/delayed-inode.h              |   5 +-
>  fs/btrfs/dir-item.c                   | 102 +++++-
>  fs/btrfs/dir-item.h                   |  10 +-
>  fs/btrfs/direct-io.c                  |  28 +-
>  fs/btrfs/disk-io.c                    |   3 +-
>  fs/btrfs/extent_io.c                  | 115 ++++++-
>  fs/btrfs/extent_io.h                  |   3 +
>  fs/btrfs/extent_map.c                 | 102 +++++-
>  fs/btrfs/extent_map.h                 |  26 ++
>  fs/btrfs/file-item.c                  |  28 +-
>  fs/btrfs/file-item.h                  |   2 +-
>  fs/btrfs/file.c                       |  75 +++++
>  fs/btrfs/fs.h                         |   6 +-
>  fs/btrfs/fscrypt.c                    | 446 ++++++++++++++++++++++++++
>  fs/btrfs/fscrypt.h                    | 108 +++++++
>  fs/btrfs/inode.c                      | 408 +++++++++++++++++------
>  fs/btrfs/ioctl.c                      |  41 ++-
>  fs/btrfs/ordered-data.c               |  35 +-
>  fs/btrfs/ordered-data.h               |  14 +
>  fs/btrfs/reflink.c                    |  43 ++-
>  fs/btrfs/root-tree.c                  |   9 +-
>  fs/btrfs/root-tree.h                  |   2 +-
>  fs/btrfs/send.c                       | 134 +++++++-
>  fs/btrfs/super.c                      |  99 +++++-
>  fs/btrfs/super.h                      |   3 +-
>  fs/btrfs/sysfs.c                      |   6 +
>  fs/btrfs/tree-checker.c               |  67 +++-
>  fs/btrfs/tree-log.c                   |  34 +-
>  fs/crypto/crypto.c                    |  10 +-
>  fs/crypto/fname.c                     |  36 ---
>  fs/crypto/fscrypt_private.h           |  42 +++
>  fs/crypto/hooks.c                     |  38 ++-
>  fs/crypto/inline_crypt.c              |  84 ++++-
>  fs/crypto/keyring.c                   |  18 +-
>  fs/crypto/keysetup.c                  | 165 ++++++++++
>  fs/crypto/policy.c                    |  47 +++
>  include/linux/blk-crypto.h            |  15 +-
>  include/linux/fscrypt.h               | 125 ++++++++
>  include/uapi/linux/btrfs.h            |   1 +
>  include/uapi/linux/btrfs_tree.h       |  26 +-
>  56 files changed, 2683 insertions(+), 240 deletions(-)
>  create mode 100644 fs/btrfs/fscrypt.c
>  create mode 100644 fs/btrfs/fscrypt.h
>
> --
> 2.51.0
>
