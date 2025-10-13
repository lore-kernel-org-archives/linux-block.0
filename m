Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197582EC543
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343317; cv=none; b=SDseWsEfsQtPAFcxQ7/RHMm9bB9clnej54HWV0z584tG8fLDxOCVuaql5P1C/H9pM2Pl8OkKhziieP4/K9mriWVuG1WGA5g2NHErO7LediwNEeSzQFJlb7fjq3XRwNXcaL/lD7Mo2jlgcABgcRC9odO1Pm0chNvp4b628erObNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343317; c=relaxed/simple;
	bh=ZDF9V6SdJC6O5Ci089i93CmqQdlIvNR7SmEpklYtaiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4cI47CHRQd+0uuOPQK61rPYxPqjrlXm/HxnY9geKFzcYK475+1k5VP1Ys6ffqa8/t/jI56MTNnkwMsqCyUaNCp72LZninjMp+Bn0nSdh39fNRSEiSxSffe1sLw1Pl+moe+IPHoRjADN2fiMGHtE5CFKqaqcluxSLwiTGqTCIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TWUOxepc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TWUOxepc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4256866958bso2105352f8f.1
        for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760343312; x=1760948112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=TWUOxepc3LLnWjGWhlpuHdQuyOvh1ON8xPxTWN1Zt6RiP1dtffxt4BH+p9AwPuPWyA
         geHyO99HKN5xJeEgPSwZSVggoXYsZPRq4ILO8nzuMg5ZksDS24Zk+jMdG16+tMSJImxz
         wtpNPgMSRbeik7p43Pew6RjImi0HsVflcYX0kBYv0BIi5iPuPZO6MNT5BEoyQ3Axt4hL
         IrsdBj05F4bFxR+l/enqx/DIwwBTw8wttmrzTfskfs/TkXAAGD9nuV6pFiLgc9vaRJZ8
         HHMC3vJMy38yQU6/w5sVcUlez0lZ+Ayesxup9glXl39siTmpxyelVxLCOFwS7MPAsAHF
         J0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343312; x=1760948112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R740my9A/r0yGv8JF/opdryBZzIxczQeXr2k5izULh4=;
        b=SZNFOI+f16Qk81gvi1WmIvp6cGUeMp4dAAyMlINynYa2UvX5x/njAe4HRdoTWoefQf
         iRim6B5ijSvcRJk53jdocJkrz2Box9TQ7yyDYKYHV3almuvLeNErkDCi/Tmr0T/inA2E
         duklSCalW43cQs3UvuABlnQQBkoDDGyI2LszqjbLwXRdQmLLax6I4ANb+DvG76OtgHS3
         OLj84DzopsZJHXjevPzDm6oW7rJY/Qu0EEkw6jeLj7fmmFCzOnnO6HKQgqPoCYxEb3GP
         Ov8EyhWHAoHFdWfyRxXXS8Aau0MNleeCI0R1TKrYcUnnV3W+JSPIGPKwWFGdduP2CMZ3
         /f5w==
X-Forwarded-Encrypted: i=1; AJvYcCWZNnRfZbD0WiFcGRNUO19rfiEIcMVx1zUsJBRNf6P5ZnDKFH/9IGSHBPUgKBc/puT0TG9uaA5bWzUtpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNKsaCl5agIypv/C6ClZbkMORUvt0CttktqhXOcwRu+NBGiaZU
	MZu4TBUXBoitwOo/ZF70d8YmdCNXYLFh2t9scj5oF4QmyqwNTf4A2Kjp1HW0vlQ2SYRpiOGScAH
	EjWt2fHcwbvTfvo30weOaTbMj9UxowgtlHIKDiji32Q==
X-Gm-Gg: ASbGnctjr8plnrSY4oexWeUFr7D7CE1gTS2GZfEWstD7q6JUaXo7FxrFSZm+R1+b4at
	eDhxuxDxpAe/iOfp0haiP45cTp/AZrHyTbXLbLB0xsY/jP3w+GR1XNXNbDHaPjG9xB2Ezn2BmQp
	gYuR2TeM456HgoSJBm6CGL+6IZ3/xGFfDzzH8fKTXjiRYjamKVH9gnjTkd5Z6DWzkBBBN/UpAj+
	TarZYT98thpk5dIeOIHVoXZCPL5Pv9FUTo=
X-Google-Smtp-Source: AGHT+IEXSnK8vgh5qb4+sZ5l2hFRJWnorbBdcfDu2E4RvgYsaMIAeq5q8p6/Cp6GKDAeCkB0EX+DEBuZJrHy3pYKRvM=
X-Received: by 2002:a05:6000:430b:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42666da6dc9mr13043087f8f.17.1760343312390; Mon, 13 Oct 2025
 01:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-6-hch@lst.de>
 <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
In-Reply-To: <65aad714-3f1d-4f4b-bb8f-6f751ff756b7@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 13 Oct 2025 10:15:01 +0200
X-Gm-Features: AS18NWCgT3XSP_MN-BMfr65K92-imDhnpGub1dZ7jpbkZ5N0Fj6p03e4QIM-oxw
Message-ID: <CAPjX3FdRvkie6XMvAjSXb4=8bcjeg1qNjYVT5KOBUDrc+H=nDQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into start_delalloc_inodes
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 09:56, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 2025/10/13 11:58, Christoph Hellwig wrote:
> > In preparation for changing the filemap_fdatawrite_wbc API to not expose
> > the writeback_control to the callers, push the wbc declaration next to
> > the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
>
> s/thr/the
>
> > start_delalloc_inodes.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> ...
>
> > @@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
> >                              &fs_info->delalloc_roots);
> >               spin_unlock(&fs_info->delalloc_root_lock);
> >
> > -             ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
> > +             ret = start_delalloc_inodes(root, nr_to_write, false,
> > +                             in_reclaim_context);
> >               btrfs_put_root(root);
> > -             if (ret < 0 || wbc.nr_to_write <= 0)
> > +             if (ret < 0 || nr <= 0)
>
> Before this change, wbc.nr_to_write will indicate what's remaining, not what you
> asked for. So I think you need a change like you did in start_delalloc_inodes(),
> no ?

I understand nr is updated to what's remaining using the nr_to_write
pointer in start_delalloc_inodes(). Right?

--nX

> >                       goto out;
> >               spin_lock(&fs_info->delalloc_root_lock);
> >       }
>
>
> --
> Damien Le Moal
> Western Digital Research
>
