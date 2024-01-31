Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0103A1CC
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743731; cv=fail; b=UuBSpKwxKzQL4sunK2F3z86VdN1QjBIcgAvRgZTX0S6zG5luLTP2gV3LXJYlup9HZ5gTwZsn1mHbk5omPKDK0qU5yd1pFmrq8TGDINAeBYaw/gHLZXkBOsFVziNBX013puIuEh55sncpHRBSJZni7mVBQm+HbqgowFHXbMDad9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743731; c=relaxed/simple;
	bh=62UMUuHW093EV7mRWH9c5oxrO3uY28Gx7aDyLOKYHkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQjc1TYbfr9EMDIiZsqW4F/2bWiiocjzymhFpMfsO52yEW+xrgFgmRNZhCrKz4cOR2aGRhBl6i1tTDwr1iTgdYulKFT1ZNQe0oYpSEOFrpBcq6kQzPk3s2hqZXKOk7kyQf1nqAEB+mdsjd53/D1Cg9SAGD+8xay+/I3rP5WKxv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qaRWOQl3; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qaRWOQl3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4zCkkIIo3ZEIFGd0CJguHI0IjnWBZftG4cGyGASUQNr8Xx3cHqzwWa390gVNSMXv2RO2kouQ1LNPLd6pdo95WAz+ceCyK8vgRcJntUkOwcm8qtDyl+3H4vmIqJtFsY8k0ok+me2dp070zoEDaIGCxkIyFsuPDtC5xEPkHkt+wQjC3fvWPXnCmkNE9q0TNR/jhpHOcd0dbCPEI0VjNvR2GsidsoJ8GituZy0vWGiO8ZugbT0MZlHQvfstMJO33ruQarYx44b4FzIsgwUB8w8Q1yKtiUFCoI8w7TLbFZpoGFFRArNwz5J0GWkxpVQ3z1ScHw8wNi3XiJxyJ6e3oTlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62UMUuHW093EV7mRWH9c5oxrO3uY28Gx7aDyLOKYHkw=;
 b=TevSz7nwzvAV3jx4osZJbuyCLGmfLeP61uQQsjB1FEB63eP2P16JRpJAB7sa7Sj3DcLFgJiqy7+1YLl5SkkkkQ8VonreQ3EelyRW44rp/lqQPguwHQxpQrArdZMfG/AS5b36JkK4I/m5ebij7yIorZflWNFA91HBQhaGceeCALNsrVxN8ugnWmjZr3zb8b30dBUZjR0jyxX2F8KOzp4DFkEqDeFs8ol2BGRaczyY1tQeTdo6PtwVglr9xE/tUNIKXsA8GtzKhEBoTSRHRWTTCrSxu0QueKxOF1QG5j2C6dUsXuOP3ocrzIokMXM1Nc8kS0z+IpWxF6pfczR3DqkXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62UMUuHW093EV7mRWH9c5oxrO3uY28Gx7aDyLOKYHkw=;
 b=qaRWOQl3SkLmdVvT2z0PwWolOh5PmfV1HvGFbqgl85y0RgJS7ni7fveM74LD0RbBu1dOoclWE5HAsSL3qBcKolGmhG8A486opo/dXEnQa1oj1xt6khsFprLeCMH93z4AtZSc2wuCSuUlkFsTQVA337uFbdsUmMzgLwnXzC6xqiySq5ozmSFWxgw422lD29z0nmfB2U5G9XZpc/Rr1aIinylRXDhPT+clIt9APA4XmFGVZiR7FM2xXlTzYwUnGGb2L7NDSenl6wUQAc5d/s8H2GQrZavwbr0gJEqeZxL5XdShfQNOul8JQPpHnTQHIs2TmE8XOg1hboq043O3vOoIfg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 23:28:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:28:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Thread-Topic: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Thread-Index: AQHaVEYOvDe/Lizqsk2NVSOR6MzFRbD0kewA
Date: Wed, 31 Jan 2024 23:28:47 +0000
Message-ID: <3949f7d5-815f-492c-bbbf-2de271806f3e@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-6-hch@lst.de>
In-Reply-To: <20240131130400.625836-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB6317:EE_
x-ms-office365-filtering-correlation-id: 33c427b2-e6bf-4da6-dd1d-08dc22b45f73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M+ZetesR3z8afTZEJs3PGRHYargayKjROiRVqr+Ftx819NACJmyitNbV+XRj8StXWgullyiXJR1A1jtJEo2NeL9i6TZsfbpqD1HZTAHzTkHTRcjJXlgJIIZdohuWlNIdHH33gBAagbhQcxmxO36cEStW3HHSWsZNk+7ugIlWx7ysrgzpAraCcV+iT7C6b/wrD7Z3OvWjOTvlbYgAWNA3oReDKq3vCB6kG4WbUXeGrGitWEjKWsXZsrZjP5HRWPz9FvBF4tWytkAezlTOVCTeAQbF8avd5LeIObCzehFIW9LQa2gTorzbP7ZiHOeINgncjPcrTfiSnnzZHMybdh4xW3s6TMwz/XyUrVBLjVG0bFkhWI8PHsM7dSNEuxq+oITer7/F2n6l18tZoj8D5ZrhVgHSsHKf2c5PyH/D61uHXM2xBJC9LWGUOOXIzoqGv4mZ94XOIYY5XhaBOv6NBfSKLrIb8B4upvS1DzxsOmY3FtqJIBnhjJ9m7yqg4kAYVOZWHigFO84ZnvqMUFIqghgx98dVHe7Gmk/aZZosPzhxj5xGS2X391VWvQbswqAwG9l4DfVtHCi1enzNBb8Ojwgu62Scd/eYMQRdvodBw7wqvNgSV4gH0fgR9Zgh4xh3lbCQgM/50LwFmQwa1z5XEznXjcZLIb7pNaDQ1ROzKQ+ykpHkAqTY5JbkES84fm9NSwt3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(2616005)(31686004)(316002)(38070700009)(71200400001)(478600001)(53546011)(6486002)(6512007)(83380400001)(38100700002)(6506007)(122000001)(64756008)(54906003)(5660300002)(36756003)(7416002)(86362001)(91956017)(110136005)(4744005)(31696002)(76116006)(66476007)(66556008)(66946007)(66446008)(4326008)(2906002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0U4YThHWEFsZE9LTmpwU05MYjJoRWEzNFltQTV4TFNSY25Nd0xlalNJZTVO?=
 =?utf-8?B?ODYxQjNZOWY1YllDV2xBdEE0eVRRM0Jja2RGWW90UU1XR083cmF4NlBsYWVX?=
 =?utf-8?B?RkZlTVNtYWdnSTRzUm9nM1RYcnRPM3U3UjIvZ2pwVTFyY2NPdVhlVHpLa1Zu?=
 =?utf-8?B?V2o0dnZTN1dBTUFrem11Mkh1L1VyU0FrUVpIamVER3A1NjludFRvWFkxdncw?=
 =?utf-8?B?ejBNVWk1elAwT3d1WlMyVUVDUVByUUNGQmZyMGh3eEcraGlNbnpIdzhPT0dW?=
 =?utf-8?B?KzlDQ2FFVnN5L2ZXaUJCMXRoTDF5U1hvaS9MaVF0OGU1eGFTRXhyTXgrUGlV?=
 =?utf-8?B?ZER1QzQ5QzJ2Vk5WajlFUDdXWTQ2b2U0YlpobzA4VHJIY1ZzdzVaMXZHYmpP?=
 =?utf-8?B?dzdDSVZUTGNZUjBXVVlHcE9UVisyY2QwNlpoUFhjMGVoZlh0TGV5UXpybkpH?=
 =?utf-8?B?bnBFaFpxME90cWVabWh4R2M3L1VqRGphdWhRQTZLZDhxcjF1Wkh4cnZyVG0v?=
 =?utf-8?B?cllUWTFNQyt3Y3pZaDZnN21IZENwbytCYnhnUEZJLzg4RVNIVzl5WEx2aWJB?=
 =?utf-8?B?cStiTjZnM0ZwcmV1NlNzY3dWR3U5QkhSS3JoejJFZllXdkh2bU9oZUNKUEpE?=
 =?utf-8?B?eDkxZ3JGYm9JYy9yWldGU1ZHQXpjSitoY1ZWOVhHWTlSNjhPQlFwSVh4ZHN3?=
 =?utf-8?B?Z25aeUlLajdxV2ZtTWI5TVQxWXpndGN4a2Irbm5MRkpZeHo5cjF4bFBmc2tM?=
 =?utf-8?B?ejcvbDhXblIyM2ZoQkpwc2s2WkpLUC8wMnRsc3BNM2xFb1JGcWVGQVJ4alVQ?=
 =?utf-8?B?ejM0dms3dUV5aXp3bnQ3MFlPTk1jSk1PK0lSbFRNTVREQ29nRm5rU2NMNUlj?=
 =?utf-8?B?RGo3MmtLditWTjc3YUZrUWZ6WExUUDVMcWREd2tDTzlvVGJnalFiL2RCOUFk?=
 =?utf-8?B?dTlUTTVDQ3cvR3oxUU00SGpOU2xZV0M2VjlVYjVUc09SU0xoNjhkQVFXcnNK?=
 =?utf-8?B?ZDJUZ1l0WVprMG1nSXZmT1pQU2dHWCtXZGlpLytSb0dsemd5VmRJejRFQUN4?=
 =?utf-8?B?YUNUbENFcisrYjdHaUNnVGt3WFg0d05aZ3YvdHVIK0RZR1BmSUJNTnJOUHpT?=
 =?utf-8?B?K1NSNU9tTG1SQXI1ZTJYdDFZSUdna21ORVJVbjNvejRBUkhqU3dEQzFiN0pq?=
 =?utf-8?B?VUpkdTJnY1ZIaWVSNy80RjBVL3JWcnNkWjRDdzVleG5LYzBQTmNxdWJHS0Ni?=
 =?utf-8?B?eGkvbkpIcGhML0w3eERNYUoyeGMzK1dxRlIvV0JrYnoxWkViaWVyTGM4emhv?=
 =?utf-8?B?VEZ0TDZpVXdXZ05VZXlkcmt4T05WRUhzNk84eHdkUG5WSGM2RjBZc01QdERw?=
 =?utf-8?B?MXlRcTVsZHpseVVmV05JbVFqa2ZVU0VQbkFTYUZyaHJXeFl4YnhDRTlkcjMx?=
 =?utf-8?B?dG1RMUxEYmNSN2M4R0Q5aTVsSlFWL2lLTXkrOW1vYjgxT2tlUTRBdEpXdmNk?=
 =?utf-8?B?UGd6Z2tUaGJHZ2hJTFhZQjZ1NUFBZmVQMzNYcVVXL283Rnd4cXpicTV0WGhz?=
 =?utf-8?B?VjhNMENVZ09DU2tsSEhEZlYySEhwTDNmVkYwZm94OG5xWWkyb2dKRDNxNDlT?=
 =?utf-8?B?VjEzSFZ4MENMRkkvU2V3blJ0YzVjR0RYb3ZOcE04OE1FOWsyZDd6clhBNjVI?=
 =?utf-8?B?VGJLaWRITCtxbDdMTzdMcFdWNnlCZUZQT01PTCtoV1dKdTM1MXdxQkpsaEhs?=
 =?utf-8?B?aG5BOHBpNUNaN1BQOWJiR2ppUzRUeFFPZWZ4eFRVcTNKdFF6dGNRTk5JYTZi?=
 =?utf-8?B?YTlVaXUwS2VRcUJwbWVZUHNDWHB3LzY2Qm9zZlJPcjU1SFdlelgyNlhrekVM?=
 =?utf-8?B?TVVJTnBaZ0duWXgvdXU1M2l3TkY3V09LOTg0Tk1kWTdXdy9nMDdTUVIyY0hM?=
 =?utf-8?B?LzhzdEhwNHM1RytJZE9CU2ZzdHczMko2c2lhUEhzNzh5MjI3cUJqRFN4NVFh?=
 =?utf-8?B?WGltQlZrUjMzRTFSVWpPRWVza3NhbFlBQ29TUFNVYTVJWjU3NWZKa2RKWUNL?=
 =?utf-8?B?TStnNGFKczZuVnFiK0NIajA1c0JxZG5kaTBTMVl4VVR3bkJUclFvMi9YcE9s?=
 =?utf-8?B?d0tDZUZTek40Z0swS1ZiQUxXL0VkL201cVhkTkRQN3lRaXgvdGZGS2I3eUl0?=
 =?utf-8?Q?HH3R7/oTvdiiz7jxyD91E0gVOZx2B4V+TjTJ10Y2jSk+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A255E5AE8C2F66499ECED6D9661B40F7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c427b2-e6bf-4da6-dd1d-08dc22b45f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:28:47.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzitvqqfIaPZbAYJ5CoD6FmyTZtlyb/nXB/QDbyS8aaTL7z9bdHpmXHi0VxZSQYIT3ODPH+kaPhScxEkW2WiNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFkZCBhIG5ldyBt
YXhfdXNlcl9kaXNjYXJkX3NlY3RvcnMgbGltaXQgdGhhdCBtaXJyb3JzIG1heF91c2VyX3NlY3Rv
cnMNCj4gYW5kIHN0b3JlcyB0aGUgdmFsdWUgdGhhdCB0aGUgdXNlciBtYW51YWxseSBzZXQuICBU
aGlzIG5vdyBhbGxvd3MNCj4gdXBkYXRlcyBvZiB0aGUgbWF4X2h3X2Rpc2NhcmRfc2VjdG9ycyB0
byBub3Qgd29ycnkgYWJvdXQgdGhlIHVzZXINCj4gbGltaXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
