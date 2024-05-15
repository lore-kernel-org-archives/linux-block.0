Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F0381B9
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749786; cv=none; b=LFKkwxNeD8Rpd9cMysptEcb2oOoqgcpp9jFxG1P5zEdXZl6OFnUrZMvQEtwjIgkVXB3vMhntcvu0qtfhAz15cZB5beFKMx6VOuxYuSVsgRIiHS0yqIZiiHQumS3R6YxE3MWkDEfsvpirAwd8Ujlza7zkGkD4BYyacGaebQY0POc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749786; c=relaxed/simple;
	bh=PWr1eoNqTJuHMfIrKTjK0JxHOEZr8PegEGVOLzYxh8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcVfiJhg7xmuoxMZJCJj6NUoXdbNqUVei9aj7VyERCsls0hIxZ3/l1OHGDVT0xs3dfloygZ/GyOw1HTlzNM21/AXinDfp8GhXbLXQsDInuwQVOioPeNJiczD5U2gkE3H5VblIr8FAb2Vzmnpbzp8bu7SqLRGFAzb+vEXUdx0qgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ej67GMLX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ej67GMLX"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so91086501fa.3
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715749781; x=1716354581; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=975B1sVy32LTXzxsALukKLfSACwxUEyol/q8JnyOA4o=;
        b=ej67GMLXY8Y51jLGong7n/KBK7cX/nzd0k4PgoxEeCn69smoXi1dDjTuytEIov8rmm
         AmGUE9ZAqmO87ghfuvA7MHRjLiM9DoNE15HRFapLVka3yaA/EPyQcbwn3neYNB8n838l
         hCu3Al+LNdIDI0G8t7a6OYoe+Nv4DgPwvcDH2lyzA5rEGksUMjVnpwJiaLUDTY6CYCsu
         oGKUVO32NnaisJfn7T2B9Dnt5hityYs6KL8j0QvqLXDLwGHmfBpKg+L8cHJ8OSU44Ogt
         ATLtESK7UB9fCiBZS5bii8h+gEIuPyvhRIOUwJ1mr830E4VcFV4temwpJ3a0ywQoh2SM
         f+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715749781; x=1716354581;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=975B1sVy32LTXzxsALukKLfSACwxUEyol/q8JnyOA4o=;
        b=fkqZeOY2z74NXnaNBTahOS9hoxNvPeCem/4V7MaHfvknqWIkUL+iZLbn7lOcG1F/9k
         mQ4kiR8uklB473EN8HcTg3PIyVwrH67uPmmGAbaaIbtaFsXyUOmYKTZmzw58CtiieOts
         +oxpLTiA8DO8hOyCKuQ+2JbQXMsKbFFf9oOur3ET9SFE/Otf8DU4qkmYOyh5w7gJbpXT
         QZ7wnI13Sit5XCPnZDSwObF/HoV5T5WwSIqpdbi33xeIKp5ztfIyfjH8cXtqrAwaVYq5
         x216Vk1tXWCP8VcTAW4Ig2biWJuaQtRE94RJoCs76Fi+43k+f9Xr1/tmxfeLsGZpNWhc
         TxLA==
X-Gm-Message-State: AOJu0YzMkZ38ZaeM7LgTmUnbnTLODJnXBgwxXxBhRHs+/dKK3mCLeklm
	2SgiU4oVD2jzCOMTVDuuLfr1wPsFCgce55vOKixlWljZnc1nD106huhl9ITpA94=
X-Google-Smtp-Source: AGHT+IGrUkRE45seMgtIIoE9PEoi8QF/KuINpSVm4YfmrAzeH/MZdLnoXwgGuJCSWjOgBpc2tUxYKw==
X-Received: by 2002:a2e:84c9:0:b0:2d9:eb66:6d39 with SMTP id 38308e7fff4ca-2e51ff667d5mr92842571fa.19.1715749781375;
        Tue, 14 May 2024 22:09:41 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a632608sm9175077a12.5.2024.05.14.22.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 22:09:40 -0700 (PDT)
Date: Wed, 15 May 2024 13:09:32 +0800
From: joeyli <jlee@suse.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Chun-Yi Lee <joeyli.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
	Kirill Korotaev <dev@openvz.org>, Nicolai Stange <nstange@suse.com>,
	Pavel Emelianov <xemul@openvz.org>
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
Message-ID: <20240515050932.GG4433@linux-l9pv.suse>
References: <20240514151854.13066-1-jlee@suse.com>
 <e8331545-d261-44af-b500-93b90d77d8b7@web.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8331545-d261-44af-b500-93b90d77d8b7@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Markus,

On Tue, May 14, 2024 at 05:34:57PM +0200, Markus Elfring wrote:
> I suggest to reconsider the version identification in this patch subject
> once more.
> 
> 
> …
> > This patch makes the above functions do …
> 
> Do you stumble still on wording challenges for improved change descriptions
> in your patches?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9#n94
> 
> …
> > ---
> >
> > v2:
> > - Improve patch description
> 
> V3:
> ???
> 
> V4:
> ???
> 
> Would you like to include issue reporters in message recipient lists?
> 
> Regards,
> Markus

I will wait more suggestion for code side and send new version.

Thanks a lot!
Joey Lee 
