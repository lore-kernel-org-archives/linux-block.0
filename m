Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC93DBD76
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957523; cv=none; b=hefwDPOPAAocAsva7ccjWyYAeEFu+BfZJfgPnOxQVc+5WL31u7ld4t/G6SCdqtu3pT1PNLVdr8H7SDyyiBp57PdP1krY5A/SYlzhX6n5toivib2eO7SKEENugMcN8BbHC7yolqqCrgcKmwfdhyi+iPAcUu/Ez2iXkJPJQGCFLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957523; c=relaxed/simple;
	bh=Sf4/FflJwV2aPRX5vnkfVvX/evGPRTypvDkhAGsXmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnN6VPf48s7UinpBlVxf9hJ+B9DL1Fi5PHO8SY862m8GKx7gN9ztfOj8WUqN8cicPTSvNtX6NzTLK+QCwJTVCd3l0CAiuDqQep56RzBUfhy2MJ3po38LmSGSdk08VArfWBnZ9iOi5ZP5X1Wh+o731jZgwLq39Nsv47yhX+EjoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx1FcDq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx1FcDq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB802C19423;
	Tue, 31 Mar 2026 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774957523;
	bh=Sf4/FflJwV2aPRX5vnkfVvX/evGPRTypvDkhAGsXmdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rx1FcDq7k6dC4eNzRsLkeWNFIKhLhbXC3EbDuX0QZms4cU3OAo7jZcm0TmonPBTNE
	 lYF2ew9pk73EdVTIs/RJgmNDnDsj+2F/Hml8+cB5W0Dngv1G1v/HZxbzin6cY7Dx8h
	 LRYckRt1/RhxRn+0peXEybBAPLAPsIHlNMdT1kn7HOuKrdhvS9OkW86Uiys7gwO1rZ
	 Oko11+Tt3y+Ib4aR+h7PyYBIkxKGVkfd2BQuHdIBEEPgdg1kYdbIA0iXnoMsQHaTOO
	 8U0IqWnFtYLW+VN0qzLPlJ/mFvyp0Ew4FD4Wg/CxNr8wKFdVSP+9MaHGKFZ3orB/Zt
	 Q9uBj8Lu+xWCw==
Date: Tue, 31 Mar 2026 13:45:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org, 
	Daan De Meyer <daan@amutable.com>
Subject: Re: [PATCH v3 1/3] loop: fix partition scan race between udev and
 loop_reread_partitions()
Message-ID: <20260331-vertagen-formgebend-1036bb16302e@brauner>
References: <20260331105130.1077599-1-daan@amutable.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331105130.1077599-1-daan@amutable.com>

On Tue, Mar 31, 2026 at 10:51:28AM +0000, Daan De Meyer wrote:
> When LOOP_CONFIGURE is called with LO_FLAGS_PARTSCAN, the following
> sequence occurs:
> 
>   1. disk_force_media_change() sets GD_NEED_PART_SCAN
>   2. Uevent suppression is lifted and a KOBJ_CHANGE uevent is sent
>   3. loop_global_unlock() releases the lock
>   4. loop_reread_partitions() calls bdev_disk_changed() to scan
> 
> There is a race between steps 2 and 4: when udev receives the uevent
> and opens the device before loop_reread_partitions() runs,
> blkdev_get_whole() in bdev.c sees GD_NEED_PART_SCAN set and calls
> bdev_disk_changed() for a first scan. Then loop_reread_partitions()
> does a second scan. The open_mutex serializes these two scans, but
> does not prevent both from running.
> 
> The second scan in bdev_disk_changed() drops all partition devices
> from the first scan (via blk_drop_partitions()) before re-adding
> them, causing partition block devices to briefly disappear. This
> breaks any systemd unit with BindsTo= on the partition device: systemd
> observes the device going dead, fails the dependent units, and does
> not retry them when the device reappears.
> 
> Fix this by removing the GD_NEED_PART_SCAN set from
> disk_force_media_change() entirely. None of the current callers need
> the lazy on-open partition scan triggered by this flag:
> 
>   - floppy: sets GENHD_FL_NO_PART, so disk_has_partscan() is always
>     false and GD_NEED_PART_SCAN has no effect.
>   - loop (loop_configure, loop_change_fd): when LO_FLAGS_PARTSCAN is
>     set, loop_reread_partitions() performs an explicit scan. When not
>     set, GD_SUPPRESS_PART_SCAN prevents the lazy scan path.
>   - loop (__loop_clr_fd): calls bdev_disk_changed() explicitly if
>     LO_FLAGS_PARTSCAN is set.
>   - nbd (nbd_clear_sock_ioctl): capacity is set to zero immediately
>     after; nbd manages GD_NEED_PART_SCAN explicitly elsewhere.
> 
> With GD_NEED_PART_SCAN no longer set by disk_force_media_change(),
> udev opening the loop device after the uevent no longer triggers a
> redundant scan in blkdev_get_whole(), and only the single explicit
> scan from loop_reread_partitions() runs.
> 
> A regression test for this bug has been submitted to blktests:
> https://github.com/linux-blktests/blktests/pull/240.
> 
> Fixes: 9f65c489b68d ("loop: raise media_change event")
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
