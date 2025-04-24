Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25B1B4248
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504604; cv=none; b=aWettvJ7ep7AgzjLZ9lU9X0FMCwGVLeA+FTudIeQozfaoz4SDKwju9f/pIoX30d0dpdUY6YYDaIPZhhG9AKRfqTziLGEhl1QkfH+V+lcZF8obOwrdUlB5SBUUaM+BjlYW62ur9kbLwTT3RCduVKF68NSftX+Rut60QsFF/4PBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504604; c=relaxed/simple;
	bh=3KbR7jp8+ZbSk9f0gn5t8RXYiZr9HKjsxdCSUDGCbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2UVkF+RZi6bmCW7zCEdErbmnan6FT3Bp7pMVLNd3TYX6eIBiwxPFWh2CiZsqxDYS+gwsoGrWxqXv/bUp2XBb2FAWWQrz8cTvh+qF65PNWTi3Pj9k4QumAHGOs1q9rYq0V/NXvOJl3M4fnx9xyZw3MGiXkVzmdBSkj2vIInx6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fmt4kcmu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fmt4kcmu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+VACXBAXT07RkefaRCWJQdFt8naqQplP3kQ/oKDNCTc=; b=fmt4kcmumGyau4EmJIqns6eQ0E
	kW+hgQgQ8KvyteVaSFCuqqwl8Bd3eFxLoLab6Gjaz39+dJ+cvWwXyetRCvf0u/wkUYwMOua9OVfBs
	A2XWPmONVzdRskMuDn3PE/qzu2hPaDsk248aDzMiMX4hnGitgCLcz/wLcNJ1DtfwLETIS/gA4lQ3O
	KHdipVIG2Xjv4HHEJik6PxJRDtg9Dg0+DEkPFa6yUp+QjifiNoKnTenhc6BPeVe34pIJVeUeJCGae
	iH9PCSYivhveUElPqv4afHPLx3bnGi6QMzivrSZJ8CTbH5FCmsOTQvGGv8UqkOfkdF5Ufl7dPgKW4
	Zd9vFjPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7xU2-0000000EMct-0qIz;
	Thu, 24 Apr 2025 14:23:22 +0000
Date: Thu, 24 Apr 2025 07:23:22 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Message-ID: <aApJWu1KLw7607Vz@infradead.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
 <aApFcW-fsdUP4Ztj@infradead.org>
 <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 24, 2025 at 10:20:09AM -0400, Sean Anderson wrote:
> Because the test is trivially wrong.

I stronly disagree with that.  We also don't support < 512 byte LBA
sizes to give an example.

Yes, it would be nice to have a sanity check for that and reject it
early, but no one is going to rewrite tests to remove that "assumption".
