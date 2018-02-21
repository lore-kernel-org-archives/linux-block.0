Return-Path: <prvs=583440fc3=bart.vanassche@wdc.com>
Subject: Re: [PATCH v3 0/3] Fix races between blkcg code and request queue
 initialization and cleanup
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>
References: <20180209184405.25835-1-bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <98646c21-9f4e-6014-1335-1f2d66bf9730@wdc.com>
Date: Wed, 21 Feb 2018 14:51:53 -0800
MIME-Version: 1.0
In-Reply-To: <20180209184405.25835-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 02/09/18 10:44, Bart Van Assche wrote:
> Recently Joseph Qi identified races between the block cgroup code and request
> queue initialization and cleanup. This patch series address these races. Please
> consider these patches for kernel v4.17.

Hello Joseph,

Can you add your Tested-by or Reviewed-by to the patches in this series?

Thanks,

Bart.
