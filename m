Return-Path: <lsf-bounces@lists.linux-foundation.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <46f16799-86d9-7bf5-6346-be08801dd48e@suse.de>
Date: Sat, 18 Mar 2017 07:15:52 -0400
Message-Id: <C191DA3B-3852-4304-A534-008088F97BA7@linaro.org>
References: <cover.1489787289.git.osandov@fb.com>
	<46f16799-86d9-7bf5-6346-be08801dd48e@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, lsf@lists.linux-foundation.org,
	Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com
Subject: Re: [Lsf] [RFC PATCH 0/4] blk-mq: multiqueue I/O scheduler
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf>,
	<mailto:lsf-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf/>
List-Post: <mailto:lsf@lists.linux-foundation.org>
List-Help: <mailto:lsf-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf>,
	<mailto:lsf-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: lsf-bounces@lists.linux-foundation.org
Errors-To: lsf-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>


> Il giorno 18 mar 2017, alle ore 07:14, Hannes Reinecke <hare@suse.de> ha =
scritto:
> =

> On 03/17/2017 11:03 PM, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>> =

>> This patch series implements an I/O scheduler for multiqueue devices
>> combining several techniques: the scalable bitmap library, the new
>> blk-stats API, and queue depth throttling similar to blk-wbt.
>> =

>> These patches are on top of my earlier blk-stats series [1]. They also
>> need a fix in Jens' for-linus branch in order to work properly [2].
>> =

>> Patches 1 and 2 implement a new sbitmap operation and patch 3 exports a
>> required function. Patch 4 implements the new scheduler, named Kyber.
>> =

>> The commit message in patch 4 describes Kyber in detail. The scheduler
>> employs some heuristics that I've experimented with, but that's probably
>> the area that needs the most work. I'll be at LSF/MM next week, and
>> there's currently a lightning talk on the schedule to discuss
>> improvements and extensions.
>> =

> [ .. ]
> =

> A silent round of applause for you.
> Very much appreciated.
> =

> And actually, I have been looking at properly supporting host-wide tag
> maps, so the concept of 'shallow' queue depth might be the way to go here.
> =

> And as I have some other questions, too (assigning a new tag on
> requeue?) it might be an idea to spread this out into a formal session
> at LSF. If there are some slots left, that is.
> =


I would be very interested in such a discussion too.

Thanks,
Paolo

> Cheers,
> =

> Hannes
> -- =

> Dr. Hannes Reinecke		      zSeries & Storage
> hare@suse.de			      +49 911 74053 688
> SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
> GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
> _______________________________________________
> Lsf mailing list
> Lsf@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf

_______________________________________________
Lsf mailing list
Lsf@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf
