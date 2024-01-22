Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E03C6BC;
	Mon, 22 Jan 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930780; cv=none; b=VKerAMTitsg20017H+g36JhRIMOeEkKZrFtCBf0stiHteDvbu7ULmKpPkPsOOZp31rc10JuKZhES3nysjt1QmbI0Xn8A7e+8xi0sbLL+qKAyQ8/0j2RJUgYpwgLpwu808JmNpiVDWg6MXIW2GtcoI/Zay8oxx/gzspxwlmZSVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930780; c=relaxed/simple;
	bh=lOQUMEve7ymeYfx4uar1XhrzZJexkIJlNiV7GUicVco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPMMjL2IBO3HxN6eBeAhA2ofiSjDcU1ci2BkiVSzp08VU+Mu9JJJNJTN8EFv7KgmVRfgt0fBQ+Xv9Wy6r/L9rRCxN2Xav4o8AVh+2JmX+/f5/qAs6V/4N0s/OH2vbdt9Ve95G2Ip+o1HiEMrweSvL14SLQzIhLDx+56W9UnXMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A647D68BEB; Mon, 22 Jan 2024 14:39:32 +0100 (CET)
Date: Mon, 22 Jan 2024 14:39:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a
 q_usage_counter reference is held when splitting bios
Message-ID: <20240122133932.GB20434@lst.de>
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk> <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com> <20240122073423.GA25859@lst.de> <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 22, 2024 at 10:26:30AM +0100, Arnd Bergmann wrote:
> > A better indicator might be the use of page_address in the I/O path,
> > which usually comes in the form of using the sg_virt() helper.
> > For drivers/mmc/ that seems to be: davinci_mmc, moxart-mmc, mvsdio,
> > mxcmmc, omap, sdhci-esdhc-mcf and sh_mmcif.
> 
> Out of these, I think only the mvsdio one is actually use
> on boards with highmem: davinci, moxart, mcx (imx3) and omap2
> are old enough to never have had more than 256MB or so of RAM,
> and mcf (m68k) and sh can't even be built with CONFIG_HIGHMEM.

It would be good to fix the one or two that could use highmem and add a
depends on !HIGHMEM for the others and then kill the bounce setup in
mmc.  It turn out in addition to the one legacy ISA SCSI driver and the
two parport SCSI driver usb-storage actually also sets this flag,
which might be a road blocker, but at this point I'm getting ready
to just pull the plug if it doesn't break using embedded platforms
using mmc entirely.
