Return-Path: <axboe@kernel.dk>
Subject: Re: unify and streamline the blk-mq make_request implementations V3
To: Christoph Hellwig <hch@lst.de>
References: <20170322190153.12217-1-hch@lst.de>
Cc: Bart.VanAssche@sandisk.com, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e13613b5-5900-67b3-2c5c-02b717e6c010@kernel.dk>
Date: Wed, 22 Mar 2017 20:17:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170322190153.12217-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/22/2017 01:01 PM, Christoph Hellwig wrote:
> A bunch of cleanups to get us a nice I/O submission path.
> 
> Changes since V2:
>  - really address the comments from Bart
>  - address another comment from Bart
> 
> Changes since V1:
>  - rebase on top of the recent blk_mq_try_issue_directly changes
>  - incorporate comments from Bart

Added for 4.12, thanks.

-- 
Jens Axboe
