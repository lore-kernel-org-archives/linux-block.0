Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59719F11F;
	Mon, 30 Jun 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261728; cv=none; b=AGk07aOF8gyYIBu8ECbstbVXaM0BogVMbJ0VWbdlK1dvMIXplZdpQmiiGJ9Ko9f9faY2oCB1Qla50te5HFFssR7nevyX4W2njre8qrziXJDumXjGPXBsm3iXxzkME7sAXjVSR4XpjsG8es92RJNhYVoGlpz9Ph4cUWN7GF6pyqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261728; c=relaxed/simple;
	bh=jK7mgvIiXgSWDulrRrTEgyqtYM5DjFefRalwbMaxvFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5ENNL0DcumWFqz6XuNjeorbQkeD2dOPRDaG3QEUXxDMoTcez+Hgeyd8z2tknPK6uOluP4WTZnESj7d6FB5m0EilM68o1xOH+KM3plVUZB1WRtJBLzmNkJyU9pOAHp8KnT5HC+PWMU9L2l6AgJRs4QEvy328v5VkRkm3rLz1nnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BF4768AA6; Mon, 30 Jun 2025 07:35:12 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:35:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH] brd: fix leeping function called from invalid context
 in brd_insert_page()
Message-ID: <20250630053512.GA28428@lst.de>
References: <20250628011459.832760-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628011459.832760-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

s/leeping/sleeping/ in the subject.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
