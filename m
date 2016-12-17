Subject: Re: [PATCH] block: loose check on sg gap
To: Ming Lei <ming.lei@canonical.com>, linux-kernel@vger.kernel.org
References: <1481971751-4016-1-git-send-email-ming.lei@canonical.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Dexuan Cui <decui@microsoft.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Mike Christie <mchristi@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Toshi Kani <toshi.kani@hpe.com>, Dan Williams <dan.j.williams@intel.com>,
 Damien Le Moal <damien.lemoal@hgst.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f470bfb2-9a82-dcc8-b018-5697d4694a1b@fb.com>
Date: Sat, 17 Dec 2016 09:49:35 -0700
MIME-Version: 1.0
In-Reply-To: <1481971751-4016-1-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/17/2016 03:49 AM, Ming Lei wrote:
> If the last bvec of the 1st bio and the 1st bvec of the next
> bio are contineous physically, and the latter can be merged
> to last segment of the 1st bio, we should think they don't
> violate sg gap(or virt boundary) limit.
> 
> Both Vitaly and Dexuan reported lots of unmergeable small bios
> are observed when running mkfs on Hyper-V virtual storage, and
> performance becomes quite low, so this patch is figured out for
> fixing the performance issue.
> 
> The same issue should exist on NVMe too sine it sets virt boundary too.

It looks pretty reasonable to me. I'll queue it up for some testing,
changes like this always make me a little nervous.

-- 
Jens Axboe
