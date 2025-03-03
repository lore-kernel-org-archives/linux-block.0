Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136C212F9A
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012030; cv=none; b=o2E0wXOwkcAgtXVf+ZhE8of7PTZRLq3lz7FPdhxjJalrYaAe1V1kj2AjLMzb/O5KPUvkAY5f0kylpVxHLbZR3qJ+/Hu9CQODbIL+NznGUGLmZSMch67v4aZZi5qbjc+Z28kOVBm+nXCUGCGyNUebdwcgWVuLDIH2sQOpKcB2IV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012030; c=relaxed/simple;
	bh=I+hi7XDRZ4W76+VsoDDoSOLM1AIqxGKnTuxOsK5AC7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYH56VvitnBVbUujt1b3sPIRcv0zHUjFFbrvC88jPlv08tbVFdZ7MhzseYkWTW3VenioF5+RfJqWTBeECS35h8Vly6aQEf6fjcMfP1COPEi0YAJAutzbSUAnc5Cs+an8T6/syb4gWxp5s6IBE/S2/k/8W+VEMddae35z0agMhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jpeDY1sd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jpeDY1sd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PTzadO2DnckvRJ6jl7j+mB7ira4oDWZGsSy/iOCEG/E=; b=jpeDY1sdsl7kdGEJjFfCB8tVfI
	rpzWNIEMkPCYt9vCLtKaZ7RzjBk7/QIkx7YExiVJi3aR1tXLj15uRKWtufG8fVXJQOIvTrH+S77Ra
	27MoDAoLk51t9BBE+VNq7e8zZ3rzh1Zd6cUNrgbO8wQo+ef/Ovx4eW2DoHNPgfGh4x/xN5NEuMqKG
	O5Mnvnfo2wEj7aj1i7PufG3faSwYi0WrIkYaq59bUAT1ESdRwxYbgAx3AYYQ39Sr5NljXJ0ZiArD/
	FaRPqJCKRQEPFj4WPyAkD3CMDrxcypdnQ75u6B4lA5aEwgCBOBkSNPcKWzmPG6hXvfm/REohuVoxj
	r8O8RoOA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp6l8-0000000Bkxo-1gBn;
	Mon, 03 Mar 2025 14:27:06 +0000
Date: Mon, 3 Mar 2025 14:27:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8W8OtJYFzr9OQac@casper.infradead.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>

On Mon, Mar 03, 2025 at 08:48:09AM +0100, Hannes Reinecke wrote:
> On 2/28/25 11:47, Hannes Reinecke wrote:
> > Hi Sagi,
> > 
> > enabling TLS on latest linus tree reliably crashes my system:
> > 
> > [  487.018058] ------------[ cut here ]------------
> > [  487.024046] WARNING: CPU: 9 PID: 6159 at mm/slub.c:4719
> > free_large_kmalloc+0x15/0xa0

That's:

        if (WARN_ON_ONCE(order == 0))
                pr_warn_once("object pointer: 0x%p\n", object);

And while the object pointer is obfuscated (hashed pointers), this
wouldn't be helpful in trying to track down the problem.  Perhaps
we could make this a VM_WARN_ON_ONCE_FOLIO() so we get the dump_page()?

I'm tempted to believe this is a double-free, but then I'm not sure why
it'd be triggered by this patch.

> > [  487.296801]  kfree+0x234/0x320
> > [  487.332084]  nvmf_connect_admin_queue+0x105/0x1a0 [nvme_fabrics
> > 34d997d53c805aa2fae8e8baee6a736e8da38358]
> > [  487.332093]  nvme_tcp_start_queue+0x18f/0x310 [nvme_tcp
> > 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> > [  487.332102]  nvme_tcp_setup_ctrl+0xf8/0x700 [nvme_tcp
> > 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> > [  487.394495]  nvme_tcp_create_ctrl+0x2e3/0x4d0 [nvme_tcp
> > 68f6be106f52ac467179f8a0922f02aeb6fa1f1c]
> > [  487.394503]  nvmf_dev_write+0x323/0x3d0 [nvme_fabrics
> > 34d997d53c805aa2fae8e8baee6a736e8da38358]
> > [  487.394514]  vfs_write+0xd9/0x430
> > [  487.551642] object pointer: 0x00000000346cb6fc

Oh, wait, that's not the crash!

We continue to free the folio.  Even though we hit the "can't happen"
case.  That's dangerous.

> > [  489.405197] Oops: general protection fault, probably for non-
> > canonical address 0xdead000000000100: 0000 [#1] PREEMPT SMP NOPTI

I think we all recognise that as list poison.  I bet this is a double-free.

Or it could be a wild-free.  I mean, look at kfree():

        folio = virt_to_folio(object);
        if (unlikely(!folio_test_slab(folio))) {
                free_large_kmalloc(folio, (void *)object);
                return;
        }

So if you call kfree() on a random pointer, chances are it's not part
of slab, and we jump into the free_large_kmalloc() path.

We have a _lot_ of page types available.  We should mark large kmallocs
as such.  I'll send a patch to do that.

