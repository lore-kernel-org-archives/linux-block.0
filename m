Subject: Re: [PATCH V2] block: Fix secure erase
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20160815181754.GA9918@lst.de>
 <1471334375-2585-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpTtxX6k13kFZNQ0MiCXeaWneepZu4q1y=42ZBPQmu1ig@mail.gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-mmc <linux-mmc@vger.kernel.org>,
 linux-block@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f5a069ae-f4d1-b6f6-4cd9-fe95824602fb@fb.com>
Date: Fri, 19 Aug 2016 09:14:16 -0600
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpTtxX6k13kFZNQ0MiCXeaWneepZu4q1y=42ZBPQmu1ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/19/2016 05:52 AM, Ulf Hansson wrote:
> On 16 August 2016 at 09:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Commit 288dab8a35a0 ("block: add a separate operation type for secure
>> erase") split REQ_OP_SECURE_ERASE from REQ_OP_DISCARD without considering
>> all the places REQ_OP_DISCARD was being used to mean either. Fix those.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Fixes: 288dab8a35a0 ("block: add a separate operation type for secure erase")
>
> For the mmc parts:
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Jens, will you pick this up via your tree?

Already did, was applied 3 days ago.

-- 
Jens Axboe
