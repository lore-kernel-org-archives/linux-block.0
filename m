Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CA13D2BC
	for <linux-block@vger.kernel.org>; Thu, 13 Jun 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266831; cv=none; b=UEXTJVPfH/kiqwTgSs99dtoh+ZqZsa193bpiLVfEuslEnLmsHlX0xcmkQ4ldkm77fcja2BpM3ARqWkz1/h2LAPqfNVl1edpRLHbwVnYPKr9JrXUPkj+VonqFoW03JKGE0u7SsHiRs69mlLm5ecTET2fjrA+EaRi+sBn7lVgEDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266831; c=relaxed/simple;
	bh=HcUAevXrKtSbhjKQKaL0FE5sM0rtWc757L0n0mfZMrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KUw+C/OFZkwgNMFaLFVWDOakfm/ZjVETOrpT/0mD84fy5j7seeTBJZvJ8XpaADiVxZRC30REj4qkU+sCiuidWeTp+QMESnh+80Al2txQx7aCsZXovd/ORlI9mNHCRF+GZXGezT1fpiQ7wpU4iHzLHo9nPMlKzU/xS4WBCKSGJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1vO/szRB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1vO/szRB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5+7lVSxaYVkh/j4lzFheSrtbenN3iwa5nr7zP06/3YY=; b=1vO/szRB47it7MfAUf70nLSb+Q
	rwhOQHEBripe5CWuQ04QO8mjgNlvN+90d4V+pjDL498eUAjs2Yr26QaSjpVT+YOKuRpIPff9XrEuP
	t4OO4oMvWkjNEs2eBWxHPqWFTO49dmXBYeKfMDHpcsRgJ1NVPCJjYOXzxXrkXC5YvHtcZi1ca92ii
	eW53NSBGTtS360+za/KT+5Fb8PIYqJuZEvu+02zFcxbW/UN/ubqTxjlqcyOeFJE2R+v+ZvlNIlOEQ
	649Mljb9+oroOCUfHnAvEq8RN2OL9j6+C9Qv5olfY8pmDIccuNZ3RALOgT4vhvYLJjExOtrLs7q9M
	BaFHhkEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHfh7-0000000Feb6-31fb;
	Thu, 13 Jun 2024 08:20:29 +0000
Date: Thu, 13 Jun 2024 01:20:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bryan Gurney <bgurney@redhat.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: blktests dm/002 always fails for me
Message-ID: <ZmqrzUyLcUORPdOe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

every since the test was added dm/002 fails for me as shown below.
Does it it need fixes not in mainline yet?

dm/002 => vdb (dm-dust general functionality test)
[failed]tors
    runtime  0.044s  ...  0.049son dev dm-0, logical block 8, async page read
    --- tests/dm/002.out	2024-06-02 08:38:27.252957357 +0000
    +++ /root/blktests/results/vdb/dm/002.out.bad 2024-06-13 08:19:31.526336224 +0000
    @@ -6,5 +6,3 @@
     dust_clear_badblocks: badblocks cleared
     countbadblocks: 0 badblock(s) found
     countbadblocks: 3 badblock(s) found
    -countbadblocks: 0 badblock(s) found
    -Test complete
     modprobe: FATAL: Module dm_dust is in use.
