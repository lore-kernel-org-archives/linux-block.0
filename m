Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 00/12] More patches for kernel v4.13
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4253f45a-cafd-6529-d773-bb7494cefab5@kernel.dk>
Date: Tue, 20 Jun 2017 19:27:46 -0600
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 12:15 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> This patch series contains one patch that reduces the size of struct
> blk_mq_hw_ctx, a few patches that simplify some of the block layer code and
> also patches that improve the block layer documentation. Please consider these
> patches for kernel v4.13. This patch series survives the following tests:
> 
> srp-test/run_tests -r 30 -e none
> srp-test/run_tests -r 30 -e deadline
> srp-test/run_tests -r 30 -e kyber
> srp-test/run_tests -r 30 -e bfq
> 
> The basis for these patches is your for-next branch.

Applied, thanks Bart.

-- 
Jens Axboe
