Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34813368D7E
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704459; cv=pass; b=LtugeC4H2Hph23SkjCnwC1hHQq07N+8WgCBF+PiHTaLc/3SIpmPfdX49yM1/ZHxAeoDT5d0pdzVRX+V95gw3ytYbR0JGQDpnQM27QNJ096hrdLwyYpgBTiax9ZocMdOyLvJ0o6sbGE760iXmbSr6lxxf701qrd7n87bDH276fD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704459; c=relaxed/simple;
	bh=QqaIYA8X3X6Tew9rng99hk3rmPCslU/eWwD53qMGzFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNr4DYxFp4tSustnu5y0G4SGbg3XUWc9w477Yl21Nbu40TemVmUbvyw5JuZAgFb0uQeFiqHpEqwff+VvZPQloyewoBitk0lAahzxpfpcK9ZrR0PojJ2jTHjWY9J6oyXttewIllWd0iYYUxbrDjGpsec5L06frNu6mbAtLPpwI0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD9fcV9D; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD9fcV9D"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b98482b253so96271606d6.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 13:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778704455; cv=none;
        d=google.com; s=arc-20240605;
        b=lG7Cb6E0dtku62IpJY5CjvuxNjtDIZ5I5Mu290HUewJxWH+WhUQMTinTA2Pey8WLrl
         RcGCHWg27zntNyaNyXgkIsKTy3BC7Ertp0+jAxOAArD2SgcZEWqGxH0hGcPfO/EEdg59
         20Ci7+n+thSk9uMHsUi5w5XyNLg0CbdWdCZEYGOYNfhW3NttgYKPW9WjJb0ITM9YixfM
         Rifq4c7EKgA72aUTQ+wUQcwzJvcnTms1UY2qPcvQFx6KX+VKEpAmhCOtJTOnko+FN050
         Mbkw+sw7F06/xHE/13X5TfiieQCT5G3XttcwjLPMliGy1RdujD5eooERCMW8DLJ2Lx0N
         kTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        fh=70+cGnL1HVVpTJUJ83OH1WIqAU/gNfFIK2ZyEQ/Bb4s=;
        b=iMXt9EW8aH50FvvaXOZADBL79l31rhKmCBGL4N31gbOoZfZbmj6ZkpaDEEFvKKloJR
         iIWxoYGU5ePbITaVAmYUbl3gWYymNb6cvvybwsYb3AJxT846QJBx0O1NeWlNX23UIuwZ
         omcmp0RN+ipbt1lz1IwPrlUHdDMymWPRup0ep4V+3mYD84dOwKPwMJ/xjEIrLWIzzKlO
         9HHVOCBWA5+e52gvgZV5ZnyScZycE8Xmm+4iLn2rR6C/XOqV3smtlC1AMvZP+ZfMSlny
         yIuUejemsA5ouLkihv1HmEpazlx3mO6EnLPq5OC0ZBFEKSYia5QhkDj1991ezZO4fq4i
         9iUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778704455; x=1779309255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        b=AD9fcV9DHYgDCefhJ2zSXZDp5IsgxaGD+U0MOWxRyeVB9HxtlwiRupMCngACCv3gN3
         DM2QnrQXjV+sYmnB7buk4J5Dt6tGrh1OPZBWVQB8b9fCQmOKih3ywWgVh1komLd2T6S9
         Iw0vFCUrddNFBUe65lmXniDofheSzrnXitWFheF975H4HOv5OAkzK3mkvFZBQzbbEFO5
         3CBUV04Gi5ikM28vxU2ZcJDeIaaPgXBzn1SOf42ImQdPsuYoVzWX98ke8U7+4SKfTYHq
         rgiLecCrmAZpjPBD/RK6amLrzQARySCD79r299h/pV/nX/61R2SXk8dj58MY+M4wHe8N
         AnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778704455; x=1779309255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YffvRc4ueiaHAv5vxRd/K/yTD1qBPNZn3LhENW3N4xg=;
        b=meT0ahVHCLAn+RTh4nVBq7GLRLLG6Bv9s/d7MFTamK+wHZWtDo68kZwgRx2cr4TaVi
         glnWhsCOmmdmXThIIrAWtfOSRWXjt+LjADOBO1q/AQbaWBNsaAtdJ6QiKkkPCwCIUCKI
         95IjDq/KHzmdOC7nck6BstOYFWxqriT96Eq7xITubkBTFmGDRyY2OQ3IuXPf7EdY55A7
         bnYsPfAxjxOmoYWVbVGNHFvjWyXP4DdNXOmM2WZbwQYAvGdGFCE4UicWhtmqXpDhau3Q
         c1Eu9+MojcGomwbGfu9hkKzNc5tXArUsT3biyD186uHNAH4MFBmWMnHwOW3qG/2jHBe2
         D3lQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NSXYOD8XacYOwFo4pku4qFExjYZ+fll57UmrUlP1YLIZsMcd6CgHRMNBhDS+0Yi2eCgZ9YbkhE3pCIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3z2OU4tQXFF2vqLkPYTcj632qhS4pCpLIvG+I2b/My5m2LbJn
	duhfx/7fFxMA5Du0nziEdfUktcnaMYaE0xiNTR4fTNCnK1Cjjnomdfc4RGukrP67ybtCNSx9HUi
	HlolwumFgeeKKagtF+EojfHjlKzumdZY=
X-Gm-Gg: Acq92OEI8EU7o8IoHYKTvq35pFg5COXpwcXSJ8ehai6Rc/zOBslYr6MUq7WTTLDSKmx
	Q9nhCqd1tDjfQtXBAraq38xdfsVMdHDTuhiVSuRHAiROwQ0ztcbWcEQidxHklbQXJcwCQ1XHw1L
	jHaLoa/ahd2Skd/7C+Yl1et8gjTUW3gn8OrOm4j3EtjVFI5qy9ljGCpn6C3gKllLahQCHZhPYHr
	kEjn/ORC8TJRCzg1wBVJ2VnkYC0t2KTafjEvvlg5pYPIz5+XR2Eq3WsxO830BMEpv9jsbeHYHfB
	Rs3Puh78is2MjujOzhW0cBYa2qXyX/53GGIjV2YzijMMz6rdzKMdjCbmIvgwIvzNz11h9tg/xuz
	NnHzv0xfVbxObAa2RQgQLf8iB5+x05cGSlqWscwdUcr1SSTxcbXYrApYa5ymQ+hffSJccwuZFND
	u6ujLVTSF4GmXAjO0YctteBA==
X-Received: by 2002:a05:6214:8009:b0:8a0:846e:8850 with SMTP id
 6a1803df08f44-8c7b9d6a34dmr79395336d6.20.1778704455206; Wed, 13 May 2026
 13:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
From: Steve French <smfrench@gmail.com>
Date: Wed, 13 May 2026 15:34:03 -0500
X-Gm-Features: AVHnY4LdSaGvyovg6RvG5pKhPWnEZkoZnNgrzQdw3V-htIBym1ah9EOHikjxM8Q
Message-ID: <CAH2r5msnYVb3hhXHwqDVHGGC1h4E6mLCRS4ktCrQoD9zdUW81g@mail.gmail.com>
Subject: Re: improve the swap_activate interface
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just tried this on 7.1-rc3 with the swap patches (full kernel build,
on Ubuntu 25,10) and boot failed with out of memory which I had never
seen before.  Any idea how to workaround this with the swap patch
series, or is there a fix for this in the swap series already?

On Tue, May 12, 2026 at 12:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> Darrick recently posted iomap support for fuse-iomap, which was trivial
> but a bit ugly, which triggered me into looking how this could be done
> in a cleaner way.  The result of that is this fairly big series that
> reworks how the MM code calls into the file system to activate swap
> files to make it much cleaner and easier to use.
>
> I've tested this with swap devices manually, and using the swap tests
> in xfstests on btrfs, ext3, ext4, f2fs and xfs to exercise the different
> implementation.  Out of those all passed, but f2fs actually notruns all
> tests even in the baseline as it requires special preparation for
> swapfiles which never got wired up in xfstests.
>
> Diffstat:
>  Documentation/filesystems/iomap/operations.rst |    3
>  Documentation/filesystems/locking.rst          |   35 +--
>  Documentation/filesystems/vfs.rst              |   40 ++--
>  block/fops.c                                   |   15 +
>  fs/btrfs/btrfs_inode.h                         |    3
>  fs/btrfs/file.c                                |    4
>  fs/btrfs/inode.c                               |   72 -------
>  fs/ext4/file.c                                 |    6
>  fs/ext4/inode.c                                |   11 -
>  fs/f2fs/data.c                                 |   50 -----
>  fs/f2fs/f2fs.h                                 |    2
>  fs/f2fs/file.c                                 |    4
>  fs/iomap/swapfile.c                            |  165 +++---------------
>  fs/nfs/direct.c                                |    1
>  fs/nfs/file.c                                  |   21 --
>  fs/nfs/nfs4file.c                              |    3
>  fs/ntfs/aops.c                                 |    8
>  fs/ntfs/file.c                                 |    6
>  fs/smb/client/cifsfs.c                         |   18 +
>  fs/smb/client/cifsfs.h                         |    3
>  fs/smb/client/file.c                           |   16 -
>  fs/xfs/xfs_aops.c                              |   48 -----
>  fs/xfs/xfs_file.c                              |   39 ++++
>  fs/zonefs/file.c                               |   30 +--
>  include/linux/fs.h                             |   11 -
>  include/linux/iomap.h                          |    5
>  include/linux/nfs_fs.h                         |    3
>  include/linux/swap.h                           |  129 +-------------
>  mm/page_io.c                                   |   45 ----
>  mm/swap.h                                      |   92 ++++++++++
>  mm/swapfile.c                                  |  227 ++++++++++++++----=
-------
>  31 files changed, 471 insertions(+), 644 deletions(-)
>


--=20
Thanks,

Steve
