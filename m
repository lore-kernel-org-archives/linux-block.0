Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745891A3154
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933511; cv=fail; b=KYBCbAQflHbfwEGhKm3CC8J9ShcePLMJkD9k+UqgAguvRpR6HfpWpxSpigpwCveZV7rbXM0vdEVk3T8D0d53sLKXdI51P2WoSRDj++1KWezDTSjLN4vZMS4VgxuqRbvNxJjvtEfZvYVrsApd1oarw4z04NR3uiay6v5cRp32/9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933511; c=relaxed/simple;
	bh=ArYG+sgT6ghPi0/ixyq3C7CD7lPRpqaCYR8T0E2bMqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K7qcsyNtx0gmx0wOFIuKUiNoGIC1FLd80Viro6GH6xHKLfUerBdzWLcwJQJfDwOPfCxZuszND45STUY0KAF+G2z8D2mcV57WiQwIIdBQeEi2PZnhI0bEX3ONR4l3Y5bf12CxOKXefVLkD6yiRPOV7GgrPGUjC/tK6Jy7QR12ooo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F4D8R/iI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lrmEOwCX; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F4D8R/iI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lrmEOwCX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778933511; x=1810469511;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ArYG+sgT6ghPi0/ixyq3C7CD7lPRpqaCYR8T0E2bMqY=;
  b=F4D8R/iI7noFPtRkePrV3ti/+bUOQ8DE4CfuMAC6lKwn2PKRiZXJxZNH
   gY5j54Ha9CWMn3aMEkPwDK5dJSFJrPtNiC3bx3yl67EownhK73TGRbXOo
   t0MP9Jq0D1kvLMd0H7VFZHKuACONyaM8HLicnfqZnSFN9DrDrQNzuUTeG
   OAonBqxFu/QCX9B1OjebEWkdA3peOfTcfH7p4ScYTiwFjIX50yOY9MoSe
   tBsdtLuOcKo/YnBGRD5YdGOaDPtV2aORRsAB39whCBvk7GqOTYUbZUJF5
   VVA2o48KiSRsHveuSVbUCoXJ0nHX/4d5aNKj0/wa3kgDZ50fhDnI6dUvf
   Q==;
X-CSE-ConnectionGUID: bN10PeEfSViyNzzNoIxdBw==
X-CSE-MsgGUID: YHtIoshgSSWSzhl+cvA8AQ==
X-IronPort-AV: E=Sophos;i="6.23,238,1770566400"; 
   d="scan'208";a="147074043"
Received: from mail-westusazon11012033.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2026 20:11:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjNfjP6+CFFtv69UqFKU/iKay6uW9b4GoqtqyWDaYUw7h6TTS3B3jmMbn3miZ9HA6PYw34muADue1ouSu9cwUrtSHL+5NHvr8EH8nNTo70kaLnYAFQqaGrNtaOnmRx6ofzbJDC+87m9ZTIdvSplcj6Yp2AA8Oioalfs22qT7v3gEXPVheHmq85D6+TB/ZW2ZNkEcNku99/9yDagxJEFyx3QpMc1gfaK5k0O2Due8Qx0QbWFAXOSlsoDwSS/wydo6eXRcBgTmv+F59+4h86DUNpdo25Rex+PTVkK15/E9wAQV4xxCluigo78tYeDdIiDHsIz8+/ETW1GFffu4zbr2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmJ82eb6LV0dNVlK7osvUTKGPnwLKD+ErCsQi/CRm50=;
 b=CA5ZAX6jW/e9CP9Yx53g8GxecNrlvRNRJ/Aac73XQIqUTA24gmCuEi1H9wkbs28emfI6m0I57uwpWvvrywBRfQosb9E5/TO85gY0EJlZ7WIs5aZhV3fhIOQAQbinsl4Y6Zq6NsU8i1PsKGRBF9K+wBr0Up5a0WeXy649X0FU2G6wot65746Ix0vHdEs/5rNN8ej7NEbDNiLInUxnHQSze1kZcTYctCaRuqLJxc96jZV2cZHPkMvUoX23YnpBesqfjWmSJvf6IcHTdOgyjfdm47MNnvAnP/0W6GpehsdVu1i6SdXYhraRwv5y5s7DIo+Ven4NGtR00DkEQaR/GLObBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmJ82eb6LV0dNVlK7osvUTKGPnwLKD+ErCsQi/CRm50=;
 b=lrmEOwCX7qBL6jT5GjIwYY7dCZaeGVD5Gp5m1b5Id5EgrXJAn/qdRqwhWall7B9CuLeZ7HZBRLsFda/93i7eTxhXFfR+xYEC0ieXl8VO6yQeUmb2QhTG8RmTrt+0dX3eQfVU+Yai6ck/kJOQL45pbCNJGtmJ1HZl7KBd6gsqa7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24) by PH0PR04MB7222.namprd04.prod.outlook.com
 (2603:10b6:510:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 12:11:41 +0000
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f]) by PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f%4]) with mapi id 15.20.9913.009; Sat, 16 May 2026
 12:11:40 +0000
Date: Sat, 16 May 2026 21:11:34 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Daniel Wagner <wagi@kernel.org>, 
	John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
Message-ID: <agheih0MbalgY2jr@shinmob>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
 <472b55a1-cef3-4473-b8b2-08b501efcd77@acm.org>
 <agWZZkwOhiSoAvh6@shinmob>
 <58c5d530-416a-4dce-8aa7-099eb571bddc@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c5d530-416a-4dce-8aa7-099eb571bddc@acm.org>
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR04MB10005:EE_|PH0PR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 974d75dc-1470-4227-f0a2-08deb3444990
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	/FeE9y+/OXouvvJNGHtOq2eC6wzOZZkVLkbco7NtbGkwXemXO/3mo9MIYds0xcuc47b0H3qoRH5Bg5mG6ORLgfx/WyDiohqle1nR6MecllV38Pom0+s6NUKKZuOR1hBoG4kSjRyEq5KUXihRyqEPfelMO3Makyd3DBLywjf+/Hx8mDjR7IJxl68PnlQSrFapgLmVvIPLnknyCpyUUvbE3OFMbxYwaZjXsGs/u+atmgBgrL2vZb5QBkkymGkRWzGUDN8CpwrBYwLHyWepocO0pdBvFM+FcfEZ2lYscSDuo5tPjYa0EREOQ4aEuwT2xL177YjbiQDUPIBPyUTSPqzqauQNsNXanurOGmvOH17hLoN+e5qBoFzB1Qo+spULRJ9h3oLnGcWyJyHPT/+TqG0CR0p6FWEpxaUG5tcYvNLbmCmVQ8O5T5pU04H0ONn9lRwn7EQz0fCSiLfDXaKQHaYRcXIuNFx9B4LPNzLkWwMLCD6ojKcoEdSr0wogWfWWf5nEa/R9pK98Cael1tBWqegNmMLXdHb9jZ2+W82b+u30/Jph4DSLAlpF4SN3X0zv6Jsx5FUZ2CU2tva4BOEqvChbwCmwK7JS1WA7CcMSFxTqrBOv/r3UqKcmCMFQhTMNHwHxqKydZMLEJJaNOAIrXsg4HMIUqsqWgV5DtOXymmbnF7F6tmoj7SxUqek5/ZDMv/cf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR04MB10005.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VUFhBnFVvVK0Rm/a+U7i+wOhEPLBurIBNIIOc1tJ780qbtGFu4m2VK1jvU7C?=
 =?us-ascii?Q?e6F5iJiH4CZuHcxJFAiMh/h85xCBs6drn6AeTM5HiX4rtXftLM10w4FDetUZ?=
 =?us-ascii?Q?tzCYKs19IWRZQthIQtzMkLWvfWwvNd8gZ4CZmCnGy5DsrMYg1/w5E0w3kTaB?=
 =?us-ascii?Q?U8ZhH7oNMNtvXCHtLYcwb233+U2sIMClcDdHsDH+I2z9c5M1R+ue8hRup1WY?=
 =?us-ascii?Q?Zo1Pu2Ct7O/Ir3HXBcpDsujoL5Yz5HV2b6svcgIS9U+up+i9dbelRo3vd1cD?=
 =?us-ascii?Q?adlTZzsWRdYyA6SC+nTn6vwcSf3isybBZNV9tma3EIkJBpeAG47cSCfggMlY?=
 =?us-ascii?Q?a8bCBVC3E+3kJdaWH5U3PgaRI0CIM+0Z4l+VDwZtpgxAgN/L4DPfkkykbBPr?=
 =?us-ascii?Q?t3WaWx1Qdy+fgXTroF423bxtUA5c8/kTHaj5OHEiciMpT/9NcQujPQ3oUt2M?=
 =?us-ascii?Q?8wyMFubSAkYDyudQvMe/1CsHPLRG9uLpS34Z4ZRgijio4thsc+/tCAAjsXeU?=
 =?us-ascii?Q?FpypN6E94RtN2nM7KzyaEKfo5Rgluzbi1yhS89LA0U0DtMktclvnFV83yV4o?=
 =?us-ascii?Q?krZlvm/nBMxulG4+eMYyLHwD0Y84lY943KYUeO7GxhcDbuqp8+s9uEeZnk5r?=
 =?us-ascii?Q?8R4zFALAIiRiEPk1LT8Z8Ufl1yNBoR3Bonl1czHtc/zZnJRLMUxE0Ak3NyLu?=
 =?us-ascii?Q?4AiEfJD6SmNhHvuqk+EuKcPWQkKxLNmDAYHHNRpYp2uj32OaoTi9k1/oqLr5?=
 =?us-ascii?Q?wIHph4ITL2//x+PPyXmRP9zsIZDrWMzFlZentgA8nNj+1MELIgx1bsBpuBJx?=
 =?us-ascii?Q?lDR3vgrTs9oEb0Ae+ylr7Xkt/NlMemiJI/0l/mAQoq3PXLtIXsVc2A5QaB/4?=
 =?us-ascii?Q?TuyBvrwDv3PCZ8lDaIx6EuxlqBKcRUjbvuL7AxsqvJuPqusgtOA+bU03wcRe?=
 =?us-ascii?Q?EnBt+FlWZ1GY7dOwSQ891Wwqb1cRtNdr9CxbBFmxl/ucu+5y4tkNff7DMd4W?=
 =?us-ascii?Q?401cWoilNEeP1kWwYDkrwsq7+UMxNainEFs4Y+SN3MEnkk+IbsMnGZYzP/kd?=
 =?us-ascii?Q?ITDvEhKYWsHTb+MI5YD/nMhPliCRvuqFTIlbkMlwR2SoBvm5UceHjcV7vTIQ?=
 =?us-ascii?Q?GSrDb5D/WO2GRQH5xmU3EgslA2qDxHv5a59rUCT/DysNA1Lchh1df8bIipdn?=
 =?us-ascii?Q?thSUxm9ExuQd85SoVjzHfnVTjUBh/cfDtQU8ckb4HMciqbXa9AzMb5fo1shi?=
 =?us-ascii?Q?OpISJmG9BwUQyetx8X3V7jlaDuS330SNa+6YvDib8VSS1w6T8XryB3m4yZZw?=
 =?us-ascii?Q?akYJKrp5FqnrDPudi6olvylmkPGSPxbv7Nm5RSET9y9YklZDpeMwxbk9jXNa?=
 =?us-ascii?Q?TvSu5X0GPNMgWZktFzGTLC443CRxhX50ii75Emc7RUem0pRP9nv4pN+wSmre?=
 =?us-ascii?Q?PvE0jO3ksMo8iwIHUGauwNHrpFAc+6egOQXtl6kI/8PGDuMOcDxz5M2wBc+Y?=
 =?us-ascii?Q?ckKrCf9SdMRUzxje/VetfXdCZpdkg5q7PV/y5+rQnA6gU4FGMF1aw56cKg7z?=
 =?us-ascii?Q?X48CUQlNTzUvnP3Q0OSIa1/jikm9tGDfhx/NmHIDkX7CLlNIbzE2PdevnOIV?=
 =?us-ascii?Q?kg297PkKkzXq1NNeyAhzSfXHceguxQvuhsdTa+U8rZ1Upmjbb4xnI/nuJQww?=
 =?us-ascii?Q?7zqNHDAtLjyFE5efDZ6r7XJgE/iqtjjTDNQ7j6Js9FcENhj/Nv2ldaVMeo1c?=
 =?us-ascii?Q?ZIRo4lkOkYG3uvb+0fmRrgx+tHupG4k=3D?=
X-Exchange-RoutingPolicyChecked:
	KzjhvfjSzs0mG2yuVPd91JHGEbLBTAVA1oY6qa3u54Qbeno+BfXSctJ34oWmred17UYGsSbIo65R1HPsNn+ABZh+2TjIHhIrooi6T1BPfmxRfB3nPQjhkHCWK++CSp5TkKy7WsbgCa3lqyI8zjqwJzz0kcXcpg55iIvEJO38UKZPxTG4c7y1RrQCCig00uR8SEZPam/6yftdTd1Gb5c4ZfkAYsaIoL/Gl/XUicM+Cjc6LM9SBK2nfnQ5qTEMxdkt/flj/3myMxZLjiNE4HKl4K6GjevS6ayBHR6hZKkEu8xGYuvS3/C0Vr3o05RrbsoNZ3m6p4Kiy9hlNzL2BZ4l5w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rDJABNStMUdEVyoHmD0akV5xPD7iuKXwU+wiScU66vowdQPhzGEb+PEcyqtOth7GgyNgNwjpgHKB5SoY5aBsOoK1Nm5p+sB1qA0F6Rn8652qgBKGFfwsDVJiX7KGgscO+KamrKDeSpl88nF1FONxUznajBzVdXTC8wTQQx6A6RqQFPib+kAaHMTQxCpOd55714hc5FCql8klsV4i+DS0vD+qjRAGjmP5Nlg1lAcWzXVwAHT1pPShzE/0U2Aa5zXN8RlLqZK6frNEc4cWWouU77wrEfvh+SWTI+T8N3wSdRc4EqOnGsTN5GUw14G5nPaT+pj7DPF9d7+y6UYTPR3vfmpSRKcPz19q8KNlaXH4UZqyIdpuSHqi587jEy1FSM2np2am0UHQheFNA/7AF/j7mIyvOqgVNVifNornvhEmh1M1TxXB3BuNYeEcQumr1lkE8wjd9yHbvfSeRyrjjrXi3Y1vF0G6dzjGxPRhdGdC/73CPHPbj8MVDT9HE205h9Diko8AQ7Onb4bVUKGalAKsAeQUf3pgSFAX1usyRiNrRzLn72jfF8C68zmL0LaPr3EKRruZ0zoUCfP0f/STOpD1eh/ncmsTCv2+WtCOMjfcxKfisK0VcBIn7wK+1DIUAfBX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974d75dc-1470-4227-f0a2-08deb3444990
X-MS-Exchange-CrossTenant-AuthSource: PH8PR04MB10005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 12:11:40.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq3uFD+e9wBZhBQ5lhuHZV4iI9YF9ViwnevcgLxnFzDJJiezLQ2uQrfNFAOv+UgZxOPQFmjg1B+5TNWSyGZ+3aUB3Z2X+eU6eTIPUaiB1n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7222

On May 14, 2026 / 08:58, Bart Van Assche wrote:
> On 5/14/26 2:45 AM, Shin'ichiro Kawasaki wrote:
> > On May 13, 2026 / 10:17, Bart Van Assche wrote:
> > > Should "echo" or "echo -n" be used in the above shell function?
> > 
> > I couldn't catch the comment above. The current patch uses "echo", and it's
> > working.
> 
> We will have to switch to "echo -n" if any code is ever added to
> blktests that writes into binary sysfs/debugfs/configfs attributes.

Thanks, then "echo -n" is more appropriate. I have reflected it to the v2
series.
