Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8193CF041;
	Thu, 25 Jun 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388632; cv=none; b=glWxzx61ZJxv53de4sKIn3inMMRq5hd90whH2HoBeuZ9AomZG76Jz05o2fl5Fc9OiWJXrn35aCGDMs45qNWEefxXP8WfwyiaORPPh/jvtchegG1MsF6yN7mTu0jYDa7lMi3IzB2n30qzu8HNEuvDvZPNvGYagRSfrHooumnSbw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388632; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI1dLjK7zsumLAn8hlVv+Cb8W9Akh2IoPycMENPWcjh9bn6Nj3EUy1AJpjgji8kdYuvKXIgOacVjJlcvV0C2v9Il6CEaztsPMfDDen/vpEUW28lrWz+XuzXfydvWVL0dIKp0mfyDbYHqXmGHMiqOvHcecbUUxZXGAb5r5BK64cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 556DB68B05; Thu, 25 Jun 2026 13:57:09 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:57:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
	brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 3/5] loop: set dma_alignment from the backing file
 for direct I/O
Message-ID: <20260625115709.GC18348@lst.de>
References: <20260624170905.3972095-1-kbusch@meta.com> <20260624170905.3972095-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624170905.3972095-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

