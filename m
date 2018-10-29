Return-Path: <ming.lei@redhat.com>
Date: Mon, 29 Oct 2018 10:49:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] blk-mq: refactor the code of issue request
 directly
Message-ID: <20181029024937.GC32606@ming.t460p>
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
 <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Sat, Oct 27, 2018 at 12:01:09AM +0800, Jianchao Wang wrote:
> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> into one interface which is able to handle the return value from
> .queue_rq callback. Due to we can only issue directly w/o io
> scheduler, so remove the blk_mq_get_driver_tag.

It isn't correct for dm-rq, see blk_insert_cloned_request().

Thanks,
Ming
