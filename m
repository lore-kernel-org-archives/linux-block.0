Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F212D21B
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971386; cv=none; b=rnnmDI14s6DsQmj4qtCAXSREDMwhj43g/2b7cM8nQdZhlEPBTKi9aAil+rGLRuKOeaTJbouXsbSj8fL3sWV5gkDXl6O6iYVaGMZiRs9+ZnOZebJ/BqhjQDoP4oZ+yQCUGJuWgE9fZeYi7a0+sdeI+LMEym61wwhQLCB6F8MMEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971386; c=relaxed/simple;
	bh=fT4jWSTb2I6oIxE3Xfk8Y16Qci+9O0FAG/fPqWpq2bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l950XcRUojlyijIHL1sFMcT7EK6pHGKu6FuUKDbHw+9wlWhfEf2Zi+v5fVTI9Q8nhpkddHb7QPSTLToLXZwCC+9atFVv1K888n/drTz77XgisHccRvimy7gPn80znHZJw76HjN7gRkg1QLUX957ngmZe1YhCXwdPXjC6Ao3K/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J/rDsNTZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/rDsNTZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fT4jWSTb2I6oIxE3Xfk8Y16Qci+9O0FAG/fPqWpq2bc=; b=J/rDsNTZj3I00ZE9PUiem++qFW
	yosCdIddicVolu/QLtm6zEEwCUqzYYneXYZK7tz0tnHb6ZGbCGYQkRI4/24zR4hYzy1yNHEubGfyP
	ks/bC6ANycvSRhpVMduTMa8BLawIxzpIcTRdJgDnZZ4iwKLWjAsGH3Vo+G5oCmodBKHLV6HiIC7Wn
	8K+cA5i3lYrJscmtxWX9+DSQ3PzGHoXtjCys3C50fCU8nlaCrARkrbuhUHMj0oK6oHIFlRUTp5742
	vOwhJxDkJLH38KBBN4jlwzTykd0axrSl1YQNXuMiZ69C344T8MOYOfpzmYA8Ig9NmR3eXm9+mRc2T
	5W33wJKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veE7U-00000002SWL-0x8u;
	Fri, 09 Jan 2026 15:09:44 +0000
Date: Fri, 9 Jan 2026 07:09:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ruikai Peng <ruikai@pwno.io>
Subject: Re: [PATCH] ublk: fix use-after-free in ublk_partition_scan_work
Message-ID: <aWEaOFuhRPvtnkRO@infradead.org>
References: <20260109121454.278336-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109121454.278336-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Why does ublk have it's own partition scan code anyway?

