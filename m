Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24582D322E
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927077; cv=none; b=igrjdMzzR+jo265VOaRRE6usuWjVUXwRhhhCyQ6pKUT0OdARIdBVUto5on85bltkTWN4/c5JDwu5Dejj0gx11ERI5MYJWyKFImTDBAC/LOqRm90VsRzYeSezvSxy8MnnR8yNWgZgDeaZd/VJXuMDT4UEf8QugY8fSeIpq/OjzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927077; c=relaxed/simple;
	bh=4vcRTEE1p4gHLVkWgtf0fYhZp+LO0lNCHFeQzHhFmk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRTfxF0QIKDO7GSgSs328pLHuXbW8mTpB4LKS8/XjX7gPlHi2glXBTJmEneBiHoaUn+oZSSXA3eL1dsCBDHuLtwyXdUA7U8hLaxzLXfWxPE3t1ZMq02w9azjqMhi1hHVvrD21e7j912O7WeLlBvJiZlq3ZezDrsR1+8oP4B1BjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kXP45FYg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kXP45FYg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b98acaadso5584379b3a.1
        for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1745927074; x=1746531874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzJHSP3MS0syJfOa/96YV4wvogpjUA3oAjisshOP/+Y=;
        b=kXP45FYgSt3zfwvFt/ln0igXoDO18HD6sno0F5xmrv/GhqPimsAVErVgvxNJI8mFh0
         kbcuRWnx79XBZIr+02xBOJVI2mKcp10Fu0n+WGK6Ym2lsQCv/F/UEUivl7scsrnXRoTB
         db/3FDapQBUJkgRd8dG05RSMX5n3CusWPf6mbv1PQB+BNsL8djm79snWTREAl/Hgn2CA
         76+xSYBB3G/7wfGzlkP6UbvRLGo/PEGyD1+ppByMoWd3dbjPwarNE/4CgMq8Vvwim0L7
         9+gO6UaOAc+Gm+mRZuu/J1p3GRyeTD3+ucxMFaB0XKPeFAn1j2AdZ2Zkw66ajDOcVj7e
         9VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745927074; x=1746531874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzJHSP3MS0syJfOa/96YV4wvogpjUA3oAjisshOP/+Y=;
        b=cQk9AtaL1eJd6qAwVt+Ggqb/QUs4OExeCkKdg6yCU/T7bIFcJNMygki971jPpHndaK
         xRUxuQgcSnNNmC23vpZb6zkzmMq6eKfvH3svP09tYT/Xh2U1pmR4nJXXyYdBy/ZO8D0V
         Pck2i2Cze6Cw8mx5q2c851ULQcKYSjsU2KnJEP7HWK2eAaNcmmnBqj2Fc0bJ0RImTFfv
         E0rHzmP5dJrAGrM69RwW87Z6vikO359EH4XgWd8YOBuFxbQgRQYunQYNurribv4buMbD
         UnWlr7pPvv6w1X/YONjOClgZ20bkHBw7nt/MVSGXeQA4ep1YnICFuMUEDZYqoRO6JoVt
         HeSw==
X-Forwarded-Encrypted: i=1; AJvYcCWyCFwrzdw5TNFPJcg76Xr65407UliTWBduFedUYs5Io4mS+Z7cej1QdWlv/BEvYEZVztBQbT09YCb4cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVc1yWn4TPgQCZtSEX5td13E/sxp+gc90nzmaCy6whXo2tqam8
	MVoaf2x/Z5FSDPx6CSxCjocHzKLD8opGzPBBf5aH3x90jXioyH+tFaREVWpK7g==
X-Gm-Gg: ASbGncsRIeJqVL0c56H4ScrKtLqUZItKLLWboPYH1EoExjzrb7y8pq3r4trl7mbDZNP
	CqvY5LtvivR5LFGqLBcRacmhaFsu9HAJnG0y05ZvmGVaO0DlSyG6eAowvkV/JIFshB79TE6oSJ2
	J+oP033krSqoCSlDdG8RfRpxFb7gzdshh7gXsgnxRuNyCdVyinOMiF07XrRzSRQxd96LxSdq2iR
	V6FK93yl9NNCqPTDg+bFr32PYYxDCsA42weDvRFGac4SfcoJIeqTRZt4s6GC1mGmfYaoQ7BX5nI
	raFbD90/gG0vZ2j96OauBsrQvyhpsZICd7vT7M6z
X-Google-Smtp-Source: AGHT+IEYgwsVKsbtIYVQP9gwgDywBl/zdKA1+1Yjlt44G10TJc3OlBVSAXYAq91oHtaPyzunvUH2RQ==
X-Received: by 2002:a05:6a20:9f8d:b0:1f5:591b:4f73 with SMTP id adf61e73a8af0-2095cec6f1fmr4302271637.34.1745927073977;
        Tue, 29 Apr 2025 04:44:33 -0700 (PDT)
Received: from bytedance ([115.190.40.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912ad3sm9981561b3a.13.2025.04.29.04.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 04:44:33 -0700 (PDT)
Date: Tue, 29 Apr 2025 19:44:28 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Kexin Wei <ys.weikexin@h3c.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] block: remove test of io priority level
Message-ID: <20250429114428.GB3896701@bytedance>
References: <20250429082934.GA3896701@bytedance>
 <adca39d3-04fc-45f5-8e34-0d06714f0ff9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adca39d3-04fc-45f5-8e34-0d06714f0ff9@kernel.org>

On Tue, Apr 29, 2025 at 07:50:11PM +0900, Damien Le Moal wrote:
> On 4/29/25 17:29, Aaron Lu wrote:
> > Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
> > definition"), the io priority level is masked and can no longer be larger
> > than IOPRIO_NR_LEVELS so remove this now useless test.
> > 
> > The actual test of io prio level is done in ioprio_value() where any
> > invalid input of class/level/hint will result in an invalid class being
> > passed to the syscall, this is introduced in commit 01584c1e2337("scsi: 
> > block: Improve ioprio value validity checks").
> > 
> > Reported-by: Kexin Wei <ys.weikexin@h3c.com>
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> > ---
> > Kexin reported a LTP/ioprio_set03 case failure, where the test would
> > pass IOPRIO_CLASS_BE with priority level 8 and see if kernel would
> > return error. Turned out she is using an old kernel header where the
> > change introduced in commit 01584c1e2337("scsi: block: Improve ioprio
> > value validity checks") isn't available. During troubleshooting, I find
> > this priority level test confusing and misleading so I think it should
> > be removed.
> 
> What is confusing and misleading about the fact that we support only 8 priority
> levels (0 to 7) and should check for it ?

I meant when I'm troubleshooting this LTP issue, I looked at this level
test and had no idea why it didn't work.

> With that said, the test is indeed redundant for the BE and RT class because we
> have:
> 
> int ioprio_check_cap(int ioprio)
> {
> 	int class = IOPRIO_PRIO_CLASS(ioprio);
> 	int level = IOPRIO_PRIO_LEVEL(ioprio);
> 
> And the macro IOPRIO_PRIO_LEVEL() will mask the level value to something between
> 0 and 7, always. So necessarily, level will always be lower than
> IOPRIO_NR_LEVELS. So please reword your commit message to explain that rather
> than describe what a user may or may not use when setting an ioprio field.

No problem. Does something below look OK to you?

"
Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
definition"), the macro IOPRIO_PRIO_LEVEL() will mask the level value to
something between 0 and 7 so necessarily, level will always be lower than
IOPRIO_NR_LEVELS.

Remove this obsolete check.
"

> And also simplify the patch:
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 73301a261429..f0ee2798539c 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -46,12 +46,8 @@ int ioprio_check_cap(int ioprio)
>                          */
>                         if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
>                                 return -EPERM;
> -                       fallthrough;
> -                       /* rt has prio field too */
> -               case IOPRIO_CLASS_BE:
> -                       if (level >= IOPRIO_NR_LEVELS)
> -                               return -EINVAL;
>                         break;
> +               case IOPRIO_CLASS_BE:
>                 case IOPRIO_CLASS_IDLE:
>                         break;
>                 case IOPRIO_CLASS_NONE:
> 
>

Will do.

Thanks,
Aaron

> >  block/ioprio.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/block/ioprio.c b/block/ioprio.c
> > index 73301a261429f..60364d3faf800 100644
> > --- a/block/ioprio.c
> > +++ b/block/ioprio.c
> > @@ -46,11 +46,8 @@ int ioprio_check_cap(int ioprio)
> >  			 */
> >  			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
> >  				return -EPERM;
> > -			fallthrough;
> > -			/* rt has prio field too */
> > +			break;
> >  		case IOPRIO_CLASS_BE:
> > -			if (level >= IOPRIO_NR_LEVELS)
> > -				return -EINVAL;
> >  			break;
> >  		case IOPRIO_CLASS_IDLE:
> >  			break;
