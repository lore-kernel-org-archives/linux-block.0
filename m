Return-Path: <axboe@kernel.dk>
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, Paolo Valente <paolo.valente@linaro.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
 <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
 <x495zzcj7u8.fsf@segfault.boston.devel.redhat.com>
 <8d5f3ab2-50e8-226c-8ccb-c722872910db@kernel.dk>
 <x491sa0j7jn.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <046d0a8c-fe66-f933-fc27-f6d9f075884c@kernel.dk>
Date: Tue, 11 Sep 2018 10:59:39 -0600
MIME-Version: 1.0
In-Reply-To: <x491sa0j7jn.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/11/18 10:57 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>>> And then there were 4...
>>
>> Exactly. I'd bump it to 5 to leave room for one more, if we have to grow it
>> again, probably worth it to make it dynamic. So for, not really needed. Takashi,
>> can verify that the below fixes it up for you?
>>
> 
> You can slap a
> 
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> 
> on that when you commit it.

Thanks, I'll do so when Takashi has given it a test spin. But seems like
a no-brainer.

-- 
Jens Axboe
