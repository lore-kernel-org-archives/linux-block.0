Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF3C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 07:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjELHnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 03:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjELHnI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 03:43:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4B6A67
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 00:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVgv9mDOQjd/WZoB4OHufwcNmb9aqo8EGoYh56Vq0tio/aUENqqrN4wOZV2kdVb7x8FtS7pg5260mhkqiAgurYFI6zBUhlEad6Z101gL1tZj3x4KgSLinqETlbaTKyOB1YQlElV4F9cG3nt5VWo6u0Fkj/Ev2rO08xukcY/PYn60y+YDIdyirIDBC7MC2CyqLGbVe7oP4Ya2GF/agd2tIzb1ow4mi/NXjJN/1dPpqmAzI8ax4OpqnOwNpeQuVX0TWwpoLKum/Gytw0qHuyGpScWCfWNPafCJCQMwaynGOUekPta4QV8DIKpSjrjNUMkIxspFLKaG5P4DDHhWOq5FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK9O4jCbsa+QZhNBlTF0uPfw60g7+Yx5TpX5Ry0O/gA=;
 b=P14JST9s0oTSjgty8XQp2GoTr2pQU4ROBfAEnVYhXqijrJHzg231PU/XIvnZzXuLwd+6Z6L1aakOtJBDur7ABV7kxfWMwi1Tkn5lEas+QMW0OCjvHYZwQ09PArqd/w/FcB+1BVPTeEy+896EdS6qr0i7MaIlBky6XCZZUWke1/HMUhAdh9iAV2+7TcK5me3Qn77pK8QhRl9QOCt7nPyVcsTEw9Vbix8hz4tJ/4WdQMnW/SW7EYFN46ZdwG5Msdf83sjApUsDP8T6eIyw8gC9xbPSflZGv+0VkyMdBQ3NAD1GivsI0YSHwbkFLApwmnf/ClwMwHy1fTRNBvXaDrp7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK9O4jCbsa+QZhNBlTF0uPfw60g7+Yx5TpX5Ry0O/gA=;
 b=XSdNn2ez8MMFfoP7YA+0KaC7MacLqpZd6MlKr53STMi80dftO92FPrqHn94kzKVVyV7DczSbmdhx/anm4+c0lRlaW8ClQr1+L/QUsbEAki7hKn2lRFsxmW9di3tuxoPq7DbmdirOlxSu/aLLiqT0el2WrZiLmD+ZhHLx5RsFN0p+qtek1g/s+yK2/ElejTqkOFCzptvOdGbJz3HwPUrmgDN6BqNxSa2T9Zw+t3AEAuHmLMinHxVEQA7hf+SjKV4NbVvOs1MAd7MuvXI9MSDxIbWlaQ+wPPOCL6hTrt1WzLMBBIqdXlYfAb+8E5xlwBgnH5dX/E8pgih+LS8cIWtcEA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 07:43:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Fri, 12 May 2023
 07:43:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Thread-Topic: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Thread-Index: AQHZhIWSMMI/E/W2eEKHkBgyjEuHlK9WQbkA
Date:   Fri, 12 May 2023 07:43:05 +0000
Message-ID: <e6496267-7365-d74e-12ab-08f39be1579d@nvidia.com>
References: <20230512034631.28686-1-guoqing.jiang@linux.dev>
In-Reply-To: <20230512034631.28686-1-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: f126d454-eff7-4168-f214-08db52bc85c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ST6LzTiN683x3LsZbNQ/GwFHPQJHQAdvAkrt2O+lxjqw3XGQxkK/jynFAOFwSnNi8C4uBNvQcmv1SbPQsT6Jkp1miBKTfj1OCDrRPDTGgALVXegWQIOzGWoF4nyUroWv5yj+Q+Bjphqgnb7Sy57V17OA0Geq01Gfmx7xRsTvi8/G7hM0eriuKTAr9ooo39rpMedeOIljkFQaU79xj7aI467ABRX6wd1gGGNGk2jFNey9HFVMMHxdZ0/a4YuSdoqs+lPSjSyMnW0TcvdYAZgBSTkxfo4WjquQCQSFF57ORYQ3yw26ubwgw29AWVtCdPjFM3KMEM/OF9QD7+0MliWamizgy76qQYTW1w05e9mlhqYxc1L7ewHu66sQODc2PjhG/xQ3ORPeTRycp1jVO+tcAePh1ywegGZzloCAuFJpNGdyH6h/nG3uv5a4T8n9rCEWzK14FM2Ub4JUahuz+vo3E78T/AfckAjAnhb1GRfJzKF7s//KlA0kG8lnSWNJiRhG+8hPDoU2R6KMc+9fQhltUk1p4SrfY8Ry3x/6FEKyLigi64Cg0KZKxvtWOY61+NEsSP1LJbfHdsRwmROS86xGw64hiXF7xTYPDbfCd/DI7tUO4iaYZ7sHmJOaIrlV98s8pyWpUc5I7w9ON+L9NxT4LjYyxfTA688MAqD0aBCGzIm+dubn3eUV5nG5jFqx6smF/hIXVba1YRk1uUZKstDcrDKycNGLdzQhjw+sl5RFNCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(110136005)(478600001)(54906003)(5660300002)(8676002)(8936002)(38070700005)(86362001)(2906002)(36756003)(31696002)(66556008)(66446008)(64756008)(91956017)(66476007)(4326008)(66946007)(76116006)(316002)(122000001)(41300700001)(38100700002)(186003)(6512007)(6506007)(53546011)(31686004)(83380400001)(2616005)(966005)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azVQdkd4aW9KY3hWcERNS2ZuVjJodmIrZHJNTFQ0ZW1kOTZ3VWs0UWFDTWdK?=
 =?utf-8?B?NHF3aDdYVS9oMWpwcWxYK0s0bkZyUy83NVFHWlNzekdnbXphempMajEvVzlI?=
 =?utf-8?B?ZSsyU1J5Ui9ZR05sQWttU2xkZmhGY0tlSjVOblVabnVVeGRraHo1VWI0UzZN?=
 =?utf-8?B?c2I5ajJqRHhDQzZMdFVpVTdMR0F1a2dhUEJNdW9sL25TY2ROR1k5dkZ5QlR4?=
 =?utf-8?B?aURhSDZLL2pzVXpUQTVINFVPNjd2UldXMWRKK2Zjbi9Tb2t4ZnpGYks0MjB5?=
 =?utf-8?B?RVhtaGI0WktPc1hKS2dPbXprcmIyNnJGR1FJWWRrOFQyMnBBdkdYMTVka09v?=
 =?utf-8?B?UGZPc0FtR1NlWlFFdGdnTTdIUlR2bGRVcEtJdXpGei8zVUw3Y0VXaWNkZU9L?=
 =?utf-8?B?T0cxSlRINVdPdTBqbm5YdzRxbWR6cWhzYWszcXUvM1ZzL2xWamlybXV4RzZH?=
 =?utf-8?B?TC82aWhWbHB5amNzZDNCc1hzVWMyODBXVDVsT3VQT1ZBaVVPaGpMcnByWG9K?=
 =?utf-8?B?Yktkc3VYblBKNHhJTnRPeitlZ0ZzY0c2K3NNN0h3UVpBcWpIMS9UUzRpeDBN?=
 =?utf-8?B?T21rUFZhdTJGTE9CNEhJRWtDcVdXQTFyR0RCUFJzRENOZklQbkp4Yi90MWUz?=
 =?utf-8?B?SzFTZ1hEQ0VmeVhsZHc0SEs0bWFSY0U3VTc2UmRFbnE1SzU4RHZlY05DRTMx?=
 =?utf-8?B?RW1leUswMFhnaHFMWUY1eFpTSmJtT0NlUThkV3d5bFJsRWppU0NIa09MRzRa?=
 =?utf-8?B?L0xicFVuTERUR1N0YlhFL0dNMTVadWg3TUtpa3plSHRZSFZFNXhhM2pHUzVV?=
 =?utf-8?B?emlieitSb3ZBNERMcEJsS0tMdDRGVjhra1hFYUdzSzM1QWNmWDZGZHh1QnRi?=
 =?utf-8?B?OW0rU0lMQ3hybEFycDU4ckZBdkJmQndFd1htSmtCSmoxbVQxdGY3cWtFRlNu?=
 =?utf-8?B?SU9rZVpOSnp5bVJPbUtXaCtpOEZCeEhIU1c0Tmx3SmdhOE5VakREUnoxTEQ5?=
 =?utf-8?B?ZGJjV2VaVVhPTCtzUEZuRG9aaUE0bEo3bVhyT2xQU1pldEpIQzFLc2Y0U3lJ?=
 =?utf-8?B?eTd3RkFoR05tS3pPM0c3Z0lZRk9iTFhVYmVCdktmQ1VYTnQ4QUUyd0ZxclRo?=
 =?utf-8?B?b3NLUmZIZ1UvZThaaFZBU21Mc2hMdmVvR1U1SGphV1cxMHZ6VGlzRWJtK1d6?=
 =?utf-8?B?Z2lqV3FzVzBRQk9HUGt3SStsUjU4djdPUG1VSSt0bnJ4YUszcWxBYU9mWW1G?=
 =?utf-8?B?Y1V0TFp4YlhJaHYvc2ZLbmpJTENRY3E2RDhUdmxkbTU3L1pMb1RGU0JuMXBx?=
 =?utf-8?B?dGF4d3NZZ0hzQVppc1BLbmdTa2tIdVlRZkFSQ1ZLaFVITG15clE1ZzRFZUc1?=
 =?utf-8?B?ZHg3bkhLMGlBYmxPTzJ3eFE5a21Jb0U1bk5sazVPMVNyZmFmTjJlZjdSNzdh?=
 =?utf-8?B?SDBnUG9qdkk5Y0hua3NJdEZVcENXenoycHpDY0RINlF0SHFUeU4zMHgzbFpW?=
 =?utf-8?B?VzJHRGdNQm9HTFhqVVV1QkZqUDFKZVE1bjRnMG5jb2s1MFFtQTlNalJFS1M4?=
 =?utf-8?B?TGZCS1pCQkdDVUsyOTRZazF2bFU5WjlYTWZtc2RLNzNMdkxVdGRzNjFwbnF5?=
 =?utf-8?B?MnROYkJ5bEllb1BOUzI5WjFSSDRQMFJENTlNMkhEamt0aEhDQ0hPTyt2dmxp?=
 =?utf-8?B?THVDQXYzUXlYV2o5M3BJT1ExdCt0UHlXNlMwdzJ2RlhjOExzZjYvM1Qyd3ZK?=
 =?utf-8?B?cy81RHFUcENKbHVVMThqWEdnM3J3UmlCV2lUWnBDT2k5YVF0S09UTkZubTEv?=
 =?utf-8?B?SFFoT1B3MmE4TTV4d1N4ZXBpMStXV0Mvd2FoZnpUTGRWUmoxNEpVTDBYbFVD?=
 =?utf-8?B?akJOWUlURWlMYm1KdHJpQ0NZeVBWeW9ibGlnTmp4Q3pOUUVIeGhlTWFpVENy?=
 =?utf-8?B?S2l6NFQ0REdsMHlpcFhBZkswUkVGcFlvVGV6UnYxWDRlRkZsS29WR3Q5UGJ0?=
 =?utf-8?B?ekVLWWhnL1V0K3NhNmxMZ3lqNFJ4Unh2eWhITThWdm9sTDVsdlNUb1ZqNUhK?=
 =?utf-8?B?RnoyT2M3VDU1eUNIVzRUcitGRG1UYXhSV3VMd1hjcHc5b0RMTVJ1UGlNY3Vm?=
 =?utf-8?B?N0daNXlNNmR6M1RId0ZUUEN0NFJMT1dhandaOVU1SWJDcUhJTkhWK1NTcWFJ?=
 =?utf-8?Q?ogiF6ddyg4tgdq2EGnLHpwVc76wb46bkB4CT+3uI+vui?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A49DF8249EAEE49BC44C284227FA91E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f126d454-eff7-4168-f214-08db52bc85c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 07:43:05.4228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkFWtEfL02p5TenqshgWc39P6J8EbIkpx7fadrndSdWjS8Oss+32z2FuZNCQs+wF/urNQENHFt7aLdakBnVsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMS8yMyAyMDo0NiwgR3VvcWluZyBKaWFuZyB3cm90ZToNCj4gU2luY2UgZmx1c2ggYmlv
cyBhcmUgaW1wbGVtZW50ZWQgYXMgd3JpdGVzIHdpdGggbm8gZGF0YSBhbmQNCj4gdGhlIHByZWZs
dXNoIGZsYWcgcGVyIENocmlzdG9waCdzIGNvbW1lbnQgWzFdLg0KPg0KPiBBbmQgd2UgbmVlZCB0
byBjaGFuZ2UgaXQgaW4gcm5iZCBhY2NvcmRpbmdseS4gT3RoZXJ3aXNlLCBJDQo+IGdvdCBzcGxh
dHRpbmcgd2hlbiBjcmVhdGUgZnMgZnJvbSBybmJkIGNsaWVudC4NCj4NCj4gWyAgNDY0LjAyODU0
NV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgIDQ2NC4wMjg1NTNd
IFdBUk5JTkc6IENQVTogMCBQSUQ6IDY1IGF0IGJsb2NrL2Jsay1jb3JlLmM6NzUxIHN1Ym1pdF9i
aW9fbm9hY2N0KzB4MzJjLzB4NWQwDQo+IFsgLi4uIF0NCj4gWyAgNDY0LjAyODY2OF0gQ1BVOiAw
IFBJRDogNjUgQ29tbToga3dvcmtlci8wOjFIIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICAg
Ni40LjAtcmMxICM5DQo+IFsgIDQ2NC4wMjg2NzFdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRh
cmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIHJlbC0xLjE1LjAtMC1nMmRkNGI5Yi1yZWJ1
aWx0Lm9wZW5zdXNlLm9yZyAwNC8wMS8yMDE0DQo+IFsgIDQ2NC4wMjg2NzNdIFdvcmtxdWV1ZTog
aWItY29tcC13cSBpYl9jcV9wb2xsX3dvcmsgW2liX2NvcmVdDQo+IFsgIDQ2NC4wMjg3MTddIFJJ
UDogMDAxMDpzdWJtaXRfYmlvX25vYWNjdCsweDMyYy8weDVkMA0KPiBbICA0NjQuMDI4NzIwXSBD
b2RlOiAwMyAwZiA4NSA1MSBmZSBmZiBmZiA0OCA4YiA0MyAxOCA4YiA4OCAwNCAwMyAwMCAwMCA4
NSBjOSAwZiA4NSAzZiBmZSBmZiBmZiBlOSBiZSBmZCBmZiBmZiAwZiBiNiBkMCAzYyAwZCA3NCAy
NiA4MyBmYSAwMSA3NCAyMSA8MGY+IDBiIGI4IDBhIDAwIDAwIDAwIGU5IDU2IGZkIGZmIGZmIDRj
IDg5IGU3IGU4IDcwIGExIDAzIDAwIDg0IGMwDQo+IFsgIDQ2NC4wMjg3MjJdIFJTUDogMDAxODpm
ZmZmYWYzNjgwYjU3YzY4IEVGTEFHUzogMDAwMTAyMDINCj4gWyAgNDY0LjAyODcyNF0gUkFYOiAw
MDAwMDAwMDAwMDYwODAyIFJCWDogZmZmZmEwOWRjYzE4YmYwMCBSQ1g6IDAwMDAwMDAwMDAwMDAw
MDANCj4gWyAgNDY0LjAyODcyNl0gUkRYOiAwMDAwMDAwMDAwMDAwMDAyIFJTSTogMDAwMDAwMDAw
MDAwMDAwMCBSREk6IGZmZmZhMDlkZGUwODFkMDANCj4gWyAgNDY0LjAyODcyN10gUkJQOiBmZmZm
YWYzNjgwYjU3Yzk4IFIwODogZmZmZmEwOWRkZTA4MWQwMCBSMDk6IGZmZmZhMDllMzgzMjcyMDAN
Cj4gWyAgNDY0LjAyODcyOV0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAw
MDAwMCBSMTI6IGZmZmZhMDlkZGUwODFkMDANCj4gWyAgNDY0LjAyODczMF0gUjEzOiBmZmZmYTA5
ZGNiMDZlMWU4IFIxNDogMDAwMDAwMDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAyMDAwMDANCj4g
WyAgNDY0LjAyODczM10gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmZhMDllM2Jj
MDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBbICA0NjQuMDI4NzM1XSBDUzog
IDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsgIDQ2NC4w
Mjg3MzZdIENSMjogMDAwMDU1YTRlODIwNmM0MCBDUjM6IDAwMDAwMDAxMTlmMDYwMDAgQ1I0OiAw
MDAwMDAwMDAwMzUwNmYwDQo+IFsgIDQ2NC4wMjg3MzhdIENhbGwgVHJhY2U6DQo+IFsgIDQ2NC4w
Mjg3NDBdICA8VEFTSz4NCj4gWyAgNDY0LjAyODc0Nl0gIHN1Ym1pdF9iaW8rMHgxYi8weDgwDQo+
IFsgIDQ2NC4wMjg3NDhdICBybmJkX3Nydl9yZG1hX2V2KzB4NTBkLzB4MTBjMCBbcm5iZF9zZXJ2
ZXJdDQo+IFsgIDQ2NC4wMjg3NTRdICA/IHBlcmNwdV9yZWZfZ2V0X21hbnkuY29uc3Rwcm9wLjAr
MHg1NS8weDE0MCBbcnRyc19zZXJ2ZXJdDQo+IFsgIDQ2NC4wMjg3NjBdICA/IF9fdGhpc19jcHVf
cHJlZW1wdF9jaGVjaysweDEzLzB4MjANCj4gWyAgNDY0LjAyODc2OV0gIHByb2Nlc3NfaW9fcmVx
KzB4MWRjLzB4NDUwIFtydHJzX3NlcnZlcl0NCj4gWyAgNDY0LjAyODc3NV0gIHJ0cnNfc3J2X2lu
dl9ya2V5X2RvbmUrMHg2Ny8weGIwIFtydHJzX3NlcnZlcl0NCj4gWyAgNDY0LjAyODc4MF0gIF9f
aWJfcHJvY2Vzc19jcSsweGJjLzB4MWYwIFtpYl9jb3JlXQ0KPiBbICA0NjQuMDI4NzkzXSAgaWJf
Y3FfcG9sbF93b3JrKzB4MmIvMHhhMCBbaWJfY29yZV0NCj4gWyAgNDY0LjAyODgwNF0gIHByb2Nl
c3Nfb25lX3dvcmsrMHgyYTkvMHg1ODANCj4NCj4gWzFdLiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvWkZIZ2VmV29mVnQyNHRSbEBpbmZyYWRlYWQub3JnLw0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4NCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==
