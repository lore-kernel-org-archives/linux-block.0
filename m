Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D435F60F
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631811; cv=none; b=HFW6nM1NuaHTTm5VY82b/ggoFhE4CeNBMIkL+ywYlUHTKnUGY6nOSeT2YlRyC4NsZESfXTEpPiUTa7a29XnOcGBrZSHo+E8sIXOssDbQuH5vX0nJDR3J4FrJdplUlvZPlITwdg4t9gZMvE3O3cEQE84eaN5NG2fUJ59lKswQCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631811; c=relaxed/simple;
	bh=RCkhMx2+y0swVftOFjqZYwB2dqj5ySiFdC50TMGiJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc4I1Rpp9Ujg06lV4NwyLCdS+cWvn0LhmXDfzaujON/II0jIu7IGSTMTkKObuoNGfBvuvg7ReuZawXvWIjr0cDcF4fttEAwYndXiinwI8AidXvtNf7RUVcSqv5jqtiGEMhe1bN10ZN3VS05uqrOmqkStHBQStc06BW396GY5b6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6VIYr8Y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6VIYr8Y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so11464905e9.1
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777631809; x=1778236609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJOn73yfPLWKunE4r7o0wjEqosBjROoWkN5Bczb+/MA=;
        b=h6VIYr8YB2ImebS6VyoN1AbiJkUTL4OcIBMA1zgjxLtxtDnNo9rLUtOU1JRbjWWmsp
         3fw88ReyKHzTYG9NB+RBSQLsL+ptbKwx72bct+Wr8X2q6JZJkmMiYftdgTfIFRHlVgOe
         mJ/l1F/GEpcIPu6g7nYmrSD1I8oAM28+mMXKwnI58mD882lPO1wc3mpGXOrBvDyJZNyQ
         504CFnSfdSf3q9EwOz/9+Gl3g5fayOf1CpN9zFkt6ZyfTqoX9acXYltCHfyPDxQ37KL9
         8zLFvmep+cuCE8fITIru6/pq+7QQCKU5feO25X58Z7QfDXxvThPK1urKyOgjZzX4W3bm
         fp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777631809; x=1778236609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJOn73yfPLWKunE4r7o0wjEqosBjROoWkN5Bczb+/MA=;
        b=hfHviyXwG5hg5WISwGaYVFFDFYgNlOd1BRYJQCGGHeu2RVdtTNLry6KIQbmVTTy8+3
         Lps48qvBGYJjEaPflCF7Tzr1In54N7KBZ3R4EnnZq9x+xP562qi7ZDY10VDXuIG607bV
         BOxPcGMY4oZZZ8AJyfsARPLht/2bAp2taDXKAxzMFRKf1z9RMAitiIjHdM8ab2AdVbEP
         dOWiz1PK/346oqxLUb9ety4FwZNximk9HQqx63x2fHskNvkQceoLwNuEhmCuKt2h6JAl
         a0owcDGkfPDJiBGaON6VT+yPUeI+hFjCCMIqY5LHCc4k3ZtDnMWcmEpeus7NeIU2BCEJ
         PLJg==
X-Gm-Message-State: AOJu0YyTpBm/v85yoqXyWAFa9Lg9Tm8WC7Z9pAvX2rKsH8OqyeJG3lBW
	8kc1rNzpeNnJI3SWPu5zO7qRmp0fnkT6L0Hw+Qn+2Grmm6uAA6gHoNos
X-Gm-Gg: AeBDieuOFMyg+Fmizx9mOBDDHkLHg0DRnVdN++5fxp5SDpqlexyPft45Xw6ZAxlpeic
	QqQ/BL7UYdSInhExuW8RRFzX7G8ZTI84Aeh9gUa3XB2TalzPC9yl8KB7y7qt46zG1xnhoBvwZdx
	ATOwDsjnvlBJI1UXl04UOg2PcLscPj3EvujR1sdHorklSkdu/gHkKkUtaiHLQYumTTN2/Ewd4sM
	jixeGLg08z2+/eflERJBlg01uLsAK02ghAuSc5o9e66TRx6uSNdBAWGdnIRJi3XLRVIAtB8WoTr
	QDx5Vxrlh+VpcSRHcQIrQI0LQKwV6lvUIHjCCziDssu6ez/tDeQCTEn7IV325Xg8UxiUVL8juqq
	NqmMYHNPej4uXGUAh12hSRFGd5MLuC+8hzeotBysaqEw66dgsGspjg4B0WUfoV/sVDwlRRv9sDk
	7XtejrcJWYDJ/PDFTAMeavbm7tDqHdFWTvR/hWH62ijd4C5NFk2hCMYHmGH+NCNLaJ+P6jafA5a
	BHorR2rmnAUDkwUjpo=
X-Received: by 2002:a05:600c:4e8e:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48a860758c7mr96243305e9.10.1777631808677;
        Fri, 01 May 2026 03:36:48 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb3dc1sm46220865e9.14.2026.05.01.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:36:48 -0700 (PDT)
Date: Fri, 1 May 2026 18:36:42 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] ublk: reject FETCH from non-userspace context
Message-ID: <afSCOu40SoLXQpwK@fedora>
References: <20260501085216.905401-1-tom.leiming@gmail.com>
 <9efbd035-b40e-4155-8382-b42acff75a9e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efbd035-b40e-4155-8382-b42acff75a9e@kernel.dk>

On Fri, May 01, 2026 at 04:34:11AM -0600, Jens Axboe wrote:
> On 5/1/26 2:52 AM, Ming Lei wrote:
> > __ublk_fetch() sets io->task to current, which is later checked
> > against io_uring_cmd_get_task() in ublk_uring_cmd_cancel_fn().
> > With REQ_F_FORCE_ASYNC, the FETCH uring_cmd can be issued from
> > task work, which can be run from io_uring's fallback workqueue,
> > causing a task mismatch and triggering the WARN in cancel_fn.
> > 
> > Reject FETCH if current is not a real userspace task, and it is
> > reasonable for failing it in case of io_uring fallback.
> 
> I think this should be caught in ublk_ch_uring_cmd_cb(), which
> should not hit ublk_ch_uring_cmd_local() if tw.cancel is true.
> fallback work should just be terminated, not be issued.

Yeah, that is definitely better, will take it in V2.

Thanks,
Ming
