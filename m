Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984182;
	b=Uibw0CedVrfF3B5+6eazqIStrXKSkEZNS4EEZWZ7i9kJwJ3uU6fNujMp4D/Hyv2hYrzj
	 uGtwgKpbh+XxVKBDEDmeIXxBYLfL/v8MR7PhyjeIxif0Z2hmN0aN9kTPOSgp2EPFbthyu
	 x3wOGPfW7VOvHoAMDdG03qkEGqwezM+yTGzIDebNDwMUFghO0xLchntP22TjygGLnTcAW
	 3j3PVgv7mcUNOqTasFI69UwSBuCTROiad+TDZ+0pAcsifGfH0BGMlELNSpPADmawxZ8OC
	 uIwbV4B786y6FF5rafifO9g+soSoTyJlqt3jrH098kTGYT6rpo8wr2+U743kbeQFIrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=z+4adjsji42YunpnXzr153PsIW3465KG5I6YOnRXsyQ=;
	b=qhRqDUxwVgziZJOa59sObDS98V9zrhxjjOLbqh5gBwIINCvvINQ/v9pqHu7FiLZT82+L
	 TVyWaYx8jR+pVSfDG/ZTHTheYx2dKGNShH6ZQ1behKWPWT2jMgqNMKoN93utCEbpe5c4x
	 dBWGFS8HDtlGj1LrDv9xuoBGHqmVX3NAeaZFUkIiw7oCYj/sbuluBQ61Hh0/8iCMLsg+7
	 jGBq5biKY0IJafH9QTkno+T/LHh6UEebmPLkP3qjm12gHwBkrNznIzHE+9ZrButnPYGEO
	 E9FPYaOkvjf4Cdoir714ksNFg6rctVlsIA6bW07d1niyhfRlQ8Q34DOQx9cTE5wCpmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fFETq0jP;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B477606A322
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 03:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B477606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fFETq0jP
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so4950442eec.0
        for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792984181; x=1793588981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z+4adjsji42YunpnXzr153PsIW3465KG5I6YOnRXsyQ=;
        b=fFETq0jPG6sQ9wiL42ku236U241G4j1Kd8IqsCybUJpzUdGray+Dl/X4p4SlX1WzID
         tzatSkKdSr6jG4SqhFB9YvxZ53PReNOYl84lku+DAcBWcuo9wPZQrxqeWa1G8aiU46BQ
         CVdLpCPJhKcsJFTXheLehfg1WqxtkgNKUHPlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984181; x=1793588981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z+4adjsji42YunpnXzr153PsIW3465KG5I6YOnRXsyQ=;
        b=k5hmgUN45rVNlIqm0hRQ357dKoOv+tZvsqNJOzE5AVCo++5rQUyaxrL4ubYAQu+sJ7
         /eMco7rQd9tySsRJLoeD/TK5xkrt+rnD+sVbyuUjqNnYv4kSai0rOiON8lTFYn4BTeMA
         FP9ZmKg3cApZdOG6bPNbiU4nm3lJOyZw0jKkudSXwcEzUA3L4WEEjBgOG9bF/yF9MVtW
         nQCIQJwCc6UqtVnGhpUge3YJq5txA27S1a9QRayNqrh4VDqBX4zbsBki7BtqnUvcQU2w
         wZgOTo4X0shGoS/sPZ4VriMbQkg8zCqKnkFRv/ccQo/MMis5BHeqZdSYq9/ZUbBikA0u
         48Jg==
X-Forwarded-Encrypted: i=1; AKwUvBzNDJwkZSTuijYmY5biBGrMCWqP5e88R4710z1TIQZA5jc69p7ebK0MtSAghekVn7oaLJ/Z+WTxaXBZMA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIO3ril0SZ3Bkl49+Ur6rywprFEe2WCqFizvAN7jDxkxkVh/SR9
	XUZVSU68cN8GeZs4P7nuE6z/dgWI479FsPefE0VzZd4E/u8143xwPhQnAoPx3NvLpQ==
X-Gm-Gg: AYBFou3GhDg8DEvoSbX+zmxvZmiu3a6XdcitSYfn+cfZr0tfTbGBS+RoaEsEnvqJeco
	aUn5wYzPeuvtL2stIDAcGxrYR16LVEgSYsQdM5NadfYPWdzM74O7inqbwyU7IQuhFu69Af7z30h
	FgYvkTWcOwUjyUjQ1XrxLj6135l50BjpnzqudGBQpF2xnlJ1hQhzlT/0f3L78BbVHq/cysx7JFK
	n3QZ61DPkLimnODJAUz6qMoc92RFI9sXd5MrC6OzemEVlgssucLeeB9UUJ7O6iv4ZAlYy4khNfl
	7gWjhtnA4l/4avnxk0aQrx4OTrkNqwd2YyFXt6SisNzy9TLhNORaoOUHnYRRlvOZz2C4Ltm5brr
	zQqaW9COIA0ss620gNMHqebMx2SBYzJMoMiINCklhDaHpJzlZptShMnAQGJe1vHRCVDZA00JXzf
	JO3TXCLY+Vb+ETbf8+bv/0VX4Ud2xOJfJew1sbxtlGTaUKlrZfS4d68THIIcVMAvGUEfYQd1dVo
	XorVyWILk6cPXyNUl+kjxubaqTBBAxF+BVEr+jbneYCSq27xa4kea56vW4szh8maNQWfBmw+Ush
	tSv43uvgYwfCLhBpFw==
X-Received: by 2002:a05:7300:3d13:b0:361:39c0:c393 with SMTP id 5a478bee46e88-369e848a6dcmr9746177eec.13.1792984181239;
        Sun, 25 Oct 2026 20:09:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:4346:aa6:8d90:326])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f4164886sm13681062eec.7.2026.10.25.20.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:09:40 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:09:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Brian Geffon <bgeffon@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, Bo Zhang <zhangbo0325@gmail.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Message-ID: <at7ECnijIur1XOAG@google.com>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
 <20261021024236.1787884-10-senozhatsky@chromium.org>
 <CADyq12xeONu-+YRP79KaH4XCsSrNK5DdoKw6T5YSEyW7Acxh7w@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyq12xeONu-+YRP79KaH4XCsSrNK5DdoKw6T5YSEyW7Acxh7w@mail.gmail.com>

On (26/10/23 13:05), Brian Geffon wrote:
> On Tue, Oct 20, 2026 at 10:43 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Split struct zcomp_strm into separate compression (Write zcomp_cstrm)
> > and decompression (Read zcomp_dstrm) streams, and split zcomp_ops
> > context creation/destruction into create_cctx/destroy_cctx and
> > optional create_dctx/destroy_dctx callbacks.
> >
> > This decouples Read (decompression) and Write (compression) paths so
> > they no longer contend on the same per-CPU stream mutex (Writer vs
> > Reader priority inversion).  Currently, a (low priority) Writer that
> > holds the stream mutex can be preempted by a (higher priority) Reader
> > on the same CPU, which then blocks on that mutex until the Writer gets
> > to run again and releases it, which can take a long time when there
> > are other runnable tasks on that CPU.  The good news is that Read and
> > Write contexts are completely independent - compression uses its own
> > scratch buffer that decompression never touches, and decompression
> > uses its own local buffer (for spanning zsmalloc objects) that
> > compression never touches, so the Read/Write context split doesn't
> > noticeably increase memory usage.  In addition many S/W backends have
> > stateless decompression contexts.
> >
> > A quick synthetic fio test for Writer vs Reader inversion on 24 CPUs
> > (preempt=full, zstd, 48 low priority (nice 19) writers, 24 normal
> > priority (nice 0) CPU hogs and 24 high priority (nice -19) readers):
> >
> >   Metric           Base               Patched
> >   ----------------------------------------------------------
> >   Read IOPS        207k               1,150k        (+5.6x)
> >   Read clat avg    101.50 us          7.76 us       (-13.1x)
> >   Read clat stdev  5,615.90 us        30.78 us      (-182x)
> >   Read clat p99.99 258,998 us         111.10 us     (-2331x)
> >   Read clat max    1,342,600 us       11,217 us     (-120x)
> 
> These results are awesome and thanks for exploring other options. I
> agree this sounds like a great path forward.
> 
> >
> > Suggested-by: Barry Song <baohua@kernel.org>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Acked-by: Brian Geffon <bgeffon@google.com>

Thank you, sir!
