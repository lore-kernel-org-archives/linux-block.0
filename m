Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189245;
	b=GmGhTgxsimikcY3hZu+5QOMEJTGBX0ZML3Za4AO2ZsLbcHm7tGWZrdknlEF89I4CtjqD
	 yMxaC1nVNBOJ9zCyUOnnv2WYqa218zf0A3tinpVj2MGOWrNZ0CJXc4gdm3+ai/9rtgQhn
	 21U/YHlx5rPmutIx8Q0zeD51YXmv47wh3UJp0ABZV+SxKlfbE4T5sC6et2d92RWmyIhwY
	 g3TbBPFEz7yzdFnHtRW7WLeEX11j0IdgREvJAviVV0Q16SJtMFwSFxljt/fIAIevtMC3D
	 AkefWETHGjV8PClx9g3FQXoJm9EBwe7VtG8rL0MHTeQVk+1LocxdVek51H7NCFHF/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189245;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=bsxYKE5Zd8vew74nvAMhIuyLHBB4fUm5DrenWtYCV/4=;
	b=Suuba2AQLLDTANPSLYMd3kjwyZVOSjz3Fn3twxPsqa/5lmfRWd0vRxLPDO2TkdogMUnm
	 h0Q+aet/vPDd0F0JyFPsaJJ2QUtdgz3Zu9nJ6sB2RODZCi5qvpfgiT9qusYDTODxWHb1/
	 3vg4ZkbaJOnnNffCmYewY7w9GVuOt+4IsLaCyIhsWXrh9nGxKuDwpXwefqorYbh6n48M5
	 kUQiPMiimnc4vBKVnd9NJc3sKX4qXp8/v2nsQ0xTDlAw18nyl67jbLkTSz+v+ERNpxvlB
	 xMzsuPSC7nbFCNjnQ27H5SUJUQLcx8xEAO+9AhDYkua3Rcls92k+AC89tiMVT2LDAHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90E606A32A;
	Fri, 20 Nov 2026 15:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE90E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BF636732A; Fri, 20 Nov 2026 16:40:40 +0100 (CET)
Date: Fri, 20 Nov 2026 16:40:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	"Martin K . Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: stack max_user_discard_sectors
Message-ID: <20261120154040.GB28611@lst.de>
References: <20261109193927.595104-1-bmarzins@redhat.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109193927.595104-1-bmarzins@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 09, 2026 at 02:39:27PM -0500, Benjamin Marzinski wrote:
>  		t->max_discard_sectors = min_not_zero(t->max_discard_sectors,
>  						      b->max_discard_sectors);
> +		t->max_user_discard_sectors = min_not_zero(t->max_user_discard_sectors,
> +							   b->max_user_discard_sectors);

I don't think we should take the underlying max_user_discard_sectors
into account here, just max_discard_sectors.  But otherwise yes, this
should be stacked.

Please avoid the overly long lines, though.
