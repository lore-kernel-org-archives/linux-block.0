Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC18C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKBBU2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:20:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5820325E0
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aANrlZ43uMmAyxJ/WJcRCwvDFYmdojrI0zRQnQFLbdwiogB04Zmau6j422e5zG3RZVUDltM+C5N9T+GfctN3ynKL3cMPQtlnoCkEuHvILkSXe5YRuDr2Q1U9LAkLWX0y4nfypqiQL52O/vpoQ3ITDrNC9YaY7rVdubWkZRHZglWXInZ9d8ANpBzlLAyK9Ou51QMzuxwBQY/O4TkCT7kSkWyJYevAKwHt1IBr3st91+n3W06g+bYQDl6uRs9JEVkroa+mrxoCDXgk1Nc6oJX9pWP0g4/j5l6HxoBQ3eUxwPed+6SyUnTgusD10rlPuRZdnpqA6WkMRa0nqjF3NnP9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfVIgF435Kx5gH0beLYmmuRRKjArq4+acsifKP5pjj0=;
 b=Hk1sdz9arGMMJcoquEVGc3B1XuTzVvCzoW7AImRicC2rsTY9KH/mr0sPfUFVN3dAlL0eYZboISbqcPYdodsSVfr9xWcAJV9Y8n60i4wTBXpWM6k0VDbHiDGPXXVLoVR2bFbkSRmeduG8TKvPAtkYddJ9CKg4jrgGvonMovOvkUaHMgN1xlzQ7YoYbUVoDbvJqwZaA4e3PevjV6AvbnpFxqIPj7gTfOaniwyIqY8c/sUta178Pyi52p71lzETlF+heKTyTRBqTSXVqlZN/LqGmov2OHssOCeQjvbAd8eleYcI/zw2hdGWX5k6i/VMgm0SrBL6CwSkKBs0xoy+Sg/TZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfVIgF435Kx5gH0beLYmmuRRKjArq4+acsifKP5pjj0=;
 b=ilQyiqxpWrgp80G5EYsTn5y7L7tBYxRJi3jARQ223cQNQ3FLSNCQSaN9EsdwATOcZ0j17ZOo8titRzoP0bc4NFDdc6C/ZTR9TlubdxcfcC/+UfjZgajOtghCvtPv3zam72u80o1hOyctqTLPqkarSVUve0tgBH+XgSn1W0U49XYRyyjI4HZ6AedLrEr/sXs5s1mZdqLibEPirixn2jvu8jrcZY9nM3ELnb7hykqRyeqOgypIEcaQiS5koW/I9OQg+R/1AqA5Kpm8C+0E5r0PYrpyLzAWK6ukMDdB3CGxdvyx7Mq6rvUoHCyryQGX+5h3emB7P/R9HwBG49GfH4HG6w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:20:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:20:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 03/14] nvme: don't remove namespaces in nvme_passthru_end
Thread-Topic: [PATCH 03/14] nvme: don't remove namespaces in nvme_passthru_end
Thread-Index: AQHY7gL3I2MVnrakqk6ByTpBzzCRXK4q1omA
Date:   Wed, 2 Nov 2022 01:20:23 +0000
Message-ID: <0cb8ce05-4c99-d66d-f2c3-c1f8d38d4fa3@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-4-hch@lst.de>
In-Reply-To: <20221101150050.3510-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: ea6db438-fe0b-4c60-472a-08dabc706ab4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: td+4qAghU9qasD1j402kMm78JH+rR+NbwOZLd+yPMujDh3lFsfYLFL6KEzG+fgotLqH9juC7evysz8ie0gNxQXnlcS69WRyZbnucmM1sCYCq2ORq3r+y0V4ikClgI7WdSeVjrGzUDQquV42PjJWxJv3ul8Cfa5RP9ye7DxzNsnVnQzDeprYuzk5oLmOsRSUqboEgnBUcZdVG2vbTDakvQTVRrWfAxdkqIbmBQW8NHBEW9RAG8JplsvHFLY1eVezMTztZSzoZ2WGts0+pR6dbChPfuu5PxJzwkMg7rp1S09pEcYzekdzcsyGuWzKg4OzsQoYgAyn+iRtwFOxwoo8H4X35GqenJnNkOY/aU8hJr36Bpgi9Jmpc6AZUt1YtvHxRo/Dkq1+oPngYMEGznT9BXfm2sT1VTDijH1phSv13sQdBa0EkpPFlA4zebbgoGQcubvMLhczlEwC+rPfsTQkLuhURvBPKdFQXxDeXpbiG9Qn3zbQQUXRg7u+Dj4HNbbREGUSnJMRkH/Apa+TfSoeCONI2SC/J6eaN2fohGqoAcJK6/Ga8Lv9WsUiIb6nTbULatyWxOthM+nJaE4lGRb4g8Rnjx3YasGZsGeIoaLROjpVaG7a6VRUj3s4ubGAFOwItB4gqGrAbGJArm+oswK/9tm6kyvFWzWzv8Sj1TJ7wtoe29AF8NzpO/AV6SOJ4v7xLI2rGWr9Zb55PCwc8i0sRubH/z28PYCwuO96QmCdiuFEHCm03nDIFbvtPwans/pePrdNYBA0Gob5cgc0cF9ItJOh8doNurYxeXiAmmpKCJNfDRtzjQ2PaN/CrGVP/gpPXl5GZctVXStPDLWsdeEG1Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(110136005)(316002)(36756003)(54906003)(66446008)(66556008)(2906002)(186003)(122000001)(83380400001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(5660300002)(66476007)(38070700005)(4744005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V09ETWtBcGZYZTJFSlh2UlZCSFNscmlEZDZHWmVaRzA5d2N4UE52dWUvdVZx?=
 =?utf-8?B?SytCMkZDZTl6MVZFVVozU2QzZzNhNDgwWWtGckVNTm0vYlg4L1hOTDNxSFBv?=
 =?utf-8?B?RmFhV1FGdHFqNXViT0poZEFZTnRvZHE0N0VFbjFkTlV5YWoyRzZ4Ums5NW5X?=
 =?utf-8?B?a1ZqKzBUZGVKeHI5SWxoWHlhSXp2T1ZLVGtMVVp2MVEvL3lGUlJNRDZqSmdE?=
 =?utf-8?B?YnhYK1FUWVc4bldSQjV1bnozRXo4Mi9NdmNDcDhhRnFhMVQxZFBNWXFJSDY3?=
 =?utf-8?B?ZDhWY3Z1MlM4ZGtjK0lWTEJvZFNUMndmTEM5ZWZxaE03QXBvYlVtN1dqLzV0?=
 =?utf-8?B?UXRDVU0zSmwrVEgwVzBrQ3BLRVU4eXExTXNqRkw5SjcxanZYVVJJRXgxa29D?=
 =?utf-8?B?b1d2TU1wQnhWR3FXbmtKYW9veWEvLzRsemVUUnV3QitwSTMzZ2xLZnlUazcr?=
 =?utf-8?B?Y3ZWUjYzazVTQVEwdEM5N1J6VUJJajluclIwZmpHSWdMZEM0T1dJYUNsMUE0?=
 =?utf-8?B?Z1lBbkN1eDcxeFpySEQ2ZEhMM09aSnF3YU1KNHpmU3VIV2s4R2RURXc0MFBU?=
 =?utf-8?B?VmJnSTVKZ2VUOS9jbWJmWC91aFk0RS80VVlxSENRMkdSYlYyYm5zY05NRjAy?=
 =?utf-8?B?aTZzYWNtNE9uUlpkTjN3a3R0aStONVU1d1ZUSld2bVRoSUUwYTE4dXQwOU9E?=
 =?utf-8?B?R2lwQkMxcWtVUzh5MzdydjBzV29vVnllNkhtTWhzNUNabERGdHh0Q1lvQ3Mv?=
 =?utf-8?B?VStZMi9FSkhYNTI0enluZUo1T202NWRWczRkbFRKMDFianRoK3FBelV6aE1t?=
 =?utf-8?B?SzRnM3JlS2FvdGFpUDAzRThVN1EvUVpQSmtOaml5dVdsZ01nSWltcHJZb2lR?=
 =?utf-8?B?SEZpQmJnYVhSUTZOVndrdVpHbXFja3JOaWtlN2lHbFBhMnc0dEpTNEVjS2Nz?=
 =?utf-8?B?NW1NWkl0ZFRIbUNLd05jYnd5Q0ZZVG5pTEU2R0RmMlUvYlcwQmxUNENwODdP?=
 =?utf-8?B?WGhJS1RlVGg5S0lPeEY4T0pnZzloaVhjak5udzdMNjlXNHppREFxeS91U0Ev?=
 =?utf-8?B?SWhhUWh1cmhNOEtWZGd0UDM1QzVZRHZvWm85dHdJWEFHclRqaTRicUdDbjRL?=
 =?utf-8?B?M2lnMjI0QkUrTGlQMUVUWEg2TGIwVVJ5STBWVFNQeEdGN0NKN3lyaHZJUHRC?=
 =?utf-8?B?YzJYanBCYUJ4bm01SDNXQmRHcGxBUytvb1FiUWltWEVSb3I3OENiNWEvaVF0?=
 =?utf-8?B?b3U2aFdpNmhCYVdDbHBYK0gyd0tVTGhwUVhOaHA1M01tT1NSeE53OGZ6Mk0r?=
 =?utf-8?B?ZkF0V1FXNXR3c3g3RTFmTThEU0FaWTJRVGxlb1MvUU5RZHk2SW4zTHJ5eUwx?=
 =?utf-8?B?RHVpQUVFYkpNT1Z3WXR5eFoxdnVCWWFZUndwV2VWL0xpOFlmSVFzZ1puMFYz?=
 =?utf-8?B?THNQSkFGNVF2MVQxWk5FeGloNlNJdWFEeTYzRDJ4NXJqSUJER1ZKZ0o5d01P?=
 =?utf-8?B?azA2SmhseG9GaG5iNlYvWVE4MUxCaXd2MG9vQW5ONzlhT29Yb3NnRFlsdldM?=
 =?utf-8?B?WEx4dGdSVW5SWElLUmZuTG5vSmRkaFd5dFJxdWN3ckZxVktnVVZyTXRiTnpw?=
 =?utf-8?B?Zm9BTVdaUXRBN28ycVNuUU5sc2FPblFWK1NSRDUybGQ3ZzJGNDY1Ylk1MHN0?=
 =?utf-8?B?Wmx2Uk9TVHpRaE44K2hrT1ZXT1JQbGRtbVBxd2x5Y05tV1FDRjgrV1VURWdh?=
 =?utf-8?B?ZlVPcHV2V0VXdWZvZGlMcGJCQ2FqeGp0N0pJRU9UVmY1ZG1kV3R1eUVDcWZU?=
 =?utf-8?B?UHJDOTBQdVJCaHBmTHdZeHlZakVNSENzZkpYb3dyUDA2ek1GaGVVNGo4RUho?=
 =?utf-8?B?cS8rQjdkMzVyNUQrSDZuVHE3Z0JPcUEzemFIb1NBS1pwY1Y2eGdZWnlqNTY1?=
 =?utf-8?B?Vlg4WU9kSitMcFZTTE8yOW1xSG5aWnNzaGZwaUtZM3BYTnIrNlVqSjZ6YkZi?=
 =?utf-8?B?WVBoWStET1N2L1ZjUVlwRUxvbUpqNUQra0FTZklocHhkQVNXQ0JYWitBWEVU?=
 =?utf-8?B?OU1KcWs0MFNtQ3ROS1gzVlVXcHdkNnk1R3RHNkR5SFRZWFB1cGcxOG1jc0lK?=
 =?utf-8?B?eU1ZRmpiWldYSTQvYStXRG85LzJydzhRekx5OXdibkZtOWtnT2VhNDh3dm9Z?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <363CB625BC7D0F41922EBE0841E2C175@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6db438-fe0b-4c60-472a-08dabc706ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:20:23.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/TXBIr5jI3ZLCiKuHS3Z8/NQuIyBYNlipvdqvnMQZKNgD/y0M//KDWxxvL3jgVka/dtHVIMED0gvT0DopRD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBjYWxsIHRv
IG52bWVfcmVtb3ZlX2ludmFsaWRfbmFtZXNwYWNlcyBtYWRlIHNlbnNlIHdoZW4NCj4gbnZtZV9w
YXNzdGhydV9lbmQgcmV2YWxpZGF0ZWQgYWxsIG5hbWVzcGFjZXMgYW5kIGhhZCB0byByZW1vdmUg
dGhvc2UgdGhhdA0KPiBkaWRuJ3QgZXhpc3QgYW55IG1vcmUuICBTaW5jZSB3ZSBkb24ndCByZXZh
bGlkYXRlIGZyb20gbnZtZV9wYXNzdGhydV9lbmQNCj4gbm93LCB0aGlzIGNhbGwgaXMgZW50aXJl
bHkgc3B1cmlvdXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+
DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
