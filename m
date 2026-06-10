Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5E352C35
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068928; cv=none; b=MtGCcJ6uCsMti4+2FFHqQz94+fDDFsSfNtrzXxPtDw803+YGvxT1OdoY4RW5/lLMoLcKHEtDWFyFEYI7N4kB6FVADDDNdaJx39wa6anQz8BeHidVSEtIS9oVEnBNY9U6GnuPIUOFrnIXPJbk3TCWZ/tMCZJGg+tLouEghBoo+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068928; c=relaxed/simple;
	bh=fgHvYoOIH04nnXg8e7RZLm6muPK/7yOdq5o8darB5ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfW+wPxU39GHT4hE4QwgzvX4BR1qk/+K1luNIlPdSq6xm7aLMDMhAZKrTQdEGEt1iGWrUE5w+oZR7hGF0SZ4naFwBVTaT3XKqUyPu0c+KIMVbnSvL1F/SHNeYKw1Qjzy7+dUHBduHndpknQwyI+WVOsHJOPKbfSbXRqb3ceeqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LtX7DfOh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LtX7DfOh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PB4SNcng19pT2atsiRFkvnoh2HZMmxuWbSfm013Pcws=; b=LtX7DfOhpoNd85mKA7AIRxBrKM
	NHmaBYx6NHkm++GMcIvNLJsFA24d0MOhHOkTa9XDfzDx746bF1g115fnBwCd7TOdm8oQoF/lVMSOA
	qV5JR41XxyZigFci9R0+bwV3okMdZPvaHU6YFPxEH590BPqpo1TThGXiEvcCzRWaT+U3I/8RoblAZ
	chSRnuizfqASUpcHh83XqR5pSDnp7hhM96oNR3nIWMGbOF6sM01kuqJwmjTYN8GoAPYmJmpS4IaKI
	wyxVR1+Kc5FVGpfdrqSD3QIK0vxa028IY3SXQ8NG5dyQWuIEjL5FNKy+TUAKSrVghEC+zSirLB2Fo
	FI+Nthng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBOA-00000006opi-2RDa;
	Wed, 10 Jun 2026 05:22:06 +0000
Date: Tue, 9 Jun 2026 22:22:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 09/27] drbd: Split drbd_nl_get_connections_dumpit()
Message-ID: <aij0fuVz_Bxi6NXi@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <167a1fe9f633fe1d1a0d89a50f10c3185d9ddddd.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167a1fe9f633fe1d1a0d89a50f10c3185d9ddddd.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:04:56PM -0700, Bart Van Assche wrote:
> Move the code between the 'put_result' and 'out' labels into a new
> function. Prepare for making the following code unconditional:
> 
> 	if (resource)
> 		mutex_unlock(&resource->conf_update);
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/drbd_nl.c | 98 ++++++++++++++++++++----------------
>  1 file changed, 55 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index c44b92856da3..57ab1f1fb1bc 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3529,15 +3529,56 @@ int drbd_adm_dump_connections_done(struct netlink_callback *cb)
>  
>  enum { SINGLE_RESOURCE, ITERATE_RESOURCES };
>  
> +static int drbd_nl_put_dump_connections_result(
> +	struct sk_buff *skb, struct netlink_callback *cb,
> +	struct drbd_resource *resource, struct drbd_connection *connection,
> +	enum drbd_ret_code retcode)

Weird indenation here.  The usual style is either lining up after the
opening brace or two tabs.

