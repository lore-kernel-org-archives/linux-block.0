Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Theodore Ts'o <tytso@mit.edu>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <SN2PR04MB2191BE43398C84C4D262960488600@SN2PR04MB2191.namprd04.prod.outlook.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <6ef654fa-292e-ed9d-b8b6-fe4282fb1ef1@bjorling.me>
Date: Fri, 6 Jan 2017 14:05:34 +0100
MIME-Version: 1.0
In-Reply-To: <SN2PR04MB2191BE43398C84C4D262960488600@SN2PR04MB2191.namprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 01/05/2017 11:58 PM, Slava Dubeyko wrote:
> Next point is read disturbance. If BER of physical page/block achieves some threshold then
> we need to move data from one page/block into another one. What subsystem will be
> responsible for this activity? The drive-managed case expects that device's GC will manage
> read disturbance issue. But what's about host-aware or host-managed case? If the host side
> hasn't information about BER then the host's software is unable to manage this issue. Finally,
> it sounds that we will have GC subsystem as on file system side as on device side. As a result,
> it means possible unpredictable performance degradation and decreasing device lifetime.
> Let's imagine that host-aware case could be unaware about read disturbance management.
> But how host-managed case can manage this issue?

The OCSSD interface uses a couple of methods:

1) Piggy back soft ECC errors onto the completion entry. Tells the host
that a block properly should be refreshed when appropriate.
2) Use an asynchronous interface, e.g., NVMe get log page. Report blocks
through this interface that has been read disturbed. This may be coupled
with the various processes running on the SSD.
3) (That Ted suggested). Expose a "reset" bit in the Report Zones
command to let the host know which blocks should be reset. If the
plumbing for 2) is not available, or the information has been lost on
the host side, this method can be used to "resync".

> 
> Bad block management... So, drive-managed and host-aware cases should be completely unaware
> about  bad blocks. But what's about host-managed case? If a device will hide bad blocks from
> the host then it means mapping table presence, access to logical pages/blocks and so on. If the host
> hasn't access to the bad block management then it's not host-managed model. And it sounds as
> completely unmanageable situation for the host-managed model. Because if the host has access
> to bad block management (but how?) then we have really simple model. Otherwise, the host
> has access to logical pages/blocks only and device should have internal GC. As a result,
> it means possible unpredictable performance degradation and decreasing device lifetime because
> of competition of GC on device side and GC on the host side.

Agree. depending on the use-case, one may expose a "perfect" interface
to the host, or one may expose an interface where media errors may be
reported to the host. The former case are great for consumer units,
where I/O predictability isn't critical, and similarly if I/O
predictability is critical, the media errors can be reported, and the
host may deal with them appropriately.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
