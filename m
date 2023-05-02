Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F867C77B73
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 02:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjEBCfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 22:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEBCff (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 22:35:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B23AAB
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 19:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F73KvVl+T68QgAs+ZDlbmR0POj+CBUsJw+/9+FuPvJgrSEC3L00yjyOlOl4vrJKM5HxcUBacHRFLcofCZMPYNTU+VqCmFtl+GGIWFH3PWWj6RsvCiL30DYNl50TQ7tjw1zOwbLItj9To96ch4VI22Cj/8T26cufiXx1cd9OB+0ttePO0sSxsImS5x5RZ8WZF3l4N54IJ+TPrrtHjyyE4cWJqbwxkHyE5B9mCRDTfYEm0Nrfdv4KRSisjPCPCs5ZcyWmybSPCABPR++AZKooByoQ0q2m6NJ+t+cjdfWcqlRs7S149AL3ocK136UakpPd41Pwtv+2FJJbmUTXTBIV5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz9Mm2007n0JN7ZEi79IImI8Yp7t3cjbfS4NODuwZjE=;
 b=VKsEwnuIQohU7U35Wz6fJtIPeQvAz3ZtTsGXSUdjYnb3n26bPMxkQ52SVRFUJT+jIi40p7o5pxev89qzxoNn/5uyy8xSZQTsAjb5Xq8Bfl0gfZvjCRwunwoP/z/QOTHjPQofD7xi+rlKuX8T7HuiNuyS9Mm42Dog9Gba7t5cj1jdPMaB9/HjGEjBAFGNaT2ipl5dUALSTq3c7dp8ysUPTVfYAzB88DzKyD6ADXywrr4LaiHVwPKlhKeMQQ2EUumIAPgDV4gBAFDwGoDELcp/m4CezC85C4ImiUhF2jAtj08+PtHFteBbI0Ja365cJzY0ksZtZDpoPc7qFqoRYVT6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz9Mm2007n0JN7ZEi79IImI8Yp7t3cjbfS4NODuwZjE=;
 b=cHG4aIjofXINMYD1GQzSjPpLaAV3+VKZAlgAFh1agfpMWR2uP0Jh9vMU3Ey1SIEghEmPncIytrsg7Uhhvxat+9Dp65BILlY+t6Q3nqlUIXGQJgP6DUE1V5pmbrGHOy5p05Ww4IO6/TOydc+3Q2fHZylI2JWOahYRhmePK1UUSJXCPIhVutDraVhrYD7mRJQ0scSy7IMY6scXjoFT7f11n1IDxAtcGYulKUUt29SHB9x332kBIS21cq8sh6dmRx1+2ab0VbbUFUpnDUk2eX4Pd/Wg5z0LDUfnjHJ2jatMxAFoMHqnbOIZdRxnKX8uzHV9vzqvaPh5i3kwxw6yU0Gwrw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 02:35:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 02:35:29 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     linux-block <linux-block@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
Thread-Topic: [bug report] kmemleak observed during blktests nvme-tcp
Thread-Index: AQHZc+mY2jx2hr2USkKlPx30OJqaia849EYAgALbpQCAAXkUgIAAAu2AgAF+74CAAAQngIAAN3UAgABThQCABcqLAIAABe6AgAErOwA=
Date:   Tue, 2 May 2023 02:35:29 +0000
Message-ID: <aadcc802-0303-9ffd-ceee-0376ae5aa49e@nvidia.com>
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me>
 <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com>
 <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
 <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
 <CAHj4cs-MtUM=7w=YG2ohATeA1HSZp_5CT1Y9DATDEqPPMZ8MMw@mail.gmail.com>
 <e5717ee0-e2af-9266-4bfc-e792d53f4403@nvidia.com>
 <CAHj4cs8DPVKPs8o+tN7cdZrvZKVRAjG5-cEZspL1N0JG-a4Oag@mail.gmail.com>
 <19c61e06-0d06-c209-d6b7-adac52df27fc@nvidia.com>
 <4f1c6b01-7abe-0599-8249-e3c77072ad61@grimberg.me>
In-Reply-To: <4f1c6b01-7abe-0599-8249-e3c77072ad61@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5175:EE_
x-ms-office365-filtering-correlation-id: f79d487d-efeb-4f44-e740-08db4ab5e4e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAZf4fVu1kr0hvaknpzx8ouV4vTEObYCTmbUl9xhaGx7v4Sm0PwMMFc1tEcg1ryDbHnJ3gmQl90cY/vYqZRD/1pKE/AqovES5JlVQbZmF2RQ6QS9cn6OhkgAW9USPfJjUqv17GMXqTTk3N4cYpt7XSH6r5q+xeH/Za/1kYvSu6KtNyv+6Z8Zxy/SVVzOKDPV9qyoNKx+CP37RcafxdgYAqeyhtT+BfjhuThG+zNyrGDaMojWGIWxfgOcnkOXeC7AdU7C/847cWIujA4zPZuBGriQlj7m3Z8fMhCNNpmP0a2g+rnMBdXbQin8NlQvro8qDosUbZ/LzKKFJDuwgIU/NmhGCjGSjJTrKO5FHob3eR2/yXb781DYk4UCDz2N2qyqD1XIFQoiAAk/Zk+NVFz04B0glU7tN1WYe77lXo+nlR+b4SeDZcENNBvbkUPWFvY6VNAZTbpOUkgk2rxmuQRY5j/zS7mmz4GuiksOwk9lMJTcWjKaJ2OC3GvS0Ll+g1yCYclaP3MNbyS2Sz2s/zPulqRGmba5QluXTPUGe/zYt+44n96CW3DSIoPpCJa6CiTknuDyzEa/UYje+O5Z9oB9pQVBWtfEJNbnBYHkVO+73jw7Vhw6h6QkYsivrLIhS/yGx5N0Nx35NuB+7kXrFmHx5sgIMQBp3Pa9gZ5VTPNf20+XXyf+lheg40lktU6JdO28
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(36756003)(86362001)(91956017)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(6916009)(4326008)(64756008)(54906003)(41300700001)(6486002)(71200400001)(478600001)(5660300002)(8676002)(8936002)(2906002)(31696002)(38070700005)(122000001)(38100700002)(186003)(2616005)(53546011)(6512007)(6506007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTR3YjJrNW9GbDhGemR1cG0zcVJFUXlKdGdtQlIvanh2NmhwRXF5c0dxL0RL?=
 =?utf-8?B?VlVsNHlhYWlKVExOK2RlcVoranVFc0Q5NW9XZnd3MlltcitGQ3dFWHRhMXJU?=
 =?utf-8?B?MzVqU010VW1rZEhSelNuemhsTXRRNCtEalFQRlpnMGd5OW5VbGYzWWd6ZHNM?=
 =?utf-8?B?cGpuTW0vOCtnSkhjL041dUlLMlgrQ3R5djF5dHI4WGNzVXBQWFpUcHBCanNZ?=
 =?utf-8?B?U2FRNjNqdDF5OHlFN0hGcGd0dng2VjNHN2Zqd053M3hkRHhxczVNVjVBSy85?=
 =?utf-8?B?Ti9NdUszSXNiTlc0WDBhTVJrWUtrTDZzcUJSUTEvcG91Wld0ZG94NloyMXZP?=
 =?utf-8?B?alhSYlY2L080SzYzL0JhT1JuQkJTaHRHTXhuRjNMS2svL1lrcGNzNWtWOEt2?=
 =?utf-8?B?Vlp6SndYVjlzallTSVJsaXhMSFMrcVFndGJmTGlYZUJUSFg4Z2hIaFNBNnVL?=
 =?utf-8?B?T2YyQlNiRFBWT0cvMWFmSXFtUzF1eEpBTkJSak9URUtuU2toZHcyTG8vanQw?=
 =?utf-8?B?M1pXVVpUNFBjVHl3Y0k2eEJEUTA4ZmlZZWUrQnZlM1lEQU5UcTN2dHFXYlZH?=
 =?utf-8?B?QkhLZFdyMXc4NmRTclVPRm1wMVpIWEZaaFl2M2NsV2lLbitSTlVPTU8yQkpl?=
 =?utf-8?B?VXJTSyt4QVY2T1VxWUtTKzZVYklldUVRcE1uQzRaa3ltbnprZ2s1MVl0M01N?=
 =?utf-8?B?eDYvNWdUSnFodk5aOFVVYUJjeWhlOTdlWjJpczE4dFlhdmFCUHRwV2RqR0Ix?=
 =?utf-8?B?ZTA0cEFqcnpHZVFPVjdTSWxoRXFOY2hKU0R2R1pINGRocXBYVmFsUzdxMWVr?=
 =?utf-8?B?WHVyLzNSSnV6WFNOS0IwVkhyRTJXb25CbDlLaGhnNHd6WjdvK3V0cUNiQ0xr?=
 =?utf-8?B?aFdTaGZjOVA2ZXJEVWdyVEtPZ3V2aGhIdkk2bm9iMG9RaFFnOGdNY3k1M01E?=
 =?utf-8?B?NGE1OXFiWTNGZ3NsUFNQSGs3cklMUUpZKzc2WDZvTUlUZFRaU1dlMUlhRHFF?=
 =?utf-8?B?OXlBMVZDNzAyaGNQOTNla2drellTWkdpM3VMT2haYU9xWnUwZHJKTEtSYVJr?=
 =?utf-8?B?YWxTcjVUSXRaUHY4R1ZJclVUcW1EbjZZcTFkS29pYzk0Vms5TmpSQnVPNTJz?=
 =?utf-8?B?NTVmMGpqTCsvZWdIQW1HWGVEWXVDeXdXeTlnbFhXR0RranBhYWRSU3hBdmVq?=
 =?utf-8?B?VkM1c0t2UXNtd1lySU1ONW9OSEVxekRMMEs2K2xSak1tK3pZR0ZuaWxVbStk?=
 =?utf-8?B?Q2dwQXpqZ1VCS05XZHhBb3hZZCtxNDk5VGhzTUtlQ1NBY0VXQi94ZnJ2ckxR?=
 =?utf-8?B?cVppT3V0eEFpMHBHcTFXK0oyK3dld1h4RG44MXpWbTRzTjkwbG5YOE9CYzUy?=
 =?utf-8?B?RkFKdWRyMnZuRGVZSDFIRldVMDVqWk85SW5BYzdycEtOZVZKNXk0dGN3VjBl?=
 =?utf-8?B?WnJpaHphZmJjcU5PWmY1K1VCNXI4NzN6SlhNOEs1bmQ0djhjQUQra3h6RE5D?=
 =?utf-8?B?dzEzWlZ5QnNJdTNHbGNNcGFycER2RkJaSHNjV3FZUzFJZUtjOUYwaU5MTlIx?=
 =?utf-8?B?OEFreGhyZWJQbll3NkVjL2FuYjlEYlhxcGpyMlF5bml0VnV3NkRBM0tmRFFG?=
 =?utf-8?B?SFJuSjZsYnRNV0JLcXpKNDFmYm9pK0pZWWFRV2E4UVdHYU5OVk1weVhNOThN?=
 =?utf-8?B?MVZPbVcydTd2V3YxcmNZdUtGSU1PWkxldDVaR3JhOFhqUjg4UHNUSmZpWmJV?=
 =?utf-8?B?UmQ2aHRkK1pkRmFRa0pvTFpwSklGNUREM2lsWW5BdWJEWGg2WElFNktBellR?=
 =?utf-8?B?NXVEaWl3WUJJMkJIemR1OXdxRkJNNmZZT29PTE4rd0hMbXJOK1YwVWFpRFFI?=
 =?utf-8?B?SEs3TTlSQTZsVHNHUFY4VlZ4VE1OdUF1ZlMrdFIrMTdUcVlPdkp5MXZZNXBF?=
 =?utf-8?B?cHNVdm1BUHd1VVh1ZGkxR0lQeUQ0UFVFV3hBci9JTmkxWWN5dWVqNkJob29T?=
 =?utf-8?B?VlNKVnFQODlkejV3MnJrTDgyUnlmbUZKTWR0VkM0R1BnWTBzMDhjVTB3NHBw?=
 =?utf-8?B?RmRITTNCdG12TWhuN2pweU95YTM2QzZyK05hbWYrQXN6ODBkS3FKZWhXcW4y?=
 =?utf-8?B?WnVwREhHZUs1MjU3ZUwzcVZ2N055bDRPcG9vTWtXY2ZxekdISUVKclF2L0NG?=
 =?utf-8?Q?gZE/t0AmwtKEbGPEacBK5/BI76WNIKU24PEsekL5G0yK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <803FF10E118A164C84FA90D8593127E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79d487d-efeb-4f44-e740-08db4ab5e4e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 02:35:29.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXRdIC8OJch5Uxom9Zec8VjcddKVfn9OfGvNc7afEf2dAcQtO+Ad72f4FIuDnJjCgRWfGFlAUntUHRmWY/COkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xLzIzIDAxOjQ0LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPg0KPg0KPiBPbiA1LzEvMjMg
MTE6MjMsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IE9uIDQvMjcvMjMgMDg6NTcsIFlp
IFpoYW5nIHdyb3RlOg0KPj4+IE9uIFRodSwgQXByIDI3LCAyMDIzIGF0IDY6NTjigK9QTSBDaGFp
dGFueWEgS3Vsa2FybmkNCj4+PiA8Y2hhaXRhbnlha0BudmlkaWEuY29tPiB3cm90ZToNCj4+Pj4g
T24gNC8yNy8yMyAwMDozOSwgWWkgWmhhbmcgd3JvdGU6DQo+Pj4+PiBvb3BzLCB0aGUga21lbWxl
YWsgc3RpbGwgZXhpc3RzOg0KPj4+PiBobW1tLCBwcm9ibGVtIGlzIEknbSBub3QgYWJsZSB0byBy
ZXByb2R1Y2UNCj4+Pj4gbnZtZV9jdHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoKSwgSSBjb3VsZCBv
bmx5IGdldA0KPj4+PiBjZGV2IGFkIGRldl9wbV9vcHNfeHh4eC4gTGV0J3Mgc2VlIGlmIGZvbGxv
d2luZyBmaXhlcw0KPj4+PiBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9zdG9yZSgpIGNhc2UgPyBh
cyBJJ3ZlIGFkZGVkIG9uZQ0KPj4+PiBtaXNzaW5nIGtmcmVlKCkgZnJvbSBlYXJsaWVyIGZpeCAu
Lg0KPj4+IEhpIENoYWl0YW55YQ0KPj4+DQo+Pj4gVGhlIGttZW1sZWFrIGluIG52bWVfY3RybF9k
aGNoYXBfc2VjcmV0X3N0b3JlIHdhcyBmaXhlZCB3aXRoIHRoZQ0KPj4+IGNoYW5nZSwgZmVlbCBm
cmVlIHRvIGFkZDoNCj4+Pg0KPj4+IFRlc3RlZC1ieTogWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhh
dC5jb20+DQo+Pj4NCj4+Pg0KPj4NCj4+IEkgd2FzIGFibGUgdG8gZml4IHJlbWFpbmluZyBtZW1s
ZWFrcyBmcm9tIGZvciBibGt0ZXN0cw0KPj4gbnZtZS8wNDQtbnZtZS8wNDUgd2l0aCBudm1lLWxv
b3AgYW5kIG52bWUtdGNwIHRyYW5zcG9ydC4gSSd2ZSB0ZXN0ZWQNCj4+IGZvbGxvd2luZyBwYXRj
aCB3aXRoIGJsa3Rlc3RzIGFuZCBtZW1sZWFrIG9uLCBhbHNvIHNwZWNpZmljYWxseSB0ZXN0ZWQN
Cj4+IHR3byB0ZXN0Y2FzZXMgaW4gcXVlc3Rpb24sIHdoZW5ldmVyIHlvdSBoYXZlIHRpbWUgc2Vl
IGlmIHRoaXMgZml4ZXMgYWxsDQo+PiBpc3N1ZXMsIGJlbG93IGFyZSB0aGUgbG9ncyBmcm9tIG15
IHRlc3RpbmcsIGhlcmUgaXMgdGhlIHBhdGNoIDotDQo+Pg0KPj4gbGludXgtYmxvY2sgKGZvci1u
ZXh0KSAjIGdpdCBkaWZmDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+PiBpbmRleCA0MmU5MGQwMGZjNDAuLjI0NWE4
MzJmNGRmNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4gKysr
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+PiBAQCAtNTE1MSw2ICs1MTUxLDEwIEBAIGlu
dCBudm1lX2luaXRfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QNCj4+IGRldmlj
ZSAqZGV2LA0KPj4NCj4+IMKgIMKgwqDCoMKgwqDCoMKgIEJVSUxEX0JVR19PTihOVk1FX0RTTV9N
QVhfUkFOR0VTICogc2l6ZW9mKHN0cnVjdCANCj4+IG52bWVfZHNtX3JhbmdlKSA+DQo+PiDCoCDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBBR0VfU0laRSk7
DQo+PiArwqDCoMKgwqDCoMKgIHJldCA9IG52bWVfYXV0aF9pbml0X2N0cmwoY3RybCk7DQo+PiAr
wqDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcmV0Ow0KPj4gKw0KPj4gwqAgwqDCoMKgwqDCoMKgwqAgY3RybC0+ZGlzY2FyZF9wYWdl
ID0gYWxsb2NfcGFnZShHRlBfS0VSTkVMKTsNCj4+IMKgIMKgwqDCoMKgwqDCoMKgIGlmICghY3Ry
bC0+ZGlzY2FyZF9wYWdlKSB7DQo+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gLUVOT01FTTsNCj4+IEBAIC01MTk1LDEzICs1MTk5LDggQEAgaW50IG52bWVfaW5pdF9j
dHJsKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdA0KPj4gZGV2aWNlICpkZXYsDQo+Pg0K
Pj4gwqAgwqDCoMKgwqDCoMKgwqAgbnZtZV9mYXVsdF9pbmplY3RfaW5pdCgmY3RybC0+ZmF1bHRf
aW5qZWN0LA0KPj4gZGV2X25hbWUoY3RybC0+ZGV2aWNlKSk7DQo+PiDCoCDCoMKgwqDCoMKgwqDC
oCBudm1lX21wYXRoX2luaXRfY3RybChjdHJsKTsNCj4+IC3CoMKgwqDCoMKgwqAgcmV0ID0gbnZt
ZV9hdXRoX2luaXRfY3RybChjdHJsKTsNCj4+IC3CoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVfY2RldjsNCj4NCj4gVGhp
cyBkb2VzIG5vdCBzZWVtIHRvIG1lIGxpa2UgYSBmaXgsIGJ1dCBhIHBhcnRpY3VsYXIgd2F5IHRv
IGhpZGUgdGhlDQo+IGlzc3VlLg0KDQpBZ3JlZSwgYnV0IHJpZ2h0IG5vdyBJcnZpbiBpcyB3b3Jr
aW5nIG9uIGZpeGluZyBudm1lX2luaXRfY3RybCgpIA0KaXNzdWUocykgYW5kDQpjdXJyZW50IGJs
b2NrIHRyZWUgaGFzIG1lbWxlYWsuIFNob3VsZG4ndCB3ZSBmaXggaXQgYmVmb3JlIGl0IGdldHMg
DQptZXJnZWQgaW50bw0KdGhlIGxpbnV4L2Zvci1uZXh0ID8gaWYgdGhhdCBpcyBub3QgdGhlIGNh
c2Ugd2UgY2FuIHNhZmVseSBkcm9wIHRoaXMgLi4uDQoNCi1jaw0KDQoNCg==
