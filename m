Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF91C433E9
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA3222CB2
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbhALG2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:28:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8099 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733038AbhALG2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 01:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610432910; x=1641968910;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sf4JUw/bZMKPA9YSqZOxD+ynI1az7+/7I2mRgGPexWE=;
  b=qlci/U34XX0Z6keB7YcjufCHS91GfYuv14wOu30SEWYsdylEQZIxqiT5
   5OlLzopwTbNhshM4dFcpAQ5vl7PydaK6HzeHfvaeqnlj3X0X/sz7Owr/a
   cSXrlY3JIXgBeAsbupgaHzh12tMuGGnL9zzaqHwjvwIaSg78EW5ZCe5v2
   Yzkj0aVAwQUSORZv7qBHCrQRUkYCv4nBHiQfL1GQA+ML14tCQ8MFnNrWi
   DR/l898txGPHpc5ymX6fb8ik5gWWcmg7kTUdYOtoRs9sniervkDM83Fpp
   Uo9HI7dJBUZcN+vBU8DNnz1GgocAAAqyLNRPZtWGtkvjk3I06mmoGOSvn
   Q==;
IronPort-SDR: ij6tvgA0p4Z4HTx41GaHBG4jbZbKtX+iTjy8Yna9u5u4cVx0UxqX5eIiDBJ+RfJ1xuFhzsxsMB
 mTapkg4u5EQo65iB4RJmjRkdB08YFPombZuwaqIlofSHdcbF7NJMquSvmnH9ZzJqjZBgRFiW98
 KxSi91016zt7aBsp4jfRRXlEKdpu2xCuQdix4gQTXNrYNfshDl+X2WvbIENypvfzkxkLhW/TNR
 rrYD6xsFuIFKEr5/4UqasgT6MGhmLet9OvcMXX39ump45IczK0vH8BCOHkTwjSZ8LVudvTMrwT
 Lwo=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="158387365"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 14:27:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUTN95bT2qBnGihxhKlqV9ruo/w1MD4iUq7IwUa4qptQIfWYRZY18oTorCMNBA4KEq17oQbPrS6kQkuvvflfnQoEZRz/dQxlBFSYFcA6QFO4Q9txo06aX48aZBdvrN873ITcPzQ0OHg1ujzNTyh8Q60rC4D+LKvb6OJ9mlaVTzisropcCbm84GTmU8QsWdGcIyLekEjkp/1WTFgCAJh1ynfDuFczj4lc+uG3pDUeH48t1gv4uvDZpky9kHs/f35siAOCWCjVpUZBrezjKyZ1VplwqTcdvjwHf/DGSmv4/OqKz9zjHjsMATItiQuT9fP+rde4tgaWGm6tmJDFhEkxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPFZ8G4+NXPtjYLlSL35w0VYXzK31Ddxy3G9XX99n74=;
 b=B0ItrBuc5WeppYM+7i/T+HhKPtryNnPBSiFVID9eKzgC8FnlFfOORb0EKVxLC1QOos8eUDlsuGLW3sXjm2uFb81hos0lnNI2JR8EHUIpMog+1yw5xdfSa9rqpi/hRHgfk0rycLSc4WJEI9b3AoO/cXUS3++nka7sZlk01fvVnWAWewktQRlPL3MbGZ8x3P5KUu3RCLUcKdxeA3TrnYvdSf60+zB31xmtJCPW48SLcsJuvfjpi8D81iJv0XZPuZv9v+mcpT5jgdBy2WTzbwg/S7l6bfiPLon6jloZ5s9P1QcNLOJWN3mffzVmrDP7yQmmoOjgTi64At8W3WnvQWPw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPFZ8G4+NXPtjYLlSL35w0VYXzK31Ddxy3G9XX99n74=;
 b=eB3O73q3vPg0sw0YQD2Vs4U2wmkg/TUB6OPAIWptET2ZyThP0W1okPq31BAX34YQT1TsC43OsUvtZ78QmoxUCLyXC3YNDmQsFpW6qSF0BLiU7MSRDgBetV/6ujxIiWfV/yVGkvJrFagGVksvVr6cqMTbSKCl3X98qov1kIaaV90=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5059.namprd04.prod.outlook.com (2603:10b6:208:54::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 06:27:22 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:27:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Topic: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Index: AQHW6Js+G6K9b/hMdEO916YVEIcZCA==
Date:   Tue, 12 Jan 2021 06:27:22 +0000
Message-ID: <BL0PR04MB651407876C76BDFBB5029D5DE7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514DF0B740BE6F4AB3141AEE7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB496575ACE95FA2E6EA31AC8286AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4af82b6a-149d-46bb-3a56-08d8b6c31f17
x-ms-traffictypediagnostic: BL0PR04MB5059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB505926D32A2118BCB95CB701E7AA0@BL0PR04MB5059.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IS3gJoHj8vkQS2VOAju5fgdzyvscZZ5UAfO7RU6FY23EB4kzSqCp8CvV4rIWyO+Blgsu9WAFec59AXKwZqk3xsl96miElv1IXRCK+MNcZjY5k5oiesdXaFxNxCQrsnXaplJkBPzT/i/OOYAwAK0YCwj0lTz49eAMee4nyC6czg/I0444EmIJBcRlLyvsI4e59AnBOUzhet2IKd/ydf2mo5W48XKavzxjrwK5opdSaxxMdbg4w+nJTnMhF2ALQhUA1SdWZ1lu3UAKnGUvY4Oy8dZ4N5MjBXbKMaJ+Cqfqa8hv7LhOiaW+1AVRpVr4RElhOSqSGjYXvfo2fiNzeiAmqqwPvqTSxkalG7ZN1hY1sahJBXPbO/USQtjoqkh837u7nq/r+eiqO1q5gFXcgwUSGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(55016002)(8936002)(86362001)(33656002)(9686003)(8676002)(64756008)(53546011)(4326008)(186003)(6506007)(71200400001)(54906003)(4744005)(2906002)(91956017)(5660300002)(66556008)(52536014)(66476007)(66946007)(66446008)(110136005)(76116006)(316002)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pv2l0U6qHt9IQ+ROpa4+6MhU0JoMdy1rNwDXrBSMGr7feA2myHrEP0tT1dlx?=
 =?us-ascii?Q?hbETclndEqky+3K7UYc6WGwMTcfWQDTNlEDUgVeQxrbNgiZ1gBo+T2RDUcyI?=
 =?us-ascii?Q?KzyITVjIhmmnah3lubma1iF/pYFQ5REufsrL1tlToLr5NqWMhgxC0HdXAeC9?=
 =?us-ascii?Q?xGxKJo8cNwpgM4my+gfedf7/VAiM9E0zzkywHF5aHW/FVQXGHCobjMtTXLIF?=
 =?us-ascii?Q?Mb95D2Q7CtV3nr2eYe57TEUjC35NGxMMlTsOAqv2RxV43mcSaV6RkKpD9onP?=
 =?us-ascii?Q?cB2nTFnmBggCXFKuFEPpCsFD3zOco8jK7Lm2rDhiM9ragjD6xuiStAlkrj0c?=
 =?us-ascii?Q?7N15VuCiFWAqr5ARnI/RZbZoZCKxmwe5HNCUlLZ5cSVF3DHxwoSooPowa0Qy?=
 =?us-ascii?Q?EsRdTF08DvsMWr3XymJ+TcaNdiwQCE4B5LXcu7wSlJj+SK+W+Cd9SmxgNYvF?=
 =?us-ascii?Q?WqsiepkLQCOGZ+uzFS/Tocwpm1rT5IrwTMAb9+NSycguKCnh04Z2BsBWwgmc?=
 =?us-ascii?Q?g8FrLoNdLKw8+WBGcruvcI2sw/KLkW03evTFwYYLXc5M2cwUY6KIm0dv7EqJ?=
 =?us-ascii?Q?mAMByIrBmBaJ/NH6axcFmp3lUAFg3MNP/IBrcGmAYAh/o5jkU6GFr/S6+3rz?=
 =?us-ascii?Q?RimICIp+oU6i9aZ+y+uHuCHssf5uRdBZcRVBahdgKY1m66mMxPb2diTsQGXy?=
 =?us-ascii?Q?nsQATlv4i3Lh3KpfQ/m5VqKwHfgJvAWvz5aDQ+1ueYJdZSML9Yr8g8smbr/o?=
 =?us-ascii?Q?fHrUuh/1Ho8XVEyGFHJqnzAnGlS8kUn949pAPW7J4Rk7XJFRt9U+E2QVAkQF?=
 =?us-ascii?Q?l1gZl6kEpgouextAf3IMOcZMjSePFX22pi9rnbEvoaJCDebG5rxnUGr5xdxb?=
 =?us-ascii?Q?JSHCfiZUoe72pGQBb/7bDKiBdnM8joos8WtnWLsfgVTvoEWOkbc8m4fYF2ja?=
 =?us-ascii?Q?q6smTUekrUnY2l/zdsdFezFDRpdDn91aBHxJp3rfxVj1/E2JlR3fJ5p5AtVc?=
 =?us-ascii?Q?pQIW7ug3DDqWnDLSva3/HGSyXTZ/tlLJreylM1WPV/3Bw/9yyNPZa1aX4yxb?=
 =?us-ascii?Q?jJrTuGrK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af82b6a-149d-46bb-3a56-08d8b6c31f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:27:22.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FKkMUxUO9eDYeNLpbIvjDxXqV+rj13iiE2hQuMUGiG2qT/RU3rFzjb4Uy2mPt3N/SzEyaJd6FK9SWLdKcoE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5059
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 14:57, Chaitanya Kulkarni wrote:=0A=
> On 1/11/21 21:40, Damien Le Moal wrote:=0A=
>>>  	bio =3D nvmet_req_bio_get(req, NULL);=0A=
>>> -	bio_set_dev(bio, req->ns->bdev);=0A=
>>> -	bio->bi_iter.bi_sector =3D sect;=0A=
>>> -	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>>> +	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);=0A=
>> op is used only here I think. So is that variable really necessary ?=0A=
>>=0A=
> This is just my personal preference as without using op we will have to=
=0A=
> add a new line to a function call, I like to keep the function call in=0A=
> one line as much as I can.=0A=
=0A=
A new line in the code costs nothing. An unnecessary variable costs stack s=
pace...=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
