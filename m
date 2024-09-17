Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C800D2FA
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726532974; cv=none; b=FJyrK/YnZDiQ13Xl3QbNBluuM/c7ctjWeq1Qw5OTdslilp6PoJ56+6pi8CKBHFr1nmRNfnzvBtkxVkn7z5iI04T79lND6UMnPj3gRj6B7rF8gBv3E6cSjJcuFWxE02Z5uaFyGSD2XXPDVQdRDUZlEWsz69pDg/2lH0ZJVAy8XAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726532974; c=relaxed/simple;
	bh=rZIUKdtXXUM4RQe9UE2317DuHDXoWVgSJvrTbGs76Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIm1W0Dgm7BSg3ULDphtjh2zuOrUKrfaDIVdUA6zD+sV90CMxuSsgtv8lKQgPRBbcjTL4DgJOCxxFXMoZ6QTBTbaySwidNPSmWAJMpzYb07ujU+V3preTQGqPdqBIyKtE9q30BfFEb9H52+moB4FXBa2pw7rKW9UhRAYQFva6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fQqgbBhW; arc=none smtp.client-ip=209.85.221.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fQqgbBhW"
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-374ca65cafdso2571874f8f.2
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2024 17:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726532969; x=1727137769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UBk1QL4XfAb1rDUpGsJYWltghMq0wmKGOdrJxnMzsVs=;
        b=fQqgbBhWnxcG9dTT+T79oj4nin20DOIXpN9Z2DBfC8u0L4NjkKUCTl5pQOvu0e9rJK
         phb9ilLnFeymc5E5zGtcM7O2acp9eRKE7I1k5GXz/v6zjmR/wlncarCpVSf8kTLqjV1M
         GWTp38RlbufUBodL7Li4/4yo2YqsnhPb1xI031qI56XPQ2JMsG/gbNjDEL5E3QsbxUPl
         O8nOCZqllEMyM4uzWK+dZnxTVLZ0dDHuZg91qaDi1NFwb7RswH0kJl+Vn2TzqG8ieiul
         V7HBNg+aW/25GH0esHWHaU51wDvIrDusdGhyi1Ot7LaelfjFukTFn16fpuKXnM9Fl5fL
         Oc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726532969; x=1727137769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBk1QL4XfAb1rDUpGsJYWltghMq0wmKGOdrJxnMzsVs=;
        b=O3MLcF8+T8pdINrBYWRm8UgeuLipr9D8hldraow43xckO0w4J0bhSTdGoxBWpmd3Gz
         r1puB0J9uhuNQVe7RziHM6oW/67ev/1OUKHQZm441oZ0+o0U28aA4s2dP0NbDVC0V7zh
         0N4AWbzWjG03K4InjJJ62BH7NcZDtDVB6ZcLpxcMSsy3FCVEVsWR39lZr7LbKNyOjVYe
         8Ux7pdwaRIlOGVnMNAIrg4H/g5kBpFLVk7mQOBSdkJTCgCOQWuHRztzCPCtwt3EAZ+3o
         2Zv963qKpvB+aKVt8Vq3xwgNYtplHJanZFVK//3sOjQdhihiBu0DKuA+PKHGAdwBz6TE
         PNng==
X-Forwarded-Encrypted: i=1; AJvYcCXTkSgc5zhfrq3JvaHrpFDRXbToc1tTX5qQRnQN5aFMl9A8I18rZ5QxQy3tiLukIKLVzGPUijbSGJrKww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxl4DxE+KPwipUeoUYkJWSburEO8N9dqjwu/yhFjFX5Gfw6Vql
	7R0NlTP/cJig33kpgp8YZO0NXKo/DjPahNl3POWUlIAD7RrJFZ5/uOZpWCv2LpcSrSqXRR98wEY
	1Pi8ucVQby5c0dkihn04Sj+W+1iOfUq0Jy9IIuturp3CIuHp0
X-Google-Smtp-Source: AGHT+IGCHp7sPpA2rRLpq2htJDHQMIzbQ5S0/AN0RDtBfo+EK/iBFDJEC3SRdA/EJn7BIyC8h9M9vA8mlI+Y
X-Received: by 2002:adf:e3ca:0:b0:374:c847:859 with SMTP id ffacd0b85a97d-378d6253a74mr6261244f8f.54.1726532969085;
        Mon, 16 Sep 2024 17:29:29 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-378e75f1d06sm271416f8f.53.2024.09.16.17.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:29:29 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DA44734028F;
	Mon, 16 Sep 2024 18:29:27 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C8F6DE40E56; Mon, 16 Sep 2024 18:29:27 -0600 (MDT)
Date: Mon, 16 Sep 2024 18:29:27 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: support device recovery without I/O queueing
Message-ID: <ZujNZ8FxtK2hqKQx@dev-ushankar.dev.purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
 <20240617194451.435445-5-ushankar@purestorage.com>
 <ZoQEmCuPIq0thaON@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoQEmCuPIq0thaON@fedora>

On Tue, Jul 02, 2024 at 09:46:00PM +0800, Ming Lei wrote:
> I'd suggest to add one per-ublk-queue flag for this purpose instead of
> device state, then fetching device can be avoided in fast io path, please see
> similar example of `->force_abort`.

Done in v2.

> >  	/* fill iod to slot in io cmd buffer */
> >  	res = ublk_setup_iod(ubq, rq);
> >  	if (unlikely(res != BLK_STS_OK))
> > @@ -1602,7 +1616,15 @@ static void ublk_nosrv_work(struct work_struct *work)
> >  	mutex_lock(&ub->mutex);
> >  	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> >  		goto unlock;
> > -	__ublk_quiesce_dev(ub);
> > +
> > +	if (ublk_nosrv_should_queue_io(ub)) {
> 
> Here ublk_nosrv_should_queue_io() doesn't cover UBLK_F_USER_RECOVERY_REISSUE.

Not sure what you mean here. I don't see an issue, can you explain?

> 
> > +		__ublk_quiesce_dev(ub);
> > +	} else {
> > +		blk_mq_quiesce_queue(ub->ub_disk->queue);
> > +		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> > +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> > +	}
> 
> If the above extra device state is saved, the whole change can be simplified,
> and __ublk_quiesce_dev() still can be called for
> UBLK_F_USER_RECOVERY_NOQUEUE, and UBLK_S_DEV_QUIESCED can cover this new flag,
> meantime setting one per-ublk-queue flag, such as, ->fail_io_in_recovery.

I don't think it's a good idea to have the state UBLK_S_DEV_QUIESCED
cover the new flag. Then we will have a case where the state is
UBLK_S_DEV_QUIESCED but the queue is not actually quiesced... that just
seems confusing. I added a per-queue flag and used it in the fast path,
but kept the new state as well.

> > +/*
> > + * - Block devices are recoverable if ublk server exits and restarts
> > + * - Outstanding I/O when ublk server exits is met with errors
> > + * - I/O issued while there is no ublk server is met with errors
> > + */
> > +#define UBLK_F_USER_RECOVERY_NOQUEUE (1ULL << 9)
> 
> Maybe UBLK_F_USER_RECOVERY_FAIL_IO is more readable?

Sure, changed the name.

