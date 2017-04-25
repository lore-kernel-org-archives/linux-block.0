Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH -next] lightnvm: fix possible memory leak in
 pblk_bb_discovery()
To: Wei Yongjun <weiyj.lk@gmail.com>, Matias Bjorling <mb@lightnvm.io>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <20170425161530.13445-1-weiyj.lk@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0e66dbc8-5349-b911-819d-5191598486c5@kernel.dk>
Date: Tue, 25 Apr 2017 09:44:55 -0700
MIME-Version: 1.0
In-Reply-To: <20170425161530.13445-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/25/2017 09:15 AM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> 'blks' is malloced in pblk_bb_discovery() and should be freed
> before leaving from the nvm_get_tgt_bb_tbl() error handling cases,
> otherwise it will cause memory leak. Also skip assign blks to
> rlun->bb_list when error.

Added for 4.12, thanks.

-- 
Jens Axboe
