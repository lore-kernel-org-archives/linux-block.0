Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D0C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 02:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41722087C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 02:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="OxfwdXWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfCNCVb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:21:31 -0400
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:26656
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfCNCVa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 22:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGrg7NhEC6JLOO93kjPxZxEULa7OFn3VUAmQ/F0U3Yk=;
 b=OxfwdXWVqu/bmYDvVywcpx30mW0fDcKKMMrzNdM3tvtseqKLSXJHx5PekzYsZuhgUdgDHUIA6IhL8P7MktQjZ3Nt/QDvqEroPW5+uGeTctkvdbd/OmN15DbZcxrnJsds+vOJdQUyn04swFEL5LAULl9m5T+6J2DGsZvK30yBPKg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3719.namprd03.prod.outlook.com (52.135.214.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Thu, 14 Mar 2019 02:21:25 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 02:21:25 +0000
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
Thread-Index: AQHU2JVqw++m7acTO0eeaCYwVxL0GaYIFuSAgAFEM4CAAQrkgA==
Date:   Thu, 14 Mar 2019 02:21:25 +0000
Message-ID: <20190314101355.1df7c014@xhacker.debian>
References: <20190312132826.12c5f166@xhacker.debian>
        <1552402699.45180.106.camel@acm.org>    <20190313101841.6d9e952b@xhacker.debian>
In-Reply-To: <20190313101841.6d9e952b@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYCPR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:405:2::35) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0d8a835-f027-4280-e288-08d6a823c1ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB3719;
x-ms-traffictypediagnostic: BYAPR03MB3719:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR03MB3719;23:B80uAHXkAE2lzIB9hRyw/XGr90SORxXXkXR/JyxTH?=
 =?us-ascii?Q?QgoRwEZumecnHx4Ub7f6Mi0yeU0+0/JGEKEwofN4/h/p74yNzjm5FxE8IxjZ?=
 =?us-ascii?Q?VsYTiAdgwP644IuqgsUvuXTXAzhgJjJctlvoAYgPwdW4OF/glzz9iEYoNhjC?=
 =?us-ascii?Q?UWG6v+yuOmUbRORrbC87xFjpdW4u1MxvbIv1pLtGl/o/UNqUN0m7IeIGMijS?=
 =?us-ascii?Q?y8Qq1wU10s2GbLamAz+T43CwgZtxs+hRDsrKFjmPeQ1QrJ6uomkqrHTmZK6q?=
 =?us-ascii?Q?u5Y1NCVn7alcrsXVtbu+OmIVmUNRHdzFKVIrMOUhRLmZKqc2lp3gLhlk25aA?=
 =?us-ascii?Q?EcxHXkWeLDGqe34FDZzcagTKc02FqsjtqLHCVflCJRytbuMGR4hrUXptzbNF?=
 =?us-ascii?Q?CwlJUTu2AOIDmboKsK5ETTQYbgsis2Up0GuB1UoWT5bCTJYIWecOgr/Cx6lC?=
 =?us-ascii?Q?IcUTQAvZi5/jrV7nOdX/rSXEguf8JacgsSFoCsxOCUXLpiVsBPKDqr+6+oYt?=
 =?us-ascii?Q?gomkZ+TFflulG5tT4Vw04ExbVvu8ETZeUKoShPHHDsFNedQc+uvEQ7Kbk3Sr?=
 =?us-ascii?Q?YzrsAXIesZFrP2Ml3OhVa4BxKEa41e+Q6q02OgocuT8UByhkt0XojS1KDyTd?=
 =?us-ascii?Q?/CFL0D9ftBW5pUb3LfP7PAWKCluaMHJZ1dnr1sLGEgaZQmcNsAlfPLwsqdX2?=
 =?us-ascii?Q?FEJ7ro3C3n1WywuO+RAwlWiviefB1HQIyEyeZ+yzScHGGGbevcKgScYO4ocW?=
 =?us-ascii?Q?YgFjXnDhEgwEZRIZnPKZ3wD5kko0/cF2HMbQS2Rmkg5UGzz1KFt15TLnuC+G?=
 =?us-ascii?Q?C6eF9C5TVvBdiiMdr9dsTEegIJua4ZxBMhTawuA2eujwpkTHWhXocF5yQkZ0?=
 =?us-ascii?Q?Bn4fMMMlM1+JkN26Sn1cK9t16sU288FZCX4i7DZSQySc5yS3YmJZlJXzG8WJ?=
 =?us-ascii?Q?wnHukartDC4C1KC9rDQ+qFdwU2Ek6oQdGbnePf+XaIg1yI/1JTQOtF10Ibbd?=
 =?us-ascii?Q?KJhA/eiSXs6fh1+Nw9ZPxLT3RcSaqyzEiKopJ/721304OgxNqMEHxw7BbWwF?=
 =?us-ascii?Q?9FwNYRVzS/VOzhI80KaFsivcVTKtnYRQv/11RinUgS3qvJTTU30kE+KcYk/z?=
 =?us-ascii?Q?sKwDShkZ5qMhFXXRD1UY66GCb2sGlgfG+jVUSh5+8i0ti1nT9o094nRR9Kue?=
 =?us-ascii?Q?UPADGGRuV72X1L1N/7/wA8Tr7tavwVyREcYNvWnscH+TthMHFpXtlzoPynA6?=
 =?us-ascii?Q?yXHHk0Y+TDQ3ilEQiSL7x/mjcIOzcfcQqys1+w3PQrfsigcWsIWD0gscdE7e?=
 =?us-ascii?Q?xWtmUOpD1P2k7PbdKfS96AZxi0mV+pb+NRGQpNp2KpqbnlA0aFmkADU9Wfu1?=
 =?us-ascii?Q?6DAzw=3D=3D?=
x-microsoft-antispam-prvs: <BYAPR03MB3719FBE771B104228F9BAF5CED4B0@BYAPR03MB3719.namprd03.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(51234002)(51914003)(6506007)(386003)(86362001)(97736004)(7736002)(72206003)(102836004)(478600001)(26005)(446003)(11346002)(81166006)(81156014)(5660300002)(5024004)(14444005)(256004)(1076003)(8676002)(71190400001)(71200400001)(476003)(6246003)(6436002)(229853002)(3846002)(8936002)(6116002)(6486002)(68736007)(6512007)(66066001)(53936002)(316002)(305945005)(54906003)(186003)(9686003)(2906002)(486006)(76176011)(4326008)(14454004)(25786009)(6916009)(50226002)(99286004)(106356001)(105586002)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3719;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bBU9r93BTwMWi0GTAoszgrftRykITZHPP2Jl3qxFpJMgehM1u/1cJXP7emfSsp8c0CgC9fPrZ684BbINhN6xGW0CxvJ/JD8OfMZWShjScVHEj9kw5PZkNbnDuPjJD299hhhSAOCH37fbB99GV45YJxHI/iVhdJd1tRriaSAikjC7uG0HFoaOmt27KBky+bToQ+NeJcWS7l55bzmBm/ZlhEuZoJkiD2zxNXGFjpPrsGkJ00Ux+NVN3FV7keTP3ou7HnrfR0S3MixsYuwkUvyvI6r9OQh7KS2FlDj4Udeuxb7g93+5DYr0qgoDEIOoRDqhDC+wrv/3I1BmlMGQ45NEVnCxXTdK7jR2k/rUIIMt0W7qpYuwJNFgbyTO8oCWX1eRB8ffCKS/XdqNMJ8Cd76ybGtpT066pZSEi+7rVf0YI1s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB4972A7A56C5645BE7A4A1CE432D2A4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d8a835-f027-4280-e288-08d6a823c1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 02:21:25.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3719
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Mar 2019 10:18:41 +0800 Jisheng Zhang wrote:

> On Tue, 12 Mar 2019 07:58:19 -0700 Bart Van Assche wrote:
>=20
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > On Tue, 2019-03-12 at 05:35 +0000, Jisheng Zhang wrote: =20
> > > I got below warning during resume:
> > >
> > > [  673.658888] sd 0:0:0:0: [sda] Starting disk
> > > [  673.658899] WARNING: CPU: 3 PID: 1039 at blk_clear_pm_only+0x2a/0x=
30
> > > [  673.658902] CPU: 3 PID: 1039 Comm: kworker/u8:49 Not tainted 5.0.0=
+ #1
> > > [  673.658902] sd 2:0:0:0: [sdb] Starting disk
> > > [  673.658903] Hardware name: LENOVO 4180F42/4180F42, BIOS 83ET75WW (=
1.45 ) 05/10/2013
> > > [  673.658906] Workqueue: events_unbound async_run_entry_fn
> > > [  673.658909] RIP: 0010:blk_clear_pm_only+0x2a/0x30
> > > [  673.658911] Code: b8 ff ff ff ff f0 0f c1 87 80 00 00 00 83 e8 01 =
78 18 74 01 c3 48 81 c7 58 05 00 00 31 c9 31 d2 be 03 00 00 00 e9 36 97 e2 =
ff <0f> 0b c3 0f 1f 00 48 81 c7 90 00 00 00 e9 04 01
> > > 3a 00 0f 1f 40 00
> > > [  673.658911] RSP: 0000:ffff8881115a7e48 EFLAGS: 00010297
> > > [  673.658913] RAX: 00000000ffffffff RBX: ffff888118d42800 RCX: ffff8=
881194c9a00
> > > [  673.658914] RDX: ffff888118ab1a00 RSI: 0000000000000000 RDI: ffff8=
88117e70000
> > > [  673.658915] RBP: ffff888118d42f90 R08: 0000000000000004 R09: 00000=
0000001f900
> > > [  673.658915] R10: 0000000045698a8e R11: 0000000000000010 R12: ffff8=
88119421000
> > > [  673.658916] R13: 0000000000000000 R14: ffff88800030ea80 R15: 0ffff=
88811942100
> > > [  673.658918] FS:  0000000000000000(0000) GS:ffff88811a180000(0000) =
knlGS:0000000000000000
> > > [  673.658918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  673.658919] CR2: 0000000000000000 CR3: 000000000200c001 CR4: 00000=
000000606e0
> > > [  673.658920] Call Trace:
> > > [  673.658924]  ? scsi_device_resume+0x28/0x50
> > > [  673.658926]  ? scsi_dev_type_resume+0x2b/0x80
> > > [  673.658927]  ? async_run_entry_fn+0x2c/0xd0
> > > [  673.658930]  ? process_one_work+0x1f0/0x3f0
> > > [  673.658932]  ? worker_thread+0x28/0x3c0
> > > [  673.658933]  ? process_one_work+0x3f0/0x3f0
> > > [  673.658935]  ? kthread+0x10c/0x130
> > > [  673.658936]  ? __kthread_create_on_node+0x150/0x150
> > > [  673.658938]  ? ret_from_fork+0x1f/0x30
> > > [  673.658940] ---[ end trace ce18772de33e283e ]---   =20
> >=20
> > Hi Jisheng, =20
>=20
> Hi Bart,
>=20
> >=20
> > Is this something that occurred once or is this something that you can =
reproduce =20
>=20
> It's 100% reproduced on my home's laptop PC.
>=20
> > easily? In the latter case, can you verify whether the patch below is s=
ufficient
> > to make this warning disappear? =20
>=20
> Thanks for the patch. I will test it this night.

Good news. The patch fix the warning. So=20

Tested-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Thanks

>=20
> >=20
> > Thanks,
> >=20
> > Bart.
> >=20
> > ---
> >  drivers/scsi/scsi_lib.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index f3f24dfd8fd5..33e1a72d47fa 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -2540,8 +2540,10 @@ void scsi_device_resume(struct scsi_device *sdev=
)
> >          * device deleted during suspend)
> >          */
> >         mutex_lock(&sdev->state_mutex);
> > -       sdev->quiesced_by =3D NULL;
> > -       blk_clear_pm_only(sdev->request_queue);
> > +       if (sdev->quiesced_by) {
> > +               sdev->quiesced_by =3D NULL;
> > +               blk_clear_pm_only(sdev->request_queue);
> > +       }
> >         if (sdev->sdev_state =3D=3D SDEV_QUIESCE)
> >                 scsi_device_set_state(sdev, SDEV_RUNNING);
> >         mutex_unlock(&sdev->state_mutex);
> >  =20
>=20

