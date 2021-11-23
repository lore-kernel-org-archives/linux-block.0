Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0B7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhKWQO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:14:28 -0500
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94]:1674 "EHLO
        esa.hc4959-67.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbhKWQO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1637683880; x=1669219880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qaz+D9+ka1tTKkp0cCQluLhu90vJMV9lidvZAYGMefM=;
  b=T6kCXysFPoxrPt3Dw1ltOcUgPOV/XIHWa4Zzlw1RkZNj+k9hGAgRuQ1Z
   1MoOI71Rkii30q047W0p1kX6wDMRKT392Fpg7AXLSvWL6MVZlIa1Bjss9
   mn7lcCLO0XoCa+gKmp78bO7MDX23Fw42OYGd+G+BfkG6UAZ+ArdHPVnVp
   I=;
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:11:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmuRNZNIWzwEpnmqVF3ijU8usroav/xw6t0SwtufWgMxiDm1Zs/c3p8c+p7i2/TzTeXJSndoPO+GaBuBmgB23TLc4Komphm/UByu8k3FkCVaKVqxW6Yn82h/wbHWAiMk/Y1pCQoUPhzkvNoC5aDVg5oJKn6xirgfbyA7Tb8KBIkDnrl/YDUrgtcdym3LODVQ6P6mBiFNe5txfRNg2s15hbZNm3OUAuFnuRrfZVMnBg1Fyx4u6Oq7SzUcbYAXHcKSLEYHkRvj++Nk+RKhVSHgdwtx1iZTX186i1n1aGEu9RRY5JhyrXn8rFxENYH2Do67xeNWjkwo0MskmaOq2Jv0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaz+D9+ka1tTKkp0cCQluLhu90vJMV9lidvZAYGMefM=;
 b=ABJqHJ5xUATO+UIlIutG80eYcL43iiXZY2+JyvZYs/dB7msAot/VEpUwXGQqmnOeOPZfJkXLUkhTY3fHwGG8+jYRxqpvWwIJVfZmf5/UqRNDiS7ZBCbpIt1hTSS151c4bmFGn9FUrPAZxvNQ1S4ZNhM5y0EE6UOWANZ7IYfct/xWL7odh83GFilgSEVUnW+EtO/qNmQ9+eJGjcgjV3JDgasoOpRcnAVVcBfqjnaPhUN4ZYiJLwQX+za80AsLswROpkzMKi5XvmpSK/x91u6CK7NmFBCOQ1pCbXXUNvyAB+NwfUsTJ/KCwwVMS+ieayad9u9AFJkRBXCRgm4SyNBfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaz+D9+ka1tTKkp0cCQluLhu90vJMV9lidvZAYGMefM=;
 b=E/RwgkaQ5rmRG7HffKBddmkYLryGUEUkgujCylSCor3bl00JQ/7BkDwIvTxGBMHVauNuIjK8MbdO50KNvrtwxq6wQ7OlcWNIJUugrfT1EMDslznRgtp/bW2mMiM+sIg6/trDUkyoSR2bJr+7QCOl+FU9yzOFIbhmg/U/2q4wAjk=
Received: from CH0PR20MB3963.namprd20.prod.outlook.com (2603:10b6:610:df::10)
 by CH2PR20MB3143.namprd20.prod.outlook.com (2603:10b6:610:e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 16:11:10 +0000
Received: from CH0PR20MB3963.namprd20.prod.outlook.com
 ([fe80::a172:bb14:3e37:d51f]) by CH0PR20MB3963.namprd20.prod.outlook.com
 ([fe80::a172:bb14:3e37:d51f%3]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 16:11:10 +0000
From:   Tim Walker <tim.t.walker@seagate.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into scheduler
 queue
Thread-Topic: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Thread-Index: AQHX3JFMHVHpph1UsEOPk1igXvdaHawLzL+AgAUvwQA=
Date:   Tue, 23 Nov 2021 16:11:10 +0000
Message-ID: <5A6B1B6F-88E6-4C22-B72E-A657A58F5877@seagate.com>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
 <163732851304.44181.8545954410705439362.b4-ty@kernel.dk>
 <BFC93946-13B3-43EC-9E30-8A980CD5234F@seagate.com>
 <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com> <YZhygSJylK4WeRNq@T590>
In-Reply-To: <YZhygSJylK4WeRNq@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.55.21111400
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7275c50-82e3-42ab-2771-08d9ae9bdd64
x-ms-traffictypediagnostic: CH2PR20MB3143:
x-microsoft-antispam-prvs: <CH2PR20MB314381719D61BF8EF1288CBFD7609@CH2PR20MB3143.namprd20.prod.outlook.com>
stx-hosted-ironport-oubound: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1G4Okp4ZtLp5ZksM29/HGSE4x8cFFPbqEuxY//x6bs9uSrqYwokSjA86Z5I9zJ3ZIeQwinWkHhBMlTyuothWUHL/84psZrwT46dhnveGCWuqIVQI0jJio6hrOR4Oi3MHhR8b+fdyMzpfoIlT8xOrqc6EGeWxOUfkCGdER2eAdaJAII+a/GxggaTxLaKpU5AP3eEhI9FNb260LWb8L5dyC7L6bVl7ZNF8UBSXcYsAlRNKOQQ4paB+4t/CDXe+KJtNoQZUY2bzAXFe9bKnB1DUctQ/peqbp2f36qdKdSesqdx91w3mB1oDLRdQ+AVFqVcw6owYUKIJQWLTRXmBxBw/WG4pSYWjMGff31BX8JCPBNjQCuVQBEx3i0tXU6eTM4LS5Ecl3Cm3qkjRb/DFvPlrVPrMSaj9baRLzLMNmAfOdjzr6KUPEjWOhgcMFqCCKrfKHxeCe0aotmsJSDnszrkE4lEFJroPe8ZwNoIN4w+H3/HN2iOK799+ezVbWPltZxOrjIon8ZATypCs3rWdjQBJiTRL25OFAvMGynpVqyyvZgqSMQzkohMDX8vW/G+WWch335fx7q+uFstE/rL8KKUVHyKhaFIaTzOF4XfxmuVAjhb3vJ3R2edaJrFg8K/xSVN7RQ+JEQsqYP2DZw3/INKbcwXgs/rn2o/q3oVIRSp1rh7jCHbHxZu1+WeCtj4xlSXawkIcucxXsytY2fSgUlFjtDr/HPTzg7ACPIIA3Dhl1+lmCU7DrZ3MdRgCNQXtj7D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR20MB3963.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(316002)(36756003)(26005)(6506007)(186003)(6486002)(38070700005)(86362001)(2616005)(54906003)(8676002)(8936002)(2906002)(71200400001)(83380400001)(508600001)(122000001)(6512007)(33656002)(38100700002)(6916009)(76116006)(91956017)(66446008)(66556008)(5660300002)(64756008)(66946007)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2JmWU55NU93ZTBRRkFtclJQdHZVV1hmem1rSDRST1R5OUIzaitoTEZmbnVS?=
 =?utf-8?B?VHNoRFdjMDlLUkxKQWlPcC92Uk5YM240SEpuV0R3UHZDSFY1dFpJUEJMV2Zo?=
 =?utf-8?B?aFlKSlhpUmY5SnFyaWRZRlhCaXd5dmFRYTVoTkdPcklqUFlydHRQZ3g3UXlX?=
 =?utf-8?B?aHZjUjlMWi81cEpMY1dMc3dMVXNlcDdzUjZha00vZ1FwOTIvR1ZjT3g2TXBY?=
 =?utf-8?B?a3h6YlVydXRlK3hETnRTWnBRRjFWSWlKckFjclB3ZlhtUWNGTmczMkFxNUR1?=
 =?utf-8?B?VzJuTzdFTTh6SXVlbkFDUGdVM2pyaEZTclQ4dlNNVWkveklYRDlINTkyMGo2?=
 =?utf-8?B?MFh2UXB0enNwM1lEZ043RU4xMUdJTHZRNytrNVdsc1lReFpPZHlKQzcyMzB4?=
 =?utf-8?B?WFNhZ1BqMGhFZDNHMzlLRjBzZmtuTnZ3SVROMjRxN3JlaFlSV3RrRFgrWVI4?=
 =?utf-8?B?QWRSalJwNlZCTE10NW9tRklhSjlDRjRPRXFBeldWODdITDM0T1RQT29kN1RI?=
 =?utf-8?B?akN4U0R5RzJhTFhoVUt5ODIvS0Z4eDdXYnlmM1hsd0FYZnB3OHpoUWtMMTM0?=
 =?utf-8?B?Y3lTUjZzbHBhcGF6Qk1XN0kxeW5iL0h3N21wYjlCbDdSTnJ1a3pCMEFKTEcr?=
 =?utf-8?B?UTQ2azhzTXVCTS9FNGtXZ3IvSFVZVS9kT1VJR3RFbmZHUkFkNFBnbEdKdmc0?=
 =?utf-8?B?Q2lXdVA2UHBWN01yWGpTMTNkRnpXT0psRnkyL0RzeWYwUFhEVER0RHFiazV2?=
 =?utf-8?B?QVpUTlEvdEhDZ1Y2VVkwRHB6dXJHZnloaGhRS09WSWFXQlRRa1hSaWVqUUJt?=
 =?utf-8?B?dzhaR3ZYdk1yeUp5TTc5QUdxRzRIQWU2b3hudkN4dXZMTWFGZVlrcE5FZ3lm?=
 =?utf-8?B?NU56RFNDTWhXRVpwZUFiS3lVRFpOZEpteTlxZDJkYUNMNXcwU3FCYjZSY2ha?=
 =?utf-8?B?dVNoUktDQkZnRHhrTy9PS2JPOSs2KzdHUHZiYkQrY3lDMTZCWTlaMzJHVjRi?=
 =?utf-8?B?aVR1ZXRSaTUyZGU4aWIzaEU4cTltem4zdFZCZ3YwZHlxa2JaTVR6MlFPRUtS?=
 =?utf-8?B?eEFNaUQzNmRhQ1YwdVU0ZHZ2eTRGMEVkaGlqaGh3dUdpNGh5bHplc09NWDVu?=
 =?utf-8?B?L0FWRzU3WTdIc3RVZG1OQ0YrRDNOUUJmWmhDRzBkVVBIbm5wbmlwc3doaTZ5?=
 =?utf-8?B?WmV2dkV0VStxT05WTkJ1UFdBTHlLV1JsRTlQbmpydVRwUnNqQ3Y0dDNYMlJz?=
 =?utf-8?B?clRQN2lWSWV2QzRkYkJGZlZxdXpoQi81M1JNdlcrc3RFeGlMMm9WTWVJYmVN?=
 =?utf-8?B?NXZ5WUZsYWlaWFFXd3NzMURPNXV1ZSszWXo1a0lMZE9FWk45d2NqVHNXRFF2?=
 =?utf-8?B?bTd4LzU4ckJ1RVRiM3ZtbWlVVzV2alJEL2pPZEw4dmdqd2tKWUtDNkYvbitF?=
 =?utf-8?B?UWVTVk0yd3FCa2NCQUdsT1RkbUlRSTVhWEx0QU44WWJvRThFclhHTk1hVFZ4?=
 =?utf-8?B?eTN5TWF3UU0wM0NCNEpTUHliTHR4K21SaGI1bFFyWmZZcFQxRmVkRm1nZW81?=
 =?utf-8?B?WmNwenVYL08wcDVabGQyb1NZcEhhUnBDTHpHeUFDVUlCMElVWFpncTBMM1pr?=
 =?utf-8?B?QTJqU2NIOHZtTjdXV0dkUU5XNGl5ZWs4Yk4zMWNpaU93T2NBTC9JbTdUTWdG?=
 =?utf-8?B?YlRWQmxlZDNEK1ViTTFFZXZsaTMzZ0loeXUvdURCR2g0TTRUWEVHbkZIdHdw?=
 =?utf-8?B?bU44TGx6MHNDOXA2S1lvUEZmT1VRWE1aWEpnSHREanFiZEdQUkVtV01rLzZv?=
 =?utf-8?B?ZmVNQjFJRFFqRGxYRTdwMGtyOUFpRU9vVkpGQjZhUklkU1RLeXY4eUZWaWY0?=
 =?utf-8?B?a0J4ZW1PanZiK05LVmlQdC9Va3hISjB4UTJJMjdrSWlVKzUydGpzdm9NTGRo?=
 =?utf-8?B?TUdGbTlRMGk0SjFsRThDTnRUNG1KbU9YWDd5dGVzZEw1MXZjYkZxVlNlQjlN?=
 =?utf-8?B?M2ZVUGdpbm1iTzl1eno3K3dIRDJJVUVqNjk2T3JRaTRla0VhNzEyUmJIWTNT?=
 =?utf-8?B?dUJ1TDY4b3JlZ2lTRW9DUU5PTGVzbjMwRWVuYWRyM2E5MG9tbGc5T2plcnZq?=
 =?utf-8?B?UlBwRFBVc2NqbzB4RmI3WHVzUDVKMmYzR09JTHpzeFRmdFdMSmdMZ3RvZkdC?=
 =?utf-8?B?dVU5VjhpZE53QjZHRGJPS2ppMTgzOFVaNzhvZGRGNDhHY2VZTGlya0VSbGFr?=
 =?utf-8?Q?7GS94IFLhvL+TWfW3DME395QjkIVXGF5Z7Y3tMyyYQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2411BCCE7798B4792C3C0FCBA05DE64@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR20MB3963.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7275c50-82e3-42ab-2771-08d9ae9bdd64
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 16:11:10.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aet0MVHerNk04BwIBW/wtFAyxHvJu9pvJvKIIsyRqSDqKmMR0YBzgCL4HmNUvb4tb81AT7M0yk5fW30VSTclZQPgCFKpeXHLnhHJznLD9Bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB3143
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCu+7v09uICBGcmlkYXksIE5vdmVtYmVyIDE5LCAyMDIxIGF0IDEwOjU5OjI0IFBNIE1pbmcg
TGVpIHdyb3RlOg0KDQo+DQo+T24gRnJpLCBOb3YgMTksIDIwMjEgYXQgMDQ6NDk6MzRQTSArMDAw
MCwgVGltIFdhbGtlciB3cm90ZToNCj4+DQo+Pg0KPj4gT24gIDE5IE5vdiAyMDIxIFRpbSBXYWxr
ZXIgd3JvdGU6DQo+Pg0KPj4gPg0KPj4gPg0KPj4gPk9uIFRodSwgMTggTm92IDIwMjEgMjM6MzA6
NDEgKzA4MDAsIE1pbmcgTGVpIHdyb3RlOg0KPj4gPj4gV2UgbmV2ZXIgaW5zZXJ0IGZsdXNoIHJl
cXVlc3QgaW50byBzY2hlZHVsZXIgcXVldWUgYmVmb3JlLg0KPj4gPj4NCj4+ID4+IFJlY2VudGx5
IGNvbW1pdCBkOTJjYTlkODM0OGYgKCJibGstbXE6IGRvbid0IGhhbmRsZSBub24tZmx1c2ggcmVx
dWVzdHMgaW4NCj4+ID4+IGJsa19pbnNlcnRfZmx1c2giKSB0cmllcyB0byBoYW5kbGUgRlVBIGRh
dGEgcmVxdWVzdCBhcyBub3JtYWwgcmVxdWVzdC4NCj4+ID4+IFRoaXMgd2F5IGhhcyBjYXVzZWQg
d2FybmluZ1sxXSBpbiBtcS1kZWFkbGluZSBkZF9leGl0X3NjaGVkKCkgb3IgaW8gaGFuZyBpbg0K
Pj4gPj4gY2FzZSBvZiBreWJlciBzaW5jZSBSUUZfRUxWUFJJViBpc24ndCBzZXQgZm9yIGZsdXNo
IHJlcXVlc3QsIHRoZW4NCj4+ID4+IC0+ZmluaXNoX3JlcXVlc3Qgd29uJ3QgYmUgY2FsbGVkLg0K
Pj4gPj4NCj4+ID4+IFsuLi5dDQo+PiA+DQo+PiA+QXBwbGllZCwgdGhhbmtzIQ0KPj4gPg0KPj4g
PlsxLzFdIGJsay1tcTogZG9uJ3QgaW5zZXJ0IEZVQSByZXF1ZXN0IHdpdGggZGF0YSBpbnRvIHNj
aGVkdWxlciBxdWV1ZQ0KPj4gPiAgICAgIGNvbW1pdDogMmI1MDRiZDQ4NDFiY2NiZjNlYjgzYzFm
ZWMyMjliNjU5NTZhZDhhZA0KPj4gPg0KPj4gPkJlc3QgcmVnYXJkcywNCj4+ID4tLQ0KPj4gPkpl
bnMgQXhib2UNCj4+ID4NCj4+ID4NCj4+ID4NCj4+DQo+PiBJIGtub3cgdGhlIGRpc2N1c3Npb24g
aXMgb3ZlciwgPg0KPg0KPlRoaXMgdGhyZWFkIGlzIGp1c3QgZm9yIGZpeGluZyBvbmUgcmVjZW50
IHJlZ3Jlc3Npb24gY2F1c2VkIGJ5IHF1ZXVpbmcNCj5GVUEgZGF0YSBpbnRvIHNjaGVkdWxlciBx
dWV1ZSwgYW5kIGFjdHVhbGx5IGRpcmVjdCBkaXNwYWNoIGhhcw0KPmJlZW4gZG9uZSBmb3IgdmVy
eSBsb25nIHRpbWUsIGJ1dCBJIGRvbid0IG1lYW4gaXQgaXMgcmVhc29uYWJsZS4NCj4NCj4+IGJ1
dCBJIGNhbid0IGZpZ3VyZSBvdXQgd2h5IHdlIHRyZWF0IEZVQSBhcyBhIGZsdXNoLiBBIEZVQSB3
cml0ZSBvbmx5DQo+PiBhcHBsaWVzIHRvIHRoZSBjb21tYW5kIGF0IGhhbmQsIGFuZCBpcyBub3Qg
cmVxdWlyZWQgdG8gZmx1c2ggYW55IHByZXZpb3VzDQo+PiBjb21tYW5kJ3MgZGF0YSBmcm9tIHRo
ZSBkZXZpY2UncyB2b2xhdGlsZSB3cml0ZSBjYWNoZS4gU2ltaWxhcmx5IGZvciBhDQo+PiByZWFk
IHJlcXVlc3QgLSBzZXJ2aWNpbmcgYSByZWFkIGZyb20gbWVkaWEgaXMgcmVhbGx5IG1vcmUgdGhl
IHJ1bGUgdGhhbg0KPj4gdGhlIGV4Y2VwdGlvbiAobG90cyBvZiB3b3JrbG9hZCBkZXBlbmRlbmNp
ZXMgaGVyZS4uLiksIHNvIHdoeSB3b3VsZCBhDQo+PiBGVUEgcmVhZCBieXBhc3MgdGhlIHNjaGVk
dWxlcj8NCj4NCj5JcyB0aGVyZSBsaW51eCBrZXJuZWwgRlVBIHJlYWQgdXNlcnM/IEp1c3QgcnVu
IGEgcXVpY2sgZ3JlcCwgc2VlbXMgRlVBDQo+aXMganVzdCB1c2VkIGZvciBzeW5jIHdyaXRlLg0K
DQpJIGRvbid0IGtub3cgaWYgTGludXggZXZlciBpc3N1ZXMgRlVBIHJlYWQuIEkgd2FzIHRoaW5r
aW5nIGZyb20gdGhlIGRldmljZSdzIHBlcnNwZWN0aXZlLg0KDQo+DQo+PiBUaGUgZGV2aWNlIGlz
IGFsd2F5cyBmcmVlIHRvIHNlcnZpY2UgYW55IHJlcXVlc3QgZnJvbSBtZWRpYSBvciBjYWNoZSAo
DQo+PiBhcyBsb25nIGFzIGl0IGZvbGxvd3MgdGhlIGFwcGxpY2FibGUgdm9sYXRpbGUgd3JpdGUg
YW5kIHJlYWQgY2FjaGUgc2V0dGluZ3MpLA0KPj4gc28gbm9ybWFsbHkgd2UgZG9uJ3Qga25vdyBo
b3cgaXQgaXMgdHJlYXRpbmcgdGhlIHJlcXVlc3QsIHNvIGl0IGRvZXNuJ3Qgc2VlbQ0KPj4gdG8g
bWF0dGVyLg0KPj4NCj4+IENvbnNpZGVyIGEgRlVBIHdyaXRlOiBXaHkgZG9lcyB0aGUgZmFjdCB0
aGF0IHdlIGludGVuZCB0aGF0IHdyaXRlIHRvIGJ5cGFzcw0KPj4gdGhlIGRldmljZSB2b2xhdGls
ZSB3cml0ZSBjYWNoZSBtZWFuIGl0IHNob3VsZCBieXBhc3MgdGhlIHNjaGVkdWxlcj8gQWxsIHRo
ZQ0KPj4gb3RoZXIgdHJhZmZpYy1zaGFwaW5nIGFsZ29yaXRobXMgdGhhdCBoZWxwIGVmZmVjdGl2
ZWx5IHNjaGVkdWxlIHdyaXRlcyBhcmUNCj4+IHN0aWxsIGFwcGxpY2FibGUuIEUuZy4gd2Uga25v
dyB3ZSBjYW4gZGVsYXkvY29hbGVzY2UgdGhlbSBhIGJpdCB0byBhbGxvdw0KPj4gcmVhZHMgdG8g
YmUgcHJpb3JpdGl6ZWQsIGJ1dCBJIGNhbid0IGZpZ3VyZSBvdXQgd2h5IHdlIHdvdWxkIGZhc3Qt
dHJhY2sgYQ0KPj4gRlVBIHdyaXRlLiBJc24ndCB0aGUgdmFsdWUgdG8gdGhlIHN5c3RlbSBmb3Ig
c2NoZWR1bGluZyBzdGlsbCB2YWxpZCwgZXZlbg0KPj4gdGhvdWdoIHdlIGFyZSBmb3JjaW5nIHRo
ZSBkYXRhIHRvIGdvIHRvIG1lZGlhPw0KPg0KPkl0IHNob3VsZG4ndCBiZSBoYXJkIHRvIHRvIHF1
ZXVlIEZVQSBpbnRvIHNjaGVkdWxlciwgYnV0IGRldGFpbHMgbmVlZCB0bw0KPmNvbnNpZGVyLCBz
dWNoIGFzLCBpZiBGVUEgY2FuIGJlIG1lcmdlZCB3aXRoIG5vcm1hbCBJTywgbWF5YmUgb3RoZXJz
Lg0KPg0KPkFsc28gZG8geW91IGhhdmUgYW55IHRlc3Qgb3IgYmVuY2htYXJrIHJlc3VsdCB0byBz
dXBwb3J0IHRoZSBjaGFuZ2Ugb2YNCj5xdWV1aW5nIEZVQSB0byBzY2hlZHVsZXI/DQo+DQo+DQo+
VGhhbmtzLA0KPk1pbmcNCj4NCg0KTm8sIFVuZm9ydHVuYXRlbHkgSSBkb24ndCBoYXZlIGFueSBi
ZW5jaG1hcmtzLiBJdCBzZWVtcyB0aGF0IEZVQSBjcmVhdGVzDQphIHNob3J0Y3V0IGJ5LXBhc3Np
bmcgdGhlIHNjaGVkdWxlci4gSXQgZG9lcyBub3Qgc2VlbSB0b28gaW1wb3J0YW50IGZvciBmbGFz
aCwgDQpidXQgb2YgY291cnNlIEhERHMgYXJlIHZlcnkgc2Vuc2l0aXZlIHRvIHdvcmtsb2FkLiBU
aGUgc2NoZWR1bGVyIGF0dGVtcHRzIA0KdG8gZW5zdXJlIHRoZSBiZXN0IHdvcmtsb2FkIGZvciB0
aGUgYmVzdCBwZXJmb3JtYW5jZSwgc28gcGVyaGFwcyBhbGwgcmVxdWVzdHMgDQpzaG91bGQgYmUg
c2NoZWR1bGVkLCB1bmxlc3MgdGhlcmUgaXMgYW4gYXJjaGl0ZWN0dXJhbCByZWFzb24gdG8gdGhl
IGNvbnRyYXJ5LiANCkZyb20gYSBIREQncyBwZXJzcGVjdGl2ZSB3ZSBzaG91bGQgc2NoZWR1bGUg
YSBGVUEgd3JpdGUgdG8gbWFpbnRhaW4gYW4gDQpvcHRpbWFsIHdvcmtsb2FkLCBhbmQgSSB3YXMg
bG9va2luZyBmb3IgdGhlIGJsb2NrLWxheWVyLWFyY2hpdGVjdHVyZSByZWFzb24gbm90IHRvLg0K
DQpQZXJoYXBzIEkgY2FuIGdlbmVyYXRlIHNvbWUgcHJvYmxlbWF0aWMgd29ya2xvYWRzIGFuZCBw
b3N0IHRoZW0gbGF0ZXINCmZvciBkaXNjdXNzaW9uLg0KDQpUaGFua3MsDQotVGltICANCg0KDQoN
Cg==
