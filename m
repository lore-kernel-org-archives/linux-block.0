Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220020;
	b=X05mJurbyIjIv8q3Ax6lqGH5lU0Zg9eY9jATthxMYabvWxZQv0yleRSKNW+YM6v+SRsd
	 sKiOVKReq6Vy5SB5P4vh2Mj0ALXjy+iFktGbypFOYHPwlr6Xg9hYwKiGdUAs6e0cJiXNe
	 GR/KPDeeMD521RNxVl6kp9AJm8ETKT0L5RhpyGWht3gEXMMTQsgQFArTBK8+C9YPJtafg
	 UTe2nnaMiobDnB5AvWI6YGwfU0YFY0q0W5BukoJX7UUUM8ssrrjA9cjpnQajW7gjpJQpU
	 mtbiLBCfFVDT2W9UQfmjGI/S5XTrE0qyxylolbBMT6Vuj4HpR7HwijMY+agPSdYJlVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220020;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=cFRkYeYd4vKKBrKQ/JcLjeow/zlblgYRDRrNh/WCsJg=;
	b=3Oz++By1h3kvA0QDfC4iZ07mGeOb05XwV7zxFupsD1RRvefJMbqqwYyFFBIg0kpO7NRT
	 Zytr3ZHYuDUOh8KlkdfInBA7VGhKTPQuR64REL3iB8O1W0i3jqpZv3jlLdUH2AS/6G/6M
	 HhixYH8u/pmCHohnhYXEiKoJ472Q1xux37Q0TBpoO6CVy2XMpnLvN5XhCoZsyu72Iz9PJ
	 PGCCWksyRVK75pAbVdNw2h7fbl/MoJBmBbFKSXZGEdsvNU1q2mA3JerjRGuC+ckrAzHMo
	 J3GVvsPlWLZSDH0tUVFbOAEOEnb1i3CQqrFaWa88WA1eYr7Enwt2yp+jAez48+GuKrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4012606A6A2;
	Sat, 21 Nov 2026 00:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4012606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD8BC6732A; Sat, 21 Nov 2026 01:13:34 +0100 (CET)
Date: Sat, 21 Nov 2026 01:13:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	"Martin K . Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: stack max_user_discard_sectors
Message-ID: <20261121001334.GA13058@lst.de>
References: <20261109193927.595104-1-bmarzins@redhat.com> <20261120154040.GB28611@lst.de> <awCi_9_Xykc_Mmk-@redhat.com>
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
In-Reply-To: <awCi_9_Xykc_Mmk-@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 20, 2026 at 02:43:59PM -0500, Benjamin Marzinski wrote:
> > I don't think we should take the underlying max_user_discard_sectors
> > into account here, just max_discard_sectors.
> 
> Is that to handle devices that call blk_queue_disable_discard()? I
> didn't think about that. Makes sense.

That too.  But also because user limits on lower devices shouldn't
really affect upper devices for consistency, as new updates on the
lower device after the upper one was created don't get picked up
either.

