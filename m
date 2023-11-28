Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43410CC;
	Tue, 28 Nov 2023 04:58:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A28F6227A87; Tue, 28 Nov 2023 13:58:23 +0100 (CET)
Date: Tue, 28 Nov 2023 13:58:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 1/2] block: move .bd_inode into 1st cacheline of
 block_device
Message-ID: <20231128125823.GA7984@lst.de>
References: <20231128123027.971610-1-yukuai1@huaweicloud.com> <20231128123027.971610-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128123027.971610-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
