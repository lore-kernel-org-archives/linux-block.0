Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH] blk-mq: Fix poll_stat for new size-based bucketing.
To: Stephen Bates <sbates@raithlin.com>
References: <1492729151-20983-1-git-send-email-sbates@raithlin.com>
 <44a0b09e-d150-a0e8-f5e2-5792f4d4f74a@kernel.dk>
 <8F6E7173-D719-4E85-9F18-7B20319E972C@raithlin.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "osandov@osandov.com" <osandov@osandov.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <15b270ab-c012-1ab5-8ce7-235146e226e7@grimberg.me>
Date: Fri, 21 Apr 2017 02:57:39 +0300
MIME-Version: 1.0
In-Reply-To: <8F6E7173-D719-4E85-9F18-7B20319E972C@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

>> Thanks, added. BTW, in the future, we have a format for specifying
>> if a patch fixes another patch. This should have been:
>
> Thanks!
>
>> Fixes: 720b8ccc4500 ("blk-mq: Add a polling specific stats function")
>
> Duly noted for next time. Apologies for the miss…

Stephen,

I recommend adding a pretty section to your gitconfig:

[pretty]
         fixes = Fixes: %h (\"%s\")

This way you can run:

git log --pretty=fixes <broken_commit_hash>^!

and get the format for free :)

Cheers,
Sagi.
