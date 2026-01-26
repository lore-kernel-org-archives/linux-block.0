Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1E32AAA8
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425185; cv=pass; b=JgktBJVDCkqpd7RaoR7I3A+2fy9gKl+UpUjdqj3IzxWwtkZ4GNqPVdSDnHUYgKnzZRU6j6cRVSBZQq4WWTtZSjiboQoVdnx9Amk3XbyeFjQK6wkoY5JYNghHX3HQl9wrLw90J4GGXK88F3pQb/rMOfZosfvst6ePfpM2XWcoaXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425185; c=relaxed/simple;
	bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2leX7YSVP2ATAuQVM1tPfJY54CqKsLnPLDrXL6yTl3XRj0ae4j1HXdwBZkTdfAbnJzTX8TU2Ancktnyb8EoYE1H0LclO0+iSfcW5TY4AI9+vfrEuHavlxSkwtd9e7KPVygtcc6KXlU/KdtCjt43hqxC20nI0BBCF3d8uieSvfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvLUkCn+; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvLUkCn+"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso8546143a12.1
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 02:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769425183; cv=none;
        d=google.com; s=arc-20240605;
        b=A87hPHCpz/i60dQQdUbqvgqmG3G72cDcK0tw68a1pBEJ9QRqvLSGHeO5c9Bn34O72L
         SLbnElI2DwnmFIZUTrIiFFUYNbJarVgTuOoewU1vjcelzIB2v1yuxngbUlGxYHlMcUCk
         Exd7p7KHhbFyM6zmB5ptoxcMSN4F1rwMyQYy7NGxyf6Sq9RD3KvHlsMtnKEv3MAQY43I
         ZE/qi4NjalIuJmPM5M8eGdwe3Mh7SKNMYhKINmWKJixBy5dMrAsmT0vtkHiVvEqT6jQl
         T8SnBRS4qJLjjhjbDeuKEjvMQ1ZvKVczyICmvtRDVlpST9P4XHEbOnHgiBystzjANBr6
         qo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
        fh=c0OSLdarGCSr8ZToAADQSWuwQSc0/pzTMFzGcpsF7vk=;
        b=gp4uwhfCwPCDWq9ZBcWK9yd3mfPcORZ/gF2hpP5BDOeMobiVMmXZ6iuEP1bXG+45pZ
         hxLpOCJLBB/MAU4hYuP0qMJwVWBrRzayBVu9S4atjnlW1yIRa2mmqrLKkO3iittXGU+G
         XBlWPJRp9Lm7Iv2x5ATwqMnvbw7ZQttBMYBOoElU+VK129Gr7NpMRqST/uReCvcUHDl2
         K00dfbNvAdvbONsMI3sZmBb+vX3mSeni3bX/6IZXE5Vp0wnHGFcF31qA1pkpi/oTNH7u
         q+L4PQzvgZSobzxJUI9YFEd2VyOIbMGPvNxhzqCbmSRLtujJHHBTMJC+Yk5D391gAx/0
         sMcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769425183; x=1770029983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
        b=UvLUkCn+h2NnvsEy0eDGcNyPBej95rmaEmrsJr53oY+ZfBVQiN7XREwoA9lZxCDveE
         g/K4Y51QQq8hD1fkFvRHAjCTbTw81EvzbtGuF/lbdGOaALWPu0sT5g8yG+aLQk3XqYSW
         vNJsxnGS46f+VvoLSokq+IELkEC/mIvjgC0ZKM2Gr0GR2De89gW7HaFyYobZvdCuKP2x
         CjoqVVK6y1Rzmk79ME6vEbt0ZV0NXJvX4zp8RXJPVM7cEpDGCPcE4nwa8LyL5f6r8YwG
         C4fMaxg9xAcRDLJ53HDJLDAU6i8L72NPTR0xhoKFV6koPs3g+ZJVnn5p7zCvXLmZnhfO
         M/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425183; x=1770029983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
        b=nfgQDZf02LHK6VPG7c5e0a0xNhDMDHneFfvCU3JAbUQFIxJRGNouCxdYTar5jRPmt0
         cf1bPZV0x/ut37hs0uG9yy7VH17raz+9LSJ6XmQEPKCE8J2xLoArejYK0qGEcBhE1kiF
         aaP7lgm83o+UHzBS8Ghzonyv5tF5Xc4f5qM63bDmF7ne0tfR7npkGXbPzgX6lh6uPfH/
         D+g4y/9fPJrO+GQ020VZ3At3XE9YFVE6dkGk33jg4yujhW17LxxvFp0x3WQiC6ZRiLot
         5s6l9KIy2Q/UNNnbOZF5b5+kH7Kp0Sszg7vMXv3l7bguTA5BgHfjdG5gzhNTqgnmYedi
         iGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRF1aL20WgckslGbBdwkOZAm7/eF/xI1lWS0TxflWv+03LAj8FkAmLz6UMAKYWrApM6c6Pz34kaH4eKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCIiHQ1T/SurxuoXxo/6HfVJs93RvcjB4Y1v7hgpIaurL/HPz
	pE96mOihfunq0EWOxzXA+V21QgNtKQiusc6AFGcOXMrdoZRHtu/R+wJdyANekNlngz2B5j4qtLa
	aT6A41K1O9P8pbx9mzxHIGpXUIAdNmQ==
X-Gm-Gg: AZuq6aIy82ygW2Wtx4NdQrVdxxpUIWRMk9UK3ts2/ODA6EQFtX6fURv8FLK0L2UI1rf
	tfm6K5mVFq2DT+be8+SonL/hgxeXT2swFEAhmdi6in5TIybvDJgW/rJApBaIHBqK+m6NUa0TLKq
	xuU4eT+jgnkkzmWRoRycD4lCaswBtMfXTP2Dfyg9Wio1riZEJL8CqZymBgWAoBXCI57iinM/8UL
	m2qGPjzB1UKusY3mBW58PcfROgpwxN0baCW279TEu7xZ8ZSawrv4Uhddf/gd5VijSmEqEIXjVsP
	cnlfPPdmnIoXdQiv732bMoBLW0F04NEhzwS6PB0536h4hWlq8eeI18l+prjIIZSjxXN8
X-Received: by 2002:a05:6402:4415:b0:64d:1fcf:3eda with SMTP id
 4fb4d7f45d1cf-658706c6cb7mr2343964a12.22.1769425182768; Mon, 26 Jan 2026
 02:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126055406.1421026-1-hch@lst.de> <20260126055406.1421026-3-hch@lst.de>
In-Reply-To: <20260126055406.1421026-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 26 Jan 2026 16:29:04 +0530
X-Gm-Features: AZwV_QiJFF4lmS5bLHeIfBkzmZWxYPcftNw7YhZNZGQ56W_tH3yW56RnEjWskS0
Message-ID: <CACzX3Au+grRcDxYp1Kwd418+OgJdN8=mdB_DrSRvphP9KqW3LQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] block: refactor get_contig_folio_len
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

I sent this on the previous version, but FWIW
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
