Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535646;
	b=i1kqmftUx3GmT7f6qDnhGl8VhOdVMzp8SnmYG0x8HwRO/r/6LKLc7rUdO04MJzWoy1Ys
	 FyD9WN7TTu8o8OhFfDSujBt9Hfh9sY5pMOGA2ysXvt57rLGb4cgrN04OnAuWtQOPCKzoc
	 0THewWk2DSfrwsynhSJztKpj5v+SHIYnxEVtCjsC0ZhastYdMADILf7lz/zrtlUAz+AM5
	 KJN6dRKuBThNL9Klobv8ZnkgcmktLLwcBdid/opbh1XqwkaV/QnbDnez+Ry+F+oXhO/3k
	 auvHzGYY0N3y7Pm398P3Fq1Hqm91Q3QKM8hQzW5rfivlFmh1JxWhmBYo8Ng/s74Zbcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ilMa8acf5SBfyXhzvTTwFhD4qHERM2c6bWjfpOKNnKM=;
	b=jiZEYGqBhhN+G/BuO0XeJK9WWzt86rbJJsUCY+59DZD46GT0zne3r11dp9BhEKCfNbFq
	 RTvmu/Ymj6fpICcOsIZclejZv3GXkcaOz0YT+J+tQdn/k/vBscbU1/sYcpl2c/dHB5TtV
	 3hB8b6Tzk1W8rTFeu28My2rtkIyqcZL3y5hDWKTkr0HxMohq7yLq0uQvl7oyJWakWa3aM
	 5R+yyF8xXWkDaqZLe0g8xBqH/QFYqs9lMSP/YA7Mph7uiR8DHRzmrzuYVQm9PXJeLuRn2
	 dxl2rBvgJEBZTGiZ8XOtJKQ4D4mlla2UrJd9lWdg8r9Df4zLZC37Vbt2zoqcj/HpvIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=JhwIrbiY;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FA606A31D
	for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 22:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C1FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=JhwIrbiY
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso269821eec.0
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792535645; x=1793140445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ilMa8acf5SBfyXhzvTTwFhD4qHERM2c6bWjfpOKNnKM=;
        b=JhwIrbiYKPGN2Ykgg0lcaNWCleSw7MEOkrRv8LgY4lACcpNAlXMkXg4p0rSgr6euDg
         8gOvbJLePnMweBlan9tyks0vRy0kZdy3yWVn3vJmYebk7fWy4pXllPc1JbjGJaIYoKaW
         bhMEK3WptB5fjWzu+1u1V9hxCxqW+LIamsfJFeWTfTJEK5+bA9uPeSJGEz1l84DTkdw0
         I9PO4AW5vycneePGJlhYDaZ9D4azGtaapG2v4HRgUwr0ie1CiQmkXPBrYliEC/58Enob
         w3bVnxXkNhrKpkNJ48usNwKHjcZrZ7KJk3z9R/2sa+Tu1TobalEAjnaerKJC5rxNuV2P
         WCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535645; x=1793140445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilMa8acf5SBfyXhzvTTwFhD4qHERM2c6bWjfpOKNnKM=;
        b=nRkFOWgSnnkeSN34C4ai7p14KkYsPDYjwh3ZSI4y50cQNv8Py2OeJrH/8lJvtc3miQ
         VHHhYtdoSXXx81TsfnKEX37pjsmYgCeXnludKS2QK8dQtSbx46LdDQyqUFURcomvQ3wL
         6khI3GPMnmPa00LBE3rWgEuKtuNI3HkqhzdruJTPfiQn0hRdCIn5LQDgVROXxve2ogX7
         uQTKPjUCpk7zsJHtet8VskD1sGXrMuqq0dlyfShBfIa28HaV9MIB+YOIct87gSEKuzWc
         UHXhKSyCTjPROvXWxSuLeSf+pP3EO/zQOF+eQgTQFLSNUS2bl11ADveRruvTfQEw5PI9
         lI3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwE+NXdJgM+XYyfYc/rh0vwrHGQauHiUCq96dOY4z/ENp4D3ooQm9oSU/vIjkh1xG7r5MrUIyPA0z6LBQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIwxKmDdBwPnsSVPY7vtQ6JvGRH3BcG505j1SpAY9uURy5yGfP5
	UxtUpdePBuRdBh1RNXqdzFHjQtjQXtZ6YXCHDJxuEYBzgJ7Tpb53tmWZbCX9rY7vZic=
X-Gm-Gg: AYBFou1/2WtrnGAFkaImtYHlBwmS0QvHuDba+QOiIfSgXOcAmaipMGeY8hxY/yD2bVV
	YeTwoPX6HgfGBSbwmEI4/SkDYgmN/Qyc/mawiI3A/TpDeZ+6ACwGFyA8AnMX9aqZddLX2bHGkBR
	qlgc2w9YBXBhoHReVz7XPhWkk7r9IvhTgMV1eY7kOnsQAvD073mA0fpxoGfb9NvVtE3ON3EY9gD
	Q4eRd2T3aVMH7o6xQIP52xMKKzzPjd8K2ATmkF4Y8Cvvovoya1vC/VLbpchogOm3Gk2fJ8juZnW
	RCKO/YNkk3I6L/JAeJSipxfOexMrSx6Sg6j2ibGuEL9+1HufmjiJ/b/g6wJIkGom19Dp69+N6ny
	1fYAdbANc8Dn9bw2gC8tFwWnpROLqXnAv/Y4drg0ZhqIPGHUFKrGm3vcSgHHfje0Sis1KqfbCbE
	FF2Om5/CKJH5h84RSYwnogy/0K5eFiTs0A8lO22tsxIPS1Egelg1BgNK6MufZ3qXbSQyzQhPVDa
	3tnXjyyNmhfEiOMnkbsAgkT2I3//w==
X-Received: by 2002:a05:7300:106:b0:365:f73b:510b with SMTP id 5a478bee46e88-3674e450faemr875743eec.13.1792535644539;
        Tue, 20 Oct 2026 15:34:04 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3674206d1f1sm1519517eec.28.2026.10.20.15.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:34:03 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:34:02 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Md Haris Iqbal <haris.iqbal@linux.dev>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [v3 for-next 1/3] block: Reject unknown status tags in error
 injection rules
Message-ID: <20261020223402.GA1582237-mkhalfella@purestorage.com>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
 <20260928221634.43239-2-haris.iqbal@linux.dev>
 <20261005084917.GA9160@lst.de>
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
In-Reply-To: <20261005084917.GA9160@lst.de>

On Mon 2026-10-05 10:49:17 +0200, Christoph Hellwig wrote:
> On Tue, Sep 29, 2026 at 12:16:32AM +0200, Md Haris Iqbal wrote:
> > tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
> > tag it does not recognize, so a caller cannot tell the two apart. The
> > block error injection code (which is the sole user of this function
> > currently) relies on error_inject_add() later to reject adding a rule with
> > status=BLK_STS_OK. This is okay for the current state of error injection.
> > 
> > The delay option added in the next commit makes the rule with status=OK
> > valid, meaning the function tag_to_blk_status() now needs to explicitly
> > match BLK_STS_OK for it, and fail for a tag it does not recognize. Hence
> > make tag_to_blk_status() take a second param to update the matched status,
> > and return true in case of a successful match. If a match is not found,
> > the function tag_to_blk_status() returns false and *status remains
> > unchanged.
> > 
> > A repeated status= where an invalid tag comes first is now rejected
> > instead of being overridden by the later one.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
> > ---
> >  block/blk-core.c        | 14 ++++++--------
> >  block/blk.h             |  2 +-
> >  block/error-injection.c |  7 ++++---
> >  3 files changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 13dc70e8f55d..c45846b9c50d 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
> >  	return blk_errors[idx].tag;
> >  }
> >  
> > -blk_status_t tag_to_blk_status(const char *tag)
> > +bool tag_to_blk_status(const char *tag, blk_status_t *status)
> >  {
> >  	int i;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
> >  		if (blk_errors[i].tag &&
> > -		    !strcmp(blk_errors[i].tag, tag))
> > -			return (__force blk_status_t)i;
> > +		    !strcmp(blk_errors[i].tag, tag)) {
> > +			*status = (__force blk_status_t)i;
> > +			return true;
> > +		}
> >  	}
> >  
> > -	/*
> > -	 * Return BLK_STS_OK for mismatches as this function is intended to
> > -	 * parse error status values.
> > -	 */
> > -	return BLK_STS_OK;
> > +	return false;
> >  }
> >  
> >  /**
> > diff --git a/block/blk.h b/block/blk.h
> > index 2cc03aa54c53..5fa54162c686 100644
> > --- a/block/blk.h
> > +++ b/block/blk.h
> > @@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
> >  
> >  const char *blk_status_to_str(blk_status_t status);
> >  const char *blk_status_to_tag(blk_status_t status);
> > -blk_status_t tag_to_blk_status(const char *tag);
> > +bool tag_to_blk_status(const char *tag, blk_status_t *status);
> >  enum req_op str_to_blk_op(const char *op);
> >  
> >  bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
> > diff --git a/block/error-injection.c b/block/error-injection.c
> > index e14bc4b723ef..db543fe27630 100644
> > --- a/block/error-injection.c
> > +++ b/block/error-injection.c
> > @@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
> >  static int match_status(substring_t *args, blk_status_t *status)
> >  {
> >  	const char *tag;
> > +	bool found;
> >  
> >  	tag = match_strdup(args);
> >  	if (!tag)
> >  		return -ENOMEM;
> > -	*status = tag_to_blk_status(tag);
> > -	if (!*status)
> > +	found = tag_to_blk_status(tag, status);
> > +	if (!found)
> >  		pr_warn("invalid status '%s'\n", tag);
> >  	kfree(tag);
> > -	return 0;
> > +	return found ? 0 : -EINVAL;
> 
> 	if (!found) {
>   		pr_warn("invalid status '%s'\n", tag);
> 		return -EINVAL;
> 	}
> 	return 0;

Doing it this way will result in use-after-free. "tag" has already been
freed above.

Maybe change tag_to_blk_status() to return an int (0 on success and
-EINVAL on failure) and use its return value without mapping it?

> 
> to keep the code a bit more readable.
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
