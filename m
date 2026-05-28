Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012A3E714C;
	Thu, 28 May 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992355; cv=none; b=scM4UfNxAo2mvQzcnVPPzaCxuyh/8rYNOeX6sr6uJzqHOWpWn84AWY6XJLgo6szSDvinEJi9sABEBRtDHDpM97q09SjVVYU+aFfF0lfaxU2ROBNbfTaDUKUEGz0zgRAssBk2UAbOwN4+/gj/p3asHlJrnhegSPdlnvbMLSaVLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992355; c=relaxed/simple;
	bh=CEBX/X6PBwrtNQVS34YvCyy1sX4BvyaNdVAE0S10LS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYcS19vuOusII2OGMf0W/usKzh14/VFNGkXIK9mE1eNfpWzhqsS71GZ/K3rClZ810A18K+6bV1sLGZUgi4ck5MpNwZ90+72E5CQvZ6MsYXkdUNc1Wl0BePKlqtJYavtYa78Cj1/YN4yKSPcvcEw5mylbFuuLpKrOc9j3hVMcK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHnvxN+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHnvxN+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129971F000E9;
	Thu, 28 May 2026 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992354;
	bh=9zfQVtS7zyt1UNfdGE5qkvygfJ2lT/N6CFtv5qKDbrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CHnvxN+XbVHln5GN22bEU2DwuYKOLZj5zBnsHY7uYUJYtgLStmeZBgZI5iwEAeoW1
	 UAbb/TmzhPagoPnMxqDC+j24wYy4VtfZLogzWU+I02dzskNiBT8x+Qup1QHfOfxITg
	 y1zvbhEtk8nC1CC6cShHaV9Tf5lTGv/kbLlo8IIIEv8n7OMr1Yih2MhyE7BBYZDQd7
	 9Bx5yLx0o8OqL++j+d1zBEZe7Y32uxEfJbTBpLLTIQEm88e//aJVSY3/NzghQ8aQ04
	 oN/m/MgPw6HKU9YTWqkjT/3xFKNI+GTJDRsWKBSh6kQoqXkdY6WEWD+Oj/swFOSZtQ
	 KtSwbX2gFC35A==
Date: Thu, 28 May 2026 12:19:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ahiHIEhsV2zuG5vH@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>

On Thu, May 28, 2026 at 03:24:27PM +0000, Achkinazi, Igor wrote:
> The SRCU read lock prevents synchronize_srcu() from completing, but
> does not prevent set_capacity(0) from executing.  The bio fails the
> EOD check before it reaches the NVMe driver, so nvme_failover_req()
> never gets a chance to redirect it to another path of multipath.  IO errors
> are reported to the application despite another path being available.

I double checked the sequences here, and yes, I think the
synchronize_srcu's already in place ensure every caller sees the EOD
error before it could fail the bio_queue_enter(), so this looks like it
happens to be sufficient. I'm okay with it. 
