Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59684D30
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565226; cv=none; b=euClQUCfqd58nBA5jbhbNzJf1OnXRt0nQn7C6NtmVQYHdxmBn7ZF9ADL/bm2WktCjr12HRGdgnZEz27XxCgEO/KzTWKV1elk/z8mRKMBGCv5KLDnqlnE/fdwFtUjxsx3czCl7PWSs4C4CJ+GinkTvWJUfmIe94m/v14UZamMYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565226; c=relaxed/simple;
	bh=EbdE3XB6o7+Elm22BznE243s0h7aDa9RjrtFu6UVpjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWlAtNIc6xddlwocgq3xKlvLU6w/YXAeYJRr5I94EDqB0Kse/HZ1+iHlRnOFpY0T6A0fvFKhSs0KCmFI4AqVLqaxaoynMRxMYHRrkj0o+YYGzoiH5WlQMlW4FKt8Q046oewaHTcEQ4WPoGCXmw42kqFq62yM1pZmkiwpVWD0oFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=No4Vks/R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="No4Vks/R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6xKYxArHR3x/d/R0UV/MerxAijK3RfnGjDoSp4pv4wk=; b=No4Vks/REwglr5iRneC57OBy3y
	IHDmpmm+HObBHkjpk6PpgTrGrTJgzHtSIdkbR2AfZQrFGh4uzkG8o3xfgOxJTYSNwnJ7u9rxBGI75
	5B7AH1zx40OscipoP3uSmYXxGa4WRbrdxeMud72LCAV9U98pguDh9L6pTcNd10xjmQJjNchf8BG7I
	lSzVNKVjLvvA/ApRlJ/WmhemsPFKGr35iQvjw1IL1IxARDGIMV+OCSvW+EdGhqxfZ8TwWjD3pS/au
	xyg31Or5hxvcRbcmeu1tzAlOtJAfukRt2WEPQBq45B23zM33BnyqWlc1jgy+sx/mkME1LMao5XWvV
	+m7AFNqA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAX1o-00000002pZj-2gWL;
	Fri, 24 May 2024 15:40:20 +0000
Date: Fri, 24 May 2024 16:40:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v3 2/3] block: add folio awareness instead of looping
 through pages
Message-ID: <ZlC05KHAB7tswaQV@casper.infradead.org>
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
 <CGME20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063@epcas5p3.samsung.com>
 <20240507144509.37477-3-kundan.kumar@samsung.com>
 <ZkUhPoWnvxPYONIA@casper.infradead.org>
 <20240524092231.pijr74qryxo5fazk@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524092231.pijr74qryxo5fazk@green245>

On Fri, May 24, 2024 at 02:52:31PM +0530, Kundan Kumar wrote:
> On 15/05/24 09:55PM, Matthew Wilcox wrote:
> > On Tue, May 07, 2024 at 08:15:08PM +0530, Kundan Kumar wrote:
> > > Add a bigger size from folio to bio and skip processing for pages.
> > > 
> > > Fetch the offset of page within a folio. Depending on the size of folio
> > > and folio_offset, fetch a larger length. This length may consist of
> > > multiple contiguous pages if folio is multiorder.
> > 
> > The problem is that it may not.  Here's the scenario:
> > 
> > int fd, fd2;
> > fd = open(src, O_RDONLY);
> > char *addr = mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE,
> > 	MAP_PRIVATE | MAP_HUGETLB, fd, 0);
> 
> I also added MAP_ANONYMOUS flag here, otherwise mmap fails.

I didn't test this code, but MAP_ANONYMOUS is wrong.  I'm trying to get
a file mapping here, not an anoymous mapping.

The intent is to hit the
        if (vm_flags & VM_HUGEPAGE) {
case in do_sync_mmap_readahead().

Ah, I see.

ksys_mmap_pgoff:
        if (!(flags & MAP_ANONYMOUS)) {
...
                if (is_file_hugepages(file)) {
                        len = ALIGN(len, huge_page_size(hstate_file(file)));
                } else if (unlikely(flags & MAP_HUGETLB)) {
                        retval = -EINVAL;
                        goto out_fput;
                }

Maybe we need something like this:

diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..7c5066a8a3ac 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1307,6 +1307,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		flags_mask = LEGACY_MAP_MASK;
 		if (file->f_op->fop_flags & FOP_MMAP_SYNC)
 			flags_mask |= MAP_SYNC;
+		if (flags & MAP_HUGETLB)
+			vm_flags |= VM_HUGEPAGE;
 
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
@@ -1414,12 +1416,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		file = fget(fd);
 		if (!file)
 			return -EBADF;
-		if (is_file_hugepages(file)) {
+		if (is_file_hugepages(file))
 			len = ALIGN(len, huge_page_size(hstate_file(file)));
-		} else if (unlikely(flags & MAP_HUGETLB)) {
-			retval = -EINVAL;
-			goto out_fput;
-		}
 	} else if (flags & MAP_HUGETLB) {
 		struct hstate *hs;
 
@@ -1441,7 +1439,6 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 	}
 
 	retval = vm_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-out_fput:
 	if (file)
 		fput(file);
 	return retval;

(compile tested only)

