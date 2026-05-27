Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD6275848;
	Wed, 27 May 2026 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883356; cv=none; b=Z4KYyUy9Y4RLD+Zvinu52Ij7841qLiJBfLUc2Sf1sxvpXBiGwFJFwFHn26BK5/VePsO0nvPUnrnDlSspnq2adJPMlV1DaHBResnUvc0YHzhR8T4ACNUTgFfOTYWPVh+FGMOBwSourssznTAoz11hH/Ip5ei5Ej5LtA8HN8HxFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883356; c=relaxed/simple;
	bh=+iJD2XxPvTEO16Xf9Q01mOv5mCQx/1FrQQPh2vK2AbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2wli16DkZGiZo0BHvcyyIJqzwjfGhX2gECi45Z/uxAoJTew9vhq2jJ75B1xnnCA5vtQfox511mvQ0foPABJ1EGlSe3Osrd1R2YZEVL733XF03TP6jV1udr0FgkN4e8txTm9fnnXD0h8W+YgtMMmHZXlypbLoPQhqg5rIdZxw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbFQTy4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbFQTy4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844941F000E9;
	Wed, 27 May 2026 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883354;
	bh=3jTwf5lC0B1c1d4ZmLVE1Bkci73JERSH43z+tNImVM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VbFQTy4nS/dwHmxvs0VTuiWmNQLayGq8PUSHT0vDQR3iXwEypqBEG0bl28lKo4P0B
	 zSeS1eRyl1mPNY3Pr3SuAGLh/aPIBhJomXpoK9y0IXN7U04JP3S9Vp2bjGNlKvQv1l
	 nAZH5CkJqkUV26KthYeRbUk4HFQHC3+t4+TNzLQ0l2GjIo1pdQ5lXWYOu422+Atuon
	 qJ5r5iS0RjKhLe153P1MmJkaK0p6GDnbK1KzsKsQytzd2+hlAMqSXkWRRFirfvEOie
	 CnX18KGdh4I1QHZa5IFUdhlhAg7TbrzSutam18m8tWAHVzuJ2TtDhwAvTyBxOuRxUM
	 MX4yGcsvNMmzg==
Date: Wed, 27 May 2026 14:02:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] block: skip sync_blockdev() on surprise removal in
 bdev_mark_dead()
Message-ID: <20260527-primitiv-heilfroh-befeuern-43d4b541b631@brauner>
References: <20260522220025.1770388-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522220025.1770388-1-coshi036@gmail.com>

On Fri, May 22, 2026 at 06:00:25PM -0400, Chao Shi wrote:
> bdev_mark_dead()'s @surprise == true means the device is already gone.
> The filesystem callback fs_bdev_mark_dead() honours this and skips
> sync_filesystem(), but the bare block device path (no ->mark_dead op)
> lost its !surprise guard when the holder ->mark_dead callback was wired
> up (see Fixes), and now calls sync_blockdev() unconditionally, which can
> hang forever waiting on writeback that can no longer complete.
> 
> syzkaller hit this via nvme_reset_work()'s "I/O queues lost" path:
> nvme_mark_namespaces_dead() -> blk_mark_disk_dead() ->
> bdev_mark_dead(bdev, true) -> sync_blockdev() blocks in
> folio_wait_writeback(), wedging the reset worker and every task waiting
> on it.
> 
> Skip the sync on surprise removal, matching fs_bdev_mark_dead();
> invalidate_bdev() still runs. Orderly removal (surprise == false) is
> unchanged.
> 
> Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
