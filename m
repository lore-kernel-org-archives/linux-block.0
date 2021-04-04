Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5CC433ED
	for <linux-block@archiver.kernel.org>; Sun,  4 Apr 2021 23:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B1611CE
	for <linux-block@archiver.kernel.org>; Sun,  4 Apr 2021 23:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhDDXjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Apr 2021 19:39:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27921 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhDDXiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Apr 2021 19:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617579530; x=1649115530;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H6Ork/jg1EUAXip5/Ej64GfAcAMH2egxFn/wcUWb5Y0=;
  b=pxCdDwL+OJvf+YjXVSxfOhRoduTFHEr1PG3EOwyY/YyplWIBuoWaknfC
   iHmm6bMdaXjeqDggdBsufGCuP7hSIFN8Yd4uUTYf19wB/V/cGBcETVgYc
   ywjqR6aKSiQNVQ+oZVEf0zBGO+EYO2M0crRYLevYKpP60dpJ2AcaZ5rAb
   Gr4e9bvtIFehNoOlXLjBM1BLFONvDVFRTqSW7NL5hg3OUQdITYWjBwcUm
   P/UidU8eE47GX4zPMVPS+Q6MPxNRwIXfI3byjpIeroznfOay2cfuQrK76
   Fp/3qg87KrWK5O9mx9JMZC3Udn4lp76Otd7vGGl6S6QYMqaE0tsqQSjqB
   A==;
IronPort-SDR: 69gUSLWox670yKVNnJ1K1MVyA56GrA7eHjEBrHSsRLInSA25V04OGaGBmyW5xOQDcPa9/s5EZE
 9wZg04/5YX78U5sHY62PXRcuFjyCxaRCdKqGV66gai3A4fwbX4lXiG8b4709rnDFsN+cjmn0u8
 oAF9v3xNrfNONPZXazRcYPli8dJpQVKWDt3W4HthcxObRgCtooi2i9p6cE1VG3NSfGaVhvbNng
 7eCSuh1EUOgdMFFMflWO5H15vlA+H/jwd+CccL9ke72nwQLsH29kXh+cM1v/PBtcSDaDgBmpdK
 Jwk=
X-IronPort-AV: E=Sophos;i="5.81,305,1610380800"; 
   d="scan'208";a="164802876"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2021 07:38:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iluVTKU/r2bJllmlWlD7j3CfLh1j4EKDqyozMbbMJUMdtXf6djvut7PCQRpJIhGjq2lbU5gP65P95SL3C1SpdOEEhvgAKPPYQr1wvbqwYJsEU3+Ms/r6UZmxAnGDfjUnXPiH8SUhNd3roh+LRI/qOlhmfExj6LKZg5+GDOjmDzDaX2D+QD5CkBZx5mTwMa63NkCaLFDXi+XxDCafNw1Ip+bTtUAT+jU100b65CebS81m07nfoivkT3qrZGChJDDH1VUBdPCnT/BmH7sGYW4OMlt9cz4OqnBkPqpYHaJqC0IxabBIJwPB6wXBz/DIuIxtS1/IT+t9kJeD1eiCETiDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=586vxE+YaetP/CLQEjloxMudyqtsTXBZbdEjB/DeJLI=;
 b=ZOZ0YpZIdFWloV6h2oVp48lI0axO9iwRGnhUZZDVaCLHPI0vln7TArb7CzOBvTns4aW2DnOxoI+uyv4MCZeFuQbGaO4qjY7TdMu9XZBvR72snFZNY+x5lg41asWaW9Ez/v1I5MnKAJylafqhdW0I1T2CvC9RxJLEbqy5fhlOBefGGPibboKM2ujeQ3MeD4+GC1UOrzX0CHBHVtfRabkg1XFdHk4TPj0usvYCnxdSpazWz7+LsEoqyOkaLKM/UtACSUZXNedSEaSFeWipOk78bp4q3TOFgU0p759rP0yAkJ9IhLxnO4yGGA9X1k9vH0Nwgj9LXWNqTCfyRcDXyYROXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=586vxE+YaetP/CLQEjloxMudyqtsTXBZbdEjB/DeJLI=;
 b=vlNvlqzcGQbC8CaxYmqeia+msBWDDuRRnax7FzHwZSBdEXWpFArsqD5e8bC06oXmdqlcwarpNkq2eNmHowowSnWlQYQdpKuGwexWOK7zk0rFWWTOLfPnMk2XGntZTe6lYeFeiK70mZtcVekds7a3uBy3sDMJu3OEzLaSW18RWYA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6349.namprd04.prod.outlook.com (2603:10b6:208:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Sun, 4 Apr
 2021 23:38:36 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 23:38:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: update a few comments in uapi/linux/blkpg.h
Thread-Topic: [PATCH] block: update a few comments in uapi/linux/blkpg.h
Thread-Index: AQHXJ+QQ7p3l6vADA0K3XMEtoRJJ9Q==
Date:   Sun, 4 Apr 2021 23:38:36 +0000
Message-ID: <BL0PR04MB651481B6F7B9C1280530B359E7789@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210402171731.389733-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b95b:6452:cf2:6a2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebd195bb-e333-406d-5e18-08d8f7c2c49a
x-ms-traffictypediagnostic: MN2PR04MB6349:
x-microsoft-antispam-prvs: <MN2PR04MB6349066EA2B4D88F979BC141E7789@MN2PR04MB6349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W0fVhApFLoS0rzOT4XGv0SwQvnSibvnlS66nuKFJMznpyrdbeUUbG4COekhrQFHYDeBuDJVep4AqVMPgiQu6UiJeOSvmGHTIy1SZB+qdfuwL4a8tHEIkbJIlj7HBMzOnFhjGIDyZ/0qbGQ42jY+YzCQU5nYREGHQTni2e2fuFE/Lgzm1HD9gk3ErbiA8Rulx5YuSm7+85+0odfj3CRdISdnPjG3pCQqwyYU/G1b131NBTynreDNM7MvtH22cyuG4jpWWroGZMBfpcslnT5upwJEiNebnxeW2TnOoNFvVLcu8Mhq+QKzYPtlG7/ZHhD+OaQbLtzxYOzrrZOKgY5IpB7/aceu4uXvg9CRRWIrqNN7Mw7xkphXCqpPDE3poB3KIucDOds3WjohSBUyNKdbbO1fcpTOpjbVAlfHZYALCBCVpx3sYvwijm8zmh5xSYHg7ufaw9Rhj8HRGFfYzxRuO0f1vW788olhsrvKmZmBluIv+hG/WfUM1l6f/0NBZe2OBfu+orAetWphNRsAjkDOdwDsIh8U3T2nP6SBSE74miHcYTmrO+qfhh62KDJH1mu9lMoWjrKaXcsuc1GDS3Vd6u5sq699l8nBgXhkS/QHCNRh5pGCgyE5LPAwgZjFho1zpyRJAW4n7lc6sQuzsEigxDoYtbKA9mcAmNj9n6CUohfw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(7696005)(6506007)(53546011)(71200400001)(316002)(478600001)(66476007)(110136005)(15650500001)(55016002)(186003)(9686003)(83380400001)(38100700001)(66446008)(66556008)(64756008)(52536014)(5660300002)(86362001)(91956017)(76116006)(66946007)(8676002)(33656002)(8936002)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lZpA2Pr0tYf3cS3NHS5/phpnuObYeExmi4TnP+jsItKmpkcgEQHKXMewZxth?=
 =?us-ascii?Q?8FmidfulSEgCjIHlWEE/2Le3X/I3loAAX4udbh+Ld5mVDkoXJwCyGT8IcuCQ?=
 =?us-ascii?Q?/khdXUpNhwk0pIEjCREGbrjienq96scqjN4mYtldNaBwNIziXMwahbOEFPjL?=
 =?us-ascii?Q?iPpChcVm5HGfRSZEMNgVqFSaQ9n2NHpvLWn+qUuQFdbasG0k9dzlNp0EMRxx?=
 =?us-ascii?Q?a7OpVw0UpbpNLNAGkxPNfdnXRAb0ydpzPgLeHCfooVe3GWLI0QLxWEKZyQN6?=
 =?us-ascii?Q?TM8EqCEKnIPfucKYRTExW5nffT/asVa44qo0rVi15uoaZVt6i2ZZyveGjdqh?=
 =?us-ascii?Q?o63yr+l5BqCzAuuPzh7xmDh52NnFgzKTKH4PX/Yrtse70yoZhxh0/WT0+8FV?=
 =?us-ascii?Q?EFsDCNQXqIbHIUdn4/mHMkceSQ424NC+8EgFfEqqt/6vjuE6SQPk2Sj/6FQb?=
 =?us-ascii?Q?kAAemGR0crdCkOqEuif7bnf6LlcJtmiRR+tnzRtAVPyExQhGczrS2TKUmS4N?=
 =?us-ascii?Q?KY3V8NFolZV9I4P0W23wx5wzvjUg1G2QxLQskqbNHVi97FCsR6+yiQETxotJ?=
 =?us-ascii?Q?WmXfPRS358uK+O9jSIBcIxsYN8YufG+o4v8Os2KXhqxYY+vLkn64ktO/NHUq?=
 =?us-ascii?Q?bNX5KDDPNIhUk5zdur/EY2mCEivLRwqJAt1AQFufZOD3vT3+XBP4rS8399NT?=
 =?us-ascii?Q?oCElM9uB0esRMyQo8N1kcoOZjeUOsZ0Hk+ENrSCTWC1ppqHjYivMF9cHH3Xs?=
 =?us-ascii?Q?4HIT/xU3hehI3Vg80H3BI85mrM9feXj0mrG1bsBZReG7EO8hD0Ipwfo3kLkE?=
 =?us-ascii?Q?VyewBUH6GtWaYvGcLhSTuW49anuMfJX3QmbuI/uwYwRxO5nx3UTgdw2yoULB?=
 =?us-ascii?Q?oZo6Kw2lLzYeOv8kz35G7Lg5dFNKAFpZlErOc9OOuI4cWSNp6GS1PDiwmYG5?=
 =?us-ascii?Q?d5MqOg4Wb5gPDhO/4N6kI7D3VNXTxS4TJPqYSAsRZuit72irO5RFhVizyHRs?=
 =?us-ascii?Q?pG8G43XtqMmIO1XodTY0IiuGAp9ElmS67Rv8mFz3l6gMCDyEYBMAlmQii5pL?=
 =?us-ascii?Q?xfjTFD7K5ksb3qwTiFK0jAwmUMyQa7fNcJWf2KHFmYqRdgEffhy70t+I9Rxh?=
 =?us-ascii?Q?wrUHp3GMZH3n/grX4+ZOGPEn/n1twSB16lrwdtafXabUv/XOswPf+aof09vg?=
 =?us-ascii?Q?y0k2E/fKlqmjrvKKHJtIbjDUra5zNdP1XZxgqs5UHfajfTsJrT9SMv2CEGqT?=
 =?us-ascii?Q?gZGGr4BvlG8tDTaq3VNmIJdAASXZux+keVk9FDn4zWSVrBXJDa2c3CmzbfJk?=
 =?us-ascii?Q?xa+A/3aF/BkudgxQH54TwtZRR0CuOa3ZK1P4pnIC+hZ9Uru8Eskk07UGLlLE?=
 =?us-ascii?Q?P95/bBnlct+8mDywaEMrLZg7vTcG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd195bb-e333-406d-5e18-08d8f7c2c49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2021 23:38:36.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqgtBy0syHcEoPpdNmq0aB3u47HqWyA9IJwKx05j2KHMIj2hH2maBMhEni10GbSkrwLhHYlclBjBQx4A8/Y3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/03 2:19, Christoph Hellwig wrote:=0A=
> The big top of the file comment talk about grand plans that never=0A=
> happened, so remove them to not confuse the readers.  Also mark the=0A=
> devname and volname fields as ignored as they were never used by the=0A=
> kernel.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  include/uapi/linux/blkpg.h | 28 ++--------------------------=0A=
>  1 file changed, 2 insertions(+), 26 deletions(-)=0A=
> =0A=
> diff --git a/include/uapi/linux/blkpg.h b/include/uapi/linux/blkpg.h=0A=
> index ac6474e4f29d5a..d0a64ee97c6df0 100644=0A=
> --- a/include/uapi/linux/blkpg.h=0A=
> +++ b/include/uapi/linux/blkpg.h=0A=
> @@ -2,29 +2,6 @@=0A=
>  #ifndef _UAPI__LINUX_BLKPG_H=0A=
>  #define _UAPI__LINUX_BLKPG_H=0A=
>  =0A=
> -/*=0A=
> - * Partition table and disk geometry handling=0A=
> - *=0A=
> - * A single ioctl with lots of subfunctions:=0A=
> - *=0A=
> - * Device number stuff:=0A=
> - *    get_whole_disk()		(given the device number of a partition,=0A=
> - *                               find the device number of the encompass=
ing disk)=0A=
> - *    get_all_partitions()	(given the device number of a disk, return th=
e=0A=
> - *				 device numbers of all its known partitions)=0A=
> - *=0A=
> - * Partition stuff:=0A=
> - *    add_partition()=0A=
> - *    delete_partition()=0A=
> - *    test_partition_in_use()	(also for test_disk_in_use)=0A=
> - *=0A=
> - * Geometry stuff:=0A=
> - *    get_geometry()=0A=
> - *    set_geometry()=0A=
> - *    get_bios_drivedata()=0A=
> - *=0A=
> - * For today, only the partition stuff - aeb, 990515=0A=
> - */=0A=
>  #include <linux/compiler.h>=0A=
>  #include <linux/ioctl.h>=0A=
>  =0A=
> @@ -52,9 +29,8 @@ struct blkpg_partition {=0A=
>  	long long start;		/* starting offset in bytes */=0A=
>  	long long length;		/* length in bytes */=0A=
>  	int pno;			/* partition number */=0A=
> -	char devname[BLKPG_DEVNAMELTH];	/* partition name, like sda5 or c0d1p2,=
=0A=
> -					   to be used in kernel messages */=0A=
> -	char volname[BLKPG_VOLNAMELTH];	/* volume label */=0A=
> +	char devname[BLKPG_DEVNAMELTH];	/* unused / ignored */=0A=
> +	char volname[BLKPG_VOLNAMELTH];	/* unused / ignore */=0A=
=0A=
Nit: to be consistent with the line above: s/ignore/ignored=0A=
=0A=
>  };=0A=
>  =0A=
>  #endif /* _UAPI__LINUX_BLKPG_H */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
