Return-Path: <hch@lst.de>
Date: Thu, 8 Mar 2018 08:44:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, caspar@linux.alibaba.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 2/4] block: bio_check_eod() needs to consider partition
Message-ID: <20180308074410.GD15748@lst.de>
References: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com> <20096c45-3e41-f24a-9fd6-f733f6d7c78e@linux.alibaba.com> <20180228174809.GA18158@lst.de> <431e8dd7-1e44-2dea-8e48-4f2400e01e1e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <431e8dd7-1e44-2dea-8e48-4f2400e01e1e@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 09:23:06AM +0800, Jiufei Xue wrote:
> I think the check should be done twice if the bi_partno is not zero,
> one for the partition, and another for the whole disk after remap which
> is add in the commit 5ddfe9691c91
> ("md: check bio address after mapping through partitions").

Why?  If the partitions has an incorrect size we already catch it during
parsing in rescan_partitions().
