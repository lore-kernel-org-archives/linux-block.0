Return-Path: <axboe@kernel.dk>
Subject: Re: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
To: David Zarzycki <dave@znu.io>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
 <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
 <7E93BF17-8476-4A93-BD27-D2E22E5DAB00@znu.io>
 <6025644f-e147-903a-e836-a2f53d3a61e9@kernel.dk>
 <79205A92-2997-45D6-9277-6F56EC7CA989@znu.io>
 <e492ffee-6a04-4f84-a22e-6d71486dbe07@kernel.dk>
 <5103A5A8-E737-4ADC-939E-ACE84AD7DB70@znu.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <07497a18-f638-d764-140a-c0de762571c2@kernel.dk>
Date: Tue, 23 Jan 2018 11:00:06 -0700
MIME-Version: 1.0
In-Reply-To: <5103A5A8-E737-4ADC-939E-ACE84AD7DB70@znu.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/23/18 10:54 AM, David Zarzycki wrote:
> Hi Jens,
> 
> The bug still reproduces with this change. How confident are we that
> kernel objects are properly reference counted while they are
> throttled?

I would be surprised if it made a change, thanks for checking. Since
you're not pulling devices out of your system, is really nothing that
needs ref counting here. You don't have something running turning wbt
on/off during the run, I assume?

The whole thing is very odd. You do have lots of processes exiting with
segfaults and similar. The only thing I can think of is the wait queue
entry becoming invalid since it's on the stack, but I don't see how that
can happen. We should exit the wait path normally and remove ourselves
from the list.

-- 
Jens Axboe
