Return-Path: <ming.lei@redhat.com>
Date: Sat, 7 Oct 2017 12:48:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V3 3/3] block: don't print message for discard error
Message-ID: <20171007044825.GA17411@ming.t460p>
References: <cover.1507072136.git.shli@fb.com>
 <483d098388b5e697dad0b6bde952e8659d8fe545.1507072136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <483d098388b5e697dad0b6bde952e8659d8fe545.1507072136.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 04, 2017 at 07:52:45AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> discard error isn't fatal, don't flood discard error messages.
> 
> Suggested-by: Ming Lei <tom.leiming@gmail.com>
> Signed-off-by: Shaohua Li <shli@fb.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
