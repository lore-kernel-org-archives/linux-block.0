Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4831E8320
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844817; cv=none; b=HkCyjyNC8WN7N5kJnVQJ7W3+yvi46D7M4VCOcJoUT6GsL5n57XapnxFoTD3AePAI3ReOaDQWqY6iP8kl94VB93THntJ0hMaXF+aTswhl/9TMZzB/shvlAXckqYcDSV2d2XxpBVF1unbIWIfamOvnWWO3rU3go9eBB8e7YrUkTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844817; c=relaxed/simple;
	bh=zZFnGIBULEQhg8FFEYFwPaffueN2j/MQSoOCifUrvdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZwXLbnrP/YZFDK2+Z9rgDq33d57Maa/1xqwQj+ya5FozDzOf8386rTUA027eeB3YvwOJ2iRNICOWnYkxvn3/OX9M9648SnYde6KQZX17QXXrIAmU88VP1UVssPuadcLjiVispr2HOhgIId/xY5nZxLoN+ZtmEXCRUXsNfkAenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLZ1PPS9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLZ1PPS9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-516e1525aa3so42580921cf.3
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 18:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779844815; x=1780449615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mlmC4XR4gxPVFC+3IrEsRTTaSk3Dm8cvG0pTcfli6zg=;
        b=WLZ1PPS9k9IZrVn25H8e/ZPMAKqINazlPctdkjlpPnSayPqfBE7WGPuIKzPx9d0bio
         8W62l78jxUQCBctHFNX2b9ASP2/8TWSkMyhYYX/MwMs9t9TiAsl/u+IG0IXlQJf3DDhM
         S5Q1u1yRuzeRCQop12INnlvBMnZh1f16IAOo4YgWJYbHHNi5iEi3JI3mlsVQ5Cx9M83p
         v3IbJAoadO/1bDkWt2eCkPrpr5pO02zqOOL67wT5s9I3ouniIQlkhyrUs94N3ZiAaqUr
         RgpGIMGHB6Ev/UQktUX+3jG8u67iELUNX8Ntb2YaX1CqZRVvLbjMFELXP8b40rO1zzCh
         nXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779844815; x=1780449615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlmC4XR4gxPVFC+3IrEsRTTaSk3Dm8cvG0pTcfli6zg=;
        b=mofS7xNDua1cwsscLMhDhDbIlzjfMbxlel5O9IQdiVYVl5H0TrGm1wsJyhgd8amki1
         8JSGBNXk4aHrIzy84t4nRtG4lGPVESRFbF3/otrCDSDUyVxs9cxZYhk/EWzkzP4Ak9cI
         3mYsMXQB5ts4aUMRoDiMHE5J6gZV157VV3GmiFjavkLFHwmytQ3RbpVOqrOn37ZDOfpq
         1nLUHoUT3vgBtO3B+7Ew4FpVWYCPbCHe2auL2D87LiMBy1E/LlbthPVt1Y+hMgnMScxi
         hZ/SNZkwcOWEr2L5lQf4vil8hWnZx7fy6+hVjwKjt31P4mP+KXBHhj3Wb/y/4X1uScYR
         q7xA==
X-Forwarded-Encrypted: i=1; AFNElJ9fx3SmpU0FJ5lEp3q8CrYKyO80Iy6kyv/4BB94B2ACBFmzp0scm6C06krH2FB38UA7rWcAfrYFJy7h5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWaFj/JnsI6dfoG4TDvrvOgVkZYVESWyGiAxOQpZKYFl/4sAB
	bmOtad9XPG7aZLDgBrFY70ElCXlThaQPgNtP+vpNb6CFKOsyLPEIoBzIk11nwF0j
X-Gm-Gg: Acq92OGp14uV3q/P4IF+wUPBdpuQetzfrnquPLychEB/b47ekG+03/Of3Pxb9D9S3eg
	VzjKnDFTxmAwAv601QqQHkipkBttSpqyrNDbEY/jRdVo/o0xW8MaWEs//dY6Hyo1+hzIzMRvpes
	oabdwCAV9wFJYttKI1ZzmvduZTkK+vLGwFHbCerDpzj5WdkdoeX4t+uTNvtY6HetcE3k5NDX7ST
	rLkxV3AaktY/0xFOFRcBySKF1DXcoqI1CgJsbNEIzTuZlt2VvKVlIxgp/AjR92hdi8iKl3NV4js
	vFibkGk2AbqsEF7JDq8KpxEHoIR2zTJ+QwElueojB71nczv1c1KnXrKd2gzcvSPHxxTB0B5FCru
	/gENmqweexUVbwRfZYcqlPf7cmN3PFjlLT1Cl0Zat8W4LUptqhODBmJIdxt5aX5B+Yn4TE5HOEE
	NX9Ab9y91rTQE9dbkD/TQ0qleCivejPf2+UQVpQ+JY6xFAGx+161YzhkGG/QKPOfUx3GPKoOCPT
	gIYRryRD21txFGx5MBxqVRLTipHpOlJiSGUNaLcBdE=
X-Received: by 2002:ac8:7e93:0:b0:50d:66b6:1564 with SMTP id d75a77b69052e-516d42e4250mr296025671cf.14.1779844814473;
        Tue, 26 May 2026 18:20:14 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706af1328sm35061051cf.20.2026.05.26.18.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:20:14 -0700 (PDT)
Date: Tue, 26 May 2026 20:20:06 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ahZGxoI6oHQ_vSrx@fedora>
References: <20260518174013.4b72dd50a5bcb89daaed1f62@linux-foundation.org>
 <d43125ff-cc66-49b7-b16d-1b2650c68c23@I-love.SAKURA.ne.jp>
 <ag0lS_CbKO9R5CV8@fedora>
 <94076bc9-2c09-4bb6-8468-b6b8af419cb9@I-love.SAKURA.ne.jp>
 <ag1nfIFcykmQHbkk@fedora>
 <1ab8c579-eb76-4227-8a72-6ec819135219@I-love.SAKURA.ne.jp>
 <ag1223nAa0wZ8ALC@fedora>
 <fda8abc8-6aa2-463b-bf72-865f6b838034@I-love.SAKURA.ne.jp>
 <ahRocb0Vs_m6RF_O@fedora>
 <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9f53d4-6f48-4df8-a3d8-2b0e442a163a@I-love.SAKURA.ne.jp>

On Tue, May 26, 2026 at 09:25:30AM +0900, Tetsuo Handa wrote:
> On 2026/05/26 0:19, Ming Lei wrote:
> > On Mon, May 25, 2026 at 12:40:19PM +0900, Tetsuo Handa wrote:
> >> Some commit which was merged in the merge window for 7.1 broke the loop
> >> driver; a race window where lo_release() clears the backing file via
> >> __loop_clr_fd() despite some I/O requests are pending was introduced [1][2].
> >>
> >> The exact commit which changed the behavior is not known due to lack of
> >> reproducer and timing dependent behavior, but it seems that we need to
> >> solve this problem in the loop driver despite there was no change for the
> >> loop driver during this merge window.
> >>
> >> To close this race, try to flush pending I/O requests. However, calling
> >> drain_workqueue() from __loop_clr_fd() with disk->open_mutex held causes
> >> lockdep warnings [3][4]. We need to flush pending I/O requests without
> >> disk->open_mutex held.
> > 
> > No, please don't workaround before root cause.
> > 
> > No proof shows that the issue is in block layer or loop driver, the IO isn't
> > expected, you need to figure out why btrfs still issues IO after this loop
> > disk is closed by everyone and writeback is done.
> > 
> > https://syzkaller.appspot.com/x/log.txt?x=101e4702580000
> > 
> 
> Of course we should try to figure out the root cause first, but how can we do?

Definitely unexpected write IO(after umount & loop closed) from btrfs is more serious,
which may cause data loss, so CC btrfs list and maintainer.

...
 
> Possible approaches for finding the exact commit that is causing this problem:
> 
>   (a) Revert all changes in the block layer from linux.git and monitor for one week for whether this
>       problem is still happening (because linux.git is more frequently hitting this problem than
>       linux-next.git ).
> 
>   (b) Revert all changes in the block layer from linux-next.git and monitor for two weeks for
>       whether this problem is still happening (less reliable than linux.git but a candidate).
> 
>   (c) Let sashiko review all changes between v7.0 and v7.1 that may cause this problem.
>       (Human developers have no time to review. But is investigation with moving baseline commit
>       possible for sashiko ?)
> 
>   (d) Any ideas?
> 
> P.S. Since the loop driver is a critical infrastructure for testing filesystems by syzbot,
> I want this problem be addressed before 7.1 is released.

syzbot is for finding real problem, here the real trouble is unexpected write IO from btrfs.

So please do not try to paper over real bug by 'fixing' loop.


Thanks,
Ming
