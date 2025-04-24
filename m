Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40FC14D2B7
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503603; cv=none; b=D7QxYaKfe9sP4QUo2g3/LWxE/+joSSr1/mJOS4c7+HWaFjXKxjtXD6jDWlgW6PmDAY4xH6KH72YLoDiYJhqvJQKzd4yJ/u34v2d1c+znQeaBjA87KMUyfUtGTg2nC8Utf8EgzQlAibz9ebrlbuwsRgdIyMycspunnjTBmn5Jmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503603; c=relaxed/simple;
	bh=5VD01WU9inVJwLJKeq8ptRnrdXy9Jbf+Rgp9NQqupAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT9Lpezn4saFTgwbk5iQrzw5v1WHZUhNrc/fByFpGM/u1rsVQAHzDq/fqAXb6jZegJH3hAJ4sJnsfAERbHuDcK/kPRGksgnaxBnPZaqf1I3XZqgwLDuWutMzMyl/kov+9RsRCYElAapPIxuEOxJGFcer09K43QqVf4jJCHklIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OIF9YuUo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OIF9YuUo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YS9w0dHX3JifpWxDrVyfxSBsFp7DSMrJJqHMEsXVY2k=; b=OIF9YuUoRWArcUY8r+B+M88EgT
	F+ZCZo+N7EeqGXxtisWCPL5VXzGY984sIx5k/UH4dTGnesZz5yzNTgzKB53x261V8pMdhtdagBj18
	WV0rf5EtgsO+hbpXkj1830Ox8Z5FH1Wo6mjgn9G5XCrB7hZ+jL6K59y33ipo7jwFn3hBe6ps6wC8l
	jWgnTXTvghvHBMTrgnJsyzvXo2GWXUY3z+8k9y5HVdNFxir7Vz1QxI7JW8WzKcHSlVsRrzX26Pqdw
	W+nozLF6mODqHczXDqCwYrfoxQDPLReNknp8trfZ6EHlz1BORp5fdTYH9SLp7TzL8OVTmV9MuAi1i
	QYLpkKBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7xDt-0000000EJgA-1rga;
	Thu, 24 Apr 2025 14:06:41 +0000
Date: Thu, 24 Apr 2025 07:06:41 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Message-ID: <aApFcW-fsdUP4Ztj@infradead.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 24, 2025 at 09:56:11AM -0400, Sean Anderson wrote:
> > As a similar idea, how about to skip the test case if the test target device's
> > zone size is too small?
> 
> Why would I want that? The test passes with an appropriate block size.

Because this is a completely stupid device that can't actually be used
by any file system or storage system designed for zones.  Why would we
make a mess of our tests for a highschool science fair project?

