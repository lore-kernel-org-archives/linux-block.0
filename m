Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC PATCH] cfq: Give a chance for arming slice idle timer in
 case of group_idle
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stummala@codeaurora.org, ankijain@codeaurora.org
References: <1502283512-4379-1-git-send-email-riteshh@codeaurora.org>
 <016b90bd-8fde-7494-0a1c-3bf623b53714@codeaurora.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <25fef483-9f23-0d59-908d-868d34642ee4@kernel.dk>
Date: Fri, 11 Aug 2017 09:00:12 -0600
MIME-Version: 1.0
In-Reply-To: <016b90bd-8fde-7494-0a1c-3bf623b53714@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/10/2017 11:15 PM, Ritesh Harjani wrote:
> Hi Jens,
> 
> Could you please take a look at below patch and the issue it is trying 
> to solve. Please let us know your thoughts on the below problem and the 
> patch.

It looks reasonable to me. I'll queue it up for 4.14.

-- 
Jens Axboe
