Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Jaegeuk Kim <jaegeuk@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <20170106010930.GC2064@jaegeuk.local>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <aff717e4-9d1c-fc86-2ad7-2a985113173d@bjorling.me>
Date: Fri, 6 Jan 2017 13:55:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170106010930.GC2064@jaegeuk.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>



On 01/06/2017 02:09 AM, Jaegeuk Kim wrote:
> Hello,
> 
> On 01/04, Damien Le Moal wrote:
> 
> ...
>>
>>> Finally, if I really like to develop SMR- or NAND flash oriented file
>>> system then I would like to play with peculiarities of concrete
>>> technologies. And any unified interface will destroy the opportunity 
>>> to create the really efficient solution. Finally, if my software
>>> solution is unable to provide some fancy and efficient features then
>>> guys will prefer to use the regular stack (ext4, xfs + block layer).
>>
>> Not necessarily. Again think in terms of device "model" and associated
>> feature set. An FS implementation may decide to support all possible
>> models, with likely a resulting incredible complexity. More likely,
>> similarly with what is happening with SMR, only models that make sense
>> will be supported by FS implementation that can be easily modified.
>> Example again here of f2fs: changes to support SMR were rather simple,
>> whereas the initial effort to support SMR with ext4 was pretty much
>> abandoned as it was too complex to integrate in the existing code while
>> keeping the existing on-disk format.
> 
> From the f2fs viewpoint, now we support single host-managed SMR drive having
> a portion of conventional zones. In addition, f2fs supports multiple devices
> [1], which enables us to use pure host-managed SMR which has no conventional
> zone, working with another small conventional partition.

That is a good approach. SSD controllers may even implement a small FTL
inside the device for the "conventional" zones. The size wouldn't be
that big and may only be used to bootstrap rest of the unit. A zone with
a couple hundred megabytes should do. That'll simplify having pblk on
the side next to f2fs.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
