Subject: Re: blk-mq: allow passing in an external queue mapping V3
To: Christoph Hellwig <hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <20160915144050.GD16556@localhost.localdomain>
 <20160915143202.GA26221@lst.de> <de5c219e-fe1f-7524-6054-995ae2f734ae@fb.com>
 <20160915144212.GA26430@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, tglx@linutronix.de,
 agordeev@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <1c3794ac-4890-adf4-e953-3d57ab545cd2@fb.com>
Date: Thu, 15 Sep 2016 08:44:44 -0600
MIME-Version: 1.0
In-Reply-To: <20160915144212.GA26430@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/15/2016 08:42 AM, Christoph Hellwig wrote:
> On Thu, Sep 15, 2016 at 08:34:42AM -0600, Jens Axboe wrote:
>> I was going to ask about splitting it, but that looks fine, I can pull
>> that in.
>>
>> The series looks fine to me. My only real concern is giving drivers the
>> flexibility to define mappings, I don't want that to evolve into drivers
>> (again) doing stupid things wrt mappings. As long as we keep it strictly
>> as a tunnel for passing mappings defined by the (previous blk-mq) core
>> code, then that's fine.
>
> So my earlier versions just passed in the affinity mask and left
> all the mapping in the core.  This doesn't really work anymore with
> the sibling aware code so I had to add a method.  That being said there
> are some drivers that might want slightly different mappings.
>
> For example skd (if converted to blk-mq) has MSI-X vectors for it's up
> to four queues, but it also has MSI-X vectors for misc book keeping
> before those, so we'd need a version of our PCI mapping that adds an
> offset to add to queue number when assining the MSI-X vectors.
>
> That being said I structured the map_queues interface so it can't do
> anything crazy - it can just build up the cpu to queue mapping array
> so there isn't exactly a whole lot of crazy things a driver could do.

By crazy, I mean even things like thinking it knows better and defining
mappings differently just because it can. But I'm not too worried about
it, it's just something to watch for that we didn't have to care about
before, as the mappings were completely mandated by the core code.

-- 
Jens Axboe
