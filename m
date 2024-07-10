Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED62522E
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595165; cv=none; b=Stv4mF4emZ3s6TL/Og1LpL/9BIpqxAK/ANmiGgo4yWladA/HM1URFU7SctNkVuOKaFTYU8i1qQ3F+5GLk6+vDT7vqie85rhX2P713uMP7SjRPcihs+28lzeD95DBVCt1Zt/YA9Fh3Txmx0N0ugeIYKG0EP2OzfG4bf0NCoTCKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595165; c=relaxed/simple;
	bh=mFd8W2LdBOlXlWHRfOuTQWcVNKd3LC2Ri9JZvLFpYfw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R3aVZwWxJYN98MWyvEcEYIvEW7JB3L2tFdmDdtELcCwfRBoMJ/CU3Ego0stmsEIGeN7FrU9M2XJKL9pGExeuUpAYppxCJPC69CEHv3k7uFE4OZw8/Q+AceRkWW5sdtkmuDk8SXYI/k+aU9tY95U5IH/v7OW1X8begUEqihQq5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2340:18a1:4138:37d2])
	by andre.telenet-ops.be with bizsmtp
	id lj5z2C00U4znMfS01j5zRo; Wed, 10 Jul 2024 09:06:00 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRROp-001aBZ-PM;
	Wed, 10 Jul 2024 09:05:59 +0200
Date: Wed, 10 Jul 2024 09:05:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>
cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
    Yi Zhang <yi.zhang@redhat.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] block: take offset into account in blk_bvec_map_sg
 again
In-Reply-To: <20240709070126.3019940-1-hch@lst.de>
Message-ID: <272362e5-1cc-e8e2-c0a7-b5e614e86bfd@linux-m68k.org>
References: <20240709070126.3019940-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 9 Jul 2024, Christoph Hellwig wrote:
> The rebase of commit 09595e0c9d65 ("block: pass a phys_addr_t to
> get_max_segment_size") lost adding the total to to the offset in
> blk_bvec_map_sg.  Add it back.
>
> Fixes: 09595e0c9d65 ("block: pass a phys_addr_t to get_max_segment_size")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, that fixes booting landisk!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
