Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2CAC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 05:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9795E214AF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 05:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="LWHfHM30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfCLFg1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:36:27 -0400
Received: from mail-eopbgr810072.outbound.protection.outlook.com ([40.107.81.72]:27040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfCLFg0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 01:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AECtvOOFWq1lYLKOB+YwnhDv6HJt3KtjjLL2vO/KZ9M=;
 b=LWHfHM306nrk8PuCOa/vT9T1+fuQjjFdcsxk57UCGW4fHLMjy9RpVf9SGgg/NUw01vnUt35uKVy0i9YyIlXJ6pmjWxKCTROXPu87GZ+Egsb4ix2c72+vCBgiSLWdcCIQ5odgtfoERp4rlum/uP8Smp3+cuKDYb3+5U9a4EPGJAY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3736.namprd03.prod.outlook.com (52.135.214.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 05:35:43 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 05:35:43 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: kernel 5.0 blk_clear_pm_only triggers a warning during resume
Thread-Topic: kernel 5.0 blk_clear_pm_only triggers a warning during resume
Thread-Index: AQHU2JVvuDgOhmoPBEi74ENXmxZW/g==
Date:   Tue, 12 Mar 2019 05:35:43 +0000
Message-ID: <20190312132826.12c5f166@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR01CA0215.jpnprd01.prod.outlook.com
 (2603:1096:404:29::35) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e32dc1d0-ce45-4166-73cd-08d6a6ac91db
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3736;
x-ms-traffictypediagnostic: BYAPR03MB3736:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB3736;23:Zlpqo7L/+s9xFsOCT9GipiRVu0eLPoFGMmITxfvgh?=
 =?us-ascii?Q?I4zATHwcY2v/CeFwTblUX7Oqz4rjftqKZJN8MkiiOyfJwf6vXB0HCidbbIG1?=
 =?us-ascii?Q?Kto0lpi+5ExkWGVltplQg5fGTPnFeD0ikYMwmUxRXsI5P4WwgOeVbytcQ9+8?=
 =?us-ascii?Q?u7BOmNya8iMQTXgrmUIUeW6do4IT+epP7wGXp/+diJ88/ao6Z7h8qhjSN/R+?=
 =?us-ascii?Q?JX5smacuaQS/92PSGsiJ0JefYHWZ4X8MgP94ABuC12F7qpr2rYwdVqEDssH8?=
 =?us-ascii?Q?anO29tZfMq4knMQ1M0i1CnR7KW+hMTN0SsYmwoGrC/DFWlrZYpK/qregUtu7?=
 =?us-ascii?Q?z/TWgORHuBgRrHx61A0R4kd967h+oTGmkaUQfASXm23+S40gCI+eGUtMzrT/?=
 =?us-ascii?Q?sZXsXrPKeV9HUtjHPRN0ghXxQ9vAMdfmeKnNYFQ6jyvbHAMuVcgeFsVcRGv5?=
 =?us-ascii?Q?W8HbjlIiRMvOhzm1L+jgUkBvtmfO2l8rwKMHdxJpjGZPhs7vELOXX+qjXmMf?=
 =?us-ascii?Q?OLRiFfZoelYHgnUhRdFQs2766oPR7hKceGTrp8rzpgsIRiusnPzNJNOklcGh?=
 =?us-ascii?Q?FBmWz8ErvsHGvn8G9nTEqQRhWwFesf+cDIUIVhUQVdZVcg250YFhmEkWXBwO?=
 =?us-ascii?Q?jzmRI/dxSSWDdsbMVXgn+lJG8LlK4sTML3YEPhOBmytAhXj1KOrBehG3gqZ0?=
 =?us-ascii?Q?e7N5r2kx6Gk8XLLlj4GahZd+on41qtS6ktElOzUNxY26crY06dmo/fkMAWFg?=
 =?us-ascii?Q?UCdEiC14hh9RHDcue88dxlzzTs9g2RPR6SFGSp1iz3qo2UNRojaR4nTjxtKr?=
 =?us-ascii?Q?M8I51qe3hAo/+WOVgQhpRi0OMLRjCeelMOgvXke1aunD0An0SSkK41zATuQT?=
 =?us-ascii?Q?5S0BeIlhaIf3j8v1p1sV5KEdqskO9fOYkJkpEvMsbxG9YA4CYWOL2GJcFzj7?=
 =?us-ascii?Q?59SqXYuHjssDgVeq2qf6Ou5vLlLWR+P8RKtENkD3LU6UQhnlFGr6fd3TJRqg?=
 =?us-ascii?Q?DaUdwcfRZYd/iPzzaKF5zVAMMm+OBMFlIPCPAyYV1XsCKre6BP1CJiwYa35w?=
 =?us-ascii?Q?EoRLX52HwHG4NJtFlV2/0UVU93I9wITw/XRQ6hJx/zNeZ/lcihDY2pMtXXKf?=
 =?us-ascii?Q?Iu9z2O7egmDNJ5cHZ6vdH7OqDMn5DvGgfGdGTGB16r5MuUb3JTzRUGkOWYpw?=
 =?us-ascii?Q?I3BZA8mHg8pBNjE2ViqC+uFB6oyDRAZrnmgMpo6OQOM9DbaCm20xh4Eyw=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB3736E6DC6283F7282F44EF69ED490@BYAPR03MB3736.namprd03.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(51234002)(199004)(189003)(476003)(105586002)(106356001)(68736007)(50226002)(8936002)(99286004)(6512007)(9686003)(6486002)(71200400001)(53936002)(6436002)(97736004)(14444005)(486006)(71190400001)(86362001)(256004)(52116002)(26005)(102836004)(6506007)(386003)(186003)(66066001)(81156014)(2906002)(8676002)(81166006)(478600001)(1076003)(3846002)(305945005)(5660300002)(25786009)(4326008)(7736002)(14454004)(316002)(54906003)(110136005)(6116002)(72206003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3736;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:3;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nrFKfZfX7DF9IppLa14ewijdySTJtZaZHAgV+an8RdV/QZwL25KRt/PLcKosMk6NhFlgdSmZJVDqRnXoYshJhrysLFkxERaJ9z2akjlPohcA5FkBqCwfsHdZohiNinCerB5RnoMZ03WJcBSDIQzVavwN9/1AfkMx+pOAMgTbMXOid6xdjMSMN+nDHOkamie+IhX7FcWshMFuXK0cTwM5vY4eLqLCYtUw/c8m66sw4ba8bcIPZ8Eo61JNAqskIhSKGJmFXIQz5wSHDCIDii8gifud5egklOli5bPnL+lrCDWD7csK1BbKKuEYdh0hmJRHR4yxHaPMIfdjakcMeCzvh21i9y5XtMBfN/q685YrzH/kQ5j69Q0UwmwzEskt330lxUd5CHzc4ArzbUFHULN88FnTqZJHLCMVRo8sqhK6dMk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <988FA2967C0A644AACF3FE99D84C8CAF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32dc1d0-ce45-4166-73cd-08d6a6ac91db
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 05:35:43.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3736
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

kernel version: 5.0

I got below warning during resume:

[  673.658888] sd 0:0:0:0: [sda] Starting disk
[  673.658899] WARNING: CPU: 3 PID: 1039 at blk_clear_pm_only+0x2a/0x30
[  673.658902] CPU: 3 PID: 1039 Comm: kworker/u8:49 Not tainted 5.0.0+ #1
[  673.658902] sd 2:0:0:0: [sdb] Starting disk
[  673.658903] Hardware name: LENOVO 4180F42/4180F42, BIOS 83ET75WW (1.45 )=
 05/10/2013
[  673.658906] Workqueue: events_unbound async_run_entry_fn
[  673.658909] RIP: 0010:blk_clear_pm_only+0x2a/0x30
[  673.658911] Code: b8 ff ff ff ff f0 0f c1 87 80 00 00 00 83 e8 01 78 18 =
74 01 c3 48 81 c7 58 05 00 00 31 c9 31 d2 be 03 00 00 00 e9 36 97 e2 ff <0f=
> 0b c3 0f 1f 00 48 81 c7 90 00 00 00 e9 04 01 3a 00 0f 1f 40 00
[  673.658911] RSP: 0000:ffff8881115a7e48 EFLAGS: 00010297
[  673.658913] RAX: 00000000ffffffff RBX: ffff888118d42800 RCX: ffff8881194=
c9a00
[  673.658914] RDX: ffff888118ab1a00 RSI: 0000000000000000 RDI: ffff888117e=
70000
[  673.658915] RBP: ffff888118d42f90 R08: 0000000000000004 R09: 00000000000=
1f900
[  673.658915] R10: 0000000045698a8e R11: 0000000000000010 R12: ffff8881194=
21000
[  673.658916] R13: 0000000000000000 R14: ffff88800030ea80 R15: 0ffff888119=
42100
[  673.658918] FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:=
0000000000000000
[  673.658918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  673.658919] CR2: 0000000000000000 CR3: 000000000200c001 CR4: 00000000000=
606e0
[  673.658920] Call Trace:
[  673.658924]  ? scsi_device_resume+0x28/0x50
[  673.658926]  ? scsi_dev_type_resume+0x2b/0x80
[  673.658927]  ? async_run_entry_fn+0x2c/0xd0
[  673.658930]  ? process_one_work+0x1f0/0x3f0
[  673.658932]  ? worker_thread+0x28/0x3c0
[  673.658933]  ? process_one_work+0x3f0/0x3f0
[  673.658935]  ? kthread+0x10c/0x130
[  673.658936]  ? __kthread_create_on_node+0x150/0x150
[  673.658938]  ? ret_from_fork+0x1f/0x30
[  673.658940] ---[ end trace ce18772de33e283e ]---


I notice that commit 388b4e6a00bb3 ("scsi: core: Avoid that system resume
triggers a kernel warning") tried to fix the warning in the same code path
perhaps, it isn't enough.

Thanks
