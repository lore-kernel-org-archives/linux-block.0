Return-Path: <axboe@kernel.dk>
Subject: Re: blk-throttle: Move three assignments for the variable "ret" in
 tg_set_max()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org
References: <e734cafa-eec0-9d5b-b368-2de496a96c80@users.sourceforge.net>
 <75495d45-cfc4-9740-39e4-bd4c3e71232b@users.sourceforge.net>
 <20170123091510.GA3517@linux-x5ow.site>
 <130ce081-e9a2-4744-c74b-b73bea5ae98c@users.sourceforge.net>
 <20170123114609.GA8200@linux-x5ow.site>
 <849a1dbc-f4c0-caf0-ad7e-706c08127c68@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <736ca444-0157-4dbb-ef30-e59b36596c1f@kernel.dk>
Date: Mon, 23 Jan 2017 08:17:24 -0700
MIME-Version: 1.0
In-Reply-To: <849a1dbc-f4c0-caf0-ad7e-706c08127c68@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 05:06 AM, SF Markus Elfring wrote:
>>> We have got different preferences for the placement of error code settings.
>> Yes we do, so what's the point? Both are OK.
> 
> Can a function implementation be executed a bit faster in the case
> that error codes will usually only matter if they would be set after
> a concrete software failure

Don't turn this into a troll fest. Maintainability trumps performance.
Every time. See previous email for reasoning for that.

>> Please don't go down that road it opens so much potential for needless bikeshedding
>> and waste all of our (including your) time.
> 
> I would appreciate to clarify involved run time consequences a bit more.

How about you go and benchmark the before and after, and present some
compelling evidence based on those tests for why the change should be
made? The onus is on the submitter here, not the reviewer.

As I said in the previous email, don't bother sending these types of
patches for the block layer again. They are just going to be ignored.

-- 
Jens Axboe
