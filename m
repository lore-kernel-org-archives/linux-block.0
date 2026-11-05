Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909914;
	b=FELCP41AUSpLoVGLvbY6U76ifA3CIVeYm8r6lNiLIqKZxDPKMV+zgCO2M9zuI5Z0yK7x
	 FwLExAPYgkkYIJjzwJSEKSw4XYJYWIrQ2vmim8g0j6h+xMJLwVWlsPmXnvoIpEMyfhetb
	 eNLQ/HTYs1J/UyJubZoKEdkL3WXiNUAps1Tpbv6ta+t4ROxZld/OfXOhIXiLaQyBKR9o3
	 2rfDmS4yKvu7eVdiskaaHQarXHC93oVYss8jDZQg2qYzrt6rQ41esXBOL6+PxOgRm8meK
	 BxZercz5UHz0f1sfjsS5ccyNuseUrDHzJe46BMUA7uBpkOggUfa1Hz931np3IbFqV6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ou4/lAhEpFwwKVnn/O173URP+OPA9Dr5LXSyF2aM0Kk=;
	b=kv2dFbrJaYpqK4PrX11hDPwnKqZCQaZUA5VmQEO0Fph4K9QLXULNow/4qKEHZSac6fPm
	 Aghun2QF0+txZf6RAbZSe+qHI1h0tbDwSYKqj6iaxGE9dHH5NP812r0KbfqMXCwFaU4ql
	 YbmOpqaWwe3yJq1Csfc74WNyb+wW8lOHamkLzYjERKlj05ckbU5WLlBHQY1J1A0bS1Rhn
	 UonGVzLlLf0fQsgpYTHa3Z3AmCmBa5NXNyV2eZ3Hh0uC8ALw8NfzEMaxYv7dVBRvnSS9N
	 pdcwi+ggxyEz+dXmJz41NstGwdazfjKO4Ae+otkXMgoJ3I4ggEipYoMS1rxFMbMufDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fY92HljY;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090AF606A331
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 20:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 090AF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fY92HljY
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso473246f8f.2
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2026 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793909911; x=1794514711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ou4/lAhEpFwwKVnn/O173URP+OPA9Dr5LXSyF2aM0Kk=;
        b=fY92HljYm7SUL/irbYBIukak8YUb3C47lQ24TCLgGG5fynimxwPMQM+lYLIvhRAsPn
         qeUUtYqIRjEY35BnZd3pdA7+2EWRL0YEmPLA5UQch4Pmsy+TjNMBcr3MTzWON96WdVQW
         oL4VhqsBcv52vQnJuepnrDyVRTGTF3q+i9khUTk18gQQlez/vXzTpXcx+azvPnzpGGEt
         Pu6zHj0bebmvcJ6HDvrCNcnCbekezGsG0wMHx9JJ2rRXOwP5gRcGtCiKlDVRkmpycaAD
         uSyxZVf1n0IK3GC0YVK8+h9Ma5JBOF0GGkZPL5elj6Rn5CwQSU1cy/+Q5oCHg3VB1E0a
         fh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909911; x=1794514711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ou4/lAhEpFwwKVnn/O173URP+OPA9Dr5LXSyF2aM0Kk=;
        b=oBBJYq7CFFThb4iExIOn+wnIMH1tlXtKI+ThTylK+bh6WxX15Cdk30OtTuPnOJL4/U
         7ihycr2Jl4mlKE9hrTAEcm5El2oEWlVq2RrqOAJpqeCqpoAgVzk7xrEZ9bWK/HDtrExP
         Jr9+GsDEbp8gppwHFnXAI8CzDtkzwrVCn8JprHppET2357ylTNJzbVDayDEka9HIapMO
         ZTV9z+7xBYlsMc5fOKr5ybkCtLiY8lJhADjNrdIvGrQ6HZCFncWquQMBppmanYkCwHMx
         uMupmdwF+gbN0yzXhHGpEcLcgztkDZFXENujKZheA7YviZXqLGQIPsR/lWkl3iN90i3f
         CizA==
X-Forwarded-Encrypted: i=1; AKwUvBwzRikS2X7pmGnNXeCtkufVRSBp5VlPbBoGlOxq/Rap3d442+i1XOce6UcGo9PTFWNBSpSH6QnyOX6TUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9JyjaWOu4oNCJbSNA0yw+m1/ZvseYXtSMOK1PlhfO7MEKym1cH
	erJ6sNBQHTFriOH4dQjrxO5hBIrBeHUX/YCG8lTEAONCaUZ2jAyO2N8MUwHYacB8e0Y=
X-Gm-Gg: AYBFou055XjFeUJueFO90bb2rKqgTXfd8ktCJgmh7Evt+AXeVYUCKXZ8OY6PYdg0kL1
	ipc/CI4c39n6eTKbJjYfwm0EPybL1gsxYFXnBp+YkTbZsbDZrdGehSED+EwHmGpEYp/SLFORUEU
	ZIiZkFClXUDuE11LuVOVRjWlas+tntGyLVpZRUF6Ju1SAYNz7q4UpFzQzfnStArA9tIs3iJwh22
	/CIfr0NbNpPaVq0e1S+HGqB4KwcCwMU04tGxOm8wOMRICkDu5z6MpQ7Hhfr0z3cvCU6/GXdhtzG
	8hJjFDNY3LTtXfo12cf7nPfbS3eMOEDfkd4BSX6SfdrEFAlC3V2h8HueSP4aChNvHFOXGX2/49v
	MOWIFZe9MzYCrlW2ghEIkUBK7/7/N8KQR6wEBLIpArjm0Zfa7XhgM5kPI1+nDqFP+k90pCuoSB4
	QIFK+3SwGjI/nch2V5je33HPwDHlYIZkV9m2zfzKNC26SVFRfQ5YoW9G95zfC1+TCWt2r45sPki
	Bl4vgT8JbTmgmckTMIhkvG7UGYYVt6ETmH2mtYgI1O+Z2UUom1KargeY4oly6qglbHL5n/CbApp
	aLhLGloChfkB6BgbS5N+15NnmRz/8mm4GAgA/IohycfmtzBS
X-Received: by 2002:a05:6000:1788:b0:491:ed89:a38f with SMTP id ffacd0b85a97d-49276977d36mr1397300f8f.23.1793909911128;
        Thu, 05 Nov 2026 12:18:31 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fece99a5dsm11653632f8f.21.2026.11.05.12.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:18:30 -0800 (PST)
Date: Thu, 5 Nov 2026 12:18:27 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Haris Iqbal <haris.iqbal@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v3 for-next 1/3] block: Reject unknown status tags in error
 injection rules
Message-ID: <20261105201827.GB2439-mkhalfella@purestorage.com>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
 <20260928221634.43239-2-haris.iqbal@linux.dev>
 <20261005084917.GA9160@lst.de>
 <20261020223402.GA1582237-mkhalfella@purestorage.com>
 <58a98f7d-b2c5-47b5-a372-0ab5afa6a8ed@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a98f7d-b2c5-47b5-a372-0ab5afa6a8ed@linux.dev>

On Thu 2026-11-05 21:00:27 +0100, Haris Iqbal wrote:
> 
> 
> On 10/21/26 00:34, Mohamed Khalfella wrote:
> > On Mon 2026-10-05 10:49:17 +0200, Christoph Hellwig wrote:
> >> On Tue, Sep 29, 2026 at 12:16:32AM +0200, Md Haris Iqbal wrote:
> >>> tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
> >>> tag it does not recognize, so a caller cannot tell the two apart. The
> >>> block error injection code (which is the sole user of this function
> >>> currently) relies on error_inject_add() later to reject adding a rule with
> >>> status=BLK_STS_OK. This is okay for the current state of error injection.
> >>>
> >>> The delay option added in the next commit makes the rule with status=OK
> >>> valid, meaning the function tag_to_blk_status() now needs to explicitly
> >>> match BLK_STS_OK for it, and fail for a tag it does not recognize. Hence
> >>> make tag_to_blk_status() take a second param to update the matched status,
> >>> and return true in case of a successful match. If a match is not found,
> >>> the function tag_to_blk_status() returns false and *status remains
> >>> unchanged.
> >>>
> >>> A repeated status= where an invalid tag comes first is now rejected
> >>> instead of being overridden by the later one.
> >>>
> >>> Cc: Christoph Hellwig <hch@lst.de>
> >>> Assisted-by: Claude:claude-opus-5
> >>> Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
> >>> ---
> >>>   block/blk-core.c        | 14 ++++++--------
> >>>   block/blk.h             |  2 +-
> >>>   block/error-injection.c |  7 ++++---
> >>>   3 files changed, 11 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>> index 13dc70e8f55d..c45846b9c50d 100644
> >>> --- a/block/blk-core.c
> >>> +++ b/block/blk-core.c
> >>> @@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
> >>>   	return blk_errors[idx].tag;
> >>>   }
> >>>   
> >>> -blk_status_t tag_to_blk_status(const char *tag)
> >>> +bool tag_to_blk_status(const char *tag, blk_status_t *status)
> >>>   {
> >>>   	int i;
> >>>   
> >>>   	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
> >>>   		if (blk_errors[i].tag &&
> >>> -		    !strcmp(blk_errors[i].tag, tag))
> >>> -			return (__force blk_status_t)i;
> >>> +		    !strcmp(blk_errors[i].tag, tag)) {
> >>> +			*status = (__force blk_status_t)i;
> >>> +			return true;
> >>> +		}
> >>>   	}
> >>>   
> >>> -	/*
> >>> -	 * Return BLK_STS_OK for mismatches as this function is intended to
> >>> -	 * parse error status values.
> >>> -	 */
> >>> -	return BLK_STS_OK;
> >>> +	return false;
> >>>   }
> >>>   
> >>>   /**
> >>> diff --git a/block/blk.h b/block/blk.h
> >>> index 2cc03aa54c53..5fa54162c686 100644
> >>> --- a/block/blk.h
> >>> +++ b/block/blk.h
> >>> @@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
> >>>   
> >>>   const char *blk_status_to_str(blk_status_t status);
> >>>   const char *blk_status_to_tag(blk_status_t status);
> >>> -blk_status_t tag_to_blk_status(const char *tag);
> >>> +bool tag_to_blk_status(const char *tag, blk_status_t *status);
> >>>   enum req_op str_to_blk_op(const char *op);
> >>>   
> >>>   bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
> >>> diff --git a/block/error-injection.c b/block/error-injection.c
> >>> index e14bc4b723ef..db543fe27630 100644
> >>> --- a/block/error-injection.c
> >>> +++ b/block/error-injection.c
> >>> @@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
> >>>   static int match_status(substring_t *args, blk_status_t *status)
> >>>   {
> >>>   	const char *tag;
> >>> +	bool found;
> >>>   
> >>>   	tag = match_strdup(args);
> >>>   	if (!tag)
> >>>   		return -ENOMEM;
> >>> -	*status = tag_to_blk_status(tag);
> >>> -	if (!*status)
> >>> +	found = tag_to_blk_status(tag, status);
> >>> +	if (!found)
> >>>   		pr_warn("invalid status '%s'\n", tag);
> >>>   	kfree(tag);
> >>> -	return 0;
> >>> +	return found ? 0 : -EINVAL;
> >>
> >> 	if (!found) {
> >>    		pr_warn("invalid status '%s'\n", tag);
> >> 		return -EINVAL;
> >> 	}
> >> 	return 0;
> 
> As Mohamed mentioned below, "tag" would leak then.
> 
> > 
> > Doing it this way will result in use-after-free. "tag" has already been
> > freed above.
> > 
> > Maybe change tag_to_blk_status() to return an int (0 on success and
> > -EINVAL on failure) and use its return value without mapping it?
> 
> I am not sure I get your suggestion completely. Even if we change the 
> return type of tag_to_blk_status(), we would have to free the "tag" 
> before returning.

Changing tag_to_blk_status() to return an int will not have an effect or
"tag" like you mentioned. But you will not need to map the return from
that function.

return found ? 0 : -EINVAL;

The line above just returns what tag_to_blk_status() returned.

> 
> What can make it simpler is allocating "tag" on stack, and then use 
> match_strlcpy() instead of match_strdup().

That can work too. Just make sure we limit the string size somehow.
