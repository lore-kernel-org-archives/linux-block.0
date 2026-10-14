Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81101E9919
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973525; cv=fail; b=mk3izui+CwuqJ2Zx/xFZQEkIfhccZTMBlfj/DcqO2lDituCOrMwzgpyUzHLJn3fI/p71ShKD48Hph4lSdBcjqGtq5ULOSw1zLZAnywVWtisnhKR1Hav/z7CvqKtzonjLOHCrTIdRoCTE92ITSGKsE+xlMicdvAE0HwmSrEsvCnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973525; c=relaxed/simple;
	bh=j+WHyV877kMfMVNVsl6hVG42Be72kRDVexLIeb2JKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evWDdJn9St6At02+/S3a9voO+yI5ZT9IcSshRT1jXPL0NV+XU53uj0WBaEWIGq8qZq/f/VdVqjez+8ODz+jvZVtYuq+a2gKPCZYpGRxH5H6MABJLsCSZVHYH1apHi55xX8ZN/pyzxMJQOVimPO1z8qOHpDn6VWFSqcXcs2QPlHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Mv7PaGG+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kZpLJSka; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mv7PaGG+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kZpLJSka"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791973530; x=1823509530;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j+WHyV877kMfMVNVsl6hVG42Be72kRDVexLIeb2JKwM=;
  b=Mv7PaGG+/tqaM+Ykr7ZfgsV6sWQ1Ul+LPGTwax2lmHfmfwXyR43u50Wb
   M0fW3pIlWgfeMyR2YshyKU6BP2DfSl/ePgxch8e/wdufQn600xm8miFa4
   bQ9nUmUx/aq7crE2Y5enqryM5riPDIyJxtWWqNRx2IRKCAbzkUhGLkLeu
   2KHASjnIi5kI+LaXRxRFdZ4V3A+JqwolzPAQ1GGY1zvyxTJ64jpiKEE0s
   UZJ6UgagcVdTkoVCwbmDdv9kQ7U0Jh/tVOAvpxHkST1Wj4x5bJAvrtqm4
   ZcEHqeqVAGKoblXeZymITPQxfV8B7rC/erzu4n/Q229RHqU8hvgo/2U8i
   Q==;
X-CSE-ConnectionGUID: eOTUpPHVSTCvT3TDZERoBQ==
X-CSE-MsgGUID: 6KSP8rfNQ/aURq5UuJDeHA==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; 
   d="scan'208";a="153845500"
Received: from mail-westus3azon11010061.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 18:25:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5bQW5er1MLotWtneh+aFf5djx/aHJ5bffgYYFpTfZoYjMPmInE6ayb0lJIEmagR7pFIIlhVDrlwvc1uivjZ9pL1MweUR8Y+tItCp4iyfTAnWQmO5p9S2HtSBA4m60dBwDnLnrVhPAAtu0d6Fbh9vL8dy9Sndx/vrdXp0Vmdd5Ac+sJU9+MQYiJi4APKVyMjcV0h2lVneptGZifFsB+GXcNWt0klQPo3RFUxDMpdOBPFk2zhICuQtMfP+GTP/XevyDuGlug9bVDaeYVZx0horYy2g5BxujBi8iFpxRRYsKJjyJYJz0u6JXjUMOvhpmfiLa1ebUlw4nSTRWKRo9K1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eCfazOEQXee8iS/XTQZ178rEcitmyJLUYZd/vEtP6w=;
 b=AsajZfS87jsDQguhpjCz4yZqT4VsO9KcCaXeZF/2WaS8Q8DUCzKGLugk5ycNZq5jFwJIX7Nt6DM2URqCp6KDToDTGe2Jfh9Y6jZTuNfU3dXE46P+hdgVkMRji4o6qE/COnOwfoUtrFUIwMdBVAx74+qwQRB8US8+dmQ4Teg1JODz3ddgqdWYyg46txOA5NiRGQRT/ezYWUcTT+FHub/6b01j3U9zxxCZLlsuubQgTH/wTgG1quQkTC63KqEwPf9m5Hcchgs7gtd+5sRHgiy8aFpq5sWIfOLju+B0qBaZj39+c4OVXdu+QwWbz7XVlAIfiCQPJcCkT2TKOAH1v7aqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eCfazOEQXee8iS/XTQZ178rEcitmyJLUYZd/vEtP6w=;
 b=kZpLJSkaxBNs9SGxYM+6TdH4enWkf1K5vt3FRFzfQGZjYf9eDSuDR5hA1FlWzZcjzmW907pU2/A+bZbFC8NeKBVeRyERt6DnL8TnD2q44gw7Dh5MQcrs+WX3LhRV3HZn4PNMJWAz0gXaSI2c4rzc1FoiCGUuR/bdTGXzN1RqupM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH0PR04MB8177.namprd04.prod.outlook.com
 (2603:10b6:610:f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:25:22 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 10:25:22 +0000
Date: Wed, 14 Oct 2026 19:25:17 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daejun Park <daejun7.park@samsung.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/071: test reservation preempt with
 multiple hosts
Message-ID: <as9W9E4gkBjhZ9sK@shinmob>
References: <CGME20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>
 <20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>
X-ClientProxiedBy: TYCP301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH0PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 539b7ad5-9fcb-477d-ff6b-08df29dd73ef
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OBfVLpE96F5XSe2BTBB+uK/zIZ2+yWMCCb80wCv0jkdCV1p9NvBcyT7E9gSdvLJDqPS+cA60txFa+w5sBfn5B/dR+9su26DpYw+YaQF16/9GcV3iTaJOD246D02/825q3oD9aTb1tIABxVbvex2U0gIDKsfh80AfLE8rTIJAr3yjooxaNTGIbHTEi2ln67favUGznN+Pz+l6SpeJnkBJI6Nf2dygOjjAv9iyu3hL6kqVpokmXSnHXYLwXvi5isXMi3QEmM6vBZRF0RAa8llSkJAq8QPGK1HvHNPluF60YaNq3zvnPnv1uiS8zCju51Xhmq/afEkGF6Pu4l9T9RAPJQzXASX4grx4nEl0RAjKx4mPFMmNPUUx0z9svK4xGmMPqwTqnkM4cFgfbnARNyzPWyyV1WiJgdqWmI25hW9rGRY/FtGKWoPj+vPryB6nolgcjLVGpuvNSYjmj6jhNkJnuU0pnmwCtr8n426cM+3iS1Op6O6uTvWJmn8wTQQzGFsVBwLC65iBwz+4WVeP34hJyLGfl8rcCgG9Z5+NCzlJ8NtPWwFVCBq53R3cw4IGAtxjV4M0bSd0BKVPYI+REA6oh1J8CVp3MzmQUc7f/yhUSz5pcus9moE3koJCqo2lWwR9psbHgNptoh3aeo+fQ7OJGrNyFw4N1HxWtwo6O+BgL30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUtf0kw9zIezdUnhe+UZLZgnpOcoojFeLw0003Vg+orShc9Y41auyJSLIDiF?=
 =?us-ascii?Q?yTshLTvPLyDUdY0oo8Csd0p6TRS0bJM5BNO+ip2Qe+VwC5hbu7eq/cyps5Vf?=
 =?us-ascii?Q?TFpc3RbgKKK3TpR96mLFQT7xFKEMH5P8jmVNfl/aX2RivLSnMS7aIiEXvO7m?=
 =?us-ascii?Q?m7rmeIocXI93sb25HyKBfrsq4xREUI8tTKpg7H5BGvHiH0mHS1t7/qf3DM0w?=
 =?us-ascii?Q?fBbbSDanmUgjEVzOyaV1bRWsCiFNEVqBoOjsO/QpSPf1seKZS0F8T9X27MII?=
 =?us-ascii?Q?Har3gjNElf/4UcL27EdH771qiQOlcRdPDBnGgpDHiBn/Fy1KGL3Wz2cI3SqU?=
 =?us-ascii?Q?cP9lqT/DDiKe2r/tyOtli222MgU3oV/Mg5XVp/UKA0340d1QZsFwWcnU8rxA?=
 =?us-ascii?Q?JNzo6JVFAP/uVPmOfoeEUzrVYSfrIJZU1Woj5cNLkpSj7ySkzp21WrXAWHNO?=
 =?us-ascii?Q?0e3RqprK006ZDcvawf//B9DJsDF84FQraqlSEFI2BpksoRGXzF4zOqYKdiAp?=
 =?us-ascii?Q?Ha5S8sBiZ+j7W23akFsfq0+UkzdgICIGHrdkKULe2HW8KVu0Ta2d3rnUuWuP?=
 =?us-ascii?Q?aqoV1Jgq+nZL4OwpntgU4+L2i4e+9Atcr0CLRAHUC7FrWB5qSvmg0WyHfrFe?=
 =?us-ascii?Q?+8IquZrStmOs2gxqtEzl6EW+7hYHFobIjakKiGe9Hl6uLB+aiXxlqKlLAxYP?=
 =?us-ascii?Q?A8yPfVltymOFIn3hi69esVy2mpT+SHCHasG3nihzkY/mJUjt9JKKJq/z0mLG?=
 =?us-ascii?Q?fTEc1oZy5JIVJOpSZrafvksJmGYikxJiuz8MI4+QDcUbqYLuJ72OvNOzXK+d?=
 =?us-ascii?Q?2geGJD2atGjxHEUWHsDEquem994WZRhKagou4icf7+f5y7gk9tw1MmwQ2iXW?=
 =?us-ascii?Q?TPxU5jMzzY/2uLR+pbHFHtcIm5hDrtpIOGtDHgyh+tyNJmEKohK1iOOBmnsg?=
 =?us-ascii?Q?p8bcUfzF5+2BQI4L2CO60WI96MLC7mGJChsbN9nv77OJSBwDnjGkqyZocvmY?=
 =?us-ascii?Q?1/27yevYu6mGqKN6LL2v1vy6lk9TwKGicwHXrtVr4ybPKOvMBMUeq7WeJnad?=
 =?us-ascii?Q?SfkJ9tn2GLemxpNLUfCTY0y3oOYeUPwZw8caEvZwK8pMhR/M2deRpXx4QkbH?=
 =?us-ascii?Q?lE0VSWKp1L80ci2W5WeI2rSCKv9IUdgc0ChE02QayWHx9iKZs0Dtst0cCxVl?=
 =?us-ascii?Q?BH41r5EQ461uB3WE67A8BNwNFPPa44Hh5gFjbi587ZuHdHEnEfCPsxB1FA8d?=
 =?us-ascii?Q?qm+4XmKhiOkqXrNNodNbS4NWVgZM+yeh3OS6yra1rHhyfJLH+CzNvNSnQ/Kt?=
 =?us-ascii?Q?RRXD8Mf6Doqa11rwgJoEXNEtFdt3S/qMeVrHJH5j190TT0B8SDHEktjetj5D?=
 =?us-ascii?Q?QNlJUKKW67Qqr9C7H9ExYhB4YUCIlmGm5/U79tZ4IrHTYDJBG9F1u2+Um3CO?=
 =?us-ascii?Q?cwZaIlmkLCIyIH3Ys74gMFHKwU42ImncXNullOGcuKGqJV1iiPOHNEtHS6d4?=
 =?us-ascii?Q?nFcRdYL7K5dUTKV/+4/EXIZOejBcFpqe6+W/VGLurarkOtZBXJFUeFl6auTv?=
 =?us-ascii?Q?vc62j3KxxqPOsiZIXLfRxqOAxh65S3BPXBW45zuzwJE9s4KBrpV2NougO964?=
 =?us-ascii?Q?LzZEk+dkfpAcYlycydi1WyovCqFN1VkcSqAdPNE6rlwijZYnR+WC083i5wHG?=
 =?us-ascii?Q?b1yo+0oCDBv2USsMno0vOGRkGUZfZ4V/Wn5iE0uuLYOGeWg01AIdWs3YXZg2?=
 =?us-ascii?Q?JVg03ZEY9oJwlfX+5VzjYPUwSiwavIs=3D?=
X-Exchange-RoutingPolicyChecked:
	aLA2jYkWFLdcF5Ho7fohluEtqEgZkUHCmuEdXkfum0buq4EKN/UzHTJ0UdT97CgJ9HvVUPH0pnVMFE029ImIzlHOmqWvFIbel5Grz0YrL0gqqE8hSnIIf+09Z+rRMg0FzD9yhc34Y9YnY6TcCRM+n0aMZWNRcjCuifKN0Pci+rcXxFb8YXO4DVpbvbjNzelRyBHG0eIhmSQQLljHep2LKbACO2snq+vYQ6mZe5A9U2U+55j4INsPcaCMyZNpNbCGXLsCd89Un8EBtVj/TNQemBCiVqqK51GGK06RRPej7Rhur8F7D+OTnDmIzx9FKNtPL+YJqbrgQf9fjr7yEP0vSg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xVkvQWX9/BaNJuVlyJl+33JUezclUhr2dB2NHFFVqPWpnQlKj1VtOYSruOcqokSlmETr8JNgyTbzrWQsUnvoZ2VZkDMzasYIAKIFpMPTtu6mu7sS3/sn+mwjAybAseUAnmMypepSpZ4IzPaV9Ugsvvw0Xn4H93efB9IpfrtrhtU1rqYQmklzEotl+nm+vBDGzymRvyEei21D2qI0YerGF9Z7ud+evjqyARDe5ErHxn8Pqps12swUfaot75IYCdTpX0RFDc1Dmi46+NUTbOUMPsQW9sfIMapRsBH96ePbnosvMsyz5u7yv7Vms2TikVg7QGcPtgsB6By5Gjn1SypkHc7PTo3MKc2kxVqdjO5zl0Asvt0uWDcLPmuUfM1zDyeD8jOLnnNP1YEku/XSz1QxqjEnIlEOPwJKMnUiHieA2uHr2HXYFonRxSiRdl5bBVubQOXXGfkysM7w+Eyivx2mAVmXwEYCIl5jNBgP6hbm1XOGt/ggTamn3LNJH91eMn0uc90l/YeFQ3xo+CtDzUNH9uV1m1sX9xGwWHo0sZSozHjKtzacPHHbNojrsPJNWaotJNE7Hm/sOj/5FguWHks47hBqGvyXPLrmwG+qyLMIIU3SOzbacUZqq3sFIfKV0/H2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539b7ad5-9fcb-477d-ff6b-08df29dd73ef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:25:22.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDz9CTQNM/gB/EDGAZdNv1y0u3Bs0flakJxYmM3SMzJBBS2Caq4xQ1Ty94N07JwRbprDsSDVd0ObmIuGChl8WchzQ7baYLAjikaiZhPKmsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8177

On Oct 02, 2026 / 16:08, Daejun Park wrote:
> nvme/054 covers the reservation commands with a single host, so its
> preempt step can only exercise a reservation holder preempting itself.
> 
> Add a test that connects three hosts to one namespace and sends the
> Preempt and the Preempt and Abort actions of the Reservation Acquire
> command from the reservation holder and from a non-holder registrant,
> with PRKEY set to the key of another registrant, to the key of the
> holder, and to 0h.  After each command the test checks the reservation
> type and, for every registrant, its reservation key and whether it
> holds the reservation, as reported by the Reservation Report command.
> 
> The steps in which the reservation holder preempts another registrant
> or sends PRKEY 0h fail without the kernel patch "nvmet: fix preempt of
> another registrant by the reservation holder".

Thanks for the patch. I ran the new test case and confirmed it fails. Also, I
confirmed the kernel patch noted above avoids the failure. Good.

I think the patch is good enough to apply. Said that, I will wait for the kernel
side fix patch lands on the Linus master branch to avoid confusion by the test
case failure. I think the test case number 071 will need renumbering. I will do
that modification when I apply the patch.
