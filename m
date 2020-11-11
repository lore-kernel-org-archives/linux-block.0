Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DF4C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD69206E3
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="dx6NzDY/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R34iSfgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKKITO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:19:14 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57373 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKITO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605083696; x=1636619696;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0bjRIfZ9+uNGyu7JOIwC/1SRCN3TRTRwwsycWdSxxWc=;
  b=dx6NzDY/HRNapJUriQoWtPga00D00ILPG8r22P22Rj2kvTZ7PPMLvl2J
   RqQu8AHDosBc5pZCEYYEMXXVlqU10Oy1QIoajQ30siHqJSxEvBViKlzmd
   NZxtmx5Hy5rFHQswuj42ktesWfMV41u2SnN4NUaPApQWWDJNXx1C1AcbH
   iu8eMODQcB3YMnHSqnO0sbteOyF58uwNtr0oT1m2ePy9+fuTVWJDmznJH
   hJe1TULJ2+TTW+wo4OM+7JiSl2ZFuKhbSJjKcS5d3HjrUHYoFjaJiK8tG
   jXOLnCx36Lex5iaSG+/idtfflpt8QGMrZis1MVpXDZno0oKhhQtBapapX
   g==;
IronPort-SDR: Ty3cHS/MGabry2nT1PYIBjTcnAL1cT8JrpgWu9M3nLpfHzJnirudjXG3Uq6P2Mp9scyrY1DQwf
 hBXyPu8I/EojDQlTTh2KSGpH5GnQncibEuHEDUbL6yEJ7c7qmkyTL/cQa0el8X2PwNkuWR2NIx
 paPFsdtj2dTqX7ydd1vZf7k7ktEGeJRXhjwXZ/PrhzieE3lGTz2GZreLcX1379WnORwv2vCQJu
 3i9tCPXAf+NOFpHcRmh5oL/uW7QqOYXDpp54yINY/IMwD2jwudh11jH4XBskPu7ztOZPSn6VkK
 ncc=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="255928216"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVUx/uTbaobB1JffrpJjsIUvBlSORT48r1ZAE1Kl116xvRFZg7ZY1Bwy1mPQryBPqDF6zS11DucX5Ebgln880KynkbUaRsxSeHVwADLdOh1BS8yffsG+51KgEaJVxM1ftonh6IY4WqHWQE3tMzGCjyrRVZ2R2IYiSge/PnRkKm2U38I2G8vb6EjtYHVJHjoq47Fn1MpiFluIuBd7E2SgVUpVUq+Y8az+4p07YiBL0xdavjuufyG/N9hTa2QIMIzNn1ggKRDkGfB58y1GbqLpIHiXi3ZBusmH7W/sUmZbGdcX7bumHwU7ryTvYZFJuD8RQKMQT6UB5MF1zVj1w/3YCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bjRIfZ9+uNGyu7JOIwC/1SRCN3TRTRwwsycWdSxxWc=;
 b=ld9LMIZoYn+Eh9RTjS6MblbQtIk2JphmFtzGPbqhh/MIe3QZyK5eGhDPJoZOOd7vCYOOIZqFI2+RmzCE1RuMxZEhaYNslLZri/Ch3RVRQPfqvApROjifYg10aPdHrtb2BCX6d21nMl48+350DoAdD3fXMeoaI/rv6IvYkccWRpOT6THGA/He59q1JyVLnDeuKHtYw5c7Gtpr4YyXEc4EcUYzTGf6HW1H5YN5y4rRau/Te0uPHYEwkAMBV5VzYttvDlU4NAh4ysLcYKt9A2HN5l1hTu271Nc/Q5KMMSKcEcJkV0tWUj3Dmg4A7YqIT7ETHexwgcCtkbZ+b5SdljfboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bjRIfZ9+uNGyu7JOIwC/1SRCN3TRTRwwsycWdSxxWc=;
 b=R34iSfgLDKKczAqlS3QT6ywjTVlArUhBgmZhD9Jipt3oIzhBomblxh9ICDi6jRkoqkBAez5Aht9ug2jGQjmp6aVHlRy/hB/AqwA6OnSwYLuR6kgIvqNk6HErZ69shRQsjkKHFvsuG7L2V8bzBk3oCCrV/d09S/O7T1fHeziYOQM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6351.namprd04.prod.outlook.com (2603:10b6:208:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 11 Nov
 2020 08:19:11 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 08:19:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/9] null_blk: Align max_hw_sectors to blocksize
Thread-Topic: [PATCH v2 3/9] null_blk: Align max_hw_sectors to blocksize
Thread-Index: AQHWt+njLNn7+/e0G0i+SerK8MoINA==
Date:   Wed, 11 Nov 2020 08:19:11 +0000
Message-ID: <BL0PR04MB651419B653696D936096D29EE7E80@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-4-damien.lemoal@wdc.com>
 <20201111080657.GC23360@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c005:87c5:ced7:ce31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5f26c49-4df5-4172-93ce-08d8861a77fc
x-ms-traffictypediagnostic: MN2PR04MB6351:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB6351147ACF09BC58D87095DCE7E80@MN2PR04MB6351.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLbVyHlTbM2zNJD60v9/F4OOI9YDxO2CR3AwVwr5WP2YnpnrvzpbBpgVp2UUYkfBSmUc8VcgZgyT1weiz3OGijjmC8ubqlzjxqXdlmsKajbsu8kev9gnb2QK/mnD3WbybER7XV7gaDfX9w89k+6B/N6pjLW0uMWX1QzAy4inqdj1c6G1jfPr+e8d01mrSh8gH/2OK9UWXYbCBMFh5uL57Hpaix7VJgg2GvrayZbBx0vJRoB4mJ9OfjyxmVSMH2ZY6YcxEHi6Lb/H/8iKSUE83KoLNmCzhyxCrhK++6vJlODpf6fjFKtRXdHwZP77K9fD5aQ7tDkxulfqNEnNtcbkkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(66446008)(9686003)(478600001)(6916009)(33656002)(53546011)(4326008)(54906003)(86362001)(316002)(52536014)(71200400001)(186003)(4744005)(5660300002)(91956017)(83380400001)(66946007)(64756008)(8936002)(66556008)(66476007)(8676002)(76116006)(55016002)(2906002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wCA422SHRhR5HUAINisyFUd9rpc6tc+70HkWU6Gn1JOQFZIsrSfsEPheN85PmmpPXZkRLSeZiErl6BVXDCBoZRWGfXFGrJbYtbN91cvF9mq4shxZgMBKSV82MiuWFBvvYukFzERbgyAkhyTqrE0IY9C0k2/ZkqBTtG/oUZoquzCufZysDHzh+REo2GS+v41mUt6H+W1961Xvu9sg15GWjQfu+3Xxu1MqnCne/vGBtEKrZthYj3Emyvf4UfHcPngzjMsaWxsyEVMkdYqgCESdMYdzEXXnwfLLFR7DpZIBSd8YDf7JuKtFnwKcbCPlPRhE+Ym17RGX6K6en9LpiXo+2effrX33nS771yqufXBsrHB7urkK7tDv2876k6pP2Spj0Cc2wxvkdpDAEydIQAwd3tGWdtzDyBHz1wvtlJ08Vs6MRKQehI2MGSpNeWWBQW1y6EpsJIFSfZEaROiyMpLfCD1UaiviG40XxRt3s8R+he032z+rcdrOgrS5TVvkpYa2cI2pAIMplr9yEHzcJh1sXi5dl+xQeeg0EmBTASOC/iDM8/hufnOk8pgTkOtqkXAbPXSprZyH/876ULyzziqoVZPlwBnTXKux18+0ufp0slbN36mp1dyfdej6euB0Hn8Hby/gto+TyhS8ALeMANmUXNFD0nknq+fmsCrMveP/1Ww9Nofa8TgjcO60YH8JIzk09NEmEtB766XiWcqX0dFjkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f26c49-4df5-4172-93ce-08d8861a77fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:19:11.2212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9X2+YFdO+3mgq+VCwN/MsTQv5B7WdVv0v4rxU9osCi28Uo+VWSfwCAETCskyceRYwd1AT9bHwAd4VrMYdkHdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6351
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/11 17:07, Christoph Hellwig wrote:=0A=
> On Wed, Nov 11, 2020 at 02:16:42PM +0900, Damien Le Moal wrote:=0A=
>> null_blk always uses the default BLK_SAFE_MAX_SECTORS value for the=0A=
>> max_hw_sectors and max_sectors queue limits resulting in a maximum=0A=
>> request size of 127 sectors. When the blocksize setting is larger than=
=0A=
>> the default 512B, this maximum request size is not aligned to the=0A=
>> block size. To emulate a real device more accurately, fix this by=0A=
>> setting the max_hw_sectors and max_sectors queue limits to a value=0A=
>> that is aligned to the block size.=0A=
> =0A=
> Shouldn't we fix this in the block layer instead of individual drivers?=
=0A=
> =0A=
=0A=
Yes, I wondered about that too. Probably a good idea to have that generic b=
ut=0A=
that will require changing both blk_queue_logical_block_size() and=0A=
blk_queue_max_hw_sectors() since drivers may call these in different order.=
=0A=
=0A=
Jens, thoughts ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
