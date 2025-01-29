Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529314F6C
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130889; cv=none; b=eoxCQWV2XWlA17LY3GmRfXR3gb91FUnSxHdOeqtETL8kz+zzyWsfJUm82KXRJ3CRjN5sLEGSWcz3tUjDBxu6bMECi+LlATBhGMp74W5+E8ENrMDMMnL2s+jqT606CgElLNgoD30jH/QJFumXLiQKGYjAR6Mkm+63pHVOMI1g9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130889; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry4Pp2tu01HGmd30lmHrwSy2CzIdqXPTncEWviW4HmB021jYw+jv9e81SOVpwdjpgrcdB4wlEE+LCBqaRezp88W5BBtkKp1PJh55jGhiFLNSmS44af4eF/8oWhqE5VtKVjzP7EXXx3eXjQxRM3xPRH5Qbxqe+qjcaIFLUkFOarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0A4968D13; Wed, 29 Jan 2025 07:08:04 +0100 (CET)
Date: Wed, 29 Jan 2025 07:08:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCHv3 2/2] block: fix nr_hw_queue update racing with
 disk addition/removal
Message-ID: <20250129060804.GA29381@lst.de>
References: <20250128143436.874357-1-nilay@linux.ibm.com> <20250128143436.874357-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128143436.874357-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
