Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2780C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8564F22581
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 11:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgLDL0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 06:26:23 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56513 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgLDL0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 06:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607081181; x=1638617181;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lyweAXYJEUD3vcj9hAsIGOhjob3wm0WUZuyfC7HYKvU=;
  b=Sw/9Fumol5dixkfoPbbl7tqgDGgHduf/Szf9cj8OGYfQ5gSMp/4aiSYi
   E3++BhmhmdelOwwVpOYl0ADMk+ydYw2VvZzeJmhL0lL89MVQZnvELcvaw
   aPQRKHeZCKs/iRCuo+pcKA9WdTGsIDCS4CXsLUTffRTAohxkzj/eE2er7
   YkCWiabVUWK+AsZduoovO1XqlQ8l7Q1YZ/G4RwqPY8m6qp5wOPKw12aRG
   3KsyRSlXgVroVN5e2nbRg6agUdLr7gMlMM22f4a+xGQHG0by8CqZZ6cjX
   cIDdMK36YIziX1L9RS/7RA0wPc99hKXQTeTN4g3e3WMXJJI0e57+Qo3Jz
   g==;
IronPort-SDR: 8jaZBTanwCqy4mEbB/a3zGKcpVqfVH5bx6iG7Wq8QNK38OkBXLE7PCqQH2q3cT5HdQ8wDbUBNU
 KYm5fgTABi/muPEBYSpuEy4JdcSlcctHDNTV5gvcoj+codlgCJWN6TbODBcU7N768yUXrZY363
 IlgCEcK+J1Okid47UdncuWv157VXUU0Qj5YSaZbEw759vwsVNGXq/DxqWCG8DGiKnjCzdrEQGy
 olZRLhHFJ6UDPaE9X9Hv+e9qm/xCYixUZs7wbeZGghhNcUXfi5hDm/J7R1TFkyhSej136qe2NN
 dko=
X-IronPort-AV: E=Sophos;i="5.78,392,1599494400"; 
   d="scan'208";a="264579782"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 19:25:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geXXzXWeY556CY90qL5D9svChhq4fncvFICd/KIS7DSytuDN5QOrv30zEpbggbZZEtb0DpApqSmIjY3/3EP5EOjg/MbkDSr0HJVxWsQV85wtF3ltxHJFPSholvC9nKIc1a8H8Rmjl4lpWUs4N8fGvMEUEBT/LjKQIlYMrWImElDs8D7UOj5+vWXtXiikDcoeQiVy2G83SY2T10Fprj2wrq147yI0Fk4ZQr0HL8yVMB/evDCXZqZ7YUquJnGLj1ywXOUaTkOsk5q1xjtGKhYxHMoFgoLUuEBKLXMX/1VdvKSF4d8yqQre76NeoWD02VbITB9SzqUefoHQZ7T9+4LVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLjFZ/Sovl/XIRW8xFXzc036bfFKtqTTJbIJQJzq964=;
 b=D3UGDfhIwIQlkWbIEwRs1Jbp711OvB0tDRkAkL5CP9AcX+m3Vp399QszTC7QtSSipVpNy0vDg+v8SFrT3tOnjKOrmUDrRTTOAPpWX+JLwt+z5pqaxKHhJlVG+jQWw/ZuYzEm2shE4DuzDJcTYXbhaVh7+795mMOKtS0fCYcY7wwct3A9si5bh1Jiz3E4l8L04LdLUMxxlsm303pVhgDuao2IH506zGNAIsYjbkSRqI+PEs1Eaf+KvlhwZqCNY2AFx+rdFsx24/5ILuj4mB32VNMhcLztw3Owc4fXA0dbNpCdVJKRsXNVrKhyIJvxhBCYHQRObPeNCO3eiqz/WyhkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLjFZ/Sovl/XIRW8xFXzc036bfFKtqTTJbIJQJzq964=;
 b=B6PlkWfTRENhICR95eme4CCbfOfsLZF16d3AC94zl5OKc5xyuFt2QRO6m0B2t3ktA6ahOk+JgQ3dwXDzP98hCmlmw84nbCOE6xE7EqXYcEzL9s6QK5i44YBte9xpoyNmakMsuKtOoxBqYOGLjiu/Si+6s3biZA2mlhiwuNyiw3I=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6773.namprd04.prod.outlook.com (2603:10b6:610:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 11:25:12 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Fri, 4 Dec 2020
 11:25:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Thread-Topic: [RFC PATCH v2 0/2] add simple copy support
Thread-Index: AQHWyiztcinYLb1afkCNvyh+SmI/oQ==
Date:   Fri, 4 Dec 2020 11:25:12 +0000
Message-ID: <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5458:21bf:70ee:2847]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 365128f2-0c71-4214-0ced-08d8984743f0
x-ms-traffictypediagnostic: CH2PR04MB6773:
x-microsoft-antispam-prvs: <CH2PR04MB67733E8C5C03A26F94B188CAE7F10@CH2PR04MB6773.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +i/280XiUrz7Lug2VI/UQ+rhTgH1eLdX9qrNyq1fcLfhCZggU92eS0kB6ASkXtijmebkc3PNPPnE+sIg0dtcCCYiq2MKn9kwKSgUH2Uee6vTMjScMWvP2lyalQjCepP5Rok4+nN1ucC3h8LqCLkwFklV0YFGgXvQRPecREAH359iJcxi35MdE8HkVS0+nkE1oFBX9T/6WJAxjsbNrU7lBPxC0JGwYw0DOVOD1nPkIQ3ImEZls2yrNBKmWKgJx0HsQvyGAWeVPrruHeP4QswAvMp8HoJ36/GR7nmM0DqMORXtIeFdBoW0rvQqTZB/nDL4g5j1henZGBdsoBCyXdkUnRnMi6UUxxp6nXqDDFo36k9y//MQSC7q9VIUXMs+PNC8kzwipMW7Rah/bnrajR440XBcb1jn2b2UXcvKICjqiA8ej6LEzzwKSvi+eRgDMoGuivJ2mout2R3onzjYtMzmpFx4XRnAF/flD+gBK0AYGks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(110136005)(2906002)(8676002)(6506007)(5660300002)(53546011)(33656002)(478600001)(86362001)(66446008)(52536014)(64756008)(7696005)(71200400001)(966005)(66556008)(76116006)(66946007)(91956017)(4326008)(83380400001)(66476007)(316002)(186003)(7416002)(55016002)(8936002)(54906003)(9686003)(43620500001)(15398625002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?92oygtK7aS1igR7/5a/PDTPjAOGjsxYnwK4lz63sUia+HVGkJKDPgLjoKpTC?=
 =?us-ascii?Q?QO4JRkvSoiGxMlQcLIK9ym0x49gBki3hOpTADA56lSDhmGByu0fc1jag5tcv?=
 =?us-ascii?Q?BcFQd627ZxQPcIr9kMBkCk/vId217knnM4aftMJDrbnBFfAKtnMlMdFlPbyy?=
 =?us-ascii?Q?I9DxhQ4BQCROiRnRjqlr5iNXdTKwOAybqfMgkLywEOV+WFY8RMH3XTJltRUg?=
 =?us-ascii?Q?3hRsq96zY6uRoxQ/VxvB8+umlKVhZHOtYYvqHutwol2u0ow25XeicMUqo8sc?=
 =?us-ascii?Q?qm1R0Jcp8a0Ved4Fb6dx7WwbyA8uUf6Pdc2eMjikLC5N1qvZQT9EeE5mvhCE?=
 =?us-ascii?Q?XEPj6fqUDDROb8ca+eVnnMtDeCpxOme43zW+j6uKpblYcv34Z51OZAzwhP1f?=
 =?us-ascii?Q?2Kn2YUIZ/3V6i2DZOLITA6iXIk3YOpSQVVDOqLT+hgPtH8cAYV63rsxS708w?=
 =?us-ascii?Q?Irg/Fnq40ojNUDYMrNdO4W1m2P/tfrciCJcWEZ5VxXysfAxMO/RslBei42iv?=
 =?us-ascii?Q?wGOX5qJSO/gJiKPZ49ID4uvlAF7j5Sfjox6G9+cbB5T9jLH9ghEpriYH2qEh?=
 =?us-ascii?Q?yRj6mKgDuIC+soJ5zWvqJvQMT5bTg7vaO0kALYhvQmNJDsk8Y+mnYVQXOj6C?=
 =?us-ascii?Q?qLXY1RSi8N4wqMjCT506twF0saiJ9TFhU0wUr6IDqSOJOzLjzTE3ElglPVAl?=
 =?us-ascii?Q?HJBPcKjPfqz4iq9510Ibb8ykQxldKtInr2M+SBAq2INlZgV1rxVgZj5Pxuyp?=
 =?us-ascii?Q?ya9S3wqQt14hIaelj1V1y+MhCbnFNzh35bcJiCUArato/kyiZmHGjXtGjMTU?=
 =?us-ascii?Q?wYL5ivbeG5MrWL9XmqRZF5b4sm7ZF870eLlLDoPFOvCbGBo1eLWce7utEcSu?=
 =?us-ascii?Q?3CFt/Jivk/Y2U92zc3WAPz90yYjWX2ik/OBgZKLfRkqDuDRj+ket32iqcWv9?=
 =?us-ascii?Q?ZTh/DbJHyofohEUuJFqnDftHHVBjuKj4rh5x4X2rY166GoKJTP8l9NACA66o?=
 =?us-ascii?Q?4BFiHPbxtxRsUqMitxUc+umreS80gSv9yZ/UGoLrcX5XPfK6S3doq3ipoAEJ?=
 =?us-ascii?Q?8QvN5Wuk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365128f2-0c71-4214-0ced-08d8984743f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 11:25:12.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyxWB2Oe3jjtYFH1Ut9EdnYdm1bmjcp5idVZeopuDqXjNy6AFjBfCcQHpLXzjjG5f4LmVEqa0MI+YVUXAQCUrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6773
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/04 20:02, SelvaKumar S wrote:=0A=
> This patchset tries to add support for TP4065a ("Simple Copy Command"),=
=0A=
> v2020.05.04 ("Ratified")=0A=
> =0A=
> The Specification can be found in following link.=0A=
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.=
zip=0A=
> =0A=
> This is an RFC. Looking forward for any feedbacks or other alternate=0A=
> designs for plumbing simple copy to IO stack.=0A=
> =0A=
> Simple copy command is a copy offloading operation and is  used to copy=
=0A=
> multiple contiguous ranges (source_ranges) of LBA's to a single destinati=
on=0A=
> LBA within the device reducing traffic between host and device.=0A=
> =0A=
> This implementation accepts destination, no of sources and arrays of=0A=
> source ranges from application and attach it as payload to the bio and=0A=
> submits to the device.=0A=
> =0A=
> Following limits are added to queue limits and are exposed in sysfs=0A=
> to userspace=0A=
> 	- *max_copy_sectors* limits the sum of all source_range length=0A=
> 	- *max_copy_nr_ranges* limits the number of source ranges=0A=
> 	- *max_copy_range_sectors* limit the maximum number of sectors=0A=
> 		that can constitute a single source range.=0A=
=0A=
Same comment as before. I think this is a good start, but for this to be re=
ally=0A=
useful to users and kernel components alike, this really needs copy emulati=
on=0A=
for drives that do not have a native copy feature, similarly to what write =
zeros=0A=
handling for instance: if the drive does not have a copy command (simple co=
py=0A=
for NVMe or XCOPY for scsi), then the block layer should issue read/write=
=0A=
commands to seamlessly execute the copy. Otherwise, this will only serve a =
small=0A=
niche for users and will not be optimal for FS and DM drivers that could be=
=0A=
simplified with a generic block layer copy functionality.=0A=
=0A=
This is my 10 cents though, others may differ about this.=0A=
=0A=
> =0A=
> Changes from v1:=0A=
> =0A=
> 1. Fix memory leak in __blkdev_issue_copy=0A=
> 2. Unmark blk_check_copy inline=0A=
> 3. Fix line break in blk_check_copy_eod=0A=
> 4. Remove p checks and made code more readable=0A=
> 5. Don't use bio_set_op_attrs and remove op and set=0A=
>    bi_opf directly=0A=
> 6. Use struct_size to calculate total_size=0A=
> 7. Fix partition remap of copy destination=0A=
> 8. Remove mcl,mssrl,msrc from nvme_ns=0A=
> 9. Initialize copy queue limits to 0 in nvme_config_copy=0A=
> 10. Remove return in QUEUE_FLAG_COPY check=0A=
> 11. Remove unused OCFS=0A=
> =0A=
> SelvaKumar S (2):=0A=
>   block: add simple copy support=0A=
>   nvme: add simple copy support=0A=
> =0A=
>  block/blk-core.c          |  94 ++++++++++++++++++++++++++---=0A=
>  block/blk-lib.c           | 123 ++++++++++++++++++++++++++++++++++++++=
=0A=
>  block/blk-merge.c         |   2 +=0A=
>  block/blk-settings.c      |  11 ++++=0A=
>  block/blk-sysfs.c         |  23 +++++++=0A=
>  block/blk-zoned.c         |   1 +=0A=
>  block/bounce.c            |   1 +=0A=
>  block/ioctl.c             |  43 +++++++++++++=0A=
>  drivers/nvme/host/core.c  |  87 +++++++++++++++++++++++++++=0A=
>  include/linux/bio.h       |   1 +=0A=
>  include/linux/blk_types.h |  15 +++++=0A=
>  include/linux/blkdev.h    |  15 +++++=0A=
>  include/linux/nvme.h      |  43 ++++++++++++-=0A=
>  include/uapi/linux/fs.h   |  13 ++++=0A=
>  14 files changed, 461 insertions(+), 11 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
