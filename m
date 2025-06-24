Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA3246BD5;
	Tue, 24 Jun 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792299; cv=fail; b=rHHRlnl+9DPxTnMiJMT7/oHiUO363kR+5y0CB7ngMl6bTkdiqi4cqRqqAFeJnD3PQCuoreGAiM6YfX8SO6KH6VBwgA8JTws7ecpWAfPYkC1ArRUrG/Cy/sQT3EzrABHkAWWt5JrG+invWgoEQew3GNz/6qIy2q985bwAg6YOaaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792299; c=relaxed/simple;
	bh=X7ePesyjjrlcsChh7BecMmP3iLoHFrUEfbr5Y8ZzXJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dt16W6bRQSDrZrfHQ0B7ZMMBtrYY6MVO+gPThBX4KjSHXiXu1zcbxS3h2qMFnaTpDDWUKxpUKulpJYTZzGPccV/nT6ZMyjh+Q5Uyz+1jFQ3qiHg8fMQiUi0DoQZ3MbLzuVQv70drIktkrGAqV+EKW9EARx9EIgEBYy0KCkAFqKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E6L8FZpJ; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E6L8FZpJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfnzCCpFwENw7dNEw9ZWzzJWYSGOH00Af5uxX4aUDqC96MeP9ZcT4y5vevKpxHgxm0PTx3APdXtLgrTV+jb7WPvod3VYkC9tZnVTOGekoQU5BJYYQmFMsgE0/qxETTJmYZ3CcXAL3xAyLp09EVDZA6LMmoxQ1lvHAFwRlGtE2r9LOHlplU+5+p7+LrUb3WhVlyG5DpWFrSRJHMA6kQbbBsq6yC2KmaImo7Lw88dbqhmdAlMtU7SLO/O5K50b8RW4gyLQ06wJkEHKbLOjV6kwXj49V3hlL3p7v1WtdkfVQB0LNIVjbbZey2rnCB75Xrtd407BSwdV34i1jjF5OC6PTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcCoddipES5SkRpJFPbVvvprySfR79GfHU1H1KIoJHw=;
 b=bvoATeHiqUXKu1YXQPSkNRBzpFtwUTxwCI8OjEj0dvhoRNZfxc7im+3E1tG3KpncZXiDkwHEyn/TImMwKlGvFvPMRlVSCDOPz7HBJkg/0KtFHc4hFHrN6pX4YNeK8yZSH+0yvlHHEUgJgY2Gsc9lkbkEWbkiIv2nV2Cfub02WGqdl9c0RpQO6Z7s8g7XDN6+WI+ILsmvn2Yg5RNjfzSkDVNn3CwRqfW41Wksh/ZCTX4C5/l8j6TFCDEH+nguar+s/zfINjDzcUx6E3dPHvOsXgNQ2+9CqSjU7goYfQoIt2f/u+3p9mX9/XIrdYVtGbCVg28RO8wXhaPk+WfHp7Majw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcCoddipES5SkRpJFPbVvvprySfR79GfHU1H1KIoJHw=;
 b=E6L8FZpJMU4bG+qcw80r4jzPG2rBo3CEmuFiV3Wkn+68dMlNYZKnkmDmBdLDeIZo8oxOS0ppSAxe7qFX5CRWd7Bpi8f9H/xekXnm1gU0RskJTig6VHfVyLj4g9mjvBcY3Dz1Lo62F9Z8gqlgc7VuB7QAN0sD3u0IdVab4ToF+ry+0pr7U3Eu4TaayF03pO/DafDo6HUrmjqNUnyIq2K9rtaAPblZ0dQPow4QFfN7jhfn4ANdozU9gxGPjeHdXbthqO1LuGiOvWX/Gprn54HIu+I/Nm44d8Qrb2El6GAUKdxUTy/RbTwHkCCQ6oLMeDOZ53dAcNhQ5Ua07xVmXHDQrw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 24 Jun
 2025 19:11:29 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 19:11:29 +0000
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
Thread-Index: AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQ
Date: Tue, 24 Jun 2025 19:11:29 +0000
Message-ID:
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250624150635-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA5PPF530AE3851:EE_
x-ms-office365-filtering-correlation-id: f5cf754f-6e22-4a3e-b4b5-08ddb352ec9b
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FwokPT5+Krm4suWaN39srhuaQU3sNqJWThmtmhwUMwanPp7fAZBQs9RKjr8q?=
 =?us-ascii?Q?/NKLTUths6IcrZ91+CRM2snxuDr1kAeFQrud9VtYtzWZJREjoM/ff9XACoSA?=
 =?us-ascii?Q?7LGIJpOoZuaHUQrdEwYCcElyo8GNiY+Jmdyi26qucRkaFkVGe0tvXaeiDd6/?=
 =?us-ascii?Q?DqHz5q4dXGaJzvLKWBzH1yY1CXTnVQwbxMCNIiXSFhHwSuPS0+eejGqBMDi5?=
 =?us-ascii?Q?K1z+SJIrWf4wMVyxojC5R0W7pcwP/9Hg2pFyxOp5VKRf43QRow98ymxQR0ZV?=
 =?us-ascii?Q?B4CnC9m/911uJwdqHZw730lVDBY+iLOOKYkeblF1alv+lOxYnM1dd4+yD7JC?=
 =?us-ascii?Q?HOGzeA4pinxoX6woh1UbWfBE24VTbES9fggJHYGkSZvcc7SatBkfDpD/0nMP?=
 =?us-ascii?Q?zK/yCqYWy7YZN0MOz4ikN3a95lAvsDyFvrPCzgR9n7/zT1Y0UTQoJsSefcQr?=
 =?us-ascii?Q?aGf+cMbA2bbpvLzM0BEmoZsFoqfs9GrZ6H5l0I/WGbefLnh3V3btC8LKmGgH?=
 =?us-ascii?Q?oO8Gzkx83y+K+h8n0PWZW5xqG7NM/cd82vgDOLRCdzxLLgif4Xw1I1WITL0C?=
 =?us-ascii?Q?3KgRtrw5ggV7pHNmEJMNCP5Ki2mftjZOqihYVnRwSqG/QUz6NrRXVw9dvKZW?=
 =?us-ascii?Q?8eGcCDRzP/CbZ+usHJsGB+6R9Vo4n6QLfDHKrtqIDNFXPECbiDzIVm1D4R54?=
 =?us-ascii?Q?6FbsBrAUvWKw9qOU2GFxrb9/iJnj9qcdDp5eWGM7UVnkoJ8YbvzlCqbxeFmr?=
 =?us-ascii?Q?RypX3EXEWMGbyWJMTSTLS23veSFZva2oY8S8/tmot9AvLWBBu4CPK5rYflte?=
 =?us-ascii?Q?08BUFQYiKdBvZf//aaSOo9v7T6jAYLlBa1i0MYvf2RWZXocBQGJtK552Wsc7?=
 =?us-ascii?Q?UR+8mghmvAJKI91I8uIVaRo0orEyY5AFCkIwXdC8+rkCjZqVwvbigc6sW9L2?=
 =?us-ascii?Q?hF3Y1y9DUlwe4szkjHgQff+aD3RimE9dwFdsGDBBlJPuSSA2QokqW/8HG5zc?=
 =?us-ascii?Q?CuRAXQSa2WhQ4Bl/BDtmNooHJ+3wmTGP8oQjTsbc5pcX3vckUW3Jv6dMlYCw?=
 =?us-ascii?Q?Z3fOgaxN5ibqsBIERJ33mt6+5wOFv5wl15FUi/6+NLAhw7WtgeJR8z5Q8DpN?=
 =?us-ascii?Q?+myxftsGJf9dGaQX9sukAETuC8ElH0ylaVSkcYgHiV2VIr7gZ3yIBqiL4ANm?=
 =?us-ascii?Q?TkMecx8aOHZRdJwOWwSWpsZouZNrHz3yMP3e8efCpDN0fuFMq4z4AR+lxBHD?=
 =?us-ascii?Q?q3k9p7QEstzww0BRAVhydmd8GgBETCFvWo8PuiwSFgc9l9bN4t4dpDUevK1x?=
 =?us-ascii?Q?qZnBPRTKzBkHiM8Wu8VECOLeIH+ZTrHCxufje7rp7qa1QKmBa0JXI/PWmQP0?=
 =?us-ascii?Q?gIEb1wK+HUTUqoRg+wDnNMOaVcrWpyK21bCs/7a6jI2RofydiXW7DYyMTUn/?=
 =?us-ascii?Q?U9k8UeyQ9c8pU6UY1SesQsPTBlydvKUo9pLeq727Fn/f8YgH0ncbnfqGFgxP?=
 =?us-ascii?Q?yJaj5IDVcK8D1sQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fOZSrEsgOsFhfEXWsuVPHyueMJH5sthj33JmKehzi5odLhujOvSiiXaf+EPc?=
 =?us-ascii?Q?AdoxnL/bi2wtGvjoZ9TQcwoVkhfi0sCirx6QFJJq6Gt93d0vqQOriAuCDn4g?=
 =?us-ascii?Q?mDRA7Jy8EnMyMptfqnwQopXM80+CAhk97g4Vb9sRnfeQoBtkXtISgFKFz/xH?=
 =?us-ascii?Q?KZtUwfYbE0dwmUqKWfdX6DsUf/54dlwXCaMFP5jlb4f7biZApydPX3QczCDp?=
 =?us-ascii?Q?PR3abW0JaUw64rupPWG6UO11whkZ1Ynr4BLpb+vBNcBAUStTBRsWa6SjQL5R?=
 =?us-ascii?Q?dpDhoP37rlBMl/1MYlvg6bEOgC2Sh3DPx/F/ItKXqP31DZB/E1uJNJ5UfjOO?=
 =?us-ascii?Q?o8UUasB6pyRtKSJj8LPF2cG4EquA33bGPmFNk8QBqTv2U7ARX0GjpYAx4PIg?=
 =?us-ascii?Q?B5rOjHNC+kOwK8PknLqap3126WSPMf0d8OtOhdPqawG+mkpXWDWi6EmJY8hb?=
 =?us-ascii?Q?6OjIBvlBCiGg5gfrMs5zPgGA2iYVb78M3XYVy2daEn2V5jK8tIAOF3IP1kks?=
 =?us-ascii?Q?EfwFkSKpLHAQ8kaqRLPNslnVNE9vpnX0+xRQUXKEe3tPX36yH3h9C6QLo9Lw?=
 =?us-ascii?Q?z29qtheXtEq0E67ob5/Nd9GUZrQHHchCceTzQ/jtkbajuUgSIsR7fa34bHhS?=
 =?us-ascii?Q?yBT2ZojLUKnj2uKfixlwNQKOJRHYAv8KC7M+JwS8kTkl4bjl21E8TtqI0v1t?=
 =?us-ascii?Q?cNzEX0aictFOgSK4ze0j5yoHRAMHLUqMwSW4v+lXHS6QpgrcBvMkHKp/mDfD?=
 =?us-ascii?Q?WH0o/zwoaht/WKZBmlWsCCuhj5E8hCMqB1CP/l5aGz1X/KshaZr7QA/x+edY?=
 =?us-ascii?Q?JwU+1Sps4wDoQVAnUQG/Zr+Yjckm1wtLdxyR8F2GQEPibJPK50aBM1rcetfX?=
 =?us-ascii?Q?My4/Tl4+ZuMTMrBUdr740Nre9CHEX9QeVeprU9ntvNbQZ9Vcns2HJbienU1X?=
 =?us-ascii?Q?+G64+S7d/qXFYRdhBmSytwLekLJPrh84bDQBogz+O0LfMmTzSD1ZX6CcXX46?=
 =?us-ascii?Q?l/TmXtmqwN4qTKBcKfDM4aNKTylDGOfymubIDJPutu9mOyGk1qCaYNRwqaOm?=
 =?us-ascii?Q?9CefouCvfWd+leDRtL3cHAjf3+XjZp2Xe36o/LKwXwEABmS7ekx4GS1gW2Pt?=
 =?us-ascii?Q?RVjIajoRgd26rAuWbzLZtDUEmcqxcgkSHhZRE74GA0wPmor5IZRnWHpzaJvq?=
 =?us-ascii?Q?tKZAANvqD8M7LoVY9NIQWOuF5/HH40Ekc1U2bwYMqUy/Wo+MHczDDzdJTn7F?=
 =?us-ascii?Q?sc+FnD4QnnDOsdxsgSZLssl4qQ55iOZX5YkOUl31q6CQczh2Dfmt44kASL0v?=
 =?us-ascii?Q?7p08h1XMhDkQdxXh0coWRx3cme/dvYlJzDhLSON+Y1xDrBsR4fkNXDSGDaLG?=
 =?us-ascii?Q?qjvELWIOuFAqGAsnZ5n74+mcglc0sg4OBjMxKer2Rm92ECdDFSW3ZVieJCMh?=
 =?us-ascii?Q?/LHFXH7xnO7LZilLCo9ZV7seesc/LLoI1nQUj2h72d5vfz/V/OwcNhOpA2a6?=
 =?us-ascii?Q?6yiWuYL+Cb9NfdubLkzMgOGQkeuDVHAifDbOCXGHD1vtUCxMRifiRGcOoJ0P?=
 =?us-ascii?Q?gLBDDpYte/85RBL/e6s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cf754f-6e22-4a3e-b4b5-08ddb352ec9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 19:11:29.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHvziQFnDQVvK0CpzWAQ66Ce2uifHI9p6mMSrzAHFvDQJRVmWycKFuUd8K0xI8vGs1IiOi4CI85yDNt4qYZiAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 25 June 2025 12:37 AM
>=20
> On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > Sent: 25 June 2025 12:26 AM
> > >
> > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > > When the PCI device is surprise removed, requests may not complete
> > > > the device as the VQ is marked as broken. Due to this, the disk
> > > > deletion hangs.
> > >
> > > There are loops in the core virtio driver code that expect device
> > > register reads to eventually return 0:
> > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> > >
> > > Is there a hang if these loops are hit when a device has been
> > > surprise removed? I'm trying to understand whether surprise removal
> > > is fully supported or whether this patch is one step in that directio=
n.
> > >
> > In one of the previous replies I answered to Michael, but don't have th=
e link
> handy.
> > It is not fully supported by this patch. It will hang.
> >
> > This patch restores driver back to the same state what it was before th=
e fixes
> tag patch.
> > The virtio stack level work is needed to support surprise removal, incl=
uding
> the reset flow you rightly pointed.
>=20
> Have plans to do that?
>
Didn't give enough thoughts on it yet.
=20
> > > Apart from that, I'm happy with the virtio_blk.c aspects of the patch=
:
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> > Thanks.
> >
> > > >
> > > > Fix it by aborting the requests when the VQ is broken.
> > > >
> > > > With this fix now fio completes swiftly.
> > > > An alternative of IO timeout has been considered, however when the
> > > > driver knows about unresponsive block device, swiftly clearing
> > > > them enables users and upper layers to react quickly.
> > > >
> > > > Verified with multiple device unplug iterations with pending
> > > > requests in virtio used ring and some pending with the device.
> > > >
> > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > virtio pci device")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > Closes:
> > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > b474
> > > > 1@baidu.com/
> > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > >
> > > > ---
> > > > v4->v5:
> > > > - fixed comment style where comment to start with one empty line
> > > > at start
> > > > - Addressed comments from Alok
> > > > - fixed typo in broken vq check
> > > > v3->v4:
> > > > - Addressed comments from Michael
> > > > - renamed virtblk_request_cancel() to
> > > >   virtblk_complete_request_with_ioerr()
> > > > - Added comments for virtblk_complete_request_with_ioerr()
> > > > - Renamed virtblk_broken_device_cleanup() to
> > > >   virtblk_cleanup_broken_device()
> > > > - Added comments for virtblk_cleanup_broken_device()
> > > > - Moved the broken vq check in virtblk_remove()
> > > > - Fixed comment style to have first empty line
> > > > - replaced freezed to frozen
> > > > - Fixed comments rephrased
> > > >
> > > > v2->v3:
> > > > - Addressed comments from Michael
> > > > - updated comment for synchronizing with callbacks
> > > >
> > > > v1->v2:
> > > > - Addressed comments from Stephan
> > > > - fixed spelling to 'waiting'
> > > > - Addressed comments from Michael
> > > > - Dropped checking broken vq from queue_rq() and queue_rqs()
> > > >   because it is checked in lower layer routines in virtio core
> > > >
> > > > v0->v1:
> > > > - Fixed comments from Stefan to rename a cleanup function
> > > > - Improved logic for handling any outstanding requests
> > > >   in bio layer
> > > > - improved cancel callback to sync with ongoing done()
> > > > ---
> > > >  drivers/block/virtio_blk.c | 95
> > > > ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 95 insertions(+)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c
> > > > b/drivers/block/virtio_blk.c index 7cffea01d868..c5e383c0ac48
> > > > 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct
> > > > virtio_device
> > > *vdev)
> > > >  	return err;
> > > >  }
> > > >
> > > > +/*
> > > > + * If the vq is broken, device will not complete requests.
> > > > + * So we do it for the device.
> > > > + */
> > > > +static bool virtblk_complete_request_with_ioerr(struct request
> > > > +*rq, void *data) {
> > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > +	struct virtio_blk *vblk =3D data;
> > > > +	struct virtio_blk_vq *vq;
> > > > +	unsigned long flags;
> > > > +
> > > > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > +
> > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > +
> > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > > > +		blk_mq_complete_request(rq);
> > > > +
> > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > +	return true;
> > > > +}
> > > > +
> > > > +/*
> > > > + * If the device is broken, it will not use any buffers and
> > > > +waiting
> > > > + * for that to happen is pointless. We'll do the cleanup in the
> > > > +driver,
> > > > + * completing all requests for the device.
> > > > + */
> > > > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk)=
 {
> > > > +	struct request_queue *q =3D vblk->disk->queue;
> > > > +
> > > > +	/*
> > > > +	 * Start freezing the queue, so that new requests keeps waiting a=
t the
> > > > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> > > because
> > > > +	 * frozen queue is an empty queue and there are pending requests,=
 so
> > > > +	 * only start freezing it.
> > > > +	 */
> > > > +	blk_freeze_queue_start(q);
> > > > +
> > > > +	/*
> > > > +	 * When quiescing completes, all ongoing dispatches have complete=
d
> > > > +	 * and no new dispatch will happen towards the driver.
> > > > +	 */
> > > > +	blk_mq_quiesce_queue(q);
> > > > +
> > > > +	/*
> > > > +	 * Synchronize with any ongoing VQ callbacks that may have starte=
d
> > > > +	 * before the VQs were marked as broken. Any outstanding requests
> > > > +	 * will be completed by virtblk_complete_request_with_ioerr().
> > > > +	 */
> > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > +
> > > > +	/*
> > > > +	 * At this point, no new requests can enter the queue_rq() and
> > > > +	 * completion routine will not complete any new requests either
> > > > +for
> > > the
> > > > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > > > +	 * started.
> > > > +	 */
> > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > +				virtblk_complete_request_with_ioerr, vblk);
> > > > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > > > +
> > > > +	/*
> > > > +	 * All pending requests are cleaned up. Time to resume so that di=
sk
> > > > +	 * deletion can be smooth. Start the HW queues so that when
> > > > +queue
> > > is
> > > > +	 * unquiesced requests can again enter the driver.
> > > > +	 */
> > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > +
> > > > +	/*
> > > > +	 * Unquiescing will trigger dispatching any pending requests to t=
he
> > > > +	 * driver which has crossed bio_queue_enter() to the driver.
> > > > +	 */
> > > > +	blk_mq_unquiesce_queue(q);
> > > > +
> > > > +	/*
> > > > +	 * Wait for all pending dispatches to terminate which may have be=
en
> > > > +	 * initiated after unquiescing.
> > > > +	 */
> > > > +	blk_mq_freeze_queue_wait(q);
> > > > +
> > > > +	/*
> > > > +	 * Mark the disk dead so that once we unfreeze the queue, request=
s
> > > > +	 * waiting at the door of bio_queue_enter() can be aborted right
> > > away.
> > > > +	 */
> > > > +	blk_mark_disk_dead(vblk->disk);
> > > > +
> > > > +	/* Unfreeze the queue so that any waiting requests will be aborte=
d. */
> > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > +}
> > > > +
> > > >  static void virtblk_remove(struct virtio_device *vdev)  {
> > > >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1653,9 @@
> > > > static void virtblk_remove(struct virtio_device *vdev)
> > > >  	/* Make sure no work handler is accessing the device. */
> > > >  	flush_work(&vblk->config_work);
> > > >
> > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > +		virtblk_cleanup_broken_device(vblk);
> > > > +
> > > >  	del_gendisk(vblk->disk);
> > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > >
> > > > --
> > > > 2.34.1
> > > >

