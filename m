Return-Path: <hch@lst.de>
Date: Tue, 7 Jun 2016 18:46:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, David Drysdale <drysdale@google.com>,
	Xiong Zhou <xzhou@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-nvdimm@ml01.01.org, Larry Finger <Larry.Finger@lwfinger.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
	bart.vanassche@sandisk.com,
	Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: Re: [PATCH] Missing bio_put following submit_bio_wait
Message-ID: <20160607164645.GA13001@lst.de>
References: <1465316612-9649-1-git-send-email-shaun@tancheff.com> <1465317133-13266-1-git-send-email-shaun@tancheff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465317133-13266-1-git-send-email-shaun@tancheff.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
