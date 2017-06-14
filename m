Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] Add support for write life time hints
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
 <yq160fyvah7.fsf@oracle.com> <d3e724ea-38f8-213f-a9ce-f78adc028e47@kernel.dk>
 <yq1wp8etv7y.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4b91457b-f64e-711d-dcea-91aa0ef78de4@kernel.dk>
Date: Wed, 14 Jun 2017 10:03:19 -0600
MIME-Version: 1.0
In-Reply-To: <yq1wp8etv7y.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 10:00 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> So how about we just call it "write_hint"? It sounds mostly like a
>> naming issue to me, as you would then map that to some specific stream
>> in your driver. You're free to do that right now. They are all flags,
>> it's just packed as a value to not waste too much space.
> 
> Sure, that's fine with me. But let's call them bi_hints or something. I
> have a couple that I would like to add that are I/O direction agnostic.

Assuming you saw Christoph's reply, if we just make then bio/req flags,
you can translate them into whatever you want. Work for you?

-- 
Jens Axboe
