Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E1C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBFWt4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFWtz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 17:49:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7374E10F6
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 14:49:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQBDUtBNkF4cxXp5Ng4afxTOXUoEpQe5+/mIzDrMFlr0tns0wxb4F0rfKz4gEBzLEoND+dIcHP8kLLrbjS54k9IL5iHiO0PpRaqW0ESij4r1KZ25p/myIBYaEaX3LhPvT7iNZ4KYTUjjUzGx1EqdshpefcrUcAyvbWq8rX97TvcXtuamFcfLAh45asZH3gMjlqnfMWOPjelaMeCl/7NKq/AL9dcrUpi8XnLdiiA0+DgVb/KF1dfwLFsvzfAwv7J1DOwIBQnZLnC11OHP8K0nbYJ+621chbHCVP1/IcBfcLivKZ6si7JmSLFmTDrfuT7hT/3Rv8HMOf+wS4CnA7V6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeJPxQv5iJkzVaqKn9PiSVhw5pXa5EzckEhsE/baiQo=;
 b=DnU9+wh/cojsHHMmcZ35/WNVclfRzX4fo3E1F+E+R5kCXANn8R0RleId/5iFpdZeyxUtW8J/jsInd3p3txXvm8eLRvp3vOlLg9giNAruxI+8hinb4gvFbI6WVWcNR8WHanc2D/9Q1V8vBqJByYtb5i/dWAfh/LFF46E8kwZVT1fz8fr4bCLSTcWUu/TGdUr4xHqSwU/tGerium6fHkOef8R8pgoi4fMj3yErGMgOwP9IZsZtLcm5AeCdOrqDVd2D8a9XgJIh2yt2ofx2EmjjbWkeacsL7VWqF2yFO+POAaMVRKMaO554t4eibkhbRlkVYkLqQ8rZbnPf6c892vMeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeJPxQv5iJkzVaqKn9PiSVhw5pXa5EzckEhsE/baiQo=;
 b=n4DeNUhfwFUZrnt+ixrBlu2TCl4J/FNUsu9VXfo8kZm0rQ7ZSeDwc4129Q/n9mNNXGQ1/duP/rsBihpRg7WtfansEYGhYLpvM6fJ1teQeUdPyNw4+JQnN+ubKDx1zYig2G+e47TSyy8FIRxIgBe44/g4PUIjsC6rqFPh9sneG6B889Q7poEd6Un8PMRp4zmtPkeAUrargsLT7N2veN+Q4VXxgUW9JwoSRfg6Q4Jbr9d9Vh45Qtj4voazM/DasK34mx0LD/p0ut1MPDEUDy6AEMbk1WCjs0akZxxHRMOJcnXHVlT1i9I4qHYsd7sNnrKkKu3Z0DfY2mHs/r8OWYvTww==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Mon, 6 Feb
 2023 22:49:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 22:49:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] BoF: NVMe VFIO Live
 Migration
Thread-Topic: [LSF/MM/BFP ATTEND][LSF/MM/BFP TOPIC] BoF: NVMe VFIO Live
 Migration
Thread-Index: AQHZNqv2kwFHnKt7sEGfV9fE3rVJNa7CjUsA
Date:   Mon, 6 Feb 2023 22:49:51 +0000
Message-ID: <e66b94a7-b4da-e6ef-37c1-65ebeb1aa46e@nvidia.com>
References: <a0ef2710-43e5-b856-f9ce-e6f1ba99df51@nvidia.com>
In-Reply-To: <a0ef2710-43e5-b856-f9ce-e6f1ba99df51@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7606:EE_
x-ms-office365-filtering-correlation-id: af0d7cc4-f7e9-4be2-c336-08db089474e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /WdZcYf26a3JYXH0neia6IHNq7OQSQxIHquSW2yRYxefmIBRU1be8KaFN4Gzracp0srbJSHucx2Z6vJu9AK2rIiPAos/gQLXWyMdri4Ly+iUysDGYsCAv7FgzRbEguY6b/unprGgkE+BG6uyMyd5CmVZFqKkUa1u4imMQbEDtvh3dNQjP8keypjwzWYdy52TAWIjchYzwBGfqN3qvmjyJo9C7GSzS2FqUHajzXldfoMc/Nyus6oa+DlukhdKmAajQYyxcitVaQZqfrxP1Mhqjd9ZG98GqaoL3wRu1opiyFQnD7sAk/8pPycqsJVAheW8cwoo8m9AigfCqgt/67Nd4zr26VjUj9LNfLiKgsEW/UVoGVqNKQcbhqjvVcCWr/cofm1BhKpTLnYb/0TZAZlun9HjXTP6aYLy9x0a4BMeEltw0cazKKjU+luE1JOHNnlnx956QJS+SaQhDVXqS7RLDSUammHbt3kx+3XftT0K4DWCwwhf2s21ocMWRjOxQFPd9GqZNjB1DHjItyQsbB9zbO75qT81Ag9djOB2ND7elQdATHANV+CgaqYbQmKwhVzjULfNUCK+X+tyLRpN/Nyk748zWdwbPUBgrXMTD5BnV6diJw3M0L6tcC89CjnIzL3I6gFSU5qafbdSrLJA5htBm/bWv3AQACmzjkE+K+U70Gbgg9mzsR03oDcc8UlwliNNRS6vMnEfY0olKoW2pj2g0TtVB7PmE1FgTsidq+2IoYCgs7Bxf6hdhAgMymiM9wncOPoIxbHWczkFBDc1VCs3nGbnjmwIkon/LMaG4CYJqivL8fbTq0uXeP2vnZ+hR8FTKsJ+F0XZuDLu2jYiPZdtVEIHMOmnQfIj4rKo0zv6UMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(71200400001)(41300700001)(966005)(31686004)(6506007)(122000001)(8936002)(5660300002)(38070700005)(4744005)(6486002)(6512007)(38100700002)(2616005)(31696002)(478600001)(186003)(316002)(91956017)(2906002)(54906003)(86362001)(36756003)(76116006)(66446008)(66476007)(8676002)(4326008)(66556008)(64756008)(66946007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFNSVkt3Q09PV0F6QmozdEk5QVBVVnhsbldzV0VaOVc5SW04MHRBckg1WEpI?=
 =?utf-8?B?VHdSK0RlVFlDNWxldTlUKzZxd25KczlNSlZFWTM1a3lzbFRFUmI4L0U4bkhJ?=
 =?utf-8?B?MGQxWHZVNTNoY1lOUGZsL0h1cTZIS2VjZ1V5dTlhbzgwZW93UWpNMEZZOFdK?=
 =?utf-8?B?c3BoZXFOTVR0Y3hPcElxMDY0UEpHZUJhTUZMVCtsUHk1eGxpNUN4bjA1UWMr?=
 =?utf-8?B?NDJadDlUd0ZaMzRHK0dkT3V6OXZlSllYaE51RWZDejJvMGVlWkNKZSs5b2lU?=
 =?utf-8?B?b040WEtzeENZLy8yZk43THdiZkdCYkhNQkxyaVRwZnBMUVo3RFA3dlc3dzZw?=
 =?utf-8?B?UGpQMm9yL2VERmRFVGZGV2J4NWtJUUF1S1ExdVd4ajJ0bVpCUW5nc09mUE5C?=
 =?utf-8?B?d3RZQlQ5MnBGSlZwWHVoU0xyQUM4RnllYUVEenR6dklXa0pkZHMyNnlnNzc0?=
 =?utf-8?B?bi9PUUxjMnNUdjUwb25qeHlZQmJ1NFhhQTk0aExoR3h3V0l2M1piMFI0ZllW?=
 =?utf-8?B?d2JQNDlOSGt0Yi84bzJrTFE1SkhPVjBvc2xOK1RPcVQxa1ZDeTFJQkVXUXFC?=
 =?utf-8?B?MXhkREpzUDdrc2kxTzJQY2p0OVFKSEJTam5SRndscE1peS9jUko2TEt2OXFS?=
 =?utf-8?B?MnRYdHpWQlRraENkWHB3RlMyWHpwNU1YcmJEanBEdGZBTXYxSGRKY0dUNlZw?=
 =?utf-8?B?aEFZZFh3N2lWYUZtd1NKMkVEZy8rOCt0Q2pReVI0TnVEUTdaZDF1N0VxTU82?=
 =?utf-8?B?N0dReVdGKzJNM3FMWkIzR1pibkIxemk4OU4wM1hTNENUTXFDSW40ZG5kK0hD?=
 =?utf-8?B?RG5KbHAycVFSY01CWHFXcS9kMFR6c0ZHOTZTekVuY1dGVmxQQWxVRzFXZzU4?=
 =?utf-8?B?YklMR0R3UGFrWWNjQmxVVUhzM3VFTVRJOG9qUEduSHoxakJxd0oyWStYQ3or?=
 =?utf-8?B?aWl6Um9DY09TTlJzWmZXSFo3cFMxWXNnRjZEeFlValNUMWFDZzNlbjRrL3Vo?=
 =?utf-8?B?MXdUN0NsWmkrL0Q2M1FWSStORHRHUk1BaVNvWm1uUHMwNFVCUSsxT1NHOEt4?=
 =?utf-8?B?d00vZ01QNEVFOE90azNJUUhKMlQ0TlNyUWdtRElWMGIrOG5xanl0bFdvUndx?=
 =?utf-8?B?aWtUVDlacGZNcTh3bFN5Yitnb2w3YVJJTVJqRnArM3JaN29rYzlZRk9walU0?=
 =?utf-8?B?VE8zLzFVY1ZXLzNyd2IyUlZUcE1vQktrWkdyNkFhQmdmb3FScllQbUYzbGFG?=
 =?utf-8?B?alpMSFIyVi84NHFKSTFvWm5ublJUdjZ2T20ycGFmcGhKOWF3ODBlSkd6ZnN2?=
 =?utf-8?B?N2ptdVZxTzdpNDFZeEg3S1hFUGxzeDRSU3dOUlBKTCtCaFFrOTZpRWNiSEgw?=
 =?utf-8?B?Z2pEbEZWT0l3NGRZVFFwN01YMGdoNkZNQWRuTjlPQ2lsR2RVbDRkZGk3UFlF?=
 =?utf-8?B?dWN2OEYwN0psY2JXMzh0OGxrWndBOHZXeFdhb1RwTG1rbmlDcU84dUp2RHBM?=
 =?utf-8?B?Q21iL0x0czEzUDVWMWM0Y2JjOERDVUoxNHlXTnIyb1JaU2lsckRpSjhQZTF5?=
 =?utf-8?B?VnNQNnc5TzNaOXBSb21HVGlkMVZvN0dvc0ZGTHdBc3htZGxGeXljSTBXWkU0?=
 =?utf-8?B?SGlLOWVXcFEvbG1GbDVqSXFCNVA3QmV3SzBZdU1JUmprakVYSEZqUWJtVmxN?=
 =?utf-8?B?eXJPRXBaR0lmaEkxejJFcUNZRTZFSEhXQkEwTWd3UDQyMWRrTm1rVXIyZW1J?=
 =?utf-8?B?cXhhQm51dCtkNWFlSkxRM0o3VEpqbGloRkFsc1gxL2VRT1dYdGdKTGdESnE1?=
 =?utf-8?B?WU5QNEMrdjlXekFDSWVqM1pZSFA5RUxUczRrRTMvekdId3NLL0dQL2xUOGZo?=
 =?utf-8?B?S1NnWFpBdEY1TG5TWk8wdkpmWUhlYzUzcVBtZXpSTlhRdHNJaVBBNGFia2Ey?=
 =?utf-8?B?aEhZYzBoUUpZWXNGQmRVOTc3NGVCNXgrZHBrdFV1OTJqTlpZQVlBNXY5ZDht?=
 =?utf-8?B?NVdRMXV1eTJiRGU4aEZYekMwYVo5SG80bFcwN0tWZlZrVHIvaWJpQXozeVBI?=
 =?utf-8?B?bzJoSlE2UC9kWUFhZkJJRUt6Z0l3L1hNcDJUeTNSRkF2dTMwcmkvS0xTeWRv?=
 =?utf-8?B?Nmh3NW1JeGhubThuaUlicDJIYi82cGtBZFQydGpBTEtlSFJJUWdmSlJCbmtn?=
 =?utf-8?Q?iFluK1OS5OJz2alSmIlg2A35bynietQlAZ6gEW0bBLFn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <865C19144DBED54D80947BE0E1763791@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0d7cc4-f7e9-4be2-c336-08db089474e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 22:49:51.2207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2PCxSnAnTITuMxb88s+nvUvJ8mmwdPc7kMr+xw8LLVk6zQOgjR3R4t+A9shRim+EWM8I98985SsMG4qeiyXfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQpVcGRhdGluZyByZXF1aXJlZCBhdHRlbmRlZXMgbGlzdC4uDQoNCj4gUGxlYXNlIG5vdGUgdGhh
dCB3ZSB3aWxsIF9ub3RfIGJlIGRpc2N1c3NpbmcgYW55IE5WTWUgVFdHIHN0YW5kYXJkDQo+IHNw
ZWNpZmljIHRvcGljcyBpbiB0aGlzIEJvRiwgYnV0IHRoaXMgc2Vzc2lvbiB3aWxsIGJlIGZvY3Vz
ZWQgb24NCj4gbWFpbGluZyBsaXN0IGRpc2N1c3Npb25zIG9ubHkuDQo+IA0KPiBSZXF1aXJlZCBh
dHRlbmRlZXMgZm9yIHRoaXMgc2Vzc2lvbjotDQo+IA0KPiBDaHJpc3RvcGggSGVsbHdpZw0KPiBK
YXNvbiBHdW50aG9ycGUNCj4gS2VpdGggQnVzY2gNCj4gTWFydGluIFBldGVyc2VuDQo+IEphdmll
ciBHb256YWxleg0KU3RlcGhlbiBCYXRlcw0KDQo+IA0KPiAtY2sNCj4gDQo+IFsxXQ0KPiBodHRw
czovL3N0b3JhZ2VkZXZlbG9wZXIub3JnL2V2ZW50cy9zZGMtMjAyMi9hZ2VuZGEvc2Vzc2lvbi80
NDMNCj4gWzJdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjEyMDYxMzA5MDEu
R0IyNDM1OEBsc3QuZGUvVC8NCj4gDQoNCg==
