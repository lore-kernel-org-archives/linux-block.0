Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4935E93B
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782166909; cv=fail; b=Z61RwXppS0uvNVSNtRuhedDaOcWN4bqbLuu/lOLMFAGowBLeFYqwaYpOsPt6l7DPEJcVNijjHPTKJLKPMJ3NClomq7YxzBcrYWhzfhc/z8C2IzW5h/HKzjy+0roIX8Efpa0gBn69j1Ij4/8Qgo7gi4ZSG55kuC9U9NRT8/KgtKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782166909; c=relaxed/simple;
	bh=NNgiJJYOefSFgG6pKNQflkzjltATAE744unMsVectwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BgQCrV7RTOzI8O2Mc6Bj7dNgJemXe0Pz0ArnB5clooFPjdqjia6j6VG0wyNzfsBeia+oUHICuL7ASNUcXwMELiQ9LPCloadTgTClixlo9EW2yHBS4b3piASJflOV3My5zQUpvt6PUkLS6DZSYwiexe4a8RZjqhXeVVPo/h+Qeos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bnMZsMUz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kgkTmj7A; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bnMZsMUz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kgkTmj7A"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782166907; x=1813702907;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NNgiJJYOefSFgG6pKNQflkzjltATAE744unMsVectwE=;
  b=bnMZsMUz7/uSFXrtXrRxVMhml7KimNUi6LyktnUQgBnl9/7qUWJty+X3
   o+0Q6KWC3uEL/nbp9iv3SS0QyJmWB/Kjcf36OE990UvOmjbywcT9jCzjr
   2kRjcEhR6eFLPVeB2rNAZPj/BiyrpguDWNUhT+ZE8eL5ger3W7GCwHgyg
   93+CNQd94xfgilClZPpkgMPgt7p0LER7HZSO/X7sCu0YP4jUuzDBlayNy
   tKrFH5E5p7ReWFEyQIJPSulSG7XsaZ/gUsQqlXlmj/tZTNQuRSfTwCFAQ
   34fiz7WH+khZLWurdCn0C7qDeLISHQc3Q3hKSpynLIGce95QmTcZMEiiJ
   A==;
X-CSE-ConnectionGUID: c6HHqiPRT9WFqzfKFvRwEQ==
X-CSE-MsgGUID: sKm8WMIeTtqP8Q1LbPOFkg==
X-IronPort-AV: E=Sophos;i="6.24,219,1774281600"; 
   d="scan'208";a="148112119"
Received: from mail-eastus2azon11010056.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 06:21:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnhQhQG08P1gOZEtpL13+lQeOZ880fCva+bJQpstfGU396LYIdMc3jLxhXb9+tnuVWQJxXb0nrMUdPDjbrtmzKDqtuaQbkvxPsLF4cVhO3bdl/oxrqHevgbWdPa2f6X0xvKQIKUvgOe+W4JcLGr8uumGl7kVnf7ZtUq6G0iChy0j5L4rRb6kdSc1pIjE2srBJK05vaE/T/4zLTqTjYZa9c97mG6gQsoco5ejWDYaGG9K/Hpz3pX8Xb8m8FHkXs5kSpItNSUw0wUejVrH6W7pRASfZxZO8uBPNjGR1exBTGu2j1R4NXtmuXFpZDNrHEZtZMg7znsndG7dp08ubLzKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl1jm9z5nIaNDQSrWbYg2/iDjo3FJlb6cwNFCMzZdZk=;
 b=rfmbqj3vDWSs9kKAcJsTZw0YbKYhe1S+w2A7CFfMtp6vgSQradMGUc+Ivr9ZGXsMK+88GnpLWKY/mMmNrLxKEZuWnZvr88aAcHUbndlP0x2ENka62955DOQ2f2+zppQ99Ic429d+XF2EG9Edvv2l4mMLw+tlfJMELpipmNz6i1E4z5gLVqn3eh3+/8l1jv86OLwDwYGPm0IBkQbb7e2Jsy/Oq29HXNXgbAYlOwy/oLeuSEAZR6PL++DmyTVucceipd1z51NP86sVQiEAmX3SjKMSFFsTg2gNrYQJ2MSsb0isiVwdoajMTWqWq1Uha/0zrjUZVqanaJ3P0TqUIjpD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl1jm9z5nIaNDQSrWbYg2/iDjo3FJlb6cwNFCMzZdZk=;
 b=kgkTmj7AkgAKA18xQbgwMfjZybDw3zaAkHGQsHYhSXaTTiv6FgLJRh2PVTRd76wOJTTFc1RY7/Gn/TpfqrbEkR+JohAy3BE2d9DgvgcCigUY2kuuS/7KrdXw71ZVk5nmuih1Lc9eEVFDd8eDfzROJ+oNS5Xl7IDEEcTQPysp6Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by DM6PR04MB7129.namprd04.prod.outlook.com (2603:10b6:5:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Mon, 22 Jun
 2026 22:21:43 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%7]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 22:21:43 +0000
Date: Tue, 23 Jun 2026 07:21:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastian.chlad@suse.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2 blktests] src/miniublk: switch to ioctl-encoded ublk
 commands
Message-ID: <ajm0FkGiQU_nA6U7@shinmob>
References: <20260617072516.6238-1-sebastian.chlad@suse.com>
 <20260617072516.6238-2-sebastian.chlad@suse.com>
 <ajSud4Y4PmCu2X_5@shinmob>
 <CAJR+Y9K=0C+TnKAycdXbeQF98FE=RhaYYvK6SCpLPbdeMH2Xxw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJR+Y9K=0C+TnKAycdXbeQF98FE=RhaYYvK6SCpLPbdeMH2Xxw@mail.gmail.com>
X-ClientProxiedBy: TY4P301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|DM6PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0e15e7-2c93-4122-e2db-08ded0aca364
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	W6996L/SqxHnktYKhiqpaW1ziZOmO0c9PDCfo/slY/64M272w1+N0PiAyAyUmYwHYoEREY6BktoaIzAMyfY7E3xf18W0boWFtDWaJyPw1WczbDdGFb3dKvZGWUDE42iJ1/4kz9paqqzAq4LZO8bFOsc9FDpRjo9SFkQjLntaHnQoDqgHY6DeUQirfGlw4MnGIUYKZFoxRvh0HZVT3GvUtiBhUWNPFsic62o9+LC8nvJppwMXCC7K5eEFLQLi7/IPzlTm1TBThqdgeBlhjGiQcfq3bkk2hVempCfXWhtIxNgttWE7aAJuDBkPlX+ytl9J4xMM+Pc1tFjeUq3QksqTyzN0ahglG6jrwHTQEIT+aANc7+aOP1t96qPLdRVWG+oyTHuz93B0qngwnsis0RaKIBo0RbHobxV9OXmpMdi9moIMX03nu72F4StMEkEqYmN0tP0TUv1ZEQBQBwZLc2L6r8kdSMeYttqUG43hv+pgl6K7dpgFRmN2ZkNB0LwQbKNjd4tpgpnMdnPodLo93/0+wvDjJNpBDtCvyaV2bm9tX9xPAdKLIowkuyhUM+XHVNpGdf4a9o4jVw1CJ4K6P+lzxgv1yv2SSmpHS26bkboGR/6LxrYUcUiHGdtXxycg85+Qz+b+HIE5Geucs4/cowhZJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?guyH7w5BrvTkXtk2ikx4cpjM1t/WYKwTh9PwDatrg10wwBpGbO3O8tu2MAQH?=
 =?us-ascii?Q?4MRHgFjHZCNYDW01883NhCMQMDf+IkuSQVu7UIt/wDVv4M5HMFR9Evhb30XI?=
 =?us-ascii?Q?jOnyLOKxiGB4ArgtLF4hbsjFMj/U1tgsOCBREwfUefHyw1ntmBc9e/TkHdl2?=
 =?us-ascii?Q?5nhwj6O9pqPOQOCTUiitacCa76SzDmdomLMLhpfJAdrCerLawF9zmLDTdybG?=
 =?us-ascii?Q?2xk5bG4MwNihP4coGKf3hZ62qKoJjPSUqPif+9Mc51xBNs3OFaRj+UHvBLF0?=
 =?us-ascii?Q?3r6nrm7kFKx1Q6667la94WFqM9HNi4zF+Oa92iuHtZhUkOEYOhp/j5DKxRIZ?=
 =?us-ascii?Q?ReLZqy9zXOvAoCCL8R3lJU9Ffqk40AXiEARhkCOKp0J5Gy1Gjw0S9qHLGUA1?=
 =?us-ascii?Q?l4n1Wt7fNCzpssCjS4J2yAiAnTMItVUH8mBV0aumgEcn4MXdVlOCGLaC0+rW?=
 =?us-ascii?Q?24ZiHov14givdpXvwWEyvjY6r17Mkm+k9x7O88D0jZ594iejaYLysfWBL6Wu?=
 =?us-ascii?Q?KvVkzo8UJ3Ri4cHs0ThTsERf6auUtNm0xQ92bRNZb5BfNDxlKi0DPJwp3ZsA?=
 =?us-ascii?Q?lvk6WKTROS9LA3iyGPIY77lHdugKufTdn5nnCQzht456XP948m8tbmPRFepo?=
 =?us-ascii?Q?7r+/F5PSbuyHmsCLlLqtZZZMNbovfbp/Le/+uAITD+EdAF8a03T/rMLhb2VL?=
 =?us-ascii?Q?rimjL7MLFoCT0nFugVWk4Hw6PkpJYXD8JTiHmGXuHor1jEDiI18MhGfGZ3Ns?=
 =?us-ascii?Q?/FE5BYoVyKxyR3zVNibaXwJKSjxUWqveveZbWbMF4xq7gIz3xpBs8EP4iO9K?=
 =?us-ascii?Q?njh4huq5BZq0oG8XhOTJOFyhj9hyC7X+56Gx9l7vbV5z3dvSvWLbXCt7bhZf?=
 =?us-ascii?Q?KwYfY5LJDL6pWiXOPorsVRGN9dCEx9YbOivXiRymxxM6VQG0fWlKQ/fspaF7?=
 =?us-ascii?Q?4PjFqUqaMpwGYW7jYmvs/3AxPIF4l5I8DWuTArzwisyL2tI3oOfiPrgoX9oj?=
 =?us-ascii?Q?qydGD7S2tn6XsHj1kLuh4d1OU+MsjEIt8Ipzt86xg3+1cbJ3UsQfndHKiDGW?=
 =?us-ascii?Q?JdLvKwmEpL4HZlOH+h81bFoVv9prUOMAB+U40aDsLbtFMHy18/3E1EBza5qz?=
 =?us-ascii?Q?uA6V33WjiBCxsrZcnRXu/Iig1lI0HYFHDt9MNfJeq9wHOUSxGO3X0LueqzN1?=
 =?us-ascii?Q?MHQxGxmwRqXhOJJVI9gPvgLk0YxlenxTaoTSm7beq05RiZPE0OJU8QVnG5jc?=
 =?us-ascii?Q?cn4/7Fy8gBoBQBctksS2IXsaRjMcmZa+J98ZFLkUCgYShXY9tEJPVQZe6xgO?=
 =?us-ascii?Q?P1+g/5DA8AjgHIPwiA9rX+JTCpFsHvgslxZ3HQ7vDMvFBQQqvHEMVUMI8tfq?=
 =?us-ascii?Q?rWfxI5BKxdYjnJy9HGcrZGvcyduXFstRSPChuOxNddrlzXRenXcZdFk8fI1K?=
 =?us-ascii?Q?h4AL68FSbQ0pYUxQNgwDdimV8lQCEZHIHt/cvSaby5LMH5UZ6gjcW4aPZg2e?=
 =?us-ascii?Q?3hM7Ei0J5bo+UrckrrbOJ0Js9FGzuhxsQOH0OgirA0yN1n06cKvUhXdHdEzG?=
 =?us-ascii?Q?oz8/Xc86DoKtCpXebjWrE8yWqrjJf7V2VJEDvz39gS4atgXTBKvrKbGBoPpc?=
 =?us-ascii?Q?VN4aklJNlkjh7SkBIfWzUS3ZskEHwlQaxk2fA9tleZWhdoRYNCwZ1ABDwpA5?=
 =?us-ascii?Q?Fqg9viJF8ZlQih6TXn1q3Jm0BOySJY7KEQ6F4dtXDlqv6zg0tKD9zmbpKx0i?=
 =?us-ascii?Q?qqO0mZofZppNtiQjXqvryEuULQhhHzU=3D?=
X-Exchange-RoutingPolicyChecked:
	llQrbdu5Nk+W3GgexvP2SosCX7r5JXstxKmNbuYJndaW9nBSNyeq2kDxCacGnS0ArSq7zp8WuRtnn2MtBT/hOvgqCvmBBA6ks8x8JPpD6zSjYu7cq71eC9sG9LHjlKUNyrE5x9M5g7avvriksSNCGW2421EaGbn9G9weQ+gWRJtHfjxnK/+CJuLzXBwZ61jVw4I+ImMgXaW2aSMLSx27VCv++i77pPGn8JuRakOCdPPVfcMF33UxFNW/lfEW1q7NpwkDgJa65zUNChHIkCVSY3OoWN8hGYFmpuRBt6MIB1ocx2l7o4EG74U/sR5EIgpnFDinQmQUZI9dsfMbQX/AFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IkU5yAGxsQODMyY8W6oaenWFULYCOHZBO6scYLr5tuIYc5Gw4dPQE+4lBpyt6D9hLLCzSQJsxv5y4A+GUCT8vnPvu111v1KO1C9SYE4M7VTYu7gOoh7OIKhflKl5mQPEQeb+2+SmZVNtsgVTq1GFdRaFl8rl9LOE0wocL5Ipc6iy4tgmhPukGZUoKzUnTN9fGXzQd+0FhW2fXdEn1GKM/FGYIvDWta3jGDKmKj9iUIqLeOdrL2LEY8lGNYkuet0VV+viP/gWYQfGDxJIHUu+X+bwv19yTugHm0hJqPccUFEi6mYtJ9oSQdpXdLaDguvDmt73OsLVUKXuf/ZZb1JpQwy+XpALRDEqe5RaZ2R4lJ0YRonlCM6syE1TgbZwpp+muo44Av8OR7K5rERxhYH2eMTvjgSZTD/kuyeZ/RSA4SpNPDkSYlA5ygIJnJ9paZrfRkRfUozBHQs94d7ytDRV1mi1STVwUYMBm2NSAm3w5RATJDVZXw7zI+o+kh5Y7BjPhiCzHmw2DiQZEntGRKOuNOqQs8BkmWjWdP8/0Y9M/TAsFb+gnpypCxTdETNnAp9xiBW4BMoFpor1JNSVaBZ//ooidzcEZH3Wg+o1Vn8EtyM53ODz7c9qDKqIjsElK6mR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e15e7-2c93-4122-e2db-08ded0aca364
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 22:21:43.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIeoNaFke7u6KdgOqT9mQvnQmqnfWgPq3w/sG9tzoJBloP6QyAfIOjPp71Lb6iUe4PMerqFn6UjiNW454MfvkPfkllnylrI8zrKvG03kuQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7129

On Jun 22, 2026 / 15:34, Sebastian Chlad wrote:
[...]
> > > diff --git a/src/miniublk.c b/src/miniublk.c
> > > index f98f850..5a35ca7 100644
> > > --- a/src/miniublk.c
> > > +++ b/src/miniublk.c
> > [...]
> > > @@ -624,9 +624,9 @@ static int ublk_queue_io_cmd(struct ublk_queue *q,
> > >               return 0;
> > >
> > >       if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> > > -             cmd_op = UBLK_IO_COMMIT_AND_FETCH_REQ;
> > > -     else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
> > > -             cmd_op = UBLK_IO_FETCH_REQ;
> > > +             cmd_op = UBLK_U_IO_COMMIT_AND_FETCH_REQ;
> > > +     else
> > > +             cmd_op = UBLK_U_IO_FETCH_REQ;
> >
> > The hunk above changes the "else if" part, is this intentional?
> >
> 
> Yes, this is intentional because we already check things in
>     if (!(io->flags &
>         (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
> which returns early if neither flag is set, so checking the first
> condition makes another check redundant as by that
> time we know we need UBLK_U_IO_FETCH_REQ.

Thanks for the explanation. Now I see your point.

> 
> However if you think it's safer to still check if io->flags &
> UBLKSRV_NEED_FETCH_RQ, I can implement it this way in the v2.
> Let me know what you prefer.

I think it's the better to keep the current

  "else if (io->flags & UBLKSRV_NEED_FETCH_RQ)"

form. Even though the change is small and will not affect the code behavior, it
is against "single purpose with single patch" guide. Anyone who looks at the
commit in future may have the same question as mine.
