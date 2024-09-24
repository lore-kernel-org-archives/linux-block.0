Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03335184E
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727142399; cv=none; b=lBCBTsyQVTYIc/PVrT2GcyCS6dSeiaDilzbhYFUSB51rhszrMF1EYhT4/o2jClA/wUyYqz6jf3z6I76dR0o7Bal8wK0Qpl0vGBywWCHE5KaW+4kZP4fkDIRBffwctNYjMDnKPtg0Svkvya+T39G3rEyGqV+MRCGayGpPO5EvABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727142399; c=relaxed/simple;
	bh=uqjOc5RRUJlg3FOry9HLFpX3EPZoLUCv5W+OuLPFmDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4eS2iRSB94MY06Af/MadLuro9YfkL2+4E7On4KBEJaVUCAtDvWqbFZJ9IMxy4IqNhBk2FhFjXS7O+DU6uIsM7wozM9rxc2xS9z2mUM1vj/7uZ3ZghDeXRaQFmTJKSsZcyeazUMHfAy24E1BCNd3zNbiO9UxuQL+0o52gnXdMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=htzWQVWS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htzWQVWS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71923d87be4so3623199b3a.0
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 18:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727142397; x=1727747197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjf7bgPkxvbASBQBW80GmywcvOAyN/cF5IYIogDHDPs=;
        b=htzWQVWSfpobRegI9Dg/Y/sJ/jzTnhlHBiToA3u57gO/d/xYQpHzAx0cRLY6xJOGjG
         /xKhRp6TRrIZf7yhFugDh7Md1cisVSxzb38fWGXwP35VrGYn8Cz+rFCC+plY0b7d3Swp
         P3V+Ekvl6IktXnVC0yj6mfUgCSok2FFFGG3rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727142397; x=1727747197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjf7bgPkxvbASBQBW80GmywcvOAyN/cF5IYIogDHDPs=;
        b=QXTNdwxIRn0IA8553rYy1CumN4HoAO4on63BiAgLSdSXmRuMZJym9k9/pXqm4ylYj5
         Ws+chLAVguAL5jYZEulXH0iO4fGYnbx8HZx7j2IJht1wKqCc0iSAFgGp+jxgx9UHqjyX
         Tnigv7cp4k4R+dxyzM7NHGEsuSzQFABovd4hFqWKW0PXccICLkiLznP+uSw/Q4tLQrR3
         RcdmSzzlJ5iFyo0CWg/2CwAW8mD1bqbhXq4f8/av5j8PFuJ6T+G8hXp6ubGOKB9gpo5N
         ElO1IRjZnslk4tGNLuuzY0otEg5MRuxOQL1a9a54O5UT60Mqa4i7ZDGC6kAReHjUnK1u
         +xvg==
X-Forwarded-Encrypted: i=1; AJvYcCXCenA9kWyGK4OHaHK1T3uAIj4m2M7uCrWuZkzj1Vpn3w+8Vg5kcztAYzRkknRHIZIfQoufdtYuXNpBpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQv4C+iVOVltult/WD+V3YnSJ4gVRW/hKi7WaIJq9ZE5w1uQEr
	rHD/VmeS7F6qDQf6ynLiX4d6i/B6sLfzbFBMzrGJ9NvgZADCeF1+PVDNW5HwVw==
X-Google-Smtp-Source: AGHT+IEChjqT75K/jqfu3No+egUQqd+5DAXt7Cf8ovcAwg3g1ML0TXHbIOCQb+CWDVISEwVc4D+g+g==
X-Received: by 2002:a05:6a21:3482:b0:1d2:eb9d:9972 with SMTP id adf61e73a8af0-1d30a967d51mr18786453637.20.1727142397256;
        Mon, 23 Sep 2024 18:46:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc846e0esm232357b3a.81.2024.09.23.18.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 18:46:36 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:46:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240924014632.GI38742@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a4e62e-6c24-4b06-ac86-64cc4697bc2f@wanadoo.fr>

On (24/09/23 19:40), Christophe JAILLET wrote:
[..]
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
> >   		zram->num_active_comps--;
> >   	}
> > -	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -		kfree(zram->comp_algs[prio]);
> > +	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > +		/* Do not free statically defined compression algorithms */
> > +		if (zram->comp_algs[prio] != default_compressor)
> > +			kfree(zram->comp_algs[prio]);
> 
> Hi,
> 
> maybe kfree_const() to be more future proof and less verbose?

I didn't know about kfree_const().  If we change ->comp_algs release
to kfree_const(), then I'd probably prefer it to be a separate patch
that changes both zram_destroy_comps() and comp_algorithm_set().  The
current patch works for the way it is, given that it fixes a nasty
problem.
