Return-Path: <mlyle@lyle.org>
MIME-Version: 1.0
In-Reply-To: <35deaddb-fcd8-c4b0-4c5f-6cb8d8495a33@suse.de>
References: <35deaddb-fcd8-c4b0-4c5f-6cb8d8495a33@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Date: Thu, 19 Apr 2018 11:05:52 -0700
Message-ID: <CAJ+L6qdB0X=oqE7hUxvBsKHqC8BtEobrGz1nrNJsO5sdJ-Lvvg@mail.gmail.com>
Subject: Re: extra part in bcache patch commit 539d39eb2708
To: Coly Li <colyli@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-bcache <linux-bcache@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "tang.junhui" <tang.junhui@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi everyone--

On Wed, Apr 18, 2018 at 10:17 PM, Coly Li <colyli@suse.de> wrote:
> Hi Michael and Jens
>
> When I do back port of bcache patches, I find commit 539d39eb2708
> ("bcache: fix wrong return value in bch_debug_init()") has extra part
> from the original patch which Junhui Tanng posted.

Sorry, I must have messed up a rebase.  The patch it was combined with is here:
https://www.spinics.net/lists/linux-bcache/msg05464.html  and was
properly signed off and reviewed.

Mike
