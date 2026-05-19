Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020139.outbound.protection.outlook.com [52.101.195.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218F312825;
	Tue, 19 May 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159027; cv=fail; b=icCbsqLJoBaG0DJ11Ee5KaTc/gkqkxIjdhHfXYuWAId8t8XegX1z1sR4C4O6wLQNd7+Ofk3nRR4Cv15bG+IILhg+2p1jNtGiBvFiKhHhfEnCUjU7ZRC2hEYgBY0ElrHkj/qiURfqX86c0Fc205ttdXBJ1BpSP8dcikjjMeaZDS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159027; c=relaxed/simple;
	bh=8gzyF2UcB7D2H4w37hXTFVcFhc57ygfH8DXZc0Fpngg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QZPqRVuOQvhHKOB+Hxq9qGdzNCBdiDQNHYQ4VrY61v2PidfAlunIQNwlEO4BMukLEC8ttxywoc93LTu3a9h1kYlMZHpoK9wIu7pYHkuztQCZCsvMeMZ2csVPRuqjtTYZX6ZRyuhu4oQqRheNscUr+HzJwvvPTVyRlTbi5R8gidc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOnASJ28H/s/JVZ6C+0o/WCsG39NO/cBg+OUrq59GehSo9LVydDAe95Ba86t+CV7oi87QuKMiKCIt41XVeeaXmlfSr8QE23HewOJRYGGJ0lHtXpgHTbAj80pYAGsmKFv5juHkPlzGxeie5xsCAnBmGU125vbft9jbQ3Z8G6rgQSN+AAQVV0x98kbqyfcKw2sWOU6jgyChCVd4IlgYRgygmK92IosxL1CTYFV1jiUQiqPYS6vBE60/tNDgRG3TRAuIGUrjq+YHa75v+jBo+dFTAb5xbu9RdEsYFBBjLtXpx/e+5WQkgCgYXRngpFrWlMLWlXpyJwE9D5cjwJ5u+ju4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gzyF2UcB7D2H4w37hXTFVcFhc57ygfH8DXZc0Fpngg=;
 b=GYNgDB72gUdz6b1qS2m4qgnox2AKxbZ9KPjGt6D7qrUUvrbPjZP2Un24Pnm3vHCRugK97CWO2y9CNjtrKVhNB8EBOs8iKCu1FseVLF/HSnzORp0xkiga7AIHfy649Qt7ItSe0w+gqFeJehMjKTCL3U+LP9TuYgs/YfPusNMkwcmSblaydrnt2nMhimnWtJlzRNR1JntVQO+LXBG73TCwtpwNqet2Wqt94y3hEfd1q9Ow9XbwFpuljEzeeBX9QSmQ2sor3m4QW+osAm20E3d60thj94nF286LqXOlxetvKeQMm5uJeCgGWn/KVAOM+CoYD/rVZrsrl3CnLjYlAt9nQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6857.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 02:50:21 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Tue, 19 May 2026
 02:50:17 +0000
Date: Mon, 18 May 2026 22:50:13 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@monom.org>, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, 
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	maz@kernel.org, ruanjinjie@huawei.com, bigeasy@linutronix.de, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, longman@redhat.com, 
	chenridong@huawei.com, hare@suse.de, kch@nvidia.com, ming.lei@redhat.com, 
	tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com, 
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <jts6gcq2pjywiwnhojp3hwrl26z26igsyqfl5a7dst5fkmwseu@haf5dmjrtpsr>
References: <20260513005509.135966-1-atomlin@atomlin.com>
 <20260513005509.135966-6-atomlin@atomlin.com>
 <3af2cd18-1221-4ff6-aa7f-6dab74460eab@nitrogen.local>
 <bovevvg2n77nzdrvjkayca2piibjl4noykv24wthex7em4u5lo@beqyhu2xertk>
 <70b4cbf0-9137-41de-881b-ff2a60f084ec@flourine.local>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ubccp6puy3dx7d2v"
Content-Disposition: inline
In-Reply-To: <70b4cbf0-9137-41de-881b-ff2a60f084ec@flourine.local>
X-ClientProxiedBy: BN9PR03CA0732.namprd03.prod.outlook.com
 (2603:10b6:408:110::17) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a69756-b8f3-429c-0071-08deb5515c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	/VhbNAmkIGbFaeRIWQm3TVteczt6cHADM8X3lzfsAIcOkhaarXwjXqdNhZ+w1flbV4zxtWRzGw1DkXlA5jKb+ZyB3x2dllJwFeLdFX2QqnycCXkhDHFj0jZWyLLz2nQ/8m4apT9KgScCUwWeSXOdsWVKxmWcMCdbLP718zf64YXAOTDKBGY2/JZ7+se8Fl+rRPvtkUDdJBDx2DvbWQzlRrd7+xadQHNtLSeQ+oEdVvQOVmYWP+t35O+iUflFM/re3nDiKD32M9GjVg5SBw7ZZcJjHVfgLhVNQ4iqKRPrgLCkEKwNMv2YWHorc23EBH+oF08pmoA0ASG6jVYfyxYKprg386WQNPvsEsXdVKTk3cmOtwqvkzSBi+BMA6Po966z82LrB2JUyOpLw9gl4p/LlKShQ9IKjuhiftUB4Y/VcfbWZK1xl2YLNXmRdIdXCu5aBPXDcugqD8XEfFdg7Nsll2YNLdsDqVA+Fd4pl4d0JSZjsRp0PdyMyFq9HT1ooZb5vgxb7DOM0BZ0LUmUPADyOxCkoLduvTX31sUkPJR/iZBUZ6OX+bDYM63D+EQRnG+ealPFOxrL1TUBlEbx17xSfg7KfYkA91bOAGlIvO08mFCrIuCZ+AKueRoK5LoDzz3fMgEovXDlMXyGqI3rSqcAMY+zYihUHf6bC7ebU0aMwBd8D8kk23PY7C9qdSrtI1lz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OURkWVVzK3Z0TnBMb1lIbUF4cTM4aXNacEw2eWpxTlVXSUdzMW92WFMrTVBH?=
 =?utf-8?B?SXo2K1d2RjA3TEppUkNtNmtaUTFMYmU2bkh5NGRwb0ozOUNmMTk4Z0RxWnI0?=
 =?utf-8?B?WWx1M3Zqak0zWk8rTExWbThMU1FvODFVOUhmMEZJYS90Q2hKQzJzZWJuQXZp?=
 =?utf-8?B?bTBhNFJGN3JJcXZVWkhvcE0zL1VPdmVhQjRuMGlNL1U5UnA1U1MyNjFsTUV5?=
 =?utf-8?B?M0xUQUdWSzB2T25hYWhWa0dRMXk1WVJUU29IbmJkTzVCeDBoeFBtVTlsQ2k3?=
 =?utf-8?B?em5QQ0FXWnI5cVFld09iR0dRK2tDMlRBK3JTR25uZ3JuK25ndzdYZFp5OEZS?=
 =?utf-8?B?ZDEwdnJYNXcrMTkrZUY0L1ZlU1ZYU0JwSUVLL29mbEdxenBtUzA5R2tqYWlv?=
 =?utf-8?B?ZS9CQ0pSOXVQc01FdHBENUlUc0VQMXREa041UkdMMlJXeEN1TFpMQzBtRkpo?=
 =?utf-8?B?YWJOWm5Xa0dPMTBlQy9RQXZEWUZVay8rSXgzaUtaNitCTGpSdHRWeDF1c1NK?=
 =?utf-8?B?V0d3QVBVRmRqTDd6UjFac1dWb0xIZFY2aEl0ZlljREhGODNaTTF5WDYzNUxS?=
 =?utf-8?B?ak5nNjJnaWdNcGw4NVZHZ085ZldDNlpnNW5VdnJOaVRzRy96WlhpRWZDZE40?=
 =?utf-8?B?L0xnNDRITDFxaUJiY2tyTW9Oa3JhMnU2clhjYjMxMm95MkFJc2F0STVBQVBr?=
 =?utf-8?B?ODNjSnl6Vmh6emlpOEt0emdpcngrc0g0Zk1QcG5EcUhaNTYzZFMwN0tFRDBs?=
 =?utf-8?B?ZkVCYkdmdEVObkxXYVFKSWQyVXRTcGFlcVMxSlA5NUNzNWVUMTd3VFVVSkpx?=
 =?utf-8?B?TmJhS0VsM01HSy9zT0h3WS9VNVpsTDM0UnRYSXNzanhuYmt5TUNNTndiam0r?=
 =?utf-8?B?YWhhOXc5YlFmYm1oRWowQUlGRGVraFE3VlNDaGVndU4yY3Z3OWVNZS9IdFl2?=
 =?utf-8?B?dmNieEwyaEU5TisxSlV0L0ZVZ012VHA1UGhKc2NsUmhEYnQ3cFhJTnZ3dmJX?=
 =?utf-8?B?TEJQOUxncERhSi9LSE9aM0dDN0NKaFgvd2srUmRiZ1VYVDA0K3NMaEFGNXB2?=
 =?utf-8?B?eVE5NzBMYjlhU3UrMDJKVW1McE81b1BJbmRjL3BUOUNUVGVGb2hKQXhZMVpY?=
 =?utf-8?B?SXRubjdPdkxQVFJlM3d0QmI2b2tSdHJhMFh5YmhhMEx5NDdHMjBkRUc3aTdy?=
 =?utf-8?B?K05jeDQrazM4dG83MW43M2pWdnpUZk5DalorY2ZiNHgyaW5YK2p1S1hwWGx1?=
 =?utf-8?B?V0FNekVTTno0UGxiK2R6UktZQUd2UG41OUUzUjFUNFMwMFIvY3BMaDNjYnVs?=
 =?utf-8?B?TnNpOGFrMmNvTTNGN0p6WVlDZjNNYUdaT0IvTkRHaitpNkJRVXlRZ2xxRWpv?=
 =?utf-8?B?YVpxSmx6L3hZRmE1R2daKzcxVUM3NlFaRVF6Uzk4aXMycU5LYXhqY01YVzIy?=
 =?utf-8?B?WGF0Vnl2RDNVdGc5TUQ3K1E1WVNLTzJtNnlQeTh4ZEZGTjFRWGhRaTlkK2JS?=
 =?utf-8?B?a3VOQ3NOa24vdUNyOGN2cTh6Z2F3U3ZNYTlvcndRMFJJbEhFR1VRVDRKNC9i?=
 =?utf-8?B?c0czVjdnaXNnU2dYQTZ1VG1salhaM05CcmlvRHk2WjJjQkNuK0ZHaXM5azgw?=
 =?utf-8?B?Vmt6T2VyV2ZrYTdjZVNNajJYUDczakFzYnArYkZWdHFGdFVwQWZwS0E1SUk4?=
 =?utf-8?B?WEp4Sm9UbVRjd1o3TTlKZmhDOStmb1gwMFNBVzJmR01mOVNyTHkrVzNveHhV?=
 =?utf-8?B?eFRnWFE1WUpob1J1enl0OHphalNCVkg1Z1U0SW1sbDdVdi8zSVVKN3Z0UFJj?=
 =?utf-8?B?eTRRQk9MNmtmRnpXdmNmdU5xRGxtUUcvTllqT0lSQVhaV0p4WVlLdStYOWI4?=
 =?utf-8?B?U3RTTzBzU0E1V0h6RW54WXU4bTlEUmpYb3pkL21JbEY3WjZ5aDNLOGcwcm5O?=
 =?utf-8?B?ZVlLUC9vKzNLOUw1MExCTXViblFmSDE4MFJqMHdraDM0WnlUOFBPTXVuaHc5?=
 =?utf-8?B?c0FkL0RXS0FCQTdLVmZOdlVsa1p0THhkRk0xeFBZMEUyZlNYbjJvdks4WWhD?=
 =?utf-8?B?MEs3MWp1VjN0bWNCaFBZdzN0TThaQXNldlYzTHNoTkhpRmgzekw0bHU2Tkl2?=
 =?utf-8?B?WDV1WEZRL0Jsb3hKMTd6MDBRN0t6R05pNlFMMTRHVm9WeW9FR2ducU5PYW4z?=
 =?utf-8?B?L3lUQWxudDNkdUlVaXZGNFI3TnJZN0FwbzlxZ3QzK0ZXWUl1d0dwbGk2dVZz?=
 =?utf-8?B?RWxYR3dkbDM3NEtnWFpKME5mWXVPbzlsSFFZdHB3TnM4ZlZvUlA2cjFXRjQ1?=
 =?utf-8?B?UmVVVnFsQ21aanBQcXJyKzJ2Mzk0ZkwwUG0rS0s0QW5FMXZXZExLdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a69756-b8f3-429c-0071-08deb5515c0a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:50:17.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFHFnbHhsgiMAh/3GfARKe2Ugsno8hXruTGeDJSGvtJBKUFs9+jM+rfp+o3s9wn2s8RlH5mfX8cbK5KOTUfcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6857

--ubccp6puy3dx7d2v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
MIME-Version: 1.0

On Thu, May 14, 2026 at 12:42:57PM +0200, Daniel Wagner wrote:
> On Wed, May 13, 2026 at 07:30:44PM -0400, Aaron Tomlin wrote:
> > > I think this should also check if the CPU is online. The fallback sho=
uld
> > > ensure the system will boot.
> >=20
> > While I completely agree with the goal of ensuring a safe boot, I suspe=
ct
> > that we actually must iterate over for_each_possible_cpu(cpu) here to
> > prevent map boundary violations during CPU hotplug events.
>=20
> I have to check this version of the patch what is happening in detail.
> Originally the idea was that the fallback should only be taken if it's
> not possible to create a valid mapping due to $reason. In this case the
> system should still boot and issue a warning. This is also what the
> comments says in the function, pick one online CPU and map all hctx to
> it. Don't bother to be smart.

Hi Daniel,

Understood.

Previously, heavy isolation could starve a device of its minvec
requirement, forcing the block layer into this fallback.

The next iteration of this series has been updated to ensure a minimum
vector safety net. To prevent fatal -ENOSPC device probe aborts on heavily
isolated systems (i.e., where the housekeeping CPU count might be lower
than a device's structural minimum), the final vector calculation is
safeguarded to never drop below minvec. Queues will safely share the
available housekeeping CPUs instead of failing the probe.

Kind regards,
--=20
Aaron Tomlin

--ubccp6puy3dx7d2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoLz+AACgkQ4t6WWBnM
d9YMSw//S/dmR0MU/9vU8Z0bFpZ9MKUJ/YpICl6TS3j3Sk9HiswHEQ3cXBewTa8r
ca5LXxxwYRtQsceM0/ebVcA027UAoYPjX6pyrlcG5pWGOHgCyN+qWtPB7sGEOSbo
7vdcCxYwAyfSU5hSofw60PAML0kCDTnmtXLzUcNY+qlhy5iMkoANzK60RZv1eb6N
2bdp2HIE/hpbUdGRPtCv4JICrGKoCd+NtsidWPTHiaaMeupxR57I1eRvp8pIxttp
HFm3TpMFeH2dQIrLAryGvD8HW/SMVKRrETQ6mJCdJCyYRdjHWctM1mlYAMG2luSU
DuzKuNfVZzFACnTSIoCcL1YVTjZLMVHvn23BCD3GExtkhGv81BmYlZTC97lD+2Ec
N3FX9OjOtZbxXmq3MKq2AeFB8Eq2s5vYDjf1Sg7cbnIWiS8rU36l1U87WzyZAl4p
xzV0j96MQMDGFzDY5Knj6oaNbZ0WbxKB0XC2bdhQi9KIhd/DsWTrrgvuIScfcHzS
vtbiPGuiKaAM3NL0ZUxt9l3ODZFYR3Euf9n9C99RT+ry29ioMI0/bRpNtcrDdpnI
ByE8vXi1lCjce4+vqfon3ifQ/Nu6HfRmKPNGjdI7Y2kF5lNgmEs5v5M/L+VXyIL/
5+SNJBo2tpKDdFyyjRso541nDCQDa9tmiRhbmZfbCbwqOA36jPU=
=wLfc
-----END PGP SIGNATURE-----

--ubccp6puy3dx7d2v--
