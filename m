Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55528EC
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592372; cv=none; b=qekPRjF9WF3A3kjVxl4BmPH8rztAVA3TDoop1wBzR43WPtuLgdkRuhYz/ZzXBVMEu2T1e1Xr1mMVE6etnJy87IwCb0drhWHvnG3O4sJxYsnlcbURlVigYPnrTgIppg0MTA6VstufYnZQ6ef2Rx30CBWfsDFx7SzqnxLqzDder5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592372; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4uGPH8raN5QsLF7H/AjZ5Bz4hUfmoblWEuQlIkrI/IvltwZlHiWAFIAs2oBMO+R49ehNxlTM8uSIkItnDV0CBNl3ktMyx16yIl1y2fkZK6/Xp1BMFplCafxuYy0pSEH3Rv/Jf5NAuAoi48p5UHYswaK8EzDIOBXcWE1tuOZv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3907168C4E; Fri, 25 Apr 2025 16:46:05 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:46:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv2 3/3] nvme: rename nvme_mpath_shutdown_disk to
 nvme_mpath_remove_disk
Message-ID: <20250425144604.GC12179@lst.de>
References: <20250425103319.1185884-1-nilay@linux.ibm.com> <20250425103319.1185884-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425103319.1185884-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

