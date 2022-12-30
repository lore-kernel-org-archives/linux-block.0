Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73684C3DA7C
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiL3I6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 03:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiL3I6c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 03:58:32 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D71FD0C;
        Fri, 30 Dec 2022 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672390711; x=1703926711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BAXardESnMpWWmbd0Brz28EqDoC43xqwX6kZvsrfYRI=;
  b=ByKs8z5jP2HRoDuHRPTvbjz2Ww5lh1vKswWLFbV6X6wF6zr24/oHfwb+
   q3nCkc8ar5/Oz4eS7N7cCUabLD4ZdQFuK/d3kRV4HKwosxneeEKJvxeZU
   kt9AwDNWaq9NhSVj+x+Wo72bKt4XogUrPT7EasR1zgICdc5nGcOnHJAKQ
   GzcpR8Gv3tO3jJzwLqVf3tphysB5TZ+/QTtHXHULxFyYKdGVAEfifGzPp
   esvF/FGKK1nPe68C4/UVaxNnbcZcox612rR4G3uyMgU1JUV7ASrw+T/I0
   DggoWr55T9tIheY5TuATs978G4MdRa5Ifpl9HMDvXZvnZH9yTUkQKP/So
   w==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="324026766"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 16:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsETvP3gPj3G1r/b/+rPP4+wYJqtCv+9485KECGOGb3OFVPPK+hqUlMZt69Ei0Yl9ofndC3i0Mt/HeQ5wUcTtYjbi6owiIsP6FPMkeEonu85sv14/hZpfgBPjAdbYvhHsBH07eCmSeN1tieJB2p3no2egl3fVvDO2OjF1oNNxSKODO6ekwAh/4OrmnxvXDw27xso+8lUKrzdCivwstM6kBV5JAfoVgCT9rt/oPNoQfQiJjUw0V97uJtEFVKFWaYxEuPGx0CgNTOJ0UtE0ewLPpUVw+m1IaFOiF1G2VQEYM0uzj4FfO7nEdMZxkv05l/3V4rE/jSnzwyAuDC+3DAfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04zYyd3z+wyfU6kkeP7g6R/iTip2fcHKC+dX5a/Ai9s=;
 b=anZiXzngV8CGLHXB3jub/QFeXEq5j8gouXsuoEWz+QdinlxZwAnqRDiHBfV5aKV8RpF33y6VIGy5xVazcOuWsCcGo2ahrqjRKOcimrKwD3X//a0IR08SFNrN7kg7aIIiGrb5xFtf4HJC47dEvIRxObJmrBIYV/80h9eRcG0mU91gYWlYN4aGMKUbVFZ/dqmVpDTMn1dqLbiC63Hci+p22FMoknn4uaEi5XtI8eCJjG5d8wbGm1HFB6rFamJ2pFgBGC4+5yXz5cSvE18XGpEhA+d9kj71eEb1lpiSje63cBL3fFotg33EFFyOaZ7MewoxZHshkjFy48mtYJAJ/+wVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04zYyd3z+wyfU6kkeP7g6R/iTip2fcHKC+dX5a/Ai9s=;
 b=VwElJHxLHACuyvbyAawugIrk8WdZn+q7gnInvKZIh1ZFn9BrrdJj2zXXsuJQ7JhtexPFDKRviMaipkR03RygwjqwAPDED/cMefu9oMJszxVdKQhxL7ZwAfotxlAVNYLrr5wgMAJjGbb2MBebO3JkwFNEiMhiqgLbtecUYZe8+U0=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN2PR04MB2384.namprd04.prod.outlook.com (2603:10b6:804:12::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 08:58:27 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 08:58:27 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 6/7] ata: libata: blacklist FUA support for known buggy
 drives
Thread-Topic: [PATCH v6 6/7] ata: libata: blacklist FUA support for known
 buggy drives
Thread-Index: AQHZHCzhMOKemT3XfUum/h1L7zqb8w==
Date:   Fri, 30 Dec 2022 08:58:27 +0000
Message-ID: <Y66oMQT7UO/NLm50@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-7-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-7-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN2PR04MB2384:EE_
x-ms-office365-filtering-correlation-id: e4a661cb-5fcf-428d-9518-08daea440409
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCb0XMcYqgFcMlCZ3vpGvD//cnOe9wm/N6epdv+6MyUpWYOb0DHoYYq40sa0iUy5eyT+AMVUhXVOO+1ul8DunQSDm3LULyL/bd8iIrG5oSu1a9kvnmU/NGdRuNDyldLSdcHZC66R2xjh04t0065tbTCud7mrSugJMO/kX3qhn5GhnoiENzb3Ovho+wv3omQiSjy8m4OHvNuJ7aXq6QGEy7Yfv1ALqAUloU/1g3//sEnAfzgQjOV8PKNZlZj+Xh2EkqFPBQIrzQoJLBnM6+fIGitdytTrs4DqMJReKQORSYaZEJap4uQ5Z2spzcZwQwiKn0IzjHhGhCo7lP/I3R8/4sRFczHdCU7jVT1rF6BqSObIP3DPTvsikwcgW8i4o5DSu1M+7auyS2J1ywwCp9jhb4eq+yrEtLeh1pu/gbQPnn8NzkZxyk9OhUchOemTXB3ysd/qqskWIdei2sW8uy20KVTPspbmG+Ja/fn7Tltd5qEDroAddzsv6eqVhIgq4GHf0/Xa82fpjzEGlymTfJ3tzlyNMB0cx7VtdhV8JnQGYU1jxpput06elQ9QjUqwiE81zJf6F6p/k/Yfvdvbr/Taj++CNXi4STl6/LLZAzJTJr6n4DS2E0lQcL2H7GFwsFQ24IQy7FbUnrba1OI2aNtKZXvpdqFVn6/f3ijxx/nsa8ZIIiN1EOx7UHxUllMLsud4vCgBszNhs5e+GNsAPwYLC8LFCNQiQ0R+7aJlv7EHYLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(86362001)(122000001)(26005)(38070700005)(6486002)(966005)(6512007)(9686003)(71200400001)(186003)(478600001)(41300700001)(6506007)(91956017)(66556008)(66946007)(76116006)(64756008)(5660300002)(6862004)(66446008)(2906002)(4326008)(8936002)(8676002)(54906003)(66476007)(316002)(38100700002)(33716001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EBrajhVp0trfycp5foanc3eKhJBQ8CHVWKbslDE9KCBGlL70S/5WbCm3KYJo?=
 =?us-ascii?Q?T6BgO4yV9W7HNNBxzZxQDEFlAQ5czOsHD5eMQ8r05S3szjg2rRmer+9l35Rk?=
 =?us-ascii?Q?KovB1hT8gp8U1w1RSXEcshuV1PBUu0qJnnRctX20yiXLXe4yUrbzJUV3NtMk?=
 =?us-ascii?Q?BSRaEyVuS2zDcabme55UjT/e5ywHzKdyr5BiT+OAZ68erSbBrsyF1oqg6Qz5?=
 =?us-ascii?Q?+Pt3jd+/rtCAN+7JZgLfSQCd/7RfrgwffZ6vwOC4mb6T+RKxeSvmM/mF3PKf?=
 =?us-ascii?Q?Q8Ytvj8Uce6RkqD9XCnDFgJ0CgiAxu2JOONSe3P2HsC6cC6c0bJs0w8nmzKX?=
 =?us-ascii?Q?DOPfDdwiVnBGiBjBfZv/8fTk0a6biDFh9fUFysAzjlKgrhSHIfAdPlaQqSJH?=
 =?us-ascii?Q?nNmrxEVJBPxZQVBAkfTSzYLbr2dwnw3gklO0Ss0nl5IHQcNeRtZmDDbA+r7G?=
 =?us-ascii?Q?7CR6PD84Kz4PaKq1EXETB8yowcuuBUaxS+wt/Gqo6XzD6fyQkbObZnRw7CYC?=
 =?us-ascii?Q?XNeMUhmP2o0KZM8KtlmC5WCeRJJ3QvgdkRgLDFRwDv0WUbJQmQKz1s0WjOVO?=
 =?us-ascii?Q?27STwNSAapiRsclzCr4aWBUt5DZ3qbkujVdskr51isGkvdGEwF23FD7bCWSa?=
 =?us-ascii?Q?LfWVprhG9M+ElRxlGdc9fBnzT6X3kucPH7iXJeCmNWExFVRJROHOzukBRCv8?=
 =?us-ascii?Q?zuDH2aK1wy+dH66/P5xhQ4VqPnpwwckqDd2SQ4wERVhNEK+PnmL4m/C7rF7h?=
 =?us-ascii?Q?S0kVWbIdRF72v1MdJS/YFBKosNvOYNyNdFQP5E6GCPg5RkSmsyymW4b0gHv4?=
 =?us-ascii?Q?b2j/35b5msZzx3WGc2bZ997L7zvx509gYlfeJwOrIbp9q50joyjr4lKQf4mY?=
 =?us-ascii?Q?kkom2040P2/yZuOZPy/5K1/bf7V66NAS+O59myaL9dfRqSJaRLudIKkJmijJ?=
 =?us-ascii?Q?CppJSWlRaJYbugK26Y3Chlu5QAdqwcpzblouQiLeTynsjtTrsOI6iSEW1VFu?=
 =?us-ascii?Q?CXNenNVB1UZzFgGFduGmpH+nrW0tWXYKviV4KzK+Y6ykM1wRXuFrsHhI39jK?=
 =?us-ascii?Q?axkF7lMHl2v6UR2NQsDIB9EbJo5HBF+AOY8DArq2uUWpyvl7SFv0X2R8djz4?=
 =?us-ascii?Q?NG/A45tP5QZ21KJElfX+Y9kmBd5alW1mYBtsCgLvEbI7yBfd3ze6jJDm06DW?=
 =?us-ascii?Q?CbrjxdHQycPQXW9+TYOO3fTYVNNXsmQeZR6ZoV1NTZ4pd+zENHtmzMl7gjLQ?=
 =?us-ascii?Q?4m2HXVZJVkjpF+wlICUK/wTQ2BRahLrT+aV9jb3qjX62xNLaQ05KNvj7iwQT?=
 =?us-ascii?Q?mCSnrBlofKpXPbBR/zwDegJ5VNYhJ5OLZ448R28lSrzitWymH0mYY7SEspS9?=
 =?us-ascii?Q?PR3yhr6WK5A48D6zLT6+Qx1POb4oNO8kVqSGWiwJavra6fT9q5HXtnQRyGXQ?=
 =?us-ascii?Q?yZb3SIeJSd/lY/OcEnQtPF6MVhnvDmLSk3sTY2Hqm5wyS23KelcMHt+anjX2?=
 =?us-ascii?Q?ZflU+pUsAddvtxagINU8dUzoqKTjXyF43IHkkRgvDVB3dUZqsvNE4Gqp1jSp?=
 =?us-ascii?Q?MzZ7gdqB/Q3LqPNxJieAP7fYxGMzC8LsNopvG6yKa+3YRLBl39sbjTptJJVc?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5198AD1FFC95D439799E11FFBBEA3C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a661cb-5fcf-428d-9518-08daea440409
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 08:58:27.2134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTKVLxAShAw2PxEvY22IgfIwl4JKuc8zbdf8o/XeWxtUYBfdD9fJzVtAflggslUWRglVMrYIBSnEMKC8EDbriA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2384
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:43PM +0900, Damien Le Moal wrote:
> Thread [1] reported back in 2012 problems with enabling FUA for 3
> different drives. Add these drives to ata_device_blacklist[] to mark
> them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
> problems on old systems, the model number for the three new entries
> are defined as to widely match all drives in the same product line.
>=20
> [1]: https://lore.kernel.org/lkml/CA+6av4=3Duxu_q5U_46HtpUt=3DFSgbh3pZuAE=
Y54J5_xK=3DMKWq-YQ@mail.gmail.com/
>=20
> Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 2b66fe529d81..97ade977b830 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4133,6 +4133,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
> =20
>  	/* Buggy FUA */
>  	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
> +	{ "WDC*WD2500J*",	NULL,		ATA_HORKAGE_NO_FUA },
> +	{ "OCZ-VERTEX*",	NULL,		ATA_HORKAGE_NO_FUA },
> +	{ "INTEL*SSDSC2CT*",	NULL,		ATA_HORKAGE_NO_FUA },
> =20
>  	/* End Marker */
>  	{ }
> --=20
> 2.38.1
>=20

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
