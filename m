Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE058231A24
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655174; cv=none; b=uzvQDAOV0XdDp+G3sOMLb3iLatjT4UxRwUBOWJ5VFxZHlOhGyUwLEWCPAMa0fBVcCEMKTRa42GT0ModFNOyS5MSzGoqrdFlEahJBEOr2aXJBq+KVrJjMAH8uSMNCs84MltflunnCDnW8gjgf23daknVYwVsYAFePQGg7HfppIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655174; c=relaxed/simple;
	bh=qmK0HZdksunB42Iw/hplJY6dcjWGH1zn3JnnaPJEi5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1ynNlgb4lOekJTGWFYDlbLcqG502X/fGuXymOdwylaueOsuRl1bUlePPPP0CpRf31U9XYrNbqgZJ8vsMHdOYfTFnQ5n0cKBblA0xEc8vQwxT/JSLJjall89DYmFT5K/tfyPVpZPW+Y0+EVHGCNEqHNmzawEw7gTErU7+9J+mkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a6ydvmT0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a6ydvmT0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33677183so3981985ad.2
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746655172; x=1747259972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rh4j5BvAfXZF7bmpZu0jQ/ugGagunI5OepSAuxXPpsE=;
        b=a6ydvmT056ujp9FcGOCZI8XvxFuJK6lJnNNl8hoxqfbR0qHNB3vy2/MEH5Rvvs67RV
         hHr/4+Xvui2AnGihzyMxdzP3lt3oBfHt8E9ss+JlaoKtkhkcJ+MrgAX4fmtE/m4vgFpR
         t/ybZccqvql+9H74eY3ndR4N8VlhOE5WQFl52FtVU3OiIMw8mA+ppP8s8zrNQ46Ticvw
         PQxd+jYBkRz1whbL9SG3hOurLgcdyJrhkRY4RdteUiRacRS0pC1e1Xmk//uzaA8znObH
         54jvNazL4LRI0jC7urrQZk6dCM4KCOQJA2wjNjPJDMPTTf+nEUGpQ1l7OBFhq7g1irMN
         kAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655172; x=1747259972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh4j5BvAfXZF7bmpZu0jQ/ugGagunI5OepSAuxXPpsE=;
        b=ik5PH/TYD77o0GTJR2p9zcDhWwMEJIjPJufVs1pQEUv+PLVTnz/Tc5KeZ6A4ecVNAS
         IqvdFJPJsYUG6cS5B6q1CDiNyIW2EItMQHbjLH8sdGsFt/7hxF8IFsGecZFhiPqcnsar
         MHXORtdOYluOMvLPov8hec8BhxvEceQSg5VljO5sGWe7+H3mcHY7sw5ocUIYw1CoOdzz
         ga7uihCWLedhZslbeR13y+TvyHEFKuLbVC/fuTdAFdZH2vuNSjD/aVEzpoIGak+X586J
         UEExomjo0nGgw3jV9VewPVTnDB7kZO8VPawjE+1TDkqtXEn2r3NyxKeP0BZ3mkaaeBqH
         WE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcF1NV/ISVqM1U7UtK7ABg9Zo3NyzbXx1ynVuG8roDexWBAcBKAfq9sOC3mgte3uXjDC3hBSusp1O6kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGjOR9HFrUbrQjp2Uk4cSol3hxnLNq13T2oamUKwi4AVEUvfj
	mus9cEAIy0g7w4DiJmy0sEbDtn07ZFMqN/1fZvcdiB4KC+NIOcbO87rMcxNP140=
X-Gm-Gg: ASbGnctawvpBzxQuJ5ebNZzNwiDZi4YPmfblUuhah9E4lMO0hgF7jvlcR7/wBuxHUN4
	/6ENTVdQ60XqYTa0M3rtnF6BDGqOmZi24tZ9lpoMTpglHLaEXhDyjs+RoNcBbng+MSbtg3oN03O
	jWF8n2wLJtt64yZckqp+xBExcrwv2Yr2Jw0/1I1jBvKApBMB0MM6CuR1l2iDE0zaLdPg/wCBpKl
	ZDmvU63cp1dpZiBMBsKR/OZU/yQ3uPZzNmgxuLVk/vCyiII+dscC59pxZf1jU9o75YIEBWACqxX
	sic6c9GxCsCXh0Ag33acL4Qh6lGk2PdGl1y7jbIZDU751n2qxca7Jasn0q5ZRFWLWqGbml+UgtZ
	522nylczQIqaPqgz20iVDHxLe
X-Google-Smtp-Source: AGHT+IE1xxxerfJkV5Vbq7cdaXtmbfAA/IeC6rJzLbxihaJKNjABSSmh0OYDfzxkDN41CkecVlaUHQ==
X-Received: by 2002:a17:903:2286:b0:21f:988d:5756 with SMTP id d9443c01a7336-22e5ecdafcbmr68689475ad.42.1746655172014;
        Wed, 07 May 2025 14:59:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fd4fsm99541775ad.146.2025.05.07.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 14:59:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uCmnY-00000000gXW-3xM7;
	Thu, 08 May 2025 07:59:29 +1000
Date: Thu, 8 May 2025 07:59:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: Laurence Oberman <loberman@redhat.com>, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBvXwComvV-uAqmb@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area>
 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
 <aBlCDTm-grqM4WtY@dread.disaster.area>
 <CAAiJnjo87CEeFrkHbXtQM-=+K9M8uEpythLthWTwM_-i4HMA_Q@mail.gmail.com>
 <aBqDGY1i3RePyzaB@dread.disaster.area>
 <CAAiJnjp6WuVaxXbjndF8dB3fuWCuWz7Nqzpz0uEu2BOqyZUQHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiJnjp6WuVaxXbjndF8dB3fuWCuWz7Nqzpz0uEu2BOqyZUQHg@mail.gmail.com>

On Wed, May 07, 2025 at 03:26:08PM +0300, Anton Gavriliuk wrote:
> > `iostat -dxm 5` output during the fio run on both kernels will give us some indication of the differences in IO patterns, queue depths, etc.
> 
> iostat files attached.

Yeah, that definitely looks like MD is the bottleneck. In both
traces the NVMe drives are completing read IOs in about 110-120us.
In fedora 42, the nvme drives are not at 100% utilisation so the md
device is not feeding them fast enough.

That can also be seen in that the rocky 9.5 kernel with a nvme
device queue depth of about 4 IOs, whilst it is only 1.5 for the
fedora 42 kernel.

Given that nobody from the block/MD side of things has responded
with any ideas yet, you might just have to bisect it to find out
where things went wrong...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
