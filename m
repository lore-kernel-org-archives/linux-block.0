Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE2369999
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967384; cv=pass; b=PGubV9oDIAl3NkuWqTWNES5ZMTGAWQjL/BAGdfNkTf4GFiMMCrMcIPXdTrC+gySsIs3nL2YYw4u/QUV3lIpoSfwvI6PFkdTaKUk++S/dxBIs5kHL4DBJgOuYG/bMMcphtvtI9SIZQxcI784TClNeyqplsLk4ZZ2IbLG6r4qtbzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967384; c=relaxed/simple;
	bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbPkJ/uvh7LtPv3439Zzzo5bHxk21dTpsxv3uI9wuW7EAtYoAlxOTQXNQdJyYjCUsQ176kJaiTxC123YQZp332xO1N1ZclX0uEs3vvpB/fBv7J18iMhnA2n03/Xu0cRoYU6pE8ol3KM4cpwTAexLE5IicxIuaTC3trX81rEYbMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RnaXudyK; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RnaXudyK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69490c91241so217594eaf.3
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 11:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776967381; cv=none;
        d=google.com; s=arc-20240605;
        b=XIFWXrv59pPuKvW+onkx9Pnmlwr5NS8zNRQIrUO30U4xNjHxFD/A8NV1ht3EnqU1fs
         /ZLzIm5kZzvb+/fb7Z5isFjxCsjsbJFBvXY9bp2A3AoOMk+6jWMKVYUYWpLcqCaMzfWG
         yUSrLT18/PlhimCnJ6VxTi6XznqfwKfaFqLpCHQGX2EesuiXuRm5PdpvEyEzdVE9wT9Z
         P7lkuD7ImYpiqDDaoHFT6UV+731uhuKwpOCbTq0N+SXZLS77O9KQ9X4y37Gk+P+1Vaio
         tQZL6ZODwSM4YPcTn4SJ0RRTDgxIKHgHonXwbve2cXBJY4xBhOSufAsGZUEpF1Ujpz1E
         8ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
        fh=1N0Fw5s8nH9p5aRJlhy896acx4tFudEOJDGwRgIB6u0=;
        b=ZBEPrjFOlulG80bH1MuShmqDwOzAPuEgrCeH7KXn+1iGD12ZIXBVlBQGTjAAs6XbBj
         b4aKnJjb8noNWndiNqQBGUd4X+0McwbMzP7kvXrwJ8df0cz002D2vbjcUTK0RAEw2Yam
         FMPPCOS+omT/bfqfnyVDkgQYencUuVd0HiRvPziT1XDz2KTW13/8Ht1vaGG2hq5AqDtU
         6iikpLT6vdAtYt+9/cdqV2ZwaYnzGPkWY5U02UygIF5vlMmGLytveq2jS6Nx15665lOs
         pACEpQgbYr5zVoLohVqujDyu3WK3ud/rHOLTbWDwBK5hnHXyX4bdFc66n2viZer6LF1I
         vo0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776967381; x=1777572181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
        b=RnaXudyKoIRW7/MZFIRNUV3etWC4Z1oh6blReqmk9KsUHGLVtiZJhueSL+EpsWHShy
         gbYPoR/rIuiWVLUnYmWJPawaEfjhyMhl6fa0BFIEl0g7GE2B21gpdAbSNl8ZYM1aUa0w
         5y18yjZ22b/SBT6S6nDpyzatVzciz4cfE3x/PsmX2N86Be7fYbhLzzksn8om1kO6LbBx
         pcCB2OTWF1pqgEVixXoNE0bSlSaxQffsNPjfwmBkQ7hssxldz4HNRZIKftWWGxZQcU4Q
         Q6sGN8dYbnq1VBIg4OQjz/yOY/s+++E1tbTXf5Bzh/ZG97Tyovyv9O2s6qPnSEvWmxit
         Bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967381; x=1777572181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1lJLEbyeroH+TWcwZkpKsknFGLHTffQF4tuZQJcp3k=;
        b=aSLz0xXi9EvKtrnQkHroAnOCmcmw87DqyMIWrh8O0wWF5fRpHM0iBHRsst04cxroPK
         4m8p7QgPsCE8gqLguzyUL8X6u3zwlbykl7mjczwt15rJxKTpKNOSrGvb0ZdMCkfnnyyR
         5JCQkcyTz5EvlSWPBCOZ/kAc8GLRlNRhwXIun1tlDzZBiKLWdImvBFQk5DasHLaMz9t+
         ncmcHZ4biCOucNDIRHOaAcTcg0Dd8RbvzdZJORzJNIISNcqksAgetAuOvnM+K9t1n/m6
         cnKSQqDARfY9I9DoDbCXge7wy5J2A40pFUYBiUuyb4aULOIqxIctQJAU748IkPwaSaBu
         E1+A==
X-Forwarded-Encrypted: i=1; AFNElJ9xkjmi0rYs/CXTYjWJcCaT615/38hEtRREYkp2HxCvYPYPHLelyOErE/EV77m38Cf++M3hPd9Pb11p4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsywocYFuECg4V+QAq9YUYDWbwMC7oErc7v/fwisnvttJHxy7
	jSSIlf9Tz1qWHqS2oLmXhimPf1oTJeAwD47uLav6n00NuE/eD3GsvmaiooONOdqDrkOSlkAAiAw
	sVxbuudUC44iTwUm9wGYQxf02Q5bNYZdVLvr4HAmLpw==
X-Gm-Gg: AeBDieuWMwv8neJABoppyrKqfmGy8tVim1ngUl7WRXPnpz4uiSDpEzCvtf2pWTxWF3W
	rkVLQjJ5S9plokTqvzIHbboZIp7oYLZfMLVfjcBZe2iZEi6sXKnFMCXH7k79LDxOlf2YDJaeFm6
	7ns3s3jzMHr4UmyCp0DhIS7blE0TvY9tZSYL5ROM9AoxIXQXHTL9mhcm7ztyei2t2uLmiafMGMF
	Mg7//M0bhQUggPbkNOO6zsWT+V1r5eGuGq7E19SeBT79pD7EK0SracgOsJaZmW3cErnMY60p/rM
	9Gv+lqL+wJc9HluHf4E=
X-Received: by 2002:a05:6870:16f5:b0:42c:1e12:6bac with SMTP id
 586e51a60fabf-42c1e13c7b0mr5869827fac.5.1776967381259; Thu, 23 Apr 2026
 11:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com>
 <yq18qams3re.fsf@ca-mkp.ca.oracle.com> <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
 <yq15x5lqfdx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq15x5lqfdx.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Apr 2026 11:02:50 -0700
X-Gm-Features: AQROBzCpAwBKjPdeKRy_iDk99MgWov4WGujklh5E85jOlbENhysKrBryAPvMMQQ
Message-ID: <CADUfDZqkT4g3T6uE=hxt9J6JDMXbJt49rM7_Vgs3EBPdFeuuLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 7:09=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Caleb!
>
> > NVM Command Set specification 1.1 section 5.3.3 requires the reference
> > tag to increment by 1 per logical block, so that seems to determine
> > the increment unit:
>
> SCSI allows PI to be interleaved at intervals smaller than the logical
> block size. This was done for PI compatibility in mixed environments
> with both 512[en] and 4Kn disks. Interleaving allows 8 bytes of PI per
> 512 bytes of data on devices using 4 KB logical blocks. That is the
> reason why we use the term "integrity interval" instead of assuming
> logical block size.

Thanks for the explanation, I'm not too familiar with SCSI. I meant to
refer to integrity intervals in my explanation if they differ from the
logical block size.

>
> > The ref tag used for a particular block needs to be consistent. And
> > since reftag(block N) can be computed as the reftag(M) + N - M if
> > block N is accessed as part of an I/O that begins at block M, the
> > function must be of the form reftag(block N) =3D N + c for some constan=
t
> > c. Thus, the ref tag seed needs to be computed in units of logical
> > blocks (integrity intervals); no other unit (e.g. 512-byte sectors)
> > works.
>
> Whoever attaches the PI decides on the seed value. In the case of the
> block layer it made sense to use block layer sector number since that
> value is inevitably going to be the same for a future read.

I'm not following "going to be the same for a future read". The block
can be read back by an I/O with a different starting
offset/sector/seed, as my example illustrates. When the integrity
interval size differs from the sector size (512 bytes), mixing the two
units results in a different ref tag seed for the block depending on
the starting offset of the I/O.

>
> Note that with MD, DM, and partitioning in the mix, the sector number
> seen by whoever submits the I/O is going to be different from the LBAs
> on the target devices which eventually receive the I/O. Nobody says
> there is a computable constant offset. Think scattered LVM extent
> allocations. Or RAID stripes placed at mismatched LBA offsets.

The constant offset relationship still needs to hold over any
contiguous range of a backing block device that can be accessed by a
single I/O. For example, with partitions, it's not possible for a
single I/O to cross a partition boundary, so each partition can have a
different constant offset between the ref tags and absolute integrity
interval numbers. With RAID, each shard can have a different constant
offset. etc.

>
> > To see the issue with the current approach, consider an example
> > accessing LBA 1 on a device with a 4 KB block size. If the block is
> > written as part of a write that begins at LBA 0, its ref tag in the
> > generated PI will be 1 (sector 0 + 1 integrity interval). If it's
> > later read by a read starting at LBA 1, its expected ref tag will be 8
> > (sector 8 + 0 integrity intervals), and the auto-integrity code will
> > fail the read due to a reftag mismatch.
>
> Something is broken, then. Because the ref tag in the received PI should
> have been remapped to start at 8 in that case.

Ah, I missed the remapping piece. Thanks for pointing that out. I
guess I was testing with a ublk device that doesn't advertise
BLK_INTEGRITY_REF_TAG. Since commit 203247c5cb97 ("blk-integrity:
support arbitrary buffer alignment"), the ref tag is unconditionally
set in the PI from the (sector) seed, but the remapping is conditional
on BLK_INTEGRITY_REF_TAG. That explains why I was seeing ref tags in
the PI that didn't match the integrity interval numbers.

So seems like patch 1 ("block: use integrity interval instead of
sector as seed") doesn't need a Fixes tag. Still, I'm confused why the
auto-integrity code bothers setting the seed to the sector number in
the first place if it's going to be remapped later. Why not just leave
the seed zeroed?

Best,
Caleb

>
> > I agree, the seed doesn't need to match the final LBA, but it does
> > need to be in *units* of logical blocks, plus some constant offset.
>
> Your concept of "unit" still sends the wrong message. The seed is an
> integer value used to initialize a counter or hardware register. The
> seed only has meaning to whichever entity submits the I/O. To everything
> else it is a value used for remapping ref tags from the I/O submitter's
> point of view to whichever interpretation is mandated by the storage
> hardware's PI format.
>
> > With a ublk device. It should affect any block device that supports
> > integrity and has a logical block size > 512.
>
> It sounds like the seed value is set incorrectly for reads in your
> configuration.
>
> --
> Martin K. Petersen
