Subject: Re: [PATCHSET v4] blk-mq-scheduling framework
To: Paolo Valente <paolo.valente@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
 <7A8A5078-E9B8-4EBF-BAB1-9E8EEBF3A043@linaro.org>
 <dd9501e9-5fc2-66d3-5c62-f8b727a6b6c9@fb.com>
 <CF1D593B-8BD0-4B59-9193-9D1D4E8BE3E4@linaro.org>
 <f5303f81-811a-8d0a-b271-d091d8839778@fb.com>
 <37570439-97C8-4009-B143-C5E78789A137@linaro.org>
 <b258d716-5c9a-c999-cec4-6bea38a8b975@fb.com>
 <C5DAF0C3-0509-4297-B12F-C436923A8311@linaro.org>
 <2028A64C-40E5-403D-B5E9-05863E94B4C5@linaro.org>
 <59b134de-5d2d-5f16-3118-bdc16bc6e36b@fb.com>
 <22EDFDE7-71FF-4265-8DDE-B141D3FD26B2@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>, Omar Sandoval <osandov@fb.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <d75c44df-8eac-b324-ac11-9bb7b6190603@fb.com>
Date: Mon, 23 Jan 2017 10:42:16 -0700
MIME-Version: 1.0
In-Reply-To: <22EDFDE7-71FF-4265-8DDE-B141D3FD26B2@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 10:04 AM, Paolo Valente wrote:
> 
>> Il giorno 18 gen 2017, alle ore 17:21, Jens Axboe <axboe@fb.com> ha scritto:
>>
>> On 01/18/2017 08:14 AM, Paolo Valente wrote:
>>> according to the function blk_mq_sched_put_request, the
>>> mq.completed_request hook seems to always be invoked (if set) for a
>>> request for which the mq.put_rq_priv is invoked (if set).
>>
>> Correct, any request that came out of blk_mq_sched_get_request()
>> will always have completed called on it, regardless of whether it
>> had IO started on it or not.
>>
> 
> It seems that some request, after being dispatched, happens to have no
> mq.put_rq_priv invoked on it now or then.  Is it expected?  If it is,
> could you point me to the path through which the end of the life of
> such a request is handled?

I'm guessing that's a flush request. I added RQF_QUEUED to check for
that, if RQF_QUEUED is set, you know it has come from your get_request
handler.

I'm assuming that is it, let me know.

-- 
Jens Axboe
