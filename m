Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5EC4320A
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 23:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768C16101D
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 23:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhHKXbT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:31:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:59548 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhHKXbS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 19:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628724653; x=1660260653;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aWYNfFXMxEpZxqtY0zOVyKtJ8FuPVgDpP5eCpZTyvbk=;
  b=e26wbq1yZhbt6onj1ke6ENTFI6ZkNebS4iMu+0DJfmNhajjETY7a2c+Q
   r48tCjWSWRBjY6+dVSwLtHTCeZNl/OzXFEr/J3F6M6H9r8XHf3egz0AWd
   8cCg5nS5tqF5O/7kQ2Xg/ALXW5KFL88mHMWf/0eJ/An67DTiO/vH2DS1Y
   dY6tQ31D5oBYi6AExExxDQWgp5+s2tqB9R0yQW2bZ6vLkTo40LBrWpyWG
   UCtNZrgugzlfERKIav8ZLpmy2QRRd+CO01GV4YI8cdPQswQ2jM3E9GKRP
   laJfnz2ShQ03YfOIl3SbZW0Z9Erc6332/RwgDRzWX4zAGYKiTIQw4p3/r
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,314,1620662400"; 
   d="scan'208";a="176984833"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 07:30:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuHVQpHvcshOmjX5xVXHUE1u/ZG6i7VoGqtEDDegjQa9OZol6+hm/NDYqgLB0o6fH+9d+cD15R0LVVMcABGaYxNAyRCd2JrqQ7Hbk82ZhdZH7jcR/O5tqugycQzYZYnlwJhIFQ85BgZdrsNKrEPSLy2a8R6UsxE6w8j5pv+4JILbnyz81klDB/gAEDh3y//JLFwDY3EiwekJDkDJ01kCu53oucf8pc3z8dRjO7Zo/9w1uAOOv/88YlvrUax4o45v2ADCC/5QcV1pI1kk/W6HYtdrpy1GJrlsV9+rSINYr32vJj+CZX6g609oItwKX85A4/KN1LMpNk8b9jFSY5JUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF/ViLbO36Sb9zjxIAEC0mLFg21gyI9LrwBSImPFsXY=;
 b=Rlohi2zudo0tER0AwAOwAVY5KOTeCSCAuvkZz5VuZMT2PQAGmVFsaj26HbDtnQJsu9nrXAiAlApejdz01SK/DNtIf0SnMMpgTUuKVB5wgLurE2IK2jMUsR7ixDJE01K9v/H+xV7Xa65+7Zf8YlvHyUkRrUscSrCEENAEjZwSCoBdJOPSPa9uvqnrIysmAxdYplxXe1E5dPIQ4twow36eoiLdDqU6S6eFkTDpvyT+SmWY1i0KDzBr5lHIsdv5FWZY8jmlcjXHn+kAIa8KCfFZSoZaqLn446k1g3RcySVWNEa3JKoTmwszeQqkazXoWJROL9THXG2CJ2g+MFmRCwgNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF/ViLbO36Sb9zjxIAEC0mLFg21gyI9LrwBSImPFsXY=;
 b=HX2+McTSgDo+EJeg+kRcam8ZpnGSsL7Rr9cfK2J7i5/zMIc+rStd+Bdz9mkqK1AJGy0OTSO65j9IPU/bqqBzy7Gc+tSyyc3s+WlMyCZ+onb1qHEsjj///NTT8PR9c1ZgsC9xFQ02PURtNzZgQLLQt+6oRbi46brnlMFXH4oE1Ks=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5099.namprd04.prod.outlook.com (2603:10b6:5:12::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Wed, 11 Aug
 2021 23:30:52 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 23:30:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs
 sttribute
Thread-Topic: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs
 sttribute
Thread-Index: AQHXjauSkRE8AaYp90i6c3dBRPDZpA==
Date:   Wed, 11 Aug 2021 23:30:52 +0000
Message-ID: <DM6PR04MB7081ED4BA9C893B488C03FA2E7F89@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
 <20210810054939.30760-10-damien.lemoal@wdc.com> <YRQgA5a4Dal4H1sc@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27efc5db-c69f-4c0e-d074-08d95d200f50
x-ms-traffictypediagnostic: DM6PR04MB5099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5099CAD93D529E62A0724A3AE7F89@DM6PR04MB5099.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1KvCZQVnXuukdOC9rrZtSnRra1F5Eea/UF6BlK4lyG06uuTxa8t22TipFIQ9/RodFoXXb6upp/hTaG3VLAXSEeDESHLNqsz7hFPJAnpF3OZv0oObtlfKP1pOZwMdikk/n0woTZjJeaf02BGSlLEPUnpDU3+fndqE3TMaUU4cM/DCrR25BdurVZqEsSURlJ9Yr83Wo8xfYLmXGaB+4GIoo5CLkFMn0Z+ZKz/WBzkbQd7h1mVVhtqsgSMlyA33vGz4CB2Is9Ubh6dULW7lGi40kSxZdHi/TKRvHYD0PtjFR8JX9zY9KLeTsr+OfdBa8tajk+4MQq9d+Y64YwXgkcAohqI/TLk3CTtwPV58rWaXoC5ECXHlde34aN1BD5Z5CF9epJq/r8Uo8ARDi5w/2SV/4/3jkVWoeFMmDVu8dP0WNbE7sNpOtLA17lEVIOmjQZnVS2UVsWm0mh0GLBDx+zp7zs2FICZyQmcT+iYiquoCAzIXSu5vJAvX3/kmxT/jWvp9PU3Hz8FLeGLXhy76S4+atIB4q0SNVPAbjhBYvLD0uOMZKFk2E1nMTJXvPbWBzLRjfSDiHSLHTtFHgLsE0di5Z57bLQo8IaK2uhR15/hrPZ6OTagfp1/Be5wlGMyYsPDYfwjYW56xM1MkJGP9UCGOdnz1JVTSWKQ/U3Q9PqeWMcLRGC2F1D3zNKI+hadIZaldUoRhP+s3iWnEa/amTdrZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(83380400001)(76116006)(71200400001)(9686003)(186003)(91956017)(55016002)(4326008)(38070700005)(64756008)(66556008)(66476007)(66446008)(66946007)(86362001)(2906002)(38100700002)(54906003)(6862004)(7696005)(478600001)(8936002)(316002)(52536014)(8676002)(6636002)(33656002)(122000001)(53546011)(5660300002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TPlpfD6MB839wqFa71M6lTmeKWptTa4/B50NWumQ6tOiKfvRmzot2caCFzda?=
 =?us-ascii?Q?5LQulFE/mtAnKp5WgE1Suj2a9MHxNL9nBZp/2VJbKotWw2WQlDCLmVMhFPX5?=
 =?us-ascii?Q?zPsCnmBfyEmFlgvxx+l3d45I3TEfJOQFjf2uzTndHAzuJXJumAW0w2JxezVV?=
 =?us-ascii?Q?7W69tGrjs/gXYC6jJWMVNzqivdNb2ZlzhpInng6mbf0ErAMhA3C+KD7S75Sz?=
 =?us-ascii?Q?n37tYFJHXnTd7JFqY1nSXo4wGkVls8zfIq+OmsKyEDSbsniCeVB6HOpYo1jF?=
 =?us-ascii?Q?dYqkErjbOwqqPNHGaH2EPOJOicCmhoEk9Mc9dPn4HuY+vxl+cX8VP8vaZjY2?=
 =?us-ascii?Q?x4FsUljTNmKB1jUpcqC94jwOfdETp2664xwpwVUCG5G5mdV9PtKMXGNp9I6P?=
 =?us-ascii?Q?D0Rj9UzD3VrpHRG2mZYjPCc5yBzBSNwf3uPh/56FzZlUjNhTwf/1ic4GOtma?=
 =?us-ascii?Q?hdz2svE2a2TM4P+6mq8eGWtejdkG19HivT4n8qslpx0ZGS0gTegCuCyg33nU?=
 =?us-ascii?Q?4xoGbA1kb43NPSrVbgyI1FwURUOYkUhlY5R1lCaj5NTgLykiUmKdsN6/VojF?=
 =?us-ascii?Q?3xkkWzrUff0xFohak3LAXxfPnH9CIb8JEtXA+t9GgOg+eGBCIIttcAMn6D+Y?=
 =?us-ascii?Q?67EPzcRi0W/ymaAg9e73Qg8nOHVADOFw1nRJaL71FCaPgHgWMsPIcI0soF7y?=
 =?us-ascii?Q?rNGWrAZUPuYNZUPJsxWzKSUi/8rAN9CDYLsRNxL1z4taAPUNjTX/veJ/vI6l?=
 =?us-ascii?Q?65WjXY8Qxm2CxRZfSx6MTbyMhZLimQiPZfH6tuHq+NHJwzPsm64xZSCWVjqr?=
 =?us-ascii?Q?bRdH6kD+db2s+sH1YODxuXi1IKGo99YLi73suG/E2BNO6DfaNLHLLrawsLGp?=
 =?us-ascii?Q?Te7AnG0kw3xXWNc5BQUw+iRahI0H1r1+XzRmrT4xgO4rFci/Y12THZs+n/cj?=
 =?us-ascii?Q?S5RAPtXkhE8xYOZPvQ+oGRwY2BAq6GBF1yLNF0xeK9yyJEvrSoIM7IGXAlOo?=
 =?us-ascii?Q?He5zC+BPSo5bq/MLM6TF6uhAQIkGphVVmSa4Jk4+i5s9/Yumxob046DcaAwB?=
 =?us-ascii?Q?wey8fuXYdM6HXYn/zpF9eVFsndS+qhB/fXFru6mBiQ0IfqXbBEwVIkvrqoak?=
 =?us-ascii?Q?sUO4i9W3Ae61ytLn2oy3scBgyZU9ZTs4gIOQtYrqfxQohPlu4U8msP8zezQz?=
 =?us-ascii?Q?BiFCDLO21ca9rV50uv/WJ+Ao2RfW0/8jgNakr45eWg8yL6ilXxAYnzGqMoiD?=
 =?us-ascii?Q?wtypZjyxyfnqaCLNZzHVJ93MyckCWHvr62L3z3TzvreiItyJPrJkNSJgxzSW?=
 =?us-ascii?Q?nDtR5/7B5YOUQTk+Qj+8G3/6b6P/VhE7jzr6Q+4g2adbO0F0+JhBgk03Zj52?=
 =?us-ascii?Q?SVGCvWIluVZzNt+PfGE3cfPIQ3IPTdF8VkZy+L8c/bnOaTpfhg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27efc5db-c69f-4c0e-d074-08d95d200f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 23:30:52.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1UhMDwWahoiFHue0I+n99TF0OgKTjj5gR1mzs5Jjf5oQ5kkejt3k49WH9CVK6Qkpcwc6QLWO2CAYTeTWIuxkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5099
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/12 4:07, Niklas Cassel wrote:=0A=
> On Tue, Aug 10, 2021 at 02:49:39PM +0900, Damien Le Moal wrote:=0A=
>> Currently, the only way a user can determine if a SATA device supports=
=0A=
>> NCQ priority is to try to enable the use of this feature using the=0A=
>> ncq_prio_enable sysfs device attribute. If enabling the feature fails,=
=0A=
>> it is because the device does not support NCQ priority. Otherwise, the=
=0A=
>> feature is enabled and indicates that the device supports NCQ priority.=
=0A=
>>=0A=
>> Improve this odd interface by introducing the read-only=0A=
>> ncq_prio_supported sysfs device attribute to indicate if a SATA device=
=0A=
>> supports NCQ priority. The value of this attribute reflects if the=0A=
>> device flag ATA_DFLAG_NCQ_PRIO is set or cleared.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
>> ---=0A=
>>  drivers/ata/libahci.c     |  1 +=0A=
>>  drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++++=0A=
>>  include/linux/libata.h    |  1 +=0A=
>>  3 files changed, 26 insertions(+)=0A=
>>=0A=
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c=0A=
>> index fec2e9754aed..5b3fa2cbe722 100644=0A=
>> --- a/drivers/ata/libahci.c=0A=
>> +++ b/drivers/ata/libahci.c=0A=
>> @@ -125,6 +125,7 @@ EXPORT_SYMBOL_GPL(ahci_shost_attrs);=0A=
>>  struct device_attribute *ahci_sdev_attrs[] =3D {=0A=
>>  	&dev_attr_sw_activity,=0A=
>>  	&dev_attr_unload_heads,=0A=
>> +	&dev_attr_ncq_prio_supported,=0A=
> =0A=
> Hello Damien,=0A=
> =0A=
> I do not fully understand if NCQ is only supported for AHCI controllers,=
=0A=
> or if vanilla SATA controllers (without AHCI) can support it as well=0A=
> (since NCQ is part of the ATA Command Set - 5).=0A=
> =0A=
> However, I do think that you might have missed adding the=0A=
> dev_attr_ncq_prio_supported=0A=
> attribute for the ata_ncq_sdev_attrs struct in libata-sata.c=0A=
> =0A=
> (The ata_ncq_sdev_attrs struct already has the dev_attr_ncq_prio_enable=
=0A=
> attribute, so it makes sense that it should have the new supported=0A=
> attribute as well.)=0A=
=0A=
Good catch. I indeed forgot that one. Will add it.=0A=
=0A=
> =0A=
> =0A=
> Kind regards,=0A=
> Niklas=0A=
> =0A=
>>  	&dev_attr_ncq_prio_enable,=0A=
>>  	NULL=0A=
>>  };=0A=
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c=0A=
>> index dc397ebda089..5566fd4bb38f 100644=0A=
>> --- a/drivers/ata/libata-sata.c=0A=
>> +++ b/drivers/ata/libata-sata.c=0A=
>> @@ -834,6 +834,30 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO |=
 S_IWUSR,=0A=
>>  	    ata_scsi_lpm_show, ata_scsi_lpm_store);=0A=
>>  EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);=0A=
>>  =0A=
>> +static ssize_t ata_ncq_prio_supported_show(struct device *device,=0A=
>> +					   struct device_attribute *attr,=0A=
>> +					   char *buf)=0A=
>> +{=0A=
>> +	struct scsi_device *sdev =3D to_scsi_device(device);=0A=
>> +	struct ata_port *ap =3D ata_shost_to_port(sdev->host);=0A=
>> +	struct ata_device *dev;=0A=
>> +	bool ncq_prio_supported;=0A=
>> +	int rc =3D 0;=0A=
>> +=0A=
>> +	spin_lock_irq(ap->lock);=0A=
>> +	dev =3D ata_scsi_find_dev(ap, sdev);=0A=
>> +	if (!dev)=0A=
>> +		rc =3D -ENODEV;=0A=
>> +	else=0A=
>> +		ncq_prio_supported =3D dev->flags & ATA_DFLAG_NCQ_PRIO;=0A=
>> +	spin_unlock_irq(ap->lock);=0A=
>> +=0A=
>> +	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);=0A=
>> +}=0A=
>> +=0A=
>> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, N=
ULL);=0A=
>> +EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);=0A=
>> +=0A=
>>  static ssize_t ata_ncq_prio_enable_show(struct device *device,=0A=
>>  					struct device_attribute *attr,=0A=
>>  					char *buf)=0A=
>> diff --git a/include/linux/libata.h b/include/linux/libata.h=0A=
>> index b23f28cfc8e0..a2d1bae7900b 100644=0A=
>> --- a/include/linux/libata.h=0A=
>> +++ b/include/linux/libata.h=0A=
>> @@ -539,6 +539,7 @@ typedef void (*ata_postreset_fn_t)(struct ata_link *=
link, unsigned int *classes)=0A=
>>  extern struct device_attribute dev_attr_unload_heads;=0A=
>>  #ifdef CONFIG_SATA_HOST=0A=
>>  extern struct device_attribute dev_attr_link_power_management_policy;=
=0A=
>> +extern struct device_attribute dev_attr_ncq_prio_supported;=0A=
>>  extern struct device_attribute dev_attr_ncq_prio_enable;=0A=
>>  extern struct device_attribute dev_attr_em_message_type;=0A=
>>  extern struct device_attribute dev_attr_em_message;=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
