Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820E3BB3C
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742885; cv=fail; b=Dqx30aXym6BITDO6iNCrgTuPEzvRLSlEgkTASyC+QAX8B1+iSZ/DMz5H9OolmtkWXe2dTHWxqQcqLeCV+peVy0ujuwS7iuyK2lUTZXyLfpDWuKK+KD46Bv3NgejpN+ibP79Qd5yqAmVlxs8OUVwUfwrlnZtuYIzrxWI+on4XcDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742885; c=relaxed/simple;
	bh=c5u8AoggVi+ck1TA9M89HZnCWwm0Nc8dWqpAQcDoZz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MGn9VwkGpzBDjRns9s8PljXDbkMAOuJiXoARQn/uyKe5xH03xHdn4jl+sTMZEAaHNhrbULnCAxpAwfX1mV0G2FMuF4IR+FVB7Yeqquwr40fimuKU5pQjLTlmBwlT2HItuobJPMNABZWaZPsdatmp6tru/+T3FWq0eiaG/ITPkiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fvfvGbro; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fvfvGbro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcW61YktVmAENgSFCFuCn/ov1+d7Xo/C05kz8/BIABJYgPiNpdKzHzcyiUql6k89R1xoMhbhxKus0olL7gCI793HpoTFb1ZdBupauwt3qV171NoSSiDke/VBYfI9uZiWxworv7z3C6nv6Fvn+LG5hrAaaMLHBCFAeypOKWnEGfRMuWtQSxQyQFGNCulBNLYUHjxhbefOYKj+7LrcyHiwmszamCbAf6oSYuT6QNIzrQ3yLM7eKCZDj5KiCrSbkGHtpLEKfu5tGclUaO7FUQLFqGID24Z3g34ypzHDCvFdawkw7Aewi+MZYaFTqzIhEdBNnA24VhboE7dbUIlbKHmsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5u8AoggVi+ck1TA9M89HZnCWwm0Nc8dWqpAQcDoZz8=;
 b=a4SqNqI9X883nCNyXV59Bv4iVKxQPvpDLLIRTEBtWy8rf1m1dlqWJ/jYj3NVBC9/6NBzORKG8cA5KsiJWoQ8oYzZV7Hl/UgcMPcXul4E9H7noyNtzS9eCnsD8ODgewDOMBCYezGOG6q0xc6Dmf1QoquU2nf3kGyebdXhuM5bWwEN+RI2DVYXUPVWHxoKuq2ZPSebUp90h9I4XeUHRUcXootQce5HMLHhfzTDCiJL4o0Kjs2D3klNfZgKv5tuJTmxsBv3IMYlo26DUD3/AaZ5AalEzfrN9sEi2P/VCLDT2598LPiZXdzQibMyCWjDhwJGt0ZxKMhPgaZmML/WRsiagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5u8AoggVi+ck1TA9M89HZnCWwm0Nc8dWqpAQcDoZz8=;
 b=fvfvGbro3ZlTyXTVfF1SypqLtzIPIavujxyuctJ84UmF+/8AM7AQiTqWlZiMBy9CVaIW5hXJCkP50W/whlocxn/oNrf46vXlaH5BQYEbkO+MUGLcIDCtizKyk+ypi0Gj39rJXOMlrihsKHwOWOcF6vjn7mcyezbMiT5YbOjFUO1Gal8rVAQFFDYHqCDFNTCrBqHooczsO170lS0ZWGs3w3xDmWPqtDcOn9aLQSN4q5jo+SzrP9t3mt03j4sP6f5ngtji1R6m4fY1rCf3wfz8l0NHW6CSz7CsCkBRZUgWv4iB473ZyZvFxZegSQnEkts8R0v4q2p7EewUhu0WAfFLIA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:14:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:14:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, John Garry
	<john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/14] block: add an API to atomically update queue limits
Thread-Topic: [PATCH 03/14] block: add an API to atomically update queue
 limits
Thread-Index: AQHaVEYIrMpcdpNCdEK5OhxiUJFHc7D0jfwA
Date: Wed, 31 Jan 2024 23:14:40 +0000
Message-ID: <374fd172-5490-48e3-a732-1488195534fe@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-4-hch@lst.de>
In-Reply-To: <20240131130400.625836-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB6797:EE_
x-ms-office365-filtering-correlation-id: df2b1515-7456-4ed0-75b4-08dc22b26727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J3Dbbi9Oz0IrA7wBxc67MwqQCB7xpAAUscGLzv8zM5KSuQWSE+0EGQPx2NcKoPmpdDaxpRehsXV8BnNcn4sX+Jpf8aBypXrqBuOQ8qCyhFMU53OiRX8HWcwwyKqfMWJ4GGvK/dRP2vsNSJ5vYrwrQ8a9r1kK/jLUFC2KRVbxVXUfqB1lFUDNraumYnHef1aAC92KegCkOW+DgbtP3QeI8fpJcSMaGRhWQAcJxS/qCp9P+zdhC5t1uAHxhDyuYXY3GqfDIweG/4zasAEjLi0AWkzl9wVBCpOkVsFYSpmJjBMH5NULwA33M3BAbO7a2XT468IQvK/b+bneevCHJhfZAkfzAMJwX2E8tfLcQBkSfutqfjZkDCMU7EshlvXgzLFb/SOtjCt1O6AYqC18LsCdCkEoyRo68Uc0TL2aMi9sqt1Z7YXmtFCf/2bbLk+9sK3YDnXv0X91iipyktmRp9FWOy6uMHaTkrPH9cY3tZZm140LODfvZ5aYDqjZMqvNSZUt2u96vQxRmdeHTEacUjREtDqd8KGNkTKr8toAe5pimjG02Kbz8clMQOs7qotmLNgby7uXhaNeBIq6Ikz2mFXAAKLQDGqvk1e5j6Z4QPpD94t1f37zFNRrqHC4dHuRuJ3AMe9YrI9TZw3EAWqg7g3cyP9LL28CnDCdR/eRyXJgtcZQ67AvF6zaulH/6Ckwxvc/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(83380400001)(86362001)(31696002)(36756003)(38070700009)(122000001)(2616005)(38100700002)(6512007)(316002)(6506007)(53546011)(6486002)(2906002)(110136005)(91956017)(66446008)(478600001)(71200400001)(66476007)(54906003)(4326008)(8676002)(76116006)(7416002)(66946007)(66556008)(64756008)(8936002)(15650500001)(5660300002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVU1MG55ejJFQ2I0VExSVVhvYnVia1ZqZFp5NlZhVGp2V205dnh3Z0RtODJW?=
 =?utf-8?B?WVUwbFdoV012NmsyK29WV3NBdS9vTGdYOE1IOVpMMnA4ZkFrT2UzTERQNG9T?=
 =?utf-8?B?aHdqUzUxZlFzdGgvdDdyZlF6SlRtNi9ZMUlWbGsrYjZVdDc2MVlTcms0dmFm?=
 =?utf-8?B?OHd4bmhDdmtNSUVqdTNVS0p1aWVUMnptY0JkbDJzVjF5NCt2YjVERFIwSG5L?=
 =?utf-8?B?L3c4ZkorYUxndDNpWTljZ2toWHNYb3B5blFBZG1LSm5FUEJHYVIxQ25VcHJx?=
 =?utf-8?B?Y3NEQ1l3QmZEWEpiSXY0R3BwNFEwS1NIaGI1RzNyeitqVU9nWGV3TlBLcFlo?=
 =?utf-8?B?amJtWG95c1lmMkZoenBBSU1MNTdGSFI2MjJCd3RLc3pKeVB4elN0b2JTZEhv?=
 =?utf-8?B?Rlg5UVlGVk0xRGJJY3h4eHpiWmwyZkplSmFvMlVPUU8vWFlNcTgwK0xaOWMz?=
 =?utf-8?B?R2N5ald0WlUrL1E3bktpMnEwcUtSenR3bUNNTHRVMzJhbTdhZXUzOVg3enpz?=
 =?utf-8?B?emV4cmE1aXltaklFcE91eE5FTXpSc28wNjdUbWJhenhjZHlhRG9JbjBLK2VG?=
 =?utf-8?B?eVdrczRmSXd5c2d4OEdxUXR4QkwrcitlMHgvSHdyTUNnbXptcmpPZmJCcHJX?=
 =?utf-8?B?Ym90SllqcjZDMU1zZjB2TFNEaXlTYW5HLzl5MFU5eEZsTzdHZjBPZmZGRzVs?=
 =?utf-8?B?S3I0YnY2TDNUcmhCR2dsdXNSSjF2TWpQWVplZ2xYRzJqMEhQNnl1UUFSRTdo?=
 =?utf-8?B?K2JMSjJ5N3R3b2JncUF0WjdUR2duMkFCUkVpYUxxN01wcndDZFhNL2NjMFBP?=
 =?utf-8?B?cXpCcGYwN3NVcU50dGRPOTl0L1FaZ2xyRjhpQkFQRzJLNjI5UmFiM0wrR2NF?=
 =?utf-8?B?bWpMTGQ4YWFiWU1tUnlNUnBRYWoyZzZGTE53eXRBR3FpeERtNktwVHZDeEdj?=
 =?utf-8?B?ZkRNSElnMXlHR1pxOEF5Q1JVQmxmWjVOV3B6d3psWXhaYkt6T1BPMmNTc0ZV?=
 =?utf-8?B?L2U1Z3ppOU9FUmlzVUUyWW5QSFRxbnUrWEtNNzNyaXJiVVR6WlJVR1U1dlZ0?=
 =?utf-8?B?MmZWVnJnVFJBVDNGSTRNNnVyMWtMU0psZWo4MG1wc2V3Q3pXVTkrTXN3azBZ?=
 =?utf-8?B?UnVCZ2w4NGFtbkZvZERsQXZxSUt0NHREaEJTTldOOTgxRDZJK3c1NFlyZ1Ro?=
 =?utf-8?B?NUJra1RBNkxGTEZsMVZ6N3JiNXdMNEkxV0dTRW5uMkdFY2d4MlI2ZUdpdmZx?=
 =?utf-8?B?clc0WWF3VmhYOWRZZ2FJOFRVeno0ZkdFaXlRYS9VR21IdE1VNERSRnNOUk5h?=
 =?utf-8?B?N2Ryc2ZRbVJ4QzBDblU2SERwKzZqaisxcHlBOGloWUdnNnpZTzQyTzdaZ0RK?=
 =?utf-8?B?OXpoY1l5VDIySVIrSkpIQ1FuSmIrZ1V0Y1pwdTUrZ0VNbzBSeTlZYnpERG13?=
 =?utf-8?B?czJKZXlnMUVKQ0c4K1ZOcGI4UUtjdEhpbnhGUTVwdUVMSnNSUXFqdUl4UFZz?=
 =?utf-8?B?aWZra053elNOdzkrdXJ4Z1lrQVlZUE5IaWtEcm1hQXhYaVpQSllRbFhMRkQ3?=
 =?utf-8?B?VlFCSU5WTzUvSE92Si94R2FwZkc5cFdCWUIzallEaWhFakxVNmt4LzAvWmZz?=
 =?utf-8?B?WEpqQTdWYytqeTcvbXpOVDQ5NDh6SERNejVuQzJWNUhEMzRienFpdTVGQVBW?=
 =?utf-8?B?Y2duK1k5MExmZHlpbUQvTnJQQTkwY1hDYW1OQ0VwMU13VzBoUW1kUENCd09j?=
 =?utf-8?B?MUE0VzdLa0dFcVRFdTgyTXdyYSswMkQ3U3ErNE1tVE1sZTFBeGhCRU9uVDVK?=
 =?utf-8?B?dTZQOTdyWmdNcjM0Z1JEbXRMUUYyRHhvdDJrMks0OEhxdVBCRmUyMktjVU56?=
 =?utf-8?B?SmJCd2hWc2c1dUpwOVk0MERsSTFMSUF4QTlkMUdLSlBtYTVYeFgyM2RZLzJW?=
 =?utf-8?B?dnh6TGNxYzRyK05nQ1JBTU1ES1E5aGpOVFV5TTY2R0ErOXBBT2ZtMHVPcFEr?=
 =?utf-8?B?WWJKeUozVGNrc0V1RGhiVkJZQjMra1V3eThUOUFFY0k4dFRDYkh2cnBXVDl6?=
 =?utf-8?B?SDc5TmJUZmQ1RDRTV0MwQyszRU11b1ZVaHRsRStXOWRPTk10WjFOVFVUUHEy?=
 =?utf-8?B?WnM3Ti9mOG9sajBJLy9kQkhkeXNwcnoyNVVWbFhqM25lcUFxK0NBbnFSMVJK?=
 =?utf-8?Q?IPTjZjlQ68KbF986Och5K680qMeaMyVV2AGmA+EQs6PF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A145C3632F880F49B1E0A0CA3B377E67@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df2b1515-7456-4ed0-75b4-08dc22b26727
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:14:40.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9T7YIh3NfwfEAEH9SVJcy3dgoLaFzqxV1Pc/TNlW6ucy1k3vEmU+K0Y0Nq1BW7KlbF8VJP6Tr54B3s2ureB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIG5ldyBx
dWV1ZV9saW1pdHNfe3N0YXJ0LGNvbW1pdH1fdXBkYXRlIHBhaXIgb2YgZnVuY3Rpb25zIHRoYXQN
Cj4gYWxsb3dzIHRha2luZyBhbiBhdG9taWMgc25hcHNob3Qgb2YgcXVldWUgbGltaXRzLCB1cGRh
dGUgaXQsIGFuZA0KPiBjb21taXQgaXQgaWYgaXQgcGFzc2VzIHZhbGlkaXR5IGNoZWNraW5nLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2
aWV3ZWQtYnk6IEpvaG4gR2FycnkgPGpvaG4uZy5nYXJyeUBvcmFjbGUuY29tPg0KPiBSZXZpZXdl
ZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K
