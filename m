Return-Path: <hch@lst.de>
Date: Tue, 7 Jun 2016 17:21:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk, keith.busch@intel.com
Cc: linux-block@vger.kernel.org, Ming Lin <ming.l@ssi.samsung.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme: add fabrics sysfs attributes
Message-ID: <20160607152138.GA24271@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de> <1465248119-17875-5-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465248119-17875-5-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

FYI, this patch should be

From: Ming Lin <ming.l@ssi.samsung.com>

unfortunately git is really eager to lose these when having the slightest
conflicts in a rebase..
