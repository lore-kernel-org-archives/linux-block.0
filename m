Return-Path: <prvs=75015a0de=msw@amzn.com>
Date: Tue, 7 Aug 2018 14:28:39 -0700
From: Matt Wilson <msw@amzn.com>
To: Anchal Agarwal <anchalag@amazon.com>
CC: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <fllinden@amazon.com>,
        <sblbir@amazon.com>, <msw@amazon.com>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
Message-ID: <20180807212839.GA30244@ued668862963453.ant.amazon.com>
References: <20180731213410.GA35291@kaos-source-ops-60001.pdx1.amazon.com>
 <df2a0476-d9d1-c6c9-6553-f459e890ce8b@kernel.dk>
 <20180801170603.GA32864@kaos-source-ops-60001.pdx1.amazon.com>
 <a9871e54-83bf-7557-2d2f-99e006ceadcf@kernel.dk>
 <9265896d-3f02-ff2f-8e02-3aca775f4087@kernel.dk>
 <20180807201247.GA21108@kaos-source-ops-60001.pdx1.amazon.com>
 <6f24ff4b-9373-2708-8342-96f190f17cbf@kernel.dk>
 <20180807211216.GA14371@kaos-source-ops-60001.pdx1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180807211216.GA14371@kaos-source-ops-60001.pdx1.amazon.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 07, 2018 at 09:12:16PM +0000, Anchal Agarwal wrote:
> Hi Jens,
> Thanks for accepting this. There is one small issue, I don't find any emails
> send by me on the lkml mailing list. I am not sure why it didn't land there,
> all I can see is your responses. Do you want one of us to resend the patch
> or will you be able to do it?

Hi Anchal,

Usually this is due to how DMARC is set up for amazon.com. When mail
lists relay your messages without taking ownership of the envelope, it
invalidates the DKIM signatures and the DMARC policy can cause email
to be flagged as forged / spam.

If you configure your mailer and git to use amzn.com instead of
amazon.com it may help, as the DMARC policy for amzn.com is "none"
[1] rather than "quarantine" for amazon.com [2].

--msw

[1] https://mxtoolbox.com/SuperTool.aspx?action=dmarc%3aamzn.com&run=toolpage
[2] https://mxtoolbox.com/SuperTool.aspx?action=dmarc%3aamazon.com&run=toolpage
