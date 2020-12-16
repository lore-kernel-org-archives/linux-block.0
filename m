Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39226C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 03:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55042311A
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 03:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgLPDPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:15:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14593 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLPDO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 22:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608088498; x=1639624498;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zFELa3j02T1VPSHGTcM5uNCLYn16xt77+PoPM1E/EEc=;
  b=FLBQPvYaSzuUTignzQakOyjpvLwlVSTCV+TPFlASJvpBl+n4fl/r3ies
   QfasmpjdEO4IV/oNnNiWiWCHixM/62GOBpAQtDwXU90cSmsGF33Brd/U8
   nXFsRLjN+aW1xn+WWYlwZ8gK/T8UY9vm77Rzvu54TabuIKmTj08cOaV33
   wZ5NSz3OQlgVMFJ5/2bGM9OXmZPWkK+XlsJvRQUdiceBpKM0UNY6Q9hwR
   UjLAxwqLXfE9Z/SmOPf9xrgxpM93eDgIkt8pCFChs/P4Ahvkwc7wkuPh0
   8o5JFjQ91X1DxYLSykTU0vLLOmHqkdbqgyedhZka4CYbvUt2Uw3NNibtH
   Q==;
IronPort-SDR: rKB3ZqPKxPlsbBpRINLisq2r+0Hy8FogdG5AI/L6bstfdoEUSy0fBbgozCoeJWsTkTm/5N6fmI
 dAxe3Hpw1rUYBOn1veBvGAHiJI47U1obkMiEIuw8oUi2DA3EsTlPmm4+H/T18gzPQaUkE1t2RD
 CZZJtWOlJhmseiKuTxNxBQ3uKh5nEWF7pu2JEqxA82h3tLdG71Wk4jSwG9CoO2/yBgw0efoNPI
 DmGZdbHKL7aJL2S+ANLuVQlmBsWrx3jofV2LshMdgb9Vk0b//rjzDq5lZVBhyw1Kg4GDRCEAti
 ofE=
X-IronPort-AV: E=Sophos;i="5.78,423,1599494400"; 
   d="scan'208";a="265446975"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2020 11:13:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWj5o1T7iLAN9dxMeBgwv5l+WfyWk6VgfnS2lT4D4tCQdIHsAfuXQBPDhIUNrlOirwjTTgSoLAi9gQxYyHt+yvxkWJuXcJND3bmkuJZZxTSjJVj3KOY51GeLkSaSWQIVZRB5DtgUmT+NLonHaHwGxdSVJ8S1Jn3miqd17DFTCNASnjjJuJcUxEsrJuGpwg1fKDrnhDAZ7yEUQ82ob0WMTbV7t92UB/68kWX6haOtw7wGaf3FnIrJwPeSjsk/rOJlnFUaTR8goaqIyokytxi/Zzxryz2CGZiX49ECVbY8wpXtq/BvhiyPXzUfr4JXVmGps9WZVonVXk/qaU08R7NtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLnW+Lp/pgmwBrzzWH8tCpYD0ALH0GByj2NA8o+YQ/I=;
 b=BfnPRG1Tu1oN7KUmqgoqDwHJRTXyEzibVx9nUFRG6XK7hC8p2rCD9BotmON6aEBcpBfCPg99o1ORV/y94sD6Wb1HHA3WO0XfEOAdc97pd/wXukeK6ZgR+B7iQVeCgcZvIKrmwFyk+GmYZ3oq8HvMLz/o+9nULWw77ZkU+QLltIBL4OSAHN97iUBpflkkwTUlfNGFb/k7j1g5c99Iogc8JYsw+TRjHeUMWlv1RRFE3IRuLCEyvkpWPK1oZqtzMV3qxErA6280vJal7bXHrc9UQFaFejQZGI6ENgo3Bo3G0ve125kkAdDheOqLPIGqr7ziKZ9Ee+YIATfdp+97+wdAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLnW+Lp/pgmwBrzzWH8tCpYD0ALH0GByj2NA8o+YQ/I=;
 b=ZIYVa2PNlWA1ljadBqzJp5P7gAhEXuJuslU1bVzQKAOxFTCPaX8fchpcss2ZS/8yLy4ExBMtQZujCsyaDUDraScAyboEPWO+Kf+0KmaHcfYBPxaoYx6ZMeO/BMuVhoTgm5LW2hdOpeBq1iYipNTyrzcAL4msZdMMsvBLq9fG5ak=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 16 Dec
 2020 03:13:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3654.020; Wed, 16 Dec 2020
 03:13:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0qgRNy69mNMtIEqLi2NUVHmAXg==
Date:   Wed, 16 Dec 2020 03:13:51 +0000
Message-ID: <BYAPR04MB49655C8106D1B958D12CBF5886C50@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
 <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522AC040C900B2574125884E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49659C0D80D3D3EA2F2D24E886C60@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB6522763AB222AD6F6CBD3321E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffbe728f-abae-446a-53e4-08d8a1709d06
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7437B41AEACD1E394020C01286C50@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xMPoK0n5Pz9xxHfP3Ju/Om0kVFp9K2BOk+V+jyANQ6168ECDYfnAJd2GJOpE1GQvIMyNMS84UHsp0VCwghjBQFGqBqei3IgaLeiKu8KVWHwGns4BpWjw4Ip0RH412PNIeJCbcqZnJC1TZsuOMEyCSIZro05HCTJyUH4QUxWqpRnK+h7E/rQTfFvXwph1QFDPC/rRZhCYMdurvEuY0IIJoz/07PSaoSk0UzTBl6HdNHYxctJuJp+1Q/rz2gZ1gDaBzzQ8xNAveknzb6e2yfzUrlga0DdKrcw8iitWge1/YbvD3omnQVT9GWXC/wUhwyELR4gUkvP9sr0tk/p6oCpcUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(55016002)(5660300002)(316002)(2906002)(66446008)(66946007)(54906003)(26005)(8676002)(66556008)(66476007)(110136005)(71200400001)(64756008)(7696005)(4326008)(76116006)(86362001)(52536014)(478600001)(8936002)(186003)(9686003)(6506007)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u6savwr0iPFKf26zZHfS2X2TESyX3cRzdziTmw8t++OVS0ivCL8xQC1csNCS?=
 =?us-ascii?Q?xB/PT122y/GmQBCoG1lRhxhDgU3df+pujl1zFhNDTjiry7evziqR4EySa6sf?=
 =?us-ascii?Q?agk4qcz5Hugyoxx11qV2FZpRMShh8CwnopqjXASlYbK1nagrI8gOYYKYetP2?=
 =?us-ascii?Q?v41tHVxMZSQ1EsJy+Xg9YKPCVATdfwDeyWCyIi1Gz8lc5N2AgTVz836WLv78?=
 =?us-ascii?Q?yRexA+lcGI3mUvDFPVQXWzunvJA8jFuL7JbBnpUEc7F5ouWt9pXJchNqtJX9?=
 =?us-ascii?Q?REK8goXpAfJ+Y7zTZPy/0PwApuArIbbC5plOhzuaC52dgF2I/5Aeou+oCw74?=
 =?us-ascii?Q?my3eF0IGlbCpQUa/0lmnK8gLUGig/KIbCTl8q5fKj+Umm/GCbmKkYmKz1A1M?=
 =?us-ascii?Q?QJuWEdSccFF82h06y8mXegOk/MaiQhNZp/fx5Vm2OxUYqN/0nwaUByLv0aMX?=
 =?us-ascii?Q?FTAWCMupD2VQuEV9kZefh78kx6LXfOTuTnVbz5fYCCm8L/mgfa9ludfXcuxn?=
 =?us-ascii?Q?GS4Wba5qfksL0luQsxeCiIUA4pjaOQGYDATx9p9PT/aJrfHt0gMSky/Gi18U?=
 =?us-ascii?Q?qYC7x0QG+VX6cZg7/f5jfokrpEzkZAkVRAjqGRE9VFatKnhyGXvz/pdJDmPj?=
 =?us-ascii?Q?rI67/calEQ40HNBYT2GAns6ZUu2Zku2JjgAkiBc1H2/05gBhUyhWhH++8Hx0?=
 =?us-ascii?Q?sqwxg0esDKG0y0939I0AZf7Q/d+eEMZGDFOh4M3e/a5V06lExw4GpQEmuSKQ?=
 =?us-ascii?Q?VPukW22rJE8NH+Fk3eZ2dOYcA4bwIaYS4oiBBznDHKwyqkc4u8JVdDwgIplx?=
 =?us-ascii?Q?wzPbIt9xjdgpZxnXTq8q3buG1SXXpdv9+MWKaqJq/MbmDXqtlYKN0pPO8rl2?=
 =?us-ascii?Q?Lf+88lDO4xotIkPt0jfRCKVKDr2s13E3fYPADFzLuHWa7ILLcnAEUyOPm1oc?=
 =?us-ascii?Q?yBbow5IyBVQIPGQVVhfej1fnBEwrhZkxns8ALiA3C4dm01KZxOhe/i67ZMBq?=
 =?us-ascii?Q?ZHcu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbe728f-abae-446a-53e4-08d8a1709d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 03:13:51.4232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xUKq89fwRnl7E8iLYZRpFalDxT/AI/fIcQyXcEyinndcIUEnUakPsBaqOh4gkqtQ+RgSqD4AvCnGcHS0Jsk8Cb8imkIv752+pefzyt1/ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/20 15:13, Damien Le Moal wrote:=0A=
> On 2020/12/16 8:06, Chaitanya Kulkarni wrote:=0A=
> [...]=0A=
>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>>>> +{=0A=
>>>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=0A=
>>>> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
>>>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
>>>> +	unsigned int nr_zones;=0A=
>>>> +	int reported_zones;=0A=
>>>> +	u16 status;=0A=
>>>> +=0A=
>>>> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
>>>> +			sizeof(struct nvme_zone_descriptor);=0A=
>>> You could move this right before the vmalloc call since it is first use=
d there.=0A=
>> There are only three lines between the this and the vmalloc, does that=
=0A=
>> really=0A=
>> going to make any difference ?=0A=
> It makes the code far easier to read and understand at a quick glance wit=
hout=0A=
> having to go up and down reading to be reminded what nr_zones was. That a=
lso=0A=
> would avoid changes to sneak in between these related statements, making =
things=0A=
> even harder to read.=0A=
>=0A=
> I personally like to think of code as a natural language text: if stateme=
nts=0A=
> related to each other are not grouped in a single paragraph, the text is =
really=0A=
> hard to understand...=0A=
>=0A=
hmmm, why can't we use a macro and like everywhere else in zns.c=0A=
we can declare-init the nr_zones which will make nr_zones initialization=0A=
uniform withall the code with a meaningful name.=0A=
=0A=
How about following (untested) ?=0A=
=0A=
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
index 149bc8ce7010..6c497b60cd98 100644=0A=
--- a/drivers/nvme/target/zns.c=0A=
+++ b/drivers/nvme/target/zns.c=0A=
@@ -201,18 +201,19 @@ static int nvmet_bdev_report_zone_cb(struct=0A=
blk_zone *z, unsigned int idx,=0A=
        return 0;=0A=
 }=0A=
 =0A=
+#define NVMET_NR_ZONES_FROM_BUFSIZE(bufsize) \=0A=
+       ((bufsize - sizeof(struct nvme_zone_report)) / \=0A=
+                       sizeof(struct nvme_zone_descriptor))=0A=
+=0A=
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
 {=0A=
        sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=
=0A=
        u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
        struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
-       unsigned int nr_zones;=0A=
+       unsigned int nr_zones =3D NVMET_NR_ZONES_FROM_BUFSIZE(bufsize);=0A=
        int reported_zones;=0A=
        u16 status;=0A=
 =0A=
-       nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
-                       sizeof(struct nvme_zone_descriptor);=0A=
-=0A=
        status =3D nvmet_bdev_zns_checks(req);=0A=
        if (status)=0A=
                goto out;=0A=
=0A=
> -- Damien Le Moal Western Digital Research=0A=
=0A=
