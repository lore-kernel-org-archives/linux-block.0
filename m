Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30619066D
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006620; cv=none; b=OEscefy1nIousDdEcGhGtG4Tg6AOiPHPOMAZYfTx0JcqyT0sdqehlEd6Zl2TX2L71TTKs0EGfUA5LmhhaF+IhDoU7HRLBGaPWVSpW16h68LfeZRkb1lHumV3JYDZWYs47cMO9KA2fuW53yvzDvzaq0RBrWwYkjqq57ti+8rHPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006620; c=relaxed/simple;
	bh=sctDNsyuv9JKx8f9JWTE6veXrsUE29ucg6NZEwONPdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkNfLxQEnBkrxo5Y3mp5TLO6PXgu9TASeeu5miFvbRn1P3PMEQZ2//C+ue3CIA9KQITKOVPK9AxyrEzJKyIjb296k/HvkdjQn+wavzRV8ur6PjQs0uywNDhtQF6DbYTeLQRCQEeNqR7F5V1g3KrK80WWuKJ9sLdOJi9jo5q5vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=SGQ+hY5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zHTWgYvq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="SGQ+hY5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zHTWgYvq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 073391140103;
	Mon, 27 Jan 2025 14:36:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Jan 2025 14:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738006614; x=1738093014; bh=0L1mt8TW1+
	VI6Bf4XILI8+bzfSFIatHw3GOQUrulDzM=; b=SGQ+hY5HX4pfkhMuj8WFreEHi9
	9pFChSANpT4NrYdSV5GTs22L7ZQccc33VcyTPn9U5vVkzhrqnyc0Ei53FE7KZFzO
	Op3+XzqgQvxIrB8bnPfUXjg1ZSxhCPuUAR+4iTtRs3on8565FFQCWxikzqazvqvw
	iBhArA8NpnSCLYccbLmtitc9mE4bvzBmPNgMCHsDE7UazlXjhV/sfrs8gih04q/h
	rRqE7V54OYUMA7U3xrsr55tgH4SjRFiIcoT9KaSH3W5A8E2ERTLk/2D5IBByVFNG
	BRD8Ra06bX8xk4soCNO41iIpgY5bygNTCEv21PxxeF2CfRy9kAedmxUpKrRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738006614; x=1738093014; bh=0L1mt8TW1+VI6Bf4XILI8+bzfSFIatHw3GO
	QUrulDzM=; b=zHTWgYvqK+tADyWEjSVexkdlxfNbZFxtPzyL3JCqJK1EZpVmF1D
	rxhUDOIGlyOhOY5bSBDJL+o7O25gkro7H9sXeSsgoC1sWN20t0832CtVXYHwCmkv
	qLZq4OTCQA4vUA1Ek2hObNHkTj2aaWUkIeFUCt854jNP6Qe0L6YBvjZ4eQsucFDQ
	voZfiY2cg1RTUV3XLF1QBeaRuUvwHQBJnSJU5zssUYz4KWZ2TWlqS+hhR6/pmaWg
	MKpZqYcvtszDSGRLaYjeiJ6uBjN0H6mkexAA7Jqe2UpzQM9IaKk8RWhqbVv2MLgR
	GpO9JAwXIRZOe7gn2kj9VlC5wMdiSZlP6DQ==
X-ME-Sender: <xms:VuCXZ4c35K6xcNb9p5jUpoahaI0tsAKb8IUYN2fqONeSQggbD_LsEw>
    <xme:VuCXZ6MKeQuPq0XurUASZCbgRuca5qYWlHGanO11gicO4qsUifItrBpgc_VhdhKw9
    01fqW56y5EA3wvKYw>
X-ME-Received: <xmr:VuCXZ5hRvME6togS2GbcO88QGr-x-qz5moU59HSlFq5VoiDbR06u67g00Wz7MKZgWnPqovNlwaumtYGTCepBqoRWpAr87XbKGehZPSLU4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrg
    iivghlrdguvgeqnecuggftrfgrthhtvghrnheptedtkeefffeuudeufeeiffekgeeujefg
    teefvefhudegleehieeufeffhfehgffhnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgu
    rhgvshesrghnrghrrgiivghlrdguvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehmuhgthh
    hunhdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhgvrdgthhhuseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VuCXZ9-5gPufSUzEWhow-XMz_x-_1hMKOYixmkuvpfuukYlhz3Wf8w>
    <xmx:VuCXZ0tCpbRAJPvA7NcBcHMRuJiSH_kDLLF3nFIRJ5L2bxtF7QLQ6A>
    <xmx:VuCXZ0E49wsALq1LUa2N0zE45JxYtJX16kutNhquKpVZlMIAC8fLmA>
    <xmx:VuCXZzPrVuHM5RuiNKLfnEL-mA3yyW10X0YNUzwyZImiuLkDrodQIg>
    <xmx:VuCXZ4iM-qS_usA7L-e9M3J_Y2EHxjm36HWZ6GpVWBPgBXeABSBobdkj>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 14:36:54 -0500 (EST)
Date: Mon, 27 Jan 2025 14:36:53 -0500
From: Andres Freund <andres@anarazel.de>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, 
	Jane Chu <jane.chu@oracle.com>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <dj45nz5vspupjdeig53p6ynn226fzwfrj5ee2orfdu2q3krhpy@fff6c2poz7bw>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
 <w7vcs35omcdqkaszcc6fzvakzdoqkzjwtvdsc3lelcnjgzytib@siim7yk4qjrf>
 <4a75d25f-bcb9-42b6-aa9e-1e63e4be98e3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a75d25f-bcb9-42b6-aa9e-1e63e4be98e3@redhat.com>

Hi,

On 2025-01-27 20:20:41 +0100, David Hildenbrand wrote:
> On 27.01.25 18:25, Andres Freund wrote:
> > On 2025-01-27 15:09:23 +0100, David Hildenbrand wrote:
> > Unfortunately for the VMs with those disks I don't have access to hardware
> > performance counters :(.
> > >
> > > Maybe there is a link to the report you could share, thanks.
> > 
> > A profile of the "original" case where I hit this, without the patch that
> > Willy linked to:
> > 
> > Note this is a profile *not* using hardware perf counters, thus likely to be
> > rather skewed:
> > https://gist.github.com/anarazel/304aa6b81d05feb3f4990b467d02dabc
> > (this was on Debian Sid's 6.12.6)
> > 
> > Without the patch I achieved ~18GB/s with 1GB pages and ~35GB/s with 2MB
> > pages.
> 
> Out of interest, did you ever compare it to 4k?

I didn't. Postgres will always do at least 8kB (unless compiled with
non-default settings). But I also don't think I tested just doing 8kB on that
VM. I doubt I'd have gotten close to the max, even with 2MB huge pages. At
least not without block-layer-level merging of IOs.

If it's particularly interesting, I can bring a similar VM up and run that
comparison.



> > This time it's actual hardware perf counters...
> > 
> > Relevant details about the c2c report, excerpted from IRC:
> > 
> > andres | willy: Looking at a bit more detail into the c2c report, it looks
> >           like the dirtying is due to folio->_pincount and folio->_refcount in
> >           about equal measure and folio->flags being modified in
> >           gup_fast_fallback(). The modifications then, unsurprisingly, cause a
> >           lot of cache misses for reads (like in bio_set_pages_dirty() and
> >           bio_check_pages_dirty()).
> > 
> >   willy | andres: that makes perfect sense, thanks
> >   willy | really, the only way to fix that is to split it up
> >   willy | and either we can split it per-cpu or per-physical-address-range
> 
> As discussed, even better is "not repeatedly pinning/unpinning" at all :)

Indeed ;)


> I'm curious, are multiple processes involved, or is this all within a single
> process?

In the test case here multiple processes are involved, I was testing a
parallel sequential scan, with a high limit to the paralellism.

There are cases in which a fair bit of read IO is done from a single proccess
(e.g. to prerewarm the buffer pool after a restart, that's currently done by a
single process), but it's more common for high throughput to happen across
multiple processes. With modern drives a single task won't be able to execute
non-trivial queries at full disk speed.

Greetings,

Andres Freund
