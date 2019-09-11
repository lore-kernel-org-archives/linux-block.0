Return-Path: <SRS0=ntoj=XG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E5DC49ED6
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FD72082C
	for <linux-block@archiver.kernel.org>; Wed, 11 Sep 2019 20:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vf3GX8ka";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P/PVExw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfIKUnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:43:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13803 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfIKUnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 16:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568234598; x=1599770598;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aogmk4FuBrjd87UsgV5gMKB2uVgd7f9o/TTL+qWFMAY=;
  b=Vf3GX8kaxqjUZ9Rwc9xDrtrL9kA/o4vxa9I1MTDFfuiNRswuMxTJljO8
   +8i74SxBTDbYB5t7PX0A2jo4zBiN2MyT90rA+zKUJUq6AvtqY4NGdt9VY
   Cy74uWk39T44I5ufEld0eH+Y5oSk0Po7myl9E089S2vMDmoxiq/O5AGaY
   EmZb0TpirdibheuuLZTBJU1344b8ey6iZosfX4cAkeJRHFLrRhU7PcAiJ
   pLKHFzKUwud5PH1I5GM3vhcn1FsEwZLPEdJO/PpH5QSa+MpgXHFU/aZBF
   s3+5vbneM+EAjc7XRdqqFVwW6MYcDxs4W11UFn2BV3wP2KW/P2aMlNMF4
   Q==;
IronPort-SDR: IQ2KiWAkylZZrI6mt0wB85MScQ+zWKOIjzSo7OaxmHvJCyoZLSPc2SO2cdLF3Rkk9oHHmemnHW
 68RF6tgeSJWTimrcMeOWqGAAgU4ldnMGTRaqzLgEF8O3kEwGo1l7QOsnx6SDsDnxZ3GkNUCw7H
 jK7ZfyuA6xWAjRZWmrpdnqwQCFe8cppyR61hFmj5ZQmEzH0TJNwsE1D92FtHLDNP6sIVlkVbr0
 tXISleWZAsxAzQcWCVvipWQM0xnhxeorVk2TP0aZVLNgurit+zE8jOusLgix9lPVCRKDs8AYhv
 7es=
X-IronPort-AV: E=Sophos;i="5.64,494,1559491200"; 
   d="scan'208";a="224809303"
Received: from mail-by2nam03lp2057.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.57])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2019 04:43:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acbDPlbYj9QHE9UBaKCvp02p6pCwkPIJg0XUfMtd5c20YozeEvf3c8M50oWRQAVGRdpvRvi42wVzG/x2cXLpSMt+8R/YXLqZA1P3eqFNba061irj5JXErQc233gggdK0Akg+Bkq8Prah2RxB4spRXof67cTjbim95yKQEw3hMaGPC/3bDejRODHtPGBvNR17jBgJCvDA996RShh5nqRKU6tf5Kq1sjt2n/Gw/i5yiuoaTLFmeX66m++CJ8VE05PIf6BfNhqZB6PTAoLAChaebPxRwr8MQmOXdD3qPtZdjPajUH8rgl6Cu/25fET51mApMp/FM7I1D65Wz7PKz/35ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBtcndzfkSb/KYs35qzvbNK+QXgxtBFtTvmlp5j+USQ=;
 b=lWmZ+vQvA0NEkbwbMzy3LhFEUBSFTU+KRZRVGUznSWD5Tk6+97x1lo1xvNmFeY2jATfR7sbCXZ6SwAwlbJM8wJct4I7nqHsrdKzs/hy0iTx7vxh6CHONJSX6BAafEb86rYXQzwCITzhYvN+n/NUshThev8BtLptsMg2BJVkxz8V3hhsCDdPB9oBAU1TWE8upln7B0zTQOW60mcZ/HRNiyCb+yuxHBHMAH/CUUomIlpGOmd+netxgJdilbQTEhoVVEzu+ypHpAi7DUXfE/CHV9RRmbQCQ5fVataI9CujfSOqW3Jr/ZpnVtaP9ftGdZ9hfAiqxxWIOygB+hmbb7tovaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBtcndzfkSb/KYs35qzvbNK+QXgxtBFtTvmlp5j+USQ=;
 b=P/PVExw/SBPPjjh4FaiEnE7aUwtZpZCkQqmt+n9ODdK3uZtm0kFybf/ELalnKkOoPvWuVbuDGaUKHQjMjD7eMGBBrLmO4/OlKq/3X3Xi3ThjaBfe3Rg8bwzFWtbiJTtK6DizWOtQHFbz5Vhq4SfMkN4Dcr5o1/YrLFzh6iXeEYg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5895.namprd04.prod.outlook.com (20.179.59.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Wed, 11 Sep 2019 20:43:17 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.016; Wed, 11 Sep 2019
 20:43:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@osandov.com" <osandov@osandov.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH V3 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Thread-Topic: [PATCH V3 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Thread-Index: AQHVaH568r42hmDZu0+VDaUwCREbgg==
Date:   Wed, 11 Sep 2019 20:43:17 +0000
Message-ID: <BYAPR04MB5749D84FB97EAA8BF654A9F186B10@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190911085343.32355-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dadd3b4-f770-4993-11c6-08d736f8acd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5895;
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR04MB58955FF427F2CF4D21E84F8E86B10@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(478600001)(6246003)(25786009)(6436002)(8676002)(5660300002)(55016002)(4744005)(81166006)(81156014)(53936002)(2906002)(9686003)(6116002)(3846002)(229853002)(33656002)(316002)(4326008)(6306002)(110136005)(256004)(7696005)(446003)(86362001)(102836004)(476003)(53546011)(6506007)(26005)(186003)(76176011)(71190400001)(71200400001)(99286004)(8936002)(54906003)(486006)(52536014)(66946007)(74316002)(66476007)(66556008)(66446008)(64756008)(966005)(2501003)(66066001)(305945005)(7736002)(14454004)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5895;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tqjburBVatmIz0HYK6ticZs7Ztd8kelPVaW5hJ0pSEQKIITtUEZ0Bbnt2PV4QulEPdPYxqdzvVNt8wtFMrJPEiQPNT7P8M5YvN3I/o1GaFgVrbD9iBjpQe8l9u1VpxK/tYnINRA5oQAu4RE3OLTxzFxoiWfm2ebRz34fVQt+pkhN0eOxD3oqvdVZGgnPzzexiGlR7ohAuUsgrSfHl78n6olnbKoVEJBMX/W5vYJ4mr2k5Inuwakb4gA7NYzAN3TfJPEUAzhl5sHVicMXGwtE1IFo0n7/DCGrqVMCjjh0m5YcrnEd66K3rFcI+CigOeyeNjrx70ooV1KhApBxroLNMXTpAwIMRAV9ez1YBZqvvrpLxA+VNI5TYO3HzZHQbC2cCU8crU0epNClAZtIXGK+uNkOZlK2hUUKaiLTw3d1hJE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dadd3b4-f770-4993-11c6-08d736f8acd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 20:43:17.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZrye0r+BjwnKc1EQShzVda8MjbdB6jMcyydcqu8zvhWx3JO+9UWLONkg0fJ7Ew5P1GhCOXg9xSleYsYvocbHvb0A2SkSHaU8heMh3ZCauM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/11/2019 01:54 AM, Yi Zhang wrote:=0A=
> Add one test to cover NVMe SSD rescan/reset/remove operation during=0A=
> IO, the steps found several issues during my previous testing, check=0A=
> them here:=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html=
=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html=0A=
>=0A=
> Signed-off-by: Yi Zhang<yi.zhang@redhat.com>=0A=
>=0A=
> ---=0A=
>=0A=
> changes from v2:=0A=
>   - add check_sysfs function for rescan/reset/remove operation=0A=
>   - declare all local variables at the start=0A=
>   - alignment fix=0A=
>   - add udevadm settle=0A=
>   - change to QUICK=3D1=0A=
> changes from v1:=0A=
>   - add variable for "/sys/bus/pci/devices/${pdev}"=0A=
>   - add kill $!; wait; for background fio=0A=
>   - add rescan/reset/remove sysfs node check=0A=
>   - add loop checking for nvme reinitialized=0A=
>=0A=
> ---=0A=
=0A=
