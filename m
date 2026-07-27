Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C742175A94;
	Mon, 27 Jul 2026 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785111559; cv=none; b=MWoHgleWO+ogUXP9qMpJdktwB2oZ6VnB35DFgIp4FJAN1GdedocddtOwlG4rMsB2n1HJVNJrtcfx/mckxpSAXiBo2oNhnhzT9DZy1Vaem3GZqz7ks5kTEScfPilTEj2cCT4+yzwUPg2MVhCPIbB7qFQXHkuNyo+AQL28Fw3zrb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785111559; c=relaxed/simple;
	bh=iZlRmoeic/p3AfpCs/NEOxREPTOpH9lfFgO+T69KxOs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VlI53CSXNSo61SiAeJR2aK5crkbJgyKuO9IXcRTyID3oUNoicKqRGDXYsBfAYKdgSIyW80SRarbMEG+osMMyEOyha6D1T57xV+5zSPu7nwiJOBG+xfs/mw6z6GQN1Z7J/oBWUJwhfsyFvitRPQdrLANHD19BHgB+O+u+O23AsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/5C/A6S; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/5C/A6S"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4BF477A002D;
	Sun, 26 Jul 2026 20:19:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 26 Jul 2026 20:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785111555; x=1785197955; bh=dhPzoPnzg1nwG1ssoWkrgJiXvnq9RKTpMbu
	id2V9zg8=; b=G/5C/A6S2xS/bLnvk1yKhePfZyEdsfaNUWVNo6pIBG2wcWpzQjZ
	2mrgAyf7AZ99BiF+HTP8mEIUqvkuS+tuje6R6YaOJ9d4sffdkf1KYTwTPyM6XkkZ
	2mYmDvcc30Dxja6wVif43eEyX793NNyC90txrvCRHmwm2PA0MfMYFg32mQb3NxYZ
	1P5Pz/yszfqCE+z+oKZFloBMSYmpPlgoJcoov8/9N4gjHFsToyvgN4OfOnQgGZW6
	CI5DpMkooaCFHetrxclOchl0uvGDxVSn4K0dyU7h4eRV8XgsVYFIB0aWnKgNixkv
	2UuOE30+oWrKh28FLv3w1Sp7Qc1M7gv452Q==
X-ME-Sender: <xms:AqRmanSK2bQXQ0oCJGStzjO0LZhgiqYXNHH754BDsNvcWC9oVd0lkA>
    <xme:AqRmai2LQQDOBDDypRicvqqq699rUePzc-A8cZwJBtu3YUzG8THTP4-SOt9H2U3aJ
    pYeqjWO3LDsNXZPX2l86eVbM9nkON-ibUsPhN9SGrcXLtgsNXBXdzOJ>
X-ME-Received: <xmr:AqRmassLScaRls-i81EG4e-WsrCyAmp5eiibXWbPP32lLHi-g5TSTZOsage-ftsnvsBc12_HfsLJQzTReh5XjIK-gFpGJObbMyA>
X-ME-Proxy-Cause: dmFkZTGNExzaVYxO1+jFO7L2ssBTlOFrPio2OAuVtiLJB78WFUXEzErArMuNBH+VZLi1Th
    vtievJSsRqZNCB7C/uPmx/Xh2fD6lhOVBJmsiwr4C/eC+1uaqJo+mi6GySWCTC2xsM2bzt
    xg40AQSRYoY68TJmxbHDtGS3Dea6EsxPOB+hEw3ziOW4sr148nsMmiZHELB/20z9tjHiAS
    30mrVjzJYuzLQPhUvJq3kROSn6w6aMohLB3KyXUlxPTuSTuMXw/XbXccJijdC+D7cXenkV
    p3T3x0rRcSWy0FYvGTrTXIAH4Qp8QDSLyOY8ETgMYh7E5EN17sgY1pa8wFamCZ7Yh/SEiX
    NiD4d8BwD0jnFoBLIYgd3yLCq+fVOll79eyTZ0+K0W2F8tUOdGH2ezPSsVhU41CldDoK4z
    Au9a9e38j+JW0e6GqcjevW8AHu1KcwPNA4pQFSOPZIwbnG+EImm4wmb4l7wvBUhpsAruMM
    YjWhCiMIfadT2jQSkUOgDhVIpTcNkPlo1ZZopCKz7G6fvvLN8knIWnkcAcJX/jt+HUyki1
    s2I2uv2M9aRw85/8QC/bf9Ww87Ihp3WDa/LsJNp8AHCZAsu+A2o7O/4aD6sqVNriwRjnO5
    I/N0lcxnHqlv5LNP40txB1V/8Fnt/6++x39lnKMKAkIgDV8ae5DS3m6FQOQg
X-ME-Proxy: <xmx:AqRmaohiP4U8FDZpGmrYxQdwYSli4e-KWCuEI6U72nlJ2UdFk7V7sQ>
    <xmx:AqRmat_hbwe33dMQpX_RqDI9kG7kskfgLPPVomFhYaIr2N4yj7oBiw>
    <xmx:AqRmarujDsAC5IZV816VfIw1P6Ywcd0Dx1BNpjWfGhpG8vs1Zz56EQ>
    <xmx:AqRmahpH-C8HJ2og8BdJn21NLTUe3poCx_uQnsdUueshWL5TzCkS9Q>
    <xmx:A6RmaoAo0j_mcHZknrgBe69NFQYImNv8-MFdQnCLXnVxhXWPeea9qpU_>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 20:19:11 -0400 (EDT)
Date: Mon, 27 Jul 2026 10:19:32 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Laurent Vivier <laurent@vivier.eu>
cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Joshua Thompson <funaho@jurai.org>, linux-block@vger.kernel.org, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/31] swim: Deduplicate polling loops
In-Reply-To: <ff1b3b6e-b69f-4081-b98e-ebd2fa31185f@vivier.eu>
Message-ID: <670c0289-e175-3e5e-b810-d2d2006b30fc@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org> <7f0be2470206f78fb64d7df72e4d6948a21ec2ab.1784196135.git.fthain@linux-m68k.org> <ff1b3b6e-b69f-4081-b98e-ebd2fa31185f@vivier.eu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Sun, 26 Jul 2026, Laurent Vivier wrote:

> > @@ -373,19 +364,8 @@ static inline void swim_head(struct swim __iomem *base,
> > enum head head)
> >   
> >   static inline int swim_step(struct swim __iomem *base)
> >   {
> > -	int wait;
> > -
> >   	swim_action(base, STEP);
> > -
> > -	for (wait = 0; wait < HZ; wait++) {
> > -
> > -		set_current_state(TASK_INTERRUPTIBLE);
> > -		schedule_timeout(1);
> > -
> > -		if (!swim_readbit(base, STEP))
> > -			return 0;
> > -	}
> > -	return -1;
> > +	return swim_readbit_timeout_atomic(base, STEP, false, 20 * 1000);
> 
> I don't understand why we need _atomic() here.
> 

You're right, it's not needed. This change used to take place before the 
change from spinlock to mutex, but patches were re-arranged and its not 
relevant now. I will address this in v2.
