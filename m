Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F52D94AB
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011036; cv=none; b=HHqOUVqUgwn/sTughvWj557Tf2/IxJolZbTMCDoswLIMpGUwb5i6OeF6Q25g7beRECI3gXkAoxPhIFchGtJ6HEUYL92QqGR3NEWBlt75EGppKTQn5YFd0NU8K/lUBlrNVTY8ZSO0femj2aVXYyYmRGi8VtP0txdS++E2xE0giak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011036; c=relaxed/simple;
	bh=CPg5W6qmv3QeO/QThKytexmCzra9QCkoXU0qYXhgnRE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cEtO1d9XsXvPyorrJ+UrX5mIM9TxYnlkVYGtiOO34FKCUuUswKC5++EGh5CZtjkumZRBcTC937kmuiC8J1qsTc8QndHeN76FUoIeisZsTFhcqU+j5s/1gpuL3o+fGSoLsGvnDmMCOtL1+QIftrKUQ28MosePqxGe4S5N2AsQ4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IJNiVaMy; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IJNiVaMy"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780011022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D4wIN4SNHRitM0ngarezIhOM5acJEbDG3qSyZyguPCI=;
	b=IJNiVaMyTnO0R8z438tXxUIihVO7hXAF28ZbM8NefFkZnYup68YW7NgHHE+Nyox05yyblt
	wTiE2pvjqGpFvYiIgRb16TDhnQNAD6yZOA4HPZ5UdcsdlWOLOBsMWBNqRYfi3L5WkiZWy/
	E2+R14LJHOe2EQ20LJ6nT+g2NW9i/cU=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 0/2] Add bvec_folio and its kernel-doc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: William Kucharski <william.kucharski@linux.dev>
In-Reply-To: <20260528175905.1102280-1-willy@infradead.org>
Date: Thu, 28 May 2026 17:30:07 -0600
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org,
 linux-mm@kvack.org,
 Leon Romanovsky <leon@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FADCC457-872C-466E-82F8-F88DF03E54F0@linux.dev>
References: <20260528175905.1102280-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

For the series:

Reviewed-by: William Kucharski <william.kucharski@linux.dev>

> On May 28, 2026, at 11:59, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> Add the convenience helper bvec_folio() to avoid references to =
bv_page.
> Convert a few of the obvious users.
>=20
> v2:
> - Tweak the kernel-doc (Christoph)
> - Add the bvec kerneldoc to the documentation build
>=20
> Matthew Wilcox (Oracle) (2):
>  block: Add bvec_folio()
>  block: Include bvec.h kernel-doc in the htmldocs
>=20
> Documentation/core-api/kernel-api.rst |  1 +
> block/bio.c                           |  6 +++---
> include/linux/bio.h                   |  2 +-
> include/linux/bvec.h                  | 17 +++++++++++++++++
> io_uring/rsrc.c                       |  2 +-
> mm/page_io.c                          |  4 ++--
> 6 files changed, 25 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.47.3
>=20
>=20

