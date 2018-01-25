Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
To: Javier Gonzalez <javier@cnexlabs.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <986429B2-A254-4247-AA4F-F631A565DA8B@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <52189623-69cf-79cd-d2e3-af2e202c01ec@lightnvm.io>
Date: Thu, 25 Jan 2018 22:02:41 +0100
MIME-Version: 1.0
In-Reply-To: <986429B2-A254-4247-AA4F-F631A565DA8B@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM ATTEND] OCSSD topics
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On 01/25/2018 04:26 PM, Javier Gonzalez wrote:
> Hi,
> 
> There are some topics that I would like to discuss at LSF/MM:
>    - In the past year we have discussed a lot how we can integrate the
>      Open-Channel SSD (OCSSD) spec with zone devices (SMR). This
>      discussion is both at the interface level and at an in-kernel level.
>      Now that Damien's and Hannes' patches are upstreamed in good shape,
>      it would be a good moment to discuss how we can integrate the
>      LightNVM subsystem with the existing code. 

The ZBC-OCSSD patches 
(https://github.com/OpenChannelSSD/linux/tree/zbc-support) that I made 
last year is a good starting point.

Specifically, in ALPSS'17
>      we had discussions on how we can extend the kernel zoned device
>      interface with the notion of parallel units that the OCSSD geometry
>      builds upon. We are now bringing the OCSSD spec. to standarization,
>      but we have time to incorporate feedback and changes into the spec.

Which spec? the OCSSD 2 spec that I have copyright on? I don't believe 
it has been submitted or is under consideration to any standards body 
yet and I don't currently plan to do that.

You might have meant "to be finalized". As you know, I am currently 
soliciting feedback and change requests from vendors and partners with 
respect to the specification and is planning on closing it soon. If CNEX 
is doing their own new specification, please be open about it, and don't 
put it under the OCSSD name.

>      
>      Some of the challenges are (i) adding vector I/O interface to the
>      bio structure and (ii) extending the report zone to have the notion
>      of parallelism. I have patches implementing the OCSSD 2.0 spec that
>      abstract the geometry and allow upper layers to deal with write
>      restrictions and the parallelism of the device, but this is still
>      very much OCSSD-specific.

For the vector part, one can look into Ming's work on multi-page bvec 
(https://lkml.org/lkml/2017/12/18/496). When that code is in, it should 
be possible to implement the rest. One nagging feeling I have is that 
the block core code need to be updated to understand vectors. That will 
be complex given I/O checks are all based on ranges and is cheap, while 
for vectors it is significantly more expensive due to each LBA much be 
checked individually (one reason it is a separate subsystem). It might 
not be worth it until the vector api has broader market adoption. For 
example supported natively in the NVMe specification.

For extending report zones, one can do (start LBA:end LBA) (similarly to 
the device mapper interface), and then have a list of those to describe 
the start and end of each parallel unit.

> 
>    - I have started to use the above to do a f2fs implementation, where
>      we would implement the data placement and I/O scheduling directly in
>      the FS, as opposed to using pblk - at least for the journaled part.
>      The random I/O partition necessary for metadata can either reside in
>      a different drive or use a pblk instance for it. This is very much
>      work in progress, so having feedback form the f2fs guys (or other
>      journaled file systems) would help to start the work in the right
>      direction. Maybe this is interesting for other file systems too...

We got much feedback from Jaegeuk. From his feedback, I did the ZBC work 
with f2fs, which used a single parallel unit. To improve on that, one 
solution is to extend dm-stripe to understand zones (it can already be 
configured correctly... but it should expose zone entries as well) and 
then use that for doing stripes across parallel units with f2fs. This 
would fit into the standard codebase and doesn't add a whole lot of 
OCSSD-only bits.

> 
>    - Finally, now that pblk is becoming stable, and given the advent of
>      devices imposing sequential-only I/O, would it make sense to
>      generalize pblk as a device mapper translation layer that can be
>      used for random I/O partitions? 

dm-zoned fills this niche. Similarly as above, combine it with zone 
aware dm-stripe and it is a pretty good solution. However, given that 
pblk does a lot more than making I/Os sequential, I can see why it will 
be nice to have as a device mapper. It could be the dual-solution that 
we previously discussed, where pblk can use either the traditional 
scalar or vector interface, depending if the drive has exposed a 
separate vector interface.

We have ad internal use cases for
>      using such translation layer for frontswap devices. Maybe others are
>      looking at this too...
> 
> Javier
> 
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
