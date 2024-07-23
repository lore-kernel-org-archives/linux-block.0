Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF8141987
	for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763171; cv=none; b=utHtgupHJ3hx0DqLoLVD7V8BwiTGK/lKXWkwM6tR+svXioh8hJ77cI+6lySUlSUZvj12uxutqc4PGSBR9Q6B/IS7HOvWBeLNmfMk6hOD+aDggjnHc4WcUu6NUbD+EHL4bjRKI+YVfsyvqKsxTT0eBvaGs+S1uJ2KU0WJnQRHNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763171; c=relaxed/simple;
	bh=M2VnkXo+wbUsmtT3hFPjzXd79QIp/PWy8S9j37kl0q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG1xlVXcftdLIDMUMxS7dYJsaQT4vEWIFAy+myGRmcgH0NSLy4MmhlP5VSCjVyQSLmam6ou2BTtN43qVo4SyWsMo+65fpm1M8Lb9dzgsGaTORIWA+gXBeGlqEflJhsazgmKkUEb/eKKtNr806Dg8ybNzsijOH5skMO7BHGyfK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GYZiNaz2; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GYZiNaz2"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7035b717880so82468a34.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721763169; x=1722367969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nW34kFipKS6pHjf6ZslXgNG7V/SAs8zrfAbzCW7a/g=;
        b=GYZiNaz2q4DLOuGRkECJWcwU9oLhWWasbLWOQVbL31LY9uvMrfhsF0O1nx8/EDBNTq
         g4oA+1Hnvh3S1YpUZOSiiBBReNZss48PzbUtF72RU+kehfpBxit72eQH5Atk8zDB4MBy
         dPoEMGA+h29e7X3OIVvy7AjKRYxOhVp97WsYhrCCYQuz5Q4/IRzlZV+YBqoW+S2+/f8x
         II9pRAKyxcb/s4w0oNi3ym8YT/h0We5r4OkK/m1oJ2imgZ6PD0i5qXazq3ltUn5Pfi5l
         ouIwuqVSz98w5NJJzsj8Nxz0Ihl4UYECWQ+c6bBf1VtjsN6EaDWFIUG7xae29lS7ES7i
         Cdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721763169; x=1722367969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nW34kFipKS6pHjf6ZslXgNG7V/SAs8zrfAbzCW7a/g=;
        b=gf36++GYj3/QsFFKMFX0mowlN0DG8Qfw9FBHKPoEk7LJwfZ5/xKcOWNB2DOBU/Xk7c
         FGT2jmpBqispRsqgTyXZOT/BuLHZUjk2e8kBWnWAaeIxbh3HMiYoOObWnNh3TegADu7e
         lmAKWMzXgVy9j9jY5t274DSYm9PkL2lCotPGcXfiAY0omQpGqNrB5/oBjHNf3tsGQjm5
         7XsmB8Z1EfblrTh9aQcy7bAsyBBidzuZ9fGey31GKIQXm/MXAI/TRx02vzUBvABxjYwH
         fd7pg/bouQOl0uh/0HO5D1QyWfkQ5PR9MuoPXlt7SLRDaXPOgW7vpngYRsOgX0wF2bD7
         O0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ufn+IUNVbrKANCpvr7ii6HKSlzaO6FVDI7mlxaPaCHZFmPGDyJjLjPeFQ13hyYORDRecDI+ayM7SxwTnPvd4Tx98artWW7+tOrw=
X-Gm-Message-State: AOJu0Yx6+pHI0A3mCXFd4ro1OCrdSbQvyulaA55b/nPPAiagaPM+CHIB
	KhmQA2rlNvN2x5tK0JYm70I4rm9u8qIPwxb8Ff9otyYRBxrGtsXTbUwymBOJr1ulfQ/J3+Y1gzm
	LA9lGdWgck8082vNtYlxr+v2C6lkKKuIa+OhkmJmaNRRP3XNV
X-Google-Smtp-Source: AGHT+IFzWgVgqawrpDF4VKKw96nb679NrtkvKkbq+xeP++uHwgqtUjQX++gCvXBx3U0oLWFUpeqUpAd2Zkjg
X-Received: by 2002:a05:6870:9a89:b0:260:28c0:669a with SMTP id 586e51a60fabf-2646ec7a740mr1346601fac.25.1721763168734;
        Tue, 23 Jul 2024 12:32:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2610ca7d34fsm470316fac.32.2024.07.23.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:32:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BCB023402DC;
	Tue, 23 Jul 2024 13:32:47 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 9439DE40EBE; Tue, 23 Jul 2024 13:32:47 -0600 (MDT)
Date: Tue, 23 Jul 2024 13:32:47 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] ublk: check recovery flags for validity
Message-ID: <ZqAFX9QorUzcHMK/@dev-ushankar.dev.purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-2-ushankar@purestorage.com>
 <ZnDqKFtBULaddzov@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnDqKFtBULaddzov@fedora>

On Tue, Jun 18, 2024 at 10:00:08AM +0800, Ming Lei wrote:
> > +	/* forbid nonsense combinations of recovery flags */
> > +	switch (info.flags & UBLK_F_ALL_RECOVERY_FLAGS) {
> > +	case 0:
> > +	case UBLK_F_USER_RECOVERY:
> > +	case (UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE):
> > +		break;
> > +	default:
> > +		pr_warn("%s: invalid recovery flags %llx\n", __func__,
> > +			info.flags & UBLK_F_ALL_RECOVERY_FLAGS);
> > +		return -EINVAL;
> > +	}
> > +
> 
> It could be cleaner and more readable to check the fail condition only:
> 
> 	if ((info.flags & UBLK_F_USER_RECOVERY_REISSUE) &&
> 		!(info.flags & UBLK_F_USER_RECOVERY)) {
> 		...
> 	}

Will do. But note that in patch 4 this check gets more complex so we may
change it back to a switch statement.
