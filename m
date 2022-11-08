Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CDBC433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiKHHpC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiKHHok (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:44:40 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C2120A8;
        Mon,  7 Nov 2022 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893447; x=1699429447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=dut0Ok4zqAUyDvTHdEflxfkoIvr7o/moHlWkoSImvnxnmRMp04/5qu3M
   3Zc4aQop3Xs8qAtqlbn28sbFzfxg4ez7JYJvPpHwy5hdZpAjGmeDQE/y0
   iu9yrk4G4GzUz52AAMyH/v3cR/HTtvQjkKpQv4JMHGcmMIBUqNDT7XgHO
   c23joii0oCOx0ykElkWmPs3TZWhOnV7w285j1fB/j5E6oyJ6wWIT0htD1
   LivNgZNwzmoGPj4erygyt/WMyONrjKV3A9lWE5/qn6zJtJ20At5/4bNEH
   k0LQ2pqRCpVZWWGkIfU9kCb7FXBmINPuEuKqdwmsBYhZiiBzhhH8e77DD
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="220896885"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:44:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/RUnsQU+2noJIFQW3WgTBsEoU8xEJkaunCLugH3FTgx2PGLWqDsMX8RyMVxqgvnxxp6E8WebiJdbr2+ukYp5W726l8Z7PX9mMOhwS9gGxPpoR7LDencn2FrydTX+OnMOnooLDs/MeR4+TO0+jf3Rq9NQEehP2fkvIvc2EFT7/FXTlYPfyiimGhrdKuFLPsV2IZvdxGijPes4te9z4m8NWMO8SfLslxgrzJyULjJcMkU+WDUa+PD7PtQzNFELbXSO3BH9nsSzvaBzOP2R8r/CFNtkn41YQVyOsOfm6c7OCn/QnqZFoMiizth1XL7NBB3f42RAu6LRqYrHpeXvlwDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VysfCHYhx+5ZRYLcGIDfILAJmItt0Us/MpVwGSnrTu6R2wZstznDC7ITfrDehSN4onssX2UrA6rJu6k+pKXye8uXrPqllpN1q3kMbpli9Z4N5MxqBjZERTiLOChB6zEbzChJh8d8KcI17naP+PeCdDrRKUbjwsQjsbBlTn4pgx62hk1NrOT/IoKjkvuoLRm4jaIMIelVBYT0B+Qr0dp9Jixr6P8x6KffmPerUejPcGYKkHjZ6D+s4VIZQYg+xgD7EsGH45ILxsLzUT1C1ME00DElwsgiJf6w8Bc9CQIz+0mOHNXVrA4/wv+if/qiJZxVjEBWJ7aykhHaV2qRfll2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=d9Po4HGPex1l3tv5Z0t1dyZt4z6IEKrCKs23nM7GJ8kPdCSf/ZYODffFOmGEbNeQ7JIrdFO9o418UrJm6MgeugKHr4ihAMHtiruOzr1d8CPc7Soks1R9FbphjnzLj8RlrWyuQg1ih0wCWII00xz5q+nOcQIrkD5TW7+kL5CjjM0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0277.namprd04.prod.outlook.com (2603:10b6:404:1a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:44:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:44:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Thread-Topic: [PATCH v6 5/7] ata: libata: Fix FUA handling in
 ata_build_rw_tf()
Thread-Index: AQHY8zbKxQusseJmOk24hYSQpIa2uK40pU8A
Date:   Tue, 8 Nov 2022 07:44:02 +0000
Message-ID: <7a271f28-17bb-efde-fe50-9c3a8604cdfb@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0277:EE_
x-ms-office365-filtering-correlation-id: b3a6e365-301c-4736-2ebf-08dac15d018e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbiL2BFZefhfsxkVYl3dGPvl4Hlh7lxd31fCzcmezfBScfQc+fUsGXESrhCQ8jVBr24hoHSLbopUdBoa5EUEywxCoC87PirSvNeb+8rG2aGC2Zai7OoCvw+sVariQRCQqxqXFTRhmxj22G1M8MXpo+Sm0hy2Bs+8AtWLFlTFSNJIOC/LbBYPzJ5Fxowqd3jeRauIx17OSBd2TZ94yl8WQqI4ez4G5kHclkas6VXI3qnpe3j3V/tIjzi+QcDz1GG4whzWtw4mUOYx9eDNIXIR4hd0d7IPtjtjcAC09ulAZEtyCjIewWDrtW57yNh9wXrhPPta2+DUDxCLyTQMIYr7RljzGWqMBnerTtrn5kg56SDBTFWdxhl6kEFlo8pBOjWH3OKmdVVzWBKbkdQC4zerMSwUNFlrh62SRChhqEBBE8JY74/4aGHH+5U5U3aJcYr74UbL4BINYLBT3kr0eMjyXEv2dGdnMK5Vb8M9WciMrEqq+i6ATttMRVpc29Tb0Mymcqy4NBAu1wQ7CDGvTpVU1CenTnUcpNSobtg0U0TaAiq0X1fGfHHocFPTuS7x7pi8/ij8bePKy+dk68NPcCNrCoEhmaqFUlKSHTTDrcsIoTV9hsqsVdIXAbSaZ+krf/vktldEJZbonw9EkkJ4M5H17j8V8ss1OzHLVRDGCk4/ZjvWvsWll8QRUpaluq9H2RkdJrTny2txtFbzZuLJ6oIZKZzrP9c16OrjMn1+gPx2RiYsoqH7oe7fFl+uNz3lfevK4M39XKayS0SqVN//11GacktSwtB2CkTqXQQOCu7RTHb57BiGPO0JxbohkS+dqwSYb8ilYadsRyxdNX3gsDdVOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(558084003)(110136005)(316002)(2616005)(54906003)(4326008)(4270600006)(8936002)(5660300002)(41300700001)(91956017)(6506007)(66556008)(186003)(66946007)(36756003)(8676002)(64756008)(66476007)(76116006)(66446008)(122000001)(82960400001)(38070700005)(38100700002)(2906002)(19618925003)(6512007)(86362001)(31696002)(6486002)(31686004)(478600001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFd5b0kwK0dsdFl4WExlS1NHTEZ4dUNrcVhDVm5mRFoyR2tnNWxhY2JlQkVV?=
 =?utf-8?B?c0l5YjVmSEdJZU9zL1QrcVRmSTllMll5WnU5OTcway9odVBmYndCbzN5UGwr?=
 =?utf-8?B?cE1HbFY0TUhXcG41cWFXUjY5SFBXdlJPOVVyR0VtbVNlM3BIanpseVBHd1B0?=
 =?utf-8?B?QnFWbGZlbXRSbWVpUlRyeEJoM2d4MHNuak5ZS3BMc3EvQUR2cjBMeXZCanFD?=
 =?utf-8?B?eUVMN3NuTEhLK1N4RndwQTlKbmtKcnhOeXBEQWhvclUyTVN1MXJOVEhOOUJT?=
 =?utf-8?B?Sk5Ucno3TmdaVnNKYytFcW9aL3VMSHF2Qmszd1k1cVhTZW0yMkVIN3hiajBz?=
 =?utf-8?B?dWwxcVcxTE5JZitrOVMzRjV5RlczbnJCSDhUYTU3ekNRTXJCYmdkaDROY2gy?=
 =?utf-8?B?NDJPZzdJRmd6ZDNSZVJ2SlYvQksrdHRZSVQ4dUFiY3FRenl4SVQ1ZFJpVVVC?=
 =?utf-8?B?OXE0U3c2aDYyNGwyUTlyWmJVT3Z3aHB2b1RRNUJ6bjBaVWppSUFjL25TUXhI?=
 =?utf-8?B?WXBUWjlmOXVRMXMxMndnTkJLUWxxNXhlWUVYUGE0UWtDTWIvYzVFWG1JUTFT?=
 =?utf-8?B?MHNueGNwaTRob1dSZXd4UEQ2bUl4eVUvckRVZlAyeVl6YjlYZjJ3ZlZzZXNS?=
 =?utf-8?B?Z3VIcG4vR0swV25XWE5ISlR1S1VpV1pTaGExdkFZSW1HTFZSZ2pxQjkxbmFP?=
 =?utf-8?B?aFBMZGF2aFhRUXpHbW9MNmxISEo1bTgzNTBCSHkweE50Z2c0OUFlamo1RlVB?=
 =?utf-8?B?UWFxMyt2WW9IeUpHNWJuUHBuVG5pSnIwcDREclRDdnZ5WHI5RHoyYUVHQTIw?=
 =?utf-8?B?Rm9zR3ZnczNJbGJsaGFrUjV5NTNjV2oza1krQUF1cU9rQWhsRGF0VFphUlJP?=
 =?utf-8?B?WmZCYTFYU2JWZmlWMzd5UlJJcnFSb0ZGcUZ5RlU3NkdpdTl1Z2liTGgwajk4?=
 =?utf-8?B?VlZwb2c1Y25rNVpkbDFYQW5laEJoSUl4VThaVjRQZ0JPZithbjZ1S0oyV2I3?=
 =?utf-8?B?U2ZvWEdKR0RCdit6MjNlaFdmcGN3UGFDZ2FVemhESkx0bGZBU2V1c29IVkJz?=
 =?utf-8?B?UEd4V1F2T09IUVo0b08vNXpTM2MveW5rTFNxUitMbTFLc00wUUQ1bTdRcERq?=
 =?utf-8?B?dkV1a1FCVlBMMDJoZWc4bFNqdkJRS1FsRDRMNDZRSTZtdjdtci8zZWJEVDMy?=
 =?utf-8?B?dVlwempveVUxNE5SdVI3ZSt0T1JoKzdZeFBObStkN1gwak1BQ2xPbW9UNEpM?=
 =?utf-8?B?VFJEVTI5dDBNalIzVkQ0MnZsMkRlNk05VlZzK21FNnJCWGNSNnlXN25jUm5N?=
 =?utf-8?B?K1ZMR2tFTXg1WUIvUEJLZWphb1ZtRWh4N1VodFZ5c3p1TGUwZDJJcHZ1WkN4?=
 =?utf-8?B?Vzg2UXltaExTYTI5UTlXUDRqM1BJeDF5Tk9vNzZFR1U1dUwvSzhmTUs4bGRU?=
 =?utf-8?B?RVg0d2dJZm9iMnorN01RMVlwRWQyVHpLd1Awc2NVUk1hWkpaRjJGbnNIUVhB?=
 =?utf-8?B?ZmM0akowWEtTdnF6d3kwSUs1aDQyKzgrOWVaaDlNOWV6VkF1UDc1RUdaS3dN?=
 =?utf-8?B?ZTlGNGM3ZmdpdmxGQ1JsV2lZdHkrcWhNUCtxUlk0YnBPMDNPNHFlQjJDSS8w?=
 =?utf-8?B?S1RVZ1RGUzFwb0JLdE9TYWdVU1N3Y0FRaGUzQ05RZVFldHVPN0NTb0xsM3Bi?=
 =?utf-8?B?WHRTWmpUOG95dW5GMjZBRU1iWUJESlhsVHMwaFp1RzFoTmxFYlNMajBTdXcr?=
 =?utf-8?B?ZTh0WlhhOU5IaTN5ZVRZTFhhakI0K1RVMmRUM2IyUWhQczFnenNoQlBCSmRW?=
 =?utf-8?B?N0ZadU9TcGYzbzllNXpRKzZUSGc0ekdhN2l1b1cwV3V1aXpEUWgyQm1FcVUy?=
 =?utf-8?B?b0xkYTVIaUlGK2VKNnBJTVo3SkxybTZnYXRaUGNIVFVYeHNiL1h4a1lzYU9p?=
 =?utf-8?B?SjdORm5yVy9kYmRNMFNpSjVTeEgzRG5EZkRnbXBCdURwcU01NWo5SWc2SExp?=
 =?utf-8?B?Yi9Od0xuWE5tREF4R1k5MGs3SDNOVTA4bFpYQXIxVEh3SWpYR09kZ2wrZ3pQ?=
 =?utf-8?B?bnFIYjcyNllKTmdBNVZtaEhVR3RidzVCVXpCZk0wN1RmckJ2NXY1N0JvMTZT?=
 =?utf-8?B?ZGJXU2tCN0U3S1RnVzMvdms3TUgwYW5kSHh0MDFtY0xONG43cE5leCs0Tlhj?=
 =?utf-8?B?VXBkb05zOW1mVzV1MFlFaXd5Vk95MUlXU1FvQTJmSFY1WW82N3Y0QXkyaUxC?=
 =?utf-8?B?RnJtdksxeC96Q3pZUjVHMkJ3SmRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E7947BAA7E3DF4ABBDB74CDDE2E3A27@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a6e365-301c-4736-2ebf-08dac15d018e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:44:02.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O0a6suQd7FWtgvKbdwnEV/qT1iR3mF/m0d9lSdzm/V3AV3yvjvRnC5FJFTOLv5jiQKiwlR/+2XDGCHQpQp4YV60Q1obXdA9lov7T1KulwxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0277
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
