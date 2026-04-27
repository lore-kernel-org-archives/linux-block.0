Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6E364E92
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332089; cv=none; b=anXJs/z56VGaGoCZLo1Pwd1mVrFQYUpOc+AzBQfrBgbOmGUHKHOF026KEd3W/dGB4E5n1keXqLVBrf5bL9ZLL4x+1SbBzRlY3gp3gXJLt42YrLe1d5dD5NrZYjBTg47OCiVxtg2cRD0nWiRcsrfjjwgpXQXqHupajjDqTaIznpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332089; c=relaxed/simple;
	bh=DJghSy1D8zh/PpCR9oWQ3USQY0F+iVWTeMrqRCDL/oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIYOqVO/xxoVBtDKpVAMOQaPSF1Ixa5Mr9ttgejVFwBxjcIzrElQRFxmNwcEfngfZuRlzZ78ywHfNQJtpoiXUTqxPtXwDkdAzZuoKPemnx3lWrNJI60FXZ3rYuOSI+ZoQ+OmXfrFPH2/MxZjVoSj7YvZNGn1af3T7JW0jO2Jl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHWBnTt3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHWBnTt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777332087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwKMBJOAIVpBKk5S/1EncS9MBw/2GYPqM3cR1GQB/UM=;
	b=MHWBnTt3OMtasY/u3qWdszCmGsr0UyXbozeW0txxud0cVrqNr9zY4tdQXWJgFP5sJO36fO
	LDu/0CC6JjATC9IH8XD8czJd6M3HyOeXIAcuguNiwsd+cVje7QtCEM1rCQyex5gwLKtGHX
	p3jEMCR6gNWCeOi2zrpL93PeH+AFaVI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-wwGLtsnHNbiLH6aMO9qNBQ-1; Mon,
 27 Apr 2026 19:21:20 -0400
X-MC-Unique: wwGLtsnHNbiLH6aMO9qNBQ-1
X-Mimecast-MFC-AGG-ID: wwGLtsnHNbiLH6aMO9qNBQ_1777332079
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FCC018004A9;
	Mon, 27 Apr 2026 23:21:18 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB76F1800446;
	Mon, 27 Apr 2026 23:21:17 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 63RNLGLG2738638
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 19:21:16 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 63RNLDEl2738637;
	Mon, 27 Apr 2026 19:21:13 -0400
Date: Mon, 27 Apr 2026 19:21:13 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org, mpatocka@redhat.com,
        gmazyland@gmail.com, linux-kernel@vger.kernel.org,
        adrianvovk@gmail.com, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, israelr@nvidia.com, hch@infradead.org,
        axboe@kernel.dk
Subject: Re: [PATCH v2 2/3] dm-inlinecrypt: add target for inline block
 device encryption
Message-ID: <ae_vacHQ75AgZbm_@redhat.com>
References: <20260410134031.2880675-1-linlin.zhang@oss.qualcomm.com>
 <20260410134031.2880675-3-linlin.zhang@oss.qualcomm.com>
 <ae7yzw-5wz9cqZt8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7yzw-5wz9cqZt8@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 27, 2026 at 01:23:27AM -0400, Benjamin Marzinski wrote:
> On Fri, Apr 10, 2026 at 06:40:30AM -0700, Linlin Zhang wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > +	/*
> > +	 * Since we've added an encryption context to the bio and
> > +	 * blk-crypto-fallback may be needed to process it, it's necessary to
> > +	 * use the fallback-aware bio submission code rather than
> > +	 * unconditionally returning DM_MAPIO_REMAPPED.
> > +	 *
> > +	 * To get the correct accounting for a dm target in the case where
> > +	 * __blk_crypto_submit_bio() doesn't take ownership of the bio (returns
> > +	 * true), call __blk_crypto_submit_bio() directly and return
> > +	 * DM_MAPIO_REMAPPED in that case, rather than relying on
> > +	 * blk_crypto_submit_bio() which calls submit_bio() in that case.
> > +	 */
> > +	if (__blk_crypto_submit_bio(bio))
> 
> This will still double account for fallback writes (which call
> submit_bio() on the encrypted bios, and return DM_MAPIO_SUBMITTED here). 

Just to clarify, I'm talking about the vmstats accounting. The IO
originally gets accounted by submit_bio() when the bio is submitted to
the dm device. For actual inline encryption and fallback reads, dm will
submit the bio to the underlying device using submit_bio_noacct() to
avoid double-counting the IO.

For fallback writes, __blk_crypto_submit_bio() will submit the encrypted
bios to the underlying device with submit_bio(). This adds the IO
sectors again, even though it's the same IO, only encrypted now.

-Ben

> 
> -Ben
> 
> > +		return DM_MAPIO_REMAPPED;
> > +	return DM_MAPIO_SUBMITTED;
> > +}
> 

