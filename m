Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Takashi Iwai <tiwai@suse.de>,  Paolo Valente <paolo.valente@linaro.org>,  linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
References: <s5ha7ooxbps.wl-tiwai@suse.de>
	<8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
Date: Tue, 11 Sep 2018 12:48:10 -0400
In-Reply-To: <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk> (Jens Axboe's
	message of "Tue, 11 Sep 2018 10:09:44 -0600")
Message-ID: <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>> Hi,
>> 
>> I noticed that bfq doesn't appear in the I/O scheduler list on
>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>> 
>> Is this already addressed?
>
> Haven't heard about this one before. What kernel did you last use that
> worked?

I'm guessing you just need to update the maximum number of policies:

/*
 * Maximum number of blkcg policies allowed to be registered concurrently.
 * Defined here to simplify include dependency.
 */
#define BLKCG_MAX_POLS          3

-Jeff
