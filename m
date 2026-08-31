Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F53DDDBB
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169096; cv=none; b=pvn734kCX2gf5/VNl5C4U6sjRbgNH+8KfjJMFb9c2abkai22bbqp2r33j6NuFx20zNoe6ATZwhAzKSpKQgXJLrxnI0rf0kpV+hDNG1CMLmFCDH2hoomTRN2yZadfAp6O+LR9fy/HruIV8swZyRo6lF7Fymz+mKSbz6aRU0lxflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169096; c=relaxed/simple;
	bh=8CU9lUBSr36Vnjtnh3nf3UPr4d8FKMwSks35Tl01xaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPj3o015qB52BAqPojp1+JdHiQwFnLxRPMJbcdSZp3aH6K6mXcVkbfhwBijxsIcjpEA4NVznpd9qjRv8mdt+KHyl6vUEvOp06FR+JetT0a/GUpufcsy7TXQlgS2JCNAHKWr1QfTVmw5flYjpBfUdGT2/Hcfo8plvmbYifmGy4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wd18PPwR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wd18PPwR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so2866430b3a.2
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788169095; x=1788773895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d4945ExoKdc+YvBa/novL6lrWieQR91OCgBEeo72O9E=;
        b=Wd18PPwR4XaqHg6klvQWxvmWR5iS0hdAFo+vhFQgVTIjTDyqi5SkkwMTicx2balH6c
         AuZ9l44emh5yim/pLpXkelkhHPgwSYm7cvgB140ZGqgsF+gLuXUPnraYRywOxYi/CKNZ
         ST3v9oKyczyjiytesUWG+IGxQ9OrX2Qu/zIXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169095; x=1788773895;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4945ExoKdc+YvBa/novL6lrWieQR91OCgBEeo72O9E=;
        b=b7nImZgg5PLWbLU0idvLiPb4bKvOBWzJG7vkjWtGJsr/CK81ye9ObX6uhu2hklVb9i
         8mJKKppfLWbED4AP9ylvjAmsS6XBvri05FMbVV76Qqmf6jbHKVPHhmxmppPqtTD4wXwZ
         1rkQygStpQP/qVwa1Dx738lUbe+W/GhSwDgaHd31nlSELg4WWnOpt0n30lkzvqEdV662
         MI+JiqvvhYYr9CYSr3ltyUX8spQx0NSrQ26K0y+dko/SaJGoPEKk0zDB6staFzSLB+Bd
         fHjyWHT2CRbFkbiFv1W8xVJrBnkJCS2hg0wza22Mtc++3zhM+b25iDD0ubPLL2KF8grD
         umrA==
X-Forwarded-Encrypted: i=1; AHgh+RrDxYu8E7SRrWvQUF66u2StxqfsCfmVp0y9+k98aNrxzVYRUo9C4AxMseP7kijz0Zo3PuBm1BoS9lEc3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l3bofCfn+RUv8WRLFJq2XwKizppkjxDQROO+MbKoT4JnCUKCkK
	z3YrN51omtJQWyxypER0NDv++5iSFFIcmo9+Ov/9rthsvDqxeugnA4GFdlUjhNJgXg==
X-Gm-Gg: AR+sD12P0jUzUvwwPza5u/vPvoAe2lPRgdw3msLQyW+lyG8kv+lrin1dryx77GuG7Oo
	lsf9jVb9XaE6yupFSN2HrZr1k23QGBY2VKNKL3PwHIGpC5eKNTtNruh6x2l8sfxAp9mLNB9PHVI
	vj0AyiLvRV3EQs7NDPsdPV9ILajgOEppZvvTuYA+3ahy6/ktpEBYEU2x72GvDdqbcpb/KJpt3o4
	TGftACJISYuEl6YOtaouUvVlMfUIki6RRgFd1J4Hvli94tqmD3Q94sTRcjD6cXOY6ZSBGbdYXBE
	+xsR8PcjbiPwdRTFkEwZ29nKqWx7a61pWnwV2za8zLbSxgSwaWT44icA1TqNOQGv6r/UVcr1Soe
	v9YEHITrxoBgw468kw9/ZvMeZtGEEKCe3IhSePvhS5RxF5RoZmECY8jy8VL2SkuJq23AiJO+1Vv
	Wlz+HXXisnagg//tXhZU9FHNxjhIQEwnbVwZtSMeR2gJh4yv4UCKl3Nak49z/ahYa9OJMVyOxAK
	f0p9oEVkHNCc955qWHmjY3QE/Qy
X-Received: by 2002:a05:6a00:9508:b0:857:74ae:ad76 with SMTP id d2e1a72fcca58-85774aeb840mr22077655b3a.26.1788169094792;
        Mon, 31 Aug 2026 02:38:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8dd2:2971:8401:7686])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a3d689ccsm3376995b3a.58.2026.08.31.02.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:38:13 -0700 (PDT)
Date: Mon, 31 Aug 2026 18:38:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org, axboe@kernel.dk, bgeffon@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apVK4g2ikVJe_Hcg@google.com>
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
 <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
 <apT-ocFYDmU6iC-j@google.com>
 <c961850c-09d0-3366-73e0-1932c1dc00e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c961850c-09d0-3366-73e0-1932c1dc00e5@gmail.com>

On (26/08/31 16:37), Hao Jia wrote:
> On 2026/8/31 12:15, Sergey Senozhatsky wrote:
> > On (26/08/28 10:24), Andrew Morton wrote:
> > > On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
> > [..]
> > > 
> > > Thanks.  Sashiko asked a couple of questions about this change:
> > > 	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com
> > 
> > 
> > > Does this early return prevent marking valid boot-time pages as idle?
> > > When a page is accessed during the first second of system boot, its ac_time
> > > would be 0.
> > 
> > There is no possibility for zram to hold pages during first second of
> > system boot, regardless of whether zram was configured as a swap device
> > or as a block device (mount-ed with real filesystem).
> > 
> > 
> > > Can the early return above bypass this zram device initialization check?
> > 
> > We already do that, e.g. when kstrtouint(buf, 0, &age_sec) fails.  Apart
> > from that, that's not how one checks if device was initialized.  We may
> > want to consolidate those checks, just for symmetry.
> 
> Agreed on both points -- the early return is not a new "bypass", and
> the write() return value was never a way to probe init state.
> 
> How about moving the init_done() check to the top, so all the early
> returns sit behind the same device-state check?

Yeah, I don't know...  Moving it under device lock doesn't buy us
anything.  We don't need device lock to validate integer rangers,
etc.  There are validations that we need to do under device lock
because those require a consistent device state.  But things like
"is system uptime less than supplied sysfs data" don't logically
require a device lock.
