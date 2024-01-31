Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19043CF60
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743098; cv=fail; b=f+36wowxIcMqUDflnosLQJ+mmN2Z09p60+yJB5672l4qeBD5wMRNtPpw4Enlb/5Ym26mLQlHE9J2TIhqgV9qu9aJnpcEpSfq7w452tTXxJCQOi1AGKB0lU2QziAUTuXnfDlhwrN7ZYMO0y6QhSauK6DiXhuN4PCrycEtYA+gx/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743098; c=relaxed/simple;
	bh=eQrNDzUjBAcf5IyEiqOSINFMJaLpiSVqYADvZW/5en4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rljuByM4mq+CgKbFqiU4Ke5Gv9ITHSURGwmhLkZySWuxUSJj6Gg0I4NOKXrJejQGgxd7JqiONlnkkHVCZ1FWKdGX9ghY1iuHKZoMKXHHHLoV+DTxMFU4HTCJ37RBZxgqYY8JYrGCFj96IOz+Vv2OpvFzlgbEriKFkqEALXFbAwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sizwxTZt; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sizwxTZt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmfDQeryYyyWdnfUjZn6SYTUoSK3wKfB4StXigQznAhfG88KEdg8insg4tBnk7P5PRCXLohWhnoizwAOzRaUAFyF1LzIqVo1Uc6luziSCweBbAvczym4QYjwo4GPjTnPd7cnm6q6WED/HiglIo4V/b6sPllDrFzGyGksnlTYZH7NM513++vibJZ3GyQLWoVYqBOFe71+R26wxytMEmqBUqW9kBi3bCQhrq/47FnEftEN1es+dc/iFcat/t+2h5mVREZsADzbHhIQuH53W6VEDQqCtn9xpD6++BoVRuEzBh1mk233vzNzFeTkMit3I36MVpEKbN8mmX+LtlwFlcLSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQrNDzUjBAcf5IyEiqOSINFMJaLpiSVqYADvZW/5en4=;
 b=BY1NiOlfNPdB/HSmFAW4V25uJnGE5s0sfGfGvepelxNVo9UcT7vWqLku63O6/pQ0MhuZ8UgnllnBsEznlJYouaZboircqGQww1mz7kULA1yFUXsFZglZ2HAwsgoKX3wpzaXpljNGbrnjqGg7sV6F8bapAGae1WurzlZBxkon74fX+03ECAkDDsMHeOmWuyHsIBlhjKR+e2JtdUTKA3fIx/nsODbK0SkR3XGoE4+sdbSazIpxaunkssxG0cAQMncU+ln+NsKQ50SqJLFxKC01miUQhFEel4qOjyLRDiegRzviW0d6hOrV9SBwHSN97nBWL+d8LpGo9GBZ1spukbpIyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQrNDzUjBAcf5IyEiqOSINFMJaLpiSVqYADvZW/5en4=;
 b=sizwxTZtYNmsN82DoHomy2XVli+XTOGmFb8lX2bmU1OPkt/QrFUPX9o7+poTGcfChliQus4v9q9Up9eas74i3YZl7uHdmUKllW29+aU505OeP7oMQiLV2IVP782xNKTVXzVe6zWNcjAkIs/3KATWxC3/xNZ4PRqF+EoBBM9/VzKF6EVmXWikz8j5pUqJADGLUc0meB3noe+cxSi4o6SaxN8tcEVAVqorUcr3kqvhiprmRgA1Hwg18RETgLjyr8njlvpm/QUJ2PMLtHpSum6NHPBIrcYp6E1MLLjVZGcjl4LiiYPGizqvwKdreK1CBcQ5rnDK0xpYW3zwwnyh+nIG2Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:18:14 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:18:14 +0000
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
Subject: Re: [PATCH 04/14] block: use queue_limits_commit_update in
 queue_max_sectors_store
Thread-Topic: [PATCH 04/14] block: use queue_limits_commit_update in
 queue_max_sectors_store
Thread-Index: AQHaVEYNzWee7hOiPk2uAMlwFhsDMrD0jvqA
Date: Wed, 31 Jan 2024 23:18:14 +0000
Message-ID: <e7c2bd4a-6453-4190-bf82-2c31d30cc40d@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-5-hch@lst.de>
In-Reply-To: <20240131130400.625836-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB6797:EE_
x-ms-office365-filtering-correlation-id: a88ac028-8300-42c3-d4cf-08dc22b2e626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Yz2NVFYSxN6Vif6ynVHRemjmKjAxCGVb/Hu3FkYzWO6lQx+sXXQmrZdIKEFAqRG0X5a/+sBeBJ3yRWna0eKvstsjrMJ/7LjawPlSfCQrd5FYfP/T83CEFz9WtSMJAeo8vRFsFbd9iPWlB+K4ZlVHTKMlGI+u3YqcfFVYiD41hZ1BT18AYB9n4GbfLpfQzEz8v3wHWM2+eBd/A3vl6A68CHOwHRIgs5iHV9iqmAT8c8wczd2OJwyO4H+rKI2jVPL/qBKDn1FVy9+Uq+ht8TnbgSsvcUP5jvS8HObaYbYN0FXANgHgWrgKEe+SdAP80cbefrjZblVKFD7W9Nworv5fC9xI3/XYDfHaBpUb0Zg0P+fZxpaJoKhP6GRwxZdPL5NKg58RZ6+qroUeegEvljLvZuYkJmFbk8Whcs1W5VzdjONUw7Xo5Ibvz2vTk1y63g5Hdu9iHra3fBcfNkqkRhXR2ji9OAlR75L2HnJQkUOGQw0zhXcLsndvVMhlXI8Fjb0VM5M4QEBEKBCJYuG9eyfeoWhrJrwjvLJlcs7LaSll+A1JuONmv/4lGQOiFeu4s8V/aPk1xChlnSQyk5aNW9nlECQ0HEf9Ekix1RhIXfEj6SSBMt3gWSHlZwIKcZLZhSwzqAl3PHyruD9aV83bqH2qItTQtG2xPOetVmzz6qvXcwiMM3kaKtadAGQhvKnbQf2V
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(2616005)(6512007)(38100700002)(122000001)(76116006)(8676002)(4326008)(4744005)(5660300002)(8936002)(7416002)(66946007)(64756008)(66556008)(2906002)(6486002)(53546011)(6506007)(316002)(478600001)(66446008)(71200400001)(54906003)(66476007)(110136005)(91956017)(38070700009)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXRZREg1WVpkd1UvQ3hwcjA1dEQwYjFsVFpZNEdqSEd4MExnbXZCMFJCWGh2?=
 =?utf-8?B?ZzRSKzdPeG9KNmJ6Q1A4enQzRHAzODYzay9maUlaUDFXR0hsVFExa1ZDU3Ev?=
 =?utf-8?B?b2twVmJpVmkxM3lYN2Rpdm5OMVNIZ0NWV2xnZmpJUG1pRE5LTERXQnJYeWF4?=
 =?utf-8?B?Z1h3TnFkRFQyb3FUR2tGOE1RYW12RkVPajNHWXNKQjJjZExFaFV1UkxuMmpC?=
 =?utf-8?B?NnU3M2pNZ0hxbDJNQjRJSnhIdVJxcjhwZ1dSYzYxNkdUdjVzSVpsRWFzQTBG?=
 =?utf-8?B?Sm5YdllXaG1LVmhLSFMzODhkc0xQWi90TDhKa2RCdStrZkI0RkkyM2c1d1JP?=
 =?utf-8?B?Qm81YXlGandreWE3aHMzc1RmSFpRa05zQ21zSFJWVHlZNWdlZThsa3BnbWJL?=
 =?utf-8?B?R0djYmxoczg0alJhc0poYXRDZUQyQlo1cnlZaTlkRk1uU3YrK1o2OXVhZGhl?=
 =?utf-8?B?SEVDQ1g2dDNLTzJpRE5URG83bkRPckQ4TnZzL3FMb0JYSk5TK1RhZ0pPaEwz?=
 =?utf-8?B?WWRpMHpsSXNaNEljdmFkZWIrUUY2MTJ4dWl3bkFQV0MzYXR0V3NwSExrSUxt?=
 =?utf-8?B?bEZJWFFDQTIzQkFTdERtQVlURmdtdXdwclRDM0t1aGlxSnR6Z1MraHhFN1o3?=
 =?utf-8?B?cDNlY2pSKzBWTlV3WDRzRzJQTXVNa3M0ZURGcXFTTlZVWU9lSHlaQjNGTE9l?=
 =?utf-8?B?SGtndHBxeDk5aXR0TkZuek9JR1lJQ1JTMXpOd0JIYkhKYWk1OTNXcm5YdGJk?=
 =?utf-8?B?UTZ5dWpjRzQzdDZXUC9oY0lZRjhKT2VxV05WK2RKek11d0toZWFpQnNYQXk3?=
 =?utf-8?B?Q2VmOFFPbFNhOEpEYmlOVWExVUNDcXZhMFlJeUVTdHVianJoQVRQUE9NR0dF?=
 =?utf-8?B?V05kT013UGJSSFVLTWZrdURkcGJuR3V3TUJ2TThpK0t6bEtXU1loRzVMZTZh?=
 =?utf-8?B?OFlvSktoVmFsS1JHMEFwNHRwQ1hYWUVFMHNyMEF4dmZwdzFhU3ozSXV0eFQ5?=
 =?utf-8?B?TWpyVDd2cFNwektCSER3Wk1yWW9JREpvYVlyZTFtS0JjdG4vbG5iZnE4S1ly?=
 =?utf-8?B?eHhlQWcyOEhLQzFFUVJ0QnQzSTJ4aXMxTlpBUjJDSnJPczhOR3BvT1dnbFVv?=
 =?utf-8?B?YVdJcVFabDhPWkpxQk92ZWNaMzFzL0FEazh2em01UGlGbTVKaURKVy9YNERB?=
 =?utf-8?B?RUN1UERHMDV0WEIrME1DTG16WkJ3SmhrdjYzVzlOUnlBaU1qaEtGSEZaT1lH?=
 =?utf-8?B?UzJKWWRWaGVuc0VWTSsyNEljVndJUGRlcytxcDBWUWY3a1RJenNhNTJVUFJX?=
 =?utf-8?B?Y0xtaDlDYjZTV2pBMWZtZjA2dTRHcWY2RWczeFEwd0puWDhFa3lsRXJycnUz?=
 =?utf-8?B?em05T1RneDI1QUpMSW9JYlowMTE2QjNtL2NHWHMzR1hoMUZveGgrK3JRSHpP?=
 =?utf-8?B?a0h3NGI2Z0R3blhjcURhdG5yaEJkMlljNDFTTDRROVlDbFNEdzE4N0tBeWdo?=
 =?utf-8?B?TVlNQ2hMeHUxYXFuZVg0VXJuMGhxVFcrWG5UK3hCandyZFBtQTdpNjM2MFV6?=
 =?utf-8?B?azNpU2pRbnA0QkUxOTF5YW1tb0dVRUkrT3BGVVkxRG9tQ3pPL01YemVJUFQz?=
 =?utf-8?B?Y1JITnJHZ0dGVFZUZ0hCcFg0ZFRuRjI1Yis5OFJSa0JhREhBbHJvSDZQUEdr?=
 =?utf-8?B?RFI4Rk95djNyVDExa29HbkE4bjV1UE9KcTVJaG4relhzbzdPbEprZ3NDRG5R?=
 =?utf-8?B?a0pKTStSVk9TZDRia3FteWhCTFdsOVE3YkRlQ1RsTEVKeFJQZ0lRVGRtL1FN?=
 =?utf-8?B?dktSazlyRGIvTThYMmhha2xtek42aVcxUFNsZjh0K1kzaTdiSUVhd1lhQ3Vx?=
 =?utf-8?B?bHhvN05jMnRwOHJIVGcvdEJTZURSd05GcEpndTdkSUY3VWdZTGdKbi8ydTVz?=
 =?utf-8?B?bW9Kd3J2WHRJVGErRHArZFFQbkJtd25mVkxrb0NiNkd1bGRtcXRHZjBHd2tT?=
 =?utf-8?B?QVYzdk9uWXFIS1lnQmtYbDRVN09LaWZBSHVTYm5GSFBNMDBCZWxSZXkvbHpm?=
 =?utf-8?B?aXYzRTRhMmJ0d1duRTBmcXVYU1ZORkdIRFhseEJXbWtqRDN3Ykh0d1Z6bjZR?=
 =?utf-8?B?cUR0MGhDa2ZCclVRdmZiTk16UnJ6NmdjY3E1cWZyeXY2bkpiVFZpTU9ZZHlm?=
 =?utf-8?Q?h92ii42/pR7x7xCx6BMMc3YMAPpCmRC4r0ZQsPEG/eaA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3325B81275ADF24A848D2CDEE4F90570@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a88ac028-8300-42c3-d4cf-08dc22b2e626
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:18:14.0398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6d0SDsmlHAf8bTTTLjHL7rBoJyj7OEFGnVRTb33NVXmw6mUjK1ZCbUgTIHGrrhIoHDfoFutYtlFq18sKpUMrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IENvbnZlcnQgcXVl
dWVfbWF4X3NlY3RvcnNfc3RvcmUgdG8gdXNlIHF1ZXVlX2xpbWl0c19jb21taXRfdXBkYXRlIHRv
DQo+IGNoZWNrIGFuZCB1cGRhdGUgdGhlIG1heF9zZWN0b3JzIGxpbWl0IGFuZCBmcmVlemUgdGhl
IHF1ZXVlIGJlZm9yZQ0KPiBkb2luZyBzbyB0byBlbnN1cmUgd2UgZG9uJ3QgaGF2ZSByZXF1ZXN0
cyBpbiBmbGlnaHQgd2hpbGUgY2hhbmdpbmcNCj4gdGhlIGxpbWl0cy4NCj4NCj4gTm90ZSB0aGF0
IHRoaXMgcmVtb3ZlcyB0aGUgcHJldmlvdXNseSBoZWxkIHF1ZXVlX2xvY2sgdGhhdCBkb2Vzbid0
DQo+IHByb3RlY3QgYWdhaW5zdCBhbnkgb3RoZXIgcmVhZGVyIG9yIHdyaXRlci4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5
OiBKb2huIEdhcnJ5IDxqb2huLmcuZ2FycnlAb3JhY2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERh
bWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMg
UmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQo+ICAgYmxvY2svYmxrLXN5c2ZzLmMgfCAz
NyArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+DQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=
