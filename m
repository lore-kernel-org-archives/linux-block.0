Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -next] lightnvm: pblk: make symbol write_buffer_size
 static
To: Wei Yongjun <weiyongjun1@huawei.com>, Matias Bjorling <mb@lightnvm.io>,
 Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Cc: linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1528190112-15645-1-git-send-email-weiyongjun1@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f961c389-20d6-328e-d263-38f4ec9460dc@kernel.dk>
Date: Tue, 5 Jun 2018 09:19:19 -0600
MIME-Version: 1.0
In-Reply-To: <1528190112-15645-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/5/18 3:15 AM, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/lightnvm/pblk-init.c:23:14: warning:
>  symbol 'write_buffer_size' was not declared. Should it be static?

Added, thanks.

-- 
Jens Axboe
