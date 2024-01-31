Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C313AA3C
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742722; cv=fail; b=Cy+3AqVFcNv1OcCFbw5buwJk7wD7EWTYGBYLxNyXO7Fsm31qRtkmqUqE2SIotSvOkqJWwiI3P7RKOQ59wUIdv2BIiOIkHCoWRz9dx+0Jn0qHUWszqLpzfRpmnDHO/0LDROHTTL+GFiuPs4tksQUp6fYBa57e9hWu1L2aJZw4m8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742722; c=relaxed/simple;
	bh=nLqdr9fGGq0E2i1gmvEICud3JEkatcSzU4vYb3RCOhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZX2WLjkL5n7niHATcI+UMtUykFEUTu8I3isydzJjgCSDwroCYq9reOWP7tofMbNkubBLDImDcX+EHTxHCdySQ/u5wSDVZS5+fDq4w8KEt6lnngoRx/sChCJLZ3mKOjRLjnB7VARljsc82NrvBH0QZBcSe2jpo3zb6q0pxUJJ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pTlHCRHq; arc=fail smtp.client-ip=40.107.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pTlHCRHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGiR0iEVBqpH1pFTNI0uuG4iq7nn8Mq1LT4sijPiPsXV7vZ3P36KB+BjmXNXvyS/AKYEEnCHcG6mrEHe7uGorrtg7Um7m1eOgOYh3IH1km+bMsEmSXPjHIdAtfis1JKCnAwjz3seDRPcTI04FzDl4QpGPwtfnYf5JnzoKVAUw+pK5+GtmjaZ0jWNOajH7AdZNN4WyjBAl7I+YfcL7Xew6hjvavreWSU2twJvw9K7NnxhwmCN72WWR96Gk4dJLrr6ChjMdByi+2jCEOpTrhWirHXMR0PZTNH/28GjBJ/t5j65AzxR72LxXpfZpd3rfEeYu/9KKkJfu0Ykt8so8MIqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLqdr9fGGq0E2i1gmvEICud3JEkatcSzU4vYb3RCOhk=;
 b=ZNTjxkGgOf5S6K9AXSqkh1MUc3Do7BwPUrMEO+uAIC8Niy+KPx7YSTcF3rmdZiy6qfMq0w/vK5EJdIlW015K344fu1npTxWj2VglfC8NlxgEjcm4QLoz/7XSFjFYrdxkGkYOWkiyAJaSVg8DIZ/EJY8kFwP/hepTxlTY5/8ItSF+Jon68vAvqq7wsMCgRvGDa+SiWVrXlBpr5Pn7eKUWGkKgpL7JBXEww/nCz+IW/VspZYJhbm4bsXoTkrDy7Pb/2nWY336Ra7m7Q6eMMkQfmNkJdtY9z73A+4+gqk+YYTbIjqz2WAg6Ay+oj71XT3lyTIsS3Dq3RqRfYN5Rxa8nPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLqdr9fGGq0E2i1gmvEICud3JEkatcSzU4vYb3RCOhk=;
 b=pTlHCRHqBLHBVFCdEGuNN26sisUXHFyPWMBoqZXa14Fh4oHAIxzL9J8pPOsLaeGmx+m2+OixwLIvmlar6V0gdyhX4qRwAOMFuEAUTvGl1WpYl2MudPtboa8Hq4AkZv/uFVvtTBC7dGvy1H02wZogwpsIz62Db0vmNU+EqzlUVvASsAS5ErPQWtRF94OfALyuP9sbHUcukfqjV5eZK2QDyKDNQlHe6ULANGFRycZMcZ5ZuecArhJArjRfGRUTdx04B+XXACnIjI8i8vhMQ0d0M96gU9L7oa+nCm15yL5WhT01XHNxrdatMBltJ5HD4CynypntWc6UNoGNqq0/jQ/7kw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 23:11:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:11:58 +0000
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
Subject: Re: [PATCH 02/14] block: refactor disk_update_readahead
Thread-Topic: [PATCH 02/14] block: refactor disk_update_readahead
Thread-Index: AQHaVEYEhrzaR0n/4kOv9KZyJG/l9LD0jTsA
Date: Wed, 31 Jan 2024 23:11:58 +0000
Message-ID: <e5e4f3a9-a3fc-4695-9a4d-d52e9b3664b8@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-3-hch@lst.de>
In-Reply-To: <20240131130400.625836-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: 8127e7d0-57ca-4655-9d4e-08dc22b20694
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 921a/Bpm6eg8l2BBUnybSAoYvgDOw+HUxHDibFeekkUbkyAL+AO5q+seKB+gkIS0NMv+mgoP09ckCV/CTod7cVPx9Fc4Xl2ZVgQwctoILb27rf5Ea+3oqcdE9fOMkXxHnSO2kIAr8W+YkTLDfeJfkXydahLjpS94Ln+jmFX+jA6i+O8MvWCWd5inHEtq5UZOvWAMRJgV1Xum48Efx+HQWYSGilfoaaBlttX4vXxQQ27k6vCEfXDj32e+AQg6F2n5QFOrF0eaNXEAkGKI6apV+2pcekJYTMn6EcD2bSIU2hYBQFHiFt7rTz6P+7m6nuuKwz+dKfQANqN6Tqui1Ps8NDQxLmxTfDCwYj9ETkALMnk2/si5rZxcGk6D1ZlkAk2ZKX7Eu1RQPPSuW3a6G2EMJ3UteTqLUwDJODfyvpPLeVVzX7ltH6OQS772bhBQI5ZPYkP51gh9JxYm4aLfxUi+hJj5iSR+xp7HtNDe9cBfKQrk7aruDrVKJtfmXRojaHhM1QhY88m4x5NeQPmSTJUhN4CD9/IvvqCL/7+BmgRJxrxuEOXjHTNyxr15jVb9LLnLbyC7xjvitYuJcdB2qgddgvycEakldK7R8H3NkWlZ+/WEyk2GaU3IETIqc1QWYhMi09ThK301GrTzuNiKK2+fEQ1+bcb6LMhAA8Qwebu9y48=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(8676002)(4326008)(64756008)(5660300002)(66556008)(7416002)(8936002)(478600001)(66446008)(6506007)(2906002)(6486002)(53546011)(76116006)(4744005)(316002)(54906003)(66946007)(71200400001)(66476007)(91956017)(110136005)(122000001)(38070700009)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUxTb0ZxT0xQcldHV2FxL2NXbVk4dzZPaUxaVzhjZzFiSUlnNkdIamN5ditB?=
 =?utf-8?B?eWxlUWY2OWh1Nk1JZUR5WFd5VlBRS3VZbnUrZm8zOUszZDBzaWR6emRWSGFP?=
 =?utf-8?B?ODhDZzh1MnpnRTBxT2EybS9IWEsrK0VlN0FwS0QrY21hOWNsUVJoT0RCeGpU?=
 =?utf-8?B?N00yeC85bG9xVW16OXVQamtZWUc3SEl2VVNLaFFqdnVTVHUzaERaSExNM21L?=
 =?utf-8?B?OEZodElwVnhLUmZtVGVhMGh2MzR0MUM0YnN6d245NXd5RjRBdXpDMzFlM0NW?=
 =?utf-8?B?MW5iMGh1VDZnRGdneUZqQmRXNnUzaXp6eTdpUVhUMGZxTW5ISW5hRGF3VzNz?=
 =?utf-8?B?ZSsyaVdkeWpMM09oRnN5MXJMcGRmeGthWU91YTBJZzFRWFliMzdTaUxuU1h0?=
 =?utf-8?B?cFd3bC9ua3lCZ2dxYUFKK20zeTRMdm1tN2tGbWZkeWNyUS9ubGRhRS9SeXdp?=
 =?utf-8?B?Qzk2U3hHR1pRNkN6R0FoTmlGeXdTNnNiYTJOSHByUzg2UFFLcklTY0VOeEVs?=
 =?utf-8?B?Mmg5SDltUzJsRGdvMVo2QU1kTmpqc0NpS2d0cGhSNUJUQU0ya21YaFZoZk02?=
 =?utf-8?B?K0JDdmtUNE5uNmxidWxlUFQxY3JLUmY1SE5SbkE5T0xmeGNBUlJyLzhXZEU2?=
 =?utf-8?B?WDlTSGdnYkxybitndlJzZ1U2NlM2WHcyQVNPMEJmOS9OTGVaczVpeE5GcmJ5?=
 =?utf-8?B?R3ZOSitncDMycDYySjd5U0ZkdVpLZEJ6UWxsb2x4dHd6QnFha0hrUndnQmEv?=
 =?utf-8?B?cHJ6b29yOFJKMGhmcWpHSzVkdmx0NUltNVVmVzMya2Eza1pPUjdvY2o1K3Vr?=
 =?utf-8?B?akxHSk95dnFXTmw2d1pUbCthUnlhWjNscXV3ZG9pbEVlL1c3MjN2d1ZkeGFE?=
 =?utf-8?B?WWVkc1NxLzdQQUFJem9MNzVWNmdIaXo3WEFFMVNhV0RZcFpFRDNRaWxMTWNs?=
 =?utf-8?B?eXkwb3g0OC9ITGNoT1JuR0FuaW9COHpGT0hOaWtjcWtObXZ4M0F2K0k5TkVz?=
 =?utf-8?B?VWNsU1dpMGJUdC9PaTlhNW9CbVFQaGRTYVJLb1NJVkNsaFBhNUQvcGRTclpx?=
 =?utf-8?B?TXhqOUZsNEQ5cEFjMmY3STM3ei91aFc4UTlVU0ZSbnhvZHdyZVlYV2twaGVM?=
 =?utf-8?B?N09ZSzlubWJCamF3elJ0T2N5Z2hublkxQjV3SlNGNVZaYklYV3BXbjlCMVdp?=
 =?utf-8?B?NlJyVDVjL1B0WlAxQjVNRlJQV3d3Ti9TZk1Vckd5VjRZczVXdWF4N0pISUx6?=
 =?utf-8?B?Y2NsMUJhRzFHRXlFSG5NVU9Xc3E1NnNSOWlnMVpjOHhmMm9xL3hRUmpSMUlI?=
 =?utf-8?B?NUpwT0tZbktTOFVocFg1b0tSemRjV3dQYVk2aGdyMzBOQW12b1FRa0tLYkY1?=
 =?utf-8?B?ci9FRHYvbEh5YytzRlBxUzhkQW9vdEprUEtzSDFYMWhQNzl5c0hFYkJKSFly?=
 =?utf-8?B?YWo0V08vcnlEMVZYc1V2UVFEd3ZscTBPckI3VzdvMllGMHVIT2NWWHk5bWxH?=
 =?utf-8?B?clkreHQ2RkcrTC9LUkg5NlY4VEpQNXpTTXFORkFvVXhURXQ4TWNPNWZmWWhn?=
 =?utf-8?B?ckV4bmJrR1ZJQUFaYVI0VGV2S3ZVdTF0ZUFucXZqWS9PdDdOak1OMDJJNWFU?=
 =?utf-8?B?dWZsbTh6UFUxd2tYK3JBMDZ2MGpEc0UwRE9lRkxBdWhrT2Y5MTlVM0crL3Fv?=
 =?utf-8?B?ejgveFB4OTdVSEs4c3FDWnpleWYvSjc3SmlJUnJ5QUFyNC9QUktBT1JDVng4?=
 =?utf-8?B?SnZZMjVadjdWMDhqcG1yMFV5VnMzbWdMclV1aVdwdnV3UGkrK1FwbGg3SDJQ?=
 =?utf-8?B?MnlpK1BDL0d0WVVkeW5SM0t0b1VMZkIvM3NkWGNhNkxVenRmWnh2WEUwMmpo?=
 =?utf-8?B?TGIxVXcrZitOWlVSZ0pIMnBHZ3Q0dWZmclhVZDVQV0dwb1h0MzE4Y3FFNWpy?=
 =?utf-8?B?Sm00M1N4S05aUWV4aXA0Vis3RERTWVMxMW02Y2l5dXlvK1RaY2RIWXdFbC84?=
 =?utf-8?B?R3phYUtvQUhtWnZsNVBnc2k1L21NRUpKR2VqclNyeU93Sm5UREJaNXdhV1oz?=
 =?utf-8?B?Uis1dkdKSVd1MUJUWll0QVlxRDZ5NW1hMFdoOTVpOVRYc3VLMTN0akdlZ3pD?=
 =?utf-8?B?a044S01EcjVNbHdqaDE2UGIxR3BhVVp5NTVWdElCMS9UVTZFZVFPY0N6SDhz?=
 =?utf-8?Q?96lEGETka9aKK5DPS33VcF1beVORmWCwaTdMjsgRwUBF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <031AE86027394144A348B8E6E6F96551@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8127e7d0-57ca-4655-9d4e-08dc22b20694
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:11:58.9354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qsg0svCXHcG0LqVAWxwlwVmaZo3uiisPcmpCI4NNmqyiuYCm75X2yGn2ZVtoRuXHcFZ4rpyulwrMWQdVAe5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

T24gMS8zMS8yNCAwNTowMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZhY3RvciBvdXQg
YSBibGtfYXBwbHlfYmRpX2xpbWl0cyBsaW1pdHMgaGVscGVyIHRoYXQgY2FuIGJlIHVzZWQgd2l0
aA0KPiBhbiBleHBsaWNpdCBxdWV1ZV9saW1pdHMgYXJndW1lbnQsIHdoaWNoIHdpbGwgYmUgdXNl
ZnVsIGxhdGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4gUmV2aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+
DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQo+
ICAgDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtj
aEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
