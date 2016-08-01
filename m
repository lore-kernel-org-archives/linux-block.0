Return-Path: <hch@lst.de>
Date: Mon, 1 Aug 2016 11:41:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaun Tancheff <shaun@tancheff.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jeff Layton <jlayton@poochiereds.net>,
	"J . Bruce Fields" <bfields@fieldses.org>,
	Josh Bingaman <josh.bingaman@seagate.com>
Subject: Re: [PATCH v6 0/2] Block layer support ZAC/ZBC commands
Message-ID: <20160801094116.GB14677@lst.de>
References: <1469818955-20568-1-git-send-email-shaun@tancheff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469818955-20568-1-git-send-email-shaun@tancheff.com>
List-ID: <linux-block@vger.kernel.org>


Can you please integrate this with Hannes series so that it uses
his cache of the zone information?
