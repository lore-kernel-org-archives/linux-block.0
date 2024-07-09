Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63714E2F4;
	Tue,  9 Jul 2024 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524121; cv=none; b=Za42ipddkEJwPUq7s6eU5iDTRenqNN7jU6h3sVUn7S7xb5sW4L4GMvdHc/FzoWLi2neRNb2HF9HtA2awRkx4g2v1QE9XUTnLxX65wZISAZkXn1li7SfTgDaDtVh9xTheU+OQBgB3dHv+SZNX+TmbNfMiBpdTYAl0ovQG/itdGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524121; c=relaxed/simple;
	bh=11Ws7j9YCcvj3i9pyOgfNbD+v9u81gyoh05llGlfvws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW8SBOVnwbs7uAj7RTskzKaUWVzRTZ3gQBkguLlB+5SLovuZw6usQ4KfZIR6y8J/Hig1KV/EDu0FVDnyGIhOj00uEcDTv658fARTUE+c2m0qqup5hftI+WgWvZlm95Wr36+f7yjixc5WuAY8i4sb6AVGNguF0J4mAbJYj4tBvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E3AB68CFE; Tue,  9 Jul 2024 13:21:57 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:21:57 +0200
From: "hch@lst.de" <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240709112157.GA5266@lst.de>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com> <202406281350.b7298127-oliver.sang@intel.com> <IA1PR10MB7240DE46976A3B027DE5484998D22@IA1PR10MB7240.namprd10.prod.outlook.com> <20240702155020.GB1037@lst.de> <IA1PR10MB7240AE0551BCF41FB1A69FD198DF2@IA1PR10MB7240.namprd10.prod.outlook.com> <IA1PR10MB7240AC320F4DBC43E73E758898DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240AC320F4DBC43E73E758898DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Gulam,

the patch has been queue up by the block maintainers for Linux 6.11.

