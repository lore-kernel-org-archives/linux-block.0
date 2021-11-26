Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3401C433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 09:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhKZJ7I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 04:59:08 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63824 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKZJ5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 04:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637920435; x=1669456435;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=zQqzQfO39aGho+BpuOunX3yY/ppRCjjGJ69E3l3eZJc=;
  b=C426dTWCqqv7PCnjeFyV9vUU3EVOmxEtfNnno0pcQS7hN4N9q8t3PgsO
   eTSJLTroKzULsqaZY6EhWuyr5Ke0R5fsXLNkqOj5bGKc03AyezeJ5+jmG
   EQhTUCDESfG4cxitjUKg/kqlmd5WcDFOYcamxDNcDOUx5AOngBD2PkedF
   xJ7Wat6lDZa47ggd92A9qxJfIqmawXZzoNbP7Xmb3YVMtNBn9+3uUPNo1
   U6nO4A7+Z1KsLdJX7sYdPZ1L9pio1B+VqZKdknXGghzpuBUZ3ktxKMLjF
   PPS324xzkYm11q6BGSqX+++Vit0n1eaeUbFJ594gyalV6HWmk+bHnnQOj
   g==;
X-IronPort-AV: E=Sophos;i="5.87,265,1631548800"; 
   d="scan'208";a="186724245"
Received: from mail-dm3nam07lp2049.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 17:53:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7S9FfouJ1qYA3QqIQAmYTnoQjZ6OD6YrNKVzYYHxplvEztvU5EnoSh84FU2SkJdR4+LbHk9K9S0+ZHdT+3GCZNeKDR6v+FxZxk038zlmwLM42K7+msEQierjsz+wjxQlATtx37GUh7g81aYjcDCL0F1iQ09Y3Lg/7Fpaqp0JRX0go6Ijte75rZavZZbTqHp3iOQ9fT12Jp5jJb8PvYgRkfgA0GcvK88J2UCmBcAyjL8WVv6VbT8SDNekdnP4XFgD8UKgjfzIhC9aeTBN3y4eFVnaj1H8q1CqYLvUrAp9R8DWzyk0Ognw+PJaTmuLPRQujHqpjgU561gdYcVTP1T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anENnE663eGotli2T0J+N6leAqPIpNMGFJqPQlxF13g=;
 b=iIyC1OkH43iPHlnN9T6D7bkduWRrRFlSwVkoTf0gqW6f7UbdbE4uOI9wzCXvbpwnaBOEhRHzttfqFcdANmyoDBzSwhU0j6bX65erN8ADExFboEpxif5WiTkOUwlX3jhwzdZ+6llG6riU8Kv4NbcEfI5kZ2wE16oUzq7SjGyY6yODzte6zsTcovj1FsWWqJE9hNvOK9VFAd5WwkstyFkjef84+Brjpw5/O2YFId5AbLs4QVFpHgdMVfOr93Y4wVEK7Cqq4LQlMZ1avzny8lLMHTaMUv8cLliYKJGY/KCOJf70vW8hzffGHQPRP6wlxB3bnoc11BW3ojAMoFsg3YIbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anENnE663eGotli2T0J+N6leAqPIpNMGFJqPQlxF13g=;
 b=SZumhXHu9lDwL+7reWYMLfbuadoylGoStqZL0lBQv5iaEFW+99/dtcfRoPhM/e4P8YkOua3kK33UpqUy9vIFgI5cmddOxnzw08TcI+mAVyVEuYgEqKeupmiTV4/2aqWgwM8B5mnN96JYlb+kXmDIxgpkU9bjHBf83fFnJ2gwQXQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8088.namprd04.prod.outlook.com (2603:10b6:8::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Fri, 26 Nov 2021 09:53:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e%5]) with mapi id 15.20.4713.027; Fri, 26 Nov 2021
 09:53:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: I/O hang with v5.16-rc2
Thread-Topic: I/O hang with v5.16-rc2
Thread-Index: AQHX4quF1d1OnS15AUqhFGZLwogS9g==
Date:   Fri, 26 Nov 2021 09:53:53 +0000
Message-ID: <20211126095352.bkbrvtgfcmfj3wkj@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 357874a8-f45c-433b-5d48-08d9b0c2a7b9
x-ms-traffictypediagnostic: DM8PR04MB8088:
x-microsoft-antispam-prvs: <DM8PR04MB8088C45DC3C21E00910C1BC1ED639@DM8PR04MB8088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GA2sSyaCpvdyyGzEfRgCyf9YYBSCadbgbaQAowj8PTxHbHebMYy+bpwTkSXBkHTLgJ1VlB2SmEE7DAmX7wfYh2ajPOnMNP3AkD8KceZ3eSboigy+z/f/bHfUJepV58PZUw3rwu3cSJ7bnJhpJ+JdzTeUvvFj8fR5XZYTFkwHh31XlamF0+jabeOwrqYzO1AT2LwZl6uddSvGO740kgVfO6429SLKlh/na1/aFtaKbmZVVoz9b6jMtnffIBeU8XqW65K98BbimbWdUnV9zaKR7PqUWTkEmNteGYBegy0DSAa0xTIMRtAUSXTB3y4a9SHMHo9lJPd2LMimNxmhMsWCwF3jog/1vdvv/xCtLIuo5xJPeRPqXWd8e4AXG84YKUOZ5rvBd3y1zjmKekDLu5WPBp1jCvSALUCVsaMZBogMXkJ5adDBhe8dud94OqyBbJbh8ukaXykgCJeXTsbLW5qGaZ/9gyY26jRwM1HLMghgpxXdMi6+NJPWIgPF3rl8wEeYCbj8hRQc5xuQWlgU8jjczx/apR5UsuLKam4u3nftgSAZnXrXtQ8yJJ1dgOlfaRQ18utuTd/aLHdDOaZZ+RxiQQaRTJpYE1LgeovBwh2SFu7QoVm45QUMLTDcJ10lBtwdY5SkRicB7dIlMCFXCqpJT+4oAd/c3QSyCtGji0T+fze/MpzDZwLwogHj7SQHHECEsvH0sKAt166ZRT/M5S7yqMf6esIrRW0LvZWZH81IeLTQ1xiBvwJNeyy43itn/COQ+4AtqmVrNwZytV+HzuWUM+ztA+EhN1i5P0WU3xSEng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(38070700005)(66476007)(64756008)(66556008)(66446008)(66946007)(186003)(76116006)(91956017)(122000001)(6506007)(30864003)(26005)(1076003)(6486002)(82960400001)(8936002)(5660300002)(83380400001)(6916009)(86362001)(44832011)(508600001)(38100700002)(2906002)(54906003)(316002)(9686003)(33716001)(4326008)(6512007)(966005)(71200400001)(8676002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J64gKMXr+a4XOZvsAnqBHZ8f+dLXhJeLFeDfRIvqTzah0hOvIgQy8lWBGEeF?=
 =?us-ascii?Q?3BrqiQ41lhFkNFC/WPRR2moFeuSq82th5UcFKeRRcS428QvQ2WpiEsjTzQp3?=
 =?us-ascii?Q?7Jy7Imcyil6zRPf3nlKqyRL6iqAfxb6qne+a+0av7B3fZrCcZJqKd/NaxZ1M?=
 =?us-ascii?Q?WTiXzwxBTMzY5a0eK1Kjg0c14MQwnlCaUbQzLqQc4LaQUO6Z8kR4HfKvdJq4?=
 =?us-ascii?Q?sMoD/8FxvgwnjOxwY5gCRx5lQhgvQLBZyeUUk7R1JSUIInFQgzdmTx1Kb0YF?=
 =?us-ascii?Q?IiJkTmJHI5C9ZUJOFMzkcFQYGZ94TxnGjoHltWXpApXamrhTWP5TBbfOssPj?=
 =?us-ascii?Q?W5z0mW+jmNqCHi3trCUS98plwob2+slfvviWb/2bjz8Cmq8DDNsoWR1vb6Gz?=
 =?us-ascii?Q?9NEiC9vcuJLcXHDASLtLxlx4Jg1HFuBGcRZUWgs+XU8aXrr2riXyXdNN/wEn?=
 =?us-ascii?Q?zMrrdclB71UIFjTF3e1iny/hpxA0sVdd2IRrKXc9SsCf8JDTq4hODo+NWWv5?=
 =?us-ascii?Q?UT9El3QfTToQDndXtjvMQRoMtDgd3wnVSVfQRNyTmJUMWYpGPRnpAsHRqQa/?=
 =?us-ascii?Q?d6a20iTSyu1jPMgYhhYnb1Q7boXneyW1/dqrU2e7uzY5t+qMU1CGoceraHZc?=
 =?us-ascii?Q?3sZv4WOkhE+vbD3tSTFJ864ccL8ODJFvW3xliMXZHlFSzL/UzsP4vtiq8+7K?=
 =?us-ascii?Q?CcvhzQwhiTGb40CyJvfyOC2r6ikpE5LCp8K4RoA7iBdXx8jobj81fDrBHCvz?=
 =?us-ascii?Q?CL46g7J7O6+yqIuDHEBTKg/M+KKkdidXyqRX8uRdl9M4HGKT3D7P/izXZOG+?=
 =?us-ascii?Q?mcfAsOkzV7SGs4ND16+CR1DOCG+1cu+7QvQwmGyhteVwoU6dLS5X/gOweiLG?=
 =?us-ascii?Q?e+2wv65qGG/W/QbPcU+UwsHeGEnhNbFDcq/m9tsps5dUXtInAgKiGLBaIJxR?=
 =?us-ascii?Q?E/sM+p0qcP1hDDaI6MKZDXPPOSl4fwXy/zk6H2e16qZLcf0e91jFitR1nafg?=
 =?us-ascii?Q?5I37V9G8PTJirCVPfANGobyRlFcY9W2prQO9Hsx1xEeHdWy5QMYHhBoMpNnY?=
 =?us-ascii?Q?IJ53xfTCnHMcHHZc7p/kw68qIGu7HXDWR7w239FqkrE0gQVNreeJxi6SWPT4?=
 =?us-ascii?Q?+KpF7qYv3pGyBtZ6sV7J5tbxjj+baXdwb981V8VKSk2Ilnjxppt+ll0MeLrt?=
 =?us-ascii?Q?kdXVYUz6gVsuvUvIiB3dRsBaG5i3ri0FdyUYjw6BL1GItJG5S3C67Gd3l/8k?=
 =?us-ascii?Q?NF0kf89/0iTSSysfmNAAXFTx0UkgW6mn18Ly6p1sArxs59ga/VqAkNwOQJOa?=
 =?us-ascii?Q?kS8SZ7+AquDF10c9NQfmASsqI+AvSeWgwMsHwS1JlLtYbDlUrGEXTooyWJh5?=
 =?us-ascii?Q?tKTuXGmx/uSqJrzmqG6Rd1B0rRvp27FOGmAZMisH7m22VmsjcQZlZRTuztrq?=
 =?us-ascii?Q?xMwLVk3kbXYMRNo4pjUqpej3Mx6eVYrG80eDF1yMWy+Eqn1JdBeMQO97WpiZ?=
 =?us-ascii?Q?zS+bsDbLU8dY6/E0/Phsk7MOZSInFH6OogvX+ePC0q6uTA8mBYP4W3U2olxG?=
 =?us-ascii?Q?AbDhll0RfqYFhe53143cQRkliRns9bHd+K7Kx3XrzzjyBiTxiYk7IEhzl3eC?=
 =?us-ascii?Q?kmQPrpvjCHxDJw28wh2l7gxLsKOguPOwTd2OKWqrZIdYSdKvsQ9LVP9PDHGf?=
 =?us-ascii?Q?cXxkJhokiNYMkK+3N7djMfeSkDg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0B58A274DD352429C4693FC6124679E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357874a8-f45c-433b-5d48-08d9b0c2a7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 09:53:53.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XyiytXsWREtoNNwEhkZFEwDPs4CUfbadHWirJed5RiLum/dKtS7nji3anWQLapO0RMUr0ZNim6WV9+wXqWZwczz0kzSYA8uCvo0YFJDmYZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8088
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I ran my test set on v5.16-rc2 and observed a process hang. The test work l=
oad
repeats file creation on xfs on dm-zoned. This dm-zoned device is on top of=
 3
dm-linear devices. One of them is dm-linear device on non-zoned NVMe device=
 as
the cache of the dm-zoned device. The other two are dm-linear devices on zo=
ned
SMR HDDs. So far, the hang is recreated 100% with my test system.

The kernel message [2] reported hanging tasks. In the call stack, I observe
wbt_wait(). Also I observed "inflight 1" value in the "rqos/wbt/inflight"
attribute of debug sysfs.

# grep -R . /sys/kernel/debug/block/nvme0n1 | grep inflight
/sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:0: inflight 1
/sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/nvme0n1/rqos/wbt/inflight:2: inflight 0

These symptoms look related to another issue reported to linux-block [1]. A=
s
discussed in that thread, I set 0 to /sys/block/nvme0n1/queue/wbt_lat_usec.
With this setting, I observed the hang disappeared. Then this hang I observ=
e
also related to writeback throttling for the NVMe device.

I bisected and found the commit 4f5022453acd ("nvme: wire up completion bat=
ching
for the IRQ path") is the trigger commit. I reverted this commit from v5.16=
-rc2,
and observed the hang disappeared.

Wish this report helps.


[1] https://lore.kernel.org/linux-block/b3ba57a7-d363-9c17-c4be-9dbe86875@p=
anix.com

[2]

[76751.973325][   T63] INFO: task kworker/u16:19:255220 blocked for more th=
an 622 seconds.
[76751.981730][   T63]       Not tainted 5.16.0-rc2 #1
[76751.986700][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76751.995276][   T63] task:kworker/u16:19  state:D stack:    0 pid:255220 =
ppid:     2 flags:0x00004000
[76752.004490][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76752.011629][   T63] Call Trace:
[76752.014833][   T63]  <TASK>
[76752.017715][   T63]  __schedule+0xa09/0x26d0
[76752.022106][   T63]  ? io_schedule_timeout+0x190/0x190
[76752.027366][   T63]  ? _raw_spin_unlock_irqrestore+0x2d/0x60
[76752.033102][   T63]  ? lockdep_hardirqs_on+0x7e/0x100
[76752.038243][   T63]  schedule+0xe0/0x270
[76752.042230][   T63]  ? rq_qos_wait+0x13b/0x210
[76752.046726][   T63]  io_schedule+0xf3/0x170
[76752.050997][   T63]  rq_qos_wait+0x140/0x210
[76752.055325][   T63]  ? rq_depth_scale_down+0x290/0x290
[76752.060514][   T63]  ? karma_partition+0x8b0/0x8b0
[76752.065351][   T63]  ? wbt_cleanup_cb+0x80/0x80
[76752.069930][   T63]  ? rcu_read_lock_sched_held+0x3f/0x70
[76752.075379][   T63]  wbt_wait+0x107/0x260
[76752.079429][   T63]  ? wbt_track+0x60/0x60
[76752.083561][   T63]  ? blk_mq_submit_bio+0xda5/0x1bb0
[76752.088662][   T63]  __rq_qos_throttle+0x4c/0x90
[76752.093317][   T63]  blk_mq_submit_bio+0x4df/0x1bb0
[76752.098230][   T63]  ? percpu_ref_put_many.constprop.0+0x6a/0x1a0
[76752.104363][   T63]  ? blk_mq_try_issue_list_directly+0x410/0x410
[76752.110494][   T63]  ? submit_bio_checks+0x17a0/0x17a0
[76752.115653][   T63]  ? lock_is_held_type+0xe4/0x140
[76752.120575][   T63]  submit_bio_noacct+0x52a/0xa60
[76752.125397][   T63]  ? lock_release+0x3a9/0x6d0
[76752.129953][   T63]  ? __submit_bio_fops+0x1f0/0x1f0
[76752.134942][   T63]  ? lock_downgrade+0x6b0/0x6b0
[76752.139680][   T63]  dmz_submit_bio+0x2a4/0x460 [dm_zoned]
[76752.145199][   T63]  dmz_chunk_work+0x9c4/0x13b0 [dm_zoned]
[76752.150812][   T63]  process_one_work+0x7e9/0x1320
[76752.155642][   T63]  ? lock_release+0x6d0/0x6d0
[76752.160197][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76752.165452][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76752.170355][   T63]  worker_thread+0x59b/0x1010
[76752.174924][   T63]  ? process_one_work+0x1320/0x1320
[76752.180005][   T63]  kthread+0x3b9/0x490
[76752.183956][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76752.189031][   T63]  ? set_kthread_struct+0x100/0x100
[76752.194108][   T63]  ret_from_fork+0x22/0x30
[76752.198434][   T63]  </TASK>
[76752.201348][   T63] INFO: task kworker/u16:7:265016 blocked for more tha=
n 622 seconds.
[76752.209291][   T63]       Not tainted 5.16.0-rc2 #1
[76752.214194][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76752.222739][   T63] task:kworker/u16:7   state:D stack:    0 pid:265016 =
ppid:     2 flags:0x00004000
[76752.231897][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76752.238977][   T63] Call Trace:
[76752.242156][   T63]  <TASK>
[76752.244983][   T63]  __schedule+0xa09/0x26d0
[76752.249284][   T63]  ? io_schedule_timeout+0x190/0x190
[76752.254441][   T63]  ? mark_held_locks+0x9e/0xe0
[76752.259083][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76752.263989][   T63]  schedule+0xe0/0x270
[76752.267941][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76752.273368][   T63]  ? down_write+0x130/0x130
[76752.277770][   T63]  down_read+0xd0/0x420
[76752.281801][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76752.287402][   T63]  dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76752.293003][   T63]  ? lock_release+0x6d0/0x6d0
[76752.297577][   T63]  process_one_work+0x7e9/0x1320
[76752.302411][   T63]  ? lock_release+0x6d0/0x6d0
[76752.306971][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76752.312226][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76752.317051][   T63]  worker_thread+0x59b/0x1010
[76752.321614][   T63]  ? process_one_work+0x1320/0x1320
[76752.326693][   T63]  kthread+0x3b9/0x490
[76752.330640][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76752.335710][   T63]  ? set_kthread_struct+0x100/0x100
[76752.340782][   T63]  ret_from_fork+0x22/0x30
[76752.345096][   T63]  </TASK>
[76752.348009][   T63] INFO: task kworker/u16:2:280342 blocked for more tha=
n 622 seconds.
[76752.355950][   T63]       Not tainted 5.16.0-rc2 #1
[76752.360850][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76752.369395][   T63] task:kworker/u16:2   state:D stack:    0 pid:280342 =
ppid:     2 flags:0x00004000
[76752.378545][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76752.385612][   T63] Call Trace:
[76752.388779][   T63]  <TASK>
[76752.391600][   T63]  __schedule+0xa09/0x26d0
[76752.395902][   T63]  ? io_schedule_timeout+0x190/0x190
[76752.401061][   T63]  ? mark_held_locks+0x9e/0xe0
[76752.405700][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76752.410606][   T63]  schedule+0xe0/0x270
[76752.414554][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76752.419981][   T63]  ? down_write+0x130/0x130
[76752.424381][   T63]  down_read+0xd0/0x420
[76752.428415][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76752.434022][   T63]  dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76752.440232][   T63]  ? dmz_mblock_shrinker_count+0x60/0x60 [dm_zoned]
[76752.446700][   T63]  ? finish_wait+0x270/0x270
[76752.451188][   T63]  ? dmz_bdev_is_dying+0xaf/0x150 [dm_zoned]
[76752.457062][   T63]  dmz_get_chunk_buffer+0x167/0x740 [dm_zoned]
[76752.463110][   T63]  dmz_chunk_work+0x968/0x13b0 [dm_zoned]
[76752.468724][   T63]  process_one_work+0x7e9/0x1320
[76752.473547][   T63]  ? lock_release+0x6d0/0x6d0
[76752.478100][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76752.483356][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76752.488183][   T63]  worker_thread+0x59b/0x1010
[76752.492751][   T63]  ? process_one_work+0x1320/0x1320
[76752.497835][   T63]  kthread+0x3b9/0x490
[76752.501781][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76752.506853][   T63]  ? set_kthread_struct+0x100/0x100
[76752.511929][   T63]  ret_from_fork+0x22/0x30
[76752.516240][   T63]  </TASK>
[76752.519162][   T63] INFO: task kworker/u16:0:281230 blocked for more tha=
n 623 seconds.
[76752.527109][   T63]       Not tainted 5.16.0-rc2 #1
[76752.532004][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76752.540542][   T63] task:kworker/u16:0   state:D stack:    0 pid:281230 =
ppid:     2 flags:0x00004000
[76752.549697][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76752.556763][   T63] Call Trace:
[76752.559931][   T63]  <TASK>
[76752.562753][   T63]  __schedule+0xa09/0x26d0
[76752.567056][   T63]  ? io_schedule_timeout+0x190/0x190
[76752.572210][   T63]  ? mark_held_locks+0x9e/0xe0
[76752.576845][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76752.581752][   T63]  schedule+0xe0/0x270
[76752.585697][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76752.591133][   T63]  ? down_write+0x130/0x130
[76752.595536][   T63]  down_read+0xd0/0x420
[76752.599577][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76752.605180][   T63]  dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76752.610771][   T63]  ? lock_release+0x6d0/0x6d0
[76752.615370][   T63]  process_one_work+0x7e9/0x1320
[76752.620197][   T63]  ? lock_release+0x6d0/0x6d0
[76752.624749][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76752.630006][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76752.634826][   T63]  worker_thread+0x59b/0x1010
[76752.639392][   T63]  ? process_one_work+0x1320/0x1320
[76752.644469][   T63]  kthread+0x3b9/0x490
[76752.648408][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76752.653480][   T63]  ? set_kthread_struct+0x100/0x100
[76752.658551][   T63]  ret_from_fork+0x22/0x30
[76752.662860][   T63]  </TASK>
[76752.665768][   T63] INFO: task kworker/u16:5:282117 blocked for more tha=
n 623 seconds.
[76752.673701][   T63]       Not tainted 5.16.0-rc2 #1
[76752.678593][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76752.687135][   T63] task:kworker/u16:5   state:D stack:    0 pid:282117 =
ppid:     2 flags:0x00004000
[76752.696309][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76752.703377][   T63] Call Trace:
[76752.706536][   T63]  <TASK>
[76752.709358][   T63]  __schedule+0xa09/0x26d0
[76752.713667][   T63]  ? io_schedule_timeout+0x190/0x190
[76752.718824][   T63]  ? mark_held_locks+0x9e/0xe0
[76752.723463][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76752.728367][   T63]  schedule+0xe0/0x270
[76752.732317][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76752.737748][   T63]  ? down_write+0x130/0x130
[76752.742163][   T63]  down_read+0xd0/0x420
[76752.746193][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76752.751797][   T63]  dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76752.758006][   T63]  ? dmz_mblock_shrinker_count+0x60/0x60 [dm_zoned]
[76752.764476][   T63]  ? finish_wait+0x270/0x270
[76752.768942][   T63]  ? dmz_bdev_is_dying+0xaf/0x150 [dm_zoned]
[76752.774805][   T63]  dmz_get_chunk_buffer+0x167/0x740 [dm_zoned]
[76752.780843][   T63]  dmz_chunk_work+0x968/0x13b0 [dm_zoned]
[76752.786458][   T63]  process_one_work+0x7e9/0x1320
[76752.791283][   T63]  ? lock_release+0x6d0/0x6d0
[76752.795833][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76752.801081][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76752.805903][   T63]  worker_thread+0x59b/0x1010
[76752.810468][   T63]  ? process_one_work+0x1320/0x1320
[76752.815545][   T63]  kthread+0x3b9/0x490
[76752.819492][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76752.824561][   T63]  ? set_kthread_struct+0x100/0x100
[76752.829640][   T63]  ret_from_fork+0x22/0x30
[76752.833953][   T63]  </TASK>
[76752.836859][   T63] INFO: task kworker/u16:6:282143 blocked for more tha=
n 623 seconds.
[76752.844795][   T63]       Not tainted 5.16.0-rc2 #1
[76752.849687][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76752.858227][   T63] task:kworker/u16:6   state:D stack:    0 pid:282143 =
ppid:     2 flags:0x00004000
[76752.867382][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76752.874451][   T63] Call Trace:
[76752.877613][   T63]  <TASK>
[76752.880434][   T63]  __schedule+0xa09/0x26d0
[76752.884741][   T63]  ? io_schedule_timeout+0x190/0x190
[76752.889900][   T63]  ? mark_held_locks+0x9e/0xe0
[76752.894545][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76752.899453][   T63]  schedule+0xe0/0x270
[76752.903398][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76752.908825][   T63]  ? down_write+0x130/0x130
[76752.913232][   T63]  down_read+0xd0/0x420
[76752.917267][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76752.922870][   T63]  dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76752.928463][   T63]  ? lock_release+0x6d0/0x6d0
[76752.933038][   T63]  process_one_work+0x7e9/0x1320
[76752.937909][   T63]  ? lock_release+0x6d0/0x6d0
[76752.942547][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76752.947815][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76752.952630][   T63]  worker_thread+0x59b/0x1010
[76752.957196][   T63]  ? process_one_work+0x1320/0x1320
[76752.962264][   T63]  kthread+0x3b9/0x490
[76752.966205][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76752.971273][   T63]  ? set_kthread_struct+0x100/0x100
[76752.976348][   T63]  ret_from_fork+0x22/0x30
[76752.980651][   T63]  </TASK>
[76752.983562][   T63] INFO: task kworker/u16:8:282144 blocked for more tha=
n 623 seconds.
[76752.991519][   T63]       Not tainted 5.16.0-rc2 #1
[76752.996416][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76753.004960][   T63] task:kworker/u16:8   state:D stack:    0 pid:282144 =
ppid:     2 flags:0x00004000
[76753.014107][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76753.021181][   T63] Call Trace:
[76753.024340][   T63]  <TASK>
[76753.027175][   T63]  __schedule+0xa09/0x26d0
[76753.031475][   T63]  ? io_schedule_timeout+0x190/0x190
[76753.036646][   T63]  ? mark_held_locks+0x9e/0xe0
[76753.041292][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76753.046202][   T63]  schedule+0xe0/0x270
[76753.050146][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76753.055577][   T63]  ? down_write+0x130/0x130
[76753.059980][   T63]  down_read+0xd0/0x420
[76753.064017][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76753.069627][   T63]  dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76753.075229][   T63]  ? lock_release+0x6d0/0x6d0
[76753.079795][   T63]  process_one_work+0x7e9/0x1320
[76753.084614][   T63]  ? lock_release+0x6d0/0x6d0
[76753.089184][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76753.094445][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76753.099270][   T63]  worker_thread+0x59b/0x1010
[76753.103831][   T63]  ? process_one_work+0x1320/0x1320
[76753.108911][   T63]  kthread+0x3b9/0x490
[76753.112855][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.117927][   T63]  ? set_kthread_struct+0x100/0x100
[76753.123001][   T63]  ret_from_fork+0x22/0x30
[76753.127309][   T63]  </TASK>
[76753.130216][   T63] INFO: task kworker/u16:11:282145 blocked for more th=
an 623 seconds.
[76753.138265][   T63]       Not tainted 5.16.0-rc2 #1
[76753.143173][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76753.151716][   T63] task:kworker/u16:11  state:D stack:    0 pid:282145 =
ppid:     2 flags:0x00004000
[76753.160868][   T63] Workqueue: dmz_cwq_dmz_dml_073 dmz_chunk_work [dm_zo=
ned]
[76753.167938][   T63] Call Trace:
[76753.171098][   T63]  <TASK>
[76753.173921][   T63]  __schedule+0xa09/0x26d0
[76753.178230][   T63]  ? io_schedule_timeout+0x190/0x190
[76753.183387][   T63]  ? mark_held_locks+0x9e/0xe0
[76753.188022][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76753.192970][   T63]  schedule+0xe0/0x270
[76753.196924][   T63]  rwsem_down_read_slowpath+0x4e0/0x9b0
[76753.202361][   T63]  ? down_write+0x130/0x130
[76753.206759][   T63]  down_read+0xd0/0x420
[76753.210800][   T63]  ? rwsem_down_read_slowpath+0x9b0/0x9b0
[76753.216400][   T63]  dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76753.221994][   T63]  ? lock_release+0x6d0/0x6d0
[76753.226567][   T63]  process_one_work+0x7e9/0x1320
[76753.231390][   T63]  ? lock_release+0x6d0/0x6d0
[76753.235945][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76753.241199][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76753.246013][   T63]  worker_thread+0x59b/0x1010
[76753.250582][   T63]  ? process_one_work+0x1320/0x1320
[76753.255654][   T63]  kthread+0x3b9/0x490
[76753.259598][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.264672][   T63]  ? set_kthread_struct+0x100/0x100
[76753.269756][   T63]  ret_from_fork+0x22/0x30
[76753.274062][   T63]  </TASK>
[76753.276968][   T63] INFO: task kworker/u16:13:282147 blocked for more th=
an 623 seconds.
[76753.284988][   T63]       Not tainted 5.16.0-rc2 #1
[76753.289905][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76753.298452][   T63] task:kworker/u16:13  state:D stack:    0 pid:282147 =
ppid:     2 flags:0x00004000
[76753.307600][   T63] Workqueue: dmz_rwq_dmz_dml_073_2 dmz_reclaim_work [d=
m_zoned]
[76753.315018][   T63] Call Trace:
[76753.318178][   T63]  <TASK>
[76753.321005][   T63]  __schedule+0xa09/0x26d0
[76753.325311][   T63]  ? io_schedule_timeout+0x190/0x190
[76753.330505][   T63]  schedule+0xe0/0x270
[76753.334462][   T63]  io_schedule+0xf3/0x170
[76753.338665][   T63]  bit_wait_io+0x17/0xe0
[76753.342787][   T63]  __wait_on_bit+0x5e/0x1b0
[76753.347179][   T63]  ? bit_wait_io_timeout+0x160/0x160
[76753.352348][   T63]  out_of_line_wait_on_bit+0xc7/0xe0
[76753.357506][   T63]  ? __wait_on_bit+0x1b0/0x1b0
[76753.362150][   T63]  ? var_wake_function+0x130/0x130
[76753.367148][   T63]  dmz_reclaim_copy+0x30c/0x860 [dm_zoned]
[76753.372849][   T63]  ? lock_release+0x3a9/0x6d0
[76753.377407][   T63]  ? dmz_to_next_set_block+0x11b/0x2b0 [dm_zoned]
[76753.383709][   T63]  ? dmz_reclaim_kcopy_end+0x80/0x80 [dm_zoned]
[76753.389854][   T63]  ? _raw_spin_unlock+0x29/0x40
[76753.394583][   T63]  ? dmz_to_next_set_block+0x11b/0x2b0 [dm_zoned]
[76753.400898][   T63]  dmz_reclaim_work+0xfe2/0x16c0 [dm_zoned]
[76753.406675][   T63]  ? lock_downgrade+0x6b0/0x6b0
[76753.411410][   T63]  ? dmz_reclaim_copy+0x860/0x860 [dm_zoned]
[76753.417275][   T63]  process_one_work+0x7e9/0x1320
[76753.422103][   T63]  ? lock_release+0x6d0/0x6d0
[76753.426659][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76753.431922][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76753.436748][   T63]  worker_thread+0x59b/0x1010
[76753.441313][   T63]  ? process_one_work+0x1320/0x1320
[76753.446390][   T63]  kthread+0x3b9/0x490
[76753.450335][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.455408][   T63]  ? set_kthread_struct+0x100/0x100
[76753.460478][   T63]  ret_from_fork+0x22/0x30
[76753.464793][   T63]  </TASK>
[76753.467708][   T63] INFO: task kworker/4:3:282754 blocked for more than =
624 seconds.
[76753.475464][   T63]       Not tainted 5.16.0-rc2 #1
[76753.480356][   T63] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[76753.488899][   T63] task:kworker/4:3     state:D stack:    0 pid:282754 =
ppid:     2 flags:0x00004000
[76753.498052][   T63] Workqueue: kcopyd do_work
[76753.502432][   T63] Call Trace:
[76753.505599][   T63]  <TASK>
[76753.508419][   T63]  __schedule+0xa09/0x26d0
[76753.512722][   T63]  ? io_schedule_timeout+0x190/0x190
[76753.517880][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.522958][   T63]  schedule+0xe0/0x270
[76753.526905][   T63]  ? rq_qos_wait+0x13b/0x210
[76753.531374][   T63]  io_schedule+0xf3/0x170
[76753.535587][   T63]  rq_qos_wait+0x140/0x210
[76753.539909][   T63]  ? rq_depth_scale_down+0x290/0x290
[76753.545080][   T63]  ? karma_partition+0x8b0/0x8b0
[76753.549893][   T63]  ? wbt_cleanup_cb+0x80/0x80
[76753.554446][   T63]  ? rcu_read_lock_sched_held+0x3f/0x70
[76753.559872][   T63]  wbt_wait+0x107/0x260
[76753.563903][   T63]  ? wbt_track+0x60/0x60
[76753.568021][   T63]  ? blk_mq_submit_bio+0xda5/0x1bb0
[76753.573107][   T63]  __rq_qos_throttle+0x4c/0x90
[76753.577765][   T63]  blk_mq_submit_bio+0x4df/0x1bb0
[76753.582666][   T63]  ? percpu_ref_put_many.constprop.0+0x6a/0x1a0
[76753.588785][   T63]  ? blk_mq_try_issue_list_directly+0x410/0x410
[76753.594923][   T63]  ? submit_bio_checks+0x17a0/0x17a0
[76753.600081][   T63]  ? find_held_lock+0x2c/0x110
[76753.604731][   T63]  submit_bio_noacct+0x52a/0xa60
[76753.609550][   T63]  ? lock_downgrade+0x6b0/0x6b0
[76753.614279][   T63]  ? __submit_bio_fops+0x1f0/0x1f0
[76753.619262][   T63]  ? lock_is_held_type+0xe4/0x140
[76753.624187][   T63]  ? __bio_add_page+0x254/0x420
[76753.628923][   T63]  submit_bio+0x149/0x340
[76753.633132][   T63]  ? submit_bio_noacct+0xa60/0xa60
[76753.638121][   T63]  dispatch_io+0x3af/0x9c0
[76753.642429][   T63]  ? endio+0x110/0x110
[76753.646374][   T63]  ? mempool_alloc+0xfe/0x2d0
[76753.650965][   T63]  ? mempool_resize+0x720/0x720
[76753.655700][   T63]  ? dm_interface_exit+0x20/0x20
[76753.660521][   T63]  ? list_get_page+0x1a0/0x1a0
[76753.665174][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76753.670087][   T63]  ? dm_kcopyd_do_callback+0x270/0x270
[76753.675427][   T63]  dm_io+0x3dd/0x8a0
[76753.679210][   T63]  ? sync_io+0x390/0x390
[76753.683326][   T63]  ? dm_interface_exit+0x20/0x20
[76753.688139][   T63]  ? list_get_page+0x1a0/0x1a0
[76753.692776][   T63]  ? do_raw_spin_lock+0x11e/0x250
[76753.697675][   T63]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[76753.703527][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.708605][   T63]  run_io_job+0x2fb/0x630
[76753.712814][   T63]  ? lock_release+0x3a9/0x6d0
[76753.717365][   T63]  ? dm_kcopyd_prepare_callback+0x120/0x120
[76753.723137][   T63]  ? dm_kcopyd_do_callback+0x270/0x270
[76753.728472][   T63]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[76753.734323][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.739399][   T63]  process_jobs.isra.0+0x111/0xa40
[76753.744389][   T63]  ? dm_kcopyd_prepare_callback+0x120/0x120
[76753.750170][   T63]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[76753.756016][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.761091][   T63]  do_work+0x1cf/0x2c0
[76753.765043][   T63]  ? process_jobs.isra.0+0xa40/0xa40
[76753.770205][   T63]  ? lock_downgrade+0x6b0/0x6b0
[76753.774941][   T63]  ? lock_is_held_type+0xe4/0x140
[76753.779849][   T63]  process_one_work+0x7e9/0x1320
[76753.784670][   T63]  ? lock_release+0x6d0/0x6d0
[76753.789222][   T63]  ? pwq_dec_nr_in_flight+0x230/0x230
[76753.794487][   T63]  ? rwlock_bug.part.0+0x90/0x90
[76753.799309][   T63]  worker_thread+0x59b/0x1010
[76753.803868][   T63]  ? process_one_work+0x1320/0x1320
[76753.808942][   T63]  kthread+0x3b9/0x490
[76753.812887][   T63]  ? _raw_spin_unlock_irq+0x24/0x50
[76753.817960][   T63]  ? set_kthread_struct+0x100/0x100
[76753.823032][   T63]  ret_from_fork+0x22/0x30
[76753.827338][   T63]  </TASK>
[76753.830261][   T63]=20
[76753.830261][   T63] Showing all locks held in the system:
[76753.837862][   T63] 1 lock held by khungtaskd/63:
[76753.842589][   T63]  #0: ffffffff9645e760 (rcu_read_lock){....}-{1:2}, a=
t: debug_show_all_locks+0x53/0x260
[76753.852283][   T63] 1 lock held by systemd-journal/580:
[76753.857552][   T63] 3 locks held by kworker/u16:19/255220:
[76753.863054][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76753.874381][   T63]  #1: ffff8884e2097dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76753.885192][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76753.896179][   T63] 3 locks held by kworker/u16:7/265016:
[76753.901596][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76753.912921][   T63]  #1: ffff88833c2dfdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76753.923733][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76753.934117][   T63] 3 locks held by kworker/u16:2/280342:
[76753.939540][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76753.950870][   T63]  #1: ffff88816aab7dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76753.961712][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76753.972690][   T63] 3 locks held by kworker/u16:0/281230:
[76753.978102][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76753.989429][   T63]  #1: ffff88811a28fdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.000232][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.010608][   T63] 3 locks held by kworker/u16:5/282117:
[76754.016021][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.027375][   T63]  #1: ffff888139357dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.038183][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76754.049180][   T63] 3 locks held by kworker/u16:6/282143:
[76754.054604][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.065925][   T63]  #1: ffff8881472efdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.076724][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.087103][   T63] 3 locks held by kworker/u16:8/282144:
[76754.092529][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.103851][   T63]  #1: ffff888114a77dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.114651][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.125034][   T63] 3 locks held by kworker/u16:11/282145:
[76754.130533][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.141856][   T63]  #1: ffff888169827dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.152665][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.163046][   T63] 2 locks held by kworker/u16:13/282147:
[76754.168547][   T63]  #0: ffff88814f7b9938 ((wq_completion)dmz_rwq_dmz_dm=
l_073_2){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.180041][   T63]  #1: ffff888143cafdd8 ((work_completion)(&(&zrc->wor=
k)->work)){+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.191726][   T63] 2 locks held by kworker/4:3/282754:
[76754.196970][   T63]  #0: ffff88816dd19d38 ((wq_completion)kcopyd#2){+.+.=
}-{0:0}, at: process_one_work+0x712/0x1320
[76754.207344][   T63]  #1: ffff888113547dd8 ((work_completion)(&kc->kcopyd=
_work)){+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.218759][   T63] 3 locks held by kworker/u16:18/283196:
[76754.224261][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.235589][   T63]  #1: ffff888134f1fdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.246396][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.256777][   T63] 3 locks held by kworker/u16:20/283222:
[76754.262278][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.273600][   T63]  #1: ffff88814ed87dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.284401][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.294790][   T63] 3 locks held by kworker/u16:28/283657:
[76754.300298][   T63]  #0: ffff888142784938 ((wq_completion)dmz_rwq_dmz_dm=
l_073_1){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.311794][   T63]  #1: ffff88814934fdd8 ((work_completion)(&(&zrc->wor=
k)->work)){+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.323474][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_flush_metadata+0x8f/0x8a0 [dm_zoned]
[76754.334033][   T63] 3 locks held by kworker/u16:30/283684:
[76754.339547][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.350886][   T63]  #1: ffff88815358fdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.361707][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76754.372708][   T63] 3 locks held by kworker/u16:33/283687:
[76754.378224][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.389566][   T63]  #1: ffff888147d87dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.400401][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_wait_for_free_zones+0xd3/0x110 [dm_zoned]
[76754.411400][   T63] 3 locks held by kworker/u16:34/283706:
[76754.416903][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.428224][   T63]  #1: ffff888151fdfdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.439022][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.449392][   T63] 3 locks held by kworker/u16:38/284513:
[76754.454895][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.466210][   T63]  #1: ffff888137e97dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.477010][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.487380][   T63] 3 locks held by kworker/u16:42/284517:
[76754.492877][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.504198][   T63]  #1: ffff888101497dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.514995][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.525369][   T63] 3 locks held by kworker/u16:52/285020:
[76754.530867][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.542198][   T63]  #1: ffff8881384afdd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.553006][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.563382][   T63] 2 locks held by fio/289454:
[76754.567924][   T63]  #0: ffff88857abd6750 (&sb->s_type->i_mutex_key#17){=
++++}-{3:3}, at: ext4_buffered_write_iter+0xa0/0x340
[76754.579167][   T63]  #1: ffff888517fa6990 (jbd2_handle){++++}-{0:0}, at:=
 start_this_handle+0xd65/0x1190
[76754.588602][   T63] 2 locks held by fio/289463:
[76754.593154][   T63]  #0: ffff8885b974c980 (&sb->s_type->i_mutex_key#17){=
++++}-{3:3}, at: ext4_buffered_write_iter+0xa0/0x340
[76754.604386][   T63]  #1: ffff888517fa6990 (jbd2_handle){++++}-{0:0}, at:=
 start_this_handle+0xd65/0x1190
[76754.613805][   T63] 3 locks held by kworker/u16:1/289464:
[76754.619217][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.630534][   T63]  #1: ffff88816ac87dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.641332][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.651729][   T63] 3 locks held by kworker/u16:3/289465:
[76754.657156][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.668479][   T63]  #1: ffff888139597dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.679276][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.689647][   T63] 3 locks held by kworker/u16:4/289467:
[76754.695058][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.706376][   T63]  #1: ffff888193417dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.717195][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.727565][   T63] 3 locks held by kworker/u16:9/289468:
[76754.732977][   T63]  #0: ffff888142780938 ((wq_completion)dmz_fwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.744295][   T63]  #1: ffff8881258dfdd8 ((work_completion)(&(&dmz->flu=
sh_work)->work)){+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.756481][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_flush_metadata+0x8f/0x8a0 [dm_zoned]
[76754.767025][   T63] 3 locks held by kworker/u16:10/289469:
[76754.772524][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.783847][   T63]  #1: ffff88816c537dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.794649][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.805021][   T63] 3 locks held by kworker/u16:14/289471:
[76754.810519][   T63]  #0: ffff888142785938 ((wq_completion)dmz_cwq_dmz_dm=
l_073){+.+.}-{0:0}, at: process_one_work+0x712/0x1320
[76754.821838][   T63]  #1: ffff8881249c7dd8 ((work_completion)(&cw->work))=
{+.+.}-{0:0}, at: process_one_work+0x73f/0x1320
[76754.832637][   T63]  #2: ffff8881348291f0 (&zmd->mblk_sem){++++}-{3:3}, =
at: dmz_chunk_work+0x140/0x13b0 [dm_zoned]
[76754.843011][   T63]=20
[76754.845221][   T63] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[76754.845221][   T63]=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
