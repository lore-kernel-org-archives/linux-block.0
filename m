Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CD9C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKHHkm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbiKHHkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:40:16 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67DB73;
        Mon,  7 Nov 2022 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893196; x=1699429196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mdf7vFNuz5n19xHmCGtVFzISRoMJ97rL3JZx5Hwp7SrqoAGH6XHemG+Q
   ekJv73FJ7LaJgqeCYo3Ear1C+iuMDa8msmKPz1buyI63GqqQkW9CihRNl
   FwPwFSvMR78OeJ/que+O0h6JhNQ2qcFzlhWALlmdrAiL5nPQeX+ZFn/U4
   9508q8p4gbZSDaVcKsUX6S9P7Ljz76icds3/RZ8vIi2f+mvbt5FUqyDsb
   ROaN57QtXozKLByEBFcTYewR3nxP4iDEKbCIsxu9IDb3o83YXG58snhND
   zNwmmo/CaDIPuVsuqCL3wj+DZjmTyUF+GGH+ZZIxr/6beN/eeE9M5/nFe
   w==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="215738620"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:39:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgxsTGupr0ppybvMab0qEwf5ZopL3dpSaMN4HXNA2TpCGhUHjp+1q/80/VHyZRTOJc/5gQFyTt+QzLMdNXqp+OF3xBOl6tQWSVLQPrEJOukMRZPwz5y0mpGmvSWBjdDsOOqDNCldOTae1nwqHUSfkIhUv8jaOwejzgCMeqNQSm0Vd2oz07yc9HeKx/u1x+KzxeNbnYTbzLT3AStGNK75yrwGSUubHZ+1C1qI8m5QRno6qF/FMcIQvSjwRF73+MaTInMnK1/dm8ZNjPDy3iUTqQWiMf6Nu6qCrh0fkEBbSvAli6yNNs2kCQinTNwSzVF8z29ueOeIG7Nqe6aFL74H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LXQx/OIuEZw4LkxoFCymNA3EFed+rAr7OulSKQr7X+vOpJ02QZrK6fvQMj8EhM/soNNO7hCb833/E4gOEYrXTAZL5Esuas7SpN/lGKLrzAb57lSNakmIQPm1sRfx37x9yUt3wB2UlW6wGld6yzZHSjWa9DPetHAP3PdNYksCzscLrhSvMmKbmj9Alw0PxoS7+d/HqaYpqOjM9Xs9XhlyAp5u0nldU5vhGasEIkz6yYPVNHuIzThYBc+QbDEYcbVYH2VRaZeg/i+uQ/hKy3aS748RFJ4RzneVLQj3P26091cEPXGghU4M1P4/7xdrq396ekn0BRxHxyR4DRuVBWX60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fu+lnO7XxEAtdwwo6zNyPfLvfVEj3dto7OLUBdnntPe0tgD20458IEv8lAqV4Q6+ryvSaEZFv+rWbgA7RNxy124wK/U6Ijh4s2Ye5s/gbl4DIG48d1PisVxVF9bupr27z+NL9iGLAYegxUztHPO7t/T4d3+seE+2wgd4sF7NXEs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6141.namprd04.prod.outlook.com (2603:10b6:208:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 07:39:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:39:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 3/7] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Thread-Topic: [PATCH v6 3/7] ata: libata: Rename and cleanup
 ata_rwcmd_protocol()
Thread-Index: AQHY8zbIYaL3ev5hBku6KXDSrkooaa40pCUA
Date:   Tue, 8 Nov 2022 07:39:53 +0000
Message-ID: <b019e37a-517a-6ca8-b475-242519cd7802@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6141:EE_
x-ms-office365-filtering-correlation-id: 6a8a7f4f-0366-4de2-da0e-08dac15c6cb2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfdU/p4LGzH+a45EfcaVqoY8DYJuB51CfvBFIX+u/ZYdxYpgZw2clENgGklDDngwNbH20tLoGKL9GMnIrmtya+RXBeIvTipIFna4kCQG12YDN7rQOPQGykh45/2rBtQcBnVHj2kEi6vMDZM9YzmiKYK4pjj5POlqHTq1AyuX6XdpbtATYpnL7MayIViTRJktN6MvC5wvnbXM31jBAL+M2WoAs6T2R7f4CPX/DYlTqJC6aiBpWpJbUz17OdFWDBG4/3RsoXc9wO+nz9YxZ7E5NTwYXqg0GZmvQsTELpehsK7KrUGIwVxHrKMw+TicTX4p5mBgma3i5Ft5whjt2HQwFxohdkdbdcInfBSrnmsoRzeuzTuzC9GZCqogouCEqBS2Qajs3SHth68gsdel70nxRkiSh8Nog9mn3ee/p55bws6xXtnstDM39GFFn5Q34hWo/be3qCUux9lhwPQOnn9J2xHjQANBRz+ohS5CsJJFM+B6b4PVlUBx2gr3KlrXXwqiAVZlOlDeJE2K4wFp5fnux5/yK9Vfkrx00J1HlWmgHG1wVuJfAOn31VOZj4S8QVtZOh4hXqm0n1TeBQrYfj5bobL0Wo4dPfrsCGpTCGL2TI7C+pY3HdD6wZkOP3F0c8ZJ0QG7X32qkF9SNqGEbsQyaag50mvjVaeUuD+cNskchj4WjevwlEn+1/RrT7JAJUAyhZjAIj1vOlJSYNHUvBHxabKhRsUD4FFo2O1Rv+p15yuLuhWqtfRp6wWIVU7bMWFeNni0VEJTx9K0TjDboC2lbjY2DNAdPViWRKraY8A8QE1kgbT79M8/sGo0Aj6CfsYbOSTKXg0pv8RiwRug0+/0eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(64756008)(91956017)(66946007)(316002)(8676002)(66476007)(66446008)(66556008)(71200400001)(4326008)(6486002)(110136005)(558084003)(54906003)(122000001)(19618925003)(2906002)(5660300002)(8936002)(38100700002)(76116006)(6506007)(2616005)(186003)(41300700001)(478600001)(4270600006)(6512007)(82960400001)(31696002)(86362001)(38070700005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWMxWmpnb1NDRmJlSG1yV2Zid1QxbmdjdFVNQlFTaXhjV0RmS2dqc1gvUzZp?=
 =?utf-8?B?aGNWWTdaWWc1RldMd2pxN1pwcTBOc2JHNys2eHJyckNxVDJUUEpCM3VHTnNU?=
 =?utf-8?B?ZEg5djhKL1pxV21pLzJ6MUp4Z1BHaHREL2pXYUo3TloxMjkzT0o2eTB6U2JN?=
 =?utf-8?B?VGpXQTlrdEVLN0ZtNkN3T0NPT2swd1dBZDFqYzJrQzBPRFpKd0wvNjlUZ0pa?=
 =?utf-8?B?WWQ4QW1SUlFYcHhyY241UzVQcFplaFdxTnkyUUpCdzZGSVczVUN1OE1NckR6?=
 =?utf-8?B?dE5HRTFYdGZLS2wyL1I4eU1wQ0FhZHN0cWVweW91USt1STZSV3ZVc1pNSUFj?=
 =?utf-8?B?MlpGcHFaQkxMRGdrY0l5aVZUVkhwRFdZV3UwWDNTU1BTeWpaN1V2RG9QZEZs?=
 =?utf-8?B?dnJhbWFRQnQ0ZDNhaTJYK2ZJOGRSbUdKWjdqZytkN2NnUXV5Y0h2dXJaRmhm?=
 =?utf-8?B?OFphNU5UZzhJSTJXRm1BWlg3amRmSFJFekVvNWFGTzVTUHA0M1cxbUVFc1gy?=
 =?utf-8?B?THpaVHByVWlqeFU4MlFZanp0ZGpQZ0k0ekdGa0hteS9IUnNRZTBXSGxpNng3?=
 =?utf-8?B?aDhWenc0TFhZSmdQVEwyRldhQ0FOSGxPczI0UjErTENrVEV2SFVWNWhZNkkr?=
 =?utf-8?B?ZUFTTDNoTlZYamlwNVBCYU5EbkkxVlFwOEM0a2FGZW5QY0g1SUpDaUswL1Iv?=
 =?utf-8?B?SWJiY1FIbjRkSHNvb3lnMkw5NDhpaVlxNGxQUVY4ejdzNmU3Ym9yQ1EvbU5S?=
 =?utf-8?B?M0Y0MFVaR2YzTld2SEt5R1BSaW9Kd2xlR2R5S3Zjb3ZHdlZocEFIQWU3OFp0?=
 =?utf-8?B?WklkL1NhdE1SakxlUXJuY0VLdXhiYTk3UEFJQXJvWktYb1NpMjRhWTRhTjdl?=
 =?utf-8?B?S3NJVS9ROCtMNjBFdW5UK1VVU0MyaTMrVDhmTW1UVmF3elZNTC8vcFZtRXo3?=
 =?utf-8?B?K1lXRm41cENnUklKZXYvK3U0QTFhOVBGLzcwc05XT05TUWtsaHY5UUdRQ3dB?=
 =?utf-8?B?d3lkUjF1MWVlanB4bmF3TGtKSHNnRVZNZWdxQ0JWV1l3ZXZ4NGFQZTA2WlM1?=
 =?utf-8?B?a2tPaXJiU2lmMEVpVWQyN2lsUzhxbDM4VnNPUzcyS0RJVEUvZjhQSXdXY0JK?=
 =?utf-8?B?TUd2WDZ0TWpPN1FNMlczQzJXYUZCcXJ3MlFWTUNzaE81a2tNV2IrbFQ3UE4v?=
 =?utf-8?B?UUdzY1dVQm81bXhjdUZ5VU05R3gvT0RUdERZZDZoUit4cDR2b3c0dWY5UmVG?=
 =?utf-8?B?Nm5iS3B1SklaNmVVNzJZQ0w5OWRPemlycjM3NjMwRit6VjZTdGovMUNML2No?=
 =?utf-8?B?aFFnMGxZQTI3S2lVY3A5TXJqYWJKeVBUZ0lpakdkMWtTWURYZ29idUpOU1lo?=
 =?utf-8?B?M2svS3hvSkJFSDBuYXdGWTJIWktyckQ0TWNUUVZYd3h5eWtmK1lnT1BFUXl0?=
 =?utf-8?B?NGpHMWZRMS9ac0lzYnFyVWlRUVdIOXJ4YmZKaUFBNWk0STlicktzVFIyR083?=
 =?utf-8?B?eUZrOWFQL2ordm05Ykx2d1UrTmwxSFBvNExFbWRYemgxSXNpU0xYTDJqSFQ5?=
 =?utf-8?B?eHQ3SUZqMFhKNmpNYzFGemtGNHp0VGtpNVNhMkREUnl5cDc4Tmt4aUw1cHJz?=
 =?utf-8?B?dUhZRisxNHoyaTZFb3RweElvYWJETHVYaFc0c1c2MG0zMk9PNnhVdWhSaGZI?=
 =?utf-8?B?cDRPdnZiR21xUnlLbGI3NmlVelR0djNtREdZdFg0Z3FUdXphc2xVdFhWam5Z?=
 =?utf-8?B?d1E2Y1BYVHo2TWFTY1F5VGJhMzRTNnFoZWlkdWpuOThxZDBheWRRcDNIN2V6?=
 =?utf-8?B?MHAyMEJPT00vVFNRc2FQV0FhMDV1Vnd0QVhyNjN6eVJKTkJVWTVBckJnU0Jj?=
 =?utf-8?B?QytJRmV6S2tCZStWNUU0ZGpjVmx1am5udkxwQ2pEdDJYb2FDZjJvTXZqT09Z?=
 =?utf-8?B?eTdyb3B1Y3VLUzFUTWRIejB6YUFxaVFGRU1XYldZNlVWbVNkQlRZYWdlT0U4?=
 =?utf-8?B?RHFsM25ZZHkyTCs2NHByVzZjNjREb3NmOWJUNWg1SVlHN3l0ejRGckhNNUQv?=
 =?utf-8?B?Ri83elkrR09FRkpFbHVJYXFsY2hQeC9Zc0ptWHluNDNFdTBVaVNKZ2J4eE1Y?=
 =?utf-8?B?SFp5YW95M1NlaG0wMWp3cUxhelNNcElSUUVPZ1hJMFAzZmEzWFZHdjVNUGFY?=
 =?utf-8?B?K05KT1AxaU1EcHQ1K0oxckFnSmdZSDVLenBUSmZzc1BRRzRGcDZ5OFRCcXJ3?=
 =?utf-8?B?eEpoamRINkYrRXJmeVRiSDl4M0hBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51597E7BAA662C4B8E92F9B2B531B98B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a7f4f-0366-4de2-da0e-08dac15c6cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:39:53.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRCs25LYYyunvTTgMuD8NyFIjkbCXe94ui+rvYySqad83TNDB6qz8q+lHnWgOq7DPiyjgL9wiY913QVuCej/WNzj117B3W2dNpJu5jWZ9hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
