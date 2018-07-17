Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] pktcdvd:checkpatch:Remove assignment if condition
From: Jens Axboe <axboe@kernel.dk>
To: RAGHU Halharvi <raghuhack78@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20180717170212.17197-1-raghuhack78@gmail.com>
 <96cc7712-bbc3-25fa-06ce-876bd8068f61@kernel.dk>
Message-ID: <6c46fb77-93d4-a24a-a99e-07242a597b67@kernel.dk>
Date: Tue, 17 Jul 2018 16:17:00 -0600
MIME-Version: 1.0
In-Reply-To: <96cc7712-bbc3-25fa-06ce-876bd8068f61@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/17/18 4:14 PM, Jens Axboe wrote:
> On 7/17/18 11:02 AM, RAGHU Halharvi wrote:
>> * Remove checkpatch errors caused due to assignment operation in if
>> condition
> 
> Applied all three patches, thanks.

I take that back, only patch #1 actually applies. Please resend the
other two in a series, which apply to my for-4.19/block branch.

-- 
Jens Axboe
