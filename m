Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Thu, 1 Sep 2016 10:45:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Subject: Re: blk-mq: allow passing in an external queue mapping V2
Message-ID: <20160901084509.GB4115@lst.de>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <20160830232824.GA2807@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20160830232824.GA2807@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 30, 2016 at 07:28:24PM -0400, Keith Busch wrote:
> Before, each mq hardware queue would have 2 CPUs, now it's terribly
> unbalanced.

Hmm.  This wasn't supposed to change the cpu mapping, an indeed I saw
results like that horrible one before as well.  Let me dig into this
with my fake lower queue count device.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
