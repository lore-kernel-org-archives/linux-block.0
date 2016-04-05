Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Stephen Bates <stephen.bates@microsemi.com>
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <keith.busch@intel.com>
Subject: RE: [PATCH 0/2] Block: Give option to force io polling
Date: Tue, 5 Apr 2016 18:07:19 +0000
Message-ID: <D87A37E7A4AA544D853031D9A919C70B168CB351@avsrvexchmbx2.microsemi.net>
References: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
 <20160405123832.GA27788@infradead.org>
 <20160405155453.GB12625@localhost.localdomain>
 <20160405172749.GB31055@infradead.org>
In-Reply-To: <20160405172749.GB31055@infradead.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jon Derrick <jonathan.derrick@intel.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

> > I think it's more about providing opt-in control to make the
> > low-latency benefit reachable to users with existing programs.
> 
> What program benefits from unconditional polling for all I/O on a given
> device?

End users  who want to avail of the polling benefits for low latency NVMe devices without having to resort to rewriting their code would like to see something like what Jon is proposing. As I understand it this could be polling control per queue not per device but I can see caching applications where polling for the whole NVMe device would be desirable.

Stephen

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
