Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA3C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 02:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D262177E
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 02:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="pBJqLViO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCMC2Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 22:28:24 -0400
Received: from mail-eopbgr730085.outbound.protection.outlook.com ([40.107.73.85]:39616
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfCMC2Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 22:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcxDT47RBPgrDM6vjF0VJBHfmSnEQNHzI8bRs7WHhww=;
 b=pBJqLViOxU9n4EHdyuS609GhE1VVTzv4wtFuhJm3ClXiI3mu+uc5p8cLw7Zzes4PZQ2LgHMWjv3BnTZEZvgEg6zgHyIY5eFMjZneSJhf7RA9E3xxQh8O8fjeLONuHLqaX4gNKbpgRnPUfN3QT9EXd9DyfqLRZOm8g9HrZKh20ZA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4374.namprd03.prod.outlook.com (20.178.48.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Wed, 13 Mar 2019 02:28:18 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 02:28:17 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel 5.0 blk_clear_pm_only triggers a warning during resume
Thread-Topic: kernel 5.0 blk_clear_pm_only triggers a warning during resume
Thread-Index: AQHU2JVqw++m7acTO0eeaCYwVxL0GaYIFuSAgAC+F4A=
Date:   Wed, 13 Mar 2019 02:28:17 +0000
Message-ID: <20190313101841.6d9e952b@xhacker.debian>
References: <20190312132826.12c5f166@xhacker.debian>
        <1552402699.45180.106.camel@acm.org>
In-Reply-To: <1552402699.45180.106.camel@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:404:14::27) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5324b160-5d5d-4758-e97b-08d6a75b8d09
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4374;
x-ms-traffictypediagnostic: BYAPR03MB4374:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB4374;23:skpf0BHJNPCxPCqrnoJ1Z5gueE4p5PwShZw77hThU?=
 =?us-ascii?Q?iznv5bmuDXz7XCZyhRRswBuqLGiw20nX1NHczGpikL1GToZyye0a5Cq1SqM6?=
 =?us-ascii?Q?cM6EVrpOo5xv4t7aNG8kLD9q8mt9gd2VSywgUqTb13HJQgVMJDnBUlLlR2JH?=
 =?us-ascii?Q?wj7wIpUL2fI1VHjH6qQchD8CiND5fd3Ov9vt29/h5lEPCZ24n0qvAs0v9ANT?=
 =?us-ascii?Q?MfbfAlh3lkJLeGHCIO6vVsYibaUskoYN6MvTAyueQsgRNH9AgsFqsREU+X1i?=
 =?us-ascii?Q?ZFhTrEIlRgiyjuf3lr2/rLrgfD3dmEzjOnWTYPHds4eb0wsmHfV2kbgzJDTY?=
 =?us-ascii?Q?kDRSS55sAQIYq3yZcAA+DNO+KMtFtYR4nNRpB2/YPzpv51oKl1tGGuDFLJWg?=
 =?us-ascii?Q?KJKH25SO9JJENni30CyItz+9Jllj4hJXgf4OMbYzleaAiqfCSHdtQqGVvb8a?=
 =?us-ascii?Q?U64zv+t/+AZAIGYtWnUr+Xcwdj/wASwKGGvhBghbOE7j5KkWUH1KtuD6/X3F?=
 =?us-ascii?Q?hJWPgA47VLA1K4QLzinFE98Q8Om0pqKxyvbDp3zfAWPTCmbRtdqk2cPlLi8t?=
 =?us-ascii?Q?brAfBEle8cHbZ9Eg/Xne2jdIg8xgxFdSgGFs+7idwmmRXFdbLzUQTSohRqLX?=
 =?us-ascii?Q?PrmzxUib6Md+1uLlRAWBCS/mYrzGz25RKuWP3ugq7yem7ErQOQ2efYNR7KyH?=
 =?us-ascii?Q?PF9o0csXklU12Q4aOQWywlJuuxaYVj9tpApWSP28wdLeh9pqi/3uOqWaQGHH?=
 =?us-ascii?Q?OurpVa3xsgzg2CApMOWwlsnxTb58e15149L/SIGmCxD+/iFBdft5q4Tin1S8?=
 =?us-ascii?Q?STvKF07ZvxonnRYGp+phNauihEuQ0JLsmxNVh4s07OITF4KXkSN2uL3+nTXP?=
 =?us-ascii?Q?216IK9Mvi2eLTwIT3hKZVORkyMKt8rNX2IIu0VQOjnVN1SVMCMsNFsZJSzU/?=
 =?us-ascii?Q?jEH3d0K1w3Wfz0/+cMfAN6z3oTP4Y2jnPhLZU+X6DYKvhMM/8JBXE55S3C6Z?=
 =?us-ascii?Q?UQFFZbTBRKmLfltJ4BiY5XL6ocvBAmwZqhzzsUTEEeI0FCVLJp62dDE7SeK6?=
 =?us-ascii?Q?XhCmkg8/NX2qXTxSXBY5CW/Oav6lQ2RHdxBVn9A+miWbyO04CA6MZGfcxlYf?=
 =?us-ascii?Q?0+fIOEG398SsGKOGvyUzAv0RvspRGuR6e7c6GMdG5XCQaUT/5Xe8EFI68M7P?=
 =?us-ascii?Q?2Mj6R4A/Q0MSKf5Ax1Y2UhC6qTY1rLBVQ+ZzYlLbXxr7Ipohbm+JrDvVI4YP?=
 =?us-ascii?Q?KLoFRdwZUYYlMWYqScc1yCH6vocZsOogzwzCxL6UFBOplVBcYQrpkyh5hWvM?=
 =?us-ascii?Q?nEI28cUziepZCkLXqalblN005i5UKQ+pvTdeYRZeQE7u0KvDfuL6YksHKHbB?=
 =?us-ascii?Q?MSzJw=3D=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB4374295EC847C9509A41CAFBED4A0@BYAPR03MB4374.namprd03.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(51914003)(51234002)(189003)(199004)(2906002)(186003)(6246003)(386003)(6506007)(106356001)(102836004)(105586002)(66066001)(99286004)(76176011)(52116002)(486006)(476003)(26005)(54906003)(11346002)(446003)(316002)(8936002)(72206003)(6116002)(3846002)(14454004)(6916009)(1076003)(4326008)(478600001)(7736002)(50226002)(305945005)(8676002)(81166006)(81156014)(6436002)(86362001)(97736004)(5024004)(68736007)(14444005)(6486002)(256004)(53936002)(9686003)(6512007)(71190400001)(229853002)(71200400001)(25786009)(5660300002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4374;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OQkMC6M4Lnp3GWMlEXuwyC14FBE1kj8gr5bTzPOhZmhvMESdCE6bAqexq3Tt2TjRGHPPQokBanBoe/nn73+4sFlb/rU837I3cuGWKOL4lI7sVLqwFUmLL0osrLwsK1OXe5KLA8v5gbNTzgzUzhLrhd6YyC1kHvw4EDj4mtW/32yUPQPvF5OX2h/Xsx3nwUr8Z85Us3zG/BlDAD/B1q3Z9ZnI1ixkvlIi8v+BmZVz2fkMfb5jbHtItfUI3sW4tD8j1XsnlfEhtn2UTrKc8+dIeE4LEusLtnqsO/s05F37a8/22Kvc+UETJG/PaVSNbdKI138wuKbT0AJqHiJTAaThIxwyjgmGuq3gx9UW5M3X+bjutoN9OOx1MMCkc8DN2sgcdYFE3PzHbx2qJ4/konOQGEPxvbpClWZzDh1w8AH7faA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <432A5C7891558C42830DD5D72B5C2D66@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5324b160-5d5d-4758-e97b-08d6a75b8d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 02:28:17.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4374
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 12 Mar 2019 07:58:19 -0700 Bart Van Assche wrote:

> CAUTION: Email originated externally, do not click links or open attachme=
nts unless you recognize the sender and know the content is safe.
>=20
>=20
> On Tue, 2019-03-12 at 05:35 +0000, Jisheng Zhang wrote:
> > I got below warning during resume:
> >
> > [  673.658888] sd 0:0:0:0: [sda] Starting disk
> > [  673.658899] WARNING: CPU: 3 PID: 1039 at blk_clear_pm_only+0x2a/0x30
> > [  673.658902] CPU: 3 PID: 1039 Comm: kworker/u8:49 Not tainted 5.0.0+ =
#1
> > [  673.658902] sd 2:0:0:0: [sdb] Starting disk
> > [  673.658903] Hardware name: LENOVO 4180F42/4180F42, BIOS 83ET75WW (1.=
45 ) 05/10/2013
> > [  673.658906] Workqueue: events_unbound async_run_entry_fn
> > [  673.658909] RIP: 0010:blk_clear_pm_only+0x2a/0x30
> > [  673.658911] Code: b8 ff ff ff ff f0 0f c1 87 80 00 00 00 83 e8 01 78=
 18 74 01 c3 48 81 c7 58 05 00 00 31 c9 31 d2 be 03 00 00 00 e9 36 97 e2 ff=
 <0f> 0b c3 0f 1f 00 48 81 c7 90 00 00 00 e9 04 01
> > 3a 00 0f 1f 40 00
> > [  673.658911] RSP: 0000:ffff8881115a7e48 EFLAGS: 00010297
> > [  673.658913] RAX: 00000000ffffffff RBX: ffff888118d42800 RCX: ffff888=
1194c9a00
> > [  673.658914] RDX: ffff888118ab1a00 RSI: 0000000000000000 RDI: ffff888=
117e70000
> > [  673.658915] RBP: ffff888118d42f90 R08: 0000000000000004 R09: 0000000=
00001f900
> > [  673.658915] R10: 0000000045698a8e R11: 0000000000000010 R12: ffff888=
119421000
> > [  673.658916] R13: 0000000000000000 R14: ffff88800030ea80 R15: 0ffff88=
811942100
> > [  673.658918] FS:  0000000000000000(0000) GS:ffff88811a180000(0000) kn=
lGS:0000000000000000
> > [  673.658918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  673.658919] CR2: 0000000000000000 CR3: 000000000200c001 CR4: 0000000=
0000606e0
> > [  673.658920] Call Trace:
> > [  673.658924]  ? scsi_device_resume+0x28/0x50
> > [  673.658926]  ? scsi_dev_type_resume+0x2b/0x80
> > [  673.658927]  ? async_run_entry_fn+0x2c/0xd0
> > [  673.658930]  ? process_one_work+0x1f0/0x3f0
> > [  673.658932]  ? worker_thread+0x28/0x3c0
> > [  673.658933]  ? process_one_work+0x3f0/0x3f0
> > [  673.658935]  ? kthread+0x10c/0x130
> > [  673.658936]  ? __kthread_create_on_node+0x150/0x150
> > [  673.658938]  ? ret_from_fork+0x1f/0x30
> > [  673.658940] ---[ end trace ce18772de33e283e ]--- =20
>=20
> Hi Jisheng,

Hi Bart,

>=20
> Is this something that occurred once or is this something that you can re=
produce

It's 100% reproduced on my home's laptop PC.

> easily? In the latter case, can you verify whether the patch below is suf=
ficient
> to make this warning disappear?

Thanks for the patch. I will test it this night.

>=20
> Thanks,
>=20
> Bart.
>=20
> ---
>  drivers/scsi/scsi_lib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f3f24dfd8fd5..33e1a72d47fa 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2540,8 +2540,10 @@ void scsi_device_resume(struct scsi_device *sdev)
>          * device deleted during suspend)
>          */
>         mutex_lock(&sdev->state_mutex);
> -       sdev->quiesced_by =3D NULL;
> -       blk_clear_pm_only(sdev->request_queue);
> +       if (sdev->quiesced_by) {
> +               sdev->quiesced_by =3D NULL;
> +               blk_clear_pm_only(sdev->request_queue);
> +       }
>         if (sdev->sdev_state =3D=3D SDEV_QUIESCE)
>                 scsi_device_set_state(sdev, SDEV_RUNNING);
>         mutex_unlock(&sdev->state_mutex);
>=20

