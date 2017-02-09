Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 8 Feb 2017 23:18:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
Message-ID: <20170209071819.GA20996@infradead.org>
References: <1486594815-2427-1-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1486594815-2427-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, hch@infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

I'm really not a fan of adding a global synchronization point for
no good reason.  Arnd's original patch looks fine to me, but if you
really don't want it I'd suggest to use memdup_user and just
dynamically allocate the structure.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
