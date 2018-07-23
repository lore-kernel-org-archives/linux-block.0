Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
 <20180723071803.GA30817@infradead.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <4517e5f9-84db-aa1f-609f-a01f1d4f5d79@gmail.com>
Date: Mon, 23 Jul 2018 20:59:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180723071803.GA30817@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Thanks for the reply :)


On 2018/7/23 15:18, Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But to me it seems that btrfs and maybe ext4 as well would be much
> better off just setting a per-IO priority in the bio.
>
> Any chance yo could look into that?

In fact, my tool does not report any defects in btrfs and ext4.


Best wishes,
Jia-Ju Bai
