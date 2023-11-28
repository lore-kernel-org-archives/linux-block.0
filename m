Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9518F;
	Tue, 28 Nov 2023 05:00:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52971227A87; Tue, 28 Nov 2023 14:00:01 +0100 (CET)
Date: Tue, 28 Nov 2023 14:00:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 2/2] block: warn once for each partition in
 bio_check_ro()
Message-ID: <20231128130000.GB7984@lst.de>
References: <20231128123027.971610-1-yukuai1@huaweicloud.com> <20231128123027.971610-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128123027.971610-3-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 28, 2023 at 08:30:27PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Commit 1b0a151c10a6 ("blk-core: use pr_warn_ratelimited() in
> bio_check_ro()") fix message storm by limit the rate, however, there
> will still be lots of message in the long term. Fix it better by warn
> once for each partition.

The new field is in the same dword alignment as bd_make_it_fail and
could in theory corrupt it, at least on alpha.  I guess we're fine,
because if you enable CONFIG_FAIL_MAKE_REQUEST on alpha you're asking
for this.  I still hope we can clean up these non-atomic bools and
replace them with bitops soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
