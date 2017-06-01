Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Thu, 1 Jun 2017 12:12:34 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Joseph Qi <jiangqi903@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
	linux-block@vger.kernel.org, boyu.mt@taobao.com,
	wenqing.lz@taobao.com, qijiang.qj@alibaba-inc.com
Subject: Re: blk-mq: free callback if error occurs in
 blk_mq_init_allocated_queue
Message-ID: <20170601191234.GA9902@vader.DHCP.thefacebook.com>
References: <728065d3-0100-514a-70b0-66b1cfe85480@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <728065d3-0100-514a-70b0-66b1cfe85480@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 01, 2017 at 01:02:40PM +0800, Joseph Qi wrote:
> From: Joseph Qi <qijiang.qj@alibaba-inc.com>
> 
> If error occurs, we have to free the allocated callback in
> blk_mq_init_allocated_queue to avoid memory leaking.

Nak. If blk_mq_init_allocated_queue() fails, we call blk_cleanup_queue()
which will do this.
