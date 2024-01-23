Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C885C62
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041405; cv=fail; b=YzpNz9sssFInUL/Iu+wA+Y5ch+aGecim/pWUKOBRZCT+uzOv4dcRAucd8c7eT9xrQyT38nJoo+jCFu0KCu9Guh+NfpTKCFG6/CUC/QL+wNCPG6tQzFsVZbX6JKzKbl59BhNIebmje2N4X7q7W/mVHFyguIYeCsakr5027YbcbXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041405; c=relaxed/simple;
	bh=UsNYe2ugoddsQzFUMvRamYSm4Y+/7j/nDLWji/RPdGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qquy/icNxCZLAReZhcpGlDnbeerpOv7tDjdErQSggSZkmeTxe09n/5ktwjkUlKRGkpi5Ao4JdgaxhjbcmKHRQOsfzxP7G52CN0+SCD3fMq8kmRq9/Gf4A+OduUQ2ON0Vf1aA00kRjbapoaKKgDWQITCB2kIEuLqiQU6Hcn3ZgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lYL67KFW; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lYL67KFW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChLfaVrKbJSKSujULcVIgvv+NRvGExP6mYd5U6SCjPhXVQrdGHl+disTjw+LVTbdiN3pYC+/J2WdTm67GCOL1kd9I+LFCqrjZ+t8A01mYHdtuBlfvpj7IcdMNeMR2Z+nyDZUu0cbEhOqVRIpZQRnxNfc4STw6wBAZ0soxw5+clZq9rIr7tzcM6LTi56A8cNbMGog1r5LhORhzNnhywxA54h7E9jIrSH0AhbvXrHniVOSySy7nQHaETQ/tIxxKL4m7QqCMZtalu4IdslAsf+6Z+qCKhBXDulOJDswahzb6yGz8a2EGKNBmKcdRAhB2GabHykiW/sHDF8ONQF8c68j7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsNYe2ugoddsQzFUMvRamYSm4Y+/7j/nDLWji/RPdGE=;
 b=LPg4q44Y03WByWJOOF6U0NDm12tL0eGrmGGEwESQO8GbOkudf8pP8s3qF6pEiC+0OPNxfoCIAa4ZSxsNGaI848UeK0h5k078yfOo5Rix7Fvfm3XWK5BzkYZu28krizjlIDrGHTy6JeE0SP3d5dRUgDDdhPyXvDvsDqgvBrtZT/YX7YJ5Z1/EujsMcIp7KxmEqNnZmj3WWZdWSALDqDwtOvTZX850Kz5SNU81kEqMgU9OmHDaZt0XDEGPUX7z+3V/TGWBRmRZl+yJw8SJ/hCMg/HqhKmFpamAIiDhUeNAvwkOJs826fH3hbkvUL2oQnfxTQ878JjvrsQbM4ORFXEFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsNYe2ugoddsQzFUMvRamYSm4Y+/7j/nDLWji/RPdGE=;
 b=lYL67KFWqEVo1s8hXkQqVKCf0lJ/ZGuC0jGoYtt6yiD0+y9gbnstA/nhh3SjbAPAFyCuR7bT4lkXUV782kci9N0SDmrzt58sli9MiWDcaA6Rs0ZzrwwKLom0kWnL8nhlEnCLrgv1iWwuLaJiPR8Bvl+x2LI4CtsJYRH67RqFg0FzVEzUvOtyWvz8YcMAYbXk2iPkyGP4ara2hNf9h+iNSSW+b5QkUyPTCpm8BhQjEg29Lohml00u78imMfAHjnQ2g4hIH1PCn5mCqWQCfCqliTTX4wzqJeam5wVpV9TwHvRZI2+UFCQjhiWuEuwWxcBds5fHdAwC92UN+rN6azERzQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 20:23:21 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 20:23:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Damien Le Moal
	<dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
Subject: Re: [PATCH 11/15] virtio_blk: split virtblk_probe
Thread-Topic: [PATCH 11/15] virtio_blk: split virtblk_probe
Thread-Index: AQHaTVm1CdUUOPKyO02zeqNP0ROyobDn2VEA
Date: Tue, 23 Jan 2024 20:23:21 +0000
Message-ID: <e61434b8-3d28-4a9e-be19-f0d728fa4a7f@nvidia.com>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-12-hch@lst.de>
In-Reply-To: <20240122173645.1686078-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6006:EE_
x-ms-office365-filtering-correlation-id: 692151f8-c4b2-4822-909b-08dc1c5124b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 274Lu4iK16mHTjPTTLd+yjR5lFpI7gfqBAgk6kEZStzuYojBVWhb2wbKYgtyxaj4gsQMANJGO0HtLCByECg9CUJcmQNKdaf874ZUtPdBjhiK1RVt0knmzF2Ss/HGhHbYZuFN05+jz4YLXlIe2uqJWxs3alMqGV7MSjHG/QeLV8Sa4Gr/Kb37i7zPABSbjxkoPVWvsw5odqQ+fsmvPW2aui/cxQzuxClknVXfeaSyTGk31uIEjRuW+fqnY64sSS4ztmQVvx3u+D1a4+JRhmDA6CNXZSDMQfwnzIp9gwKfERptbnGPBi/5WSnnIdFbofCu7HIQF46QPLgx15ABk01h4rxwOpiYNr+wUR3UUCdhvTgW/fWQfYKaQMUqm8o+2Gx0RW7312vTGPtt4fBv+xClaOfMGorNnr8HTSYtXY7SeOB0F4VgQCYPqQdi6qDqQ2TO1VINF3Bt/hzWqe8lGWCKl5Cy0ylmmbRW7c+HxyCZ6f7yCokmH5Agejuw8O13m5U2KLaq+pAAnV/cNuY3UO1BA18J9yGBtPyIojhuNyow91MyD6/m/kZV+dk5vM6Tvm2j6nRQ8nfln02v5I038r2SakY2MLJ8ZnkTcF1DCJG30OgaINd2sFbSBlWXdVLixUMSlhC09FdBd1PfGE3i8RUyMR3jcqYb9YSyppEr7hJdnDWglQpqQU4jVGECI+x6axPu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(64756008)(91956017)(76116006)(66476007)(66556008)(66446008)(6916009)(66946007)(8936002)(8676002)(316002)(31686004)(54906003)(122000001)(7416002)(5660300002)(4326008)(38100700002)(2616005)(6506007)(71200400001)(53546011)(26005)(6512007)(478600001)(83380400001)(31696002)(86362001)(41300700001)(36756003)(6486002)(558084003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dlVIbUdrZVl5OUtjeE0wazBTUjc3NmhIdjRnbEhDODhSYThiOGw2aTNKWU40?=
 =?utf-8?B?S2huQW1jVytXTFo0Zk5vd04zQXljVEtwVDRzVUc1R0hVTlNMb3l0TW0vdWRa?=
 =?utf-8?B?ZkJCR0ljNmNiWVhMek9weENEaEdXbkttSHF1aUlVNUZTMHN0N0w0dlBaTUlu?=
 =?utf-8?B?NEZnQjN0eThnWDB0YXNRT2RkRVMweTZvZWdxR3pLa3BSOWF2QkZWRUFvcVlV?=
 =?utf-8?B?d3hkOVNHNDZZbDhHNzQxY21nUFhkMVdDM1Brd1dmSWF3ZUo5S3RsV2szRGU0?=
 =?utf-8?B?SXhEaCtYMmhHT3JkamU1OFJCTFArMFFmYjVZb1l4NSthclRNdTRQS0xhTWlU?=
 =?utf-8?B?WEhPOGZFNWNXZzJHY2JUVjBMWFpGYTVyUC9oeEwzRnAwTkFDRTBsUHhCUUJF?=
 =?utf-8?B?TEtGNzlncTk4THJBU0xQbXM3WnF6WG8yeHNLVWJueHJHWW1qaXhqbHI4VVF4?=
 =?utf-8?B?V1FlNlJDUFdJNEwybXZwdEsyVHVBcWZCTVRwUld1TkQ1QXhEaFFINlh1ZlUz?=
 =?utf-8?B?cnlWeEl5UnVBTmZGN1lmVG16V3FhQ1puY1B1dmRwKzhuYjNtSnQraTEzbWVl?=
 =?utf-8?B?ZDA1NVRWc3FkU2duM0ZZQURXdktnbGNMTllvM2xpUDFRK3FkbnZjNm1BUmN2?=
 =?utf-8?B?d2lrRGF6RHJVbEZvNzJrOEd1eHlmamVKOG55ZUJ6M3Mrd0xQWDZmdEYvdDZz?=
 =?utf-8?B?M1lvb3hic05Sdk1sWmJnVEFqWlpMQ1JTYTlGU21RRTI2aEZ2bDMxYjhUTDBv?=
 =?utf-8?B?d1dtYXN3TFZzYk9icTZQQXhUQ2RWY1RsTG0wbXk5MzR2VHdyd2hQWVo2TXE4?=
 =?utf-8?B?MUJUWWVGWEQ5ekJPdjhTQk10V1ZNOXRtQnlCS2tKcTE1bVJTY0tpemd3bXlj?=
 =?utf-8?B?UmMvdW02T2gxZ085Qkl5TCt6T2g2WWIrbnJmb2FXY2pHNHFNTmxHU1BUT05L?=
 =?utf-8?B?Tms1N0JubDJsdlVtZk1GMEdCQUZsMllxUkJvd2pJQXlRRXYyYWR4TG8zRTI2?=
 =?utf-8?B?d1NFTzN4Si9pUEpwVzZqWGF1VThZZnpKeVBiTlR4cTByQlBvd0hkeWcwYmd4?=
 =?utf-8?B?QnZ6OU1OT21kUWZxU1FuNXZNb3JTR1dTTWNUTW90OHg3TjdIdFNoRUR0SEFp?=
 =?utf-8?B?RjFDUDVtM3Z0MlJPUTJJYjhnNW9xR3lpUVZ4Nm0xN0VqSVFadEdvSUl6V3lv?=
 =?utf-8?B?eTd2d0tqSHFaUWxWY2w1NUc4MXVpam4zNUQ5STFySnp6UHhnaWsvYkpBUnE1?=
 =?utf-8?B?Q2pOU29WOTJRNDA1KzYvZldkQ1U0SjJSeE94S3lTZHlVUHNta0NpTlVlL0d1?=
 =?utf-8?B?WGFDZDVIbzVydFR4K3cyR3JRRXMzQ0NnWFY4NUtMUTdCV0NudXd1UU9CRmU2?=
 =?utf-8?B?aEE2K1RjR1A0V3FWanQ5dit0MjJ5NEtHaW5SODF5TjRLb0ZPTUhVSU9kcUdx?=
 =?utf-8?B?SzRhdzNHYW41Um16cXdKYlAwUFVCRlp4MDIyT0FqNlVJNGxmN1c1N2M2d1Bq?=
 =?utf-8?B?NEcyU3laQnNoMU9sVXFDQy94cWFaT3Z3aEt1U3l1aTBRZUNEVXVURmpjQkFM?=
 =?utf-8?B?YUQya25ub2F6Q2VXUXhrUG4weHl2WTA0ajRoZUU3Z0ZQbUErSEJMVzJzaXBx?=
 =?utf-8?B?bGIrYjFkREhjQzlPbExKUHN2NmprYXRrWjc2RjgxdFZJNDQ1bFdlNWxuRFhi?=
 =?utf-8?B?MkRyOTZ1Z1ByWEhWRjl4NnAwc3I0ekRYdGhuVVl6TGpwNktZaDFyYXpHaVVY?=
 =?utf-8?B?VlpNQnV4aGptL0ZreHR4K1Y3NE1iTHdEQlBQVFR2UWtndmZHY3UxT2k0MnZH?=
 =?utf-8?B?ditjbkNmMml6TnJjK21LR28xZTdHS1p1VUZUVHdkODFBMkg0cjZ1Q0RVZGZO?=
 =?utf-8?B?ckpvZmxWK0RwcVd3cVFzYlJvZURLdytZNmlLekpCblNnVHhiaFJBVWFPUlVN?=
 =?utf-8?B?Wi9uZklIdWwyZ3NGb3I5eER6RFJEWTh3SHRQam9adm9kK09QZE9mZDN0VXoz?=
 =?utf-8?B?RUdLUHQvWVFNeThjMVB6NUdXM0E5clBSaHpEbUgzOUhvd3Z6UjhHVVBwakYr?=
 =?utf-8?B?VUo4ZXZ5bC9YSzVoY1pRMUdQeWxNb3IyNTBKajgxTmdCV3hSSy9razVaakVH?=
 =?utf-8?Q?ibSfjL7TJQw1rFZxlkMafrdK9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C8166E92A5AB644A864EF2B3034ABCB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692151f8-c4b2-4822-909b-08dc1c5124b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 20:23:21.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36HRvuH3YSYTjvjDenu71XN3QyVN92tXFVQ5VElTwmyCyO11l+tzznPp5Azs2/4RZ+5EUP2R7l50FIPO4SbUPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006

T24gMS8yMi8yMDI0IDk6MzYgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBTcGxpdCBv
dXQgYSB2aXJ0YmxrX3JlYWRfbGltaXRzIGhlbHBlciB0aGF0IGp1c3QgcmVhZHMgdGhlIHZhcmlv
dXMNCj4gcXVldWUgbGltaXRzIHRvIHNlcGFyYXRlIGl0IGZyb20gdGhlIGhpZ2hlciBsZXZlbCBw
cm9iaW5nIGxvZ2ljLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+DQo+IC0tLQ0KDQpUaGFua3MgZm9yIGRvaW5nIHRoaXMuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
