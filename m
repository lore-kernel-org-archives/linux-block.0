Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A0C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A420672
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kDMQ2VcU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RJnycS/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507A420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKXVj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:21:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4788 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLKXVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544570500; x=1576106500;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Jq1YyebjPcaISfItDQFgYQH4T61f58n/VN4c6bAKplI=;
  b=kDMQ2VcUNupRJrdv+9lPrqXHAXieDOPEF+IOxiQs8j3p1m0UBIMid6Uo
   wOMxY3JRAJexPM4+IjYpxVNabThvMJCkc+ERSS1yWzdAphvWX1HBvEhSX
   ZRXn9Khze+IK83ABFQKe1Je+FOF5ttJ7VtBOU9KxSGHaInd7LcAHV7aqp
   yKzJ/N3wJRM0cnvRFB5wFz9hv0ApdQBXROdi6Uj8dYElAeb7uuvkNEvfa
   MDsXCWrqnfo2cYz4aBK86Lvd31C4+ypl/YfVYoVeiXiUfCuOptd7qrAnI
   /3o0sdErWm4ALxgpU+VlmbyWF2nnL4E4aNRgH6RXNnveUDz3DERad7lti
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="98116079"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2018 07:21:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq1YyebjPcaISfItDQFgYQH4T61f58n/VN4c6bAKplI=;
 b=RJnycS/bz0VLvcHLCkivcM4+820amaK4XmomuWfO02ywsaHibxXW34GCRmI9mpFK7dBCulcietajGHo8SU6OdqyoKAGQLxF8KcvPId/gNacmC8xT6uIkJ3D6FbMawEwxGkqNNGX4ZShQz7eIokgkeubOu/b9E83gmxdWPgAPFn0=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5654.namprd04.prod.outlook.com (20.179.56.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 23:21:37 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 23:21:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
Thread-Topic: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
Thread-Index: AQHUkUo+tJKkBfZhpECElV5qbdGoRQ==
Date:   Tue, 11 Dec 2018 23:21:37 +0000
Message-ID: <BYAPR04MB5816D19ED64DE1EBF4B339E8E7A60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
 <35b326a9-e428-7195-06ea-fc6c5d201ef1@kernel.dk>
 <BYAPR04MB58169F997AEC920DE8E3D022E7A60@BYAPR04MB5816.namprd04.prod.outlook.com>
 <511098e4-47fb-cd00-51f7-9892077a5485@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5654;6:mNXuqeDEoSdinEyWVezpKg1XFoprFlQDT4pksrQ6Ia3e2YVYLUZmQAQz9lgzQyNTB7eY/9XZVsVf+6ciq/3jgcgWSy2LiMHolShqI2QsaRTHcyBKKZe1OkKoNXgy+GG0nEiJuy5NTDBSa6MlHn5k68oZk1qLTNFNWKNv0pyq3GDwcguQDwQUL69bAlx6sMasZxQtGdsjsGC98f5x689aAYSH5sAepgefJi1GOSfRK7ZVO5tgKAT6uB5WIBi7anHGlGNY3EPIFgcLSZQ0plVZj2nPg6lCVNvHYOYE+gV1Z+r3kHxVi5XTvijeBp/rrhuJxI+1MDQqX/htl88AijHKuMN4u0E7SoAeFLcAMkLM9NDReM/v6R24UlrQPxKcoMkyyRc0Y+RAetcAXOk992jA+rOoJATKEE5K1GAR5zd7hFBkeoXEJcOo5dFJPigFRUXNJJpkHYRubVJjTmOG78GCfQ==;5:TVS6+SBT4PUU3iOj0ghlSDkh9r5sL5BC/UweW3xMwD3Z8UrsGvlAyNSILL791lXzii3/dNaU1MFXVc6wzbOWwEmXcJ0RUX4tPqEv7CPex44F3JpTJmNejgjfoDRLOuJkRYOCqc0KLl8QxLTI+PQ9AsDe7aZDC/RuMhcUnSeEtlY=;7:lATsTuJEQZ+nYOsYu9kGeJnS6QJxxp1kM60VI938kPuW4iMIqFPASi9KMh9O330UkHBwPj5aI3q7DFcld7VGpqjg92NTlUXiqDBqYqBB0nMVItJuSdQnokkKLoGcqw0G+4GWd8Nin84uUxCUXo1REQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d3a145aa-4292-4f42-625b-08d65fbf6612
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5654;
x-ms-traffictypediagnostic: BYAPR04MB5654:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56542860AA57388963596238E7A60@BYAPR04MB5654.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB5654;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB5654;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(102836004)(6116002)(53936002)(3846002)(7696005)(478600001)(14444005)(256004)(76176011)(9686003)(72206003)(55016002)(93886005)(81166006)(106356001)(81156014)(105586002)(229853002)(186003)(6506007)(53546011)(7736002)(6436002)(8676002)(5660300001)(74316002)(66066001)(97736004)(2501003)(446003)(486006)(476003)(99286004)(14454004)(33656002)(8936002)(68736007)(305945005)(26005)(86362001)(6246003)(4326008)(110136005)(2906002)(71190400001)(25786009)(71200400001)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5654;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iVc35Y2TiHgVW7Fjt7zYEgqq+z01PO/FA0gX8/8TFjNdsuaiwziXXF2/kiiNt+6X1zC7oYUPX678zf8os4sAhFfoCQgpzZefPKX+s4l04x43VYDkWImOIe0PnnBrDHlAKwqaTkFHYP/fbnmulkLtPGWlbn/PmsowvXmcfg+zsFMHfoVzPU178oiFTsJRbdo3KZIEkIvu2AQuDuUqGb7uFhFIfnT6bt0Fir2l9x4IkzrO1OK6xR4HQSbKQdxTDHSECVaMdHdBfzeu0lqnMdqefrjA2TvJsepZ+W5lDy87o8xIsL5VrIAeASaLrfh5LFn+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a145aa-4292-4f42-625b-08d65fbf6612
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 23:21:37.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5654
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/12/12 8:19, Jens Axboe wrote:=0A=
> On 12/11/18 3:55 PM, Damien Le Moal wrote:=0A=
>> On 2018/12/11 22:44, Jens Axboe wrote:=0A=
>>> On 12/11/18 5:08 AM, Shin'ichiro Kawasaki wrote:=0A=
>>>> null_blk_zoned creation fails if the number of zones specified is equa=
l to or is=0A=
>>>> smaller than 64 due to a memory allocation failure in blk_alloc_zones(=
). With=0A=
>>>> such a small number of zones, the required memory size for all zones d=
escriptors=0A=
>>>> fits in a single page, and the page order for alloc_pages_node() is ze=
ro. Allow=0A=
>>>> this value in blk_alloc_zones() for the allocation to succeed.=0A=
>>>=0A=
>>> Looks good to me, this looks like 4.20 material.=0A=
>>=0A=
>> Yes, this is a fix for commit bf5054569653 "block: Introduce=0A=
>> blk_revalidate_disk_zones()" that was included in 4.20 merge window.=0A=
> =0A=
> If only the patch already had a Fixes tag!=0A=
=0A=
Yes, sorry about that. I told Shinichiro to not forget adding it.=0A=
=0A=
> Queued up for 4.20.=0A=
=0A=
Thank you.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
