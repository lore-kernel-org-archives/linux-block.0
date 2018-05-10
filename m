Return-Path: <loberman@redhat.com>
Return-Path: <loberman@redhat.com>
Message-ID: <1525968713.16630.1.camel@redhat.com>
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "paolo.valente@linaro.org"
	 <paolo.valente@linaro.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  "snitzer@redhat.com" <snitzer@redhat.com>,
 "broonie@linaro.org" <broonie@linaro.org>, "axboe@fb.com" <axboe@fb.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Date: Thu, 10 May 2018 12:11:53 -0400
In-Reply-To: <75617a7d85070b989245e26de21f708c8762c7b7.camel@wdc.com>
References: <1518202449.2871.32.camel@wdc.com>
	 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
	 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
	 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
	 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
	 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
	 <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
	 <1518547636.2796.15.camel@wdc.com>
	 <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
	 <60f48ff1-7c8b-2c10-4560-744d70bccea1@wdc.com>
	 <6C49304C-D506-4719-9365-E7D35BEC9851@linaro.org>
	 <1519868123.2777.28.camel@wdc.com>
	 <10BDC305-A874-477C-9545-5617036C2E91@linaro.org>
	 <2dcb12b92e50a31c55dd3ab0e464cc819432c3d3.camel@wdc.com>
	 <7E372E2C-83A8-4EF4-B52E-E3AC6ED01C74@linaro.org>
	 <a6e512dff10d0cff12a688bbf1b30e275a91633e.camel@wdc.com>
	 <6A355080-C9A8-475D-9A35-32850D771ABB@linaro.org>
	 <1525466533.9055.1.camel@redhat.com>
	 <75617a7d85070b989245e26de21f708c8762c7b7.camel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-05-10 at 15:16 +0000, Bart Van Assche wrote:
> On Fri, 2018-05-04 at 16:42 -0400, Laurence Oberman wrote:
> > I was never able to reproduce Barts original issue using his tree
> > and
> > actual mlx5/cx4 hardware and ibsrp
> > I enabled BFQ with no other special tuning for the moath and
> > subpaths.
> > I was waiting for him to come back from vacation to check with him.
> 
> (back in the office)
> 
> Hello Laurence,
> 
> What I understood from off-list communication is that you tried to
> find
> a way to reproduce what I reported without using the srp-test
> software.
> My understanding is that both Paolo and I can reproduce the reported
> issue
> with the srp-test software.
> 
> Bart.
> 
> 
> 

Hello Bart

using your kernel
4.17.0-rc2.bart+

CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y

These are all SRP LUNS

36001405b2b5c6c24c084b6fa4d55da2f dm-27 LIO-ORG ,block-10        
size=3.9G features='2 queue_mode mq' hwhandler='0' wp=rw
`-+- policy='service-time 0' prio=1 status=active
  |- 2:0:0:9  sdap 66:144 active ready running
  `- 1:0:0:9  sdaz 67:48  active ready running

36001405b26ebe76dcb94a489f6f245f8 dm-18 LIO-ORG ,block-21        
size=3.9G features='2 queue_mode mq' hwhandler='0' wp=rw
`-+- policy='service-time 0' prio=1 status=active
  |- 2:0:0:20 sdx  65:112 active ready running
  `- 1:0:0:20 sdaa 65:160 active ready running

[root@ibclient ~]# cd /sys/block
[root@ibclient block]# cat /sys/block/dm-18/queue/scheduler
mq-deadline kyber [bfq] none
[root@ibclient block]# cat /sys/block/sdaa/queue/scheduler
mq-deadline kyber [bfq] none
[root@ibclient block]# cat /sys/block/sdx/queue/scheduler
mq-deadline kyber [bfq] none

Not using the test software just exercising the LUNS via my own tests I
am unable to get the OOPS

I guess something in the srp-test software triggers it then.

Doing plenty of IO to 5 mpath devices (1.3Gbytes/sec)

#Time     cpu sys inter  ctxsw Free Buff Cach Inac Slab  Map
KBRead  Reads KBWrit Writes   KBIn  PktIn  KBOut  PktOut 
12:08:32    0   0  1437   1107  88G   5M   1G 902M 300M
178M  1380K    345      0      0      6     74      0       4 

Thanks
Laurence
