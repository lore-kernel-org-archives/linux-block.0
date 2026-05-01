Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CC382F09
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632906; cv=none; b=Xv93Xv8kLhsxyYaZDT8/HZHhgn5BJYwnB978YkhooPPpWtWsG17eoOTmQdy2I5+2T/ArSn5awoZVUsQxBS+NamVwaq7UjvraNP11yW5XzyXX21ZEzla1d1I2Hb90g7CwT7WFRiN4fj1GfbC7Yz05vvmLcHJ9SYAabqBqksjGDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632906; c=relaxed/simple;
	bh=5fkUIzcUzt1A7CV9iJpj35vlY81UF8qhMChYYea6fgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka7gK2XT3Pm6l63Jd9acjA7FriUwlK2iRHf0h3HZxknLblXMNa/MNxDsRPRzikRmgV2vW8/ahG1BkkF9n2eRq7HCj47lnffhtAFe/7DMlCno/Aj69Sz05/cSLjVDLaX7GXohev0Y+FDtesDNlnGsXtt/oa9fhPl4eBChI23cqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl6nR2bI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl6nR2bI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so19781375e9.2
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777632900; x=1778237700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vhLSzbXANs7xGvI14rNuz6JL9wvXD5vuBGg1+6WTmA0=;
        b=Wl6nR2bI8AI6VW2SQckqlDn72U3aGwP76ri+JS4iD5Qe9DIQv1fVRO+x3DEXFhMn5N
         eNNeYS0ISEtmD+itfKSwAuGg9ORtjILtX56LRfPusvYk8yOV+pVNefQ3m7RWRe+lVWfQ
         Q6EM5iifPvHoFySdhfJCL48b+gHHXv5aH9lhShAmkuHVZD4XbYcQ9kekJEjq4iF/beoR
         +5nJi0QZhjDOQhWgecHAqWYetlQAWUgFCaD+zFPt4MK4n8LUO9jAtpiAwtVLM7V/yqPi
         p0nTtcx4WP+CzrSJh+SMlf+Ot4ZeG/RKiRDealQw34Pm4QiB7bkSbr/Q26unzUw4T38v
         qmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777632900; x=1778237700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhLSzbXANs7xGvI14rNuz6JL9wvXD5vuBGg1+6WTmA0=;
        b=DThwvltCOZn0Ab3sOjmsh9BU3NATv+GW5oIUjjRWVx8zN3hlSZ3Azsmcg7Kiw1K6nv
         xnobgdL1j95tAvmFV68rC1wH66iFffCEjbJLFIN+Ur4/QvkyR/dJIS8F7TXN9kCc6F7T
         SoROwFs7TLCer2jvthQnZ/cphcpjhF+VPA86QPprsDayDYeddfn7mVEGZcj9gzR/Gfdb
         kmsbXqvu2L6Qq9s7nNL6mTIu5zuEpu15+7+qqMGWZN7ikNaRwQr4kujcUdTbn1N2V4ID
         LWMon6MRpG+NGjNbMMLy36VS0/gloEDW5gjBpsvAnmGdjbO4Svg6ZxFOCretuuPV2kRm
         teqA==
X-Gm-Message-State: AOJu0Yx6yG0LZ0vXO/9jbOBVSnV9RxNRRpaLsBv1B8025X7d0hXkJZu/
	DenRzeH9KQnBpCRk4oXK0gEeAofEIpxwADuaFF6PMvntleTtBc6Pe5iT
X-Gm-Gg: AeBDietV3INmoKlH5c7wtSPG0Q/naV47FwwafMAnL/MBlyr3GYNOtimiyRrVz4jZt/U
	jIoInP6uWbWC9cpso267rG8JI9MaW2wvEUXww6wuFoKFtwiFYovi0Iml0q7/CT+pR8bQI62OJq+
	xlktbFzmodkYSY098aEmO6si4pAOxejsZL2iUwX/BxtCn4aLwIlWp8xJmN91B5oiyCySiwnGEyl
	OSV4fHMuDvorMlCQ4aN6cUT//E85uJKoK5TSGsDiBtXRAsaJFMwaQSnJfd4YJh2mjghvNqv5qa6
	n2Iu8Djj7RiT5VEjOj7AdZjlofvxP5mlaXUR1SO42PgN5LR5ohDACY4zWqjdKS5V7BLfl4zOROQ
	j2W+/yO/NV+AKIiAUDO49yprfAWOeZg0vIBuCeiG7L6XO5/7X+ydEkTd+AE/K0zp4q4c+sMd/DP
	FiJ82OhH+HWx16vswTKGnjkslJBILT5buUzPdCle/PAq/p3mQ7YtbHE0+hYOnl91R+86e1nrfC0
	+NOigh16HrlKaI/fXo=
X-Received: by 2002:a05:600c:4f47:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-48a8451d08amr105530515e9.17.1777632900013;
        Fri, 01 May 2026 03:55:00 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4d60sm10612735e9.19.2026.05.01.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:54:59 -0700 (PDT)
Date: Fri, 1 May 2026 18:54:53 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH] ublk: reject FETCH from non-userspace context
Message-ID: <afSGfdcmtKHpvR07@fedora>
References: <20260501085216.905401-1-tom.leiming@gmail.com>
 <9efbd035-b40e-4155-8382-b42acff75a9e@kernel.dk>
 <afSCOu40SoLXQpwK@fedora>
 <c97fe4d3-9b48-4793-a008-4fbf7e72f5b0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97fe4d3-9b48-4793-a008-4fbf7e72f5b0@kernel.dk>

On Fri, May 01, 2026 at 04:38:22AM -0600, Jens Axboe wrote:
> On 5/1/26 4:36 AM, Ming Lei wrote:
> > On Fri, May 01, 2026 at 04:34:11AM -0600, Jens Axboe wrote:
> >> On 5/1/26 2:52 AM, Ming Lei wrote:
> >>> __ublk_fetch() sets io->task to current, which is later checked
> >>> against io_uring_cmd_get_task() in ublk_uring_cmd_cancel_fn().
> >>> With REQ_F_FORCE_ASYNC, the FETCH uring_cmd can be issued from
> >>> task work, which can be run from io_uring's fallback workqueue,
> >>> causing a task mismatch and triggering the WARN in cancel_fn.
> >>>
> >>> Reject FETCH if current is not a real userspace task, and it is
> >>> reasonable for failing it in case of io_uring fallback.
> >>
> >> I think this should be caught in ublk_ch_uring_cmd_cb(), which
> >> should not hit ublk_ch_uring_cmd_local() if tw.cancel is true.
> >> fallback work should just be terminated, not be issued.
> > 
> > Yeah, that is definitely better, will take it in V2.
> 
> Something like this, totally untested. Caveat: probably worth checking
> the other tw paths in ublk as well!

tw.cancel can replace the check in ublk_dispatch_req() for ublk_cmd_tw_cb() and
ublk_cmd_list_tw_cb(), which is one cleanup.

ublk_batch_tw_cb() doesn't track io task, so it is just fine.

> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 8e5f3738c203..d10460d29e4a 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -3496,8 +3496,10 @@ static void ublk_ch_uring_cmd_cb(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
>  	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>  	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
> -	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
> +	int ret = -ECANCELED;
>  
> +	if (!tw.cancel)
> +		ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
>  	if (ret != -EIOCBQUEUED)
>  		io_uring_cmd_done(cmd, ret, issue_flags);
>  }

This fix looks good.


Thanks,
Ming
