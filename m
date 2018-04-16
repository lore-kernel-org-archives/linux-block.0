Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: mark hctx RESTART when get budget fails
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523865336-17326-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180416081503.GB23664@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <11e10ccf-bdeb-4790-3bec-e3f49ab246c8@oracle.com>
Date: Mon, 16 Apr 2018 16:34:43 +0800
MIME-Version: 1.0
In-Reply-To: <20180416081503.GB23664@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

Thanks for your kindly response.

On 04/16/2018 04:15 PM, Ming Lei wrote:
>> -		if (!blk_mq_get_dispatch_budget(hctx))
>> +		if (!blk_mq_get_dispatch_budget(hctx)) {
>> +			blk_mq_sched_mark_restart_hctx(hctx);
> The RESTART flag still may not take into effect if all requests are
> completed before calling blk_mq_sched_mark_restart_hctx().
> 

Yes, this is indeed a very tricky scenario.

Sincerely
Jianchao
