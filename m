Subject: Re: [PATCH V6 1/3] uapi: sed-opal fix IOW for activate lsp to use
 correct struct
To: Scott Bauer <scott.bauer@intel.com>, linux-nvme@lists.infradead.org
References: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
Cc: David.Laight@ACULAB.COM, arnd@arndb.de, keith.busch@intel.com,
 jonathan.derrick@intel.com, hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <9cd7e86f-7d2f-f58e-65c1-7f7ddd85b904@fb.com>
Date: Tue, 14 Feb 2017 19:47:50 -0700
MIME-Version: 1.0
In-Reply-To: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/14/2017 05:29 PM, Scott Bauer wrote:
> The IOC_OPAL_ACTIVATE_LSP took the wrong strcure which would
> give us the wrong size when using _IOC_SIZE, switch it to the
> right structure.

Applied 1-3, thanks.

-- 
Jens Axboe
