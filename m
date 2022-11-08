Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83420C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiKHHpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiKHHpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:45:19 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C850EEE18;
        Mon,  7 Nov 2022 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893518; x=1699429518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AtJY+Fm9+xXzsD1wm42GsC/Z2RVjfMI/fUh1nTtFP8jDV+uP3CCTcatK
   kwI7UA0MxLDyvK1aBFm6cZuC1w4SIXzCwUn79LNn/v3s2MDX4WyFfrJot
   kCcL8IkYl7Z4q7wuYZ/eq2CriPXYH9G3tshY9mslunlA045gylK84/QZW
   BMOoKZXyQQHyk31aKhC9eWDrNTqAaQ24pEvBJRp5jcyVjZGdQVGikbV0X
   tjml8CqVZu9DsLLDAhsC5yTkuzCLRp3PxW5SFDfhUmtEN2OT9m2bjiXus
   BvgAQDmT+Gt1pJNWCS1ji62tZUu2U/JOrZDQh/S1rfWfQnvJFRoAN3bhz
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="327838765"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:45:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCB1j8ccq+/pcqluFX3hHxG9y5EU5oZR0HvL4U7lziOLnY3KcqE7NK1o1lcWnQkhm34IpLnX9xyiLYb+EMOuTi9eBlhOTDWLFMgKtdx5Ma1c9usGfXJbsw155DbjTqWN4nv63sPblJZqQBmj+pY8BRGKcRfi9yQZZY80gWxELfK+wEMfZzaO9I5Vl1M6k4o8JnxloOAa8PkZD+saZdngGGq9etvn5ZDBQ4O2ASf2u5plo6kdXOOTp9/AC7pFPd6IOmqF5ehGDoFDVAsOLmuA7CG8UZ02kJW01gv1qqv9ggSFK2r5pn1BhC11zoXsxVnpZxF+iaeioO/xh0ZPcwyTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iNfZt83WJCtvIl/eiBFprHyg65xJzeIB9l/0fwvPDWOfBBx+9VVgZ8RpOt9TY9RAIllLzMYoWoHxvzb3M+tkYUyOMYT+EcW6hY3I8f3j2G5AvDU/Kd6ozQyWhkOmJ5y/H9291cltC6uMMdoPy1yfJjSPAapLrV+MpiAMm9bEw9FPuI4naXpdsrjbgnzVXIfNkZiGYnDnHM9iDP12bL5GK+3kqJW8HkP2+e9/5OandOnzd22Cc+lM61/w3gX2Q8T1Pj+zrPC7nOu/vxF7aLCC9b1T1IOCEoB+gIz/LqMEjAyxiTGeoUegaqwy9ECeS7h336J0mIocRWQ7YSYrVkjYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DKlt1AxoS5p4f0Bu0H0PqHbceIUUuWHxoke+stcf+LwQKPaeHglJXLu8hcLcnSySQJy7qoIPTQi6LlF0hr7ugtQY/SrWQYvSP2HqAkTbO/Tz5b29wMtbfrj/934j8NobtGL5Lj770e8KrlqhZoMJmVPdZ6riggluy9mIsnxQ2lg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0277.namprd04.prod.outlook.com (2603:10b6:404:1a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:45:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:45:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Topic: [PATCH v6 7/7] ata: libata: Enable fua support by default
Thread-Index: AQHY8zbm2wwdBiPaWEGTh1OgtZzLma40paUA
Date:   Tue, 8 Nov 2022 07:45:15 +0000
Message-ID: <39dd1f73-4f3e-c8bf-fd3e-5ad7a7880b28@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
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
x-ms-office365-filtering-correlation-id: 8c8a96bf-1761-40ca-464d-08dac15d2c95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkyPB+YDOZLVLDE6Yb3jIfMhOqdH8vMBx0x/dzk+0uXv0Tp8PhfqYKAtg5G/dq0w2B4eMiDn7T+XwHC+IMD70c8arwgBzZOXczOJVMRE8AkGF3/iKfyCC7IvTB4bFQAuNHVq6FW38thKgq0MSOtyX+hxVwRAlgFJdqnCB587Mv7LPG0EL/9rxskd42jPVF8baW1QYHLWhpwCUPYFUVCd1SPK97uspL0WNTiQSI+mPfXemrkaZCLsa/hsXYTWRAaxPfyd46qnGqM24GxSV2khD6A0ouUKl/h6lo4yDHeV/iEYKw90tKtQSbkoJvaVtBGT1jeLHJQvGPigYtHA7J8DPEFFxtwUBl9bfiGM7Y9pP1GYa2QCIyjvBp27Ublp8JGC9lyN+1QL1kFcTykxWg8+OWmUVMPP3y4PUiaq0tjXy3m18wIkowYOfjG3/jjaCw9neqL7xqrhPcRzEnfRx9Jwf2GQzqvtJZ7wuAhUcsMxUqQlI94/p63GCj0PLtPDsVtp019ktAjyGKTqjd3QyC7fW/MMNtrUBJOaETZrWa9FMP6tWZR8sBOD7IdWRBTWacCy1NB4LtKLwYFrXtfbcKgj9XMTG75/aYyCmq8OxJEyMhpEzQa0PfNugwD/BL/ec6H5g7bZA34KorGN8VDkewgp/bXSvpVSpe0xc2uEsf1IdmNJwrNhFApNSJUmpzpNP17uCwK9SAwds29GKjUe3+IsmldHftuyeyLuo/iS7b+NuenQnkgkRQ6ogs7yC6BnkmFomCG9xfwxt/Gp+BDMeyGi5pO4523nlmBGaYMeQs0t9X5GGW0RFcRnjsjC7MDBsebp9LVQUMLktZtrxpjZglKmSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(558084003)(110136005)(316002)(2616005)(54906003)(4326008)(4270600006)(8936002)(5660300002)(41300700001)(91956017)(6506007)(66556008)(186003)(66946007)(36756003)(8676002)(64756008)(66476007)(76116006)(66446008)(122000001)(82960400001)(38070700005)(38100700002)(2906002)(19618925003)(6512007)(86362001)(31696002)(6486002)(31686004)(478600001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW9sMmI2Z0ZrbTZON01rK0pidlA1czQzcm0zWGMxdVhseE9hc0VmVU9vL2Vn?=
 =?utf-8?B?clNQTUhicmZ6ZFo2dGVyUElxdUpuVE50V2tHNlVUeHRVdnhrOUorbDRaVUdY?=
 =?utf-8?B?U0d4QUxkb1hxdFRNMmhGc1FHMXd2MEpPWEtVZlFaOHgyQ3U4L0h3azE3RWU0?=
 =?utf-8?B?RU1nMGxkeElGL2FBVU5wMXpmOXZmWHR4SFo4WW1oQ2tYbm5BTVZFNFdzNkF4?=
 =?utf-8?B?MEk3aE1KTEhZcEROY3ZZa1dhVUlHRkZ0MnNmU3RPME9FcFNVUnBEWTVtRjYw?=
 =?utf-8?B?SlhLMjFZMTRibmVweWpSQysvQ2QzcTIwVU5OWkZ2d2dJVkk5K0p1bzVKUFBQ?=
 =?utf-8?B?MkwxdVc0L3NtMlF1cTI3blhPcUlWcXFPNVNMeXpOQnB5dW5IMnlkVTBSc0VE?=
 =?utf-8?B?TFBjQ2twVHUxZUVmVDJoczluQ1RlYUFpSkdvK2RKL3FrTFphcmN2OUc3RFla?=
 =?utf-8?B?R2NESTRoVFYzVUg3UmorYWdhVSsybXNjZUZjY3dhS0FmOE1UaGdzTmM4V2oy?=
 =?utf-8?B?SUZVUWZCcGJ2MVRNaFNJSzZOaDlydTBpY01kZDlqSWtkU2hKUFo0Wm9ZUHp3?=
 =?utf-8?B?aS9zZW5VVFlOT1NjeWVaaWZUVFQ0WVRCMnNwcmlPblNUS0YrQkJ4WkEycVFS?=
 =?utf-8?B?N0VjTHZ5c1pySFkwRVBEeVdJUFRpTWxBQ0FOY3hzZE5icCttMDJ3M1hqY3lq?=
 =?utf-8?B?V2lEQzVCQ0ZIb25DY0xpMFFtTzhWWDRFcWxvYUNMK3RER3NTYTg2M1QvYlFu?=
 =?utf-8?B?Y0NZZlJleC9iQzFMdldKWFhmcmtSN0JOY1FRZHFhMmc5SDVEVFpqR1VnSEY1?=
 =?utf-8?B?eXI0elNON2laSFUyK3lWc3R3dGJvNXVrM1Bac2N1bTNNV2twZ0VkOEtUZzNW?=
 =?utf-8?B?YVAyM0lweTk1ZnpTQ0gwY25Ra0JxbHZweGRaRllVT0FSNStmOVcrSG55QnVN?=
 =?utf-8?B?WWY1Q3hXZ29IMG9qcEN0TjdYa0ExdWIxZGREcjlIeGd4NnBIeWRZaS9WbGFR?=
 =?utf-8?B?RjF6a3I3K3VWZTlXQzdxY1RJL0xjZUc2MWNzTmlpbDRSUjh6emY1MzFmQ2dW?=
 =?utf-8?B?TTVRdG4xT1pESVZab2duak1VNm1RUVh6dHZzbFhRQmxPWnA1THI0ZTlFaDQ4?=
 =?utf-8?B?OVVoWXRJYlJ5UTJHRFJpNEpUdjdSM0N4V2VBSHN5T25uaFozS1p1Y29uRFBM?=
 =?utf-8?B?SE1qM1BMUEEzNVYwZ251cks4VE8rTUc4WktpVUZHWGplcVo3UUEwcW1uMmhF?=
 =?utf-8?B?OW5MdUR2Z3FsRS9aUDFTZUNJNUpUc0R0andzTGQrZUcyWFdvaURpeDNPMTJ1?=
 =?utf-8?B?bGpNVUtzdVVhOHRGU0dmZ3lsd0lJYmVPOTg2OWljSjZlZW0yK3BZT01IZXB6?=
 =?utf-8?B?RldlclpJTnBPaXVDOFA5TFJxOThBN2laRU9id0JGbHliU2tvMjNaZjNXTnNR?=
 =?utf-8?B?SGUxZnNzZzZBUU9WMU5xNTNRN013eGtNR2loMTJVUFRhRVN6d085Um9YaFFD?=
 =?utf-8?B?QzMrUlBoTUFCNTVwbmJwRndiZ1dKRG1wYlZHYXZreUlWdjJjMHErdWRPWWdU?=
 =?utf-8?B?dzVQVk5PdUxaQm1EeVdyaXR1NWJWYkJHdXZZZ2RBVmp2RW5LcEpCVFZoUlNF?=
 =?utf-8?B?TzFUbkgvZFdsTGFrbWNUeC84aXNDSzk2SWFyNnk0SVRCamdKZTRVclJnL0hX?=
 =?utf-8?B?QTFzNTJ2R05NcDFmQ1BIVTBIVGt4TmpGd2tLZkNWcmJtN09hQWhMem1DQmdU?=
 =?utf-8?B?TEI4UEJ2eUl4aS85c3pOQkxmOWtnNkxRdWdaclBLNDBBUnRCTkpxZFJvVXNa?=
 =?utf-8?B?UzYrVlIwQVJYTjBrNEdaV0VycUVKZW5uUlVscllMdnhuWDlabENHZFBrRXB2?=
 =?utf-8?B?T3cycThhM1oyQ3F4TytLczE3ZXVtWFlSVzBhUi9GYWxqaEg0YlU5c2t2Ti9B?=
 =?utf-8?B?RS9zcVVJMUVtVCs0bzRrcXZFQ3FkSjdCemlnTVBaRXNweXNpU000VDRjYmZ1?=
 =?utf-8?B?S1IvMU9SelpqNVk1TXA2NjRtZFZvck15S1BxWVd5M25EYS9qQ2tsQ0tzc2cy?=
 =?utf-8?B?bm5ScTNocFRFbHFjR2Z5RnZVQTZ3T29pZ2V3NXZpNGtsOCt6a3VmaU1BVjRE?=
 =?utf-8?B?STV5Z2xpUzI5aTdhTkF1bndpVldLYUxhOVFVcnU4L0VDTHVlWEIyMzl2K0hw?=
 =?utf-8?B?eSs4RHFXMURnSUR0WHZBbUNWMk14ZE5TTVFXK3JHSjBxbEs3RHVQbGhCL3NE?=
 =?utf-8?B?S21XNzBWTmp0cFNjMWhUTmZRM0J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91FDBE33ED9984FA929BBF9CA5B13FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8a96bf-1761-40ca-464d-08dac15d2c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:45:15.0289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhCXN97N48zlqPFXU67Atq2LWz5p2M0m2k/hBU4+KEVYyzB/uZsb68GbA9wSUADVuQewtT+IF1Jy5GCKt31A6mMEmf+si5/Uk7oiHuGjmnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0277
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
