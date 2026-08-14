Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E842E001
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694933; cv=none; b=RTaITBcLCyd/P9TxX3cx0qzuCFYMdJyPrTOOtcGxKRleOqHl9l4OMBIEwPbSBHbWPUmYMumKich8XE6nPng847H7aAoXKAhpqwNhliJ1XoGDFwuJJCtxMAxfQ8oAZTLnpbuTAVb3XRwEpuozeo4jcjRK203gcz9huPXaz47xiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694933; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNFuMQ/C1X1/ehgKjL870C/hG1L+pZj26aGAij71kYp43ahn/fMG+QyMS7ITMaDTahTFsP4F14HesvW/Q+dupovDtlR2JJTxAtvKnambWx80KbPyfRvoGN+iQTgveePRhF/TEAMK166e7ueBXRT0AWw4/+llRlaSMZYgVENWv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7276F68B05; Fri, 14 Aug 2026 10:08:48 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:08:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 11/13] block: allow read-only and offline
 conventional zones
Message-ID: <20260814080848.GF12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-12-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-12-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

