Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F01F09B7
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037161; cv=none; b=U877wWA42gWOas3sTWcZSdMuEnMm7SXjDLUSP7rt3WKq65RoV93mUACup2D1ns/fd1c2ABf/GXmCdYlG+XzdO62FUMh9mMu4mNTBjc2VIfNu2lUKcmFSviKl9wypf6yLX8qpYXEKDPdM7IylifK903Gld/u4D/6qUvAx25hF8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037161; c=relaxed/simple;
	bh=sMDdY6U1CbGW59ZUQgGPk3Tzm3cjEPAT2SC7RLyy39Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzmIvtZGT9i8tN8pkKnrw09C1SOVMsuleyME7q+17ZlhF4Tgy6o2Jcl3oGEBltKcUlpLulEXkeHFaZX/AgZ99E4JTOzWWHho+4v0PTg9T9kBUfTcJvGXU1wGZAJCsr504Ghh3lpcBO+QIwkiESZPe/GxVOCun8v47y+zFm4cvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D98B568AFE; Mon,  7 Apr 2025 16:45:55 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:45:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	jmeneghi@redhat.com, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [RFC PATCH 2/2] nvme-multipath: remove multipath module param
Message-ID: <20250407144555.GB12216@lst.de>
References: <20250321063901.747605-1-nilay@linux.ibm.com> <20250321063901.747605-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321063901.747605-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 21, 2025 at 12:07:23PM +0530, Nilay Shroff wrote:
> Remove the multipath module parameter from nvme-core and make native
> NVMe multipath support explicit. Since we now always create a multipath
> head disk node, even for single-port NVMe disks, when CONFIG_NVME_
> MULTIPATH is enabled, this module parameter is no longer needed to
> toggle the behavior.
> 
> Users who prefer non-native multipath must disable CONFIG_NVME_MULTIPATH
> at compile time.

Hmm, I actually missed that in the last patch.  I fear that is a huge
change people don't expect.  I suspect we need to make the creation
of the head node and the delayed removal an opt-in and not the default
to keep existing behavior.
