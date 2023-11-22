Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sO/L2q4O"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27929D;
	Tue, 21 Nov 2023 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J+bePWMprDbaGsnpRV9f2P2ovME7LDOe2qhgN0MMut8=; b=sO/L2q4OqAtZKvjVdg9fs0cQ+4
	9UGXKrFzl23cuOIY/lrbPdm8CXVzgeG5spD5qeMYMOwMfgsIIDzLSjy6x5T2rfI59pv3duwvH9YX1
	4pVFrQDr94qRX8uVU0RoE/GnpB6oC/4pi+d3I+WkexzTywPUPMzSfQ+n2hCmD3ZTwLX6QCYR5q1SF
	+gYo03A0NYe5hgUgq3ecCMVJggOSzg98WzZb53qCIDM9/+PcRi45e24yn/i0qv3bu74H/nZygXx+8
	3Lxa8eQx2ZpVwvcV77rienMmpWSHIxB9JGagtw6Z93JmrmFXvkMqkM//vvNWM87dQhX/ckUKt54Ur
	Z2QhLx8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5i2v-000y8k-38;
	Wed, 22 Nov 2023 07:53:17 +0000
Date: Tue, 21 Nov 2023 23:53:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV2zbTPTZ0qC2F1U@infradead.org>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2xlDgkLpPeUhHN@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> All the existed 'bool' flags are not atomic RW, so I think it isn't
> necessary to define 'bd_flags' as 'unsigned long' for replacing them.

So because the old code wasn't correct we'll never bother?  The new
flag and the new placement certainly make this more critical as well.

