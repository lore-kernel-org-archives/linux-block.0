Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Message-ID: <5A71933B.1050908@hesbynett.no>
Date: Wed, 31 Jan 2018 10:58:19 +0100
From: David Brown <david.brown@hesbynett.no>
MIME-Version: 1.0
To: NeilBrown <neilb@suse.com>, Wols Lists <antlists@youngman.org.uk>,
	Johannes Thumshirn <jthumshirn@suse.de>, lsf-pc@lists.linux-foundation.org
References: <mqdvafkhep0.fsf@linux-x5ow.site>
	<5A6F4CA6.5060802@youngman.org.uk>
	<87fu6o5o83.fsf@notabene.neil.brown.name>
In-Reply-To: <87fu6o5o83.fsf@notabene.neil.brown.name>
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
	Neil Brown <neilb@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] De-clustered RAID with MD
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On 29/01/18 22:50, NeilBrown wrote:
> On Mon, Jan 29 2018, Wols Lists wrote:
> 
>> On 29/01/18 15:23, Johannes Thumshirn wrote:
>>> Hi linux-raid, lsf-pc
>>>
>>> (If you've received this mail multiple times, I'm sorry, I'm having
>>> trouble with the mail setup).
>>
>> My immediate reactions as a lay person (I edit the raid wiki) ...
>>>
>>> With the rise of bigger and bigger disks, array rebuilding times start
>>> skyrocketing.
>>
>> And? Yes, your data is at risk during a rebuild, but md-raid throttles
>> the i/o, so it doesn't hammer the system.
>>>
>>> In a paper form '92 Holland and Gibson [1] suggest a mapping algorithm
>>> similar to RAID5 but instead of utilizing all disks in an array for
>>> every I/O operation, but implement a per-I/O mapping function to only
>>> use a subset of the available disks.
>>>
>>> This has at least two advantages:
>>> 1) If one disk has to be replaced, it's not needed to read the data from
>>>    all disks to recover the one failed disk so non-affected disks can be
>>>    used for real user I/O and not just recovery and
>>
>> Again, that's throttling, so that's not a problem ...
> 
> Imagine an array with 100 drives on which we store data in sets of
> (say) 6 data chunks and 2 parity chunks.
> Each group of 8 chunks is distributed over the 100 drives in a
> different way so that (e.g) 600 data chunks and 200 parity chunks are
> distributed over 8 physical stripes using some clever distribution
> function.
> If (when) one drive fails, the 8 chunks in this set of 8 physical
> stripes can be recovered by reading 6*8 == 48 chunks which will each be
> on a different drive.  Half the drives deliver only one chunk (in an ideal
> distribution) and the other half deliver none.  Maybe they will deliver
> some for the next set of 100 logical stripes.
> 
> You would probably say that even doing raid6 on 100 drives is crazy.
> Better to make, e.g. 10 groups of 10 and do raid6 on each of the 10,
> then LVM them together.
> 
> By doing declustered parity you can sanely do raid6 on 100 drives, using
> a logical stripe size that is much smaller than 100.
> When recovering a single drive, the 10-groups-of-10 would put heavy load
> on 9 other drives, while the decluster approach puts light load on 99
> other drives.  No matter how clever md is at throttling recovery, I
> would still rather distribute the load so that md has an easier job.
> 

That sounds smart.  I don't see that you need anything particularly
complicated for how you distribute your data and parity drives across
the 100 disks - you just need a fairly even spread.

I would be more concerned with how you could deal with resizing such an
array.  In particular, I think it is not unlikely that someone with a
100 drive array will one day want to add another bank of 24 disks (or
whatever fits in a cabinet).  Making that work nicely would, I believe,
be more important than making sure the rebuild load distribution is
balanced evenly across 99 drives.

I would also be interested in how the data and parities are distributed
across cabinets and disk controllers.  When you manually build from
smaller raid sets, you can ensure that in set the data disks and the
parity are all in different cabinets - that way if an entire cabinet
goes up in smoke, you have lost one drive from each set, and your data
is still there.  With a pseudo random layout, you have lost that.  (I
don't know how often entire cabinets of disks die, but I once lost both
disks of a raid1 mirror when the disk controller card died.)


_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
