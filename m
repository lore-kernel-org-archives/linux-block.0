Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3B482EF
	for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478624; cv=none; b=R7ms8k0VjcNDfmbhIffZSljYBOPGEfYwVI4P47Mqryn6X9k9c8STZWrc61a8GzhSkvwyvFoAu2e9byXlASB+0HnDkqf4b1jJ1WR0vzR1w0YNyuzTmm1gT+8HWnyp/6UeDnlLwEVhr0T+r7Wka/5pE2p2ZHZ3v1HRrt6uAvy6/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478624; c=relaxed/simple;
	bh=5FsEHtEj/NvtQYRLA0oR0Szlqlbhk2HL9IujoJ2r9E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNmPOHn9bw85iFVU4hz8TmCgY3R7FqWJSd6QhOXN2QpIEHJhN3lmdsGMa2yNbt6SPAIW6RiF89iaiGFPNLYjY58mi5rWW15Q1iRTtae8pbp2xnyl4S3E5hWVgE+AvhysfYrA0r6uX7BjapvnuB0HSI1+xnivqKhZqzi3h8PaaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VmzdLf7H; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VmzdLf7H"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f66423686bso37460871fa.3
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726478619; x=1727083419; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUaMYwgpZ2Ku5tNMW6Im6QjDbcaD3sCpWLaYf5Q5iVI=;
        b=VmzdLf7HYzzt2QNbs0PoXYk7LxpCYulktAr3pEOL2AitOoSuDJPps99ooGxlNmaJ91
         t2I1QlMjHefaK7VNMjRZIGDyfZljXKE7NE6914JzR1u3tKJuW2G4zxmWTerPZvePYiOx
         VqZpB3wWmdKj9cPY0TGay40aklkIwBFEgC0ra5U+wJR5dsaHwDcAyEMTlx/YgqgdbLC6
         AX2Mp2k77w79ANlDObNrAnGPg4ApG57j1MQBObiJaqFypJdaqJW1R+LAp+q023Rj/aZQ
         TpHdIWLY5uqjX1bLp3C6e63G9MIkYI/zLn5ZAWiK6DAdR95smz/2F8Z56VdYmN3WJig+
         SL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478619; x=1727083419;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUaMYwgpZ2Ku5tNMW6Im6QjDbcaD3sCpWLaYf5Q5iVI=;
        b=cuJYk7MGVIZKwhWSk10Lx3HTee8hJUdCNR3rR+KQQGMuc1LeseNvwlkkRGNvu0kpuw
         7wfOpP60frEJ7x3Gsr2xKhTFrEpIFJ/WGmUuxV2oAJNUUAq+44F6WFy8Npw14LlsaCIW
         n5zFfdPXnwR7XAw8W/QnJlBRVgZIgyK8MW+auCv2niphhxLF/7yViAG3J4Ix/715ACme
         SbFvAxqLpeU89/gbPtfIqEHL3N13tz3WRpfHLiEovkTWvvwgugoSTNCpgwZEfz7GcuHx
         Bhs3QrIFnfLgN31fxAyfXjCvmCUdm7vnGExrwKrsvVs4uBHvStSnPGkGn5z9jp9iGdQs
         WFSg==
X-Forwarded-Encrypted: i=1; AJvYcCXps747P4XhIkvXEDaLh8PFerow44bak0lxKKy9C0gLWTGY6wjBxhD66mE88/FCSkCxFsqXg9pQm5a5Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIe2ef+FynKPdzrIRhwOGaJYOoZ1UsqIGScBLL3WyFfIe40qX
	RrYG+NNQCbSWpFdkK0oHTT5mk3alIxLxRiuN9ZxZayYrWQcK4p2zRomkPWAmCVs=
X-Google-Smtp-Source: AGHT+IH2cZxToR1Mm2fvGCS6avu+/Woqny9ILHMW+m489L3DnVmBj/IMWkXo2pwKbd0ZCc3idTj8qA==
X-Received: by 2002:a2e:be22:0:b0:2f6:63d1:166e with SMTP id 38308e7fff4ca-2f787da0b93mr79504571fa.3.1726478618471;
        Mon, 16 Sep 2024 02:23:38 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fcb77sm32659395ad.209.2024.09.16.02.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2024 02:23:37 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:23:33 +0800
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
Message-ID: <20240916092333.GF3296@linux-l9pv.suse>
References: <20240912102935.31442-1-jlee@suse.com>
 <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Valentin,

On Thu, Sep 12, 2024 at 12:58:46PM +0200, Valentin Kleibel wrote:
> > Then Nicolai Stange found more places in aoe have potential use-after-free
> > problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> > and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> > packet to tx queue. So they should also use dev_hold() to increase the
> > refcnt of skb->dev.
> 
> We've tested your patch on our servers and ran into an issue.
> With heavy I/O load the aoe device had stale I/Os (e.g. rsync waiting
> indefinetly on one core) that can be "fixed" by running aoe-revalidate on
> that device.
> 
> Additionally when trying to shut down the system we see the message:
> unregister_netdevice: waiting for XXX to become free. Usage Count = XXXXX
> on aoe devices with a usage count somewhere in the millions.
> This has been the same as without the patch, i assume the fix is still
> incomplete.
>

Thanks for your testing! I will look into it and reproduce issue again for
improvement. 

Joey Lee
