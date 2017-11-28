Return-Path: <hch@lst.de>
Date: Tue, 28 Nov 2017 13:44:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Add default switch case to
	blk_pm_allow_request() to kill warning
Message-ID: <20171128124415.GC30487@lst.de>
References: <1511815254-18166-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1511815254-18166-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-block@vger.kernel.org>

What an annoying compiler :)

But otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
