Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A743C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 20:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010D1610A0
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhITU3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 16:29:00 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:22400
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230176AbhITU07 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 16:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZEh8slmHIZWT4+Vtf1MV40Ebk34a6ljq3wAohAWr3qswKulpib6ZbGPGh4fNbNUU8+5o7+UBfWHmgp9SXA+NxTSt9SxPEvnU/8j3rGcFbkyxa/HpiR+GrGdTWee42zCfqsmjq3sNAtTUZzPhmt899WgWos0hDSnx7yPW/o+5fHMQdSbWb5YowtnviIdeW5AeraCdSFlBQq9E0JvmyYd85cJnUNqQOW4dioTH9yabRS5MzhYcxfLAua1YlI9dzP1cpoBTtoYPoNcFwLHA2y+AmCed2PlJjOEtLzUuHQ/hlkrhm/LmOHd71hC84k1ocl2OeQ4rbVmfhOCa0LueksjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BWZmirIodd83yqkXYE8wcdnjeLZYan/Oqiem3X5lSNI=;
 b=VSRPjlqJpjW5W7aV8V0UFZbyVVrZN4fL4e3iQtNPp8vbufhZQPSyw93TzzEoJXGppLsbBVpHOOc7eApA2vFfn7Uu5wgAYmw7scAOjRiATt54pz78VokA0qBpOAxKFGdsVmA9O0RLV4THXEq3irH1/OPyt8jX3HloXVLaiEaseNd/TGAQ05HqvTwYoADaa9+CBT4PWgJ2VnHDTTSVoirhDL5/ZhO57jaq3vl0TxcIVdNZf7c0ohtIryto1AZgO7E4T9eXfDGHhiN4fxL7q0RgpF6Pl9XPHMYGLHpB0LyQ6oQrGdq0VzmokhXsyeSora/AbwzMLc5GPDGB3Z7z+WHSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWZmirIodd83yqkXYE8wcdnjeLZYan/Oqiem3X5lSNI=;
 b=G0VwwRpAu1VIh5Q3wPnC9zivchXL3LSlnYF0X6nlwaHkzSBAi3RxLj22sSUzrEaFTTrKnKgrhL1ztXYYpaDBVDVMwCGDCnco3Lml/+DY9Yet2QDIsFNdtPDwDV/OSQBCgfLNQOtje1qzXdL6YfAXbxke3oofaaxV0da+C47tfmINbhEyG+hEo5Q/2g19phnnVCLMTce6piOHXiBNr33ZDLLIeG4rV76MtR6lgmW/CKEei5TYU0nXTmqttHir9P65XjMK8uFVpkMzNdjcInHpeIqVtOOWLvly6O7/NYfKV7NsbnEk0adoox4dov1zKNDLDeHzwDGGj8bf5C4PMhGwHQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1645.namprd12.prod.outlook.com (2603:10b6:301:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 20:25:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 20:25:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Prasad Muppana <Lalita.Muppana@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Topic: [PATCH] blk-mq: export blk_mq_submit_bio symbol
Thread-Index: AQHXpTzKDPVrIJupQ0+ewmun+nT2equb4YcAgAWCmQCAAB1TgIAADxUAgArmKwCAAPohgA==
Date:   Mon, 20 Sep 2021 20:25:29 +0000
Message-ID: <792dd48b-a246-0456-58a8-00d739201251@nvidia.com>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
 <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
 <YT7rL4PhovDOHfHO@infradead.org>
 <75f77917-a8ba-0138-750b-8dedd8f7ce7d@linux.microsoft.com>
 <PSAP153MB0518F021C769875159C3A03984A09@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PSAP153MB0518F021C769875159C3A03984A09@PSAP153MB0518.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1674b34b-cea9-48eb-8719-08d97c74ca2b
x-ms-traffictypediagnostic: MWHPR12MB1645:
x-microsoft-antispam-prvs: <MWHPR12MB1645207B8499DFCA1E312F0BA3A09@MWHPR12MB1645.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8UaX0zDaOMwsgAT4VSeHg7jcnc20x2M6Y5VM5Hd4d7PcCvXFe3J4XRnNe8iowLQZF3VunazUXwNV3Ll6AnmWSaXEs7VpWxDTmWjVpCaFv90Swf3aS/bI9NDzVCWVknskbZfL3r9VOgV2lzlqrncbkEgzYcCyL5JKBiERPI61a5zWHx8UdH2zpof6D+YbBX83QoX71t9MzI5ZmDuwXxGQ7fsdPs9YVK3U8xdTVT4mGymXtfZKtP995OqEdKn8ZFtOAa6XYjv7rS1eDYOCCwtAjkmYsQhGL9FmDKlxJxHj9i6UHYhbIzfpHQUgGwnLStdFWlJXVoWihDq8iyL0/7pHPeCcBVU0R1X1LpnScEJNBoyFsxmRMbLsU7Ev56QZA6oKh0EmuVfew1CNhv7DpGXC2zEFdCUUX3HEeQ87KkgzTcZg+Pby+op+Kb7IK/SW3izj/v1ZcF8RuoSViKr60Y4Y/0bYebcTJNwxHP2JbpXLGlweCeSQZhAuH7Oywr363Cs6YDDZOfaZDZhyfxVPQFmnTfM3volAkYCbDMwn96xzbFctbASZV8ilSdOwF2p41x/KIhm2GdshaStg/VAu1150Alo4ZHDirgvcz0tNR8ZAXGqzdsXyxKtLy+Xb/NOPzsOb7TlYVRzZLxZFjzuTT2Ic8TCmPq71Zgtd9JYz0XIyzzux19TeQ/HDyTZQD+BK1s4xOAjnU1AIb7R2iv6tJj4XKR4QfSUWGpc/2zHTx6Wl202UYrmyN0bX64xybai97YcSVsAYfmMlDmuPHLWxlTxBXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(36756003)(2616005)(66556008)(66476007)(66446008)(64756008)(186003)(71200400001)(66946007)(54906003)(5660300002)(6486002)(76116006)(122000001)(6512007)(38100700002)(83380400001)(2906002)(110136005)(4326008)(4744005)(8936002)(316002)(31696002)(8676002)(86362001)(31686004)(6506007)(478600001)(53546011)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hrWEthV0RWMlhlbzVWV2NsS1dmdEFnRjI2UGFNRkp3cEhYUUpST1pXcUpl?=
 =?utf-8?B?SFdOaFVxOWVudDN1YTZJWUhkV1VyZml1N0lKWEJLUEdxd25tU3lJekw5WFVW?=
 =?utf-8?B?blpacDJ1djFFS0pwTWdzRk1qWXpDaVRYOThNWUxpblA5d1hsc3l1U0Fwd04x?=
 =?utf-8?B?UUVBQ3JZWUluQ0ZJQndpeXNQOGhUSyt0TmpUQkNqT0VkQ2xsL0p4dS9NRUZP?=
 =?utf-8?B?NXlBek0xTjZLSk9HVENhNUFLZ2ZRNk1hSlBjWGdJR09xUXphNWhoVndWaC9K?=
 =?utf-8?B?Y0pqT3pDMFZVRnhXQTFTaFQ1Uk1TRUljQmo0RW1IbTYzeUF6UFh3WTBoQXFZ?=
 =?utf-8?B?dlhsQ2JzWGY2RzZCU2xRTGJQU0dJWm9vM1p4Q3ZpNlcxSW9QUmRSVnAxUE1U?=
 =?utf-8?B?VzM2dnRMWCtZMEJMVXdSa28vbUtLOVlzQXFZakRTSURnZHAyU3k0Zm9NQXox?=
 =?utf-8?B?WXVKNG5MZzlwMUNSSkMrSFNKanQrR1NLVFNuWWxDenRVcnhmZjBqQklQbVp2?=
 =?utf-8?B?WDdkYzBxNHROaVp2Ty9PTUU1T1dsbnR1UmQwMTZFYkZ5T3NSN0FPVHZCMW5o?=
 =?utf-8?B?enZ4dDVrUHkwaXhvb2JCTUJVQTFUR1pvVEI3STZHanhmVTF2QVZPakxKM29r?=
 =?utf-8?B?T2tVazlqdTRENTVWUjE3dkw3VFpqTXJNb1E1RmtIQ0Zab3RmOXlEL2VjT1FP?=
 =?utf-8?B?VDNscTUvcjIySmFQQ3Fqa0VKZFIzNzVsdHQ4Vm5UOVdmbmxWTVJ5ajRXYm84?=
 =?utf-8?B?RVBMcWhDalpLamwyQ3I5TmlQLzZUd3BnMkdVMmFrY1hVblM1ZXBiSlJXZldq?=
 =?utf-8?B?TlpQaHNqYXFad1Y5RVc2NkhkTk14aUJlMU9EQkVPbFN2bERxVHpDWXJkbEQ2?=
 =?utf-8?B?L1N5NG9Nb3FNWDZyd2lvenV5YkdyUFhEYnpXU3pydUV0QzVMZ2ZFY3lFUE9Q?=
 =?utf-8?B?WkZqekl4WGwzeGRLNFFJWEtKMWVTaFdOek9yS3I3SFhiWnhYREtQdXFhemNq?=
 =?utf-8?B?ZnM5MVJlVnR0YjdWVkFURlBWUGc0S0NmYXhlSVpiZFIvY2Jaczk2a3NZdGNu?=
 =?utf-8?B?QTRUT2NZRWpPbVM2MlJCUmdLQ1dWcVNhaDNFbGU1OFUxMXduWTYzODZhSytZ?=
 =?utf-8?B?Q0h5K2ZSa0FpK0lZWjRuS0VHb1dZaHU3N3hYNDJVS0cyeHhaOXNqTzBnQkFI?=
 =?utf-8?B?MVZ3Y1JRek0yaC85aUtmWHYwNlBmdnlSeVdvS2pXeEdRZTd1MHBxM0Znc1hh?=
 =?utf-8?B?bFNuaG9oYm1ZUEZ2akhqaVNCTXpBUkdlYXEvUDVMZ3M0cFpmN0QvYktJa2FZ?=
 =?utf-8?B?c3k4Q1VpTEd0RzhJWlVpMjI3QkYxQnl1RjVOb3QzVUVFaGFlUlM4cjBiZ0Z5?=
 =?utf-8?B?bnlNRlh2MUhlVlExb0hFYUd1SzZuTm45bm9sdVlRcWd5Z29GcFBTYk5Vdldm?=
 =?utf-8?B?SWVaK2ZhSG9icUgwWDI0cGN3SndLSk5meGQ0b1dTYkxPbnRoNW16cFFhbzdS?=
 =?utf-8?B?VEhUelpVaURyY01ua3NkUmQ0YjdWaEY4MHVuRkxKdmo5YjhRTnMwRDJPaEZY?=
 =?utf-8?B?Z1lJbURWRWxiS1ZZRVdGSkcwd0lWS2FZYmFFQkZFcHB6amV2WjBmNEVGUjl6?=
 =?utf-8?B?ZFN0aVNqY3ZWdFFBUDY0emJRZjN6V0VPcnZqMldBV0VWZlVJc1pBaHVnWTRn?=
 =?utf-8?B?TjRaN2ZISllMYm1Pa2tSMVZ5RmhNQWNzYW40ZkwrczBKVWFVUE1oUURmS0xo?=
 =?utf-8?B?b3RDbWxQRk5JRUh2MDgxU0xCZE9YcElMZnpEdlFFZXhtQUpXQ244Zkt0emtn?=
 =?utf-8?B?bzhmUUNMdk1DQ1F3WkFLWG5FVS8yamlYMkJLL01vbE9qTWQ2Tk1FYlBrQitJ?=
 =?utf-8?Q?SkDaGsrgDNWaE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <323F0E2F7F8EAC41B05A0C8FD667DBFB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1674b34b-cea9-48eb-8719-08d97c74ca2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 20:25:29.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XN7KPtHG90ekj0XqkkluWkJarRz2NbTxn8FG3P8gvPrIZZQxv3mvgdtnWNPfTXb/o+Qy7VrXnzAxznaX/PlH0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1645
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS8xOS8yMSAxMDozMCBQTSwgUHJhc2FkIE11cHBhbmEgd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
SGkgQ2hyaXN0b3BoLA0KPiANCj4gV2UgYXJlIGluIHRoZSBwcm9jZXNzIG9mIG9wZW5pbmcgdGhl
IHNvdXJjZSBjb2RlIGZvciB0aGUgZHJpdmVyIGFuZCBzdHVjayB3aXRoIHRoaXMgaXNzdWUgd2hp
Y2ggaXMgY2F1c2luZyBkZWxheSBpbiB0aGUgcHJvY2Vzcy4gQ3VycmVudGx5LCB0aGUgTGludXgg
Y3VzdG9tZXJzIGFyZSBpbXBhY3RlZCBieSB0aGlzIGlzc3VlIGFuZCBtb3N0bHkgUkhFTDguNCBh
bmQgVWJ1bnR1IGN1c3RvbWVycyBhcmUgYmxvY2tlZC4gU28gd2UgYXJlIGxvb2tpbmcgZm9yIGFu
eSBzb2x1dGlvbiB0aGF0IGNhbiBtaXRpZ2F0ZSB0aGlzIGlzc3VlIGFzIHNob3J0IHRlcm0gZ29h
bCBhbmQgaW4gdGhlIG1lYW50aW1lLCB3ZSB3aWxsIG9wZW4gdGhlIHNvdXJjZSB3aGljaCB3aWxs
IGhhdmUgbG9uZyB0ZXJtIHNvbHV0aW9uIHRvIGhhbmRsZSB0aGlzIGlzc3VlLiBQbGVhc2UgaGVs
cCBoZXJlIGluIHRoaXMgY2FzZS4NCj4gDQoNClRoZSBpZGVhbCB3YXkgaXMgdG8gc3VibWl0IHRo
aXMgd2l0aCB0aGUgY29kZSB0aGF0IGlzIHVzaW5nIHRoaXMuDQoNCg0KDQoNCg==
