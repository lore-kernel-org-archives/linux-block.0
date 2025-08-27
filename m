Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB726AA91
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281146; cv=none; b=PLSiBpGMLnivxjDRnGwsFGDcCsPYH+HGF6hXnk/1TMKwvouQqg6QJsxrvXyjBNWqxbsT7wg6Me/6bYKlVIz3HAu4vz39kksuehVbKXl6CbIfF91bylIEdnFtrexab3OjT8myp+RF0PTQLKZ9QcobqJVdPoWV5wmifOjCA4oSeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281146; c=relaxed/simple;
	bh=4uPPDQQxd3husst5QshnzYZ0fTVT2ZE8qOm1D3VAY2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwTq6hdM0G80p7WL6B939tWtPJSchEby64wBc5JFfDxYyNmgJvBMS1KYIWkuhmQ8QbbHRNtRFjDs+fnTs/Rhpif+dgk32qNuhPhUyqyWL5ibrFftEN7ImloCJNOwrRIz5n9JVMt+zjhvDIYBtna4CkDVyBzqKOC5BvWrRes19Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/PMIxL9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EuoXTnYz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/PMIxL9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EuoXTnYz"
Date: Wed, 27 Aug 2025 09:52:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756281142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjtewYJQj4hxsuqlXsBQ4Q4sH4wZuH/23qpVs4gkPWg=;
	b=T/PMIxL9PqXwZj7qcsKkp0ghx8CN1PxvmU0Jj2Mq+j+oFJY5Z1oH3xHuhTWfKlY1jVlbq5
	rklgfyv4CHtdke4wJUr2DBFkbjQlFDW8yBSOL1yJrX/5vtMDDqd3J3+PiCBqaSWbQoB3nt
	id1zvGx+zmz7RPfNSZp6vS9WPm/fsJ7SL9bAGcEXhsybsbGLhGutqab6df0jacMX/snz9z
	2llrlPlwv9JdBYxU4Oeuwye8JX5AHnJSi2lnfaOn47V0XNhrFaudU4hOtxt+iZ+7MvYNXb
	taNurSdSKfR/gxvmcB084JnZdJC/zoogScs7yTrNJGfXqRe+cujJ8sgGg9zOtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756281142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjtewYJQj4hxsuqlXsBQ4Q4sH4wZuH/23qpVs4gkPWg=;
	b=EuoXTnYz5V7qyFFeEUU1aV4/2F3RQbNEVEQdAO3tqq3i6ABAgZrdYwo1UgOe+gC0DZnDlK
	Vu/cTfbWtgkmU9Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250827075221.6hTi-i7m@linutronix.de>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
 <20250827070705.4iWhHGPE@linutronix.de>
 <20250827073836.GA25169@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250827073836.GA25169@lst.de>

On 2025-08-27 09:38:36 [+0200], Christoph Hellwig wrote:
> > Did I forget to update firmware somewhere or is this "normal" and this
> > device requires a quirk?
>=20
> Looks like it needs a quirk. =20

Just wanted to make sure I did not forget to update firmware somewhere=E2=
=80=A6
It should be easy to fix this one the firmware's side (in case someone
capable is reading this).

>                               Note that if the above commit triggered
> this for you, you could also reproduce it before by say doing a large
> direct I/O read.

On a kernel without that commit in question? Booting Debian's current
v6.12 and
|  dd if=3Dvmlinux.o of=3D/dev/null bs=3D1G count=3D1 iflag=3Ddirect

works like a charm. According to strace it does
| openat(AT_FDCWD, "vmlinux.o", O_RDONLY|O_DIRECT) =3D 3
| dup2(3, 0)                              =3D 0
| lseek(0, 0, SEEK_CUR)                   =3D 0
| read(0, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0>\0\1\0\0\0\0\0\0\0\0\0\0\0".=
=2E., 1073741824) =3D 841980992

so it should be what you asked for. Asked for 1G, got ~800M.

Sebastian
