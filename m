Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F99C432BE
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8106660F57
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 13:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbhHMN4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 09:56:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49276 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhHMN4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628862979; x=1660398979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LyaBAh7esC4Tg3pO0MUej3D8Tff9ZD0tQukP2Zdfh+g=;
  b=eOpaeXGa8q1p4ui4JCZPXKewetjKUnA9PQ0RdM4hqjTUMdbYDyEArCK/
   G2ozquNMMQvRoLITupKDh+iCN2uyHeGuT/4enGMy/3mjPL8YJlUcXqfAR
   cuPSGfKjJcpWecVCK0g9W3wj5CRCiDb+4+lxv2VOhti07M11xUfU9v7gh
   W0Vm3NOMhLzXV2RznQNj/nEaM7W/f2CTXp37wHGg531trvC+qTmrMUQoA
   HJm3QZbwkSt5agqXX9K1xJJiQCWJqMD9rVqDFLtGXgxrztRyNmr6KYQKe
   GBDeG5PmjMFVWKOwINCXT2LZCXb0Ao9pXGKPjgQBum8qGkUwtCV8H88T+
   w==;
X-IronPort-AV: E=Sophos;i="5.84,319,1620662400"; 
   d="scan'208";a="288734198"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2021 21:56:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0YIp/5dBgNJz3Vi8wPTkUvK9aeVDhV1tz1swBWDcyV2BsElKinlY8daeRDNNQXRZT/+xmP0qklizqOzjXyLlJm/alpneeQ5RdJp8xbu7qE8rrNnH+IVNafdqDR96PlJ+HEcm0zCel+SO7MukwvwoDCrPtH2tTe6dkHrD+Ql2XZ7MJZpmnwxjK9N7D6kmAhMDIk5g7fN4a0AzR6g3F5QCN7dAXEzUgGo5uA7nGocYOz4aPRillmdC/l5Wb+PPWf70Nq29yMHC3pmAIah2aLZhi/57Lc2xqSKYENbGlIqFMTrEQQ2YAgYVipfUnB/KTp5ljGzc5adiFtRlGttlK7GFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQMFy6abyY/lRtA0ZgXUuii8YZaRn1km5wbFtU5jOs0=;
 b=Ab6ph/KeRflkFDFTkPamVZL4HAURxVfnJf2cc/aBtWob5/P0I3NKw7yujxciYk0NhzfXMlQuCPkN9KVmn/rm/33cotS0zbhXVyy/MNRHJUOM2pku3K88nA/PXtDol7LU14bpIuUYQAtoHjSPWD4VJqr7meX1ZElG/StrB4xJMYVdWvuBBx9f7cIgfXtsjHi0mMwgVsC1cqb7KC5LVqDU25kAvTwJ6rjivisKUlFpNoB7t7+drIM13MgYsMJ7KdN72PabcE5ECQkE5MTQ3Qtos63bEfBDxACJqr119yGQAuqOoXroY9PRRttccJLtNJ6mjDivdlXonK3ROAPuHPpT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQMFy6abyY/lRtA0ZgXUuii8YZaRn1km5wbFtU5jOs0=;
 b=XX1NyllHkOzz/4W+1c9wEJG1CTR0dpOKJG+jM2UKBCLnHMd1kDVJ6wTAAgwUogSQMHu+LZOZ2M21CaOUim0ewX3rTKNbQn8ij8r+GDvU4kBPMCivsg2n8GDiADDLIxKXj+uF8Oh51x5W+P0GUauOmRWgSTu7mAyaYs072ii05jI=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7669.namprd04.prod.outlook.com (2603:10b6:510:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 13:56:14 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%9]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 13:56:14 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs
 sttribute
Thread-Topic: [PATCH v5 9/9] libahci: Introduce ncq_prio_supported sysfs
 sttribute
Thread-Index: AQHXjuQt1D2SfZ3X8EyhuIM7/ZmjnKtxeCoA
Date:   Fri, 13 Aug 2021 13:56:14 +0000
Message-ID: <YRZ5/NciS5gVqkdy@x1-carbon>
References: <20210810054939.30760-1-damien.lemoal@wdc.com>
 <20210810054939.30760-10-damien.lemoal@wdc.com> <YRQgA5a4Dal4H1sc@x1-carbon>
 <DM6PR04MB7081ED4BA9C893B488C03FA2E7F89@DM6PR04MB7081.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB7081ED4BA9C893B488C03FA2E7F89@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceba1047-710e-4cd3-c153-08d95e621d95
x-ms-traffictypediagnostic: PH0PR04MB7669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB766938975569A2DFC1F09E52F2FA9@PH0PR04MB7669.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4DE5AignYFImze7/bC80MKd26rIKI05iELdxtgrADENtRaQwiN2OFXFYYeQsxr8UGEnRetfg64DDnGG5/GbOeur5ruOOfqfoJnvtQ1W6e+OtYlj68HuD7XW78RV1JKSVLzpYr7wNRIwwpwznSYT9joYT6AvBgBFmBHn0tnJOWVLi8arHsf+JRMTC5NcVdjJcu0FrVXZj0e6ovmuy9XrS10XrlZfQliD/HM39/14fKAU/+96ZadysQCVzilBO/y1rFgJi2H/QVYqWTTBjJ9NHDQtzRYW6HaEMahTSl1iGZ7TbSEpA934cqaQHVc5RWwhgKSbdpMitgfAApogTy4M3MvnEYKo9IMFmbAtE2pwXAUMxO59NjLkIDSdbi2X4f7TO3L9MrlUoSH1bQZIovb2ACcqsu+jE6sBU3kFdM2YPyhkiX6xwhfYvkRtrKMD2M6tqscpHqsUEQcdDoJqyIooBYpovlRdfonEJlW9ezjTmTzS6g1Ix6XcJYIWiazesaAdjd7lYrCI5Qm0h00LOwBxPl8elQ0PC5RNClILVfRuwfuqzHYPW7LIF0Cn3k6Iiv5Tbd/1BFjJIW7fAdZ8gIPefrBekxU9V+UyHrcnSLBHg23ki2bZAWQoLNXaLS4ez515ZKTZ74MkIQ7Xlgayl2SpvRz00x2gNxSfbswEINqLuxpZoFP4YaSxaRDQ6RMUxlSkgJhIzTrQjSOB2Kzs8Jcutg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(8676002)(38100700002)(6636002)(316002)(186003)(54906003)(478600001)(83380400001)(66556008)(6862004)(64756008)(6486002)(122000001)(4326008)(66946007)(86362001)(66476007)(91956017)(66446008)(8936002)(71200400001)(2906002)(33716001)(9686003)(53546011)(6512007)(6506007)(38070700005)(5660300002)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VzlasWv7Dfp3xt7rjfyyf66G1aDBBsq2mNKudH4yzimgJPyTpofPeLTe3Tow?=
 =?us-ascii?Q?93uPHzKZuBV8JIVH5bO8t+MH0Gs21NJrD2ulcnR2ta+6UBiGFgOEjngHk/iT?=
 =?us-ascii?Q?J6vuE09124Zkq7INTghf1GDWbfWKkSICcES/m3fobvYxlEPc8q5+VtWkAR3F?=
 =?us-ascii?Q?VBLpgM6/F150ByZmbAP19d+ZaabGINh1z8oqh+JHy79+zeVTz9afUrHm89vb?=
 =?us-ascii?Q?5seUcVdq4BRml42fGiAnEjgGr20DOEbBcwPTcdq6Hs2j41J3dbcX5+RbvpYz?=
 =?us-ascii?Q?njpcFLY+/XGNhKtIdk7Vr4216eNLDkpGbbH7TLbutT8ZWcq7n35w7Y2ES9Ao?=
 =?us-ascii?Q?nNDA7H27pmicLrjeRiHIhOqKSDLc2I3CMS+MyWN3EBDhP3x962zxXUtiJKvy?=
 =?us-ascii?Q?VvQ6u6zqGDluS3t2+VDE7cZnqw/8Kf/NFlpuY4KufyCC3ya4ayclzviIo9CZ?=
 =?us-ascii?Q?r4irAlrAFSoBVwpTdCbU2O3OkDy0xEWkKU3zWBXYsVsBHWMkv9UGu9loTc22?=
 =?us-ascii?Q?LJbQgQmg0wPoNoZVkXDCMtEramPu/0OvRVKnv4bOetzlKaZQ47qmw3/Lan2H?=
 =?us-ascii?Q?gL4pCiHZy7IDkqFa1u7wn8uNjOFfzAtH8sTJa84ygfxXVswLR5k8qnb7WHyo?=
 =?us-ascii?Q?8BE3QameDtTzUboo8CnBdgEYQkStYJUdDfU+73SEHUxqVR0NnsVmfj1zBqPl?=
 =?us-ascii?Q?nv/eoPsoubXVq35hAXNhdIUhb2+rxl4qbeK2ye8rtrAjbwkdYzFNr4aSS3AD?=
 =?us-ascii?Q?lZkSkokXNW22MXiQCI+vSRjDr5Csr3o2PQQLNFIXfR+KwLPlvuj9vcfsg6eR?=
 =?us-ascii?Q?uz8J4ay1Q/71ZteLeyZ4PxABN6n1EZlJA8ibBNpORuwwf7r3bl7t2yCCw0FO?=
 =?us-ascii?Q?0io1QYDyd2SXM5v0vy0jdy+1xSswzgsOebTNzivYqb4/b5Labml23InLqncZ?=
 =?us-ascii?Q?t1AgjsGgLjitz+87u8ez0M1sJaywAWWTjXArmIAjakVBSRAqCRUpbpJcfYkc?=
 =?us-ascii?Q?jQzNGaMDNVllbM/NoeBdeDnVzTZnHGdd2xWt5kSizDCnatF+XOFaFOXyb/N6?=
 =?us-ascii?Q?21j5WYRH4tSOyh+0A5709bcHlNyCGcMLiMXY5WShlPUSfgViKIxpqrgxU21O?=
 =?us-ascii?Q?E2C/jgpIrfAzNwP+O1SaKp1nyGrFauK07HAWrGKY+BBREWvhIVG/O8ailIZh?=
 =?us-ascii?Q?MAcw3wiBcdOPhq0pAsP3ipAYE3Fu28LApSdNHtkJv2a9w3Luz/wNjkNJuB1o?=
 =?us-ascii?Q?13UCv+TEe6JvY8cYpcoBmTuIQJ1WXLpqtkVDqfE7guIT+8l86vIXOtfS5wba?=
 =?us-ascii?Q?JD4xjSpx1d1GJBZpQUB6IkOd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E02233AF9BB1C040A01FD263CDFED7A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceba1047-710e-4cd3-c153-08d95e621d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 13:56:14.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtKvReBgG9rAEqGO/1z0vg+9RzmiFzOoIrM116VwIN7o3LY/fcaTheHl4wGnNl65nHQiJY1RbSS5IPmG/zuIMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7669
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 11:30:52PM +0000, Damien Le Moal wrote:
> On 2021/08/12 4:07, Niklas Cassel wrote:
> > On Tue, Aug 10, 2021 at 02:49:39PM +0900, Damien Le Moal wrote:
> >> Currently, the only way a user can determine if a SATA device supports
> >> NCQ priority is to try to enable the use of this feature using the
> >> ncq_prio_enable sysfs device attribute. If enabling the feature fails,
> >> it is because the device does not support NCQ priority. Otherwise, the
> >> feature is enabled and indicates that the device supports NCQ priority=
.
> >>
> >> Improve this odd interface by introducing the read-only
> >> ncq_prio_supported sysfs device attribute to indicate if a SATA device
> >> supports NCQ priority. The value of this attribute reflects if the
> >> device flag ATA_DFLAG_NCQ_PRIO is set or cleared.
> >>
> >> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> >> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >> ---
> >>  drivers/ata/libahci.c     |  1 +
> >>  drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++++
> >>  include/linux/libata.h    |  1 +
> >>  3 files changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> >> index fec2e9754aed..5b3fa2cbe722 100644
> >> --- a/drivers/ata/libahci.c
> >> +++ b/drivers/ata/libahci.c
> >> @@ -125,6 +125,7 @@ EXPORT_SYMBOL_GPL(ahci_shost_attrs);
> >>  struct device_attribute *ahci_sdev_attrs[] =3D {
> >>  	&dev_attr_sw_activity,
> >>  	&dev_attr_unload_heads,
> >> +	&dev_attr_ncq_prio_supported,
> >=20
> > Hello Damien,
> >=20
> > I do not fully understand if NCQ is only supported for AHCI controllers=
,
> > or if vanilla SATA controllers (without AHCI) can support it as well
> > (since NCQ is part of the ATA Command Set - 5).
> >=20
> > However, I do think that you might have missed adding the
> > dev_attr_ncq_prio_supported
> > attribute for the ata_ncq_sdev_attrs struct in libata-sata.c
> >=20
> > (The ata_ncq_sdev_attrs struct already has the dev_attr_ncq_prio_enable
> > attribute, so it makes sense that it should have the new supported
> > attribute as well.)
>=20
> Good catch. I indeed forgot that one. Will add it.

When respinning this patch, we should document this new attribute in:
Documentation/ABI/testing/sysfs-block-device
as well. (ncq_prio_enable is already documented there.)

Kind regards,
Niklas=
