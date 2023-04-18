Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8DC77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 07:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDRHAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDRHAO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 03:00:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFC1A2
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 00:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWpJBqiY0C1nkj30be7OWbua2kcykzJsm1kVqfubDmrQfYlUQv6tCCzMO1XJKwKnvUgaDSglY3Lthgk+s71DJOMsK+2HeBVb/HqnlSUrOjQQjbgEPMasSjSdddciBZqwxM9WQMmxLwTu6KclUeV3vQqVA9FG8aOoI9x/IszTYmzto2B4dd1PAFeKHiCryU1pCf4Z8Ad1hnUw38ZhNTxUpx/HHD6LOJhMgEo7o2/XCtpxCizWBdDHUDb3fQG8WmqEvbX7zm0nRsmNm66qXCXzMWm56IJ93YqQ0j86aLuflQd6ReDziU7gGzWDD0DFewui8U9OL4tJjEWcPvlf8zXQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45NqhdPE0N/803wQ4pFgGEzkf0UaafjApnFBdFfJYuI=;
 b=MAuh7tawwgleKZgpPNI81vMj8sE2FsvEAVhrUFMHaCnfLHxyLKl4bkAoxs1BJk2aez24ZzY6Dn1DKjAC4TldTqAjrvMqL4mhKLjgIk7mhFLjs4CdF84jIACPEhqopohSTRxQyWEN8OXPeYCkD6WqngPcAyrmRnutAQVVgq4FiCQavogdnn/FHS74RfodxyrKSieHHeBXlKXrnv435JA4eVefiiC5UTU/YdAHTo7DvUqXw599EVmVFSNJ48nufPSzTXEjgSTgV+KoFjrA+mZUOqrKBxYkHMGWQvkOvjmK1B+sZ823WtMdwAAmPP1SXYBo6A4WeCIdUx41lw9e8hvgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45NqhdPE0N/803wQ4pFgGEzkf0UaafjApnFBdFfJYuI=;
 b=QbXzlSrRbxYPFPX70GT0SnfyFMpJihhH5o4H6li02cRnaCgNSeheDqpf54zk8EWWh4BiWExY8V2vJ7BNb4prjHl6LsTJ0ZiCInzoHtNHmg2oyFqs/YdZCpCJfuaS7bbr7oD0ezM2+wmo8azzcKWszjetkne8IcRpF3KIX9kdIRWwmAVnA0J7zXjCMkZm5LyLyUfKeaeJ6jMbEzmGgFVZmbcKzuN2nV1usWmwE7PoMuD0X7S9K1kyEhNy+cyZXOIgjycyOeYh+IsOebWaLW8OL9CtFCu176Ecrj8LqeGmz9hM4aVuz5TRUiY44pKgN4BXl5KFHUdSQWemqG+r5o/vFA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 07:00:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 07:00:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZbRuBGnDoA0PLrUmq3zDXdDqS5K8na52AgAlA+IA=
Date:   Tue, 18 Apr 2023 07:00:04 +0000
Message-ID: <8bab3920-0177-c0eb-48bc-13803e115ff6@nvidia.com>
References: <20230412084730.51694-1-kch@nvidia.com>
 <20230412084730.51694-2-kch@nvidia.com>
 <5f2abec9-6d5c-7590-5ba9-f2886d98f1ae@kernel.org>
In-Reply-To: <5f2abec9-6d5c-7590-5ba9-f2886d98f1ae@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7996:EE_
x-ms-office365-filtering-correlation-id: f87b2efc-6cbb-43af-6869-08db3fda8943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YmXOKOdCl45YpYrtlhWqLo1yLLHFEFf8p9EYidmMmnyy/tb7lL+gSPVNmVKXM6UIogDtujjQEw03xJiKG3d0TwPcgcdUp8Yr9/fs6+Q3FJtrPjWNMLJUC6/UNAkVbv4Fk6/WBPp4Rj+ARJsj8oxKv0TXHyPXD1GePwYwSvffbHr18P+tVM4ZgoUgC2WL1txxrz3SMD8Gw0oVWST6WrqOVq9ZhegHBpUYYafwQQRe1YuIBMIojTL18jqf9TIr6Q+Y2tR6RIcy3BlPb0+jqruh4RS+9MMUj8ndhUi4PUCWM24EHNva0xr75HpxBcdVQmqRLobIaHzA/1wJwh6E6I6JAG9TnAyzrmMLITdlLL9m/mZzcqLltni30D/DwITB9vdXyS3YaS5Ck3pP+eJ6IF/jdnUHtGBzE1Ur2IFCv7Qs7VFVMFgdGmhrRIp0Tn4GHKCTwm1RErF7BriZe40VGLFUV6V1lkhZwRcd0MTY+fEjUPGURyHpsxw0ts13VzFa4cOj38O1plA1w8jSvhJrkdg5fzEoxAK7mgY9zuZTmTRyjxOPKXtnVZD0NdwrgmoYYkHHTdeq4UJBzEKvY88RvRH0qlDoPMBEc4m54RA74jUL0rKlgnU98v/JvU7FxfNDyoGsoE56HwUgEwsh/2LmFOwsOOOzEAoZvFYESYmHXJXf3aZoT/OQtevBinou+IFtHol+K3zx63qaJ1wOQctRPX4CNLIO3s/lficUvt8NSk0rOLw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(31696002)(122000001)(2906002)(38070700005)(966005)(478600001)(71200400001)(6486002)(2616005)(38100700002)(83380400001)(53546011)(6506007)(6512007)(31686004)(86362001)(186003)(36756003)(41300700001)(316002)(5660300002)(8676002)(8936002)(54906003)(110136005)(66556008)(66446008)(64756008)(66476007)(4326008)(66946007)(91956017)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekRnOWl3aFJ0bzBhQnlkNE5GUEFOSDdCa2kwWW9MSnBVUDJXRE5QNkZNc1F5?=
 =?utf-8?B?RXpMc0FCUFpmUE9WTlRVK3ZmanQwbU1HUG9QUlZIZVNUYkVXaUdJanM3NnNT?=
 =?utf-8?B?S1I3OUt0N1g0ZWlZSW96eU90WkZmbVl1LzhjMSs1czJKVHorMlBQdld6UHRw?=
 =?utf-8?B?T1h6UmtSTnZyVFREQ1E0Ty9ENUcwTjBKVjVpMHU2UFkyV2k5WWpDSnRLUk9s?=
 =?utf-8?B?UzhWM1p2SmhoemE2aTYzZHZYMjk4Ykx2b1ZOYXFudEJLcEdYcGVNdllOOXBv?=
 =?utf-8?B?OHZES0Z6MUJScG02YnpweHFuS2JJVG9oUFErRXJZS3ZZTzRDemt6eGIvZytr?=
 =?utf-8?B?ODRyYmliMUZzbnh5cmJrVUJsZGt0akV3dC9CVkhLT0JlOWREOXJac1V5QlFV?=
 =?utf-8?B?SHBaYjVZVE1OTnB6eS9RWEZzckE0MC82T2oydW9Wb3daREhlanZjRXAzb3dX?=
 =?utf-8?B?Qy9iZzBxRUVOcTYvTy9sSngwalZMbnFVUzlsMU9nbGRsQ3JXNHh3akk2WXha?=
 =?utf-8?B?MmhJSUlIVFhLYjhLSXJxd3paajZzMUJZMnNWZCtiRE52WGhTVWpnRUZFM05Y?=
 =?utf-8?B?eXJQRkJoc21tdkMxVEdQeXBybjhKVmxsWUk0TXJ6bUd1cDk3V3VnQ28weEla?=
 =?utf-8?B?bTdwc1FDZUFJQ1RZZWluZTZvTmMramhmWXpCUFI5VWRUZEJwMk9ITVhPSDlz?=
 =?utf-8?B?TUZxTmpWMGh2SnRFTlZrZEdOcllKd3oyUTdkTG16R1daYlJWeXVDNHJlN0o2?=
 =?utf-8?B?Y3NCdUxaUndHSFpzMWNOUHRtSGY4eGtXSy9UOTBROVZaVUY1U0ZHMFJidnJL?=
 =?utf-8?B?cVVpQzBFdFJtMEh1NjdBODMwVGZacXpXMStuQ3NqQlJmRTk0ekdZY1hhVkEx?=
 =?utf-8?B?cGFsNzdIMjlMOUZicGMrU2Vsb1RzaklLeWVEUEYySUFpa3VhQVVaancwNDBM?=
 =?utf-8?B?RGdRNjRnSXo2Q3NmU0JUSUw5aEZ0QUZPYzRsdkVQQ0twcVEyb3pFQ1RrZGoz?=
 =?utf-8?B?aEpLSjI4bXdpYkF5eTVvYUtTcThpV25pUXByMHUyRHFHczgyK2MxdEFoRVdv?=
 =?utf-8?B?SENlVThTcXhqNHhmazU3VUx4L3lOOWtDbG8vdTAzaWx0R2JYaVpyQ09Hd2Yz?=
 =?utf-8?B?ZEZ0T0l4dDZIcUJEVTJKaGsyT0VNRVA1SC93ZitSUTQ5enp4dGJQOFJkVDNv?=
 =?utf-8?B?aUFQYVFhMXc0aG1MaWhQd2FkK1JvL3JxVklmSDdqc2huajJTZ0JuQWVIaDBq?=
 =?utf-8?B?TTBMVlEydmZGcS9JajlQZ2ZTazNvaE5tVGJHcUdpMk54N0NtNGJIVGx0VUkz?=
 =?utf-8?B?bFRXZVM3TGREazVQSlgwWWZsbUVZSlc2LzBhQ0NkcVI1V291MzE2Yk84eEdO?=
 =?utf-8?B?VG9kczRwRlhTeVdxeHVqejNNY1lFMFpneElmd1FpdVUwWlZyMnF1SHJicklw?=
 =?utf-8?B?K0tHUXFuR0EwVG5GeG9uUGp6QTZEbTgwcGtHdDNFcktGK1RqSHc5N3A0UUlC?=
 =?utf-8?B?YTZZQ2VNVUlzUm9FSGM5VnQzSnc4WjRJdERtTU5sUnJOTDN4djBSOC92ZHpz?=
 =?utf-8?B?Qm5iTElXQ01RY3g0QzNwaW1NcS9QU01ITmgzV3VmNnFqa1p4TTNOdE54N1NS?=
 =?utf-8?B?cEtWKzlaMkV4RERxNzBsOXRpVERRZjNBQ3hoUHZhM2gvOGJtK0ZmeEtaYUc3?=
 =?utf-8?B?Q1VzbGlMS3dvVmFRNVIzalRTMDgrbEY0UDRSQzNDN0FBOUh2WlplOExOM0RC?=
 =?utf-8?B?WXNaNEhFdjBvK1lENnhSckhPMEs4K2R5MGRXcjZxeGJhMzA4Qm9oYWQ2Um9D?=
 =?utf-8?B?eWhTYzNFdTRxMG1SUzhhRWUvVW5WMUk2bXFldHFqdmQrcjkrVVBRYXVxSXh4?=
 =?utf-8?B?VStVUXpObkhtVTg2ZlJmeTFxUnA2R2hiQTk1TWpEVW1qMzNsQ2ZFZUpzNTlJ?=
 =?utf-8?B?Z01Jbjl5SUdIbWpETVI5RkwwR0wwV2pDMTBVL21zMzg1QUVVd3M3aWthbWNQ?=
 =?utf-8?B?TlBYRmVtaGZtWWZWR0wvZExaYkJ3djhkZC90S0luSkIvLzNkOFVxZXF1bmEy?=
 =?utf-8?B?blRJVTFOL09IMFlhaFBYMkVYZUE1K3IyWnNtME5EUmh0ZUtpZTlrS1NNRllP?=
 =?utf-8?B?azFyZHNTMnBKNHNERFlRRWRsT3NXeklUeGgrLzdUSDEzeTJiSDhscE5sdHUz?=
 =?utf-8?Q?yh20HwG+aPjR717Wt+j/6wX2z1gzkrhI+7H0ttFPekzU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D3950F3F4573E45B1345B5CDDF0A140@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b2efc-6cbb-43af-6869-08db3fda8943
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 07:00:04.0755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4sCMuLKaRIV8UMrOCXCjLSaMHDNhe0uYCob1aR03pg24PctAZrvpMKnrR0i2onldiI+oH2A9BXU8ynUq/CWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xMi8yMyAwMjo0MSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDQvMTIvMjMgMTc6
NDcsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IFFVRVVFX0ZMQUdfTk9XQUlUIGlzIHNl
dCBieSBkZWZhdWx0IHRvIG1xIGRyaXZlcnMgc3VjaCBudWxsX2JsayB3aGVuDQo+PiBpdCBpcyB1
c2VkIHdpdGggTlVMTF9RX01RIG1vZGUgYXMgYSBwYXJ0IG9mIFFVRVVFX0ZMQUdfTVFfREVGQVVM
VCB0aGF0DQo+PiBnZXRzIGFzc2lnbmVkIGluIGZvbGxvd2luZyBjb2RlIHBhdGggc2VlIGJsa19t
cV9pbml0X2FsbG9jYXRlZF9xdWV1ZSgpOi0NCj4gQ2FuIHlvdSBmaXggdGhlIGdyYW1tYXIvcHVu
Y3R1YXRpb24gaW4gdGhpcyBzZW50ZW5jZSA/IExvb2tzIGxpa2Ugc29tZSB3b3JkcyBhcmUNCj4g
bWlzc2luZywgbWFraW5nIGl0IGhhcmQgdG8gcmVhZC4NCg0KZG9uZS4NCg0KPj4gbnVsbF9hZGRf
ZGV2KCkNCj4+IGlmIChkZXYtPnF1ZXVlX21vZGUgPT0gTlVMTF9RX01RKSB7DQo+PiAgICAgICAg
ICBibGtfbXFfYWxsb2NfZGlzaygpDQo+PiAgICAgICAgICAgIF9fYmxrX21xX2FsbG9jX2Rpc2so
KQ0KPj4gCSAgICBibGtfbXFfaW5pdF9xdWV1ZV9kYXRhKCkNCj4+ICAgICAgICAgICAgICAgIGJs
a19tcV9pbml0X2FsbG9jYXRlZF9xdWV1ZSgpDQo+PiAgICAgICAgICAgICAgICAgIHEtPnF1ZXVl
X2ZsYWdzIHw9IFFVRVVFX0ZMQUdfTVFfREVGQVVMVDsNCj4+IH0NCj4+DQo+PiBCdXQgaXQgaXMg
bm90IHNldCB3aGVuIG51bGxfYmxrIGlzIGxvYWRlZCB3aXRoIE5VTExfUV9CSU8gbW9kZSBpbiBm
b2xsb3dpbmcNCj4+IGNvZGUgcGF0aCBsaWtlIG90aGVyIGJpbyBkcml2ZXJzIGRvIGUuZy4gbnZt
ZS1tdWx0aXBhdGggOi0NCj4+DQo+PiBpZiAoZGV2LT5xdWV1ZV9tb2RlID09IE5VTExfUV9CSU8p
IHsNCj4+ICAgICAgICAgIG51bGxiLT5kaXNrID0gYmxrX2FsbG9jX2Rpc2sobnVsbGItPmRldi0+
aG9tZV9ub2RlKTsNCj4+ICAgICAgICAgIAlibGtfYWxsb2NfZGlzaygpDQo+PiAgICAgICAgICAJ
ICBibGtfYWxsb2NfcXVldWUoKQ0KPj4gICAgICAgICAgCSAgX19hbGxvY19kaXNrX25vZHcoKQ0K
Pj4gfQ0KPj4NCj4+IEFkZCBhIG5ldyBtb2R1bGUgcGFyYW1ldGVyIG5vd2FpdCBhbmQgcmVzcGVj
dGl2ZSBjb25maWdmcyBhdHRyIHRoYXQgd2lsbA0KPj4gc2V0IG9yIGNsZWFyIHRoZSBRVUVVRV9G
TEFHX05PV0FJVCBiYXNlZCBvbiBhIHZhbHVlIHNldCBieSB1c2VyIGluDQo+PiBudWxsX2FkZF9k
ZXYoKSBpcnJlc3BlY3RpdmUgb2YgdGhlIHF1ZXVlIG1vZGUsIGJ5IGRlZmF1bHQga2VlcCBpdA0K
Pj4gZW5hYmxlZCB0byByZXRhaW4gdGhlIG9yaWdpbmFsIGJlaGF2aW91ciBmb3IgdGhlIE5VTExf
UV9NUSBtb2RlLg0KPiBOb3BlLiBZb3UgYXJlIGNoYW5naW5nIHRoZSBiZWhhdmlvci4gU2VlIGJl
bG93Lg0KPg0KDQp0cnVlLCBjaGFuZ2VkIGl0IHNvIHRoYXQgdGhpcyBmbGFnIGlzIG9ubHkgc2V0
IGZvciB0aGUgTlVMTF9RX0JJTyAuLi4NCg0KPj4gRGVwZW5kaW5nIG9uIG5vd2FpdCB2YWx1ZSB1
c2UgR0ZQX05PV0FJVCBvciBHRlBfTk9JTyBmb3IgdGhlIGFsbG9jdGlvbg0KPj4gaW4gdGhlIG51
bGxfYWxsb2NfcGFnZSgpIGZvciBhbGxvY19wYWdlcygpIGFuZCBpbiBudWxsX2luc2VydF9wYWdl
KCkNCj4+IGZvciByYWRpeF90cmVlX3ByZWxvYWQoKS4NCj4+DQo+PiBPYnNlcnZlZCBwZXJmb3Jt
YW5jZSBkaWZmZXJlbmNlIHdpdGggdGhpcyBwYXRjaCBmb3IgZmlvIGlvdXJpbmcgd2l0aA0KPj4g
Y29uZmlnZnMgYW5kIG5vbiBjb25maWdmcyBudWxsX2JsayB3aXRoIHF1ZXVlIG1vZGVzIE5VTExf
UV9CSU8gYW5kDQo+PiBOVUxMX1FfTVE6LQ0KPiBbLi4uXQ0KPg0KPj4gQEAgLTk4MywxMSArOTkw
LDExIEBAIHN0YXRpYyBzdHJ1Y3QgbnVsbGJfcGFnZSAqbnVsbF9pbnNlcnRfcGFnZShzdHJ1Y3Qg
bnVsbGIgKm51bGxiLA0KPj4gICANCj4+ICAgCXNwaW5fdW5sb2NrX2lycSgmbnVsbGItPmxvY2sp
Ow0KPj4gICANCj4+IC0JdF9wYWdlID0gbnVsbF9hbGxvY19wYWdlKCk7DQo+PiArCXRfcGFnZSA9
IG51bGxfYWxsb2NfcGFnZShudWxsYi0+ZGV2LT5ub3dhaXQgPyBHRlBfTk9XQUlUIDogR0ZQX05P
SU8pOw0KPiBUaGlzIGNhbiBwb3RlbnRpYWxseSByZXN1bHQgaW4gZmFpbGVkIGFsbG9jYXRpb25z
LCBzbyBJTyBlcnJvcnMsIHdoaWNoIG90aGVyd2lzZQ0KPiB3b3VsZCBub3QgaGFwcGVuIHdpdGhv
dXQgdGhpcyBjaGFuZ2UuIE5vdCBuaWNlLiBNZW1vcnkgYmFja2luZyBhbHNvIHNldHMNCj4gQkxL
X01RX0ZfQkxPQ0tJTkcsIHdoaWNoIEkgYW0gbm90IHN1cmUgaXMgY29tcGF0aWJsZSB3aXRoIFFV
RVVFX0ZMQUdfTk9XQUlULi4uDQo+IFdvdWxkIG5lZWQgdG8gY2hlY2sgdGhhdCBhZ2Fpbi4NCj4N
Cj4NCg0KeWVzIHdlIHNob3VsZCBhdm9pZCB0aGF0LCBoZXJlIGlzIGV4cGxhbmF0aW9uIDotDQoN
CkJMS19NUV9GX0JMT0NLSU5HIGlzIHNldCBpbiBudWxsX2luaXRfdGFnX3NldCgpLg0KbnVsbF9p
bml0X3RhZ19zZXQoKSBoYXMgdHdvIGNhbGxlcnM6LQ0KDQoxLiBudWxsX2luaXQoKSA6LcKgwqAg
Y2hlY2tzIGlmIHF1ZXVlX21vZGU9TlVMTF9RX01RIGFuZCBzaGFyZWRfdGFncz0xDQogwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoMKgIGJlZm9yZSBzZXR0aW5nIEJMS19NUV9GX0JMT0NLSU5H
IGZvciBzaGFyZWQgdGFnc2V0Lg0KMi4gbnVsbF9hZGRfZGV2KCk6LSBjaGVja3MgaWYgcXVldWVf
bW9kZT1OVUxMX1FfTVEgYmVmb3JlDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2V0
dGluZyBCTEtfTVFfRl9CTE9DS0lORyBmb3Igbm9uLXNoYXJlZCB0YWdzZXQuDQoNCldpdGggbm93
YWl0IG9ubHkgYWxsb3dlZCBmb3IgcW1vZGU9TlVMTF9RX0JJTyAoc2VlIFsxXSkgaXQgd2lsbCBl
cnJvcg0Kb3V0IHdpdGggcW1vZGU9TlVMTF9RX01RIGFuZCB3aWxsIG5ldmVyIHNldCBCTEtfTVFf
Rl9CTE9DS0lORywNCkknbGwgYWRkIGNoZWNrIGluIHRoZSBudWxsX3ZhbGlkYXRlX2NvbmYoKSBq
dXN0IHRvIG1ha2Ugc3VyZSBpbiBWMy4NCg0KVGhhbmtzIGZvciByZXZpZXcgY29tbWVudHMuDQoN
Ci1jaw0KDQpbMV0gVjI6LSBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1ibG9jayZyPTEmYj0y
MDIzMDQmdz0yDQoNCg0K
