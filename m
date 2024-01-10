Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A33EA80
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cBy0GTpS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eefjF+ux"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704901362; x=1736437362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=cBy0GTpS/g3rq3zbeHmWgIQnE64wBgq3d0RPSWo0AkmHSjxAcQWbM+AP
   S2is1UgGzCXirDgnyWTzdXeHnncEDSSjEV6UBeqV5Q4/91szpcl2Ko4HP
   rQ+iMGvScFk3UJsmiohn877x4mja+3BbUwqv5nt1p98PhWvFw1jsAoPwc
   Ha6LiD6ei3apI0Mb5cqzzIT90y5fRdKaxLV1njU7nRP8YCOjoJgf4IUDm
   svOm+IzgLa3DhaDjOv2ABL6axQRQ/FmmZ6B4evHHVuT2Dsyjw0Ztwwxh7
   ibUDoy3bIbBDxmCdA8/+zcrLPv1JHoxOcpqJeKCqymaPYtbhCyXU8wz58
   g==;
X-CSE-ConnectionGUID: ALjO3WohShq9C//HYFC8hA==
X-CSE-MsgGUID: sMehY7ScRW6Up4FMgTUoMg==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="6583638"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 23:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYGlqkGNMJWQhSVWztTrpU2miKz6F1tP3TrlqybjNONvbOBXjdOKkmVigbG4OzUrRPyi+Nv9Id9zR/rnK0c7YEqOG+WxxEy9Sl8Sj14SN99KrnMkJd0Ac8w55CqDht1d/QqD8XeH/Qaua9cFau8DTWnfVmLAJBU8ac0YEKc0mA2oTK1KjAQSyJmRdFtwk3edhQeXvBpHNxNkXOctzImVU4iAroBi/6SS2KxlfjEf/CpUQYhEM0U8AuUgDNebW4WpMmTCYl47SWFs7AKTfLlep3S+5MLnMb1MBmSsS1xjFVzVaYklG+LyCOZYn8HkF77RDQi2nCeL0V/+4D8R26p33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=UpJmkbb99BTw7lJBnO2O5mpSSRNoqzj4Mc9Ebuukd6jGL5amMvR285uB1nwVobKV9e2QivMOuRy/QdG5NXTBjJUvuV5GwOxlMhP1HmXAQf4yhajScMI7zPN4kDblm8xF4qn61HpDcK3GE2jzFp1+tZaTirghMWDJhMbI/o6xC11kPUdx3FvB2GwvQg+J+8MdwpzkRd4Ik5ia5iOEtpCJWUHbqQxS6KPDaiSuHcTKh/KtpcisBSu5+j5+Rax2ukY+RzzIx3waekoB0F6uPifri0vk7eP+Y2tMkdm5QnDsGfhyZe5W87WHYnvkXbENAIeFrlhu5Pc3cjBoD5HBmgSIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=eefjF+uxQqbY3Fe2rqEu3B5z+C0a2s1C6If/b5AvgtShrW5kuVWSrO2hKMTHWNoM18e4jTIa1QE3r3Ppz9T3qIR4Av70sfvFiMuENbQc3VveflNln6TdHngUxAe5GveqZBdENyLDIlaOewxtavdNn+vVR7l3UL1ZG21aOUoN1zk=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CO6PR04MB8410.namprd04.prod.outlook.com (2603:10b6:303:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:42:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::a8a:ec30:a6cf:8e1f%5]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:42:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] block/iocost: silence warning on 'last_period'
 potentially being unused
Thread-Topic: [PATCH] block/iocost: silence warning on 'last_period'
 potentially being unused
Thread-Index: AQHaQ9pDh0SjWOeezkuy0KTzSfNxPrDTL4sA
Date: Wed, 10 Jan 2024 15:42:32 +0000
Message-ID: <4aac7886-b3f9-4db0-ba2d-c13cfd1d237a@wdc.com>
References: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>
In-Reply-To: <06a7b6da-f3de-43cb-8ac5-bdd090a7d33b@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CO6PR04MB8410:EE_
x-ms-office365-filtering-correlation-id: b52ae4ff-da3d-4d3d-9c4b-08dc11f2c2c3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xhGxYDWh+W8Eq3LqKhWSUXp9nuwiX+4ixOf8YXoBPLib2HiHSuLk+ZD9Nz8xmdFNU6ih4MR/tfeaPZrT/Ly6iOqg1b5TjAAQ2R5uzy5VGQnYDwtD3pmXfYyYaLYRVWYALODGVVNkAapMm1jFlIRt/F3AZPwSAzPGLKOFagsgNXrxSjPdYvC9L3rSy2iWXY2XBHWKCu+HOEPl4CUJj+IKzfSa380GMvrhWer8XlzyR8Lzvujol+1l91Hy3z9FbVI93pXt1UXKRB2iYyaC72pPmUrs+TELXriUhpDHcTaCpnRXeBLPJCA+yWbvD0q2E39K08nefyd4/KPafxuwMXp6pmPrYtFVnoQJ4BVNDGZ/oWqKgzj6PytcMgfPU/YIJOZgKDZ+DoFoC/NOdTM/HSqOG8kd+7li0lY/z1IpB0C4ROc9XoEBx5TjE15PNKfi1ic95IhaCX/Jlyelll/ABZ/HAERdsiAxHG+ghm6p2zI+ta0+HzwRnAclXvCwwuEOVFycGUn4BGB/RIn/ubkRPyPbr2AYEsTAwP0i5RCUVZGDdl8+vLvHAziMJckgScU4MXngKDNOOzC+grJ2aUyjN+RugmIxZQrrGRNKkVhwAcUDzvCC5fhZZ3Z0WWJaOxkuGJ13cjB/ztXibmL+XqK3O7Sey7D+5yOU88Ce8zIJEwnF2GewwqpcNhDQ/trnxIk7v6r2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(4270600006)(2616005)(8936002)(8676002)(6512007)(6506007)(41300700001)(6486002)(86362001)(558084003)(31696002)(36756003)(38070700009)(4326008)(66946007)(316002)(2906002)(110136005)(19618925003)(64756008)(5660300002)(91956017)(76116006)(66446008)(66476007)(66556008)(478600001)(31686004)(82960400001)(71200400001)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEJNRmgvRExjSXVaYXQzQ1d1SFlkTXNlS242enYzWEVkVlRCMG4rb1ZqTDNK?=
 =?utf-8?B?Nnk2OUt0YldqVnlsWnlzczhGdUVZNC9NNndsR2lVeG5vNitBY3Zxa2lvbHRm?=
 =?utf-8?B?R0lyVjhXTk1lN0V1dXJ0dHpRMTRXRmlTdTgwL1dNUFVnN0RxRnBWemxmenZN?=
 =?utf-8?B?YUYxN2hRUEJ5Qm9aNUFRKzlQaTBGSEcrZE5LT2VLdGM4c1IyTEZmbW44VUh5?=
 =?utf-8?B?SW4zeGlWaU1SRnRKdytZejljcDNLWkh4bmVvSHk2aStMaTgxOUFySDVXZXhx?=
 =?utf-8?B?NVpsb0lCVmRqNWRmNTFlbElRWjJja2gweXZxRlJuZzJkZzdUQ2J5MjBKK2Nn?=
 =?utf-8?B?eDZOOUM1blI5dWFzNkdmOVZFWGtCR0JEdW1zOVZlUzZuWHJRVWxDZ2FRZm1O?=
 =?utf-8?B?Q1BOMkRpZ1NFUkpCUEZYUUtXbGxiY0VFdmp0eHc3cG8wVC9uWUxOOGZkQXAv?=
 =?utf-8?B?eEJIMTEwbXgyUTZrSHRrTlNJY1p1QUFiYnJIN0VyRnIrNHducnVabjhLSUVM?=
 =?utf-8?B?dFpneFZOZTNoTGhCUU5DY1NFK3RnUXByZm8wcFBBU2N3cjhoY0hQUWlPOXAx?=
 =?utf-8?B?bVZ5Mk96bW9WSDRKWlY4YVFxN3ZkTktlT2VSQzVLRzVZa28yMWNPRkFjK3Yx?=
 =?utf-8?B?RkJkVnppbXVMYW40SjVNRFVRN3lpbjlXd1FJaFEvUWx5MkpQWFZVSFB4OG9v?=
 =?utf-8?B?VnFpeDEyVVFaeUZIVmVjZzdwR0R3N0dFVWFCRHA3dndUR01XQi9yTUVWaG9Y?=
 =?utf-8?B?ajZJblhrSnlOc21tL0x4VGsrbWVLMlhxTlNQOU56bis1TmdCdkU3ZUlPNjdr?=
 =?utf-8?B?MG9oR1B6MFNTQmVqanNlY3lqU3lxZUJ6Y0dlYzVnVTdJY0RmTUthMjdGa0lS?=
 =?utf-8?B?d0hGL0wwbmNiRWNiZ2xWcm5lMWhockJCZmxVRFB1NUc5Y1lsYVJ0bVVJWWJa?=
 =?utf-8?B?Y3Y5cE1UYmlVdUlFcGxSRG82ZjhvQXVqZFRWeHJIamMrdmN1WWp0WTdHakVU?=
 =?utf-8?B?TWRYZkFIeTdHT1ptTTVHZ0d3Zi9DcmtvZWtiRXEvRWhBWmdjbDhlMitVMFhT?=
 =?utf-8?B?UmJtZXA2Rk9PUFVYV2diQjVoQWZPdXhXbkR4cWRKK2p2MzVDUWRvLzdzemdV?=
 =?utf-8?B?NWNBbnhFUm9iSkRwb2RLWHZ4bHlVdHhKdSs1bzdkcVZVdE1qQ1FsSUpGNUtB?=
 =?utf-8?B?QVNYTVZyRDlvSWVGVW8xRlk5dkY0dUxvbEFKZjN5MDJyTDJkWEVoK1NLbzdp?=
 =?utf-8?B?ZjZPTm1wNGpmYlhqbkJtcWw2QmNJR2RGbDlKMElqcDZhLzVDWVZZQ3B2OUZv?=
 =?utf-8?B?dGNra1ZEenB5a2RkdTB6VGcyc0RORktmWUZhTHdpR0R0YnMrcFdVVWZFQzlH?=
 =?utf-8?B?MTRqOFg0cm1IVHJQYlRXdDNwMTlEMzdHeDN5Mmx4UzNOT2Y4MVhlb09rZ0V0?=
 =?utf-8?B?Z3ZKZTZ1SUNaTCtOL1lHNm1FNEZkOURJMXM3NFB5cVA2NUFZTm5SMFFhQUV4?=
 =?utf-8?B?azJFNmFwL3VsNWFXNnp3TjFNNVpoZWRJbWN5NjZZOG0zN2IreGZ5MHNNVmUz?=
 =?utf-8?B?L3dUclQ2MFZkVXN5SHZGVmRkSnlvem1LRmJnNU9aWE12aktqYjRWZ2dGS0ZJ?=
 =?utf-8?B?N2ZjUGpLQVNNSDM0QWJSOUtWelQva21RY0ZTbDdSMlVyd1o3dW5DaVp1V3po?=
 =?utf-8?B?aHNQQ3Z1YkxOeXlxREJQck5vMFFOSllna0NHZmgzZTdjaTBQNVlzeVNYOEZh?=
 =?utf-8?B?R3VyUXNpd2dDZHNuUkRvNkVYaHc4c1FwRmVaMDlPZW54ODBCcEVzYXpTWjN6?=
 =?utf-8?B?L3VDNFl1SGpCSXBuaVRnR0FzSm9zUE9BYjFEVmZ3cnR5Y0hyaXJHaVEvS1Fn?=
 =?utf-8?B?b2huenUwQlc1YnhkaHFkMkJwUUlWVS91dkh2eTkyUmJkYXVVUW5FNWNFL1hs?=
 =?utf-8?B?LzA0c1V6Nm95ZlJyMG5SUnpoR1lyMW15cm9WbzFEVGJnVEN5c0hjRFA0dEYx?=
 =?utf-8?B?K2pUeFNRTDc5ckNPSi9mYks0RW43bXByZUVHRTlMeUFsOCtOOHgzbFZnM3dD?=
 =?utf-8?B?d1VxaW82NUFuQXVKczZ5a2lQY1R5VTJDQjRoelI1a0YwbUFYNlJ5T3Q2QnVS?=
 =?utf-8?B?UUtJTkFmbUNnVkh6amtuSFR1TlBhZElKQUovNXk3VHl2YkcwYmlMNWtUdURC?=
 =?utf-8?B?SXo4aFR3SmRGZWI2R2dZTmZHMHRTRnA0Zm1FV3RTN0hvNjJ5b3FwaHpmeFhu?=
 =?utf-8?B?Wm9lSjhQdTh4TkRmM1B6OERRR3FRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF0A1D84D5F9449A7A723B16B1DD5C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xv9Q/Ow+DSz9JDzAmGgL93osXerQL5Q4CxdIgL6MirpJnPqKn1FiCbBhYIaV8HSRuodJjYXdld7Wx03zq/IrLhkHKVhAvyWZHBsOpHn38hUl5vtsMdTJoTpSvEmdm2GlnzMwmDOftoQkDlhvVUjtaT3YknekHv1a2hHUikusEHuzVC2h7c2gKujtDPQZUTt0vRsBlTcKwnhcmd5yw1OR2V1hE9+EANa2IbMxfU0RxLnYZs9AdemZEZI6Gy+uo0B9C+k73sv/CLPg8mBJH5V2DdTXpHcFb6EDIamxcKjC3N5RKpTvzpjv8Jct0BGr28RIioVLMFR5KzGTuZXyJ79QTydB88IzwYPAaNCTYfEyG8nyef9H9K2PaRBvxTovQADdylYti6iRUQHfm9RNTYvBD1I1IoJ6qcMNr0sn7zfNkePqrssGG0lb0Z3BmVS1fJvuFg2uDM1AOEMxRKXqr8hMolLFrzRHZ1cQL1HcbEZ0aTE0hHhbW13UvjxUKhpbb8bWqytQzHagqb9Rc7P45hBuliblE5dTj6jrZGqqarWDDXVGvPgkgZwtPr+RegGal/22dDwVvs0tWuNuVCQXn7qBfT7VjfTcBR9e62XGIMAJPkt6tVySgNKHz+Sn46XRS4ME
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52ae4ff-da3d-4d3d-9c4b-08dc11f2c2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 15:42:32.7053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCOujOumVqG3m1kYEUJbo9Gpshs4bEp9GWwspOmm2KbY9QAd32kJyzzNWrGIs9HQtLB+pI50d1FjVrJ+BWHTNhaC0EZQBd4T8AaiVk6i5tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8410

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
