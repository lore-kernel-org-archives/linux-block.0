Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75AE1EA71
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855482; cv=none; b=qxoGQJJ5zJQLSsMRD9EIHtJRUBOdybBY7x8KXxmwVGZtDoDgfEs/81aStlHw5Pxra3rROvAryN8YK1kajMLy0xa3vr3sS0Y2Kdqm+5SBlJdm+qn3Vq9I6C3MR+PgFVGb5kP6VJZ6XFKZJ9QQzf3X29GtjTRoDhI0XTdIQot2XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855482; c=relaxed/simple;
	bh=88ZGe9r1kxdtsGPLmyOkOKqP8kNu5/NKy8s96DL17u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abLjOxcbc/5IoB3rE5ZuQDr5/D/j4RdUQ3+XIVF8FqDzSKsmMTI2IdKwfGUazvYjk6/+Tfmil5qFbxSd0w0ZnJpUPqeW5fD3abIpkKlA6rbaqcT8jnVGrk1GcSFljNzpG6WV8pik5IfXNAyE85AoQxST2acBbfE1XZ4JZ6UF+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vW0n6jWa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vW0n6jWa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=54P+3nDcZAzEbZfrdRNziWsu2PD2G5jDHxJBLukxBPE=; b=vW0n6jWaBDhtjWLqxRZNXaO9u0
	E0GB3A2ciZY1MNmotzh0UMIhFvrg4bvNCxulPDv+cRmpzcO6WepModBx7msM1flUgAT1ydkjTSrpC
	YiC9pS/olnuZetganWOMbmNNJle2ahljyXvISKrNd1h7MctgfyUraNvo0xHbkeYGUgY2CWp9YnA/H
	rc0A5D2Z/bd8RsFq1KGNZPBrXZ9/978a6Py2BWAyn0DTOr6APe/JSN8XmfREeP9JjrVMXxOu4Skxj
	uWeoRXUrE9SXCnM0mK3mH3covzmZmdmN/jkLYAAMh2MQnTPJYjwySaFykMx/orJSGYl+irT5V1Vqm
	L//78hlA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK8pQ-00000005ZCP-3UmB;
	Thu, 20 Jun 2024 03:51:17 +0000
Date: Thu, 20 Jun 2024 04:51:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 3/3] block: unpin user pages belonging to a folio
Message-ID: <ZnOnNAdDl_jM1k8G@casper.infradead.org>
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
 <CGME20240619024153epcas5p4fda751acf693081824c7f1f279988f65@epcas5p4.samsung.com>
 <20240619023420.34527-4-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619023420.34527-4-kundan.kumar@samsung.com>

On Wed, Jun 19, 2024 at 08:04:20AM +0530, Kundan Kumar wrote:
>                 if (mark_dirty) {
>                         folio_lock(fi.folio);
>                         folio_mark_dirty(fi.folio);
>                         folio_unlock(fi.folio);
>                 }
> -               page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
> -               nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
> -                          fi.offset / PAGE_SIZE + 1;
> -               do {
> -                       bio_release_page(bio, page++);
> -               } while (--nr_pages != 0);
> +               bio_release_folio(bio, fi.folio, 1);

... no, call bio_release_folio(bio, fi.folio, nr_pages);

> @@ -1372,6 +1364,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>                 } else
>                         bio_iov_add_folio(bio, folio, len, folio_offset);
> 
> +               if (num_pages > 1)
> +                       bio_release_folio(bio, folio, num_pages - 1);
> +

... and drop this hunk.

