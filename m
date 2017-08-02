Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add comment to submit_bio_wait()
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org
References: <20170802082521.3925-1-jack@suse.cz>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78debb3f-8a31-0030-cea4-0c9bee03a5dc@kernel.dk>
Date: Wed, 2 Aug 2017 08:25:40 -0600
MIME-Version: 1.0
In-Reply-To: <20170802082521.3925-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/02/2017 02:25 AM, Jan Kara wrote:
> submit_bio_wait() does not consume bio reference. Add comment about
> that.

Thanks, added for 4.14.

-- 
Jens Axboe
