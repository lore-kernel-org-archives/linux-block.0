Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21013A868
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028428; cv=none; b=D9cX8xEHnX5Lw2zndkYV8/l3zWqnX1nCagWWnT/ogUAgZh4TyOQRDmqpFL+dH28PdNgP4eREO4gzsYfkoDFJ1OnAFPC/vxEyw7ii8HP2FpSlp46t0cUGL3j6uwRb5P8YYauoJbt1YUq+kMaNNMly6pLlfbT2Jdq3DX0MqZlAUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028428; c=relaxed/simple;
	bh=mBPw/l43WqpBhYb5GYphiZJqwn9HXtWJeKHPO72ZMY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB1kADgYNVvrXEluQvF9iQTtQMifENYO5rySYxooovuFL7Rgi4LHNaXKnJV93r0YUfLsQajAa+ANAe1lFq1IR46pr3dCEH1LzqY6qoaSR8npixV2ypPCBBJ47cYE9M1DosC0TXxmL0SC94cRHeWF5afNM3WDu67mUCEQYleCxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cg6g097k; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cg6g097k"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so1283706f8f.0
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728028425; x=1728633225; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSd4XkWxEjHWSImRXS/OrAr6nrk5as84KbJ9s1v67IM=;
        b=Cg6g097kKsEnUo7+xHUI7rFaXN15XgSDdegE5fC6nC1tZYn9IA1mAhQYdR0Sgzar96
         epY/yDuVnENeM5FYJrTCSYWvXm/PlrgxhJqboAkgb+bbO/eaqIy1xFAWUzy/myVLN2BR
         YO5PrBqJYvuZErVY6T+DPSxB/PynIQvpb866r67Grl2g7xsz3fqWUxbAW1Z7i1HtOfJv
         TBoX/pcpDnG4pWsBu6mdOCNzGoadPVs2MvfEiyeSMMwC90DYwHmQH5jkrbilZshRi5ra
         xxnd7usN08Ezj8TQqrDkeEHuqaymy6gi/ZLPHQT9M6xBq53JqgtzRfpwk+K4fi8f1GPB
         E6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028425; x=1728633225;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSd4XkWxEjHWSImRXS/OrAr6nrk5as84KbJ9s1v67IM=;
        b=I1oNIYCS1/z44KtZYHKKxU+FP89LBPbUaKEGvpX4reUjmPXhkN5/eMssj7yCVsNo/k
         dtAKOTtO4LcWNUdHxY+OqWaVVBYj3tw3IeToS9PCpu9WpxJDf8ZkvzlbFacSyGxVOY6E
         VHwjPiNJaQNOLjvi3wTNJo4R1ax+raw46Fl/hBEySwkLSDJonAWPsyAbY9ymyg1oKmJG
         A2gSV+N/efoM614mj1YhSj1rHb1uMCyJ7itXh29iVKZCPyrVHgDcuuNIT+c0AZK4n8Nf
         qjTSgvvGOty6LaCzNH2tZunhCDnwIrJC2C6C9Ad0qRoMMCTJ9qhuQWI16bAYKcM4hKNO
         T9ag==
X-Forwarded-Encrypted: i=1; AJvYcCUD8Q2p4aoHMXJTRBIehvxYJJFcVLrOcIZp4c4R2CCqwTm2HqHkjVwfWQbSV2rWmd6XROf5J7urs6xpCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmT2X98Puo8tKYoGxhl56vSBjO3C/utosG/0qRl+jFyRTgaGB
	9+3pjD2OPvj5HwNjEwvPAqKZp8kzL1lLzwWEddHj3v2TNggd6I4D0iuDrvnE6/E=
X-Google-Smtp-Source: AGHT+IFN79cyZs/XWOlRSuLPxg/RKO30DUk3/AcaruChZ5ovj1sCHyhqFglIvrqyefPzf37H3UJWfQ==
X-Received: by 2002:a05:6000:10a:b0:37c:c4f8:5e06 with SMTP id ffacd0b85a97d-37d0e6f26ffmr1079939f8f.20.1728028424395;
        Fri, 04 Oct 2024 00:53:44 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefafc76sm19158985ad.208.2024.10.04.00.53.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:53:43 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:53:40 +0800
From: joeyli <jlee@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] aoe: using wrappers instead of dev_hold/dev_put
 for tracking the references of net_device in aoeif
Message-ID: <20241004075340.GM3296@linux-l9pv.suse>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-3-jlee@suse.com>
 <2024100223-selection-thirsty-99b9@gregkh>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100223-selection-thirsty-99b9@gregkh>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Greg, 

On Wed, Oct 02, 2024 at 08:30:49AM +0200, Greg KH wrote:
> On Wed, Oct 02, 2024 at 12:06:16PM +0800, Chun-Yi Lee wrote:
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> 
> For obvious reasons, we can't take patches without any changelog
> comments, nor really review them either :(
>

I will merge the 'PATCH 2' with 'PATCH 1' in next version.

Thanks for your review!

Joey Lee
