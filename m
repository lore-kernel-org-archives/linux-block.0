Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32407C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 08:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiCNIhk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiCNIhi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 04:37:38 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ABA3EF36
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647246985; x=1678782985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FBCLmUCRzsA7LFxclI3KrE1h/4g4o73hk1SFk76zxMo=;
  b=MR5H61QHfxUxHtiUbiOO4k4JSRirfFx5S6GmWW0AZi8KyvNoUuzMeFqx
   gbo7pHcxKOyIEeEiIANyt5cZalLCThu37dc6a72x60gyqU6kSr/9mqgar
   iedSMY2MYm4vwnlHyBGEoNaJrIIjKOm0mMOsiDUmBYimbw14ZwGXDg/LH
   gIbf1kd2f7V/RHYbHLON2s/sd0WpB0J18rhPox0cVB/pqpEewbn/q/Vpy
   zm3c6FuCFYWFswjaDnX1FOUXkyUsbED3cnlk+rt7IOidR9yNC8Q+mpzxY
   1kPDDnaUDqae82pSROlkaTqhHUWeq2wASStz/nRcnqcN6ZU7k+/mtv+fa
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="307244291"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 16:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKtAnzZvigzKtrb5pjBdjAv1ylH3Y7XmE8LLapFuhniRvLEERa4Z1HgzP7OtaaSIyv8PJGldGRMf3hKj3Idh6/4yc9wQ8/gfwD8L3VdOMx6ZWnjSdT88kuN7myqI2qy4ok0x9Zhz2WjO+/bh6WNa0fF+NJHOHl81lrRhW2nN99LWNqy/h0a9uftBORNJJ1AsPkV9MIKFF5asp8sRWPbGdcQjVKdhVETWUD+AYzPEGngALlxbZy0SoI++PNOnoP29K6vf0y7MNYaLqYcDpk3aO1diBevqmpfjHpHIO9teUzSEqy6GBZ3Dt2yvYBbBf8skjX8/HPX2F92x+t56WLfkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBCLmUCRzsA7LFxclI3KrE1h/4g4o73hk1SFk76zxMo=;
 b=M9p7DdZDGqJ/7VDt4/wVlNI7a8bnLxZB+vSHnK86lmHt1YUi1RdKlAsUbMAbN1rtCBuOTedAUuSguasbGa4z8QVmIJPMSCyv/vv3MXc2fRy5sjvxPE7g+IlBIGrMozILpAv+zJR8YvS/FtAgoYBVOc8nWmhjL9GKBT8ojRBHQpnIK67az82t5AxCbIpMZ5OA05DpGdQ3u787+BDO+Yz5zLtOCVSDzTtafZiabXXB+0sxJ3k1BTPEadRJt3XOuZ+7QM96gN5CPI57Sa+Ht5u85zznBFn4L1Ax57U9Dhiu8wbfupbwjshWUrDtQ79J35VatHsuleNwSGoXnUQ+oAstrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBCLmUCRzsA7LFxclI3KrE1h/4g4o73hk1SFk76zxMo=;
 b=smBWCo23A8DcCsn3Rw1zTN0As0IKTmzJ1UKwQOR3/3Tzsq6ew/YTIiAi7L2Ff68Kn1hJuxpPOWPRzuxQw5wK5mDDnM3e0mbMU2GSCETexj1CuCTFAbt2MShwNU87mxIUJ/t93DSnEghCSj0sl+Z6MpHtBXlwwdpP1Cqo3iQEkIM=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by SN6PR04MB5440.namprd04.prod.outlook.com (2603:10b6:805:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 08:36:22 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 08:36:22 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier.gonz@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADKLIQ
Date:   Mon, 14 Mar 2022 08:36:21 +0000
Message-ID: <BYAPR04MB4968805C8C98DCB43A568ED1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
In-Reply-To: <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbe19cb9-73af-402e-fe69-08da0595b7fc
x-ms-traffictypediagnostic: SN6PR04MB5440:EE_
x-microsoft-antispam-prvs: <SN6PR04MB54406C1A87205B92DB7974B3F10F9@SN6PR04MB5440.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLJNQ0dx3/UbskFp0hSTmru+RYe7YFyIlUqkbTtmf5tRosxb4GlOWyZVpPdYL/l12FfSFg2NvQzVIBas1OaIpF6OCFMIhqqzhq18zaohSjp3y3W7z97ABcZM98NE562x+9cyalSUXGkvKniCZOErkEtEi0YzG6ut6AjBrDGFOl6VgTdtfnwgAfM4fJIbNt+tv1YxkPyjBBE9VUTuRkz/KEAn188hxhW2G6qp3q6iNJSa0kXbT2Fwv8EXRQdxiYDAMAysLY2+tECYnhubez41++4UAgiWDVrn9mBNxQQS4X/fhW/Got6CB6iF6qXPqnvaelTMelvcbBe8NNaNZXDHcDKi4T07elscIiNjvJJT24gnXMXGKSCcwjIRTJM2iBbzxud4Zhm6c5Uaanjt+RFjhKFWJbaFwKnXZWDbvktMiwdSRWGvY0m18GKQPXqf7BpViPItxw+9EuAnAs3o3GA5/gWrkkeClzT1t5NlKave/9TC0rrh01uXQ/UJppfTjRV5U08mtmt0M6YTpNN8Kf2D4goSAm2ny/W948822/Th0FviyIeatMaYw/vVI2E9IvzITJUTFNyxSHQnSeZUuNLqLOLn/h76KWESCg+o2erK5SPBXyCjqKEBR9EpaFXOgMUAB2INhXXW4PuyoGuy/inqwXtfE7/uMbrJeayoP/BbdlJYTwMFWtzJKptIbcjjvwc7T3Ue1dGAG+z39hMHWioQyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(64756008)(66446008)(76116006)(66946007)(38070700005)(38100700002)(26005)(316002)(83380400001)(52536014)(8936002)(86362001)(186003)(7416002)(5660300002)(122000001)(82960400001)(110136005)(2906002)(54906003)(85182001)(85202003)(508600001)(71200400001)(55016003)(9686003)(7696005)(6506007)(8676002)(4326008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVXYWxVU3M2ekZHUnh3RkxVZHZIS3ppakdVTGlGYkplUFNtZS95d1FSa0ZG?=
 =?utf-8?B?Z04xRWxYd0twQnhkazJ5aTN1QkU5VG5sRmEzeU96K3N6cGhRZExRbGpjV3dj?=
 =?utf-8?B?UTNnWkh1dlNQUkVKa1k4SlVIeFRQWnpLMzk2Lzg1WEdqOTRZeHJVT1pXYkxX?=
 =?utf-8?B?NEZaWUNheDBxaVRNcFNDeFZ2YVd4bi9iSVd1NWhyczR0ZFJNTGVQMnlxUHBW?=
 =?utf-8?B?ZGdqMTd1UDc0SVRBUGlzVGF3NnNBSURDd3hSUlZVeU0xenRuTFNXdXgydGFp?=
 =?utf-8?B?K2pVMlFvWXlsSCtIZkNKVVQ5RHJIdFAzcXRoK2h5djNKV0FwOHhCVVloZ0Zk?=
 =?utf-8?B?ZElpQTNPTlpuTFFUZmR3WGxWTk9NaTRXK0ZjeGpZYW9oS0Q0R0pnQ2xGb0Yz?=
 =?utf-8?B?MUZpbjhkaXdTYmJuVzMyZnNubUNnWllhK0p6MFYxTzBueEpUWW1iM0IxeW96?=
 =?utf-8?B?N2FBQWwrZE1uSEx4NWpOTzBQaEZBeHAxVkVhRStsdmQ3R3ZDdmlaWVM1Z3J1?=
 =?utf-8?B?cHlSQjV3WkRWVVE4RjJsbExNb2ZIVkR1cGxlTGt0Wm9ySG1lMnlOdHFWWUJr?=
 =?utf-8?B?WDhibXg2UVExRk1jRlJHVFF0RytkWFBmcDVvZVpXamwrUW5qaDg4YnJIY0w4?=
 =?utf-8?B?ZjlyZGZ4NG9mYnhMRlF1by9MVVEyRVoxKy9wRFh5WThWZE1TVmlzY04vTEVX?=
 =?utf-8?B?UHFyNE5QWEpHZ2NXMmhvOUhnN0FZQm8yNmV5UE03MnlmVUNBUnZhb3I2elVl?=
 =?utf-8?B?UWk0VVJIcHJpa09kMXF3NGtTYTZFa0FFZHc3Wll6NWhjWHlzWHVwYjZCVHMy?=
 =?utf-8?B?KzBwWVFGZzEyZ3h0RFlqS0Izbm5sMzlvOXFpY1ZoQUIxVVJ4VVdHZDZ0TUhi?=
 =?utf-8?B?K2plN1AzbFJtQllxR01CUEdtVjJwRW8wV2QrWGJlcFgxQ3pvcm9kcU1TdUlt?=
 =?utf-8?B?a1lGOGgrSGNMSk1Bb2xYY0VNb0Y2Ykt3azFWaUtxdndNTThTV2EwNnJsRER2?=
 =?utf-8?B?M2NzRkhLUnk5YW8xMFlpcmpFYmhnZG1wWjR5QS8vOHFNQ0hMeDVWUTRHYmcr?=
 =?utf-8?B?ZTd1ZitvM05MWTNNS3A0bkR4R1JMc09YTTNmaDZGdWZoUjFGNzJFNHl6N0lR?=
 =?utf-8?B?MXNORDU2NG5JY0hOSDE1aHk1K2pwa1lxbms1VHcySVhobDdVLzkrZDkyQTZ1?=
 =?utf-8?B?TEtodjdzclFaR2hDSGdoUGxyd1F6anU4ZnFNUDR3bGNxSGwrU3lCZ1hUeDVR?=
 =?utf-8?B?T1ZpaGllRGxHdVFlNlRpSkFrd2dkbTErMWZpaklnOGFhb04vb0V1ZTNGUTRV?=
 =?utf-8?B?d0pKUzVad2VmMXFBbDlWRXBOdW9XZ2lGOCsvY0FuZDlMREdyM0U4UG10M2NT?=
 =?utf-8?B?VlUrQ3NZWmVhK1JEME1oWHNUcnU3RGpmcGpnNXZ0L2loQUo3dTlvNG5rek14?=
 =?utf-8?B?TFRlYTY1elZ6cG5QcVJraEJLRmZWK2hObUhzUTVrNlJ6K25XZ2hQSTFPQmFv?=
 =?utf-8?B?eVVjaEgxaUkzdzN3dTVMNmQzMVorR2UreGpmT2xRcTRzMGhhWHpTUWNoMDBZ?=
 =?utf-8?B?MStRNUhHNXRTRDVmOEdtWWl0bDNlMDBWb1hhS1ZGOWk0bnRqOGdNL0xneDIy?=
 =?utf-8?B?bGhNQkZxT0xsYTFENzdSdnJlK2V1YzFSVDB3NW04bTFKR1o1aTI4RXFXaVhG?=
 =?utf-8?B?dXJVcWF5SXloQjNFTWNMcFJEYmFIeFNGVzB5QzkzbUUxY1pvWGNOUSs0clc4?=
 =?utf-8?B?RGYwRjUvNmdhL1lkQWlJQUZCOGhvTEZKUkVkakg4Myt3N0d6aldnS1ZqZFJL?=
 =?utf-8?B?ajVPeWhpZ3dMUFUyV1RIbzh4TW5JVmg3MWZFUWVpb1lRWEFEOGJCNHg4RTBY?=
 =?utf-8?B?aFJHYW9ZMytKNkx4eFYxU01qa21yTGtINUJQdkVEWnNVRlA2YUVnWUM3QXMy?=
 =?utf-8?Q?ad0IWzhElFdrqs5wQNhriBSllUFlse10?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe19cb9-73af-402e-fe69-08da0595b7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 08:36:22.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJZRl+JCDSdVWPA4AiIu4l29ulQ9Y2S/sSLpJuCksFgWMUyBdO5yGMQ1yiEVoxLLjCkU7jkPxhchLS+dAl2DmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5440
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiANCj4gRnVydGhlcm1vcmUsIGFkZGluZyBzdWNoIERNIHRhcmdldCB3b3VsZCBjcmVhdGUgYSBu
b24gcG93ZXIgb2YgMiB6b25lIHNpemUNCj4gem9uZWQgZGV2aWNlIHdoaWNoIHdpbGwgbmVlZCBz
dXBwb3J0IGZyb20gdGhlIGJsb2NrIGxheWVyLiBTbyBzb21lIGJsb2NrIGxheWVyDQo+IGZ1bmN0
aW9ucyB3aWxsIG5lZWQgdG8gY2hhbmdlLiBJbiB0aGUgZW5kLCB0aGlzIG1heSBub3QgYmUgZGlm
ZmVyZW50IHRoYW4NCj4gZW5hYmxpbmcgbm9uIHBvd2VyIG9mIDIgem9uZSBzaXplZCBkZXZpY2Vz
IGZvciBaTlMuDQo+IA0KPiBBbmQgZm9yIHRoaXMgZGVjaXNpb24sIEkgbWFpbnRhaW4gc29tZSBv
ZiBteSByZXF1aXJlbWVudHM6DQo+IDEpIFRoZSBhZGRlZCBvdmVyaGVhZCBmcm9tIG11bHRpcGxp
Y2F0aW9uICYgZGl2aXNpb25zIHNob3VsZCBiZSBhY2NlcHRhYmxlDQo+IGFuZCBub3QgZGVncmFk
ZSBwZXJmb3JtYW5jZS4gT3RoZXJ3aXNlLCB0aGlzIHdvdWxkIGJlIGEgZGlzc2VydmljZSB0byB0
aGUNCj4gem9uZSBlY29zeXN0ZW0uDQo+IDIpIE5vdGhpbmcgdGhhdCB3b3JrcyB0b2RheSBvbiBh
dmFpbGFibGUgZGV2aWNlcyBzaG91bGQgYnJlYWsNCj4gMykgWm9uZSBzaXplIHJlcXVpcmVtZW50
cyB3aWxsIHN0aWxsIGV4aXN0LiBFLmcuIGJ0cmZzIDY0SyBhbGlnbm1lbnQgcmVxdWlyZW1lbnQN
Cj4gDQoNCkFkZGluZyB0byB0aGUgZXhpc3RpbmcgcG9pbnRzIHRoYXQgaGFzIGJlZW4gbWFkZS4N
Cg0KSSBiZWxpZXZlIGl0IGhhc24ndCBiZWVuIG1lbnRpb25lZCB0aGF0IGZvciBub24tcG93ZXIg
b2YgMiB6b25lIHNpemVzLCBob2xlcyBhcmUgc3RpbGwgYWxsb3dlZCBkdWUgdG8gem9uZXMgYmVp
bmcvYmVjb21pbmcgb2ZmbGluZS4gVGhlIG9mZmxpbmUgem9uZSBzdGF0ZSBzdXBwb3J0cyBuZWl0
aGVyIHdyaXRlcyBub3IgcmVhZHMsIGFuZCBhcHBsaWNhdGlvbnMgbXVzdCBiZSBhd2FyZSBhbmQg
d29yayBhcm91bmQgc3VjaCBob2xlcyBpbiB0aGUgYWRkcmVzcyBzcGFjZS4gDQoNCkZ1cnRoZXJt
b3JlLCB0aGUgc3BlY2lmaWNhdGlvbiBkb2Vzbid0IGFsbG93IHdyaXRlcyB0byBjcm9zcyB6b25l
cyAtIHNvIHdoaWxlIHJlYWRzIG1heSBjcm9zcyBhIHpvbmUsIHRoZSB3cml0ZXMgbXVzdCBhbHdh
eXMgYmUgYnJva2VuIHVwIGFjcm9zcyB6b25lIGJvdW5kYXJpZXMuIA0KDQpBcyBhIHJlc3VsdCwg
YXBwbGljYXRpb25zIG11c3Qgd29yayB3aXRoIHpvbmVzIGluZGVwZW5kZW50bHkgYW5kIGNhbid0
IGFzc3VtZSB0aGF0IGl0IGNhbiB3cml0ZSB0byB0aGUgYWRqYWNlbnQgem9uZSBub3Igd3JpdGUg
YWNyb3NzIHR3byB6b25lcy4gDQoNCkJlc3QsIE1hdGlhcw0KDQoNCg==
