Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67545135A53
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729883; cv=fail; b=UNprsArq5Rh6vI7roiGL5lIWghPwAsFwI/sc6mJ2rZRrE3/WvmIDAxQeFqjuS++kUELtCsOHhf81wUlYL1bdGs/J/6QCIudIbbAz+w2wk24neXDBMgFGsWyT0TUJTnzIxlVFtkEeKUIXrE6FwaxbQi/DgL2DfAy2bquqsI+kAGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729883; c=relaxed/simple;
	bh=frtI/j+oR53xG8zPNGqPYYuuD9WDpPn0nx1IA8pwsXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qS9DrpayB4pAU2rASvDq6w68Hh3gPu2UOtPNiVGFsdiHF9RtKQZa5mTMejk9MJ+mlBC/zejZhnRWwHPeQlPVpnZXM3PmPENb/xoFAGPAFSrGNdlRnik6LeNRwKSTUkSSRTBUcfX8hQ2Db4q3UdjWycs40IPINb1zbqBLGtHx08I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LAgIzd94; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAgIzd94"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHtMnc5MPlPEnB2+InSEcZQoemwENb8rMAn9hXKonfgKpaUtIlV3rIAbn4VTSFFPPRlHkB5vxUjT9jkGqyLSs32zCPUly0OjDWcbq68+tySt/H3zMbnq/UGhM4npowHBC0ymiXqVAIisGO1+cX8rw+EvY3SH2KDiC3YPaR79WjnACbReeSF0yNgt1ewjl28qf4ou/g8j0HtDXrx+v0YQkM0+t4J/jlKVwLQ5UdbRZQb8xY5pXQldCBwceGIf6VQUUDAfobaG0dTmUCOdgzA2K7Xg1LZiXTW0GE2Fvo52a3j6FnA/bepuC+eVfBuvtFxgB9aPqCFG5Qft1/jP2eyLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frtI/j+oR53xG8zPNGqPYYuuD9WDpPn0nx1IA8pwsXI=;
 b=mysGfgwIBGWRWnETK8nKfs/1BIs34a81NOddkIr4jfN9yegNSM2YNTLaCGgL122WzoKEZ7B5aqzAqS+dMZFoN0ODXLxarDco5BawLlTsIXgGG3Fny7shet6lySkzylDZSnCuyY0G1jSqrLj0Fxx/jJiTyz2LRPPt7jT4oX6fotDeW1DPSO7B9sP1gN4C652BLnvJ9p0NVkrC8P2pvobVElAyxRoaFhY86OpOjN7NP7mzDRf4LCWJU8k37S/kBvDKFWEADhi2CyiH5P8MYGywAD2tZPZQm1wZlvJWKR//1oGeB7Ptrtx4YFKAUyLkzxgXLc5doObhDh+96El6bJWcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frtI/j+oR53xG8zPNGqPYYuuD9WDpPn0nx1IA8pwsXI=;
 b=LAgIzd94X13htj6GpADofRoIwqNaBcfRZa1Txx1Ouyo0cT0AcxoKRKlRfEp/pYPq6ep89rfEz1loLnsmvgpHZEZ6D+BSZi5y2Kbgba2xKNl/DcZ2mw0siuF+bgRtNhCHq5mwCk8Xtep8yL+VqyIu+icV5fJJoOlYKf4p8NcTGx/9D0UP5LJv0aIg9IPJbcAYfOEp1n98gjTsi+TAiNDQWaDNDr++YfTVKv6C/wp4wn+GAP5HvNlPUrijT4xplvqGt2GakUi6f99cVKQszKgbcvL4RF+qLZIlQIDVXNxoZGOSyIrsExNKPl2dhg/DvdTG0UuW2sRxSpzhwjZ1yD03dw==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.40; Thu, 12 Jun 2025 12:04:39 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%7]) with mapi id 15.20.8792.034; Thu, 12 Jun 2025
 12:04:39 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Uday Shankar <ushankar@purestorage.com>, Caleb
 Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Topic: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Index:
 AQHbyzeSSRaVFqTPg0GnAQDdJHQew7P0ldE6gAFlm4CAAxP3QYAAXvCAgAXfTWSAABDtgIAAK4nt
Date: Thu, 12 Jun 2025 12:04:39 +0000
Message-ID:
 <DM4PR12MB63285592EDAA9C03DB1D6BFCA974A@DM4PR12MB6328.namprd12.prod.outlook.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEK6uZBU1qeJLmXe@fedora>
 <DM4PR12MB6328BB31153930B5D0F3A3C7A968A@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEWfWynspv75UJlZ@fedora>
 <DM4PR12MB63280BC70C29A91E973E8080A974A@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEqanYVjHgVOjcwR@fedora>
In-Reply-To: <aEqanYVjHgVOjcwR@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|DM3PR12MB9325:EE_
x-ms-office365-filtering-correlation-id: 024c7573-01f5-4b66-a004-08dda9a94f1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vtPceGZHXhDZivzlC9uVSmj/NLUkEgjcZ4ABz0JAZNKdUCnI5js6ARk5AWGq?=
 =?us-ascii?Q?9MoTwlUCJGcHurdT901Y0ATWYDYdIrmiX7GmZEe1ayodJvxVWl2nEQbCGip7?=
 =?us-ascii?Q?vfcxJQYo8gZVfd2Pg0XP8EySIQXqQ5AoY1MkdJAiOkbEg73SI1SC63QjHh06?=
 =?us-ascii?Q?L4i84supMDbTR7yIL3ibUAQ+FU7Dc2PKkUouAlFxHqZfNI02j40I9//d3d12?=
 =?us-ascii?Q?JN1ExRq+17ZWDq9VMFAvzCN87aYphwLPE7/IgnHmzDC1c47APnDgepZQiaYF?=
 =?us-ascii?Q?J2uA31WBIYam348gNyNtmCFa57rDnoZdj9p7R5XfbGdhxj5F+5iJ/onAlWwZ?=
 =?us-ascii?Q?uSKHw5TgGAM2s7eCKedeTmzhaECVmeZX+0oRznBpZNyuIiY754nRvRv3Nq+b?=
 =?us-ascii?Q?vT6mZBAgNEtJzTjzGm5BsVUZAfo2e9jG4djJzUvfJAV/WR6x/WpbbEG6lY3R?=
 =?us-ascii?Q?u80Ydsbnu3t4+1jBKTOmG5Q0sMEyp8Cae/5+cmGp5hvDKG89idyavf/ITOt4?=
 =?us-ascii?Q?Te36R8yxhokhhy2rVVUTeIj47VbcWXleksS2Fh1U9xVmHAGLRNIvACo4vJ5u?=
 =?us-ascii?Q?sk9MbFEbj5oMmDKH4ImL6SSegKXfndi1MCNkmvlcEMejgzJKsbStjYTJp7u0?=
 =?us-ascii?Q?oZTNadmft7vKsxk94yw60/tuJSD/QJQL/W5hV19HqQhmnp81lkow+yReTV6b?=
 =?us-ascii?Q?JwXj3RYESVxOmTzwPGTDpwsak3Qj+Ds+RjrYrAYk+1ktP/pxCwr/bbDQPO3U?=
 =?us-ascii?Q?SuN8Y2GRA85Lg5YctsJKs5jrqbCWyuYfBJ7CnxgPKFxE1MzFaKkRIDRaui5j?=
 =?us-ascii?Q?gmPqgbm57hgkcewP3fvD9o6Lc+EqyNB6yQEMz5/Y5PZyHzdz+ZrpMW4r9Yha?=
 =?us-ascii?Q?wY2GF4XpMvVoX62QdkUWjtgBkCnDYRNODPHYby2DuLVkUUKON4QiYL503b2U?=
 =?us-ascii?Q?1VAf7/NPMEBuWbp9PvOhZ4iAiV23faed5cy3Xau8TQis++xEYknORXN9lf6N?=
 =?us-ascii?Q?LLGH8Wnx7D5PDARB4QsNKp997iNgP10D1gRLygWe6S8WjaruIvXoo6/O0Bcs?=
 =?us-ascii?Q?Sj+CZ4l7G1b3hV9wQGtMWXugvA5gRZ7Dj3a9/STQXi7kRKZ55qLlPpBGXSwn?=
 =?us-ascii?Q?sazDcBB9pqG7S3ZgtTemsU7zL3nhMv0DM9ui3alOrBiDqf1hfhP5wjrDINK9?=
 =?us-ascii?Q?fPE9P3Ln9bdZrMgmsLy+yVBUQ2w3xjSW1RDh+QVMGX1z+XUzxpK3tFzn9PgN?=
 =?us-ascii?Q?Eo/ORY0pbSv3r/6wxbohSHwEDYnfBDklx9JNHilWq6XqspBMLzgk/Hdww0NC?=
 =?us-ascii?Q?q/3bT0njMYdbzST1Ki84ZPY1uHesjI3wlMjuuiJTW///nxmgSV6XekMUxRYS?=
 =?us-ascii?Q?cUAdUsbG+ouVuYUYVTUEI6E8xpNHek4Ct9LCNb64+oPvHhQqZLFu+Cy14Zkj?=
 =?us-ascii?Q?P+gike/Z4GmHapaFhFbglWzgSGT+PV475ewDBg0h5BARKgCVHbq7hA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8H9gx8YkYVkTm+z87BmkSUNst/EB9uMZZ3EOxHutId+LFm8IutVnMqHfBGF3?=
 =?us-ascii?Q?PoTFI9HuI2Z9rqdkN+3Q+5jONqcoecsdK/G5XOPngQXzUzMRLrw7OJvtQWBE?=
 =?us-ascii?Q?fy9aBxZPbKoIJtNgn7DXLb8EIHeajIU+W7kb51Bc8w17gJPKY8hWvKf53WsY?=
 =?us-ascii?Q?OEk9L/ah4pigeT3SAAnU8qDJSooaWGFNfUg7OXbjkmXlzSWAY6mBduu3edWQ?=
 =?us-ascii?Q?LL4HUHEuueTDuVWFn8JjU3BpANMSG/8fcEvpgTChux8XqxekgtD9aluqg4wz?=
 =?us-ascii?Q?3Dw2mcUbvuFLy+PdYruLgV0wkSR3keZCBJp+uic2W2i+hittd+cb/5wtC7MD?=
 =?us-ascii?Q?i1LcCkEmgJp4rQ6P5IXM25JtlEapI2rPqlnUGPUjsORH3U/MPmkTZ85QGCsb?=
 =?us-ascii?Q?cX5sMF8keTxAglQbavGEGZcyls4Zsvc4OTz8XsdCAzWCPsB3R/9hiwsqXFRf?=
 =?us-ascii?Q?S38D6EFV62QlgXbODfyHcJe6yg71CEzfy6eUUaPkC3zmijGUrADd9kHQKJjr?=
 =?us-ascii?Q?sit4xNicr6L33QQPK+je2bbQFIt9q9eAEcNIRBFYJ6gqKuV48ykZrlVz2zcC?=
 =?us-ascii?Q?/da/bN+5NvgBUPOJLkA5tK3pALD2ouNN+vSR7+xtNfyysLxW+UpQBu58s4w1?=
 =?us-ascii?Q?fwn56aLBD220kOWp7MDlFxXizNpZG/F9bm92JlsZ+y4HsoTclsuzvZk4000l?=
 =?us-ascii?Q?sOIbptkHsTGLT0TVQYi3Ia6/ZlYJyfxsx2ATgteeuxBnxOQQv6No7nsoVUaG?=
 =?us-ascii?Q?yxNDR2KANlLIWFGEDzwDJzKbIPxDSqXsAyVkJMjxdiqUkeO+AUdBC4n1yDdD?=
 =?us-ascii?Q?mWaT9F9vKi7K0pLtQMN9gqD6elZ/CTH4dIvyooEWQmjfQrsrLw/55Keo2rUm?=
 =?us-ascii?Q?JDL2xnJhHqs8Nb6Ejsp1Y8Pnx1DSVhsrhW40oZuBxYWpwslWe0d+ho+OpaDo?=
 =?us-ascii?Q?vFwS4axDIy/0CKMeSogNk8tCXw9l6h1l3EbEB9nuiY2REvmfZDr1h3nDiB+H?=
 =?us-ascii?Q?JPgK3prpSj1BSBI/DffWzL9bPSW+HXwpSN13XcRBLZm1SNmF0AFsFrKcecRm?=
 =?us-ascii?Q?nTF53DmGzZbxHYP5Jtoa4HkYxehwFHBf5ehc3KBSEqWsWLcFsdayyDS3deqO?=
 =?us-ascii?Q?dgP5aPCT2UInmrOpyZ/6JLhuU+/OTjEMgJnEzrvUFxcAhfkfVZZQfj7++N9h?=
 =?us-ascii?Q?5m/De0n70FouLwrB/J/4DxtvUr+6sEdqUwUBASEkRZOkBT9RQjkiR8jrX2AJ?=
 =?us-ascii?Q?GIY9Vsvg3V4EbrlCzmhqdCFo2EAYyi3Wn8Sv3sOnI/WMlueRGCMMw+3SPqDV?=
 =?us-ascii?Q?T/8xfpX/liPH60E9dAkl6AWkmK9hgjUIn11Ur8XDT7jh1iUYiy+8PN9y5BwR?=
 =?us-ascii?Q?P1U4sxsisbNBsJIZoDIMj3HQdXN+POGdmjD2oTRDr0czRVacbKdJdkGx/+V0?=
 =?us-ascii?Q?/cM5UxtKNKxhO9503s+ATF1U+LQFyldGKHA9otY78q3q4lOCLV37SovctwF1?=
 =?us-ascii?Q?x+ZSIGgnBdUir3NFMWL+0A8RBkAE9KK+w1YBF4k7J4RM+s7JIEPh/w4ydUsJ?=
 =?us-ascii?Q?9eX+diyHa8HTbNXzoXc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 024c7573-01f5-4b66-a004-08dda9a94f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 12:04:39.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eVipB0ulw7IHa+V6WRLgMHBmpdlVcPXBNAtyRPb8wt2ybv/ajjPHqPvNP8gPAIg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325


Hi Ming,

So I know it's a radical situation but my only concern is that:

0) On our application timeout of IO may be set to few minutes as it is goes=
 over the network.
1) Let's assume we have 1 queue with QD=3D1.
2) the Only IO is in the userspace application but as we send the IOs over =
the network it may be stuck due to connectivy issues.
3) User trying to upgrade/stop the application so we issue Quiesce_DEV with=
 infinite timeout as we want to ensure it works.
4) We are stuck now until network connection will recover or Our datapath w=
ill somehow Issue the COMMIT_AND_FETCH back to to the kernel so it we can g=
et the ABORT later and QUICESE_DEV can finish.

Problem is that I don't want to wait for this IO until recovery but on the =
other end I don't want to complete the IO with error to the user.
So on this case I guess we can abort the application or something but maybe=
 it will be cleaner that on Quiesce_DEV will need to issue another SQE per =
queue or something so we can notify the application this way about it.

Anyway also on our case it will be super rare to happen where there is a qu=
eue without an idle operation + network is currently down but we try to be =
complete as possible.
What do you think?

Thank you

________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Thursday, June 12, 2025 12:15 PM
To: Yoav Cohen
Cc: Jens Axboe; linux-block@vger.kernel.org; Uday Shankar; Caleb Sander Mat=
eos
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE

External email: Use caution opening links or attachments


On Thu, Jun 12, 2025 at 08:17:49AM +0000, Yoav Cohen wrote:
> Hi Ming,
>
> Thank you very much, I managed to integrate the feature to our applicatio=
n and it seems to work perfectly fine during our update tests.
> Just a double check: when UBLK_F_USER_RECOVERY & UBLK_F_USER_RECOVERY_REI=
SSUE
> and QUIECE_DEV was called - does any IO that will be completed using COMM=
IT_AND_FETCH with a failure (i.e result=3D-EIO) will be retry after the rec=
overy stage?
>

UBLK_F_USER_RECOVERY_REISSUE supposes all inflight IOs are failed, so
these IOs will be re-delivered to ublk server after recovering to LIVE.

So you needn't to complete the IOs with -EIO for retrying them during
recovery, in short:

- if ublk server handles inflight IOs, complete them by sending COMMIT_AND_=
FETCH
with result before closing '/dev/ublkcN', and these IOs will not be re-issu=
ed
by driver after recovery

- otherwise, just ignore & discard inflight IOs, they all will be
re-issued by driver after recovery via UBLK_F_USER_RECOVERY_REISSUE.


Thanks,
Ming

