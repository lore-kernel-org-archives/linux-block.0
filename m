Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D477367287;
	Tue, 12 May 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585360; cv=none; b=jURizSzmJUL/fIjttbnh1kWuXDE0PW2oSHl9bqw9JEO0ppU6jpOKrbtSI3RbKVMqg90H9OCbSTN+0ja5wWlRnc02wqGFtxi53PtvpvzF3KBy6MDbahj43xOxrdByL+KfEPMWGatDblH0thZGodD5slLHTDgjw74hQ74kGf+xL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585360; c=relaxed/simple;
	bh=HBNp/495kypoGoXqHaMGhnTUBtyrQKEUiL4MMW+FdUc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PHtFOmr3AFoCsJD662PJAaU074wKPdRutfOZCT2gJaQFGFQ53ZMB52SFd2M/fknXhu7rgmadmTT7z+fXC3PSWv1vF32HggTRtjFMqnsg9iD2WHfiwKGy/8vWLQo6z6Jt5bHDshDP8LlHgIPE8iOAFG+HyoaS3RVNmZmzUg9PBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jKKG5p/H; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jKKG5p/H"
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5f11:0:640:6821:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id AC894C09BA;
	Tue, 12 May 2026 14:23:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp) with ESMTPSA id cNITP7qRYa60-2hcLO0hZ;
	Tue, 12 May 2026 14:23:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778585020; bh=HBNp/495kypoGoXqHaMGhnTUBtyrQKEUiL4MMW+FdUc=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=jKKG5p/HZ3mQUnc1kDqW40rljuT5KG/YTqx0+s7d0lS0W3m1DfdcHJonJfg5xI6E+
	 NMfxw54YeV4lwLQDTMf3QXWchc8DZ27+neVGz7UlJKmFXE3bQG7xrisq2wkcs8hJ0V
	 6aie521KcjQLGYQ9RRw6g/uNCaBiNcwMUleUJ59g=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <83a30cc552ab939027949dd27f5de3784e248c1c.camel@yandex.ru>
Subject: Re: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
  Christoph Hellwig	 <hch@lst.de>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, 	lvc-project@linuxtesting.org, Fedor
 Pchelkin <pchelkin@ispras.ru>
Date: Tue, 12 May 2026 14:23:38 +0300
In-Reply-To: <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
References: <20260508111329.329943-1-dmantipov@yandex.ru>
	 <CADUfDZpC5WOBY4_xvAy6ORtgQsxwFYj3Px81RdN7NKQZBFdJSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 11:33 -0700, Caleb Sander Mateos wrote:

> Callers seem to be inconsistent about whether they treat ret < 0
> or ret <=3D 0 as the error case, which is another argument not to
> handle freeing the pages array inside iov_iter_extract_pages().

Hmm... looking through iov_iter_extract_pages() innards, ret =3D=3D 0 means=
 something like
"no error but no data for further processing". Using iov_iter_extract_user_=
pages()
as an example, iov_iter_advance() is not called if pin_user_pages_fast() re=
turns 0
and, since the pages array won't be touched anymore, it may be freed safely=
.

Dmitry
