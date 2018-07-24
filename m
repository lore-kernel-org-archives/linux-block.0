Return-Path: <axboe@kernel.dk>
Subject: Re: kill bio_clone_kmalloc and bio_clone_bioset
To: Christoph Hellwig <hch@lst.de>
Cc: Boaz Harrosh <ooo@electrozaur.com>, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com
References: <20180724075234.26861-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8539f366-178d-ee2d-7c24-2bf339f4caff@kernel.dk>
Date: Tue, 24 Jul 2018 13:43:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180724075234.26861-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/24/18 12:52 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes all but one users of the traditional deep bio clone,
> and then moves bio_clone_bioset to its only caller so that we get rid
> of the deep bio cloning in the block layer API.

Applied for 4.19.

-- 
Jens Axboe
