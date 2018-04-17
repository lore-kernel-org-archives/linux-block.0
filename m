Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
        ming.lei@redhat.com, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com>
 <2612135.Ur0PZolWSD@merkaba>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
Date: Tue, 17 Apr 2018 22:34:08 +0800
MIME-Version: 1.0
In-Reply-To: <2612135.Ur0PZolWSD@merkaba>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Martin

On 04/17/2018 08:10 PM, Martin Steigerwald wrote:
> For testing it I add it to 4.16.2 with the patches I have already?

You could try to only apply this patch to have a test. :)

> 
> - '[PATCH] blk-mq_Directly schedule q->timeout_work when aborting a 
> request.mbox'
> 
> - '[PATCH v2] block: Change a rcu_read_{lock,unlock}_sched() pair into 
> rcu_read_{lock,unlock}().mbox'
> 
> - '[PATCH V4 1_2] blk-mq_set RQF_MQ_TIMEOUT_EXPIRED when the rq'\''s 
> timeout isn'\''t handled.mbox'
> 
> - '[PATCH V4 2_2] blk-mq_fix race between complete and 
> BLK_EH_RESET_TIMER.mbox


Thanks
Jianchao
