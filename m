Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8018BC282DC
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 23:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDF727A34
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 23:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oZL0csIG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eTQfsFrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFBXnv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jun 2019 19:43:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31159 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFBXnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jun 2019 19:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559519061; x=1591055061;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RfYji+B18oW8P7M4M6oGhR8sPvs/SVTLe5KoHJ5prTU=;
  b=oZL0csIGVLW5VwpF9B/UoZabDekd15SaXCkCkQ+bjKDxDH+TDxPagoZO
   WL5T0Rc0fi5yv2eC+CNxoS0DLmL0AOTWJeXc7PJn8SuYv9i3NEDSoZj2n
   rO1ppJwzx+Trj/DOU1KH09kFew92vTCi04CrddbqT4fNR2oUqKW9KTNS3
   D4KJI5Yu9lJ07Zy1uu2FO3HTlm3NSM9/M1qSmL7hL7N3BLHWFjn36PNfI
   F1dqh6yDO3+3KTygnFVTkASsSJgPaYbUmQeMfOVZceos/upZXS7UeHEXk
   V7lUURTH+2pbqyjXS5LBjEtODZqKAXe1aX/F7GOmfERAMh6XllpsCxVtc
   A==;
X-IronPort-AV: E=Sophos;i="5.60,544,1549900800"; 
   d="scan'208";a="209207668"
Received: from mail-by2nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.52])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2019 07:44:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGZvOqXysFiRL/WCcmJC5s2XvoD5cQiAxuIG6Efi4Ig=;
 b=eTQfsFrrNrxOuW+oSY6rg7tAxZ0F576dVw72XJkDW3YqO7HAkkCox7ykbOleWj8HTDL/D+a7aQrqhGeRIQ/YPK6tuP+XeicDJxCe6CwDlZ3Yuzgg+tp5FbRPjYrJk2e6nZGzAPpuZdBBcPa+nRazW5kVVAO7LRvnPmonueeIkWA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5110.namprd04.prod.outlook.com (52.135.235.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.16; Sun, 2 Jun 2019 23:43:47 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1943.018; Sun, 2 Jun 2019
 23:43:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hare@suse.com" <hare@suse.com>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: null_blk: fix race condition for null_del_dev
Thread-Topic: [PATCH] block: null_blk: fix race condition for null_del_dev
Thread-Index: AQHVF3cUt12bBtQmMUufFactkaZk8w==
Date:   Sun, 2 Jun 2019 23:43:46 +0000
Message-ID: <BYAPR04MB57498234FD33E381E665B066861B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190531060545.10235-1-bob.liu@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8b0a7ca-c414-40aa-7d1a-08d6e7b427da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5110;
x-ms-traffictypediagnostic: BYAPR04MB5110:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5110E0E146EA3913D448A123861B0@BYAPR04MB5110.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 005671E15D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(7696005)(305945005)(102836004)(99286004)(8676002)(7736002)(66066001)(446003)(71200400001)(71190400001)(26005)(476003)(81156014)(81166006)(6506007)(229853002)(86362001)(110136005)(52536014)(54906003)(478600001)(68736007)(14454004)(2501003)(74316002)(8936002)(72206003)(76176011)(53546011)(486006)(66946007)(66476007)(76116006)(73956011)(186003)(64756008)(66446008)(66556008)(256004)(14444005)(25786009)(55016002)(6436002)(6246003)(9686003)(2906002)(53936002)(4326008)(6116002)(5660300002)(316002)(3846002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5110;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AHgAu/FzGkGZkABpyPIjpTnPvjMoNyMFddZoCm17+AgqWHnVeUFGYfOTnEXRri3Ejqa5Gngsbyn/EXVLBZN3s9HOoSlkCGIRfg+lqpgW4vrOuOtHWZTNfBR6cv1UomyfIfby+AKgpzSZr7jJBsB1IIavxq6QMO7zEVcxhgem1Ly7zbw82urB5AS8tNmolLO2TqvKhsD+K7yZ+SCKnIRmOnRCnyuShTv1FcQuzTFLSE+SivEdDUWF308hJ6xbmL0jBLN8BS8mI0krtbf9Ou14C2bSClYFQbXBLY2putrpMy/sjrYQ24NBBvKg6uLtVYmIeCWHlhahmI963gGSv8/YrI23b71w42+lMxCTNofYB4UY4PO79FDchtN/fgBwEQbuLj3QiKlOI9nvYtk9g1O0P3HHD+pxkb1EyUS7hJxWW/4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b0a7ca-c414-40aa-7d1a-08d6e7b427da
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2019 23:43:46.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for your patch Bob.=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 5/30/19 11:07 PM, Bob Liu wrote:=0A=
> Dulicate call of null_del_dev() will trigger null pointer error like belo=
w.=0A=
> The reason is a race condition between nullb_device_power_store() and=0A=
> nullb_group_drop_item().=0A=
>=0A=
>  CPU#0                         CPU#1=0A=
>  ----------------              -----------------=0A=
>  do_rmdir()=0A=
>   >configfs_rmdir()=0A=
>    >client_drop_item()=0A=
>     >nullb_group_drop_item()=0A=
>                                nullb_device_power_store()=0A=
> 				>null_del_dev()=0A=
>=0A=
>      >test_and_clear_bit(NULLB_DEV_FL_UP=0A=
>       >null_del_dev()=0A=
>       ^^^^^=0A=
>       Duplicated null_dev_dev() triger null pointer error=0A=
>=0A=
> 				>clear_bit(NULLB_DEV_FL_UP=0A=
>=0A=
> The fix could be keep the sequnce of clear NULLB_DEV_FL_UP and null_del_d=
ev().=0A=
>=0A=
> [  698.613600] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000018=0A=
> [  698.613608] #PF error: [normal kernel read fault]=0A=
> [  698.613611] PGD 0 P4D 0=0A=
> [  698.613619] Oops: 0000 [#1] SMP PTI=0A=
> [  698.613627] CPU: 3 PID: 6382 Comm: rmdir Not tainted 5.0.0+ #35=0A=
> [  698.613631] Hardware name: LENOVO 20LJS2EV08/20LJS2EV08, BIOS R0SET33W=
 (1.17 ) 07/18/2018=0A=
> [  698.613644] RIP: 0010:null_del_dev+0xc/0x110 [null_blk]=0A=
> [  698.613649] Code: 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b eb 9=
7 e8 47 bb 2a e8 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <=
8b> 77 18 48 89 fb 4c 8b 27 48 c7 c7 40 57 1e c1 e8 bf c7 cb e8 48=0A=
> [  698.613654] RSP: 0018:ffffb887888bfde0 EFLAGS: 00010286=0A=
> [  698.613659] RAX: 0000000000000000 RBX: ffff9d436d92bc00 RCX: ffff9d43a=
9184681=0A=
> [  698.613663] RDX: ffffffffc11e5c30 RSI: 0000000068be6540 RDI: 000000000=
0000000=0A=
> [  698.613667] RBP: ffffb887888bfdf0 R08: 0000000000000001 R09: 000000000=
0000000=0A=
> [  698.613671] R10: ffffb887888bfdd8 R11: 0000000000000f16 R12: ffff9d436=
d92bc08=0A=
> [  698.613675] R13: ffff9d436d94e630 R14: ffffffffc11e5088 R15: ffffffffc=
11e5000=0A=
> [  698.613680] FS:  00007faa68be6540(0000) GS:ffff9d43d14c0000(0000) knlG=
S:0000000000000000=0A=
> [  698.613685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
> [  698.613689] CR2: 0000000000000018 CR3: 000000042f70c002 CR4: 000000000=
03606e0=0A=
> [  698.613693] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000=0A=
> [  698.613697] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400=0A=
> [  698.613700] Call Trace:=0A=
> [  698.613712]  nullb_group_drop_item+0x50/0x70 [null_blk]=0A=
> [  698.613722]  client_drop_item+0x29/0x40=0A=
> [  698.613728]  configfs_rmdir+0x1ed/0x300=0A=
> [  698.613738]  vfs_rmdir+0xb2/0x130=0A=
> [  698.613743]  do_rmdir+0x1c7/0x1e0=0A=
> [  698.613750]  __x64_sys_rmdir+0x17/0x20=0A=
> [  698.613759]  do_syscall_64+0x5a/0x110=0A=
> [  698.613768]  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>=0A=
> Signed-off-by: Bob Liu <bob.liu@oracle.com>=0A=
> ---=0A=
>  drivers/block/null_blk_main.c | 11 ++++++-----=0A=
>  1 file changed, 6 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.=
c=0A=
> index 62c9654..99dd0ab 100644=0A=
> --- a/drivers/block/null_blk_main.c=0A=
> +++ b/drivers/block/null_blk_main.c=0A=
> @@ -326,11 +326,12 @@ static ssize_t nullb_device_power_store(struct conf=
ig_item *item,=0A=
>  		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);=0A=
>  		dev->power =3D newp;=0A=
>  	} else if (dev->power && !newp) {=0A=
> -		mutex_lock(&lock);=0A=
> -		dev->power =3D newp;=0A=
> -		null_del_dev(dev->nullb);=0A=
> -		mutex_unlock(&lock);=0A=
> -		clear_bit(NULLB_DEV_FL_UP, &dev->flags);=0A=
> +		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {=0A=
> +			mutex_lock(&lock);=0A=
> +			dev->power =3D newp;=0A=
> +			null_del_dev(dev->nullb);=0A=
> +			mutex_unlock(&lock);=0A=
> +		}=0A=
>  		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);=0A=
>  	}=0A=
>  =0A=
=0A=
=0A=
