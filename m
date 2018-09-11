Return-Path: <axboe@kernel.dk>
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To: Takashi Iwai <tiwai@suse.de>, Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
Date: Tue, 11 Sep 2018 10:09:44 -0600
MIME-Version: 1.0
In-Reply-To: <s5ha7ooxbps.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/11/18 10:03 AM, Takashi Iwai wrote:
> Hi,
> 
> I noticed that bfq doesn't appear in the I/O scheduler list on
> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
> bfq_init() returns -ENOSPC, hence the probe aborts silently.
> 
> Is this already addressed?

Haven't heard about this one before. What kernel did you last use that
worked?

-- 
Jens Axboe
