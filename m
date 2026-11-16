Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810469;
	b=lEalhOecgwOmSDyNs1B31h8UKT0YZoDkQNm/M0DJT6CDcgDmtLpaGW/qyDFOCDfGe4rc
	 yzhwbepGNIxQsRpuC6KYriG4okSxl/z2cKksLQz3rg4ooMVE6ywZ2EfKSqHduKbjTbeLx
	 qC9UVfQyFj0G26eAxPL4uwKENPtY4ag6IQ6CiYG+w3JFB5XI3TSO2CPro3BM571o9/Dy4
	 4RN/QktyxOy+MKlXNsqpOVtHSWsE4bC8XRdv0ebeV1ExpbPsLfpsOg01yiTlxZNOG2gJk
	 vMqMjAHIKRN1Ix56CG7SfJMCBairjMmh84755snDvEtSmzUnWhZTh6uhZLp5viAhghA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810469;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=l9KHikMHreBcTYOBDUZkJ7ONxIp7aBkEjVDoIuXH+n8=;
	b=4/KMgZWwM2jR9NmHUifcC1JfMKsPAr9NNlw+JrjAiiubmp/f/PEq/Apuk8H1h2/DaBDL
	 IsB5nXdh1TCMw4XdCqxwM66dm9RMiWh/sXjJuh4wTEzLJoQd/5qOEHVzZzW1ORgStRTZ1
	 UN2TUmfh5U8uGfRp4OpA3FcLbSZGgzXqvQPumKUNtm0GfL9JeAW9A2VZpfzN9P+hzia8D
	 ixTyJy4c9cfwnFfB2alHUIc8tCD/uWyMhs1VxtZ+oaOG5+vZZSfJpMKgQOwm+NOZ/7ntJ
	 W7l61fHLuAhWmJykXDno54IPdCtyDWfzOQT6hldgqPviYLXcGIK5zpZ9IF4bKbdm77A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k2LpiMhK;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F86606A31C;
	Mon, 16 Nov 2026 06:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k2LpiMhK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l9KHikMHreBcTYOBDUZkJ7ONxIp7aBkEjVDoIuXH+n8=; b=k2LpiMhKjDuZp+IljX+wobmPSY
	qpB8rJCE4mMY7GwYhnRROLp8iMrUatmHcgQsZ7vpkCaHIaDqw+7gQM1I6FMypwwT6x/wF/WZOCIdY
	wHYuo8jiFOkPOEzv299bsGbhl5XehpkZuf8ArCyWyvqZ99TE8+HSHhn2MkfJ1AVAeuwu0gvb7Ofqe
	uTwl2RsIZIEvl159QcitryuOWJSzf9hRiJg3vH0pLENJ+6w5mC/SXCD9O2mKL16DWfzoJAbAXISTn
	gUsWZ9WM7fZDZq/rUjkTPEoC9uJp2AiF1bVdAtgxpJxh6yL9Kx3dZLTm9ND9RpHtql8aJDUcqoCmn
	XM5Al+gA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqBv-00000001EWs-3vO9;
	Mon, 16 Nov 2026 06:27:47 +0000
Date: Sun, 15 Nov 2026 22:27:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Qiliang Yuan <qiliang.yuan@linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: return early when the elevator doesn't
 change
Message-ID: <avqiY8KqbSZ7X41G@infradead.org>
References: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
 <20261114-bug-block-elevator-unchanged-v2-2-5a1fe7d72fa0@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-bug-block-elevator-unchanged-v2-2-5a1fe7d72fa0@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Sat, Nov 14, 2026 at 08:58:33PM -0500, Qiliang Yuan wrote:
> Fixes: b07a889e83355 ("block: move q->sysfs_lock and queue-freeze under show/store method")

But this fixes tag is not correct, that commit just moved code around.
