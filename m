Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74019258A;
	Thu,  7 Nov 2024 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730958267; cv=none; b=QQmFq/54hHz2AJK5VePxaRRmOe45+jYY8huIb2rnheCVu9s16JU4sTrwLyckqhKfPUWEi9r/BYKPOvsLa44OEErxkM5+7F0Hq6mJ08RCcagASjFeNX5Dbxif/gZZleQhP37ib2vcEOoW1g4EFZLzaE9eZgx9c3DbU+vqa4e0nrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730958267; c=relaxed/simple;
	bh=MQ6qGtsjXzcFq/1VGXUQgzEGYifcRLLrAh7sJ3DlDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9XmcE0tMeY5hiDZIUCDklnu/7f2snUcWnzB5gTCWxUdikXmzzAlVpSMfNKWXwY7KB6HEtVuODiNc2oL1qhJjHEvQvYpXQRHFYaxM2onwiVd2Q88Wg4A+8kpoQ3KBFJSDhCuktXbotxfh9lhBWMrGPE8c7DLGcOVag3KoxeXS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99525227AA8; Thu,  7 Nov 2024 06:44:21 +0100 (CET)
Date: Thu, 7 Nov 2024 06:44:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: zhangguopeng <zhangguopeng@kylinos.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
	ming.lei@redhat.com, yukuai3@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace sprintf() with sysfs_emit()
Message-ID: <20241107054420.GA2336@lst.de>
References: <20241106083454.45887-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106083454.45887-1-zhangguopeng@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 06, 2024 at 04:34:54PM +0800, zhangguopeng wrote:
> -	return sprintf(page, "%llu\n",					\
> +	return sysfs_emit(page, "%llu\n",					\

Please keep the \ aligned for all the multi-line macros.

Otherwise this looks fine to me.

