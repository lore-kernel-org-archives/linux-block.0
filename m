Return-Path: <SRS0=TFq0=EF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B002C4363A
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B200E22227
	for <linux-block@archiver.kernel.org>; Fri, 30 Oct 2020 14:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="nqTpb1gl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X4G7n9Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgJ3Obw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:31:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14041 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3Obv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Oct 2020 10:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604069445; x=1635605445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UAM3jqTRPDIpW5Pjygd6etGotgRf6CmBQTq7czVWsr8=;
  b=nqTpb1glo8bsps3QaItpHmq6CRVahWZRiXcDZvv+2DR64L3ZfFxHH3bu
   rxZMUY6OkGy9CufoPgiMnTr6isLwbVwJaHBHJpYAU0bdET0gMnxf+U7Df
   HbQlslqFk3CmRUrx4GBH8QCGdMu76QcYC1Q204F+mJwVkl3YcHJcb4ctB
   dVSXiR45eObyvGl2e6x6C4uFo/LiK1pvdEgeyPXfwj7IMP7iDkifbppk4
   B9X0blf4BdHN8Jy0hqQ4j9Ac7/N/3+rlM9MB90e0/hkfYPsz22gCtpWOs
   4gRho7yKp7BMdYkwa+c89qzOdTOOSGndzNp8M0xuMpGVGZtZE2gkINfch
   w==;
IronPort-SDR: RrgnNUIU87HymBfXbprOSNzYLJid1RHVNhqeE6NFFyf8t3Rm7D2EmWpoYcspNVb8EADhsR68CR
 4Rf6ZXCjB7HhXvoTB9/EVl9bigYyw/Z+BcDk5SVuGn8feWsV+TkXEXn5rspHAAz6EHE8lDqI1V
 ssjmspoAvLcGsYMgsqfZGEfsRWrI1WUMCusTZ13Gzsy4C1gIXfW0xHdtO9GMcRexNgWaJyI66v
 alzZfElRJ0SM3UH/s8EstfuUmICcdWNFjlORnefOi+DiRzjBafwiV6zZeSZXjjriqBwYHsilgZ
 dZ4=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="254902646"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 22:50:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwuBDRKB1SAUEsT2XFa64u3utD69jqFxo59mcOMy6f4EoeDD59VcXi40KuAsIeCqONfBnXqCwxstVlseyh0w6sr8YfBGm2YD+9iII41IRQhvJl0OarfpPfx3cu2Krx9Cvuc6xKYmxhph3uNJM5d/fFWOzm1ujS3S0ySQGWxt2mp7YMqbl0yQ75yFvAvoEJqprZw+b+xir0N9gzVMyw2e9oxwz173PR/uHTHHsyLhXTWLL87VYcnqvmTADM0VvFr7S5PePhq7aU8h/s+3WDrrVMjxtV3mICWDbdyqi0tbFBDHveZt1gAu1fjjkj4ds2Ct8epUkh6qevO2TrJuTGI1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noHG76TJZIoXLRv+pz8f3kAZ8KougUCW54hTSFvCA9g=;
 b=BxNkoh8WwsoyVBC/SgZluYVULiE6f3bvE0/irwaJL5bBdWrEfkuy6u9lhGoyUm3dpivdqIeI0SLbPxK7cclPTzzPTHy81ugRutzzmfirUCm50cwEcjBoY9OsaIPUGtrp8k0RYviA/aXDHNkk5+vAlhuJZNGJvpGHnJQoabL9USZMQ1SZ9Ki4cJTuXy3d5q8h5phI4GK5eB6pBFNOYoLpOFIi+W/Y89LbI2ZiOShZN0DKbMHSJcGyVV+2Whwje5pV13ndmeSA+iPYO+RUo/aPocpVllftW9eCbS6CreSdmwYCAU//GLPLKCiuSOwb7zBR+yGiAMIZmHbxhFoI2GWgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noHG76TJZIoXLRv+pz8f3kAZ8KougUCW54hTSFvCA9g=;
 b=X4G7n9LfGz5T7s3XoLzGSw6pe061cFN65xbqwDJJ3hJatLQZ2zV5NwnZBQbzQzNbkKVJNRJkSr78QtfsbfM7NiSzHYUnRfoNZhHYuqcSFvB6ooYfDJki0iiVOkj0YeNV3ipB8aBLmO6NOUY9fXn35MzzyJDsbaMrtnp5qOx/+0c=
Received: from BN8PR04MB5475.namprd04.prod.outlook.com (2603:10b6:408:50::28)
 by BN8PR04MB5954.namprd04.prod.outlook.com (2603:10b6:408:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 30 Oct
 2020 14:31:47 +0000
Received: from BN8PR04MB5475.namprd04.prod.outlook.com
 ([fe80::44a3:946f:57b0:9903]) by BN8PR04MB5475.namprd04.prod.outlook.com
 ([fe80::44a3:946f:57b0:9903%7]) with mapi id 15.20.3477.034; Fri, 30 Oct 2020
 14:31:47 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Thread-Topic: [PATCH] nvme: report capacity 0 for non supported ZNS SSDs
Thread-Index: AQHWrsllDye4hhD8gEKXDqYoAbLnLQ==
Date:   Fri, 30 Oct 2020 14:31:47 +0000
Message-ID: <20201030143146.GA105238@localhost.localdomain>
References: <20201029185753.14368-1-javier.gonz@samsung.com>
In-Reply-To: <20201029185753.14368-1-javier.gonz@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ade71ab-b738-404e-437c-08d87ce08861
x-ms-traffictypediagnostic: BN8PR04MB5954:
x-microsoft-antispam-prvs: <BN8PR04MB595462D3E13D5A0CA5D8CE28F2150@BN8PR04MB5954.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yhKyDEZPPixNE6o+/yoS86NXPppD5nvfzSLA9gE9eYrxXpqfbjDyAOUE0seL7U8Valm4mddDoG8v/hUrWrQXeF6M4Sd1pJynViMaPmNjI/P0jls9z/kNd4g+fzq+Gunb6BUcf2ha5UbNV30tRbkavRMNCuoBBZ75pML5jo/6rXELjhVgTDl1xIY1qtyZrPVldt6saUioPG4PgWt5hq/GiLHnaNi1EdkJ6suk8rLOs0BQPDvUwtwQ4mSnHVggnRWy6IhAdjPruzFPNLW1b0jowy9GCc6Ns9zlY1HrjfKZX166DwQg2dK5dCpv7ilt6TVy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR04MB5475.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(4326008)(186003)(8676002)(7416002)(9686003)(6512007)(2906002)(26005)(1076003)(6486002)(6506007)(6916009)(8936002)(316002)(478600001)(54906003)(86362001)(91956017)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(71200400001)(5660300002)(33656002)(66574015)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: O/iejgYR5udWNkXNhJRlEpVjomWDlpXj6LguHWZ5i4AMbsdWOh1ipOfg5S1qUQx70/aFXcf5nd0Or+PLIusG2opssRT4Hrd5h6Lb76gzEvfDxPG0gpTXB+Rq4iVcARNUzDaa0wb0YeBuKJZy91iw3WmJ/Iz+KOTpf+wCT21N+gA3r7y/dzfakPN/ga2C21PDX3yELWwkUKPHye/6UeNAO0FRFWJVykAMoAlwHYhHU8n6Em/gWgata9iFLTHY9//k++sEcadLms8p56rBKcC9JzUaCTymXK/2C5a52864rW1r/uoEIPsA9H4EVoxpjBfF1aGGfo5Z4IRstpQsMZJAgiu2AVG9iilVcyfHPFMDYhCVViim/Y5sRCJIVULLJ/ip8sDIMBU0ErM4G2jxDhcmXxGZmzsymPvp+CHzlyX6soneRFjir/MXRcZQo1l8j8+kYncVo+/HwPWicqp51JH+wxWgCNaUMEP54kBvQPzSN5AdQ/EE/47FOW2wI9dpya8WfIt7uyq8aiziumo1tj6orsxyyE4HHh6E37/e+3G3tIhPRmSSX32tUW31j/DnBDbhSFVunKJR7DaP4lNQ+gSA3xzC+LzqH7RjcQS64GP4Muct1n7dhiK4G4IjeEMGIcrWq+b6x42v95b8OZaEQqpoKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9F308E7B885E0341A0DCC5CA4A5205AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR04MB5475.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ade71ab-b738-404e-437c-08d87ce08861
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 14:31:47.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wun22ftV0KHyVIhh0atL16qvaiNFMy3AljzeVc0ipTiJ3xIquT42LLbR/HnRVbfHqQMTGX02b8u/kg+flRnaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5954
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 29, 2020 at 07:57:53PM +0100, Javier Gonz=E1lez wrote:
> Allow ZNS SSDs to be presented to the host even when they implement
> features that are not supported by the kernel zoned block device.
>=20
> Instead of rejecting the SSD at the NVMe driver level, deal with this in
> the block layer by setting capacity to 0, as we do with other things
> such as unsupported PI configurations. This allows to use standard
> management tools such as nvme-cli to choose a different format or
> firmware slot that is compatible with the Linux zoned block device.
>=20
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> ---
>  drivers/nvme/host/core.c |  5 +++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/zns.c  | 31 ++++++++++++++-----------------
>  3 files changed, 20 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c190c56bf702..9ca4f0a6ff2c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2026,6 +2026,11 @@ static void nvme_update_disk_info(struct gendisk *=
disk,
>  			capacity =3D 0;
>  	}

Hello Javier,

> =20
> +#ifdef CONFIG_BLK_DEV_ZONED

if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)

is preferred over ifdefs.

> +	if (!ns->zone_sup)
> +		capacity =3D 0;
> +#endif
> +
>  	set_capacity_revalidate_and_notify(disk, capacity, false);
> =20
>  	nvme_config_discard(disk, ns);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 87737fa32360..42cbe5bbc518 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -443,6 +443,7 @@ struct nvme_ns {
>  	u8 pi_type;
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	u64 zsze;
> +	bool zone_sup;

Perhaps a more descriptive name? zoned_ns_supp ?

>  #endif
>  	unsigned long features;
>  	unsigned long flags;
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 57cfd78731fb..77a7fed508ef 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -44,20 +44,23 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,
>  	struct nvme_id_ns_zns *id;
>  	int status;
> =20
> -	/* Driver requires zone append support */
> +	ns->zone_sup =3D true;

I don't think it is wise to assign it to true here.
E.g. if kzalloc() failes, if nvme_submit_sync_cmd() fails,
or if nvme_set_max_append() fails, you have already set this to true,
but zoc or power of 2 checks were never performed.


Perhaps something like this would be more robust:

@@ -53,18 +53,19 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned =
lbaf)
        struct nvme_command c =3D { };
        struct nvme_id_ns_zns *id;
        int status;
+       bool new_ns_supp =3D true;
+
+       /* default to NS not supported */
+       ns->zoned_ns_supp =3D false;

-       /* Driver requires zone append support */
        if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
                        NVME_CMD_EFFECTS_CSUPP)) {
                dev_warn(ns->ctrl->device,
                        "append not supported for zoned namespace:%d\n",
                        ns->head->ns_id);
-               return -EINVAL;
-       }
-
-       /* Lazily query controller append limit for the first zoned namespa=
ce */
-       if (!ns->ctrl->max_zone_append) {
+               new_ns_supp =3D false;
+       } else if (!ns->ctrl->max_zone_append) {
+               /* Lazily query controller append limit for the first zoned=
 namespace */
                status =3D nvme_set_max_append(ns->ctrl);
                if (status)
                        return status;
@@ -80,19 +81,16 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned =
lbaf)
        c.identify.csi =3D NVME_CSI_ZNS;

        status =3D nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*=
id));
-       if (status)
-               goto free_data;
+       if (status) {
+               kfree(id);
+               return status;
+       }

-       /*
-        * We currently do not handle devices requiring any of the zoned
-        * operation characteristics.
-        */
        if (id->zoc) {
                dev_warn(ns->ctrl->device,
                        "zone operations:%x not supported for namespace:%u\=
n",
                        le16_to_cpu(id->zoc), ns->head->ns_id);
-               status =3D -EINVAL;
-               goto free_data;
+               new_ns_supp =3D false;
        }

        ns->zsze =3D nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze)=
);
@@ -100,17 +98,14 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned=
 lbaf)
                dev_warn(ns->ctrl->device,
                        "invalid zone size:%llu for namespace:%u\n",
                        ns->zsze, ns->head->ns_id);
-               status =3D -EINVAL;
-               goto free_data;
+               new_ns_supp =3D false;
        }

+       ns->zoned_ns_supp =3D new_ns_supp;
        q->limits.zoned =3D BLK_ZONED_HM;
        blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
        blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
        blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
-free_data:
-       kfree(id);
-       return status;
 }

 static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,


Kind regards,
Niklas=
