Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4150CC4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiKHHkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiKHHjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:39:44 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A8220D2;
        Mon,  7 Nov 2022 23:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893118; x=1699429118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=D6qZuzKW3pthR4yWddHxWpqZH6Gsq2iufdmjKsRrDup9XW3dPySugUr6
   cC6fa9pJSQ8XksEBzKSepF+Y9jKNqUztaJ0NrWRcqXLDyPqc8t38ZsYfg
   n/1zPsqGLarjearc96FR3Ad/oVHsmF6r3/IHzeO9AiwuFefkE0doeFDx3
   edxdVLPuvd7xuwJfpwbAL44cvWm66K1WOGm2Rueue1hP5itd0SyvRsl7E
   id5QUOEyv6vjyCMJq8AC/voahqwPc8W9FV/Ssmq2dr/PIDXAZw31NBz1/
   4WslZrWAWChSGHDmjTlJ+U+mFr5ePi5Hma6V6y5PgcjDJVClWy7sE5sKI
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="327838320"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:38:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjEmaQbdBdA4Nwg7TDp7lPcI+tU8yEzWjmoXdRrnmn2gcu9Jz7eIzkQ3zY5w1SR2r5gicviZ6s+KjIQCcUEcb7qXGlCpIAFUWfYn1RtZ/oUikPq+sVuV2wfOJBj7bCadW65IXuS0dsnTSPxJ5rAhZUjZR0hmiDjOHS005i9scsOJoM6Y+8s40KQX05XxVOrzrc5cVcUp3/krIkPktTUefBcbVrNRqgjNAds2HXzrtjO0yq2blA1rdwwq9TiEVO0RUIvesfOvqz412r8vlwNim5ZylrtyWr/zGcp7XPiaINPYE4JLCyzsMFv29qQ2zetZONc8C2FB1OUjkGzeFfXgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XbKFL8MfxgphjZd9eM9fbmmr5bdlW+Q8jkqpcE79j4G1HLP9Q5QpUB+0Xv59BfZNGxIPz7g1Z6EgSpm1omKdV0oW2vUrYIrUnZULQ8BssxT/5OLkCvgViDseyo3VygLbng/voVfWMMt1+Euks9sIOniL+DYOzwTywXVRz6SfdNZM6/qwZtyvRoy33KCmR/45eP13VcFHEWwQvikzUOVpZgejDi+v3qU680wXAtCGO1lEi/GjCcY5jRAuUdrsmSSNpzEUDDp9IKMA4vbPHzLo0Jj6jkFaWHTFyuAl5zGTlJZsxVXk/brAOx/gP2mEJv8p9oeg/1Ldc55b4Jor1vDl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=V/nwSsEBpPggHXShwxP49ptim/RVSDo2d9xrqeghTQPQtvJKC8V9Mcp/0IVCPpLbaEcBNGdSvCeJwFo3GIRcIuWeBLZdo/7qt5Nk9RMp2RERbkr0AP6iR1Mu1l1AAro32KpW7W8NB9g1FBsP5JqVL5eHrg5ivEUnVtTGDZXTYAo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6141.namprd04.prod.outlook.com (2603:10b6:208:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 07:38:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:38:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/7] ata: libata: Introduce ata_ncq_supported()
Thread-Topic: [PATCH v6 2/7] ata: libata: Introduce ata_ncq_supported()
Thread-Index: AQHY8zbIL+10Ljwex0G7RRMYN72Smq40o7oA
Date:   Tue, 8 Nov 2022 07:38:22 +0000
Message-ID: <faf0406a-66e9-03ab-9fa5-4403047663ad@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-3-damien.lemoal@opensource.wdc.com>
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
x-ms-office365-filtering-correlation-id: 18117ae4-0611-4b70-1f66-08dac15c36dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpuJpANvQBqIWXzKr4vKxLAZQu5OfjQBjvU9Dms2HrLVvLHyB0OUbAffU+8oOhbUxet6fvoMN+Rj0vNLLadBXUpCM224pc21Q9w0aQytQ9C48DIIHJRK70dQZnmc1Q/O3YZDkFyKmqckfagK8k3SNSuPJVmE6L+LGeTtMZa9C5klIsdyt5iK7gfGhU13aCHSADiI3qGzGsW2RtFqw+sYoEdBcYj3dp6w7gIjhMTUPwXMOMU+85rHoaxprzsIYm4EYqYKNyQZoLPlIL0BGJWJUUtBQjMRSnrsqiQBwTQhSbxI1YBdh5vMd7c5UOiy8bfToJMJMbkE47+ir6p1/ApXiDUqDI36pywV5xj0Rsq9AI8aq2B+scMyB3Z5LoAL0YE59Jreisv36RSSBrdLB4ke5FDYgimV4Srhx406Wvwt7pKWOxsedw7r6NGV28MbZusfkadzO2QtvaXnbjXb80SJ5+Vl3SIOcsU8XZ/OTM5g81UxmBzBcLwCmWIDwhfjdc4hZSGKdJQ8IfuhUAsXC2auBIOhqSUH32IAh/IlOTAJgq10sJkFCeg0yKeTuHKlSokBkiH80z5EulJeZAXORbw+SuoOi38QsDWqwk6C8cV/XYR+fUxm+boWDukAHAFXmedq3Dxmg1JYgCEVxl0VwIUKvDHptP2nE4lUILoikHJ2KWNC1OCJJYHDTxsa/TDfK/Gxa+f9evT4+Ox7HmRY1CtQC3wdQA7vJ/ckqckatfgOdYMxtW9tiC/G4LhaW+wndjh12kqq+1IlINohffLCCAjZ++UieFpnyyhx1p00092qdTNBXpg/PLg3hVNuxtg5Yg6B0EO/HKJrAYIA2M52KN8cAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(64756008)(91956017)(66946007)(316002)(8676002)(66476007)(66446008)(66556008)(71200400001)(4326008)(6486002)(110136005)(558084003)(54906003)(122000001)(19618925003)(2906002)(5660300002)(8936002)(38100700002)(76116006)(6506007)(2616005)(186003)(41300700001)(478600001)(4270600006)(6512007)(82960400001)(31696002)(86362001)(38070700005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3FLNjFuRWVEdTh2Z3V4bXhmajN5eDJTSDdZajFOUVFtMWU4VWdGNkRyUktM?=
 =?utf-8?B?V3pyeWpuN1ROb1k3Sk9ZQnRRMGk0ekN5ZjNudmxjUi9ERVRsamY5UER0SFU0?=
 =?utf-8?B?a1ZWTXc3VFgybmhORVZmVVYxNHJXYkJuL09MTllZQVZQbEFVY3pldDM2R1Vw?=
 =?utf-8?B?KzBsbHFDZXdEeVRHMS9RalNFM2QvVEVxVnByU2VtUE1Wd0JGR1V3ZGViWHpk?=
 =?utf-8?B?VXFYR0x1UDRVeWMyVkJ1NjRZYmRjTi9EaElUd3JmbTF4WnFTWS9jclJ5Ly95?=
 =?utf-8?B?R29NeHQ4by85M2x0NUdsVG1qNGRNaFQ3RHVWWU02a09YTFZkc1kxeGxWdGdD?=
 =?utf-8?B?VnJLSURaRHdQMFFsNXhDUkUwdDIzK3pwUC9TT3RmQUxZb3oyNDg0WUhZN3lD?=
 =?utf-8?B?am1NaXhidEErZDNXVDkvQVdPRXcvQ1Z6V1FGWUt4MzJ6ckt5ZkhOSUtXQUlO?=
 =?utf-8?B?U1ozWnFEeHNkeUViM21JT2dQazlTbERKYlhQQVo3RGN1Sk96MFM1dU5EUXRX?=
 =?utf-8?B?MlRLR0kwY0w5RzM0TmQwcDg1NWE1SkxWM3NIMmpVcko0MHdwQXgwbHRubzdv?=
 =?utf-8?B?bFd0ZGpST2hPaDd6NGlQclo3dk9IZU5BOU1jU0FiUkFIWXc5RWlXOFl5bmZS?=
 =?utf-8?B?Lzk5blRWcVFKQnJDY0dsOTFrZm0xNmlmUDJWdmt3cEpaSzRacjRna3lzL0NO?=
 =?utf-8?B?bC96UDFHOWk0Rk5qUnphTDVlVStTYzJWYkNhb1hEYlN2UjFXUUZJVmFTMVMx?=
 =?utf-8?B?WG1TZWxDeEliU0MyajByYUZ1R2hHdUdweGZyaXQrNDVsUk9TblBWL1BpeC82?=
 =?utf-8?B?bFhVcVE3RkRLcG1RSG9rWTRmYTNBcTlLaW15YnNkcVBGY0hMRFNkUnlUNDAz?=
 =?utf-8?B?ZUFRT0JobTdJS2FVM3lLOFJXcVVrRVNraitUbytlMG9CdGlRQzF5b1NsKzhO?=
 =?utf-8?B?bUdhcUJPVjU4eTczbVhENkxNdlhhY3FDVVlHSXFBWGZINWdTNnBWa29naWRW?=
 =?utf-8?B?K29sNVk0VXNHaHNBekhKRUVVWE9wbk90OGpqNGhsWndOdTRTQVkvMFNsL2J1?=
 =?utf-8?B?bVZjMGxodkNQdElON0NiYmg2ZzFjUVdTenVWUGdiWGVScGdCNXpnb3VqWUNr?=
 =?utf-8?B?OFhKVDB2QzhFT0JXUmV2ZGVmRmZoeUNRWC9Sb2hCSWRyVTR4bW52REx3WE1J?=
 =?utf-8?B?VWV0UmtGUmg2MEFEZUdxZUJlaTdHenhocnVGTWx5RUtmdnRiTnVKTktvYzRX?=
 =?utf-8?B?bVpSUnVnODlyWnRQQ0Y0VTZ3ejFDaEx6UXNhNUM2enVQZmxWNHBOWU9rMnMx?=
 =?utf-8?B?TjJpdEtteGltejZQYk5aeXlXNVpDQTQwMUh2VkpBSU0rcGFxeVRDb092Q0FM?=
 =?utf-8?B?azJpZytyZFEreWpDSDFBT0JkRmgvbXF6SlBOUVQ0SkxSQmpCQ3RsMFhaVW5w?=
 =?utf-8?B?MnFTTnpWdFg4WlRnN1dqNUtDTVJtSG5NUXVhc3QvcWM2UkhRVjZMVXJmMkFz?=
 =?utf-8?B?RFdHSGRKMFNnREE0TUpiSTVKS3RVNUgvTGNyYTFqQVNaUk5Falc2UzJOQ0NQ?=
 =?utf-8?B?WnlQWDJtbG04eEdPYUwxZ0p3YXBFbW1PV2IzT0g1YngrYUNxdHNCcWIzUW5w?=
 =?utf-8?B?ZnFaL0pOMFN3Uk40MlpkQWNJbVJLZmJqQlhNNUYva2lLNnEybFBDUVZML3Mx?=
 =?utf-8?B?TlN0MzNQNXhnKzJ3T0hPcDNGNHF4ZGpHaXJaVHRlaStyN1AvQVhaVS9MR0p4?=
 =?utf-8?B?NE12VzNWZFEyRWMrdFMzalV2Q3hOdERHOW1TNDdUTlBuZExMU2s3cVZRRnAy?=
 =?utf-8?B?cGs2am93M3Q0Zm04STRkNXRDYnJ4OFJnK09UMmZKOHhUd2J1aG00ZTRJVTk3?=
 =?utf-8?B?bXllWkFpc3ozNTBrUmRTWjhFcHBQemF2dkMvSWV0QmFSc3hpeU9mU2NjT09F?=
 =?utf-8?B?ZDU3SnQ0dlhBOFd6eG5paXRlZVFmTVJ4djhLbXBYUXhHSFlPZVQyU1dyVW1G?=
 =?utf-8?B?MDdHbDFzWmt2OS8yZGtaYTlDc1Q5VVE4VnBDMHlzSFlJOUJiY0RUMWhWcEo3?=
 =?utf-8?B?dlYvUGVMMURsdkJqUzZERmJnUXhuOE5TanZMbmdrVk1kQ3hFanRWWFZXTnVD?=
 =?utf-8?B?dFJqV09mdStZbFBRL0VyNXBpZ1BZQml0azV4QUlYdU5ya0p5dG5qWUdWUm5t?=
 =?utf-8?B?MTU2S0JsQko3b1lYTlU2S1BtdzhlcUxDaGJUWVlJSmYybVB5YTZ0Y0xUSUFm?=
 =?utf-8?B?T2lUUE0xRElWaUlIZ2wxZ2wwZ1VBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDC1F77F2FEF414B9478AB10014886F5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18117ae4-0611-4b70-1f66-08dac15c36dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:38:22.7425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Co2h63H6TTVuQxYWi8vgwRiP6ECORUadMyBKUVL4ILsWh1OL64Oor7kYtAL6mHQLz5dqx8QfkgelORUDNePXU66SIiL4ECX6Kq2WfK4fU40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
