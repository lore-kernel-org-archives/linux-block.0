Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B11F941;
	Tue, 26 Mar 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473924; cv=none; b=eUhT8q3MqYsVbDPW4+NU4L342GggfyDvv04XQ3TrJb0RDbov1VM0PPKRx6p1Xl71p7Nxet4bi9TqabSW5OfshgZlGD90auj+CvzOn74YZFRSMQuM7gB221Zz474jKDSYF/Dm8d48KzeIoEpHXZ9lT4CfXL3PbuJ53yoI0Mg0/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473924; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coGrpbJtV8E675lmSxJ7svaSeP8OqoCH1V5koYk0n0cCZPinZYWPM2aZst6lwtrqlcW/2KkDdxa6+TQT9bq2eD5oV2tZXPgLAVpamUB5lHf2eDRtJBNJ3xu8Ravw+mYvshsUPmuLWTVptbglB5gZjzA4N6I9ElutTpJlEYl8e6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2056468D37; Tue, 26 Mar 2024 18:25:17 +0100 (CET)
Date: Tue, 26 Mar 2024 18:25:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fs,block: yield devices early
Message-ID: <20240326172516.GA25884@lst.de>
References: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-vfs-bdev-end_holder-v1-1-20af85202918@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
