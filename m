Return-Path: <axboe@kernel.dk>
Subject: Re: [dm-devel] [PATCH] bio: have bio_kmap_irq return the size of
 mapped data (fwd)
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com
References: <alpine.LRH.2.02.1711071641090.1339@file01.intranet.prod.int.rdu2.redhat.com>
 <20171108094730.GA7074@infradead.org>
 <alpine.LRH.2.02.1711080733220.12294@file01.intranet.prod.int.rdu2.redhat.com>
 <20171108150559.GB10374@infradead.org>
 <650d7a0d-f344-155a-5b53-4ce368c4aca4@kernel.dk>
 <20171108153436.GA24548@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aabd8f47-3b9f-ffb5-474e-ab0841806a39@kernel.dk>
Date: Wed, 8 Nov 2017 08:36:25 -0700
MIME-Version: 1.0
In-Reply-To: <20171108153436.GA24548@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/08/2017 08:34 AM, Christoph Hellwig wrote:
> On Wed, Nov 08, 2017 at 08:20:58AM -0700, Jens Axboe wrote:
>> On top of that, there are no users of it at all...
> 
> But Mikulas wants to add one :)

I know...

> Note that __bio_kmap_atomic has the same issues, only has a single
> users either and would be cleaner if opencoded there as it already
> has the current bvec.  See patch below.

Kill them all with fire. The open coded version is much clearer.

-- 
Jens Axboe
