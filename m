Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1513D243;
	Fri,  5 Jul 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182226; cv=none; b=dWP3GQ8YHqVOTZesBWBvubpM17HGkpii/deT4hDxwh5+KMx0UBhbOHQmVpzn3IX5io09F35nhYj7Ep1E92xc6T26Dh5izY+VlxC7WQQMkoUyMBQ3sQapAVrYbxCioiPz/q+qfuvPNvujIR3JtWujSjJLcsuwQcA/sTHH2V1XRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182226; c=relaxed/simple;
	bh=4XWOLzZTtH1fsJi6Y4mSeBKBITXTtuDOPNxPhYKQZj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWcjvxMKPNjxKllePoH5LP4V9py6YPD4+22uX/7EFzbJSzmoNxtxANq+ITRMyZYi6YT9+29w8YoRRP5EPCBNUElptWdWjliYcMM+Wpydelt+n+SM1tShJ0zL3eh3wK7TU30yE6OSzG+L50o1zF5rKeVrAxlxGimrh285MEzIGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNG0+Z1x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXFGCH6t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNG0+Z1x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXFGCH6t"
Date: Fri, 5 Jul 2024 14:23:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720182215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmdQ9W5UznoY2Do+sTBd4x5mIEK/S3AKOxbdEub+S/I=;
	b=ZNG0+Z1xvp3kLitxsJ0nPdD1HmNoWWTxwFdM9/02U2ENC5POTcN+0JsZxdLQoFiy2RvoV7
	LtydAD0KZ742sPMF0ZgoBx6KzE2haIc8zyN4ur0BH3RsTeKspET0gRBcoCPxsbYwjmGv2i
	9CM/UIFAkkmmuLLvVjjc4qxK3MveXRHUhi+ifM8m6dBvzpWwK/DtVUJT98GEm1zp9ihQIu
	MpIzKSdv9ahT3J6qg06pBjvu7MY3b1SQOb0TQQuVRgZ4VTmyKZdR/YdIDKfyde0otQd0YS
	KJk86zAICPGFVIph5Xa56Pd5EJTsrkBnaBHE8mCjTgaW0zZkd4oQbqDUwlX7LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720182215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmdQ9W5UznoY2Do+sTBd4x5mIEK/S3AKOxbdEub+S/I=;
	b=WXFGCH6tYwKk5WWS8LBYbtNuPfLcfMmSnPNUchURaoYED8eIpMiS8KxyWyZkaGHXsRHdJV
	twrhik58moGSFFDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240705122334.j8mJcj5V@linutronix.de>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
 <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
 <20240704121908.GjH4p40u@linutronix.de>
 <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>

On 2024-07-05 14:02:22 [+0200], Alexander Lobakin wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Thu, 4 Jul 2024 14:19:08 +0200
>=20
> > On 2024-07-04 13:38:04 [+0200], Alexander Lobakin wrote:
> >>> index 3acd7006ad2cc..036845cd4f25e 100644
> >>> --- a/drivers/block/zram/zram_drv.c
> >>> +++ b/drivers/block/zram/zram_drv.c
> >>> @@ -57,19 +57,34 @@ static void zram_free_page(struct zram *zram, siz=
e_t index);
> >>>  static int zram_read_page(struct zram *zram, struct page *page, u32 =
index,
> >>>  			  struct bio *parent);
> >>> =20
> >>> +static void zram_meta_init_table_locks(struct zram *zram, size_t num=
_pages)
> >>> +{
> >>> +	size_t index;
> >>> +
> >>> +	for (index =3D 0; index < num_pages; index++)
> >>
> >> Maybe declare @index right here?
> >=20
> > But why? Declarations at the top followed by code.=20
>=20
> I meant
>=20
> 	for (size_t index =3D 0; index < num_pages; index++)
>=20
> It's allowed and even recommended for a couple years already.

I can't believe this=E2=80=A6

>=20
> Thanks,
> Olek

Sebastian
