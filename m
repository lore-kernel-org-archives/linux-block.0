Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25550244687
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939680; cv=none; b=Y3wo47N45Ue7rrd2N+xbCBqeoorrhvStOwutFBb3p6Ii9oAHzzMimhenwuw3QDL5xmS0SnGh8iOiYOxBaOmmKe1s9ez5h6+b49GPSVRNPcCgziQ8wCX9cn+H55yzBtCF3HwY1rvTJ6TzxIcP+B2jsXW5i1ChQVBimcht4LR+ZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939680; c=relaxed/simple;
	bh=Ao+JrQ4Wg5nQE/jWMUiMsDRLMeTD7rT78rxYr+SiRLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3HlwvkyKviTHHtVGxZrlRdw9Zn4BJGxHLerETKgD2qwF3HMFDxxLTOi/89oIGwOS/THOtNvxVCx7k2Xu625C61tUcmO67iwNcHVSiM40CL51vSWfeenusW4p1amIU3yaSwcruRFpLchfiGWB5V73kWZ+d08m/dJDSPI7E2U+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/6CN+8+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/6CN+8+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5164dafcf97so123212161cf.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 20:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779939678; x=1780544478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sga9RmpfP53rYiBjnmaPnQfGvT74E690u8FkgaINL7s=;
        b=D/6CN+8+03NHEhmxyElYHwMxLCogqUA1vI9bX9cZxqX/2TJPLSY8N0uQK4JcwRggY6
         bUGoPvFCK8VC0b8cb98iUWE3W80QeBz9m7ot4hw9hukQQ8HHHr4NCnO65liQcckghRyd
         v4p+w48pgHq96i51GwIx78kHOrXsudHCO7PV2j26nd6HuMA/FVnkfi/QktOFyocRCOBn
         uAnQuLJWHPnh4je6IqNOgTR2HFHFAcqnKP8V2SKsrZ86crPPV5eO/HBn8ZAZAD/1agCT
         AF8xwyIEgO7TwHK8CpmeXWuqBlSmePsAs2v1tKHZuXwTp9zoOAd3Fb25t1XUXVBWnBUV
         YeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779939678; x=1780544478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sga9RmpfP53rYiBjnmaPnQfGvT74E690u8FkgaINL7s=;
        b=fayoCLL1CiUYhtNymzZY9TgO0A0tU09cWlFRNe7l9bJ9XHaoD078iyNCOfGzU/trmQ
         mdwgsB6/8ECCOMlCtfgVzRuSBAR6vjzhyD5MvjMvFgBlqECYTMbWxSbdlZUD2J5nvetM
         k4nYh6h4Pqi5IMl6ge5wvBJpiItKlQ2OCdaoMrUt+C/7vv9H0Bb3NLo9Umjpeiwt0rBY
         fDbTT+kzmZQWwUDFAEO1PJ4HndGMGJTRZHSXElrkXUzH27GwJ2z1KH39EaQZhZssqTuv
         EQVnR1R1339dnoqaKmhNNCtY03K+pjFDo6BaLmSg7Gz3/ioyNCIEy67Ndmv9Wua6vmDj
         ANvw==
X-Forwarded-Encrypted: i=1; AFNElJ+hyzIJf8QMlGXhNlvrrmdtr/KZEyhPisxlGur4r41h9gTujRUh+u22C8HdjNgh1NBO4zhw2fz3k/fHGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeDld1C8SZbTeT0raGlJBxumH+qLTZq6d3PsdmavjWCCjfK6O
	P3sUPKlP54+/p0CiqErn+4m/cOs0pySumaGp54YmglCl8NEp644XUi6A
X-Gm-Gg: Acq92OEwyvGjDO+3XjllNSUCfSQ67iKuHWoI0nM1uq6xVQV9PWOgmG9LMYx6WturEXi
	qPGvDUiJDUPGBRibz5fi1cnn3l1sbaHf3kz+sEPioUGY+HO1N6YzEMu9FdvarX7Nk1sdfe72u5e
	3SYzBbjpPS6mooL/P1iYKBcYAJrbWhqhsXrUGYGSz+zT/1mSvJb9/TEvUMLUoJR/9mg1CJDpopC
	LKifd9RusWoqZxDRkWCeKfnM1zbpOneL+zE65sqGK+AeDf8Xdy2FkTHObxAjaa0QDPPIb3/VAJ9
	fO0eq4dI7TvNUCefMYpT8rCfyrunhtXXpYXRQ1XZFEUu88nth/xySMJWx3Jm+F/CIaBzVrLQgsP
	XzyauEc2JXeC9G9tYHZ4goS1MkImk1IEdOc7tusO4qViZJlWg6s8j5crk62/CBpAkcbgOcKAcmh
	bcG0yjJ0pg/eScsIps0KSIWRyjTEIgaLSFgyyeOoSh4KL3QDH57TwB8HZiZLvBlWWcaqb6ME9iZ
	s/lFHmGxGO2agHlsKiUH4p7OXiLw7fqw3PbVv36YMI=
X-Received: by 2002:a05:622a:190c:b0:516:d25e:951a with SMTP id d75a77b69052e-516d44246acmr346134371cf.8.1779939678088;
        Wed, 27 May 2026 20:41:18 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b066e5sm60033391cf.26.2026.05.27.20.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:41:17 -0700 (PDT)
Date: Wed, 27 May 2026 22:41:11 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Message-ID: <ahe5V8u0lKx8IOwF@fedora>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-4-hch@lst.de>

On Wed, May 27, 2026 at 05:10:22PM +0200, Christoph Hellwig wrote:
> The macros are impossible to follow due to the lack of visual type
> information and all the braces.  Replace them with inline helpers to
> improve on that.  Because the calling conventions are a bit problematic
> with a lot of passing structures by value, all the helpers are marked
> as __always_inline so that they are force inlined.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
