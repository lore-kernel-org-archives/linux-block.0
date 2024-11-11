Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491B14F126
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333228; cv=none; b=WRZwKX09iA7NekhDip/t6ybYc7uL36DF8gI4PbkEEM3mdVdkQ3TQOuN3Xe1+zUNkOd9NdOPepSn3nE35o6IHMYtcKduf9GDLEzaocyVgL9rZi+jTD8lTy7kQ+qlm7v1ZNMagUEFRllXwOVX90fh5ZK9WA9djysd3IaTAuA7rehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333228; c=relaxed/simple;
	bh=fsMPtK+02Q8/61h9duKymu2GAy3p9uS9wobeeDtibhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DImZQGesx+Tq0jNp8xiURj30vn9xsKYPaK6wkSuVRTbo40NUV+73pUiZYfdCSakWmqVfcCjb4l4NOhsx5QhvoI+S7uyopCsf+1hyFOXns4v/cT8PuchqLaakUuI0UEB8ZdF1LW9q2FAMAeU+9+B0jBY5aCaWAErqbhXqLbqu4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PPsxJN2E; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PPsxJN2E"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so4442481e87.2
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 05:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731333225; x=1731938025; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRETJB9GMYpE5zNptZDsi0D65To5Kc8GhYkf2DQ68eE=;
        b=PPsxJN2EUAPr+oeJHtixYtHFGW/uDmqw44mJoAz9em21OpW3rICtYde39O9XaIeW8n
         kmetz3HCrB4zdEhdpQcRfqYkb8TFyw/IlzzopTAXy93mTaDFv6HuTohHD/+zQaoVtDLN
         120QDieKXSsRZIG1SruqkZUymdxNq8A2ErzIEyj8Xw6Xi97X0M7gYzvi/aN5GlnJ6YMd
         7d2bci4HsASmvDyVL+kS3d6ye/glfG7aMHjkDYGkd9yukv9bcsrgH2QSN9Un+75t+MXz
         oCsVR/V8204H+PUGrAaaVAVQRlGkwQbPhSSfHLogYTSu81YmS7m6D4A758rwFpEVLJye
         Lqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333225; x=1731938025;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRETJB9GMYpE5zNptZDsi0D65To5Kc8GhYkf2DQ68eE=;
        b=MWU1bwgYGTDMZ8Ay048COOJw0Qs0DBVRKBOf75JZpZzz5Bp7Dzz2IrP7xDyTHmtRqK
         O+s2iSE1d1fsywWSYx6i9c4szOZv85ZP/Yxu19PAc0TBpOtphh+9stoMhG+uTfak5mYl
         LJ8hATmBDbvwE8aKrM9oSnbGYAxozpdv40ABWu54FqfkPegoWes4VL7T4SEfFqjaz3rF
         w05vAe7Dwu0BaLhmBatLOdqBBLAb9yMRES5W6MIwXCtkgE73dR/mEOkgeejJQ3b3EEIQ
         Iov7NtEXKoSenWvBiDBaRsbc5Zzbx4B3iF8PmKlOk5xkK4rRmakGkBaUO/nyG+cs/r9u
         n4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXIpGg7CG69bPRllMDxEEEqBx/6ebbHrvalIiaSb/Mo344Cpl+uX0R0fKAWIZsKVFe7TeXYHqgaMRqX4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdc9oYc//oUjV5U+oT8j0T/Wq4qg1oGzSuiBEXvO0Ydhm9Fnqt
	UNolFk2lLljdiv9q21zXwPWBTxFHATO1kBhU/7ngcLzYJdYZWwW30sudLSxAx89MXNJkSKoRJAf
	7
X-Google-Smtp-Source: AGHT+IHvrJRpNw+sfe/gOsk73gWb+wFtTC8t8WsXJCIw1abIndpgqLZlESkgswoJAksoOzwUb4KDuA==
X-Received: by 2002:a05:6512:1319:b0:52e:7542:f469 with SMTP id 2adb3069b0e04-53d8626a7dbmr5364852e87.0.1731333224422;
        Mon, 11 Nov 2024 05:53:44 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62d686sm10616662a91.52.2024.11.11.05.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:53:43 -0800 (PST)
Date: Mon, 11 Nov 2024 21:53:20 +0800
From: joeyli <jlee@suse.com>
To: Valentin Kleibel <valentin@vrvis.at>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20241111135320.GF20879@linux-l9pv.suse>
References: <20240912102935.31442-1-jlee@suse.com>
 <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
 <20241002055338.GI3296@linux-l9pv.suse>
 <a471d233-8fbd-4a67-a50b-6686566f8103@vrvis.at>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a471d233-8fbd-4a67-a50b-6686566f8103@vrvis.at>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Valentin,

Sorry for my delay!

On Mon, Nov 04, 2024 at 02:38:20PM +0100, Valentin Kleibel wrote:
> Hi Joey,
> 
> > > We've tested your patch on our servers and ran into an issue.
> > > With heavy I/O load the aoe device had stale I/Os (e.g. rsync waiting
> > > indefinetly on one core) that can be "fixed" by running aoe-revalidate on
> > > that device.
> [...]> For the reference count debugging, I have sent a patch series here:
> > 
> > [RFC PATCH 0/2] tracking the references of net_device in aoe
> > https://lore.kernel.org/lkml/20241002040616.25193-1-jlee@suse.com/T/#t
> > 
> > Base on my testing, the number of dev_hold(nd) and dev_put(nd) are balance
> > in aoe after the this 'aoe: fix the potential use-after-free problem in more places'
> > patch be applied on v6.11 kernel. I have tested add/modify/delete files in remote
> > target by aoe. My testing is not a heavy I/O testing. But the result is
> > balance.
> > 
> > Could you please help to try the above debug patch series for looking at the
> > refcnt value in aoe in your side?
> 
> Thanks for your work, i can confirm refcnt value is balanced and the issue
> is fixed now.
>

Great! Thanks for your testing!
 
> However, the I/O waiting issue reported before is still there, and occurs
> more often now.
> This problem started with the first patch CVE-2023-6270 applied in commit
> f98364e92662.
> This only happens with heavy I/O on our "older" storage systems with
> spinning disks. Unfortunately we do not know how we could debug this, have
> you got any hints what we could do?

OK, spinning disk is good information. Could you please give more information
about your environment? e.g. CPU number, storage size shared by aoe? how heavy of
your I/O?

If the situation can be reproduced, then I think that perf can be used to analyze
bottleneck.

Regards
Joey Lee
