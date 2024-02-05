Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9518EB1;
	Mon,  5 Feb 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134123; cv=none; b=dKvHHlFsRiyvk1xywk7K4nW8cMSfDz4louqfPnlVNdkTNVAOC1llOfNprd6ADlCxfENX/squBRKhR8XDn/ynOpKZAP/9wtBJeDgju63Sw3jXBu7PDZnZLPrfg/GEsNSU+IA6iq5m5+uXGm+XzkPQilthl12rUrtJgEp3Dr0iZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134123; c=relaxed/simple;
	bh=vcTcw3QZM+FJ9OhHdU1Dr3k5mD5XU60j9QSyLvBtwqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOPhJ8Dy88KFVutDy7ab8f6VQv0GLi7WEEr076KZTJHDiwg1OVrSQkrYFra6vVcOBZzM78az1BdUWNf43UHEDwkClSxy/8JeeUuup1CpH5WwrrWanIPAjcLL1M2yyhiH9Kca2DD0AVdPtnPSD1NJk6NmV2d98g9YaZIYeTmovcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuep7jpG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuep7jpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BC9C433F1;
	Mon,  5 Feb 2024 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134122;
	bh=vcTcw3QZM+FJ9OhHdU1Dr3k5mD5XU60j9QSyLvBtwqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuep7jpGUmwYnp+IAvBhI6OUhEXB5j3ByEQl6CEXYsS8XNJbw/qqV3jCR+PQILklZ
	 m60PSoaP1A5tGPFSnfDSiYVSFsyqyB89ForvQiedsBUD1mPl0CEw0dgEfU9XvHMWI3
	 JonFJtvpFcKTH+CroZu8nfB+lkbtzszkoBIldVU52wrE+RhNUAiURyzCs/JzJuvHqF
	 FPFfY8dMvYRyGjiUt81ChbA5SfLJ3ciJnknXEgQl7JE78Q4lpwBUbrxk2k0OWu8rlr
	 Qs5ku2ig9e3p/Gp5QX+rPx8RJliZcurZ5XjOfFov0dTs9o0NLpsegWR7+6GoBlbuai
	 j0PM/BTSDyCSA==
Date: Mon, 5 Feb 2024 12:55:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240205-biotechnologie-korallen-d2b3a7138ec0@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>

On Tue, Jan 23, 2024 at 02:26:17PM +0100, Christian Brauner wrote:
> Hey Christoph,
> Hey Jan,
> Hey Jens,
> 
> This opens block devices as files. Instead of introducing a separate
> indirection into bdev_open_by_*() vis struct bdev_handle we can just
> make bdev_file_open_by_*() return a struct file. Opening and closing a
> block device from setup_bdev_super() and in all other places just
> becomes equivalent to opening and closing a file.
> 
> This has held up in xfstests and in blktests so far and it seems stable
> and clean. The equivalence of opening and closing block devices to
> regular files is a win in and of itself imho. Added to that is the
> ability to do away with struct bdev_handle completely and make various
> low-level helpers private to the block layer.
> 
> All places were we currently stash a struct bdev_handle we just stash a
> file and use an accessor such as file_bdev() akin to I_BDEV() to get to
> the block device.
> 
> It's now also possible to use file->f_mapping as a replacement for
> bdev->bd_inode->i_mapping and file->f_inode or file->f_mapping->host as
> an alternative to bdev->bd_inode allowing us to significantly reduce or
> even fully remove bdev->bd_inode in follow-up patches.
> 
> In addition, we could get rid of sb->s_bdev and various other places
> that stash the block device directly and instead stash the block device
> file. Again, this is follow-up work.
> 
> Thanks!
> Christian
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

With all fixes applied I've moved this into vfs.super on vfs/vfs.git so
this gets some exposure in -next asap. Please let me know if you have
quarrels with that.
