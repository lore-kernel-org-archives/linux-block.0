Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4A25D54E
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750853551; cv=none; b=gtRozfO8hhyeXx/ZQU2uF14rcNIqfINYZoywqvYPIhKgAR0e/Dckx/ceuXiHMstRS+TF3naECOeGX8tPJHMICtLAc+BfM9S55h5AxG747KUWRPkqOAFdkuooQ3BXKM/wR6uCtF/XI7IcYbzMFij6bE+HmU2SQkcD8Q8LYqc4zzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750853551; c=relaxed/simple;
	bh=GaGCVNnrs049twokdApTJpYwHf0SAp2qsLwoXn4B0aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ6aCoZdUQCaDcBdH/B5V0maQczXcPRGPgbt49/XwjclXXCksucabv23Li2NeYDg47ooZyUo4gHIYfws+9Pa2TyWwiUJAHkyNI7y58NSbRmTv0pKX937lHf/mFFfs0l75VCDUE+gEa5M36jrcPZ68oGZwcL9IJUiVdYlfPKmk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FdXzwqBw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FdXzwqBw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so17061705ad.2
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1750853549; x=1751458349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANo+Owi2IwINUCllKBT2m+pMoITuQHrikto8dDxBvQE=;
        b=FdXzwqBw4EkBD1bnRzBOC3MWR3JrlctjyYEctwV7AnwmI2JtWMv6H5MY1NDhbobDNL
         Vn/ICJ50sKxjFT1F/KpFecMwf2G5sfIa3PfXLLqIK+yWH8aRjBF7SLk2YAzBvwATG3gj
         A4uSUK+G/NFl6aPuJ5E+hdPonogVZRxy7vN7UzIxYo110Hnr0SbT4+I+ERV4WOLZgZfK
         OCIYsp8rGbnlZQEV8hI+OcUy3WkHJ+Ko4gKza0cVYzoOFPDa1pYewVsV0RX5nNUpbYPj
         UpcBJ1DBDSGwJE5i8ZgZhuZUw0B7zFU0ZGephmdvhazL3eLt3trT2qJEGztlGuyUeVUM
         pFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750853549; x=1751458349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANo+Owi2IwINUCllKBT2m+pMoITuQHrikto8dDxBvQE=;
        b=jm8P51hQejHpKQS+sl51su5DzR8oH/keuxpflV87TGQxxnr9JCIQw/Xy3A18dtP5pE
         twBiv4rkR5WTDdwElimhnH0CLbUcB2c4iI/sqRYbsd13Z8f2lBWSnrIohPF42cEG7Ql1
         3jbI6P4P6THXFK3Zq7yOmKFBtg7SF3pT638cppdiQKXomahl6GoUsHbVg+lDMwJb5EFH
         2nGi6waK4ykmxdvZlwoh3CI5WDDy3QzHoRb8XFlJ7xnMELGqDfkJFeoFPkFb0tQ99EnU
         Xr9B6vAFkBQRqytRaNhhVhHW2NsuYNRSqxvK+Knt2dUzqC227FfSQ20DPXiq/f7Iy9kg
         9WCA==
X-Forwarded-Encrypted: i=1; AJvYcCXRtZQzZuIPmR0nITkC3CwM6xYqav2BYpvKVjznl4haMus1P34b1Ztf7LphkQ2XmtlUBpZlX/6YHe2x6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54b6Q6KM725kguW5Q+5E26Z9rkKdEaaC9zGb4j3vrF+itIsTs
	J/uPuLLBCR08cb3ccvWJxOHYaZjEbxYip7IlusvlbEOnIkWylSxsw72KifdgL1IBGB7My6qEj7K
	N02BW
X-Gm-Gg: ASbGnctt/+IBqeJA8di65yUqqW2zEr4pBcE8zkQQr2U1k1Lyhsti88KGG0Qs5uRp5C9
	k3qngLIdvNirKbSExP7p8cTXqUqK13dUqel9K/mXMkrqCdmL4S6/tqoDIYhi19Hz2UEAToaAGbg
	/0FQGH33LzsGBVtMQPHI56/ZQBeqGl6iYNNtg3CCF16cocYmMP0W+0Pmmhbpdcoh5Wis9BNXa2G
	1aPC9nQV0JUoLM6zzS+k0FByYSaHdItSyzAzJd/jC2MN3F0SW1vVce0f3IIUPh4Lo0K2TBLFde0
	qcTUtSwV7tgmvWlPnd72SKs8yM4UJw/yDKwtH3W5SksnAQe6BPHCvT1TGL/PenKIO6ANGJqfGO7
	uH6nOZ6HOaSY0qmAeXwHTPKsLP0M2Wd9nuEaMaZIx2L9WWIha
X-Google-Smtp-Source: AGHT+IFsWudnfojrg6arN08dw23V0B/7VU39ASGj4uWkOJeXH09JGPtPTIbodbPCaiNIWH5xF0rUTw==
X-Received: by 2002:a17:903:32c7:b0:234:bfcb:5c21 with SMTP id d9443c01a7336-238240f42bbmr51536505ad.19.1750853549402;
        Wed, 25 Jun 2025 05:12:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83eefc9sm132360405ad.74.2025.06.25.05.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:12:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uUOzJ-0000000340m-3yC6;
	Wed, 25 Jun 2025 22:12:25 +1000
Date: Wed, 25 Jun 2025 22:12:25 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [WARN 6.16-rc3] warning in bdev_count_inflight()
Message-ID: <aFvnqZEHCkikG6xM@dread.disaster.area>
References: <aFuypjqCXo9-5_En@dread.disaster.area>
 <aFvdRm4Ec8Oi3uBT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFvdRm4Ec8Oi3uBT@infradead.org>

On Wed, Jun 25, 2025 at 04:28:06AM -0700, Christoph Hellwig wrote:
> There's a test patch for this on the list:
> 
> https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/#t

Ok, so when is this planned to be fixed? I've hit this at least a
dozen times in the past hour with check-parallel - it's causing
significant problems because random tests see this trace in dmesg
output and fail, even though the tests themselves have passed....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
