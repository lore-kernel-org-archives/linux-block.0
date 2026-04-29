Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3138D6B8
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492424; cv=none; b=eAEtjHpLc+IBHvCbEHbMkfz/rS7v0XIY9XraDCODf3+gkPOcg1NnyCdXee5Hpr95+EIuSo1j0VNN5eCJHCaSd06qYS6DjIGGqkWDZeJpdhhXoRER+gfNXPTauJGeoNzfRFUtnhaEcZKoh0FRcRoBMZEJ7zuDgc3N6n4Tmf93Row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492424; c=relaxed/simple;
	bh=yhml//+cypomlbrv/uqWPycrmq9alyej1kuyt592IyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWuoEHetgtxwHArnoPXzIM7R6BQ6Yah83S0N7uZ316ZqJBlD1f21Qxd8wEVU7+qZooTBvHa6R/FLAOW8ueoWZYAtDm/4P/YiGrHFGbk9hLfz/PCNVtI/RtHSGFQM+quXb1TPF+EK1PDWwfsK9Z3e4YYPdhLWkxiTWoxEnosg7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=wvh1iXr8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="wvh1iXr8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f6092eso107841f8f.2
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1777492421; x=1778097221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAJYmniaHVmD8EEx84YZ+oBBj/pKHMowOmKMeo4UE+Q=;
        b=wvh1iXr8h5Yr0wOkqEK+iiJ/jsfImAyrtV0JNzJFjGzU9Hw38Iqi5ZxBpMaL3rCYwf
         VHSPYB3Fi7xN3xnYEiJw65mb5KSxprnQ6H/ZsB6d+JZnt43vRUq8Hoi9V4/QdNnmlYXd
         bU+6XYAdvKibOOJ3UXDdRlshLHe+vKWV9f6pqIRejWNFDTxuIxpy13oLLnsTOBRycftf
         AW9DQSNtFufaQM4eq9Gc8FWkCN+Q6ep6sidklrnpypsIX9qCcbWu9CqN7TvGCXNhiH1l
         4Toehg/7EHfiMDzcDv7JxpMaf4WRUqUF+QZUW/KTRMFlSUZwB9+fTXT3AR2kcDR2qVIt
         ehdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777492421; x=1778097221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAJYmniaHVmD8EEx84YZ+oBBj/pKHMowOmKMeo4UE+Q=;
        b=gFJ6irAFdxTpwkYHCchs613pqWwGtF1TWzz0dmFWhN8ClAgWbQ1oFalj2U9mGWf8CR
         PO6oYdvi/6wS2Mgei9jjjaTPy789KiLc8Hjq9hDC77IB1D9V8gDK6bD/ibXcFHFT5MqC
         TIi9xQDP40iGMlAlPBjFleHghdEnDJAIKq70quTHKoJi34IHC9uxkQ68mUCdxAbwy86R
         G1Wh5brwf1HlzIZ2TVTZ7Tko1YnRyJBSQSUuO5xEgCWmha98GPYAfiWu8GvvrYLEJim0
         inLiMUG4vLIGrR3ibdIFJNj1Kyax44rg3j3/gOlWvhIdhAHzufwiYAd9NxiJg3HsuBNM
         n1Ng==
X-Gm-Message-State: AOJu0Yw7sq47CFFLUW5RA5HpHVWFvSQHe5yAYv22acVUDK6CpvZDBfe2
	TBdwj/rjU3zPmwL9hrVd7xWcYHhuQ7EPhAEaiCeMaynR69TfZbE6JM7My5S57whMrZU=
X-Gm-Gg: AeBDies7Cbm2n6Qx/TZOxxf1Da6oK2NgyBnMnmopwWhHHaZhFt83U9L91tiihcHKuRe
	q4/NdeXjnAbxFhmlhK6YAxJjlM3mswXRwekKbQAV6QyaVzJyq+/xc4l+Ylu1gmACRGhBCx3e/Gr
	/QAr7cDVYgnVid/rsMEl8xlxIBIm4QX/MTxU4e14SzL83mGmYFubhZY0dDFgUtBhgSwEKwBj4x/
	Dcv9egiKy2DKxlBSXYZZPL9qqo1jv0KOqZ0Z6x1CYnJF4dIR7VGVgWmDVtATF6OOH6ux3OrAOfa
	kaXNb84+BnoWF8bNy9C1BdFSL4PKMfC3ojfdk9Jks7saNBRQfwU2Kg+VSJwQTRcqZncXsQiFcG5
	L9EGbdMD7ph/e8KDM+cRQGQpOmmQlplJD4CaH5Q5pEgUvYA2G0lCtfoUGYdeIBubriZXpsvs5o3
	1PYiAipi7Sjta+hEAPYr+sbPO2XfR3jMloZThOZ8InJ5C66JhlCJ4tWACJNN/ac0uizDxvr8tQw
	QBMw+K/GvgEsHc7oe4oL1K4Q+YDLd4=
X-Received: by 2002:a05:6000:1885:b0:43d:733f:aee6 with SMTP id ffacd0b85a97d-44648f28f69mr15494826f8f.10.1777492420313;
        Wed, 29 Apr 2026 12:53:40 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca67aesm7315936f8f.33.2026.04.29.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:53:39 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:53:38 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, daan@amutable.com
Subject: Re: [PATCH 1/1] cdrom, scsi: sr: propagate read-only status to block
 layer via set_disk_ro()
Message-ID: <afJhwgTJF-Kqz93h@equinox>
References: <20260427210139.1400-1-phil@philpotter.co.uk>
 <20260427210139.1400-2-phil@philpotter.co.uk>
 <8816ec1a-a4cb-4c68-a99a-79e9d59cc288@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8816ec1a-a4cb-4c68-a99a-79e9d59cc288@kernel.dk>

On Mon, Apr 27, 2026 at 03:52:12PM -0600, Jens Axboe wrote:
> On 4/27/26 3:01 PM, Phillip Potter wrote:
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
> > Link: https://lore.kernel.org/all/20260422113206.246267-1-daan@amutable.com
> > Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
> > Link: https://lore.kernel.org/all/ae59luYMh6npxD09@equinox
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Link: https://lore.kernel.org/all/yq1jytti447.fsf@ca-mkp.ca.oracle.com
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> A few notes:
> 
> - Please don't include a ton of Link tags in the commit message. Don't
>   add anything unless it's a link to a bug report, and your patch fixes
>   that bug.
> 
> - Signed-off-by implies Reviewed-by, you don't need both of those.
> 
> -- 
> Jens Axboe

Sorry about that, didn't realise it was bad as I've done it that way
previously without issue. Will make sure not to do it again :-)

Thanks for taking Daan's patch.

Regards,
Phil
