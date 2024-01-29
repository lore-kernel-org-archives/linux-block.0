Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626615A48C
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566393; cv=none; b=FHHn3Ci9jk3VS6NnWKW1gwa3yvZXH53hAAETodg5AC2NQQ98O/ncbHRTHdgkRhdLmQZ7xlo58xtslsuipqInK7RSOz+S7eJPtLVP75PnHIoeQb+KoRAT0+RXN1hRg91kyGkZwp9C6/OTYm0E4Rtr7RWeRXZhQa5B5m1heIm6XnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566393; c=relaxed/simple;
	bh=GTUP3Yc5YtD8QCTLnsiDuXJsWCaa2BMw/SMR8GnUdyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDJF8AzeASil//qd9fZJnHoAeg1V+1pdcH779ykrr94fl3OCFNZFwMCJRzekEEW9LUnYeUFzmw4wXUDF2c1h6WVxfrwvId8iyYz9IivZ0fVPesY2SHFrWvIg8EGgUZQNwsfh5lurPH1jTYG2p0HoZA5/5/CldwmPWSOJE1Srfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uY2UUhd9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uY2UUhd9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddc268ce2bso1814351b3a.0
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706566383; x=1707171183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDLC7xFNAUmo+AcG//FKc/QhXLX+Lm9EeZICYZdweD4=;
        b=uY2UUhd9UENWK2sFas/szyFHRDxKoXurHvTZxJRJwkGvUZK9OURAEQqybg/RxX14PO
         HoGMWtmnyvEf/tAVd4SNhMfMi0qrmzxcUTZ2H4uz8A9GHKWd75YzJWn1PuQ8Xg0TDHNu
         kBllbqT75fMcy/dPCbmAQk9svEpeqzHyrDpYluD8k7DToIgwQW5JJL1/nbAtILC72hp0
         w8bUO1EgEpUujQ+Pe/mu1D3Ub1FnavqdGyhKzthzW6OnNtTb1I8AN3Ci86izdMwjzNpa
         mh9niWehrfq2yOZso1aXz3eCv5ojmGKk1wsEw8F6DEFLRjYjcl1Y/rZiEEsmgKTi7FBg
         WxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566383; x=1707171183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDLC7xFNAUmo+AcG//FKc/QhXLX+Lm9EeZICYZdweD4=;
        b=RLZvbeYm3pueyNx9lJhE59LXISIq/EFI/JGRCmuMeVwoSNZvwtkBDNWnJt8KN2lIBL
         C8YR3a9Yj0MTh8LzCAbsAkBkih+EPdFbqfY6TAFwUa9mqVzW8lb7dna25Kxgpje5qx9n
         KgPqg3/auxCSLp4czWhOw/dmwqh6W2eAeh8MHCXRDZQZ+qXTElp0ctsTbG8vLd4v/yhl
         zJ+IzvBeNofZDhT2WCb/2CU4wY5hfMd3qKsDWxABzlBw7NsDhxlb+mMlR1+44TAOPHDj
         WKL03pDNWMoL6aqV5SW6rVirU+N2X9JSR083ENDxlyMNcaZoTmSBzdHuoX8fKnCJZ0OI
         2fPQ==
X-Gm-Message-State: AOJu0YxcTPkRSkV+aD+fj2lumOIidLN7fxwEqOa6assfRzpnhdAf/I4D
	0bS2Z/Hi9Wq+4jouYPqsDAbErRBD/EbCshi6k2J1Vsm5O6cYTdBa55u7mo1sSrU=
X-Google-Smtp-Source: AGHT+IEWU+bfR0SfQjxm8SanypfzwarXm+Xl99VMrnakbTbW5UlL5xEhkIluA1SfHbGga+NwzjrVCw==
X-Received: by 2002:aa7:868f:0:b0:6d9:aa18:291c with SMTP id d15-20020aa7868f000000b006d9aa18291cmr4247687pfo.8.1706566382805;
        Mon, 29 Jan 2024 14:13:02 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id k28-20020aa7999c000000b006dbac48633bsm6357939pfh.189.2024.01.29.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:13:02 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rUZsB-00H2ym-2S;
	Tue, 30 Jan 2024 09:12:59 +1100
Date: Tue, 30 Jan 2024 09:12:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <Zbgi6wajZlEkWISO@dread.disaster.area>
References: <ZbenbtEXY82N6tHt@casper.infradead.org>
 <Zbc0ZJceZPyt8m7q@dread.disaster.area>
 <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbfeBrKVMaeSwtYm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfeBrKVMaeSwtYm@redhat.com>

On Mon, Jan 29, 2024 at 12:19:02PM -0500, Mike Snitzer wrote:
> While I'm sure this legacy application would love to not have to
> change its code at all, I think we can all agree that we need to just
> focus on how best to advise applications that have mixed workloads
> accomplish efficient mmap+read of both sequential and random.
> 
> To that end, I heard Dave clearly suggest 2 things:
> 
> 1) update MADV/FADV_SEQUENTIAL to set file->f_ra.ra_pages to
>    bdi->io_pages, not bdi->ra_pages * 2
> 
> 2) Have the application first issue MADV_SEQUENTIAL to convey that for
>    the following MADV_WILLNEED is for sequential file load (so it is
>    desirable to use larger ra_pages)
> 
> This overrides the default of bdi->io_pages and _should_ provide the
> required per-file duality of control for readahead, correct?

I just discovered MADV_POPULATE_READ - see my reply to Ming
up-thread about that. The applicaiton should use that instead of
MADV_WILLNEED because it gives cache population guarantees that
WILLNEED doesn't. Then we can look at optimising the performance of
MADV_POPULATE_READ (if needed) as there is constrained scope we can
optimise within in ways that we cannot do with WILLNEED.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
