Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFA2F0E49
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659061; cv=none; b=Mi53pZO2BTdCzjr1b3fGtLGABe1UFPj8yNKN8cUVJObbEFXjxhSfpQqzel62R63iG1TeJZuFbkSug4QhOPxtrGXI06nY2agUmVkOijm4ga55VPSOlc3BitvB1L1hhqxPaJG41adeonnf+XZqP82wQ8NLqUVuBzxrjcOiOYS8GDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659061; c=relaxed/simple;
	bh=NudOtJaHKfwpKRxiG+P4sUEmDYIZSqhwxiYyu/1rXRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3og+imw13cuTLYdoaEsWm8hXsUpEvzmLlYAhR/83/TU26CEWz1+pyfO/2WHkpejdvQ0qcYIyR9nAHWExVRzUbrbjoE8Qaai66oTXn2MLB7lxJIaGfDVolx+sE0LrGHJATwbkE2njxHhxnAcLqyNwFt7LVsIQwhyHaA8jrJzT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LsdgkQZi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LsdgkQZi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23aeac7d77aso50085915ad.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752659058; x=1753263858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/MRaoTHxwRJvwPm3IFe8X5kWdiLlCM66v6ozoa84TI=;
        b=LsdgkQZimnPCSV9ePms7DYbGzY/kVxKqgBXvWkt+wBHhP1EnhDRVBGK72tyq7liwvT
         c+jW8GqpRoA9aB5jOvqxw2UmV7iK9GhGRij/vvGF6jzgPzF3RmABTI+ntvQVHXOkclco
         F/HCi9N1gWc+k5dfgX0yNN3VDbCwmL6vg4cXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659058; x=1753263858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/MRaoTHxwRJvwPm3IFe8X5kWdiLlCM66v6ozoa84TI=;
        b=FHA2T0ANpMT1hFmN7zT3Jw6Dfjpn9Yq1S5RUvtSMbx6oiOHyerGyIfFPRotms1HGvD
         VB0TfIynIBtE1rFt9BIkIwqFI/R2JGeomYS8tMc1I1D068tqa5yALeqyErAWwBvNXVfY
         gufbmf3KfZFXDXWywPCKETyEqu4nsdUx1SNRPQI9t9Km4luo9t7MN3wsj6SqkbHg5Nag
         CmDp/bRnqcikvyHjBUc9LajUhytKZa5xFtRlsiRjfEqbxixee0rzYByp4xGCw52Z5/gd
         jC7MWhrkgTQSGpUVPvag2TujqK/U1WQ2NSECKjY4CHJGhjtWygrEaOnb6zqEi5zCY2LW
         mgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU52aqMU5tymTPg2GjZ0FJAMwX/ZXTU7lwGSrCRk+9gkvNhAtRpErdoaIMIkZEKzh5vv+M7gm0bZDrDZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3Fr06g/cn8JwxqVfXZuqQTal+DxI6o2SOK+LGdCMxd8iSOSr
	Xcwbakm5tyyahd46mRsRI8NT+xbcNGXPOmqpBMvH6WQTW0JQz2jPw6I6CbGDNnwi3w==
X-Gm-Gg: ASbGncvrpx2sqf8x3rJt7aqzopI6+reugOQeCUGRbdmbL0zK3gzMub+l2eSvbKZkePD
	Cq5kOsIS9JCgGV3C+n309tlq2d2ms/UWGngRG/Isi9cp/8nN5NJ28rRLL7Rz/5dmdje9VY3+/yT
	aaCl0AuGYvlfC1GzvNlcFqljIWU9x8XgrbZXSBNjQX6YjGcF9RbQhuBEcrF/w69dA4MtcsBxeWr
	vnc5UPUUGvix3tpR3O0Ikexg5YmFSZt9wwmHAVjCNPdNwNEIvaZGVos6mipIsnV30UEF3j0ESJX
	9NXnLOLKVpTf7jobRfGvvShhoXCexlavNm8ZZi+yOkUW1MlCjMvA7aXWO3Xlq35w0N25MaveERn
	dM/dAYqdYGMgSjs/rI64fUD3h4Q==
X-Google-Smtp-Source: AGHT+IF157mzUMUiSNCvgg8EkSviHMXOPMi99eiUONM56I4rAkB9RYJl0pAuuVoDQbXQVjwMQ3KhVw==
X-Received: by 2002:a17:902:e743:b0:235:e76c:4353 with SMTP id d9443c01a7336-23e25000edfmr30647405ad.51.1752659057890;
        Wed, 16 Jul 2025 02:44:17 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:9ab6:c2f9:ca7e:e672])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1ba62dsm1062298a91.1.2025.07.16.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:44:17 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:44:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Minchan Kim <minchan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 16/17] zram: fix synchronous reads
Message-ID: <sbqfktl3qwfizfg3b5mkmme26ks5xkazeh7y45yoo4bpbr65kb@ya4eepk7jprz>
References: <20230411171459.567614-1-hch@lst.de>
 <20230411171459.567614-17-hch@lst.de>
 <rjq6lrsq2mflcry4vtks7wth63cgpjzngcbjxy65z7ucupin3q@owvyk5befvpt>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjq6lrsq2mflcry4vtks7wth63cgpjzngcbjxy65z7ucupin3q@owvyk5befvpt>

On (25/07/16 17:38), Sergey Senozhatsky wrote:
> Hi Christoph,
> 
> >  static int read_from_bdev(struct zram *zram, struct page *page,
> > -			unsigned long entry, struct bio *parent, bool sync)
> > +			unsigned long entry, struct bio *parent)
> >  {
> >  	atomic64_inc(&zram->stats.bd_reads);
> > -	if (sync) {
> > +	if (!parent) {
> >  		if (WARN_ON_ONCE(!IS_ENABLED(ZRAM_PARTIAL_IO)))
> >  			return -EIO;
> > -		return read_from_bdev_sync(zram, page, entry, parent);
> > +		return read_from_bdev_sync(zram, page, entry);
> >  	}
> >  	read_from_bdev_async(zram, page, entry, parent);
> >  	return 1;
> 
> I was looking at zram's bdev (read from a backing device) today
> and got a bit puzzled by that !parent check in read_from_bdev():
> 
> zram_bio_read(zram, bio)
>   zram_bvec_read(bio)
>     zram_read_page(bio)
>       read_from_bdev(bio) {
>          if (!parent)
>            return read_from_bdev_sync()
>       }
> 
> The thing is, that "parent" is basically "bio" which is passed to
> zram_bio_read(), and it cannot be NULL (zram_bio_read() dereferences
> it multiple times before passing it down the call chain.)  Is sync
> read basically a dead code now?  Am I missing something?

Ah, wait, I think I see it now.
Synchronous reads seem to be only for partial IO:

zram_bvec_read()
  zram_bvec_read_partial()
    zram_read_page(NULL)
      read_from_bdev(NULL)
        read_from_bdev(NULL)
          if (!parent)
            read_from_bdev_sync()
