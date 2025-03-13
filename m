Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94EB267393
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869739; cv=none; b=Br/4FKA/PDU6Rio78PZOkoOI7iWwacaMkh4IN5DsAIgkeQOExQYnmx/sThk7OWmpOIVow/BUc2/XJDnKh3bqSIe11ynLCV5Mxt0XQ5vMqc9B12kTjLw8X5TbfLP6LXmwwZUmCK39oKh2+hpnMLRWh+PBkrT8nt5hXbC/lyRQH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869739; c=relaxed/simple;
	bh=u2RY/QKXr369Wf8bJDCPT0/noJ6cPZ/mAHFjms02+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b++II6QDMdcUMcUuET9bWt0JckybqF37bPZ8yvaO/CA/WvCMky7JCN2O8KIRmUrpwJzi/elyib5w+4aI4/a8ew7Ni9Mt3s9/JYHJwL2b6xq3/KxSZ685n8MYi37mXGG/v7XjgBFMj+3uxpj17JsOOn6acEWAl6rmX/MeUnC8B4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DF8567373; Thu, 13 Mar 2025 13:42:13 +0100 (CET)
Date: Thu, 13 Mar 2025 13:42:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 2/3] block: Remove unnecessary goto labels in debugfs
 attribute read methods
Message-ID: <20250313124213.GC3841@lst.de>
References: <20250313115235.3707600-1-nilay@linux.ibm.com> <20250313115235.3707600-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313115235.3707600-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Nit: the Subject starts with a capitalizes word after the prefix,
unlike the rest of the series and most block commits.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
