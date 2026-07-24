Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038363385B6
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863518; cv=none; b=K/L6lsJ77K8yj8purDN74x0pnw5ynaLRi8B3iL1wYwm+OxLEZt4LtFtw0z8nc7ouTZTeIAQ/odpeim3oJ9K6asEaBcUhOVz1wmAPLP+aR19cKKEkALEFycJmsT5EgFkita4ocW+JL29mNgZNOIh0PWewt7sEfN04KcYDD7gdPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863518; c=relaxed/simple;
	bh=7RDujKArK7A0YRlt5XOrnzoT4HTdB/1nKHdXAHzhjUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4Emr/EL0Q36HwstIsQbkgw5BJCJdToMbsi+6KoSwvKf63Es7G5nWQtPVyXwNykm53RxH7vTpZW5UPQCzv+5aTSCqfUOT72jjV+Anw5+D6pkmHcNI5qYLcWUn8we+Ij0JDSpQJMJ2twr9UsjQvojlQT1TquZEjbJgZX/Nv9NIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kubMpi4R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kubMpi4R"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84867f07d63so1566532b3a.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 20:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784863516; x=1785468316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLw+iNXTSGSfw9Y7a8fjmuaJ5kL6Cp8Mm5bKv5Vuo/k=;
        b=kubMpi4RyHy9i8rid02LLfzTCjniE/U83GzA/z54ay3MI4oXXt29FW7lAp21Jeg3Th
         dI07FpzPVt8HbE0GlAzdL7uHbmDY902wfxQKudbi6XIgp5lNdJ40s4fyzvNrbLdnJ5WG
         8TlJ3ys6rLp8YCwbTTU2wD8rpCpy3IeBoOYAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863516; x=1785468316;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLw+iNXTSGSfw9Y7a8fjmuaJ5kL6Cp8Mm5bKv5Vuo/k=;
        b=RuJmjlcNhD/t5Inw5ODpPSLAiEOew3KDrUb9xuhaoMGEJFNagz2vG7/Ah/yhTuqgz+
         ZgXxupFktMJ7TQEv0UjiCl/KCDQnUw7niSakm8Z1FeRlKtgQ+KxmXBeTukM34Vbxuk4t
         lC0PW5YlkIQuCledc8hYX7wr0CNBisX8GWRsqE/HHfRJW9Ew0wFgq+lQzp5hN+2IRKv0
         4kCWuz3IlG9IX8jor515LDihsR9xQ0E8zKIxEI1TdFYHwDnjnaTLKovpOGvbh5S3Fh/c
         gilkb+xM06MpdxVkzSakKkhEEp7ApN3HevBX2otGUWawEixZdpx6CMynakzozb65geaA
         J/sA==
X-Forwarded-Encrypted: i=1; AHgh+Rp37XWTgKms7RFgei0CBiPRFfj3qOp+kBOztNdC1tbDiIukRKTH1RTCA4eSdho3uH7mOEI4Yv611VUUKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IcWmeSDnSO1OTU42bMmvEdU92ACmGTd+N0xYafV+JsPsFKe4
	zGy5QKvmh9qP9jQ42GKPfcaTL4gf26xG5eHekj7BEE7FYUC35v/1aXTP32rq27vGDg==
X-Gm-Gg: AR+sD121pvrfGXpd8kQdB5xR3QWnjiREEPe87ohqZ3AcsWU0ZToSQOIcAz7H8/j2mHf
	UX8cvBLDviiwFZ0X7q0TWd2TiXrepcEOPKjlvVSTFXIpcGKjxWukl7ZxbZ8XNKDy/YRKR2syOAE
	XJS4QGult4MlSeOQL4GHaR5lKkAuVy/MmP4tIgTpeZmRxil0FgAbh8oLnjk/KjhuqkUrbnsSOXZ
	Z3vQxd5XMg8VgvLl8sBvJwei3buEVjeXsuLtyBBAW90O9JFDH3GZ+XfeGnKFwtYQ5POvsPTB5U4
	TNz1sAJm/SCV61fbIZ/IkdJCymk1SUJd+tXBrPdIistAEpQSNxMVV9fhXPM11rM/WalcglPWHZm
	OXKx+g5R3q2Dlq/PUOW9zJqBdqDsd65GaQDnbA+E2Ly5AOiyB9FEUEv9cFn72mMaHtkZEag1EmZ
	m2r5/I35GXF1Q5BQw9dzT1/nHLphlqzAtmypXN0rBC7g==
X-Received: by 2002:a05:6a00:12c9:b0:848:4c0c:9482 with SMTP id d2e1a72fcca58-84e2baddf27mr6682896b3a.35.1784863516432;
        Thu, 23 Jul 2026 20:25:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:c102:f12d:5168:6be5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175a29aesm3924592b3a.41.2026.07.23.20.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 20:25:16 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:25:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: Move lockmap to be per-zram instead per table
Message-ID: <amLa8bS723DLgKyd@google.com>
References: <20260714141300.3945672-1-bigeasy@linutronix.de>
 <20260714141300.3945672-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714141300.3945672-2-bigeasy@linutronix.de>

On (26/07/14 16:12), Sebastian Andrzej Siewior wrote:
> The zram object contains an array zram_table_entry. Each one has a
> `lock' variable and each has a matching struct lockdep_map. This mimics
> a struct mutex.
> 
> It uses always the same key for all lockdep_map instances. This makes it
> look like the same lock to lockdep. Therefore it could be reduced to
> have one lockdep_map per struct zram.
> 
> Use only one struct lockdep_map per struct zram.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
