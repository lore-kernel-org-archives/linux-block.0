Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F51DFEC
	for <linux-block@vger.kernel.org>; Mon,  5 Feb 2024 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165214; cv=none; b=djZ0MZETxp/37guSJhDHXEXmKQ2M2YRXvSla92mqAmM2eA+DQG+cAtgAixEQtis6ZEs/As3SZdZ7p5ZJ7qRTHZuL8rem00xZIZDNHDHbYmmwkvuYdd04Qq1mwIvvxIJc1Ro8pezpkqCOlKOpRJ7OgHC3KX/GGqi3sa7uvatvwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165214; c=relaxed/simple;
	bh=84Wm144yxI0sZofGqvnmYxOwUFfZYp+YlTK1wrMQHm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge2cX5FDxuCt5GPmStY4XOnIlKgRGJnKyT6Qxe3+vgbs3Glk8vEXoaFG03EQE2w0urvqN0weGNd3aUNmcOFi0LS5POcaKYsZXbhE/29xm2mzpK49gTjHwm5UwTqE7PQK9HhchpTPDFMsQ+kFa01AgNA7rXyPYRNIzj6KBfAbYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783f1fba0a8so255020185a.0
        for <linux-block@vger.kernel.org>; Mon, 05 Feb 2024 12:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165212; x=1707770012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ2cCZbNVBFr5QmyQ/zTTglXqJrVq+6u2SzrmewGqmQ=;
        b=GtobpsPCX3xbjhWe9UdLSsVVk9I3M+zhf/oDsXGG8YC130fVQXXv07+sQXmA7efwRa
         SS1svr3DU7yA/Et5wpgNdIXD8QVRnpd3Jvd23rTd/Zu9mpWSosKA/x3zk4oP1+YwXXaP
         2Xe4p4T0IkgT/7xakASjLS3rE1DHdiXJTCHfG3t35lmdPdcRozZEnVCA/5wmD4kZ/R/v
         Fve8jWmrAaaDnI3sZ+LkyWtf8uVf/lf2LJmAN6RqV4VkybLuEbGypjeORE1S19SI80Q8
         KqSBTFTLgVU0Oy6jBDSeNcpKmXt6Wp8S+ZZlTidn1AAfm4mbItFJ0vt0nvHuhm7ju+/i
         sPJQ==
X-Gm-Message-State: AOJu0YwZx+iMHrEvS2wjkjHGt9YBot5FOxT1TMIzey0Qr7ELwoAsd/tw
	IKedDjYqWi3F2DbzaOUrZ+GttADRz6J9mRruuxNwTPJmUg+MUsMJaZ+NZYWRSw==
X-Google-Smtp-Source: AGHT+IHBXkIeNQaapkhCjHyXPeHg1bTz2aBwFDuTf9dxryTz4T5dBqE8FpYpmOYY8ldwibiuYeFjwA==
X-Received: by 2002:a05:620a:6891:b0:785:6c4e:9dba with SMTP id rv17-20020a05620a689100b007856c4e9dbamr770972qkn.15.1707165212033;
        Mon, 05 Feb 2024 12:33:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKi4aPNpuyJ1vujjM8XuK2yKmpRPRK8VbQvN/P0iWYja4uart6X+bQvEpC6NC+xXWZEik/okNcI+71R4qXnqUpolSBaumh+I8RCQ65p85vWVgbONVq3e226Ymeme5+BaPMtb4V6LJpJ+ICxQmcfa+e8lxSSuLuyJwO3gWELyxq1EJ4MatpE+gkzfaRwK6LfG/8ZM+KyKlh0QpOp1sf
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a220f00b0078560085d6bsm261189qkh.100.2024.02.05.12.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:33:30 -0800 (PST)
Date: Mon, 5 Feb 2024 15:33:29 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/26] dm: Use the block layer zone append emulation
Message-ID: <ZcFGGdVc7mqCpU7a@redhat.com>
References: <20240202073104.2418230-1-dlemoal@kernel.org>
 <20240202073104.2418230-11-dlemoal@kernel.org>
 <Zb5-2LsnQtJHV2mL@redhat.com>
 <4eb920d7-e2fc-49d0-9eec-5fc152fa21de@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb920d7-e2fc-49d0-9eec-5fc152fa21de@kernel.org>

On Mon, Feb 05 2024 at 12:38P -0500,
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 2/4/24 02:58, Mike Snitzer wrote:
> > Love the overall improvement to the DM core code and the broader block
> > layer by switching to this bio-based ZWP approach.
> > 
> > Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> 
> Thanks Mike !
> 
> > But one incremental suggestion inlined below.
> 
> I made this change, but in a lightly different form as I noticed that I was
> getting compile errors when CONFIG_BLK_DEV_ZONED is disabled.
> The change look like this now:
> 
> static void dm_split_and_process_bio(struct mapped_device *md,
> 				     struct dm_table *map, struct bio *bio)
> {
> 	...
> 	need_split = is_abnormal = is_abnormal_io(bio);
> 	if (static_branch_unlikely(&zoned_enabled))
> 		need_split = is_abnormal || dm_zone_bio_needs_split(md, bio);
> 
> 	...
> 
> 	/*
> 	 * Use the block layer zone write plugging for mapped devices that
> 	 * need zone append emulation (e.g. dm-crypt).
> 	 */
> 	if (static_branch_unlikely(&zoned_enabled) &&
> 	    dm_zone_write_plug_bio(md, bio))
> 		return;
> 
> 	...
> 
> with these added to dm-core.h:
> 
> static inline bool dm_zone_bio_needs_split(struct mapped_device *md,
> 					   struct bio *bio)
> {
> 	return md->emulate_zone_append && bio_straddle_zones(bio);
> }
> static inline bool dm_zone_write_plug_bio(struct mapped_device *md,
> 					  struct bio *bio)
> {
> 	return md->emulate_zone_append && blk_zone_write_plug_bio(bio, 0);
> }
> 
> These 2 helpers define to "return false" for !CONFIG_BLK_DEV_ZONED.
> I hope this works for you. Otherwise, I will drop your review tag when posting V2.

Why expose them in dm-core.h ?

Just have what you point in dm-core.h above dm_split_and_process_bio in dm.c ?

And yes, you can retain my Reviewed-by.

Thanks,
Mike
