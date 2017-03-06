Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Mon, 6 Mar 2017 09:13:23 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] block/sed: Fix opal user range check and unused variables
Message-ID: <20170306161323.GA1951@sbauer-Z170X-UD5>
References: <1488814864-28478-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
In-Reply-To: <1488814864-28478-1-git-send-email-jonathan.derrick@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org,
 Rafael Antognolli <rafael.antognolli@intel.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 David Binderman <dcb314@hotmail.com>, Keith Busch <keith.busch@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 06, 2017 at 08:41:04AM -0700, Jon Derrick wrote:
> Fixes check that the opal user is within the range, and cleans up unused
> method variables.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
