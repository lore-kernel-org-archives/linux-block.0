Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED4A2049
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979061; cv=fail; b=HvRjGpT1p93iJS2GIN4m4QaIpVHDPneeZeGpLRhymxrgeGvzRYI+43hKRMvu1/yqlvoBM97DJpMRGVeUPCEes1Tyt0bQz3N1hSAEk+Kmh7Woqh43yA1cLbZ35fdhWhUU49zqoQ34VR/AgbeBUgmjPMHH42EgCASCALjwAblzf2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979061; c=relaxed/simple;
	bh=poCiv7kp2WmVNhdEumgS/OPF5KRdQrM1/yQUMk6EiMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFWRXZaNzKHH/HQ5J1qCBVYNcubHbWNSTHgKCFm/ucyn4Zp+PvWQYE9X2Tgsff6iF6S7jhPLiZtBhJchegJQFpt3Q2MP7rywNcMkl6bi/CkjnOPwN9A26vba9bz3JjrIuUg2tCVtsv5xz/QYyAzsdcW59wA3iZXU5WwZMdKt3/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QdNHVhyu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ctxpibvh; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QdNHVhyu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ctxpibvh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1791979059; x=1823515059;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=poCiv7kp2WmVNhdEumgS/OPF5KRdQrM1/yQUMk6EiMY=;
  b=QdNHVhyu2sso15+iWztvR+G+YCmP4g6JjKcwRc3DXVyJxBtU9iIg/mXv
   sgOYC0LdrFNKEshIy/Uc9VElCUfUUaeHdPiiiXPFAhpl8FF3GpoQRg0lc
   f/6YwJgd78nHIMIAROuEJ77KGXA8GrGJF1fbHQJ07oS0GwB5MkGuPskAT
   zMHmpit6IvTGbEqYdI+dzr8w6JywXAUc8psT4Xh6rjOPGZMXMMJ3v8i7g
   x31UWXmDqCvYOJBkGcmuwlDiP0rY2x2WHOGcYluSoM+x8Rv13QPrX4u4w
   hLxVnhodO3f3GdTjX11Fw9GntgCQWrnThz2yrzRaYNtzU4gVwslEU6Y5q
   g==;
X-CSE-ConnectionGUID: us50bQYRROKJvxQ1lN+l7w==
X-CSE-MsgGUID: W/YBZXe/QiWp7ipx3o1dFQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; 
   d="scan'208";a="156471825"
Received: from mail-westus3azon11010048.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.48])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 19:57:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn6ofVu9snkBghjb4MwgNA6uljj9V4Kb6zk7meMUfSdGmiRY/4tWueKLARhCiox69m3qZSIxBROeBCB2nTBMdmi3fSVNcvlLneiXsVAYttqSqGHV3pJlmTgNPiZQvJbd/dAJc29u/zvCRTAKximYy0jdO+7rFJjlzH6rlpZHNKFm9nBJZWXkZaRX9ycTpyzLPJf3wqCD/q1nbNXoqBbuGiegiQZpsDeKFjAXPlAhVcdZc/gzB859jBLW5dvbTv0DR3PLc2oGSgXMHA5HrKiANlSjgk8DrC/BBQZ536IkLl4nnO/wFqRazTn+X95+SheflmrhcSLOvVwPa1R4TLOoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRJvMlO4SlQGoHSuUZMTi3KSb6EbhTj+mLw/aMDromc=;
 b=hkF2QYHYz1DM5PJz6opkomeoQZjWmwzcv8ILcXCGHEiLbbd+uAy4sRgm1OB7lcMJCzsK9334g/dv/3S1Tt+Kns3Df/YC4GIGQQ5KwlT5PkwcGo5j95jq/Q6LMoM9X8vnxeXHC2JO23RjvpeXES6k7Xubqmi5GQoGW8swGZ6LIKI5nX4k/OM7ZNOCqSXfDr1Gkkk0KH9H0M0T10UJXotuVcVNKJnK6CXaLEFJR/EPueh4RbocAfCaRAdZ6TTmXB22AUDbWs/KZIuGKPK8dzj1fT23iGUUy3qTIoj0CRp0R8lMZprF6qU9Qpv0MdN6TpVhG+EhBzqLSyqgK0Ryt9+2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRJvMlO4SlQGoHSuUZMTi3KSb6EbhTj+mLw/aMDromc=;
 b=ctxpibvhMr9jhJqnCtSPs0bwVsdKSgzl+URE4Ar19dOUbpAqfZfoW+rK0iElqc9pIoyHkJS3UCYtBNIIv/44aUPZnUV01JCQQwzQORpljHheNCBrxNv41TG5EU2EVLChiRxNnlhgQhuD4hlpFBZM36HD5yO8/8BKTgSl6Sj0p4k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7693.namprd04.prod.outlook.com
 (2603:10b6:a03:32b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 11:57:30 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 11:57:30 +0000
Date: Wed, 14 Oct 2026 20:57:25 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
Subject: Re: [v3 for-next 0/3] block: delay support for error injection
Message-ID: <as9tTCdj-BP_88ga@shinmob>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
 <a99313f8e07b8eef09229050598baf914fea410a5b07ccd515822ebd9ad9fc29@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a99313f8e07b8eef09229050598baf914fea410a5b07ccd515822ebd9ad9fc29@mailrelay.wdc.com>
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb8a42e-07f4-4549-e1ee-08df29ea5352
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|366016|6133799003|10067099003|261009223027099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0jSNhc/TrXM6I3qLPQVdy8L/8dH0nwGJVZrpfOMaty7CJqMk1o+QlNmZ0VtQv4H2ZGIafTQOo+pBLMqxl8PyKo9HJw7YXYHe57ggC68eK/wyGJBekYSJLj+JPMDPCkEz+1wyj1+UX/DFMaLrYVSfy5AF1oq3HTBnGPTfPCO7Y/w0UWPLtuqc22a236ZlcTSDLUi7ii1EvV+ncMLprhyHZsnKyeVghuB5y41wNZpcM+Lbiq+oFfFHxsbHtkSDf2ypKjeCkNGl7rpJUYXJT4aOQZKAShVlmcuO2iTTNveW9bpIHwCrTxXAfIbVTYOUI7wfvNNb8Wr2u911E6945LLmeEuzvq7Z4FR1s20EjCsj9EINnL92764so1+QDdYZmIfp+myKNeyzsiVuszxWLeJn3LSGqJhNMR11Eck38stWsy+hUCfigzXteqwN835DA9blPVpCHw6bnZK0gxal/fmzOUdyW4EzttMerxRRG5Lks2FvqlYlSuAlSjQVw7S9SlKzE//H2apXkooRFhAD/visF0VZACiUTu8sjo7IJCORaaEeqIo8YQCpSZ0UuEWRvRLWJdN25gmapG9o1ucEj/IT8dYxluDdlpxS7bliorz7aEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(6133799003)(10067099003)(261009223027099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJwurNkibr7WeL8ZcWeGvQdcSKX+luXv8hF3YUBgaB366v8iTrfQv6Ok//70?=
 =?us-ascii?Q?8HG/1gSB9DTyOkagMQ6grIgqjeLlm3eadcO0qeXS0v8VFEPA6knE3Pz7kuFU?=
 =?us-ascii?Q?Q445VGTZQIMDAvVFW65H0u7PCPab0sSKX4Kluwom5oblNQDuzzDkCQFyfNFK?=
 =?us-ascii?Q?Rk/ZQ7vSf11WBaJ6JbseJqt/OiuNaUr2NEs3kNp1qp4eM5lFNc/0sM/bXW9/?=
 =?us-ascii?Q?TFgj//tYQeTsXaW4aQTuI7scI9Dy8RtXYbpgZejSGMhQi54phMNX/n02+/IL?=
 =?us-ascii?Q?pqSQGhpF21NMZ7Od1bbAtU3fIqZyn6cMGdXIS4sZlSt6/xRWZLhdyjQI7XKw?=
 =?us-ascii?Q?LxxV+Co04gt10UOBi8mFArz7NDA4Xt0OjootiqH4M1D+6MK8RTGpVt9ykhBW?=
 =?us-ascii?Q?mUlLOa5rrkOX9dmU67XrZJCjyf7KlS56G+lzTRNxOpFBo4AV9HR6aJPn8cE3?=
 =?us-ascii?Q?MvnUqlvZQ8hHBs0qEvIxB+BlFcOd/LJDizpYoeKAOcd0mC90gY6D9vLRZeNn?=
 =?us-ascii?Q?Dmis5sRWDve+/mZQ8zWlbgNYZbDcep0Cwku1KMjvv8i5qGWaWnLFm/S9ff8f?=
 =?us-ascii?Q?U3VzK+2DE6M8IgLwCAxYuzTTp9UoeemPlyxEZ2N71gpGnOPhWdZTeyCmg8Pq?=
 =?us-ascii?Q?1fnCa88dVxztyEtTjnxmagnZB/+whx6Zml4DUqnpzZgTFPPkac8BCS0dTDcX?=
 =?us-ascii?Q?vPyHCk6IEjNdiEL/JObJ+gZBG3qPIEPnMn9w6i/hKVb0zDMWQyzYOcmCjIwW?=
 =?us-ascii?Q?xfBaK2PC5n6mDX+r692BsY5MxrEw8m23oJl3EJO5kESnTUEd8ZFBEzsJujmB?=
 =?us-ascii?Q?ToA1BH6w+021olwXHo4yIqXJW3kcjwYZaEfJhL98MBkWI/GRsSDG2nsYXiiu?=
 =?us-ascii?Q?p6PLeogydTOqjyC2ESCA+YwGNaQuT6MhDdy5hTc3MCXcXPVsXp+Njlr4MSaP?=
 =?us-ascii?Q?lT/UwgQAT2yVKZ8odaVuawqna7ZwiQRroYNVctY+GEtMD82+p/13FHQHGcLs?=
 =?us-ascii?Q?2HYhviNcBztVLouH+beWIWrSyrurZEXlUPwCljVLAax2f5NDEnkYkvVG8YvD?=
 =?us-ascii?Q?2w4qwmOB7N4QjZoVZeDcrL5XQj/UDcmIpjb/X88bL8VfJkTnQL/euMN4Pyei?=
 =?us-ascii?Q?vFQYdb6wWh2wwMS4ECD6zJuprU8GSHHAd0iUIfoC0vOmooEPez5zK+It8JEa?=
 =?us-ascii?Q?5Ne65LzIt93ZkhxnRvqbB27GWNS7sWn/nGsGHU+dZVoTUjDwc0aiO+VA+mtE?=
 =?us-ascii?Q?WUo+4VIE3Dflz0ZCYh+ufBow/x4e1dy1NO3PE6u0QxPg7LD2an76myYUIegf?=
 =?us-ascii?Q?JPunaGzcpGuK8jKCNrA8xaeco+XIt386gqnHLhWYW/Nkl50LYXoWwUBqG7qc?=
 =?us-ascii?Q?mIm+1sG6njI2dHm7MZkPCkhDlFz0kiih/98Eqnb+gwnPuSbglGXCnpGd7H0Y?=
 =?us-ascii?Q?vqWe4j8r3YaCjqu1QBLXzfCgyDNWKIl8VEKxSrBNvqbsISt3weBANyJUwu2B?=
 =?us-ascii?Q?k2d5kpUYuY3lj4rVgRuY5k0Cn96gs6kGLC1MP2/80QuVqxE6A7lqZ0AZfONC?=
 =?us-ascii?Q?bn+eTnpm0G/ysGLlgiLr2UlvNn/e11Wq2h/IOPBI+yZ7+IjxSbFkgzTLfNC4?=
 =?us-ascii?Q?SwYA1XYRe7xuDkeT9NjFmWg1lU5Ef3HJIiS+jSjlTOX1GsZxJIMJotOQjQsF?=
 =?us-ascii?Q?0To/rO7RUWskqi7v8nv1ZHNcdh5zX1SmntzTE79ZS+LWyimpjzXuNwrK7Oay?=
 =?us-ascii?Q?/PKZi9StsNgYIIX445jOKBoCmKR0UYg=3D?=
X-Exchange-RoutingPolicyChecked:
	ChadpRVfYCXwNAP29hznOUp2FSVqGdtBs84Jd90dXewIWDpugoZ+q8gFJ6uVKXIrIM9Qr57SB1F2PPucF1hoG9X0WWHLHX1XjxZecckiqMUglg9ocySYSV3HvaRAwgurG96Hk2I6RwfNcD5caxquLIRzKoLdRZ7eTbjvq12J6tvN2xvq4ikl6Y0FQvYdm0j/uLXAprMCgCcWLxs2ZSIROQNrJ9v2yJGDS2idnUxKgkC9tLd1VRltPFsPKCmKFB7uS0Ys6XyloCX4IH6BdrFj/NDKE4NQzTOChN3BFUImcE3idrtAaVGFTX/ZcgESMG49uru++93v9WU53kH6CW5uHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C63SEZNiTrNNxeyazEr3hxQes2CF8qpRUoASz+S8yjxbDXUvYfBMr7SLqxVlOiMYdgciwIfAkPf03Kpy40Wn1BDufmRJ4fY+O46zKaGLfaZ09o1+wxMidOar0Z1OGb8zLECSj2HRWfi4dXUfBywsa1G+mx3rJs/aBnOMK2MYhB2nllp9zfS3kguKaV0EFhF1TJi9oFtcQhFZWj24ekPLuhja1mFPANifW0+qrB2O+i8N58tgJ2TqG1/ZOn6MlcZ79aieUkFy110+35EsG1aZCCdkDv86MGz2jRwf1XLW8Votxwt2MoJODzljFaGUbqDzqef9xOOubLyAFVsjSnHBar0Z31SD3t97tGv1bBxpwta31Y2Cx9LvRNA6D2qSts8bz1f7SkVgMDc2OnuIOGxL5M1sAavZ9u52PORl7/IrEiTdiHX/3t7Ita0dPkijbXzevzbjO5E0PzmtOkzOkVS6rLmsqeLF2QXRE6oxW5O3ZeZ/7v459c6Q/l/E6aFgI9u99Ezg8v/jxy+tFopr8uHb1cpA8Qvf4sXxFYhkgnlVm+ha9mN06VPwLMii84+X0ZoOwYzb/XeOGGkhnJYBQ49nPqq69ojkjsk4sArcRZ8SrTBZwVNk8g3wpquyitliWL7k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb8a42e-07f4-4549-e1ee-08df29ea5352
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:57:30.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gal8xat5g/3Cb62gj6BxqR2wPIkcQIUM3z97acWB0/97AucyWbibNv6ocEAvg6QC5KKZusbfR/LaZraDdX1qA86NxGo30Wdo8OGHIsbe4qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7693

On Oct 13, 2026 / 20:04, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
> 
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       [v3,for-next,0/3] block: delay support for error injection
> Patchwork:  https://patchwork.kernel.org/series/1175637/&state=*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/38472940769
> 
> 
> Failed test cases: loop/006

Please ignore this failure report. The loop/006 failure is known, and it was
triggered by another commit [*]. Sorry for the noise.

[*] https://lore.kernel.org/linux-block/as8-8rDJmUb1FxbP@shinmob/
