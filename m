Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634820;
	b=5PAeZJ7JReaI9CeVbNuKmhnQD0SX8MYbZbdUauOWPCoAgQ8JR4PiFMsiNgfzXwyMjnSL
	 NvfLDqGFaiZ3FdmRo64ps3jLmAntD6TUV1oovpSiFinbYcKR3Tvt+Xu60ygH0ge81UjXb
	 o2HtqoINiSvVdYezLIGJqlVvuvQQMgfLP4ctZx9ecoPdcz0nU1DW7PgS4esEMUXASQlZM
	 6IOxPJV046qk6GUSX03kNsJUby0gLabH5SttT+W7IQVHDwSTcViZOZx44nCm1W/vo5Gqb
	 gXVOuWZP+yx2UZOG4yIxoQMbcBYyIiDEEnWdfmU7AA9hXsnO+0AGXyTAva+57Mnn/TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eQ915uMcXwm+HIjz60hdmKSaQ15t6ZjQjfLrkfmZVJQ=;
	b=DwEmsEI2PQNK/YxDtPut/POsZmojR+DrvILhNFPIFbcueDRnHPVvt8bbVN9jgH1CIZ2C
	 WcZ7oKCe8NEva8HxfMEoq7T5cds4Fk52mlR0yTnRaow9bW9FwPR7oELrszVvskbTxmsCB
	 TqhGh32TdGprI6F5d3TTApf8dGHS1cN1HPHZaai4Jc3yrqxKVNAWHeltkOgDQoPVtbZAL
	 /ZFGlPXt8aaBD6nVmeSo+CH7KmVWc0Ci9RpfFrBV9AcLBg6paHCujEQtH+55DALkG5kat
	 guX9Cwg/QJRMFbQKvaD9VOdtF6HHBxLyPFmBUpJlY924ukgIFoPfKflZZMTHbmGwE3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O3+ZIBOC;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BB606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 02:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O3+ZIBOC
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1846bc43c28so435938c88.0
        for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792634818; x=1793239618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eQ915uMcXwm+HIjz60hdmKSaQ15t6ZjQjfLrkfmZVJQ=;
        b=O3+ZIBOCk1wCPp9waZxD2cBeYr4Abqb+o6rfsr1DcTVjiU4Ni2wmp2jM7GU15l0H4E
         IKPJQpRb/LcroSa38zbAWWYhhELXRxyJLhaJ8l2xt2iJKQHUAxaOWVKIbMBGP9TRFDbW
         eqOr+vOlVzw2FzOrkrkitxjDx9CTlhbbJyMjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634818; x=1793239618;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eQ915uMcXwm+HIjz60hdmKSaQ15t6ZjQjfLrkfmZVJQ=;
        b=zMDXS7UPiFZl8fe7iPjAraSCGKTVjxax/L8Zfu4VHbrqmQALNeNGUsWPyHjfw2Lou1
         UpAT6svOdo/K94z05FOcVh8GqKd9dYO+JCV5Xv27fk3rirdbsFdYBxOmZIYfxiKOTvSc
         bwbatNLCtFR6kgWBxvd+W1A7M8BGTDVEFM3F0C12+Aju3BEq1a16NMfD+nj8lqR4So2p
         cC0jRacqCZCLy0lUwZ/cklGoTFibSIL1XxNL39ImYG0i7Q6SGXc1jOgtyB/QoQgwQsuT
         asAPWzBPgob5b72BJIk8U7wXoVYZ6SE8IhjQwUmHYhjG6VsD30TMeFhT7q73j/0YQtRy
         xHRA==
X-Forwarded-Encrypted: i=1; AKwUvBxKh6ZTNVvOeP3NmgubMVueK/uoq38ly6Z3b6vaLkwt4kEbYEx6deOebLrdEgEj4nxuBLpavKdYx8qDsg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIUYzLC7I/8TNDobmZ1/2v5wqXel5lkaBzZ8FAFgz0NrYXaqWv5
	UpA1PC3SBwGmdNv4i8gMMzDbxUzkgfQV79x80CLPPGoVYwVcVAOpCTX9GsEbH8dtGQ==
X-Gm-Gg: AYBFou2jMSxL1PeWC/dGT+FYMV16llWgT5TX2O0kldbsPA8bjwRY0GmTcUwexuvKQuo
	NBxmNpMJb6YM+raeCQq7wV3iXNX/tKJgU7yYahE9J7l0/MQjlA5/HbwDdM5xDNOgfHwoEXYI/rC
	Muv1zl3dDXvq759cViH3kWl6Bxk0NJexwLgCxqoz6eiv3gbIx2Hldq4v5baMHwPEYpICHSXYUOZ
	FpWgdG+peVCaAFKyR25mW0Rce+8slCB94mf25RdvTfUfEJqOfx8uZ+bsyiRuKc02MdGDHHWglQt
	CozzyWaPTUc5PdAQ0nNXuNbolOyMOdbxQEmlnAJm0hE62PcdZikx+UDorS89vx/KUqEa9HzXfUJ
	aC+sNAv8VBLYvFSYjjXdZSlXvBUp1YizpetDPdDH8pqCOLj0iAu495pT1+IBLcRN9RKX/Q0LPIV
	ItqA3vZFQAj1fxysEYqXmPSt4b4JH2IccIzGNW1iV9SImCDqcwEpasV/cqQNjdvkfbKOeoHzv13
	me7solhIDDXsijV5xYD2g3f24+hanKJPixG/aMFpkk/QV1WT1hfAt+625h1NKH/cw2J7bTuBH0m
	cBg26eN1dwNElKQIi9vC
X-Received: by 2002:a05:701b:4308:b0:14f:fb87:cf62 with SMTP id a92af1059eb24-190a5d6f6famr4655442c88.27.1792634818203;
        Wed, 21 Oct 2026 19:06:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5145:5add:2df6:4671])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm10318111c88.19.2026.10.21.19.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:06:57 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:06:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Brian Geffon <bgeffon@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Message-ID: <atlt8YGuSxgRb5uE@google.com>
References: <20261021075322.923-1-hdanton@sina.com>
 <20261022000822.938-1-hdanton@sina.com>
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
In-Reply-To: <20261022000822.938-1-hdanton@sina.com>

On (26/10/22 08:08), Hillf Danton wrote:
[..]
> >>> Given lock like mutex, priority inversion happens from Monday to Friday,
> >>> but I wonder if you are inventing some wheels in 2026 if proxy excution
> >>> works for you.
> >>
> >> Reader-Writer split is a foundation for further improvements (like
> >> singleton recompression stream and so on).
> >>
> > But that split is not needed at all if PE works, yes?
> >
> 
> When the number of locks and tasks grows, I have increasing difficulty even
> describing the lock chain that you in combination with Brian are unable to
> handle. That is why in general PE is prefered over whatever wheels you can create.

Hillf, if we reinvent the wheel then I'm very happy with this reinvention.
But we don't.

There is not a single reason for compression and decompression to be in
the same context - they don't share a single byte.  And there is no
reason whatsoever to serialize them against each other.  Compression and
decompression should have been separate contexts from the beginning.
While serializing decompression with a PE/PI-enabled mutex is cool, not
having decompression serialization at all is way cooler.  In addition,
decoupling compression and decompression leads to a much saner recompression
stream design, which saves considerable amount of per-CPU memory.
That's what this patch does for us.

The commit message probably can be better, but other than that I'm
happy with this series.
