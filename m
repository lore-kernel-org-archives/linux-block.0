Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
To: Stephen Bates <sbates@raithlin.com>, Omar Sandoval <osandov@osandov.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
 <1491567843-26190-3-git-send-email-sbates@raithlin.com>
 <20170420200706.GA24823@vader.DHCP.thefacebook.com>
 <c7543e20-8f3f-03c4-38a2-de185e066aa2@kernel.dk>
 <20170420202039.GB24823@vader.DHCP.thefacebook.com>
 <808e7f83-9f55-29cf-7472-c09daea665bd@kernel.dk>
 <0E9E52B3-977A-4159-83B3-758564FF67AD@raithlin.com>
 <6617fde7-4866-4a2d-6cf5-dc8b2c678186@kernel.dk>
 <D356CC80-F509-4427-B999-641636131E8D@raithlin.com>
 <ca5bec05-ba3c-55db-6f3d-ef0965a79737@kernel.dk>
 <0C2FFC52-512F-4031-8E6F-487FA651A31B@raithlin.com>
 <6214fe06-c636-c565-9b2c-fab7cf2e6d19@kernel.dk>
 <F8C6A572-C589-4FF9-8DB2-66D6CC045EA1@raithlin.com>
 <16225338-232a-ef39-0b9d-1281e0a66367@kernel.dk>
 <F1D4091B-6AA1-46D0-A99E-0A891DE4939E@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c8a630f0-2745-3c3c-3e2f-e6515d39f75d@kernel.dk>
Date: Thu, 20 Apr 2017 16:06:42 -0600
MIME-Version: 1.0
In-Reply-To: <F1D4091B-6AA1-46D0-A99E-0A891DE4939E@raithlin.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 04:05 PM, Stephen  Bates wrote:
> 
>> You can, but it won't do much good since v3 is already applied. Any
>> further changes must be incremental.
> 
> BTW getting a compile error from the Kyber code in for-4.12/block due to the fact we now return a signed from the bucket function…
> 
> batesste@ubuntu64-batesste:~/kernel/linux$ make -j 2 all
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      block/kyber-iosched.o
> block/kyber-iosched.c: In function ‘kyber_queue_data_alloc’:
> block/kyber-iosched.c:295:57: error: passing argument 2 of ‘blk_stat_alloc_callback’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   kqd->cb = blk_stat_alloc_callback(kyber_stat_timer_fn, rq_sched_domain,
>                                                          ^
> In file included from block/blk-mq.h:4:0,
>                  from block/blk.h:6,
>                  from block/kyber-iosched.c:27:
> block/blk-stat.h:138:1: note: expected ‘int (*)(const struct request *)’ but argument is of type ‘unsigned int (*)(const struct request *)’
>  blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
>  ^
>   CC      block/compat_ioctl.o
> cc1: some warnings being treated as errors

I did fix that one up, I did a ninja rebase, but apparently you pulled in the
few minutes it existed. So just update, and you should be fine.

-- 
Jens Axboe
