Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC97DC432BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD10F6105A
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhHKTIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:08:15 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14669 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKTIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628708871; x=1660244871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0zI/4nWMM9Mz3N7FPCFa8VtjvIwW8MA4F5Q/GFW9Jm4=;
  b=LKOekdBbA74sqUOeC51dIVKEdLToFRlo2qIXSQtXxxG0KnTXCNBaLJsI
   BGnTpAoLLOkOt1hwbOAXO5NEYoxOR3RYZSbaTqJXDfWzqxvwA+LtmRc/k
   VFhKDIeaIjWkdv5O+LsMNuUdg+NpZrO/9iorn1rzXW77lRkbeSFPdQR/N
   uJia8h9KGhPMmbMDlHvE69fx+wFal7H2MFWhKUQ6cuWwFxP66Rk8uTIJ8
   ERWYQJsVpjT5C27nviW8y3GkBBBXhZSvfvZFYabnni5EJpkFRoE0F9Cb8
   C2kpq51WkHt+YzFDZzzmcu5ZIw6SwTmwCkglmG8aiBclW5yHvW7VrgZ7d
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="181766501"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 03:07:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQAJleTckjIL/jxYl9gIduroysyElK+MG4fkyNiLYEaoFz/fiLetSxYu7zHXqCHUi+uvNiU0IGwNrNCijajeqafEzmINZPNijP9D0/7wheMuOb+W/YyiaGIqWXQZh9bRdOi591XNEz2ndP/+C5UsyqZ2cdZDIFDkjTK+6qWZut6VtFOfO7MVlS+YFt4dI6efN1zc98ji5OvyuHnegPG5yl0p72TrkED9Tz8hQ5E2wGpUydOgRFYWFtzwqzbwlyR4vR9G5AyU0AaZFYkKdBFB31TjUTCAct+ZZFMhANTcqdd555eY6FLZnhVVX0CtDliJJ5N6h/yOxTCW9KAcuJ2leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x29130GobRtU5VAOOHvCWH4gymIcbunSKMZ/Y35f4Xs=;
 b=NnJ+r9mzeolFVUSEhraqhYC696Hk3TjloBZCuFAoNAPVkYPjnhZ+1BWpIQBoO3KXcXgTYkVVFb/71osCYyAYhNf3Otrex5F71UQBro3IsgYjAaOq2rn2MPUmDO1VfYTOLWi4LShKGcIag35/+cdh9HS32sfmYDEZKNpfPRxy/zIWlO2zWs955SBLe5LaDcMtNGAqqRVvrY5TaLmzJY90uCzNtDCZIDm4itIUhTJ8TEIHNrSNai3RkSOkvst5WL0x6P0pnxvFp8DeYLU/b5Wbyd3K8rFYqO6fVsUs1RKDx6P6jy9UHD6D/Hj0po6YQg3P49HNDyDt52E0w9weR6MOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x29130GobRtU5VAOOHvCWH4gymIcbunSKMZ/Y35f4Xs=;
 b=TkZpt84yIzGyVbVGa70uxIppkMXDEbt9iZkRsbj1jBuWJN30Ll7h7saT9ZXOcoDvYSHNNn8GYrpdyV4gI0P5WBAFVKcBCB3Ba9rpGD1xgqm3DEZaUZBoBIbKb97V4zaOgiHdN2aksluKoH0T88JHC5ij+kHjJt+yRKI5FxcjJhs=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7384.namprd04.prod.outlook.com (2603:10b6:510:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 19:07:49 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%9]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 19:07:49 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs
 sttribute
Thread-Topic: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs
 sttribute
Thread-Index: AQHXjuQt1D2SfZ3X8EyhuIM7/ZmjnA==
Date:   Wed, 11 Aug 2021 19:07:49 +0000
Message-ID: <YRQgA5a4Dal4H1sc@x1-carbon>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
 <20210810054939.30760-10-damien.lemoal@wdc.com>
In-Reply-To: <20210810054939.30760-10-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c3982b3-933c-4d0e-3512-08d95cfb4fd3
x-ms-traffictypediagnostic: PH0PR04MB7384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7384E33F3AA1E41B897FC8C9F2F89@PH0PR04MB7384.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPS3HFh4QfBrzzAyHpEuc0QIUTZlGqOpSlHV2hqpiyFwu8lgCcvMiocSMsV/KJXTEP9BuGdvgiinWHjQcBBjks8bGm5FWx1P+SsVrW8Xz74i/6J43g0Ot1XU7/CBoiPVALKx3KJ6ktTDi7mDJ2yoGqKuG4+SmMjtc0CYDTOK3ZxOoML0IhvLYagV/iGiJI0ml6Fih/4Oak+yEbe5NLxpEW+jVwLxP1/BgM6bn6PSG8T9HdGrht5QogYLZESmRMVU9Pkx8kqOKV35IdfafjNka9vS2nYm11iavVUfU2QO7NmW7o2OYePOBIoWI0f5789sXpoJWP32SOGaUWghd6RWkyKAuxPdnEXQwYhJ++3N5BwyshVGI4dve/RVuVFkeridV/IICnsEl1gn9O4SQyi35CGiBATc0RsrjWJ1czE5LqtnxpLQlv/27jysjgARvS1RcKsypH/tkqNi0Ox3mskaWJ0seBhYWQPSesIcsMWIA9ARg9VQikPZxQacdt9XzFgP3223stHB0nyjoJE4MsfI1ca4AZEEDhIjUQ1H/yel3WgIFwH/+613mNBlnR1LCnkrmQ1MXuIL42cMqsnJ2VFI/qbtzTFE7RbqUSRGEDHYOjoPtnZpgHucq7dKRzSdPDVt0o4nVnYKi21U8KPdseOj/RS1TKgqdek1NHxZNwWiBXDhKNHkoEIet0lSxmALx6VDpEDHh5u/N5tUgzca/3WOvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(66476007)(83380400001)(66446008)(64756008)(186003)(66556008)(33716001)(54906003)(316002)(76116006)(6512007)(9686003)(8676002)(38070700005)(6862004)(66946007)(6486002)(91956017)(6636002)(8936002)(86362001)(38100700002)(2906002)(6506007)(4326008)(478600001)(71200400001)(26005)(5660300002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7q5ISMgQjLym9U81J6xtp4pe5dYArVckNcgb0wJfp7qfXzM/OuWOeKa478q3?=
 =?us-ascii?Q?7V56DMwAiydB0bB9/W//RrJdqmjEXh8KV/M+oPjOHghAww4cnGSs99LUNjU9?=
 =?us-ascii?Q?HFIcdeCFycmgxOUE6CuX7pXezu/lADaDHTJLdusctgym1SmGxNyS8gBerCHK?=
 =?us-ascii?Q?oVRjN4zBQYPmJ6kuG1E0okJXWb5psqt0nxjn2YUzFwhRhFHZNLCmiGUiUGRQ?=
 =?us-ascii?Q?VwMm/CJLSYE+ana/l+WK6mTIqn8Rwx2X+qmI5E6JTorT4pBNbMrIou7qcLhc?=
 =?us-ascii?Q?7Mj38t4Wo7nwbAE0A2Z6C0FIRcxTUunXUlzyHYHTdvOcdTdgxtaDJsk6tUzx?=
 =?us-ascii?Q?13c44KKDBZ7LwFMfMj24rf20Y1Z7kOnh8vlnkKy89JMGyljY7OLn4ygNHyf4?=
 =?us-ascii?Q?HCe0TRLCRUPyTIR/JyzJo2N3DbQa5uozDGKhUjcBDNIO9Ss75K0t29N5RWZk?=
 =?us-ascii?Q?oYLUDrpEE3iOcCDZEe0XCDHHj8ZrAwEl+eJPZUVyuDN9hnWTZ2NeSC597hCo?=
 =?us-ascii?Q?8cJ91f0Cqugo0qOASXL9R+Z54KiBnSiPMC7+fdZF+qzYoDsBl3EJ2gUbZVb7?=
 =?us-ascii?Q?ri4IM7VnUo/D6sK2PpBVYZ4Oe4E1sKddS02g5B7mhBHJy509shDQKJfV0asL?=
 =?us-ascii?Q?SNw9pWiOclMGss/i+3K1bNXBW36nNiE9AyQibuoTjIag4RacarRDJuTcQBuG?=
 =?us-ascii?Q?rmp3Ox5tim7LtfIhDi+R10i1kHPVedG+b32pw9bKtrKPtL8B/wOaDxZ+qB9v?=
 =?us-ascii?Q?s3XzkGwkpapHeUH2mWk2Cu2UAq+Z0sqrVIFjP5+1cF316jOqF4Vt+kwYdt07?=
 =?us-ascii?Q?dEoriiYxpXJtP/brclvTKtU/PbB5brJCG+eBdGsLnWUcX52YbUFmpv0OJZn1?=
 =?us-ascii?Q?uWLvjpYH5vj7M5Eakj37M+i/ZBsd4R5fJQq3ASf9UGCr0KLHSemXcajRR3xC?=
 =?us-ascii?Q?OQukaHcW+BRcNBX1rOl/7Yu+X3hfpPRsNW1jQJTAQj/3nYglKP7Bj93kqDWW?=
 =?us-ascii?Q?oZD6eYnEsfvA7f15bPAdTc2sq4/tZtKVFDnDG+Z8zQptDbZrc0JqaumUU61A?=
 =?us-ascii?Q?6gh75woOyRrxslcLrIYmC90aaCOaFCg7c/zxqaIIVgiRfhG2wiLWtdznhqcP?=
 =?us-ascii?Q?LOvNSUmeLAf777uWCOB7gMynd+qY4MV7Oy96eex8zZR5DsCKV/pZ0x+JMjhz?=
 =?us-ascii?Q?ISpV6EvedS2uIPXO70GUJdtDi8kJVAaYbGXDxCYiUgusfuCzUTEvpD0JGWK8?=
 =?us-ascii?Q?AzsrRdJQvF0E5jHJKDnABA+dTEZBDKJ4sO31PQt3v/jr227gYY0b1nOQe0Vc?=
 =?us-ascii?Q?rpSPaWfjoVlfzniB/ahGjGvjrpOOcGciHjAWypis9NzNVw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27A4889DB64314449F517D70AD0C78ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3982b3-933c-4d0e-3512-08d95cfb4fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 19:07:49.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75XqkHGLg1xbmOqQBgbjtUWIlH9vG2Z65P9G5mONzRKmIcS8gfS9ROOuD7VpPkNAsxpLGy0lH7Ez3QmSVstVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7384
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 10, 2021 at 02:49:39PM +0900, Damien Le Moal wrote:
> Currently, the only way a user can determine if a SATA device supports
> NCQ priority is to try to enable the use of this feature using the
> ncq_prio_enable sysfs device attribute. If enabling the feature fails,
> it is because the device does not support NCQ priority. Otherwise, the
> feature is enabled and indicates that the device supports NCQ priority.
>=20
> Improve this odd interface by introducing the read-only
> ncq_prio_supported sysfs device attribute to indicate if a SATA device
> supports NCQ priority. The value of this attribute reflects if the
> device flag ATA_DFLAG_NCQ_PRIO is set or cleared.
>=20
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libahci.c     |  1 +
>  drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++++
>  include/linux/libata.h    |  1 +
>  3 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index fec2e9754aed..5b3fa2cbe722 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -125,6 +125,7 @@ EXPORT_SYMBOL_GPL(ahci_shost_attrs);
>  struct device_attribute *ahci_sdev_attrs[] =3D {
>  	&dev_attr_sw_activity,
>  	&dev_attr_unload_heads,
> +	&dev_attr_ncq_prio_supported,

Hello Damien,

I do not fully understand if NCQ is only supported for AHCI controllers,
or if vanilla SATA controllers (without AHCI) can support it as well
(since NCQ is part of the ATA Command Set - 5).

However, I do think that you might have missed adding the
dev_attr_ncq_prio_supported
attribute for the ata_ncq_sdev_attrs struct in libata-sata.c

(The ata_ncq_sdev_attrs struct already has the dev_attr_ncq_prio_enable
attribute, so it makes sense that it should have the new supported
attribute as well.)


Kind regards,
Niklas

>  	&dev_attr_ncq_prio_enable,
>  	NULL
>  };
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index dc397ebda089..5566fd4bb38f 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -834,6 +834,30 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | =
S_IWUSR,
>  	    ata_scsi_lpm_show, ata_scsi_lpm_store);
>  EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
> =20
> +static ssize_t ata_ncq_prio_supported_show(struct device *device,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct scsi_device *sdev =3D to_scsi_device(device);
> +	struct ata_port *ap =3D ata_shost_to_port(sdev->host);
> +	struct ata_device *dev;
> +	bool ncq_prio_supported;
> +	int rc =3D 0;
> +
> +	spin_lock_irq(ap->lock);
> +	dev =3D ata_scsi_find_dev(ap, sdev);
> +	if (!dev)
> +		rc =3D -ENODEV;
> +	else
> +		ncq_prio_supported =3D dev->flags & ATA_DFLAG_NCQ_PRIO;
> +	spin_unlock_irq(ap->lock);
> +
> +	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
> +}
> +
> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NU=
LL);
> +EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
> +
>  static ssize_t ata_ncq_prio_enable_show(struct device *device,
>  					struct device_attribute *attr,
>  					char *buf)
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index b23f28cfc8e0..a2d1bae7900b 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -539,6 +539,7 @@ typedef void (*ata_postreset_fn_t)(struct ata_link *l=
ink, unsigned int *classes)
>  extern struct device_attribute dev_attr_unload_heads;
>  #ifdef CONFIG_SATA_HOST
>  extern struct device_attribute dev_attr_link_power_management_policy;
> +extern struct device_attribute dev_attr_ncq_prio_supported;
>  extern struct device_attribute dev_attr_ncq_prio_enable;
>  extern struct device_attribute dev_attr_em_message_type;
>  extern struct device_attribute dev_attr_em_message;=
