Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A918A6C5;
	Thu, 19 Sep 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726745869; cv=none; b=pyJNyhTNavVLvD17W130AxZorlm/QqGUaaVwMFjzSqhp3y+jsovWXuMgASe0m3TmcJmaLn74zwFENvmLNiX2fEi/p73m95XRzTK/d8WJ5Df5K1PvzECs/GrsLCkRyLKV/uqlqCJfQR4Uwr0Ko6AJcvfT+CkYYIG+frdWvZ/Tuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726745869; c=relaxed/simple;
	bh=/QwzbUtjn0JVsLE53dxj+9O1VYVnrHWhgyHOajQf6gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5VOD4Cg4Cqa0jTx8mHbW0OZauDuqmA3xKvO5uUV1VyXZ15TshKPvjWKEhCLJaoC6PhuPHW1hatnB3hrk6rLTtq+IWmYvouyJLByp7uFotsy5MnC+3aMNVe5E/RJYQClobCEG0oTpLVBGvQHR+mj4b3mCc5O1ItW4/fY6TyXF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pd65Nbhp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pd65Nbhp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/QwzbUtjn0JVsLE53dxj+9O1VYVnrHWhgyHOajQf6gM=; b=pd65NbhphS1nHSii4UtGmEI+Bw
	G7Yxc7bykIPjG7NWv6NUA+rq+rrseadCpelHDT54tZ/TUijFYJoWIoHRU77CxbHJKmZyqEaUTul6x
	j+EHT1R3NYNRYPiDRlrFStSdpFbJmT9EZdfaGuLg/WT6t+k9SYUmI+BZqjUhlnpOtoXGCJBtid75Q
	tIzrF9I5uVX+CeGNhjsL0OAwuCNljwgidunEyjyhjolE9vvoWIxy1p02skaFyS+z26BxTPLIZVd3x
	E1L06M4wWFUtT7/3/CAt9GQkTuGEitdHv9O+0Ib2mTfG728DrvKUm4Gpy7BYtcLL+JwtA3ziU/AIP
	B84Bfpqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srFTV-0000000AAxh-30TU;
	Thu, 19 Sep 2024 11:37:29 +0000
Date: Thu, 19 Sep 2024 04:37:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-block@vger.kernel.org,
	Casper Li <casper.li@mediatek.com>,
	Chinwen Chang <chinwen.chang@mediatek.com>,
	Andrew Yang <andrew.yang@mediatek.com>,
	John Hsu <john.hsu@mediatek.com>, wsd_upstream@mediatek.com
Subject: Re: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and
 SWP_READ_SYNCHRONOUS_IO
Message-ID: <ZuwM-aEEo7DE-qXw@infradead.org>
References: <20240919112952.981-1-qun-wei.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919112952.981-1-qun-wei.lin@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Well, you're not actually setting your new flags anywhere, which -
as you might know - is an reson for an insta-NAK.

