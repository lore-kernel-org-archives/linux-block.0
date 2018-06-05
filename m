Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5] block: add verifier for cmdline partition
To: Wang YanQing <udknight@gmail.com>, gregkh@linuxfoundation.org,
 pombredanne@nexb.com, tglx@linutronix.de, caizhiyong@hisilicon.com,
 rdunlap@infradead.org, jiangheng@hisilicon.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180510030637.GA25734@udknight>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b23c64e5-6768-9387-517c-59deded8a331@kernel.dk>
Date: Tue, 5 Jun 2018 09:21:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180510030637.GA25734@udknight>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/9/18 9:06 PM, Wang YanQing wrote:
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
> 
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will log a warning. We don't
> treat overlaps partition as a error:
> "
> Caizhiyong <caizhiyong@hisilicon.com> said:
> Partition overlap was intentionally designed in this cmdline partition.
> reference http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html
> "

Applied, thanks.

-- 
Jens Axboe
