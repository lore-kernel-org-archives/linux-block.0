Return-Path: <colyli@suse.de>
Subject: Re: [RFC] cleanup bcache bio handling
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180611194806.13222-1-hch@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <19c69615-821d-fd14-a682-a1ec1ce739eb@suse.de>
Date: Tue, 12 Jun 2018 12:40:08 +0800
MIME-Version: 1.0
In-Reply-To: <20180611194806.13222-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/6/12 3:48 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up various places where bcache is way too intimate
> with bio internals.  This is intended as a baseline for the multi-page
> biovec work, which requires some nasty workarounds for the existing
> code.
> 
> Note that I do not have a bcache test setup, so this will require
> some careful actual testing with whatever test cases are used for
> bcache.
> 
> Also the new bio_reused helper should be useful at least for MD raid,
> but that work is left for later.

Hi Christoph,

Thanks for the patches. I will setup a test environment to run bcache
workload with your patches.

Coly Li
