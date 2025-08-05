Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687B78F2F
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427143; cv=none; b=ttcB77e+tZI4k2US/zcsmqxK2v10FFTW3rkx1OvG/77mDahkcJodKbQl8/EAn/euyzzTRJiPeRvkKmADar/E2xyZ8tBBRnlggpnjfCfG2wiTrh6huUUwCzXB056U40QJVOUdMvR2kLc/2Cr65AifuaQs0Mir5ACqKitt+3jC0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427143; c=relaxed/simple;
	bh=9rX8zWbrBvapgXZlzmK8Wkfw1bZZ/pmiNIsbxNBaX50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqPT75gZDbCouJBmtPsa1qlJZ6NE16lFbAgiVWldM2/uJ6ElSpHej51ZI1kafBpMF6O9GAOJrkMTips4JmnqHhwOATsmkCnzz7Y4P9ogwJ45f7gfk+0PzNhbwFZpvGkRSa2RYPz7EqWdpsfHAz54txqC0tymwkhI3ScSE+TmXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/98kjdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/98kjdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BB0C4CEF0;
	Tue,  5 Aug 2025 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754427143;
	bh=9rX8zWbrBvapgXZlzmK8Wkfw1bZZ/pmiNIsbxNBaX50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/98kjdUJOd+z4CW63KVXost5ludFicYpgYa+23dSVwC0oC8UNV+eD4ZieU2c9V3U
	 Wn7G2Ewzq4lXNZ+E6yNiGph4BDhY3ZHsEGqAq3gsu++EFNLBGQr+HUfuhk3BSls5y1
	 NE4XPgNHnctLwhTlJuR7zGj1pCcnxCmoWQjFBNw4h5gDLfNXj3W5iN9hjhxcl71vv/
	 pZVAyE3cLTQoMednZlrqJz9UzBtyHXxKI/Vlez5sY7QUPQlbThJo/cvNUbwG759tNf
	 WH6onf/AoceWV59ZOqU69Yc/RXSklIM/98SATGpg3x3usTtgxiArX/a/I9tgNuVjXL
	 Vnm3lNJaDMGRw==
Date: Tue, 5 Aug 2025 14:52:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJJvBPg1t-JQAXh6@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <CADUfDZpv0e_wZ-RPn56rqm6Tz7YvZrwiKK+F8iW8jXYO4puMZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpv0e_wZ-RPn56rqm6Tz7YvZrwiKK+F8iW8jXYO4puMZw@mail.gmail.com>

On Tue, Aug 05, 2025 at 04:32:22PM -0400, Caleb Sander Mateos wrote:
> On Tue, Aug 5, 2025 at 3:59 PM Keith Busch <kbusch@meta.com> wrote:
> >
> > +#define bv_seg_gap(bv, bvprv) \
> > +       bv.bv_offset | ((bvprv.bv_offset + bvprv.bv_len) & (PAGE_SIZE - 1));
> 
> Extra semicolon and missing parentheses around inputs and output. Is
> there a reason not to make this a static inline function rather than a
> macro?

Using onstack bio_vec's made sense to manipulate with macros rather than
functions. But I suppose a static inline function won't push copies on
the stack either, so sure, I can change it.
