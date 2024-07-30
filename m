Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB4DE573;
	Tue, 30 Jul 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368237; cv=none; b=R5/6Nx4G7YnNauCjS0h+T+yoGfxt3EZgVl4p+AsP68kxBBzHKr7/UtM0UYqiJunNVMlRce5TyoGtnHtP9cXdQxRpyBhrCzQsupkDYdcCvPvg83OuEayGGKSX8xbnRmHMNy8Y39IRQik0yRpFRJncdo8qo+xtO/8Epkj8DsKpgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368237; c=relaxed/simple;
	bh=SuXN81sPt6fadqL4dE9zkbRuXf/SPvv0eEFJj4dG6NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnFcy9fo0YmgkEKa1fHY+QC3ejO1tgtVJEJsJB8Ed+ghP+5jGKeJwTxhWYoY/highgcZ1Lf6PMCqN/ks3fCVFKFxKLmkYQCqlbI72nKyk+MVfBl97m827zwuw6DBH/Ef9CzR25hTSiztE2YJjNB/Fgv2Mm9BENgEFIX1ZgJmoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n0taJCQ0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0taJCQ0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XXudJi+h1E0YvanZqq4b5RDjTV2xzdKULNqOA1AtYR4=; b=n0taJCQ0ip6i/4AAsyz5wVmopY
	17GWuZruwKOq3cIX+/HQpJI3QNQ7nyF7JG1AY94Hgid/ADQAPoluH+bbURtCNB0CrSlGbZaQ1Iqvv
	a+0cFFrG073xGiOfEAjkuDkf1Lv0qHqA7OpIcIiD8o73RcoYdroa7ovSp5gjHvIGSu6MPiePAtGMD
	ymdfpGYYdQd6L5FxTQyq7wi87fWjtbrPBuz2HxhKGKK7Y3TS881LBDTJQsMO3IAm6h013fg21j1p9
	WySZGKQlRTzhYXLZZGPf6TZuntywdslYdTWLr5nJy3RM8XeS4uODgjlopEcxBdrWQu1PGQf2Ylevk
	QkTCUtmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYseZ-0000000GIWg-1IJ8;
	Tue, 30 Jul 2024 19:36:59 +0000
Date: Tue, 30 Jul 2024 12:36:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Chad Monroe <chad.monroe@adtran.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tianling Shen <cnsztl@immortalwrt.org>,
	Chuanhong Guo <gch981213@gmail.com>,
	Chen Minqiang <ptpt52@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 3/4] block: add support for notifications
Message-ID: <ZqlA21iolCpnu4wn@infradead.org>
References: <cover.1722365899.git.daniel@makrotopia.org>
 <ca0022886e8f211a323a716653a1396a3bc91653.1722365899.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0022886e8f211a323a716653a1396a3bc91653.1722365899.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Same NAK as last time.  Random modules should not be able to hook
directly into block device / partition probing.

What you want to do can be done trivially in userspace in initramfs,
please do that as recommended multiple times before.

