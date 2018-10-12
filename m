Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 14/17] aoe: convert aoeblk to blk-mq
To: Ed Cashin <ed.cashin@acm.org>
Cc: linux-block@vger.kernel.org
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-15-axboe@kernel.dk>
 <CADvA-dnKCWSBZsmtnG=w_iAfU-aFxEq9oi_z_XV044648GYejA@mail.gmail.com>
 <fee272b4-4f75-4b70-fa32-1143bd34f6af@kernel.dk>
 <CADvA-dnUNB7UcaiXbbYS_VF22Po5h52MHwYCGP5+44isZ=duAw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2fb82c13-66c0-30bb-a408-10e01abc648f@kernel.dk>
Date: Fri, 12 Oct 2018 10:23:08 -0600
MIME-Version: 1.0
In-Reply-To: <CADvA-dnUNB7UcaiXbbYS_VF22Po5h52MHwYCGP5+44isZ=duAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 10:17 AM, Ed Cashin wrote:
> On Fri, Oct 12, 2018 at 10:20 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 10/12/18 5:28 AM, Ed Cashin wrote:
>>> OK.  We always tried to avoid putting includes in the .h file, so
>>> if you wouldn't mind moving the include to the C files, that would
>>> be nice.  I wouldn't insist, though.
>>
>> There's really no way around it, since I'm embedding the tag_set
>> in the device.
>>
>> Is that OK with you?
> 
> Yes, it's fine.  Thank you.

Can I add a reviewed-by?

-- 
Jens Axboe
