Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A31D86D6
	for <linux-block@vger.kernel.org>; Sun, 20 Apr 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745139448; cv=fail; b=NbfVO0jgqC9zZzUAKY+8/HPRxNtABMUoEYJ4KVN4As5PCGSomxOkPZPvkVB8GYDx6gZBJvnSiWZMQ8eB8xz52r+v4ZA9j0vcjbYaHQDYe0C0kQRULFoRmjpWdxfIZnonxHsky4hMFEp13dgeIqCPEtgRvZ48o8ddFAFHN29awpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745139448; c=relaxed/simple;
	bh=/d/Y4eiR7gUG6mhXW5A4OUs8wtv+GTf9RDVQ6m6ngzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hDBAOaILk52kWe8a/MJGZlzNrZ88Ro631uedLShSVvo56FseBhZfSHQZ6TjLhiDT92b634N1GeLlnmrv9383I9NZ6kBQ/HydpYvhN/gt+35/eVlGThCyFoj3kZptUlW3igtLmD8jcauVgNJRDfMRNVoxurNwRSfa1ODeOEmU5gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hb2mACpW; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hb2mACpW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5v+jPQ1De8TdUDlWcVBlDnNph1Y854PHXkgw5H+4qH9aGH+iqQXTdedtQxu+GkvTDXmxvFwxFF9SXFPBKbfHbu6JttfnSnledRzWI3XcN2PujXGbZDBQwN2pyOn4kv+lfSR5253dCC2qOPjcCZ3Dw4vViHMNHpZaTXlMXA0fj60YyfYsCV5ZLkKZu9ii+npiy3xp2nz3QGg/h4aDfK5NR9XjFtoIMmOs7SNk8OSgl27nGg5KFs9LarjeXtEa5DISRZRlery1/RtQ5Gq0GZU6QjV37EfMxWYA0cReXjIUdIuu23byG48oCqe9z5uO/8UzFqFxV3TUjTdq7NJGDeImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKm3H6gU4hxw9vZ/1nGYeSYJuqZo7+Yvk83x/NcwsKU=;
 b=zFq3gBlYrFIyQI9CWaIEArB30rRg1+CQ8bAQZZ/HZRBjjRtP7hMo68oLOXeYTc7cgtyUPY2OXd4UBrJ5vSH7PN/X73oN4eMH7wJarECcgKMYdKKRIz/yEVPZHGBqruDrdya0HXRZmRwom1EkoZoVt6lwOFvUeN67dcAgalqZ1/ZpDBY3c6daVjiHF3CxB9yR86zvzcmM0ylfKKL6VB0V6RR39a05buD3OYeyIIRUoFYR76vd3fv02ypQ1IQoHGmhJzXk3/UNN7wQN1vaevmwIk8eVjCNQCknaBDYWpdtxIEuSM065mwFjo54387uosFVRIzEAUJ5PTkWEvzFwPl6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKm3H6gU4hxw9vZ/1nGYeSYJuqZo7+Yvk83x/NcwsKU=;
 b=Hb2mACpWj5YV3JhUKCxtTw9UUpORPEjfiQc+JTPQC9Y7foJ70Ik8DPPvvJJ/ZzY0qHwKTu20f2mBigrHDKWmB8NxqLYqefFOZcSZxkzoIBKRePyUkQvDseKp8/3cqH35HWoh9QubCUmpn6EK872QEdenpRbikagEpukx6pPVgxtUlT70tB4/NwkRgnk/N1oo57Euz33bUiuFVNPePMPbH5TEU00H0nvKNN4wvzpGnS920MMQZ4/bF7lZd1OmgEqJNWnn+uxbHsT7C9PPcsFJJ9O4n9klj2DhcQDMpwSXfJ6OvZoSDpVZ4S4ClpWWavOQT13uk4UV+mnl3ACTJRC5qQ==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.30; Sun, 20 Apr 2025 08:57:23 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%4]) with mapi id 15.20.8632.045; Sun, 20 Apr 2025
 08:57:23 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Uday Shankar <ushankar@purestorage.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Thread-Topic: ublk: Graceful Upgrade of ublk server application
Thread-Index:
 AQHbrd5cAekQDakHykq2J5wD805DDLOkkQSAgACQ35uAAFXigIAADS2AgABtzQeAABDnAIAGRMCC
Date: Sun, 20 Apr 2025 08:57:23 +0000
Message-ID:
 <DM4PR12MB632807AB7CDCE77D1E5AB7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com>
References:
 <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com> <Z_8KO5uJfkB-SKvT@fedora>
 <DM4PR12MB632890760804D06B3CBC357AA9BD2@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_90hHRXe7R3fQuk@fedora>
In-Reply-To: <Z_90hHRXe7R3fQuk@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|CY1PR12MB9560:EE_
x-ms-office365-filtering-correlation-id: d19fa1f7-a478-482f-61d4-08dd7fe95d9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SChwsBOChNuvdxA1MFflxNho74wYM6Qdxbl1VySBgfyrLkU3XP7zzNI/D326?=
 =?us-ascii?Q?oJkrUhO5B6No+SW7xM7iDtNPjilZA8TLlWuCpnAvYhxoMiWGT0JVwXx0cmSp?=
 =?us-ascii?Q?OEyFUoG4w7zwxOWK8bTilnenpW5Yz1iOKljGes0iOq0zLeLVJX4PCe9vnmow?=
 =?us-ascii?Q?PjvJFsiyxHDoLJVPYSx5IolOlFLLtOxMsSOoulEG+G7z9L1Kdy0iTeVCdc5p?=
 =?us-ascii?Q?mledSnxT8sK/gQTiIjzyCFn2m+MPgzcSkDq1IrxGEnjp71HMogq65KGLkqz4?=
 =?us-ascii?Q?pEu+jB8XF2AZxR13QuVezjNXwd3Lq5lOCBeEi7ZNJ5A8XdeRlerviodTGJPA?=
 =?us-ascii?Q?+bE6M6bDerCdRRhKslLmN/lElejuzVi4/JYjONmPeu3x54K+8J35ZzTM23NB?=
 =?us-ascii?Q?WLPQSfMipVFMbpuhCjtqR6QBKMecZa6+IrEDJXVTRs26yIFa8Z55oZvraBEJ?=
 =?us-ascii?Q?8ib4WqSzYj+ADc2vaZqF4vrJt4UvXjEW1syVS0GCJDIUqM9GeVzjGNvGxMJ6?=
 =?us-ascii?Q?FX4GSI0nGl81o1uNlN7nwjbtjXkCwrJoG1EFGHQ1bE9p8ZULuAWBjyCux0KR?=
 =?us-ascii?Q?Cg7DKreRyF9NRQOxkZH3h4JPbvIKVLJaqRuqRHQUdI75TuNZ2VYiq+h7bSoJ?=
 =?us-ascii?Q?ELT22arxepdqys7wJWJEObNQ4PX/qWDe8m/j+6fQhLHqgR0zP9KhdRGiSc2h?=
 =?us-ascii?Q?insb2aBh+a7VtwhaJV9nzy6/8VAAk8cN0jRzxv6T8ux+Svuum5q6S5jrMbkx?=
 =?us-ascii?Q?Ozik37rmqZx0nZq/iPXNOOWh4z6AAcwkhcA9S/PHdw+37UOxA3nKg0u7f0AY?=
 =?us-ascii?Q?pAtaLPdACcKZx0XK7ce+A6JKToCrQLWFq0ITuaU5+lARnurPubT2Zxiruk61?=
 =?us-ascii?Q?VULg2TW61W7B20UtG+DIs/d3r70eH7hx2rYtoe2ElCXyUlFwYm3fQlmGPXOR?=
 =?us-ascii?Q?WPUQSVUeWjdW787n7Zi00wL+sffZLxfzbqQbBzRGUmYiXKZo+Js2HLqLbJBX?=
 =?us-ascii?Q?nFAN5Dd60Iz5fqCFbDVb2JsOiDcDgBW8YuGdjdWTSsLRCHk+hT8v9fWh7BKy?=
 =?us-ascii?Q?FuoYPWB/fGVmTW6j9HqJzQWuPOtoxFTGCWJwzcXJIfINhWR7oMkFKWWaTetL?=
 =?us-ascii?Q?aq9VZspGQWNPx/2Or5zQjECW2vCz2EWK1I5XTtRJNr1O8XPW8Pa2vsJFvc82?=
 =?us-ascii?Q?lh/cvo/zErLXN7zWYEJRNyvPGXUnZ1n5ThVpidZgWyYomhGKDU4oxz0PHAfl?=
 =?us-ascii?Q?qXDJcCrbCoy/D91bXAyvqA2bBxcm+mXGXofBvCllTfjZqSE5tQHduFYRdpSj?=
 =?us-ascii?Q?FhYztfbuJwpK50k6wFMJ8A0r2jtEq2HqTN6zky7uZv1U+rAEW/1iRISie1nO?=
 =?us-ascii?Q?Nw77djXNGuIoM/06QOh25+LYWjWsf7l0mX1ayfFF8TXcWe8oPangFkF2tvmf?=
 =?us-ascii?Q?5PB0lxewz3zIOgszadbRDMRdxYPrGr9LcG8cad8PPAOf8SskNMj+jA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GsQ1ygB4JAo44/vkWb2uDcIyWiIfHJc319iOTcDNz0ZEN7KkyxThUfNHa6Fj?=
 =?us-ascii?Q?/amXqhl6GrWc1T2sE+ID/HneUQZy+9/u4J1gRkDaghvIIcIW39G8iodbQWls?=
 =?us-ascii?Q?laMIMgD+i8iPZEo+bnmMcp/o0O81QkR1bOkKLjekJCpeWXe+lbKBOAbW1xQi?=
 =?us-ascii?Q?ZainYcAP/ClrrDvSuONfwZU0F7lUINUkywTcKSnmd6NmAi9tkbnhRwfxa5aX?=
 =?us-ascii?Q?JeOfhuDhkI14gn2HBIJ8ik8A7nMmkm3W88YdAjquaCBLUB+eNXauIZK4VeHE?=
 =?us-ascii?Q?xzF+S65RLNqeX+ToxYvmfvbnOpQ8YLAvMX29PBVZXSdeFJy1ccB6gPyEDJUi?=
 =?us-ascii?Q?xit5pkeUIx53LoGsAyCKiXuGFs9Qdr2X5IG7D6VzDTWUUfmkzQMlegXt2uZF?=
 =?us-ascii?Q?yUlNS8V4b976liiyusq+r+gWwDuFeAshAIr/wRpj/P6lFu2wE2YEKNwEDfkO?=
 =?us-ascii?Q?PQC/j5JZo8GCtNmrDHDFSGUIwODEdNzm21zlARtz/WP7Tx2WodB+S6QKkjPe?=
 =?us-ascii?Q?QZcqivOvXkI2nahg/G4ydTdqY18PFR6LlfcNwwyPLhFiOdvm93SzLwuBGJjs?=
 =?us-ascii?Q?XExYm+lsbnQ4fwvddkBKHc7ibNo9YlzC72lstJ+B0eh1MYzNWSvurX+gWxTA?=
 =?us-ascii?Q?Wn8X9+tMn2gJOD2PX2TZyWb0swuZL1nR12ac9Rk1r+AZy4wdRFkldZaUAsIB?=
 =?us-ascii?Q?rZPsMsFixE289hwgCFxGKpknEHAE+52+RVV1GFHwMUXoudx6LUTSieUfsAGh?=
 =?us-ascii?Q?shu0tc/C5IIJe6nnFThJDr+YscqjfGoul5ZfnZtwgOhg0RMhRhyfVUhcy5Ut?=
 =?us-ascii?Q?t0U+luLVnYjM5WTansiC0y42mcdOMcc4+y2ht2JhKSYmNiA7asCmXfZned2V?=
 =?us-ascii?Q?lpKr/eDP/f0ZW7fk5zb5ZULbaruC3Bf7ZQIBmZF7e3HeMmyDg7Vqbv+IBTIH?=
 =?us-ascii?Q?EbYs0wwTd4gvJn1hrkrHU37ujFUqAaKliiqajgy4CIZk1wGFl3EXa3xjSodX?=
 =?us-ascii?Q?gDj5+t7RgepBYmsOo/bSSRjxIJKxRQalFhUqE23ilJ/a2me7cEFr6xmybI46?=
 =?us-ascii?Q?2rAmqYteFejL+OF4ua26ITGokhLt1JCb+HvCIKD7bgn6eqXXHnwKEUbH5gac?=
 =?us-ascii?Q?0/gowaLGlV5EoJLBlAxay46dndewD5wJqbCYfF9GyPwcmhBWemSl7XIkPx55?=
 =?us-ascii?Q?hquR0VzHMTMRqitixXoLY//hsMgcCyD1O3lPMJG3zbLz9eQdPf9UogAAUhM+?=
 =?us-ascii?Q?RWDs2XSXJpQ1sETZmaKWoK/NnzP10fQcVGgf7TjUnByPCad6asdGnCAUejKZ?=
 =?us-ascii?Q?Dwnb6CuG3/tdYpBoJsCJcHkDHch8EoVy2y/+/olAooLUVS+p3kEwlVgpVFe6?=
 =?us-ascii?Q?xFSEuieAGWnGiE4+d5NFqY3AREL7WucP3ZWsA5r1OrxNTCXdNRG3Ly4sud4a?=
 =?us-ascii?Q?kRCGTqiJBDzMNk6S0eDZ/XctaRomzkS2BVL7XoX7IHkpjLk86FuLhM05bHM6?=
 =?us-ascii?Q?pKrNcSZtfczzsI1LB1dB3WGCpZIImdF5KVcFg9u+8f773yuDJQQxcKHCQBc3?=
 =?us-ascii?Q?Hmc4WBvj/J2v1j53qEA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19fa1f7-a478-482f-61d4-08dd7fe95d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 08:57:23.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJt9Dhq2Z57fKlnBEP0VIWiQTrhAL2Mjre+gRmAzb45Cr4QiAYZwhMQxmBH5oAw0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560

Hi Ming,

Thank you very much!
The above seems to match our requirements.
Just to be sure, Do you want me to Implement it and issue a patch or do you=
 plan add it to your plan?

Thanks

________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Wednesday, April 16, 2025 12:12 PM
To: Yoav Cohen
Cc: Uday Shankar; linux-block@vger.kernel.org; axboe@kernel.dk
Subject: Re: ublk: Graceful Upgrade of ublk server application

External email: Use caution opening links or attachments


On Wed, Apr 16, 2025 at 08:16:44AM +0000, Yoav Cohen wrote:
> Hi,
>
> The use case is as you say to replace the binary (update) without making =
the bdev to disappear.
> Currently I don't even use the user_copy(to avoid the 1 more system call)=
 so the io buffer is also part of the sqe which is prevent me from free it =
from userspace perspective.
> So yes, even ABORT_URING_CMD by given tag can be enough.
> What do you think?

I think the requirement is reasonable, which could be one QUIESCE_DEV comma=
nd:

- only usable for UBLK_F_USER_RECOVERY

- need ublk server cooperation for handling inflight IO command

- fallback to normal cancel code path in case that io_uring is exiting

The implementation shouldn't be hard:

- mark ubq->canceling as ture
        - freeze request queue
        - mark ubq->canceling as true
        - unfreeze request queue

- canceling all uring_cmd with UBLK_IO_RES_ABORT (*)
        - now there can't be new ublk IO request coming, and ublk server wo=
n't
        send new uring_cmd too,

        - the gatekeeper code of __ublk_ch_uring_cmd() should be reliable t=
o prevent
        any new uring_cmd from malicious application, maybe need audit & re=
factoring
        a bit

        - need ublk server to handle UBLK_IO_RES_ABORT correctly: release a=
ll
          kinds resource, close ublk char device...

- wait until ublk char device is released by checking UB_STATE_OPEN

- now ublk state becomes UBLK_S_DEV_QUIESCED or UBLK_S_DEV_FAIL_IO,
and userspace can replace the binary and recover device with new
application via UBLK_CMD_START_USER_RECOVERY & UBLK_CMD_END_USER_RECOVERY

Please let us know if the above works for your requirement.

Thanks,
Ming

