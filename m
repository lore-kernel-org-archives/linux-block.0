Subject: Re: [PATCH] block/sed: Fix opal user range check and unused variables
To: Jon Derrick <jonathan.derrick@intel.com>
References: <1488814864-28478-1-git-send-email-jonathan.derrick@intel.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 David Binderman <dcb314@hotmail.com>, Scott Bauer <scott.bauer@intel.com>,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <3b17e72f-e58c-8f21-0c0c-c0692db88aea@fb.com>
Date: Mon, 6 Mar 2017 13:15:15 -0700
MIME-Version: 1.0
In-Reply-To: <1488814864-28478-1-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/06/2017 08:41 AM, Jon Derrick wrote:
> Fixes check that the opal user is within the range, and cleans up unused
> method variables.

Applied, thanks.

-- 
Jens Axboe
