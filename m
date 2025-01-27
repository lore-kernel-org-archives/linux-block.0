Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128947DA6A
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737998722; cv=none; b=IZI5pjvCXVZ5qhmzK3aLw57esqBmFiCjbAgF2hcg+RDP13rWDOibX/KQ7LZaT7Njeyu3Dc+H9506SD83Sb0QFtAFavVeBx/XhGiwXAMZ51Z+DO7KjIC61YIgYS5axVIS1NnCVsMXZrPgDzqaPp1YtuqEbXybnQY2TAVinzoWWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737998722; c=relaxed/simple;
	bh=m4tHMqWDa29Ehksob8WbAa7k7Gs6sVVn8cGBUcLECgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1anAjXOjRolTkbsnmMWsfo6ghgxFl7SNLK8MoIUqxMZ3/r8Qh8FCUArGfEhlwZwNwDkKj7n1Zf436TkVq+MQUmI1+sl6LdlERhdL5A17cmDxULAYKYdlTlow7HdZ4k/yz8ba1Uz2ldRRY4NDwM6NJjRZzu3x7CfJ04QwNH7Bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de; spf=pass smtp.mailfrom=anarazel.de; dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b=I0ao+zjY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8GQumNm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anarazel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anarazel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="I0ao+zjY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8GQumNm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD70025401B4;
	Mon, 27 Jan 2025 12:25:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jan 2025 12:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737998716; x=1738085116; bh=jItTkK19lV
	rEaaQasijWB0BlZX8+jCdh2zngJoStwo8=; b=I0ao+zjYmvuc/70tU5DtbL1CJk
	w96cHTrEsqAqtoBCe/zo9UfLyPKSC0UcEjixFcb9YZb/eZajYk47/UGvMgo8EnmS
	pWSgxtzwG+XASXhc2n87zHT9sgx9eRjYkDosDyTWET+TM8lnAK7VAxdTYaIZjBmK
	/zrEyeTAzz6noE0VmK8REQHcwJ6fycST/DxjJIYv5olyy0aqF3LJT71c5V7PILcu
	KfY8GudeOPwDgnFzggnkPSD6VGHh7NexiaFA/1R8TaqBHDElZDVYccJkrSkEBFZN
	FkeoAgkUXoczYnfeabmxPJbwOO/ZfYPKJmqd+jhoUxgg2uEmeBo/OBEV9d9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737998716; x=1738085116; bh=jItTkK19lVrEaaQasijWB0BlZX8+jCdh2zn
	gJoStwo8=; b=e8GQumNmQyKTSxhFe3KlzodP1Cc6vSWTt4Oi1o8hr5wr09N/Hb3
	+kbEU88ill/wydNq/WQ/KFv6RYbHKZW6W6S/gm1lTG4QwrPALHiD/qx0li6TL3Pz
	2gfSMVxJTR8MG0RfSI5VlQHI6BWzgEeGUSGD4c4ClcJuEW1N2xg/Dzbf0ryyy/PE
	gRRHmWFcbwK8SUX+TuLtE3mvN00sg5Lz89OaIZ3kOg8DZsFCnkJ7GvNV/+V0Hgx5
	qkXaGH2y2CGCzA8Q6v0J0eDeVeGfFK7nWQB6NRCCpSwI+fc3/hfa1FKdbGy7iS7U
	IfkWU7PyAkxFo1mGl84lDe+uixbi8pPQnPg==
X-ME-Sender: <xms:fMGXZ0ejR8-bdPfyZmfFdMkR1ahIYYyTPVcEwuk7vyXl4OQJaDmCjQ>
    <xme:fMGXZ2NrnP1Ch7gUlMOy2AQ6Vssx9d1ctV2QMuqMqFwnVZYWKEGsvVIqSeFOk7SzA
    ZRZgoaXV0j01g71Fw>
X-ME-Received: <xmr:fMGXZ1gDuVSc_Uq9b-hyc1BGCqfRKrKowav-TeC63p6jXC9nK-2vkaG7nxEfa1-E7yuQ7lnIzkwCjBO0YMH4h26e4Simax6linxDUY71ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefjeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:fMGXZ5_oyvWWE978AfSH-kzgdvBEABVXxKFYg1iIjTGFht7mIi9BJw>
    <xmx:fMGXZwuqO4W0c7dq4q7CtS0GfooD6oJfXwrW_Mag6cA1GFKOnodNVg>
    <xmx:fMGXZwHlNyKP-nEp6C_LrNoUd3d17160QdEm7LaQ-aJT_l6eqEQhWQ>
    <xmx:fMGXZ_P4FDf3XzvbrldEPqBsz6PvJkmdl6E6puyQ3U86wJnPy11R9w>
    <xmx:fMGXZ0hoEHguddYlLP3ldmJ2QTec8j7oRyLFeYyMtex2atEkGJS65AcB>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 12:25:15 -0500 (EST)
Date: Mon, 27 Jan 2025 12:25:15 -0500
From: Andres Freund <andres@anarazel.de>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, 
	Jane Chu <jane.chu@oracle.com>
Subject: Re: Direct I/O performance problems with 1GB pages
Message-ID: <w7vcs35omcdqkaszcc6fzvakzdoqkzjwtvdsc3lelcnjgzytib@siim7yk4qjrf>
References: <Z5WF9cA-RZKZ5lDN@casper.infradead.org>
 <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ba55af-23c4-455e-9449-e74de652fb7c@redhat.com>

Hi,

On 2025-01-27 15:09:23 +0100, David Hildenbrand wrote:
> Hmmm ... do we really want to make refcounting more complicated, and more
> importantly, hugetlb-refcounting more special ?! :)

I don't know the answer to that - I mainly wanted to report the issue because
it was pretty nasty to debug and initially surprising (to me).


> If the workload doing a lot of single-page try_grab_folio_fast(), could it
> do so on a larger area (multiple pages at once -> single refcount update)?

In the original case I hit this I (a VM with 10 PCIe 3x NVMEs JBODed
together), the IO size averaged something like ~240kB (most 256kB, with some
smaller ones thrown in). Increasing the IO size further than that starts to
hurt latency and thus requires even deeper IO queues...

Unfortunately for the VMs with those disks I don't have access to hardware
performance counters :(.


> Maybe there is a link to the report you could share, thanks.

A profile of the "original" case where I hit this, without the patch that
Willy linked to:

Note this is a profile *not* using hardware perf counters, thus likely to be
rather skewed:
https://gist.github.com/anarazel/304aa6b81d05feb3f4990b467d02dabc
(this was on Debian Sid's 6.12.6)

Without the patch I achieved ~18GB/s with 1GB pages and ~35GB/s with 2MB
pages.

After applying the patch to add an unlocked already-dirty check to
bio_set_pages_dirty() performance improves to ~20GB/s when using 1GB pages.

A differential profile comparing 2MB and 1GB pages with the patch applied
(again, without hardware perf counters):
https://gist.github.com/anarazel/f993c238ea7d2c34f44440336d90ad8f


Willy then asked me for perf annotate of where in gup_fast_fallback() time is
spent.  I didn't have access to the VM at that point, and tried to repro the
problem with local hardware.


As I don't have quite enough IO throughput available locally, I couldn't repro
the problem quite as easily. But after lowering the average IO size (which is
not unrealistic, far from every workload is just a bulk sequential scan), it
showed up when just using two PCIe 4 NVMe SSDs.

Here are profiles of the 2MB and 1GB cases, with the bio_set_pages_dirty()
patch applied:
https://gist.github.com/anarazel/f0d0a884c55ee18851dc9f15f03f7583

2MB pages get ~12.5GB/s, 1GB pages ~7GB/s, with a *lot* of variance.

This time it's actual hardware perf counters...

Relevant details about the c2c report, excerpted from IRC:

andres | willy: Looking at a bit more detail into the c2c report, it looks
         like the dirtying is due to folio->_pincount and folio->_refcount in
         about equal measure and folio->flags being modified in
         gup_fast_fallback(). The modifications then, unsurprisingly, cause a
         lot of cache misses for reads (like in bio_set_pages_dirty() and
         bio_check_pages_dirty()).

 willy | andres: that makes perfect sense, thanks
 willy | really, the only way to fix that is to split it up
 willy | and either we can split it per-cpu or per-physical-address-range

andres | willy: Yea, that's probably the only fundamental fix. I guess there
         might be some around-the-edges improvements by colocating the write
         heavy data on a separate cache line from flags and whatever is at
         0x8, which are read more often than written. But I really don't know
         enough about how all this is used.

 willy | 0x8 is compound_head which is definitely read more often than written


Greetings,

Andres Freund
