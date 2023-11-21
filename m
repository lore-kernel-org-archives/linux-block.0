Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E1DC;
	Mon, 20 Nov 2023 21:05:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B03AA68AFE; Tue, 21 Nov 2023 06:05:19 +0100 (CET)
Date: Tue, 21 Nov 2023 06:05:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 4/5] iouring: remove IORING_URING_CMD_POLLED
Message-ID: <20231121050519.GD2865@lst.de>
References: <20231120224058.2750705-1-kbusch@meta.com> <20231120224058.2750705-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120224058.2750705-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
