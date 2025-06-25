Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F81A4E9E;
	Wed, 25 Jun 2025 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750820136; cv=fail; b=eQDzjdGZEvFM2KsmxtHbXhuDsl637cv+GBybHaUYZgtIC6b5eoiCJPXoEgn5NwTlrfHrk1gUqbrKzoJBmKnMiinQYWjGio4IhjMd+4J1nPYEyuCxi+33GmhOn5kNGQHzQUWABwIshtX7107aAgw/P7beQ+liN3RpeA0dWtcuuaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750820136; c=relaxed/simple;
	bh=U7Ht72xrYyi77a4vvrkMfwAsl/QBMqQFyyvrAC+w7Xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DhTVVUEzaTPMkF7a0q2oBDiOCk5dbDAW0XEKRJb6tWE7OgvM8ajOwZjgdAsH9Sep4gnkTCmjZg47r3++JR6cf9Mmbhq8q3xelNEeEtbsi0eNQbXyUEA8Ux8l+PS52Rdb3AUNJgUnzHm7tzqifSu/kaU5BqOJR+/18sKkqkV5iWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBVQsNVF; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBVQsNVF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7cwTQhyDMa/N4gw9ZCsvdZNDVXF/p6xJ4THuYXhtZSaUhLdQT4o6NvYmtOZ2iTSOdbbEczey+1MBkanJjNpGS0vQA5QH6l05yCWre8fXKsomPDQ1nfXY9aen6W4mWT+EZ7TJlTJYH7BzdYjnK7GC87UlAoXddbcz6N00Kn4IyX16MTgfK6MYwU/yRc6isvgt96+q0EPKloyolNcV4MlA1OT1vD0Xe108hauxV5KnUkDrtITLuEDAr708VbtsNzPzXNYfjK9QNofMFQFp3ka80FsYvaitSwa4Rnxmo+qUyFJxrb36+FcmitgVIQShI4sm0iclX3jNCNFDeek698u/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/wmGfUsZ2Hr4HZZbPBN7xguxn1NZtzZDsODyL5zsh8=;
 b=LJNn4K9vKusxjFdYwyEYRJjhWFiYWv/xeO3/hiDWQm7UMthIfuisY+hvYj+edfM6GzzcV0UxnT/tFQ0oP8rU/wojwt3w+TkEusg5oy4RpOnIyERKmvRx4tBGRKKkcLnq+X8lxsB6ECHVQKZ6dOUZom1gKQ469KGuCUMTL46MeoffBXedlv3wiizOlOpaWKYifJgAb/ZjE/tn3oeHqP14xFpaMCwGlDjD1lB2ISQsChO2mtFnzPwaUgTtwPXZRq5QYz7WCIDH8JESVFAHzRVQNA4+UIzD9uepctOxfB22TYjyCgcXFx0C0RJqXE/fPrrfvtcKlvSWSJkQjSiwRwUCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/wmGfUsZ2Hr4HZZbPBN7xguxn1NZtzZDsODyL5zsh8=;
 b=NBVQsNVFWfTxoqPDjNoX4zLBv8IRof2dloMmbG5ay20HsXnwLwmAs7KkjEm1TU5zdWH1eP0NScuEUldg0HOSSHEmPZvI7WoiGHvO2XtLs0s+RDWITyv23U1NMBxJHFiRMR5RDVQcLesleF1I3vxGxfoHyAInQSAQ9hq2rlzsDaSmXCr3gb43u+A/1sCWsKBaxUt6lvVX2tOJ2Tasfuf7L2LUBbdBnLmDnfpP7jnvLljrEX7nZRetK61kaODXyxCFRjyZzondQMtyFAQhsABgemypB4K/U/IlAoJzQsx7AHunhxOnJws+cbBvk5d8Sw4UpZhGd0Y8iRR/nzvQMWd8wA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 02:55:28 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 02:55:27 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index:
 AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQgAAMIgCAAHNgsA==
Date: Wed, 25 Jun 2025 02:55:27 +0000
Message-ID:
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250624155157-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA1PR12MB8859:EE_
x-ms-office365-filtering-correlation-id: 5cfb7f0b-8a41-43a8-d040-08ddb393bd81
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7dz1vCpsJiEmNJTUiRzH/sFUwHnLzi9Vq5NCMjcdmt2U9qu5nhuiugxQzBln?=
 =?us-ascii?Q?tl4j/5lXtzwRvjloKyTGMX7bDTNJiA2gqyO/saMZo8QahNsPwCB4tkcQru+j?=
 =?us-ascii?Q?Il83a0Tnpw8TXQrYK0lhuNyhp1P7CP9MCAPOU0Exn9e4b2DxkF1uLhQUHjJo?=
 =?us-ascii?Q?/24NOGma1yBRGaGHE1toI21EUAVQmLu9Ia1+5rwY7C+joXn5LnEi1YtV5TcE?=
 =?us-ascii?Q?OU1wTuvnP91ppGSlhqkZmpSsgJs3dP9OUVWuMGZ11rXfwxsHbTkyp76UGsi0?=
 =?us-ascii?Q?cs6AK76ACsEQD452CAd69IvG4587v5uSMdVRi+erstdz+5tR/vqiGKwrcnVX?=
 =?us-ascii?Q?ECsCTSmuhH4P6Sh2JaQppoDe/Hiq7uc8NYSkaaBSA1lhszRbevsAb+1XwjKr?=
 =?us-ascii?Q?Rvj5aM/b+bBwxkjzHjwaB3HqFbPy4taKiVo/YKW/ZqD3b2Md9T0n+W8I1kNw?=
 =?us-ascii?Q?tTpBsQGL0m5uBaac5Qxqhq24xgneoVFqmm65RnpWNuynBJyAMhW2bU/PQD7h?=
 =?us-ascii?Q?7cj8bwd5EdxvL8tm7X13VSz2b3KLNkmta8mOeh65eqJuYzIJwWXW8T+WHTNt?=
 =?us-ascii?Q?u2rPXkRXW2Vs3VuPxHVc8xRF/ZbOyMVjCWOvuPaTNU8q4FicOtmmtpuj/s1S?=
 =?us-ascii?Q?/R6Gt0xg5aaWjy70QyW8dnSlJM4Xu7bfeQGXKsve/MJCTMwLMdV7Yvd+PpTF?=
 =?us-ascii?Q?LuKFu5wrp8TG5QeWA23nHX5kyNUXErihgKvRSRLJbulO/BPNei7eeK68vkWl?=
 =?us-ascii?Q?+3lLkC3vjtwGIzeHtxPw0ZYMI9jy5NnR8Ruj1oLapKT+eb1A2rPNBq0QngKY?=
 =?us-ascii?Q?RHetxnaVKq82bk1dzMmxi+3Ey336c4YFh2XaWXa9/Z1TM6PldCYbbs1dmCYC?=
 =?us-ascii?Q?hel/CH8lTcMOZSBF6Qlyvs/9cF0L9droHscffgHl1fsWUGgVzPjLniHduAVJ?=
 =?us-ascii?Q?NbPvNKkko1HiAnXOryWHtYqcZrSCE7Br+HPoO5mbdso41Ff2uLjo5GacrqQv?=
 =?us-ascii?Q?+tjKkNMVzeVlGsaGQz7C/fmWiC8mju2W9+AB4rG/RbO21z7YeQk+G8uADmzA?=
 =?us-ascii?Q?Qu2MeR6bHpwOm2iZpqoLCmyHVjuyWX/TcR6mXmKhdzq2AK/HMvJl6Jv4r5wR?=
 =?us-ascii?Q?y/gMsr7cdc1FwifhW6PFmuAuEQivPQg09E4Uv/D3DSeXhaBDENMI8Cp1lnA6?=
 =?us-ascii?Q?iRfgy8fj+tVbr1PL+Vfb/5vk689n8Lwehw9wzCwvcJO/eTmpoMfHLCCVHC9z?=
 =?us-ascii?Q?UZFpVsgbqVIbImClhyy/3d2buy8lvk0idczNqByGsRXaVrARMMGtyUu4Ky2E?=
 =?us-ascii?Q?Y7DNlBvbFYe6epZfhLtBJnzqgJaVCL3p8ITf9IVF0D9G80ydWdbysuzhWErv?=
 =?us-ascii?Q?6iCtOuFMGaqCrZHgDchntgmwab6f6tDeztdQTSmhkeqPMM1KJRndei9NJfmS?=
 =?us-ascii?Q?TBdIp0Ml6eS1njWS8SiKZIsIb+Xy7UD4EHTrAZ7EjyJg4TJI7r3rrXPHa1/n?=
 =?us-ascii?Q?xOnniqoDePVItxg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EQgMhhnzalkjLkNGw/Cz9FvjtN7m78I/GOZ7JnfJuU6VHhHRxdtKEJQtZA33?=
 =?us-ascii?Q?/9YPfQ5dwdBEurGbhj60+bM8C3IexBSOTpuRb4yWlM6OLrx/ZwzJNV8Nlv/h?=
 =?us-ascii?Q?sKgHJZQUlsLVPWby+8ntLIqy8uUlN1PoTLDZQGqiBIJMaF7nPrgl7NymOcni?=
 =?us-ascii?Q?YORJQVYxkNdgGaDfmGA9ruy2fCBKUp5GMJe1JmiO7FSXhN3uBTL+mJWDdT/4?=
 =?us-ascii?Q?IHns5KVmvziT7Cab+vnaOyvAqGW8HKovNgtCTsumnYX5/V0MEi5wCEVnskba?=
 =?us-ascii?Q?CvwBuln+atmGNkW2oos6CyLMyVKBvTteRAvKBxszkSaH4C22l9VRCfMZp1Ar?=
 =?us-ascii?Q?C7Qz6Atrlrpk8njUrUY+bwom6NTsBGL1CWJSKMXIh/kPDtfOp3ftpFMb+hAg?=
 =?us-ascii?Q?fc2B4eajaKARq5ILMxVkjuneAlLQDwcGe/l8PReUiBi6sZRQp+qFQaC30KG8?=
 =?us-ascii?Q?HPa9pbfjprdpZGXD57y4sGC0ux2pDn8zVcK0vWuXvKI1x1kpOToT3mo5tiEO?=
 =?us-ascii?Q?Tnimbk5AO8NFyFoxtstixriMXCNvkd70ekpWyyKwCO+W5jWWW3t1+ZPE7e/o?=
 =?us-ascii?Q?BeWWnPiLB6wk1C3595Y7ytJP5RWNXULI7lT0UFc3ywUNZZtHjNhT8x5aWvGc?=
 =?us-ascii?Q?aTGKc3K9TlouiFUTB9CDWjTY+EDVbUR7H3yr7OSc4PSzgsionQe07K0nKW+h?=
 =?us-ascii?Q?kILa6rLzoc4LVqxQiywCejXQYXVB0MEjmKGRbo7/Au/I6gFvFyImor14riCM?=
 =?us-ascii?Q?EwqOuNegeNdNl/c+aTvgs9Niiw8cf6uqhnsbHzoIYxGihKs+K/oZ6gs1zFdu?=
 =?us-ascii?Q?Fq45aoZD3/voUACZAIqb67BnVlDLXeiF/fyvFsnP4zEaqEGyBQp5NOapgwEC?=
 =?us-ascii?Q?a9ZZrjmkOsv5zw6ZSo5dHEn93oyGCxYLRnSAY961Oz4d6qFlKBncABXThejK?=
 =?us-ascii?Q?qkqKfl2CvjZdOsWw5WvD+d9kANPDgUyiaDb4ONoaV7CapQ1nyBbeXrja4tGe?=
 =?us-ascii?Q?w10s6GR7Ky6s5pZGk+tiBVAr8CcpZx3n/DnjuEsPa+q3D3O8vNCuueKUSShN?=
 =?us-ascii?Q?Wb6hls7qHy/EyTrKzAty7ASXbEVd69PFxHPAgg7KJTOMWVeIxeGf8hkLkroi?=
 =?us-ascii?Q?PxnLfyG01/JQrUcK8/Eej+RqncQJgDuqVVUWbNvBV0RTQG1tIFPbDrwAw76E?=
 =?us-ascii?Q?ojl6Jk+2ik0Gx1J7H+xGEeI4899aCxBozqARXNlVrGILHdV2TAbmQhFA0aS7?=
 =?us-ascii?Q?GXV884cpXOMPwyWsr0163Egk0yLge48uBeAt5HjSLi/zuKJSyrOvbwxI7CN+?=
 =?us-ascii?Q?+dUstfseMpKbZiTwxSoZqzXD36vsWiaekn2kU2xymzhvvoOqkngFIZ359RyL?=
 =?us-ascii?Q?VTW5TsL+vkX61nXyCnbwkjsp/PsbOB3QWq/qNrDDgsl5J5uVtkfdrOkfYOnT?=
 =?us-ascii?Q?v91T9ykESU7Z7qP0KUZeFQDRq4y40g6qhrGhtanMzOW254ght0DvWs+nWKYI?=
 =?us-ascii?Q?k/wiR0otwgH1jjH4GwqhdRVv2b8TGi65HM7HNAkhhI2HTxhHZkqOX7zG3zXF?=
 =?us-ascii?Q?ogYlbhRfyrIgC9rgG0M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfb7f0b-8a41-43a8-d040-08ddb393bd81
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:55:27.6340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqpvYnU/tj8YNz3DeLhkxHx7+rRtKt22AkFELm98Fe6Qdv/QdYTPVfYmCX3r9uYLcaUqu4btIvtiPNmnq7xAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 25 June 2025 01:24 AM
>=20
> On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 25 June 2025 12:37 AM
> > >
> > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Sent: 25 June 2025 12:26 AM
> > > > >
> > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > > > > When the PCI device is surprise removed, requests may not
> > > > > > complete the device as the VQ is marked as broken. Due to
> > > > > > this, the disk deletion hangs.
> > > > >
> > > > > There are loops in the core virtio driver code that expect
> > > > > device register reads to eventually return 0:
> > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset
> > > > > ()
> > > > >
> > > > > Is there a hang if these loops are hit when a device has been
> > > > > surprise removed? I'm trying to understand whether surprise
> > > > > removal is fully supported or whether this patch is one step in t=
hat
> direction.
> > > > >
> > > > In one of the previous replies I answered to Michael, but don't
> > > > have the link
> > > handy.
> > > > It is not fully supported by this patch. It will hang.
> > > >
> > > > This patch restores driver back to the same state what it was
> > > > before the fixes
> > > tag patch.
> > > > The virtio stack level work is needed to support surprise removal,
> > > > including
> > > the reset flow you rightly pointed.
> > >
> > > Have plans to do that?
> > >
> > Didn't give enough thoughts on it yet.
>=20
> This one is kind of pointless then? It just fixes the specific race windo=
w that
> your test harness happens to hit?
>=20
It was reported by Li from Baidu, whose tests failed.
I missed to tag "reported-by" in v5. I had it until v4. :(

> Maybe it's better to wait until someone does a comprehensive fix..
>=20
>
Oh, I was under impression is that you wanted to step forward in discussion=
 of v4.
If you prefer a comprehensive support across layers of virtio, I suggest yo=
u should revert the cited patch in fixes tag.

Otherwise, it is in degraded state as virtio never supported surprise remov=
al.
By reverting the cited patch (or with this fix), the requests and disk dele=
tion will not hang.

Please let me know if I should re-send to revert the patch listed in fixes =
tag.

> > > > > Apart from that, I'm happy with the virtio_blk.c aspects of the p=
atch:
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > >
> > > > Thanks.
> > > >
> > > > > >
> > > > > > Fix it by aborting the requests when the VQ is broken.
> > > > > >
> > > > > > With this fix now fio completes swiftly.
> > > > > > An alternative of IO timeout has been considered, however when
> > > > > > the driver knows about unresponsive block device, swiftly
> > > > > > clearing them enables users and upper layers to react quickly.
> > > > > >
> > > > > > Verified with multiple device unplug iterations with pending
> > > > > > requests in virtio used ring and some pending with the device.
> > > > > >
> > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > virtio pci device")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > Closes:
> > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb7
> > > > > > 3ca9
> > > > > > b474
> > > > > > 1@baidu.com/
> > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > >
> > > > > > ---
> > > > > > v4->v5:
> > > > > > - fixed comment style where comment to start with one empty
> > > > > > line at start
> > > > > > - Addressed comments from Alok
> > > > > > - fixed typo in broken vq check
> > > > > > v3->v4:
> > > > > > - Addressed comments from Michael
> > > > > > - renamed virtblk_request_cancel() to
> > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > - Added comments for virtblk_complete_request_with_ioerr()
> > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > >   virtblk_cleanup_broken_device()
> > > > > > - Added comments for virtblk_cleanup_broken_device()
> > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > - Fixed comment style to have first empty line
> > > > > > - replaced freezed to frozen
> > > > > > - Fixed comments rephrased
> > > > > >
> > > > > > v2->v3:
> > > > > > - Addressed comments from Michael
> > > > > > - updated comment for synchronizing with callbacks
> > > > > >
> > > > > > v1->v2:
> > > > > > - Addressed comments from Stephan
> > > > > > - fixed spelling to 'waiting'
> > > > > > - Addressed comments from Michael
> > > > > > - Dropped checking broken vq from queue_rq() and queue_rqs()
> > > > > >   because it is checked in lower layer routines in virtio core
> > > > > >
> > > > > > v0->v1:
> > > > > > - Fixed comments from Stefan to rename a cleanup function
> > > > > > - Improved logic for handling any outstanding requests
> > > > > >   in bio layer
> > > > > > - improved cancel callback to sync with ongoing done()
> > > > > > ---
> > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 95 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > b/drivers/block/virtio_blk.c index 7cffea01d868..c5e383c0ac48
> > > > > > 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > > > virtio_device
> > > > > *vdev)
> > > > > >  	return err;
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * If the vq is broken, device will not complete requests.
> > > > > > + * So we do it for the device.
> > > > > > + */
> > > > > > +static bool virtblk_complete_request_with_ioerr(struct
> > > > > > +request *rq, void *data) {
> > > > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > > +	struct virtio_blk *vblk =3D data;
> > > > > > +	struct virtio_blk_vq *vq;
> > > > > > +	unsigned long flags;
> > > > > > +
> > > > > > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > +
> > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > +
> > > > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > +	if (blk_mq_request_started(rq) &&
> !blk_mq_request_completed(rq))
> > > > > > +		blk_mq_complete_request(rq);
> > > > > > +
> > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > +	return true;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * If the device is broken, it will not use any buffers and
> > > > > > +waiting
> > > > > > + * for that to happen is pointless. We'll do the cleanup in
> > > > > > +the driver,
> > > > > > + * completing all requests for the device.
> > > > > > + */
> > > > > > +static void virtblk_cleanup_broken_device(struct virtio_blk *v=
blk) {
> > > > > > +	struct request_queue *q =3D vblk->disk->queue;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Start freezing the queue, so that new requests keeps
> waiting at the
> > > > > > +	 * door of bio_queue_enter(). We cannot fully freeze the
> > > > > > +queue
> > > > > because
> > > > > > +	 * frozen queue is an empty queue and there are pending
> requests, so
> > > > > > +	 * only start freezing it.
> > > > > > +	 */
> > > > > > +	blk_freeze_queue_start(q);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * When quiescing completes, all ongoing dispatches have
> completed
> > > > > > +	 * and no new dispatch will happen towards the driver.
> > > > > > +	 */
> > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Synchronize with any ongoing VQ callbacks that may have
> started
> > > > > > +	 * before the VQs were marked as broken. Any outstanding
> requests
> > > > > > +	 * will be completed by
> virtblk_complete_request_with_ioerr().
> > > > > > +	 */
> > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * At this point, no new requests can enter the queue_rq()
> and
> > > > > > +	 * completion routine will not complete any new requests
> > > > > > +either for
> > > > > the
> > > > > > +	 * broken vq. Hence, it is safe to cancel all requests which =
are
> > > > > > +	 * started.
> > > > > > +	 */
> > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > +				virtblk_complete_request_with_ioerr,
> vblk);
> > > > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * All pending requests are cleaned up. Time to resume so
> that disk
> > > > > > +	 * deletion can be smooth. Start the HW queues so that when
> > > > > > +queue
> > > > > is
> > > > > > +	 * unquiesced requests can again enter the driver.
> > > > > > +	 */
> > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Unquiescing will trigger dispatching any pending requests
> to the
> > > > > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > > > > +	 */
> > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Wait for all pending dispatches to terminate which may
> have been
> > > > > > +	 * initiated after unquiescing.
> > > > > > +	 */
> > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Mark the disk dead so that once we unfreeze the queue,
> requests
> > > > > > +	 * waiting at the door of bio_queue_enter() can be aborted
> > > > > > +right
> > > > > away.
> > > > > > +	 */
> > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > +
> > > > > > +	/* Unfreeze the queue so that any waiting requests will be
> aborted. */
> > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > +}
> > > > > > +
> > > > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > > > >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1653,9 @@
> > > > > > static void virtblk_remove(struct virtio_device *vdev)
> > > > > >  	/* Make sure no work handler is accessing the device. */
> > > > > >  	flush_work(&vblk->config_work);
> > > > > >
> > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > +
> > > > > >  	del_gendisk(vblk->disk);
> > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > >
> > > > > > --
> > > > > > 2.34.1
> > > > > >

