Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598498002F
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654426; cv=none; b=M566ITk7knmg+YUojrTibrGSd2aXLvtW8nauKWxDrvx2533YEYkOWb2tPMoTLGP5kA0oNdXE2TNY6UkQU+a2Zg3TM8iaFL2EL3BRsoV+pIh97KiAlnF9vSXWsSazojOQ1xq6s/xRTk7chpdpco0i0+lIdijShVW5RgM/2rwL9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654426; c=relaxed/simple;
	bh=I7zp2tD2WhsFvUy4kUyxvtkXSiLcPdf9F79z4XLJEPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UorBPww0K0tAYRiZFaeH0usvzw02qzUaTtLSnLflk+DT4C9tEt8ihpEbfrDK8uRgmzCctenzosxYHfUjF7+W0JGGLaiLHlqA7kxlL830WP4qxgvgwqsIAbGmx0mGfQxokf+7ntIJPFh26FnpruPMSMVg4g01EUDB4WjsUr90SPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50EF4227A87; Thu,  2 May 2024 14:53:41 +0200 (CEST)
Date: Thu, 2 May 2024 14:53:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
	willy@infradead.org, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Message-ID: <20240502125340.GB20610@lst.de>
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com> <20240430175014.8276-1-kundan.kumar@samsung.com> <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317ce09b-5fec-4ed2-b32c-d098767956d0@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 02, 2024 at 08:45:33AM +0200, Hannes Reinecke wrote:
>> -		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
>> -			   fi.offset / PAGE_SIZE + 1;
>> -		do {
>> -			bio_release_page(bio, page++);
>> -		} while (--nr_pages != 0);
>> +		bio_release_page(bio, page);
>
> Errm. I guess you need to call 'folio_put()' here, otherwise the page 
> reference counting will be messed up.

It shouldn't.  See the rfc patch and explanation that Keith sent in reply
to the previous version.  But as I wrote earlier it should be a separate
prep patch including a commit log clearly explaining the reason for it
and how it works.

> That is not a valid conversion.
> bvec_try_to_merge_pages() will try to merge a page with an existing
> bvec. If the logic is switch to folios you would need to iterate over
> all pages in a folio, and call bvec_try_to_merge_pages() for each page
> in the folio.
> Or convert / add a function 'bvec_try_to_merge_folio()'.
> But with the above patch it will only ever try to merge the first page
> in the folio.

You mean bvec_try_merge_page?  The only place where it uses more
informtation than just the physical address is for the same_page
logic.  That beeing said converting it to a folio would still be
a good idea and a good prep patch.

