Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2 0/4] fix a few problems in block layer
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>, Christoph Hellwig
 <hch@lst.de>, Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <63b3bbc5-1f7a-9d8e-9434-a19725c6083d@kernel.dk>
Date: Thu, 1 Mar 2018 08:41:49 -0700
MIME-Version: 1.0
In-Reply-To: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/27/18 5:07 AM, Jiufei Xue wrote:
> I have found a few problems while reviewing the patch 74d46992e0d9
> ("block: replace bi_bdev with a gendisk pointer and partitions index"),
> So fix them.

Applied 1-3 for 4.16, thanks.

-- 
Jens Axboe
