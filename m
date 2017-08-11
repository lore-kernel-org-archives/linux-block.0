Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/2] block, bfq: improve and
 refactor throughput-boosting logic
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, lucmiccio@gmail.com
References: <20170804053511.2389-1-paolo.valente@linaro.org>
 <66099037-D7F7-4803-B9A6-8A4866EAE43A@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <edf973bd-a99c-868e-4889-eea489dd975e@kernel.dk>
Date: Fri, 11 Aug 2017 08:58:30 -0600
MIME-Version: 1.0
In-Reply-To: <66099037-D7F7-4803-B9A6-8A4866EAE43A@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/10/2017 01:55 PM, Paolo Valente wrote:
> 
>> Il giorno 04 ago 2017, alle ore 07:35, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>> Hi,
>> these two patches improve throughput-boosting logic in two
>> aspects. The first patch refactors the parts of the device-idling
>> logic, related to throughput boosting, that are still scattered across
>> the source file bfq-iosched.c. The patch concetrates all the logic in
>> one function. The second patch fixes/improves device idling for
>> flash-based devices that have no internal queueing of I/O requests.
>>
>> The contribution in the first patch has been triggered by that in the
>> second patch: finding the change made by the second patch has been
>> more difficult than it had to be, because the logic that decides
>> whether to idle the device is scattered across three functions.
>>
>> The second patch provides a significant throghput boost, for random
>> I/O with flash-based non-queueing devices. For example, on a HiKey
>> board, throughput increases by up to 125%, growing, e.g., from 6.9MB/s
>> to 15.6MB/s with two or three random readers in parallel.
>>
> 
> Hi Jens,
> any idea about the fate of these two patches?

Queued up for 4.14.

-- 
Jens Axboe
