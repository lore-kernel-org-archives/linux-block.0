Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACA3FB19
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744325; cv=fail; b=Iy4RMxaypEfS1bo+QDHsuT1Z2OOBCnWvad71AZY4Bjlrf0mn1vhr1nic/wTHewmUK4p5NInd60ax2qOnnbE4ErV4GweG263Acfe1NzLWAsnVLcjkpNpYcWUpaBv4qV4ydEIGKP2jd7v/6FWt6cA3VobMPyx//gCEgVBwmm3DYSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744325; c=relaxed/simple;
	bh=+GsqsiBt9RvT43Z+hLJEsiGDmFdRfvi0zm/kWftjHCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzKsJMjxsMcwgveL2a06GTQHtdiXsV9LtRSezJ9XLrZelpaEh0mPiNpCP47tA9iij+gd2eHzOnoGoPZ6FhQHzSCa0aq/NGxeGxm6yl7D6N4tGTiFaj5BHgz8Ia1C1aHmJW1i10ht9g8LeBT7uikipaaRiVN5DA1zZl9DTrOpI/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfAE6AU+; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfAE6AU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Alefky75rKh6f5FVylYlWBnRztMzTE8F35TOEN4Q8cH+s/3dCLjiCjeHAlIKaAG/+hDFpBGKNnu0+Va74mrIQd/lJO5jLQ3m/M1QeWIpr11jVa7xGTXXBwjBqkB0R44LdTDyARAOXyN15LwhpPq4PlEQLGYLiphgn7/Ib0O2cTaGY6Ba2JX/A1KTyfOJQyeGrewN5IBDP67ACV64Z5SmRE2XG9VbuX8ozv9dNembP+czfLXd117S+8z1gYZPXIThJokXugPXjqOYhqw8/emfP0syBR01LitC1Jo3yW7LCMI+cT0sMA16eG+9Z//ESWuojpgub5IBLDlm8J9WkkADwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GsqsiBt9RvT43Z+hLJEsiGDmFdRfvi0zm/kWftjHCw=;
 b=GUFMvnbnjQtBFMglkart0tV/s2sKy5zm+5BbxjAeaiYvaaS90Ealewt8YsACXxTI8nz4k/FAmFQZb+C5nhn/W0k70kKuR8xvF9ZO8YejWDqVnud6aMV8pXQLuwegqaYs9/Xhu4afRMqjIfpWRdf/AIZPOXeZ7ux3FcyhXHpzP+R0YkMDZuSPUER05L83Bm7XpKAJK6BZtO2Akqj4jqUxg0+NsHE84V3xRfN15EF+4lkIc/k2KBwifDMmWDr20rKaSDkoYmnVjwpE+ESxbTBrxDSkRb9C9BDi1dWrk5zsSFeDd6nLs2B8+L1MbnwTiT3FtcJsnhGGOMxROMOmDLuNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GsqsiBt9RvT43Z+hLJEsiGDmFdRfvi0zm/kWftjHCw=;
 b=MfAE6AU+oJcx4t3uhNa/Mxrlie56g7DtXYoYfUH7SPX7anXl5y7HAg8lJg8vg4SIUvM/RIy0Vjgok2gqcgPwDAVZeUbDycr1ChRJo10LYdC9Bt6gZg4UbJgE3+db78zxG4+2uTGHLIW9Wt8RENCYOYbpBBHGK70q8MsaIWZySQRph421PS7ccyAz+l+6Eb1kYTYn0U3XeyD7ZVs1Cn5rb8ALxsRgMbSLjXxc3pzAGazWBD92+PXyLTyyFkhTqF6HDmlxxZ3Jse35vfutO0WaGABoeQVCr86YRxCMseGvldw8nvJqrE/kF9xycrQGQe3P+aqZqH8ynxYWT/8ie7y3vg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 23:38:41 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 23:38:41 +0000
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
Subject: Re: [PATCH 14/14] loop: use the atomic queue limits update API
Thread-Topic: [PATCH 14/14] loop: use the atomic queue limits update API
Thread-Index: AQHaVEYrAI8cpNnJK06kSoFiQ4YAQbD0lLGA
Date: Wed, 31 Jan 2024 23:38:41 +0000
Message-ID: <b5fc1ee9-4c4e-4937-b2fd-b55f96a1b2a8@nvidia.com>
References: <20240131130400.625836-1-hch@lst.de>
 <20240131130400.625836-15-hch@lst.de>
In-Reply-To: <20240131130400.625836-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9206:EE_
x-ms-office365-filtering-correlation-id: 63040a51-4163-47e1-48ad-08dc22b5c1c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ge536xWtSrUZ2BFnOe8i1CgK9VV9oozPL/fGIbETTSCJaybt765rdW0z1fG1gbY9SeXEcfHq0n6fya7PY1ieLgiXK53UUUySRmL/TEjRqA47+RkbQsKl7BbFSZvf/DuWbeRTvik99CyeSE2Vd3c1rac6sHjs5Kg8BMDMIJaRW1kWXmoPDy40ZEYM+1j+DV87tepsu/3PiQ4Vzewt4ZpE/nc7/kQBR3zVVLnb1YBlxp36n3Zcuxv5Y4F5mt7pjHoNBGfJ8shW4vEVXCPj3I/y26g9WydPkp3/dOvpPQtDgRhapX8fYgsbhr2JgUmiXcwWPmZJJwOjWtSuX6/GT1qJfuGXOO2PFcx71lpCXR0fyxVnmDs5CxcXt8/ku+/QoWYOXt9MxYfbkXrn5yTcNq0VKA/rOorRYuEf//Age7jIgQgJ4G//ZeyzjsfAt1QxerS1+FbxmPowTF0lEksXApRtBnCoSI4DTRd0nectM+MR+WPu8qwlXTbYS9W7dH7PE0tXXt3O5nye9qu5FuXNxhkbCN8m0aMUNudCYDaklwRycoMkAkZaIBC2hDnE1hq26u3qkRwo78D3F1em5riUv1WQxkrazsFu+L6j+DJLLmdxRtxBAv216rmapEuVA9F8kzzPiXD0oIKRl/snEnRbjQ4kAouKA9mWfMkHzMrQAnO1Clwpr2XbDMx+kyHwvHsi02Ei
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(2616005)(41300700001)(66476007)(316002)(54906003)(66446008)(38070700009)(36756003)(478600001)(6506007)(6512007)(6486002)(53546011)(71200400001)(83380400001)(38100700002)(66556008)(122000001)(64756008)(110136005)(2906002)(8936002)(31696002)(5660300002)(86362001)(4744005)(66946007)(76116006)(7416002)(4326008)(8676002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWNTQXFhNUpnTVZwNmVUWUx6VHFwNTYwWjMzdWUrdHNzVUpndjhPVlJoSHR2?=
 =?utf-8?B?bnpjcEdRL0M2RmJaOFRPNDZwUm5STHFmTVc4UEsxb01WbGdraUU5WTZwRXRp?=
 =?utf-8?B?c1FWbWtHSElGZFlvejZNd09ObDFxdVp2WFp5d01ucE9FSTkwL05FcXprRHUv?=
 =?utf-8?B?azRVbk91SEh2ekNGcWp4Qm1Eb09pZjVveEdZUTJwcWVRMkhXVUFtOXV3UlVR?=
 =?utf-8?B?VzhtSzJwaVE2dVJDVVBWN1V6Kzl0M2V3NVovQklWU1pKWUlHQVRMTmJzdk8w?=
 =?utf-8?B?S09BZllvUXFtdlp5amdublZzNTNNdWcvRUQ4MXVYMjZBTDVlZUZIVmM5Zk9S?=
 =?utf-8?B?dlM0WFJVUUl1R2tuL09NWkdvQzk4amdBSXVVaVFpSFRmRnRYMmVwUS9ZWUpa?=
 =?utf-8?B?TGFOZzh6aUZZSklNU3JSSzArUXo5MUpCVlh2WGlUMHRWNXZnb2tkZGw0K3Nl?=
 =?utf-8?B?K0p3TUFDNlhlSTE4ZkhSYWd2cDhpWlA1UzEzMkFiWkprbWtOREhsYVMrN1NB?=
 =?utf-8?B?L1JRT0p4WE5YdFVTT0g5SEFPdHBkZ2JaWUJweTBQNG1BeXdtb3VxSHhFSmYw?=
 =?utf-8?B?blgyODVCd3BBMTBqR2QvMDFlemxlUnhXMGVObnJ6RmNIdHJJVGpiUU1TYXdL?=
 =?utf-8?B?NVRDUlZsamNKODFkWER5aVhYTXNQZDd2Z1lkUDBBZGpZQ1hWSk5zVm1ONWd0?=
 =?utf-8?B?eEV2YmxqL2U3Q1VMbjVSclVMZGVlWUlWSThoaC9aUjJzSHllNEhWdDcxYUpM?=
 =?utf-8?B?NkhBUE1GODgrMFNDQ3d3QzlacEtpbC9RQlBjT1BTN1JVRXNJSUxockZxV3ph?=
 =?utf-8?B?dmY2TkR4WWlLYlQrR3RsczZUQXlCVklnUEJpeXdFN1JXTmhENUowQklobUd0?=
 =?utf-8?B?YTA5UFpHTk92V0J5VkQ3WUQ4MldRMWVlS2xBdEFOc0czYmc1RnEwVGlwbzF4?=
 =?utf-8?B?Vm40dkNBb2RPVU5OOGZneHl1M2RaaFoySkRCVm1hcG1ER3pFSHdMajBDYnVi?=
 =?utf-8?B?ZDZPUHI1Sm1mWi9XZlRKdjJlbERvcE1qUHBuZVVGcmpwUE1vN250bUw4bDNS?=
 =?utf-8?B?b1FNaVRsOEZjS2picDdQbHVEL0IrZFd3U3MwcHU1WGxVaXEySnk3TWNXaE8z?=
 =?utf-8?B?K3RVbUFpRUlwb1lySlgyaCtWc1dVQmhzdHIrNTBVZGMzd25OQWJpWFFHZm5x?=
 =?utf-8?B?bGJaei9hMDhVQytwdXA5N0lqTDVGNjlzRGVKNTA1Tmp3MG02Qk41dFBUWjZG?=
 =?utf-8?B?bHN0MWFFVGcvaXlXamhZak1CSy9xaDNXY1JTeVAxaXdHdzlLM2xTWHhqaXFr?=
 =?utf-8?B?VXptbUZRcnl2RVZqN1p5TjlCekNVY1BYVk4zakErYmVDb3drSEhVb2J4VTZE?=
 =?utf-8?B?RldaV21LczZVbkMxdTBoUDVkUExWTVlURFdza3ZpaC9OaG52K1p6WHp4Q3FI?=
 =?utf-8?B?UDg3RnBLL3pLS2l5VjFtZE5HSkJUODZGaW11NVBPbnlTRFk1RzFvRk5ISXA3?=
 =?utf-8?B?dGZFaE1Ua3MwZ0N2cy9mRzBtZGExMzJ2cFgxb3p5T1RLYXFWZUdMSEJXU09B?=
 =?utf-8?B?UkFtNEkvbFYwRnowbVIwTzNLTmNJSlplUS82dUZJTHQzZ3lMMWY4VkFuZWJi?=
 =?utf-8?B?aWdKbXBMOHVzQ1NFcVJxYy9xRTR1bGx6aEN0Z01GMEN3RE9McTBwdUdwd0tx?=
 =?utf-8?B?d3hraittYnZhUjcwRWhXcTVVL2RUa2hMQWFhenJhYzQzZmtHRFZZYjBnZm0y?=
 =?utf-8?B?RjNCSmhzYnpuYllZYUtCclpxWmRhMU4xOFlER0F0NE9Ib0Evd3BUUEEzdnJD?=
 =?utf-8?B?RWVHaUxFRm9wcStyZFFoVDdPcVdwWGdKWnpDcHBkZDU1Ym1JWWRBZE9QN1BL?=
 =?utf-8?B?blM2VVNhYXhXS3JzWDlkQUQ3Nmd5bWhkbkhXR0tMM285MS8yUUt2OGdPZTVG?=
 =?utf-8?B?TUNFMElOU3dnRjNoVTFlZC91dVRFeHZpdUVJOTdLc1dJNExUQnhzMnJCMy9p?=
 =?utf-8?B?bWZkWXQ5cjAyY1c4NU5yTHJVMHBPWDlBa3hiYWFYUkpSeHpPdGZIRHRpbGFK?=
 =?utf-8?B?TTN1MDFNZkRZMnZzNnZIUkttSnJZTWFSdEFET0ZZZEoyWVJBRGJYcE9PVlNp?=
 =?utf-8?B?eGx4UFRMdzBjVFQ0ME5taW9qWmw0eDY1NWRZbnMzYXZPT3hCM3BwdW1xVE9C?=
 =?utf-8?Q?DHFz3SI+bdxR7ztjRg5wqv793gat40nZE0X+1uxX1INJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82726F64F59D614B9668F755C4440605@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63040a51-4163-47e1-48ad-08dc22b5c1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 23:38:41.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGTK+E/j9BfkjPB5dSS8ghcmsx5gpK6qy3f+eir6YH47OMBsh4itoP3xznG64ESBpYsYuSrrzBxeRol+2wL+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206

T24gMS8zMS8yNCAwNTowNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBhc3MgdGhlIGRl
ZmF1bHQgbGltaXRzIHRvIGJsa19tcV9hbGxvY19kaXNrIGFuZCB0aGVuIHVzZSB0aGUNCj4gcXVl
dWVfbGltaXRzX3tzdGFydCxjb21taXR9X3VwZGF0ZSBBUEkgdG8gY2hhbmdlIHRoZSBsaW1pdHMg
aW4gYW4NCj4gYXRvbWljIHdheSBvbiBleGlzdGluZyBsb29wIGdlbmRpc2tzLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3ZWQtYnk6
IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBIYW5u
ZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gLS0tDQo+ICAgDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=
