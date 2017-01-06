Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
To: Theodore Ts'o <tytso@mit.edu>, Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <SN2PR04MB2191BE43398C84C4D262960488600@SN2PR04MB2191.namprd04.prod.outlook.com>
 <20170106011144.fbfqx4ksr7dtsy5p@thunk.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <b2bd6ba8-4b2d-0e4b-df0a-27894a6ca186@bjorling.me>
Date: Fri, 6 Jan 2017 13:51:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170106011144.fbfqx4ksr7dtsy5p@thunk.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 01/06/2017 02:11 AM, Theodore Ts'o wrote:
> On Thu, Jan 05, 2017 at 10:58:57PM +0000, Slava Dubeyko wrote:
>>
>> Next point is read disturbance. If BER of physical page/block achieves some threshold then
>> we need to move data from one page/block into another one. What subsystem will be
>> responsible for this activity? The drive-managed case expects that device's GC will manage
>> read disturbance issue. But what's about host-aware or host-managed case? If the host side
>> hasn't information about BER then the host's software is unable to manage this issue. Finally,
>> it sounds that we will have GC subsystem as on file system side as on device side. As a result,
>> it means possible unpredictable performance degradation and decreasing device lifetime.
>> Let's imagine that host-aware case could be unaware about read disturbance management.
>> But how host-managed case can manage this issue?
> 
> One of the ways this could be done in the ZBC specification (assuming
> that erase blocks == zones) would be set the "reset" bit in the zone
> descriptor which is returned by the REPORT ZONES EXT command.  This is
> a hint that the a reset write pointer should be sent to the zone in
> question, and it could be set when you start seeing soft ECC errors or
> the flash management layer has decided that the zone should be
> rewritten in the near future.  A simple way to do this is to ask the
> Host OS to copy the data to another zone and then send a reset write
> pointer command for the zone.

This is an interesting approach. Currently, the OCSSD interface uses
both the soft ECC mark to tell the host to rewrite, while the interface
also has an explicit method to make the host rewrite the data. E.g., in
the case where read scrubbing on the device requires the host to move
data due to durability.

Adding the information to the "Report zones" is a good idea. It enables
the device to keep a list of "zones" that should be refreshed by the
host but have yet to have it done. I will add that to the specification.

> 
> So I think it very much could be done, and done within the framework
> of the ZBC model --- although whether SSD manufactuers will chose to
> do this, and/or choose to engage the T10/T13 standards committees to
> add the necessary extensions to the ZBC specification is a question
> that we probably can't answer in this venue or by the participants on
> this thread.
> 
>> Wear leveling... Device will be responsible to manage wear-leveling for the case of device-managed
>> and host-aware models. It looks like that the host side should be responsible to manage wear-leveling
>> for the host-managed case. But it means that the host should manage bad blocks and to have direct
>> access to physical pages/blocks. Otherwise, physical erase blocks will be hidden by device's indirection
>> layer and wear-leveling management will be unavailable on the host side. As a result, device will have
>> internal GC and the traditional issues (possible unpredictable performance degradation and decreasing
>> device lifetime).
> 
> So I can imagine a setup where the flash translation layer manages the
> mapping between zone numbers and the physical erase blocks, such that
> when the host OS issues an "reset write pointer", it immediately gets
> a new erase block assigned to the specific zone in question.  The
> original erase block would then get erased in the background, when the
> flash chip in question is available for maintenance activities.
> 
> I think you've been thinking about a model where *either* the host as
> complete control over all aspects of the flash management, or the FTL
> has complete control --- and it may be that there are more clever ways
> that the work could be split between flash device and the host OS.
> 
>> Another interesting question... Let's imagine that we create file system volume for one device
>> geometry. It means that geometry details will be stored in the file system metadata during volume
>> creation for the case host-aware or host-managed case. Then we backups this volume and restore
>> the volume on device with completely different geometry. So, what will we have for such case?
>> Performance degradation? Or will we kill the device?
> 
> This is why I suspect that exposing the full details of the details of
> the Flash layout via LUNS is a bad, bad, BAD idea.  It's much better
> to use an abstraction such as Zones, and then have an abstraction
> layer that hides the low-level details of the hardware from the OS.
> The trick is picking an abstraction that exposes the _right_ set of
> details so that the division of labor betewen the Host OS and the
> storage device is at a better place.  Hence my suggestion of perhaps
> providing a virtual mapping layer betewen "Zone number" and the
> low-level physical erase block.

Agree. The first approach was taken in the first iteration of the
specification. After release we began to understand the chaos we just
brought onto our self, we moved to the zone/chunk approach in the second
iteration to simplify the interface.

> 
>> I would like to have access channels/LUNs/zones on file system level.
>> If, for example, LUN will be associated with partition then it means
>> that it will need to aggregate several partitions inside of one volume.
>> First of all, not every file system is ready for the aggregation several
>> partitions inside of the one volume. Secondly, what's about aggregation
>> several physical devices inside of one volume? It looks like as slightly
>> tricky to distinguish partitions of the same device and different devices
>> on file system level. Isn't it?
> 
> Yes, this is why using LUN's are a BAD idea.  There's too much code
> --- in file systems, in the block layer in terms of how we expose
> block devices, etc., that assumes that different LUN's are used for
> different logical containers of storage.  There has been decades of
> usage of this concept by enterprise storage arrays.  Trying to
> appropriate LUN's for another use case is stupid.  And maybe we can't
> stop OCSSD folks if they have gone down that questionable design path,
> but there's nothing that says we have to expose it as a SCSI LUN
> inside of Linux!

Heh, yes, really bad idea. The naming of "LUNs" for OCSSDs could have
been chosen better. In the future, it is being renamed to "parallel
unit". For OCSSDs, all the device's parallel units are exposed through
the same block device "LUN", which then has to be managed by the layers
above.

> 
>> OK. But I assume that SMR zone "reset" is significantly cheaper than
>> NAND flash block erase operation. And you can fill your SMR zone with
>> data then "reset" it and to fill again with data without significant penalty.
> 
> If you have virtual mapping layer between zones and erase blocks, a
> reset write pointer could be fast for SSD's as well.  And that allows
> the implementation of your suggestion below:
> 
>> Also, TRIM and zone "reset" are different, I suppose. Because, TRIM looks
>> like as a hint for SSD controller. If SSD controller receives TRIM for some
>> erase block then it doesn't mean  that erase operation will be done
>> immediately. Usually, it should be done in the background because real
>> erase operation is expensive operation.
> 
> Cheers,
> 
> 					- Ted
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
