Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C56C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiKPSlW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiKPSlP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 13:41:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD12B25C
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 10:41:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avimIzalPS8M4WDaJTMXpSTs8LciJDauNRE5HG2OUxdN4IHnZ//Sv86OZ0uz2lnNLnjO1ICsKxKVtoay2t49YxMseURnZPTyybAdwd0KHrEM2BB36KLj7hG4qYZRdn77W8H+Ye5SUxJxcoUK5JC1D2zfQKnTpy/Uho2Yd06/BH+iG4wrU/ZDCsRrFQBv90tuZkcW8a5IWB9Dr6kkyv7MmNUgXp+j2Bq81rmo/bHecI5803JaVHOaByzkJkMWlZEfc7xPOpZGdlfZ91HdKgcXN6vrSvxwfmXdGfZS5y06PsLeaBdwNDvRJyTjDtUfJm94o2KepttX72siLFwB17pqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD7wUlVsXUpHUp2sV4gtX7pWSPWINfBHI8B9rmLdjJQ=;
 b=kJCMuI8HG+c9LH06ki21BeJD6mj1AL03zq0fif8yWtbJHWm8nz/kQXu1H5nrmnfL5YmcA+e2XYzXFCbKhatH1OGB9pbbIaLKSU16049+0rlkkPSMCWXoerXoZh/EdLlG6nvvkseZVLydRwgkxulGfDNSDxYjDiPZad3PAXHKIpgDPN1tZTCtIPg7ViSd2treV5AJtKhJ2QKn0tCYNZd38Yn9pyjJwGypPAwJhjw77kIXDCc5R5N7t3G4HnLyFT+4SVLY+AtPewTxJTX2c3BXlo5u2bCG+FOTzoklSMrdy7ZPuKDV8ZtnB9R8xY+uht8cJ8mXJfODXoESjq623xJpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD7wUlVsXUpHUp2sV4gtX7pWSPWINfBHI8B9rmLdjJQ=;
 b=gg56/8wGlg767HbKq+CuefxiG1bp8gTBhmwX7AzUaMi1Wui90X/LQEpf85LsyC17WfN+/GCyQEnp5BUE60Rw21LqzanQooFX9O53+jBUsZmo6Mbe6lPPz0HRxfjWHy1x0Xgs33zFTHi9wBo4K5e5CKwcf0NTWidD8Yd/Mz5fQs0la3nB1+N9GRBl+0uKvGb0mtQOp+4ok++ZUsjQ9ETBL+5EZtzmfXxyh8q1sLDhCvJIDwq4c5N65dqlEqFJyEhjq4zTxC/fEEXWR7ldx+lRwOgRlVfe90m/gX4WMnVsiUhhU5slX4lXBkHkds4Or3jNjjcjwBkGNjlJCiJJhDSZUQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 18:41:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:41:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Alan Adamson <alan.adamson@oracle.com>,
        Keith Busch <kbusch@kernel.org>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Topic: [PATCH] tests/nvme: Remove test output for passthrough error
 logging
Thread-Index: AQHY+VAokBGuJELIQ0OcoKmIBV0HOa5A8e6AgADSCYCAAAliAIAAFgeA
Date:   Wed, 16 Nov 2022 18:41:13 +0000
Message-ID: <b75cba0d-3484-30a3-4450-af05aea11aa8@nvidia.com>
References: <20221116001234.581003-1-alan.adamson@oracle.com>
 <20221116041701.mu4osauvwqsbvjau@shindev>
 <Y3UUb9RvkmS2OuYp@kbusch-mbp.dhcp.thefacebook.com>
 <3CF838C2-0594-4EDC-BC4A-809267F65219@oracle.com>
In-Reply-To: <3CF838C2-0594-4EDC-BC4A-809267F65219@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7557:EE_
x-ms-office365-filtering-correlation-id: aaacc44c-363c-453f-c9d5-08dac8022357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uk60C26kkDMuNGFMY58jrysQ38o6vJ/gjLsxdWmYTSIKFXg58qNiRh8sh3rWKxOzG4el3LknVTFW536rb/G+FxNvjsxRiYY31WDdhlrDMFnuLDnitllgy5F40dh3NY7wMjoZaPPuZQnRy8ItT/VuYHEBPf8f4/eu0jRoE+hOu+ILVfXVakHsB8nxzl1F60LIMCE+QsGmTTE3AIAmg+O3QmciqaVgsScyYB7djgBcOk8yfnORxio0tPE0tfWf8oxs0quIndfTN1REtYAqZD7/Src53lTJZlT/qY6APMSAI0hB6K8MBDAbaKt2ACe+wqExmVOEQWn8+NpnEpnu4OmRPjNQOnesj9Zd9b38LRMbyezZwdNOL61cdMYdQptxbq9kqFWF4OJlzvLBv5f/TP8fLChKoKifFTzB6IYOQEDwCcHhFwS8hGyNIxIJgwa1jF02887a5TUFuFEzCJfVjLNW2EHVbO39Vz2ktRTgyC2QnVrHpfxAKfTD3WKc4Wl9wV8sjidy5xG01ZTmVgXkKPfGGSoAK0xjeVY/Rn8hS+Xe1jFuDDbDMXymD8IZQ3W8BmzIrlgagmlVdvwEVGZNVw2+F8ZGhqcIDFYQxiyxsKdgF0V+ItGVg+5+ro/FEP0aeHGJj6dEC8OuzYh5AX3X0hF40y1yGCOzhqdb1kJLIa8bSkfuFxxCn4UcRUQlJhb5E//e2cQc7Nr1yIQehH54+ODOndZ++crQMz3GLVQNcRpTdEMJ8CTRkKvC90ZqymuD+mESIzbPpf8nDjj7srYimfIlQn06vq013iQqbb1Uf7bKrPrUZm1ZCLucD2WhJJNk9qIL8pKyNeRmNag4EmY+9EIh3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(86362001)(31696002)(4326008)(8676002)(41300700001)(36756003)(2616005)(186003)(66446008)(66946007)(91956017)(76116006)(8936002)(5660300002)(110136005)(6512007)(71200400001)(478600001)(6486002)(6506007)(54906003)(2906002)(38100700002)(64756008)(66556008)(66476007)(122000001)(38070700005)(316002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjhqQTVHdkZsV0wvUUNIaCtadCszR2pVc2xuQXV4dnBWZWRPa1VPVTV5NGs2?=
 =?utf-8?B?ZnVsdjJFbjk4QmhFc08wNDFKU0RtQVZVY3c0N0Q0a0F5WllzelE2YjMveDRW?=
 =?utf-8?B?d0FOMVdxZEpVWTB0S1MzY3hYZWpqSUUydTBQQURmT2w0eGFUUDEzdnJNcHZm?=
 =?utf-8?B?Vjd4RncrdUVKWE9kWVhMcDR4LytsSS95YUpSNEhXMElVMGZoSWZhUFRtenBa?=
 =?utf-8?B?TUc1M2k0NW1YSUdZcWdYSkF2blJmd3A5bXBpTGN1cjQ5WlFGa0x1NWFqTm5w?=
 =?utf-8?B?aXV3UDFBcGRNVHYxVFM2ai9lb2ZUNGZyNWNpczBVTzIzRWwvQUsyQXc1d3pr?=
 =?utf-8?B?c0ZVdVBUYUNkTHI0ZDlCYnlkd0RUcTBiQzVvUjYrM1Zjc09YT2RqUllUbGtI?=
 =?utf-8?B?cnVubm9SQ25sTmd4Y3JsMEN2emFmbG8vK0tCMHdFcDBkMlo2NWdtTjYvaFFM?=
 =?utf-8?B?RHRnbS9melhCb3pETGw1Zm9lL2RHWDlZQ3ArYXhsVkRKekV1czI3cXM2YkEz?=
 =?utf-8?B?Y29CMDNMVGpnZ3Q0ME40bGNLb2Vpd2lvbGxYeGZpVGc4bzBKeVVCODh1VTdH?=
 =?utf-8?B?TXgzQno4MU5kWGpsTEpjSnhzVmVFQndTelpMVHMxRDNpV1FpQU5QRDliWHho?=
 =?utf-8?B?TDNUYUk3N2dzQW1uN2w1Y0VGSU8xN1grOW42UlpVdCtWUE13Mit3K2pyYTN6?=
 =?utf-8?B?ZVh3TFdQQ2lON056YXRxSjJaKzRQZVUxQU9QandqU3duTXlkZ2JRTWZtTFRK?=
 =?utf-8?B?dTBUMjhvd0t4ZlRvMVI1M3pqUUhHNklhUGZxMXhyWi92MVpqR1NJQUE0b3Qx?=
 =?utf-8?B?L2lkcG5oWDA1azZ4NWsrUGx2d2xMZTU5dW1Oa3BRU0VrUkkwZ3I5anQ3MGtk?=
 =?utf-8?B?dC9kZmE0eTlXMlE2VUdEY3ROTGxoSFJlL1Z0TGVnQ0VQb3JXQkFRNUJsY2ND?=
 =?utf-8?B?UGJMMllvOG5qRlZNR3R5TkZ1TUlOcE1oTDNieGVLZmc5RFVPcm00aFlPN2Vq?=
 =?utf-8?B?dzBIY2xkRmNreWdrcWJjcjBGT2QySXZDaktEcGNqcVZIaCszNG5SWUdGdkRO?=
 =?utf-8?B?c01IRzc5OUQ5UnZMQnQ5MnllUm8xb2YyNzUyUHRhYmdpZUNGU3BXbWJWS2Jv?=
 =?utf-8?B?MndKcW9ob2lsc3lBVXRNZlFYL0ZyNFI2eHpybGMvZXNFMENRV0lZYjNOSnVp?=
 =?utf-8?B?S29XcTZ3b2ZEZlloL2ZyeW8vZ1dFM2hhaldrTUp2TXhFWUsyUlNRRHdSbUhN?=
 =?utf-8?B?eG1DU3RpTzhqQWNsdEZGME9qTHFUVmpwVWlLSUM1Qlk5V3I2eTZiL0tVelEz?=
 =?utf-8?B?NnVDdElYejRnRWh2Q3ZOOXFUSmpsQ2YyNHVMcXB1MlF6Ylo0aWlXckhYdDBx?=
 =?utf-8?B?V2tHMVc1ZXJvamg0VTV6aXA3dUNNWHg4K1I2a2JpYzlMbnBIdlhscVFxSXFo?=
 =?utf-8?B?bmo1RCtublY3MDU2QWFPVHk1ZFU1WEhCUFNoRjFPRkMzaUdxZ1orMlhxcFd0?=
 =?utf-8?B?c3lBaGd0dzlrL0NrNjBFc2xCRm5TdURMc0ZHeTZTYjVLQjJqNXA4a0thQmVa?=
 =?utf-8?B?SmlZVG9NTnZvTnNZZW9qU2xsaSt0cTVFZGVZL1dTcXcyM0RVdmFvWndSZXYz?=
 =?utf-8?B?YlhHOXUzbjBZa3BadXdZQ3FNT1p0SnNwUmJ1aXZKbmdic21yRjVKdTBkcUtG?=
 =?utf-8?B?aXBqa3Z2YUc3Y0RYSmc2VWZrY2RuQkRKODVvR25aR3Y0LzRNT2VNVXl1cHdQ?=
 =?utf-8?B?K2dhQzVZNFo4S1NGbHNJN01TY1ZhS1FRQ0F5ZmVKbEJ4V013UzlmbVlFL0k4?=
 =?utf-8?B?b1hoUUU0RE1oM3NhblFLM2tZNzZYT3NkR0VtQW8zd3dGSFpuMk9Lak1RV1kw?=
 =?utf-8?B?TFZQTnFITU42VXdLVWsrM0FHRklDdklRajAybWRTa1JXQlRJTnZ2NFRxNFZU?=
 =?utf-8?B?UVRJRmtQVTB5cmlhYjNMZkZsdkVjTHlidDUza0V6RFo0bFExS0wvd29lQTFI?=
 =?utf-8?B?ZzhXcy9PdDdXaCtJU1BseW1mMlhka0t4NmdxbllFS2xBQUxWcGlZL29WMjZZ?=
 =?utf-8?B?aThZR1d2NXh6cytpWFJ6YVlJYWdvdE1xVVBlWVh2bTZKNXJDNjFuRWdsNUNK?=
 =?utf-8?B?Wmd6UFozZDRYMG1IR0NOWjN1Zis0NkErY2JJSVRtclRlVXBiaXhSekxDVzRo?=
 =?utf-8?Q?4MMLi3x64Y9E1yPwTdQ7hwym1xAG7qM9YH6vOPTs9xzS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A0AA918A5CFB45B24912D557554BB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaacc44c-363c-453f-c9d5-08dac8022357
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 18:41:13.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ay68Z7MJMwGTn1xzqwITfFZXZqwGfGXi21TCPSp0NIdrhKWKCcPQ2EwndUb45SRfv0s2w544C2rUKfYCzekqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pg0KPj4+IEkgY29uZmlybWVkIHRoZSBmaXggYXZvaWRzIHRoZSBmYWlsdXJlIHdpdGggdjYuMS1y
YzUga2VybmVsLiBBbHNvLCBJIG9ic2VydmUNCj4+PiB0aGlzIGZpeCBtYWtlcyB0aGUgdGVzdCBj
YXNlIGZhaWwgd2l0aCB2Ni4wIGtlcm5lbC4gSSBzdWdnZXN0IHRvIHNraXAgdGhlIHRlc3QNCj4+
PiBjYXNlIHdpdGgga2VybmVsIHY2LjAgb3Igb2xkZXIsIGFwcGx5aW5nIHRoZSBodW5rIGJlbG93
LiBDb3VsZCB5b3UgcmVwb3N0IHYyDQo+Pj4gd2l0aCB0aGlzIGNoYW5nZT8gT3IgaWYgeW91IHdh
bnQsIEkgY2FuIGFwcGx5IGl0IHRvZ2V0aGVyIHdpdGggdjEuIFBsZWFzZSBsZXQNCj4+PiBtZSBr
bm93IHlvdXIgcHJlZmVyZW5jZS4NCj4+DQo+PiBJdCBzb3VuZHMgbGlrZSBzb21lIGZ1dHVyZSBj
YXNlIG1pZ2h0IGFsbG93IHRoZXNlIGVycm9ycyB0byBsb2cgaW4gc29tZQ0KPj4gY2lyY3Vtc3Rh
bmNlcywgc28gSSdtIG5vdCBzdXJlIHRoZSB0ZXN0IGNhc2Ugc2hvdWxkIGJlIHNvIGRlcGVuZGVu
dCBvbg0KPj4gc2VlaW5nIG9yIG5vdCBzZWVpbmcgdGhlc2UgbWVzc2FnZXMuIElzIHRoZXJlIGEg
bWVjaGFuaXNtIHRvIHNheSB0aGVzZQ0KPj4gYXJlIG9wdGlvbmFsIG1lc3NhZ2VzIHRoYXQgbWF5
IG9yIG1heSBub3Qgc2hvdyB1cD8NCj4gDQo+IFdlIGNvdWxkIGp1c3QgcmVtb3ZlIHRoZSB0ZXN0
cyBmb3Igbm93IHdoaWNoIHdvdWxkIGFsc28gd29yayBmb3IgcHJlLTYuMSBhbmQgYWRkIHRoZW0g
YmFjaw0KPiB3aGVuIHRoZSBmdXR1cmUgY2FzZSBzaG93cyB1cCAoSG9wZWZ1bGx5IHNvb24gLSBJ
4oCZbSB3b3JraW5nIG9uIGl0KS4gIFRoZSB0ZXN0IHdpbGwgYmUgY2hhbmdlZA0KPiB0byB0ZXN0
IHRoZSBvcHRlZC1pbiBhbmQgb3B0ZWQtb3V0IG1lY2hhbmlzbS4NCj4gDQoNClRoaXMgc2VlbXMg
dG8gYmUgdGhlIHJpZ2h0IHRoaW5nIHRvIGFkZCB0aGUgdGVzdGNhc2Ugd2l0aCByaWdodCBmZWF0
dXJlDQp1cHN0cmVhbSB0aGFuIGZpeGluZyB0aGUgYnJva2VuIHRlc3RjYXNlIGNyZWF0aW5nIGNv
bXBhdGliaWxpdHkgaXNzdWVzLg0KDQotY2sNCg0K
