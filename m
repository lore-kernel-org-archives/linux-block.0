Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1421D266
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF3010F9;
	Tue,  7 Nov 2023 23:19:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6680D6732D; Wed,  8 Nov 2023 08:19:25 +0100 (CET)
Date: Wed, 8 Nov 2023 08:19:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: josef@toxicpanda.com, linux-kernel@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
	chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	lilingfeng3@huawei.com
Subject: Re: [PATCH v2] nbd: fix uaf in nbd_open
Message-ID: <20231108071925.GB4875@lst.de>
References: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107103435.2074904-1-lilingfeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I don't think this is actually enough on it's own.  You'll also
need to move al the teardown logic that is currently in
nbd_dev_remove.  And with this you should be able to remove the
NULL check in nbd_open, and propably the nbd_index_mutex critical
section.  Although that'll need a very careful audit.
