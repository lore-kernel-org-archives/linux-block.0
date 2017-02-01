Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [dm-devel] split scsi passthrough fields out of struct request
 V2
Date: Wed, 1 Feb 2017 01:01:17 +0000
Message-ID: <1485910862.3113.12.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
	 <4054e944-b28d-1cd6-574f-6cd90e28c301@fb.com>
	 <1485464486.2540.12.camel@sandisk.com>
	 <6995c991-65a4-8dca-c36e-fb2eff277ca9@fb.com>
	 <1485467235.2540.14.camel@sandisk.com>
	 <e1d5f4e6-c63f-545d-710f-d4d10fa8d2e0@fb.com>
	 <1485472465.2540.19.camel@sandisk.com>
	 <e222c541-3239-104d-e0b0-40d19b012b66@fb.com>
	 <1485474426.2540.25.camel@sandisk.com>
	 <b98195e7-6e04-5a59-8b83-ce2e1c5c4e1a@fb.com>
	 <1485477510.2540.27.camel@sandisk.com>
	 <2d971693-b79d-c1b9-fb2a-f5dd04128c68@fb.com>
	 <1485479738.2540.30.camel@sandisk.com>
	 <ecca734c-7a9c-f060-9335-c2de089849c2@fb.com>
	 <37ab009a-bc2d-d2ae-a875-269ab563a430@fb.com>
	 <9cbf0ce5-ed79-0252-fd2d-34bebaafffa3@fb.com>
	 <1485535925.4267.1.camel@sandisk.com>
	 <2c696943-2a44-4f36-f0f8-0bebceb95a4a@fb.com>
	 <1485825148.2669.18.camel@sandisk.com>
	 <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
	 <1485898487.3113.7.camel@sandisk.com> <1485899692.3113.9.camel@sandisk.com>
	 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
In-Reply-To: <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Tue, 2017-01-31 at 13:58 -0800, Jens Axboe wrote:
> Interesting, I'll check this. Doesn't make any sense why the scheduler
> would be implicated in that, given how we run completions now. But if
> it complains, then something must be up.

(reduced CC-list)

There is another issue that needs further attention and for which I have
not yet had the time to root-cause it: several processes became unkillable
while I was running srp-test (with scheduler "none"). Apparently the dm
queues got stuck in state BLK_MQ_S_SCHED_RESTART:

# grep -aH '' dm*/*/0/{state,dispatch,*/rq_list}
dm-0/mq/0/state:0x4
dm-1/mq/0/state:0x4
dm-0/mq/0/dispatch:ffff880386d1ca00 {.cmd_type=3D1, .cmd_flags=3D0x8801, .r=
q_flags=3D0x2000, .tag=3D1637, .internal_tag=3D-1}
dm-1/mq/0/dispatch:ffff880388ee5400 {.cmd_type=3D1, .cmd_flags=3D0x4000, .r=
q_flags=3D0x2000, .tag=3D42, .internal_tag=3D-1}
dm-1/mq/0/dispatch:ffff880388ee5600 {.cmd_type=3D1, .cmd_flags=3D0x4000, .r=
q_flags=3D0x2000, .tag=3D43, .internal_tag=3D-1}
dm-1/mq/0/dispatch:ffff880388ee5800 {.cmd_type=3D1, .cmd_flags=3D0x4000, .r=
q_flags=3D0x2000, .tag=3D44, .internal_tag=3D-1}
dm-1/mq/0/dispatch:ffff880388ee5a00 {.cmd_type=3D1, .cmd_flags=3D0x0, .rq_f=
lags=3D0x2000, .tag=3D45, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1cc00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1638, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ce00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1639, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1d000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1640, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1d200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1641, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1b600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1627, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1b800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1628, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1d400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1642, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1bc00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1630, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ae00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1623, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1c200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1633, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1d600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1643, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1d800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1644, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1c400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1634, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1a400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1618, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1c600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1635, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1c800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1636, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1da00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1645, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1dc00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1646, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1de00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1647, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1e000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1648, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1e200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1649, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1e400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1650, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1e600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1651, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1e800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1652, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ea00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1653, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ec00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1654, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ee00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1655, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1f000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1656, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1f200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1657, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1f400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1658, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1f600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1659, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1f800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1660, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1fa00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1661, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1fc00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1662, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1fe00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1663, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1600, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1601, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1602, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1603, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1604, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18a00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1605, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18c00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1606, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d18e00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1607, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1608, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1609, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1610, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1611, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1612, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19a00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1613, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19c00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1614, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d19e00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1615, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1a000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1616, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1a200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1617, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1a600 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1619, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1a800 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1620, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1aa00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1621, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ac00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1622, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1b000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1624, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1b200 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1625, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1b400 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1626, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1ba00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1629, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1be00 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1631, .internal_tag=3D-1}
dm-0/mq/0/cpu1/rq_list:ffff880386d1c000 {.cmd_type=3D1, .cmd_flags=3D0x8801=
, .rq_flags=3D0x2000, .tag=3D1632, .internal_tag=3D-1}
dm-0/mq/0/cpu5/rq_list:ffff880385b97e00 {.cmd_type=3D1, .cmd_flags=3D0x0, .=
rq_flags=3D0x2000, .tag=3D447, .internal_tag=3D-1}

Bart.=
