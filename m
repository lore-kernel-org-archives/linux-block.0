Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAD3D9025
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179638; cv=none; b=L1hBOeeWKNobqZit+7iIwK8eWKTMSO1zHF7y4gWsWJwucXk94E5YtT8qurGtd2R0OqKWmWH1PNxyzvyjAeAsOyYMSgM9DrspVoec1GFXPFx6C7klR+RRhsLf0lckuHrkmaqbuonp6EljAAuQkTEdg3Iw3soui9TPEaziOLVebq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179638; c=relaxed/simple;
	bh=Yo0EVHV1kiPGFY+ue5QLPkhNG4ekxqZnDLGzfQ6cezk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKLYbGSIg3jBBUiWaFwbVcFtk8sbx8hMurD7I5mnnZPMacuVZLISIShi2GcaPXyhege3ELKWQFqDTC2uXfrykO1Ju409FA15Ca4P2eRErWArJ6FFAogaRfNbki1c7YQ8KYCyhZOAjp5ZXngXnPkB2b4oFvDguEYvGaLw1y1XmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZMdSByH; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZMdSByH"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de7c57b52cso3118174a34.3
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179636; x=1779784436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EiakiSkQhw1pZrsQQLBSF74qifypdvMzdt7ZdBqgl/k=;
        b=EZMdSByHkitVd0FpnpSXiM/NEK0KRAut0elxCZa2XtcIwGoxQh8dKnhGS9hcmb5og3
         2jQXRVOMbdlSLn9FSbfTr1+fq1WcP1mBcpnQyj4fam+czVNV55iRLkwUtSIpHKrZHHJ2
         B7pxfNjxETMxrd4Ww7jjPEVvIa9W/53S3DWujAE0h+PzVocsf0G9WZzOQorqt/otPTLX
         2vVsXwPtJFM3Ada3yN3DwmhvZPPsFhV4ouE9Fd4t/GsCuHMYauYSvwRGvyvauZkZOtKs
         U4IVmjRTyPZbQtuomjlprbpIcwgEzyFo5viEalL2M0+gcmySr2Z6bIU7L8fYtuuRncQ3
         DHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179636; x=1779784436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiakiSkQhw1pZrsQQLBSF74qifypdvMzdt7ZdBqgl/k=;
        b=Z2x26JTeM1OntUwgXP2N7++poUxrZvvXvf1/w98LOBScfvfqo4iFtT9dwOkKxY3pNS
         ldjCC/aYvRrhYbUp4PzjY+0QTGV22Wnwc1wlJCHIA0+39evVjOZ9EYvgBsQG1Z5X3LSm
         qRuvUiWdm8QwByWMYodnKzlWoTQI5qsezWv3KEDBfRZQpJAQukMCqfWQbxWpI8I4/hQh
         Elm3HLXQ89WHZ5Hsih0iV4pn0plsgmKjlGsmHJ7/jW0w1xVPiMK76hlgRSVIk3e9sg40
         Iv4HmlAEVO4MOMcjxyaBzlg66vS7AziOTJO4XsBFYJKv8KeH3fO/Z9/PQevc1r8Zigij
         +YQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8pGBwxoghFK3fGnRs42w/yI5HzDhNoc0DfIiTlB44F37/TFv0AtooiJPJBcl8yl7TLGBc+SIDGI2YsRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2p6BYJagTQmm0nfCs/yEgYuW4gJ1XnelMqh3GANzlDN7DEwfd
	nQF2koDqLS3KOuRGKo2e3YllBvaELVljm8cgSpQXYSvKWO3vmKot7Ir6
X-Gm-Gg: Acq92OEcKOvqLrlWKh7CGoVJ6uQFLjjqV13xkzK5G0dsuK1vqmH4aUuA5kE40G5dt96
	h8b9I38WsQsZN0oajHuryZuIf9EJDIOEki+//MoFQqUxI+TIctmiWu/wFknLtQroGikp4D7jv91
	hiXnH/WWid2cV4den5lwthtNBZtqCLoV0TIvKDkGdEv/gugSdI4AfG5RMqU8g+2ePI7wq89Z4+N
	Ye1zzuir2QsWNssge4LZa4VV0w/9uhsF/kpVxZu27Yg3r8Xh7oPsqRgwLWib+5KoTjd9O/eMNkW
	axivkOA1zWGq0QHQimGhnRe3F8N2WzUYCWedxnajMrzX/z4X01fIc10L85zWhxC6VZHniaIOwUV
	MgzbHEz2eY+FQ21VdMytqKaAl5L3AVET7k1CxIhzi+HeIxJcakrYHy3bFtrfZtwez5OfF7HZEha
	v/aSNNXIYLWEoq9BGTMDBUc2KhqgyV6RX4Fpj04ruCfM1/2jMmAsrPpmPGK89Tqe44X691Dlzo4
	Ul4PUs/yBWk5SLJDXCG
X-Received: by 2002:a05:6830:3812:b0:7e4:230:96ca with SMTP id 46e09a7af769-7e4fa05a5bfmr14260526a34.21.1779179635795;
        Tue, 19 May 2026 01:33:55 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c68d6sm9344663a34.3.2026.05.19.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:33:55 -0700 (PDT)
Date: Tue, 19 May 2026 16:33:49 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Hongling Zeng <zhongling0719@126.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, axboe@kernel.dk,
	ming.lei@canonical.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <agwgbZmZiwzZe4-D@fedora>
References: <20260519040103.22776-1-zenghongling@kylinos.cn>
 <agvqK_4EelxnXUvf@fedora>
 <6A0BFDE2.5000808@126.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A0BFDE2.5000808@126.com>

On Tue, May 19, 2026 at 02:06:26PM +0800, Hongling Zeng wrote:
> Hi,
> 
> Thank you for the review.
> 
> 在 2026年05月19日 12:42, Ming Lei 写道:
> > On Tue, May 19, 2026 at 12:01:03PM +0800, Hongling Zeng wrote:
> > > lo->lo_backing_file can be NULL when the loop device is being cleared,
> > > causing NULL pointer dereference in lo_rw_aio(). Add a defensive check
> > > to prevent kernel crash.
> > > 
> > > In v7.1-rc tree, lo->lo_backing_file is cleared in __loop_clr_fd(), which
> > > is called from lo_release() only, when it is guaranteed that there isn't
> > > inflight IO.
> > > 
> > > So care to share your stack trace?
>   Syzkaller has managed to trigger NULL pointer dereference in lo_rw_aio().
>   Tetsuo Handa encountered the same issue (commit 1a83d226268cf), but his
>   patch only adds diagnostic logging and is marked "not for upstream".
> > > Also fix loop_attr_backing_file_show() to use PTR_ERR_OR_ZERO()
> > > for correct NULL pointer handling.
> > > 
> > > Fixes: bc07c10a3603a ("block: loop: support DIO & AIO")
> > Can you explain how the issue is introduced in above commit?
> The issue was introduced when lo_rw_aio() was added in that commit,
> which dereferences lo->lo_backing_file without NULL checks. While the
> design assumes no inflight IO during __loop_clr_fd(), fuzzers have
> found edge cases where this assumption doesn't hold.

What are the edge cases?

> 
> > > Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> > > ---
> > >   drivers/block/loop.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index 0000913f7efc..d8db1b0d8018 100644
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -397,6 +397,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
> > >   		cmd->iocb.ki_flags = 0;
> > >   	}
> > > +	if (!file)
> > > +		return -EIO;
> > If lo->lo_backing_file may become NULL, it isn't enough to add check here
> > only, cause it can be observed in lo_req_flush() & lo_fallocate() too.
> > 
> > 
> > Thanks,
> > Ming
> You're absolutely right. Tetsuo's approach only adds logging to help
> diagnose the issue (and he marked it "not for upstream"), but it doesn't
> prevent the crash.
> 
> To properly fix this, I need to add NULL checks to all functions that
> dereference lo->lo_backing_file:
>   - lo_rw_aio()
>   - lo_req_flush()
>   - lo_fallocate()
>   - loop_update_limits()
>   - lo_can_use_dio()
> 
> What's your preferred approach?
> 1. Simple NULL checks in all functions
> 2. A helper function with proper locking
> 3. Your recommendation
> 
> Let me know which approach you think is best, and I'll update the patch
> accordingly.

It isn't supposed to happen, so please root-cause first before sending
any workaround.

Thanks,
Ming
