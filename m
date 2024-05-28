Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B32155A4F
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889520; cv=none; b=PvmVjXbYQpiqRdFlI8S7mbtaiwimv6xb7pS8c9snTbNarw/w3QXoR+eJuu4Ac1Z9huBRG08xXlMjLKqa/Q+U5axll5vhUoOnGCC8CZCXfDrpzicMSoZO5c4wX8qRiq68bzvPq9RdlAvLYgvgAf+SnEoV3qDcsxUFxUW4wWd1yjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889520; c=relaxed/simple;
	bh=nfVZoECiu21SbnQns93xMAJk8jPOEkArHUrOO7sZ98o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOEL+mGIx6pd28D+CI6qgEr4UUTWbE951YGqUOovgYZttREZLA+UqhVyjblKGUNj/8kfUJnyHN/fcAIF6Th7Apc/gZ9gIJOYUSOPTdDbok0ILsFjNVMj7O4a0T/WPWknYLlQI6PHjvHU7OMDvayB7PFUcq3Y9WzS+mMhtOLUeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=grNfTieT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="grNfTieT"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-681ad26f277so461516a12.3
        for <linux-block@vger.kernel.org>; Tue, 28 May 2024 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716889519; x=1717494319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSaikuAEE1TmRWmTPr+CsdopaGULdY/HVZMAQhbHYwc=;
        b=grNfTieTrRGwevSntA7MPXhCRrXTu/OGLUG9NtE1LQ9CFjbzRvh6WalZV8FHXa0m4a
         3HZd+MyDEF+vFFWniCBXMPUr8zv2XiAryzGYijBRhnuq7P/+JL0nTeW0XP8xkjQF/1ab
         j1j1jfy4gN+2vzqbWaN+oO0111QlywCJdRtSlYrNLwKj/rIAWy5hVJsB976RFZW1ioCh
         diNtDcLZVAaYWGLg/KjrBeZxDL0M53Hf8M/7zdygvlSp4dndBu8wtuXVoBPHohenZTVk
         dZNTbsyZ3wp2g989D3el9i5+VQ/zmWCllVaW3+TYhEjDW+PVE8/qMEGPSPL2fsi6NGnh
         nfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889519; x=1717494319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSaikuAEE1TmRWmTPr+CsdopaGULdY/HVZMAQhbHYwc=;
        b=exKCrYZrtduWmp1opR+UfedXbexIRG78Axa0henbnt24VCD6CVkNX/BBF75QzDEZ83
         hZe6gNucQAk3msfqeYggwGsE0b6OAioG7UizgolUPm5V2ut/2LfRH9Z0Pba3nN2J41fs
         rbYezAd9LqtLJiH/46Q0jPUmQTiWj9eMA+RY+hYs0oNDM4RB3E96QRR2C7VxUQWDuySl
         1j5fqDhQpFBSwvuAQ4UWMnl+WJS4S2oGGoAJFhmnlJlFdkRlPcPyDYNXERwS9dlrGo3f
         bBNOf7iDs8QlgZoBSb/S8rzcqIHMEmhvjWnvYRKJEQvhjr3MUYnBUuWINfVqGqoagi/Q
         qFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt3XkzlcIqArmdB+vFeA9lkz8JFypxbQB3lBfyLTVu8tAH2Nnu294KCmoKl5hUG3REj98i/sR2uc4+WT2oiQIkE9v4FDqZ/VMyGh0=
X-Gm-Message-State: AOJu0YxNdamURGeRfOpBAmTtg7cnVVqw8KDC10TTMfRRRJlt4YeC4eCX
	2wUjSlrSfnxpltP+25T7SHcIVC3HaizE0QOsfBtsBWJ/2Tr9JaF4bPxx7LWyAhA=
X-Google-Smtp-Source: AGHT+IF5RgW5VSoTNNLwvOASd+BGDj5dWiaubF8Oqrmvn2nbTRNTa88hfPX0xKeu1Haa6CBW/oCfgw==
X-Received: by 2002:a05:6a20:a10c:b0:1af:d1f3:2cb5 with SMTP id adf61e73a8af0-1b212ce1f49mr14193215637.8.1716889518533;
        Tue, 28 May 2024 02:45:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9d89b3sm75760405ad.292.2024.05.28.02.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:45:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBtON-00DKcW-0N;
	Tue, 28 May 2024 19:45:15 +1000
Date: Tue, 28 May 2024 19:45:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, chandan.babu@oracle.com,
	hare@suse.de, ritesh.list@gmail.com, john.g.garry@oracle.com,
	ziy@nvidia.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <ZlWnqztSjDdbqDcB@dread.disaster.area>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
 <ZlUMnx-6N1J6ZR4i@casper.infradead.org>
 <ZlUQcEaP3FDXpCge@dread.disaster.area>
 <20240528091202.qevisz7zr6n5ouj7@quentin>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528091202.qevisz7zr6n5ouj7@quentin>

On Tue, May 28, 2024 at 09:12:02AM +0000, Pankaj Raghav (Samsung) wrote:
> On Tue, May 28, 2024 at 09:00:00AM +1000, Dave Chinner wrote:
> > On Mon, May 27, 2024 at 11:43:43PM +0100, Matthew Wilcox wrote:
> > > On Mon, May 27, 2024 at 11:39:47PM +0100, Matthew Wilcox wrote:
> > > > > > +	AS_FOLIO_ORDER_MIN = 16,
> > > > > > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> > > > > >  };
> > > > > >  
> > > > > > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > > > > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > > > > 
> > > > > As you changed the mapping flag offset, these masks also needs to be
> > > > > changed accordingly.
> > > > 
> > > > That's why I did change them?
> > > 
> > > How about:
> > > 
> > > -#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > -#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > > +#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
> > > +#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)
> > 
> > Lots of magic numbers based on the order having only having 5 bits
> > of resolution. Removing that magic looks like this:
> > 
> > 	AS_FOLIO_ORDER_BITS = 5,
> 
> I think this needs to be defined outside of the enum as 5 is already
> taken by AS_NO_WRITEBACK_TAGS? But I like the idea of making it generic
> like this.

Duplicate values in assigned enums are legal and fairly common.
This:

enum {
        FOO = 1,
        BAR = 2,
        BAZ = 1,
};

int main(int argc, char *argv[])
{
        printf("foo %d, bar %d, baz %d\n", FOO, BAR, BAZ);
}

compiles without warnings or errors and gives the output:

foo 1, bar 2, baz 1

-Dave.
-- 
Dave Chinner
david@fromorbit.com
