Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D033E7
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588836; cv=none; b=Y1jF/L3pYi+7JAVEIyrC0mfHwn6abm/f/clz9c925RSRzhPS5aOZ6HszIL26qWHKdHrWYoj6pVGwZHfb4pLbIx4meFj+M5LICYLF8swSlWUib+G7EOokVZ1ZC19o0rvNsL1QkoVeKlgsYvonnocJDWUZwoatsTa6ysIVonFM4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588836; c=relaxed/simple;
	bh=tKuNBZF1Jfcg1x0DlWIcj/AE8qofj1weNsAa3inTtHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSqCHlFyJ5aIyzn5Vr/kQBfRVVNJWMg68yi+AhwE2mkG6o/SEQcTgSlPOlLHn39u4o3ycb7ANK0ZlSo/terT5JFnsPHte+tcpuL53tYInCfUIcM+61kA0K3L77m3nxzrd+Z8oVq4a7oerNlKXYsR2kK+2O2f86pJJ7wR607lz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xsB2H8RA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xsB2H8RA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cXVlPdbWXHKADYa//0pci7ISS41aeD0seLYNbe9+T7E=; b=xsB2H8RAozy596oGmGmiXLHK8T
	ZnxEhVXof7MZuUYDh3Xjydk0S7D2ROeYE9xONHvwWmiWB9L6Crq0jCyM3kjxHvMUuw7FDZP9wDygT
	OoTnwIa0o3eboIGkTx2FBKgdtlMRLK6A/lku437xLssDfAq/YmwzAQWJ/U77wUY22Xk3hcRRYJYeA
	vmIrUrlT7LyU9SVJcugVkl40+kNzie/pvN7/Lbr7vfIy/Zfrx5NOqEzuTNvkIMeRMJ2RrNHpXc5hO
	BH1pAJAtmGadFSTl3zgjcwQVJJx1FPVWclH7VEtMODy3/pucyfA1yr7coX8ibmOCJS9O8MJneFVI0
	r6gNSEAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8JOc-0000000HL4u-13oD;
	Fri, 25 Apr 2025 13:47:14 +0000
Date: Fri, 25 Apr 2025 06:47:14 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Message-ID: <aAuSYhnxwpJns5Cs@infradead.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
 <aApFcW-fsdUP4Ztj@infradead.org>
 <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
 <aApJWu1KLw7607Vz@infradead.org>
 <790260c8-09b4-96b3-310f-f9c5a93ef7ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790260c8-09b4-96b3-310f-f9c5a93ef7ff@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 25, 2025 at 12:04:39AM -0400, Sean Anderson wrote:
> and in userspace that assumes 512-byte granularity. But there is no
> such deeply-ingrained assumption for zones. You just have to set the
> parameter correctly.

There are everywhere in software actually using zones.  You still
haven't answered whay your intended use case is, btw.

> Plus, smaller zones are more efficient at reducing write amplification,
> in the same way as smaller block sizes.

No, they aren't.  If you zones are only a few kb you will waste a lot
of effort to actually track their state.

> If you really think such zone sizes should not be supported, then go
> add such a restriction to all the zone standards.

The zoned standards are extremely lax in what they allow, that is by
intent.  Actually software supports a lot less, and that for a good
reason,

> > Yes, it would be nice to have a sanity check for that and reject it
> > early, but no one is going to rewrite tests to remove that "assumption".
> 
> This assumption is very weak. It can easily be removed.

It can, but it's a really bad idea.

We're running in circles.  You are doing something very silly with
something not support in the kernel right now, without a use case
and are lecturing people who've done zoned software for years with
made up falsehoods.  That's not going very well.  Maybe your clever
scheme actually is better than what everyone has done for years, but
you'd better explain it very well and show how it's actually going
to work.
