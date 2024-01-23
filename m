Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7B53E2B
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052114; cv=none; b=TtGt3ZfKtkDJB/c35rA0bpye4AEpH41Vsn/QdjsE/iQ+LaO+BfK/iXOFoXMND35IJHflxgR595BI8rvq+Mjj7v/02HTKWnX4kS6JuzyCmg68dcc77JMfZfUJajUqcceJBV0D0r3yFCu4faaYFFJaINbrEYWTRXZq8wES1YfBnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052114; c=relaxed/simple;
	bh=ZR7sfWUwnT5BjG/tPD79vE4fth31migQSpuAcSwowUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jro/2p56s8zU5NgBa16rqVYuge4jfCPREuVliV9Gcdmel8Pi6TfUHKoG3wYDNoGFVhn+ck0KVf+V/tzlOUrrCdrPNJFYCHyyx7uRDUs6t+qn9hEQz5o5U+NIbDHwS9429SRe6iSZDtTk1YCSzQjzmwh4Wc4Zmf0V6g+TxdFlqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=RvX4HvfC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="RvX4HvfC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso3039139b3a.3
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 15:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706052111; x=1706656911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyNE0YBQ61XvxQg0qzcUw/mj3pyKM5V+H7U9PFr3Dnc=;
        b=RvX4HvfCp9MumJ6K8hIZzKFqBmgWHy/Y6u1vIUhjUQtIO4WFvjpCcqE70cg9PTfjRU
         +gDCUwKH4q0tfBIS0xfLoBJ1oaO5rJFYohmjq2yfeAKb8gQSJqyHKp44xaQeRPdQS5XI
         fDZcdggS8uPRwLROIRGfDdxD/56XoKevdcwY6M3M3FLudZgNoy6HsBhV4f2FMDeblEsL
         azKvCt06cZXAxAVsFCC6vJWC9/AvSgwn6Dzx+NkAbMyg9LsjT2K4Uf6JwkuG00v2geI8
         Yt9qz2qHhvckMjKyDxEIBSZ3kbhkOb9M5H0N+UYQG6SHzoYr+4GlCEbngYI/xIUF0JRZ
         Da4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052111; x=1706656911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyNE0YBQ61XvxQg0qzcUw/mj3pyKM5V+H7U9PFr3Dnc=;
        b=qZ3qM7uUBvBexVzhHq0QVrIx12Ssvy/kDpnbAhu05lv7d+uj96+wVXg1Ud/dklGMa1
         8bHhMxovtify5M//pAA1jQVwH0g76v1JA+ryh4OHONlNj5EH1Anb7iZ9vfbpwxhRnrhv
         Gt33QKIj2UXqzN0iv1c8diIfLezcyXy/4G3ajeqJQUgaSsigbSSTJaSq/YdA1kd2Htl8
         dDCRbjMZ4NnqaGdyQUY8WSPid+x3Ix1791/Sx1DpPxPJXcOs5HJ8RrN+5HuBul4BCmgx
         bPEzAF1ISUs/zt+r+ZQPyIX10UPqOq0/kscCBHWqt0Ma18kYT14d46cEWYS4pU+e0QHy
         /yRA==
X-Gm-Message-State: AOJu0YzzUMAqbPJUG5W0lhFMulUKRJy7MvXpMqcsaRid4e9IbWP1uxfX
	sD63SkG6ogYgkd5jqsAtBIKejaI1qZtFK9/REcliPeATJjX2k7O2CQafzfXTNAE=
X-Google-Smtp-Source: AGHT+IGeQm//kQ1jNNCFdA/q04f/cj+3wXvZbTLBGBCW2U08K7o/GP2/AW3XgLOokmhWoQbjbV2FZg==
X-Received: by 2002:a17:902:d202:b0:1d7:1e5d:ab39 with SMTP id t2-20020a170902d20200b001d71e5dab39mr3908243ply.80.1706052110812;
        Tue, 23 Jan 2024 15:21:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902bc4a00b001d714a1530bsm8165932plz.176.2024.01.23.15.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:21:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rSQ5T-00EPce-2c;
	Wed, 24 Jan 2024 10:21:47 +1100
Date: Wed, 24 Jan 2024 10:21:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Message-ID: <ZbBKC3U3/1yPvWDR@dread.disaster.area>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
 <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
 <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>

On Tue, Jan 23, 2024 at 09:39:02PM +0100, Mikulas Patocka wrote:
> 
> 
> On Tue, 23 Jan 2024, Johannes Thumshirn wrote:
> 
> > Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
> > zonefs_zone_mgmt().
> > 
> > As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
> > from a place that can recurse back into the filesystem on memory reclaim,
> > it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  fs/zonefs/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> > index 93971742613a..63fbac018c04 100644
> > --- a/fs/zonefs/super.c
> > +++ b/fs/zonefs/super.c
> > @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
> >  
> >  	trace_zonefs_zone_mgmt(sb, z, op);
> >  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
> > -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
> > +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
> >  	if (ret) {
> >  		zonefs_err(sb,
> >  			   "Zone management operation %s at %llu failed %d\n",
> > 
> > -- 
> > 2.43.0
> 
> zonefs_inode_zone_mgmt calls 
> lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
> function is called with the mutex held - could it happen that the 
> GFP_KERNEL allocation recurses into the filesystem and attempts to take 
> i_truncate_mutex as well?
> 
> i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
> zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)

zonefs doesn't have a ->writepage method, so writeback can't be
called from memory reclaim like this.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
