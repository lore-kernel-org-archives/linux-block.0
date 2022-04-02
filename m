Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F8CC433EF
	for <linux-block@archiver.kernel.org>; Sat,  2 Apr 2022 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345626AbiDBVlF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Apr 2022 17:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbiDBVlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Apr 2022 17:41:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC1810A5
        for <linux-block@vger.kernel.org>; Sat,  2 Apr 2022 14:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBU0dApA1vYBl2F1OGx0hvMOvAAiCcOJ2rmyDYtq7qrMsyeTY6vjH+NMCt0prcTKzVQTzHbJWebWlKwEXNxVcHf/KFKXE+FDuU0VmNQCZ4RBCmROJu6Yl9a7G6SQT0eVbqkNvK2babJAlTGsQHu4McRq3FKdQF32Fb1wM7H73TIZ8pt2iraZmEMRok6lCOgqvMfRSk6heVMH5brTsTQEQ2ZmRwSksIQB5ph0Gr8LLgJCGHr1jJ/G7YM+bE04BXH0EPclPM6scRsgQzM3Za6phMDtDoQU04TSiNB4r08z9Gvgsin9kJsLknf2cuw0QncSA4h6gH0bf20lhMoSrKGKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3KnY+SBpUtc1q13ypAC+ZC+nfefVNit//sy32E1GRY=;
 b=VCEdhlh3AgciTd2wrR3oSS/Sjcy40m/ThXs6CG68QnB+iFpLo1993RBw7Fd7W2CiT7eSbCEqLEIVH9DrmCL5w8pPebdjLXsc3TXH0kw8tssWFirWtITBUR8QkEcQmP7Lfe1mxCmkQmvV8rfVKRasFBs8ZKvlc6ZQlBfOYFB4WLYXD8IIUTnZVrvIaBDH46fRi1KzAx7E2W4EbXNvUVy0dBl6kNmTyVrX0xHrik6iU81Jo1yR8tfcbMqqSfLOnn/cfttRSGdmMFx9jgpJAAv+ejTBCozsB4OAwzopgvmMJsAuNHrZ86C/gOzHKx8C9cjeh5nBAPNN0zEi0qt+W2qC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3KnY+SBpUtc1q13ypAC+ZC+nfefVNit//sy32E1GRY=;
 b=msIozZ9s17kP69FPKzqvrXS4SFc14U4LG3iSWaoEJ9Z/tlsnVDAhACLfj2ps2YMjfCX6refzXuyc/LLpbHgJa7+uEjzmzT8RwmKfOkQJcua8yszGe43TXllNO1rn2yB+TezmNS3OLgP/Naut/VmqZK8mLnkhVKCl+pccJ6ftYN0ifinCmBxhJbYfWsL06k3qr+p5UeP1I5mi7bLKkTQ96tH4cIrn9Wi9DA57GIbcXAK3U2tOgJ103eR6EZw21ollnp5NAptQdCfSi1HEsIdBseR4yJ04a+h7k1rPLxn3YEzpODmqKfKgRooNWQyVeWOv8rRLp56WYBw5CisLd5GEOw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB2662.namprd12.prod.outlook.com (2603:10b6:a03:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 21:39:02 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 21:39:02 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Thread-Topic: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Thread-Index: AQHYRUjBwnGPk6IwqkO7sMN+F7vJGazdKZCA
Date:   Sat, 2 Apr 2022 21:39:01 +0000
Message-ID: <4586da1a-96fc-ddf8-0abf-96d5774c3b41@nvidia.com>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <20220331214526.95529-2-alan.adamson@oracle.com>
In-Reply-To: <20220331214526.95529-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df38d266-a968-427b-0fc1-08da14f13422
x-ms-traffictypediagnostic: BYAPR12MB2662:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2662A045189C15B0B93E23A1A3E39@BYAPR12MB2662.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OChSmHi7nTQqOs2jYNMVfJue6pUncberxTKzid5GKFQNRBZjdLu3/fd7klomPTiPEUZVwkdUFI/y8TsvP9OcMfsLFo8+iDob8X0y4st3rNNvtd5QyzRh8MH9EXuFso5LN364iIJz5MX3UEIomQ5BN63VAErRSSTsojK3UcbXgoBvX1Zv1aBsVDW+v/69PVNPe1g/g9sIuF9eXgN24OV5vDhgoU4ovBDW+/pRpiHH3LqSCmHFkNTfavYTKWQulwVvqwhgfK84TD4t3pJDjKd5H4yiw3QGry9KzDf5Jy1WjRvTs/N3sX3eF6Bg0xCJSoY4d9ZskHJtzJokWJTdlldcON7qJY8bfUjRrX6UlZEWCGkH6fknUA9EuBeAm2vyD+RXh8kNqvKpOY6i3cr1jaeESlrT/RUxuSinNmY0JIdLoV88m2dVepY09WKgdnJKxHeLK6NwXruwnekOBAulsci86OCMVNTk3/hLkaU/ZU9Y0lPKwWrBBOTNvHxH3oUFmpZLj2qZBUYnvFRar/oJV0kMlAk+DeJkb5kGQWwFwc0hQVZSoCKNdOnu+KZKNqEUy77RISNdiTSCxtn11Zt6rlVKU5wn/I7i0RD8F8v8UfUNZhQFvcLwwvM8HozqAJdMg+RAnh3O30K8L4mpBkU9DoG97qznM/4Eq0Cm4kGpsHkw7mBkgAURAt57qdEk9UXXMvNvMMVRKGeJZ7xKXnOJa0v/gNyeKdvp47hfHqoN33wIYBFuzn0jz8D0F3Ru5tZPH1ZJ9UFQbrRIzzSYdMJk0LnJ6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(2906002)(86362001)(508600001)(31696002)(76116006)(91956017)(6486002)(36756003)(316002)(6916009)(54906003)(66946007)(5660300002)(186003)(4326008)(66556008)(66446008)(64756008)(66476007)(2616005)(8676002)(38100700002)(6506007)(6512007)(71200400001)(31686004)(38070700005)(53546011)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmkzUW9UdHlBRldnYjVpalZ6Nzk0WDhZbnhlK05oUWY5ODJUT2tZYjZNVzVt?=
 =?utf-8?B?VHlENDNpOEEvYnVyOHNFZWMxNzRWaGtvdFUyV2c3TzRkaGE0UldJVlJuOEhs?=
 =?utf-8?B?WmRpUksxSDYrUjJYRmRQVG1TbmNQK0FWQTN3V3duV0RlRmhnTGFjaDdnLzdt?=
 =?utf-8?B?MlhIVW0wUFBUU05QUXhBZ0lUMlZrVWFJeWZ2SlJKb09QQ2FiVi8rbk5wekh0?=
 =?utf-8?B?OFRsVUtVWVpNTEZ2dzQ2NzB1MFR5ODVRN3NFd0pZUWJFamIrTG5abmRpRDhR?=
 =?utf-8?B?MnhvNzg2TTRQQzM2NU9VTzJRWlYva0VDZ29lUCtYNXFNYmJJTS9QSSt3MkV2?=
 =?utf-8?B?TnBDclBTOUxDWTl0bkhxaWNaMnAxNlJOazE3OGZ4cDVqUTFkM3c5VWNobS8w?=
 =?utf-8?B?b3c5UUsvemN6MU95ODhZZWdNbDk2cWNqU0t6QjFNL0xWeXczVWxSMVBqVytO?=
 =?utf-8?B?NXo1bENPWmhka2xSMUt2ZXZCNlczREpSbjI5MnpHUStHUncwdUQ2bVFGcEtO?=
 =?utf-8?B?Z1VDTmJMc09mMGlqblIrTitmRXZMczdSUSs3U0p3cU1SWDBEVy9yUm5CSEpK?=
 =?utf-8?B?eTBTNWg3ZERUWlI2SCtKZnJ0NFlGc3RXd0FSdGY3dGNONUdjRlN5SlFmd29G?=
 =?utf-8?B?SEpucWg4dDloNXJaVGp3N3owK1JtWFUvVWp6V1NCdjEvZjUyTDdQakd2bTZP?=
 =?utf-8?B?SFVjSmxPYXBLVXlIenM0dFA0Y1BqRm13RU84Q2RoRnFLSXNmUG9hS0V2VndZ?=
 =?utf-8?B?MjdXUmdBamdOMXJlQkk2S29QazF4UWpibDVPZ0xWMEdjNWQ4TTRaZStvZUtY?=
 =?utf-8?B?SjlPOFJVRVBWQ2RWbG91N3hjelZqOGJla0NldTVGRzdINEtDUVFySllZeHF5?=
 =?utf-8?B?Q0NhK0VCTWFwb2M5ZnJrZU96UVJ2ZlgyY08rYkhFcDl1a3dKTmVLeWZaQ01M?=
 =?utf-8?B?aGVWSVZOMVZyUG1ZY29LVVY0bHNIcTNaOXN0bThqZDFGWjRtbU1vYVZ4WUJo?=
 =?utf-8?B?N1ZubG41UHNTL296S2lKK2Z0Yk9TQlBFTDJvb0cyRnpoNlRoT0QwaFg3K0tx?=
 =?utf-8?B?SjFvUlo3QnBxSXQyS0V3Wkc5SjcrVTU1Ti9neVkvNit3NWsxYmF3U1NKWWNi?=
 =?utf-8?B?SXp2b214algvS0hlYXFVdVR3UWhqbjFHRnplc0VpQjcyRGlGdzdkRXU4OWgy?=
 =?utf-8?B?S1ZCaGphVEhSVWpNNEZ1ektRUWkzc1VXOWV2YVY2SFBzb1czVUdrNXgveFRD?=
 =?utf-8?B?Z0Y4YUFiU0o4M0VLRnFKK0pKRlpZSnFLdi90S1VCRmZ5Y3JrZ3NJVU9OOFFp?=
 =?utf-8?B?YzkrdE1TSmtySzdXRCtmS1c1a1pnWkVpRk9aL3hkdlZTWlJlYmI0dGRkeURP?=
 =?utf-8?B?YzhSeGEwWlR1MXpRUURKbmdNdVN6UEtnN25hdmR2d2NQWjl3dDd2NFpVMng5?=
 =?utf-8?B?MERLaVY2ZWo4RTA5dlpsMVM4a2twbkhhQzRWZCs4YnRDSkhKZWsvVWJYSGIw?=
 =?utf-8?B?RHhiTllQeFZsZWNWR3N6dEpPR3V4OG9wbkVhVkp3czBFNENYdWExcm5CTGt4?=
 =?utf-8?B?WEtMeEFaTDluZWNaRFVETzhONlFiRldBMm9kTDd1YlhEem1hUndzTnBQaXNj?=
 =?utf-8?B?amF1VUFsamdjYy8xRzNOTFdyci93TXJ4VmtIemI1aENBVld0REFIZUZaNWk2?=
 =?utf-8?B?R3dFVmhGdUxtbzRPRUhSc1lSQ3hYdURSalhrVURGVmxUbE9RRlRYUkxEeWNW?=
 =?utf-8?B?VkE4ZUV6dkFVU0srTkV6M0hRNGpXdVRmcFBPV0puQUF1ZldtWXo0NU5QSUNl?=
 =?utf-8?B?ZXZka0F3WGRZa29VQXhjSy9wZlZ3ZnlVOTJGN25WVjQ2cldhTDBnd1ZPL0pZ?=
 =?utf-8?B?bzdSZzZKTnRoaStnRVZSZ3BLMDd3VkpRUmtNaE05aG5WRnN0UlN5bXpzcm1F?=
 =?utf-8?B?WnJJcFB6WUtPdUw1cHhsam0zWjJyQW9yQTIvNEZnYVhyYnBzT0pRNENsUzJj?=
 =?utf-8?B?RGNqcWQ4TVlCR3JmOTB0VFI0RFgwV3ZURzZOdGVXWFVIYldXaG5Nd0s5Q3pD?=
 =?utf-8?B?dTNNT2lkVk14bnhsd1Uyc2NxTSthVW5qd2RzbDdaK0pKcnJUdnJzQzJTa25S?=
 =?utf-8?B?elV1VnArWGFta29iMHVCWWd3V1hZdGUxL2I4MjdyUVd5dTFmZUVQVVB2NW13?=
 =?utf-8?B?K01Dckp6ajU2UmxFWFZ2clN2SnNYbzg0K1JMdWdxSXpnRmN1QnlXRUJqbGw2?=
 =?utf-8?B?d1ZoelBEejc1YzZoUmd3VHUzQWRQeFB2aVdJUHJBbWlCVjNnWThmdGxsbTBq?=
 =?utf-8?B?MVNGMDNxT3puNDB3VGxxdUExdjJ0R3FiOVJaWGUrOTJ2UmZlUUVtTHpMZ0xX?=
 =?utf-8?Q?kBK8HG+6NKTLPWhw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D9C1BF70821D64F98D6BB4395E04856@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df38d266-a968-427b-0fc1-08da14f13422
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 21:39:01.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /toRENOwuhxFFIzs3u2mdhdYd1zJlTlMX3X0U9UuEr5eSlOVzGL9z99kfysY5pRVa3gzMSHlTu+qZkdN6ahpjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

KCtMb2dhbikNCk9uIDMvMzEvMjIgMTQ6NDUsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4gTm8gbWF0
dGVyIHdoYXQgd2FzIHBhc3NlZCBpbiB3aXRoIG52bWVfdHJ0eXBlLCB0aGUgdGFyZ2V0IHdhcyBi
ZWluZw0KPiBzZXQgdXAgd2l0aCB0cnR5cGUgYXMgImxvb3AiLiAgVGhpcyBjYXVzZWQgc2V2ZXJh
bCBwYXNzdGhydSB0ZXN0cw0KPiB0byBmYWlsIHdoZW4gdGVzdGluZyB0Y3Agb3IgcmRtYS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFsYW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+
DQo+IC0tLQ0KDQoNClRoYW5rcyBmb3IgeW91ciBmaXgsIGxvb2tzIGdvb2QuDQoNClJldmlld2Vk
LWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
