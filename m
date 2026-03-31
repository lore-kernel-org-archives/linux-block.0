Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC83FF883
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969203; cv=none; b=FUGPsYbH3sYOewCDvlYe4Rj3OQvqqn83k7pFMoR/5evqtpntuYOUbtgFiz3MZVgGnZNhD9pZ8Q5LxapMYhsjCHSyw5tT7QV/P0ZbhKxx4E9/ci4oDooWRZpnRifp9OFyLzlU2bot5dm8ypuRdRtuk4AQ/jqlG99o/i207Epv4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969203; c=relaxed/simple;
	bh=BaMYLx/ETI1LB1X47dc0f3wTEFQSAaHrolPgcHFph3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpTZcKp5yH57S+K46zaiwR/PBcPk2UZOyiEmxgGxQmxbVlqmE0Ooa5pQb7yG/q0GVbQ2JNIE9kOfuFG3ufp//502FR64GJKBoRE3eJL1qCb6lSC367U+5ICtZ43SXlC/R+v+6sfW+66G33wFCEq3OLH1yLPbWwTTjgaJafr8qeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UqPwfhLi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UqPwfhLi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8n+ZOZAlriIVsBJfBp+/ZMo3oYvDH18xBm+QXf/YUF8=; b=UqPwfhLiBiUSGCFEP2gTw+NJRB
	Io9X+fq8j1JEdE4Dpyi29phEOnomdfOZzBxKkNXIPkgDpY3VjEIPe/n/sl9wCLqkq6vW9trJC2a7I
	vU17FMN541qH5W25N75GBVRsoUwjA6rRFzFZ/sTpKDtP1VWEkF1jlC8UBuSJ8VCi5JA1BNuqcW8Nu
	TzJR0alxzGy+t9RnDq1ukPpIGEbOjlI5utCmNqvb92Ox+vUJe8uHrhZQWXDuxaRAbtIgBO/9SLGeS
	ZBft2kQTs9Bhe++r0OZnxOAHfUyXjobNR9pxsZyqH+htgnZPV3HBA5JxeW5Dl/EVTW6akMJbSJXcW
	Kz42vouw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7aZR-0000000D8WN-3L6g;
	Tue, 31 Mar 2026 14:59:57 +0000
Date: Tue, 31 Mar 2026 07:59:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, brauner@kernel.org,
	hch@infradead.org, Daan De Meyer <daan@amutable.com>
Subject: Re: [PATCH v3 1/3] loop: fix partition scan race between udev and
 loop_reread_partitions()
Message-ID: <acvhbcRbR2cvMGRg@infradead.org>
References: <20260331105130.1077599-1-daan@amutable.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331105130.1077599-1-daan@amutable.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The subject looks odd - for one this is now a block patch and not
loop, so the prefix is wrong.  It also claims to be patch 1 of a
3 patch series, but so far I've not seen more than this or a cover
letter.

Otherwise this looks good to me.
