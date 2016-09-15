Subject: Re: blk-mq: allow passing in an external queue mapping V3
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
 <20160915144050.GD16556@localhost.localdomain>
 <20160915143202.GA26221@lst.de>
Cc: tglx@linutronix.de, agordeev@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <de5c219e-fe1f-7524-6054-995ae2f734ae@fb.com>
Date: Thu, 15 Sep 2016 08:34:42 -0600
MIME-Version: 1.0
In-Reply-To: <20160915143202.GA26221@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/15/2016 08:32 AM, Christoph Hellwig wrote:
> Thanks for all the testing and the review Keith, as well as the
> fixes earlier.
>
> Jens, what do you think of the series?
>
> Thomas has added the first 5 patches to
>
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=irq/for-block
>
> so it would be great if we could pull that into a block branch and
> get the rest into the block tree sooner or later.

I was going to ask about splitting it, but that looks fine, I can pull
that in.

The series looks fine to me. My only real concern is giving drivers the
flexibility to define mappings, I don't want that to evolve into drivers
(again) doing stupid things wrt mappings. As long as we keep it strictly
as a tunnel for passing mappings defined by the (previous blk-mq) core
code, then that's fine.

-- 
Jens Axboe
