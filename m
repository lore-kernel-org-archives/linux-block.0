Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] blkcg: small fix on comment in blkcg_init_queue
To: Randy Dunlap <rdunlap@infradead.org>, Jiang Biao <jiang.biao2@zte.com.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
 zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn
References: <1524110666-106945-1-git-send-email-jiang.biao2@zte.com.cn>
 <b24cd922-01c7-ce14-6427-1a8dd7819e58@kernel.dk>
 <c79d16cb-739d-2ac8-9fa4-bd5f6671269a@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1695686e-40c0-6128-9b27-18cba7bf53ca@kernel.dk>
Date: Thu, 19 Apr 2018 11:23:39 -0600
MIME-Version: 1.0
In-Reply-To: <c79d16cb-739d-2ac8-9fa4-bd5f6671269a@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/19/18 11:10 AM, Randy Dunlap wrote:
> On 04/19/18 07:52, Jens Axboe wrote:
>> On 4/18/18 10:04 PM, Jiang Biao wrote:
>>> The comment before blkg_create() in blkcg_init_queue() was moved
>>> from blkcg_activate_policy() by commit ec13b1d6f0a0457312e615, but
>>> it does not suit for the new context.
>>
>> Applied - btw, in the future, if you send more than one patch in
>> a series, please include a cover letter.
> 
> Hi Jens,
> 
> Where does that cover letter requirement come from?  It's not documented
> anywhere AFAICT and shouldn't be needed for such small patch series.

It's not a requirement, I just strongly prefer it for anything that is
more than one patch. Hence I tend to let people know about that
preference, if they send patches more than once.

It makes it possible to send comments for the series as a whole.

-- 
Jens Axboe
