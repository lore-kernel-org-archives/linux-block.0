Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DC279917
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301719; cv=fail; b=RQ00RZOEXwk7q+iF4acBRzWqtp2DaDisL4KbheAPuZLTu1k3cxvFPdUYFTGqT7uX2gY5KhTpGywaK/MSxYl9MRJ57Gx2aU5RJcw3agNkwAKS6LhqvQtOxBNJtfkMHsf7E0sdrK9LBKaIx+BPtLJvXHRqCYH2N5zYnlnDjUNWndA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301719; c=relaxed/simple;
	bh=vkAaMdFpuKIp7h0Y8e73oaBiHKOQQJ7lcr4zOGpsB1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ga89SP8WmPpXC/SN4o+2MYoM33Yi47LrtEy7NKpkRLuhz01usLdl+IPe9lZGPRVoh2x7z3i+FMefyLhoDRqrsrW5UAAnXWircrHdexPgUAOIq+b1peExPSCNozPXQT0tEMhZKD59vKQ5b1QlfYYfxH6b70xlZBDFsndvvcF6aEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hXG3zSZt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=el0HxDzk; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hXG3zSZt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="el0HxDzk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782301712; x=1813837712;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vkAaMdFpuKIp7h0Y8e73oaBiHKOQQJ7lcr4zOGpsB1M=;
  b=hXG3zSZtbfNbn4hod24DVCF8KTp9R/5uh9dyed5OUS44eDmFgOhPIarI
   poTM3vezPg4se6wLinKbH5WiDBl/INyR/QcSoVWEhS2Q7Me5vl+jYeTaN
   LmyXPKOR7KhgzI8v8LTDCvqM3VNMFBnw1SSWCOWNoa8ljr2SXocw06uMw
   shnMgLyZe+r3hxRGN3afa8CL0NZ0bq/vlGtK9Z/x4eumuMhB5WvtgjbQo
   072SlCtSYjj4VwJ+8LG+SoqFP6giSK5SNZnwvY62IXVk+uneIeZg4YLv/
   X/FhBYXtFD/09Xj5F6msqcbD4MaDw0ZALr+t8tBdhmurYFTNaj9VZAtHD
   Q==;
X-CSE-ConnectionGUID: 8AXOgPXnSz+oVomaLW7e6g==
X-CSE-MsgGUID: QxHRoWi7RnOg+kdMecF1Pg==
X-IronPort-AV: E=Sophos;i="6.24,222,1774281600"; 
   d="scan'208";a="149746910"
Received: from mail-westusazon11010015.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.15])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2026 19:48:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ococlBlRE8yk2JzutHjMllquXF8OPps9MyadgCFzWEL5oeFxd0U6xzwhp+ULKza6CyqAjjwWV97QUCeWsnsyX23f23QwmjxXq4pJLyG9bd5OeRMI0gZ3e6ACVOpdLJXlKCyJOV67kz4tfbnYY6m8k0sDoHget6TfAN6OFi9XiU1p1vRQRx9lt8VTL8FoQYGWNWjZyBCUuV2M3RkZRsKnt82L2jktHlvWvXLnBSr06r8yu5w7x0oM04iVYPX8dAp9BPIJYyIo5wXp1c4qOZPxAa5/UZOMjuUfoiWb/r4F2r/NWCG4c4CiRX1xt8k8QdVVPiKfXFSHrbBgbsrSXTRZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1c6cUZyh/4H5YGndNyUM3pT3tqfIFBFpkAcEoT7VrE=;
 b=EpBvkX4Octs5T9rI0QnqnC8xGIXS7VkEVeszEWlVwGl+eDAOxZVp7S0lCoZ2P3OBfg0gtu3Qg91fvqzK70ClgcDjL9Ctfkew77FOPnZcQpa1oeTTCUFD6u0zm6vaQiM0E/iD5U0kOEgIfZXrt4OgsS18yfNR4mcKaG+7NCO2JFyMnr1Pt5FdqeupB4b+F5DZlUQHKlYjGD+KVdOWs91h6rX3H9W4r56k+C0GaKALg13AwFeqmkFOUHN+JE/BYpy7kJONVEQ818UDASmQHJ9hkN/NkTFIwZkamfzbK3cdKLtEI0Tu/1gI9vRzR0yoTgVZeue4cuGa4UcQlggfcM+rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1c6cUZyh/4H5YGndNyUM3pT3tqfIFBFpkAcEoT7VrE=;
 b=el0HxDzkkVdZBL61ZRopXZmxONWUu517/Hh1ZvtS/5CbtPWh42p2H1oS9GfET3LinjHE4zyiSMnNsx5TgizvxymtqXQ75qCjZroW8DXVJ8YKUhgpNZTy0CtAofi0e6dr+Fb+616enqc9vXFCM02mv5lpKYMdR4yAStCKx0JBhTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS1PR04MB9140.namprd04.prod.outlook.com
 (2603:10b6:8:1e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 11:48:22 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 11:48:22 +0000
Date: Wed, 24 Jun 2026 20:48:16 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] block: serialize elevator changes for the same queue
 using a writer lock
Message-ID: <ajvCBkxdTCNt9JWI@shinmob>
References: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
 <ajum7l5BPDRoeJgi@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ajum7l5BPDRoeJgi@fedora>
X-ClientProxiedBy: TY4PR01CA0116.jpnprd01.prod.outlook.com
 (2603:1096:405:379::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS1PR04MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 14921cc0-09d1-49d8-6b00-08ded1e67ddc
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ad3tPvR1jwd1DU5YoW0hn+7GR5kSPHBYpZVNOlDUZZuC+GmyhyG9wpl3BZe94t+JdvJPj50Hm/5mvc3vwn+o1NB1auvWlsmMy6D3xYqOUC2uvkd/7O4bBkCfWHZ/0wBLupBZPkKP8DvO3ZJX4jrjiK/QEaTzxlOwOaZYD7jdJpP9tcBuxXevpeoMfDc53S5lZbjx5l4qe2jLEFQxb7PkbQxyGib4dBF+cbFUz8yx5nA9Ym9Hqdv+XGbj45auqOhePOMWYyV5kgCiHdvGEDuZkMqCpbL6BsykLUT+0h4SLEzpnW4WXhLkrYkdhblI+CQC6aBtMD5u3O+LRV4lZotVNpVLhQ+euS5XHUNQq/OvemwA2oDp+eHA4bo/7Cq/xpmYkPHUr+EqISgwU7t6qzThqPo+reUMLFzrxMPdCmT+E1aYJKfTi8lPIF1b1Upr3/Mzu/oIcC3aPX3P+bDDafAxJPlMOwmA5PkJ/UpbViPQie9weyAIh66H8rQs399EZbDHn6HEWhtAIOcrSE/IoNwY28ktXnCfOdf/u7XzMm+NAI1vH7Hp9cif+W51klZ/LhFzJhzqgJLwgtVyGrR0SeFaTEDiRETPp8gVM5YeAalaDdF3dbJFrHeEwn08nB2zMNWS49qZ/Yb2M/avmKTIJtp1IX4g0d17tmtOShs0q9dlkJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fk4BRsp/0Obs7HWqZBZjFXdSghZEe096G8ZAYgOY6qBYoOfxcj9TqonOsDof?=
 =?us-ascii?Q?FUQeAj+dZ6JsPLtNeli9AemL3nYA2Fq0XRmklvt5IoOymJ5Ubl9yu0EqUarP?=
 =?us-ascii?Q?sZoag+v8VmmgJmu9HGtn6MrN3oPcKYu0s6sJFAyHd5Rdp14mQdwyGd4lLnKf?=
 =?us-ascii?Q?eOHFbvMbPZLQtv7f+ZfzhV/BsNJjGQX/h+LC4ruEXt26pMJG20OpFmjRdsLL?=
 =?us-ascii?Q?uJeizGWuhnLavwkLnChowuAqYWCN7tFdU7q8vs4tdkjy8MBeIOdBW9CVfvvv?=
 =?us-ascii?Q?O7lkxsIXdInDbz08evYngFHz5DepdtRjJQm5yFo7POESRxrrJsjiYomoQFbC?=
 =?us-ascii?Q?RjDUNCOjK2HcUWHlv6t2KlFzK7wz50FZ+R2bOtu6T0SaCggVSwu7omxAwE/w?=
 =?us-ascii?Q?FjFRvqWf07ljjczo4PGCRKrtzxOO+FHh99lUbjR4QZLvrkRbY2X6GFg/aZX6?=
 =?us-ascii?Q?TJSE9UViBPZ1igimHGJZxW2y50ij3m9sVhFNWrAMEcx4vtXDKwpGfhJ/Ixj8?=
 =?us-ascii?Q?QBTNc2egeZ6Svo0TitgdRHU55Wg8Un76UW8r/VfS9+/jHGvY8KSz57em5+9f?=
 =?us-ascii?Q?+CEhwYos9UyQKskBw6rQzu6Acm54FGGaCgEwDPG6K/RqOGkgL/B8HYXfydxk?=
 =?us-ascii?Q?YQpCFoayhjKtLakHgv+L85qQmlKfTwDa3O5sRVVk3B5pIicURUCQtqBhoWHP?=
 =?us-ascii?Q?vUUxTuLn6Q/BiuaOOSmLs9Te+GdvQZUcyUqchqbEqhp/GpC0h0IVc4WRS0+Q?=
 =?us-ascii?Q?FTvUlCVAkXkgyAJJ5rHH8DZnMva4cQreDTemYWoVsI9/s4erk+T2l6jLOekc?=
 =?us-ascii?Q?OCl7PcYguukw5swoKzcJm3CvEmT56qIsz7bRXi1aCTy8HybE5E4KF3fXS6bl?=
 =?us-ascii?Q?OLEUBwHfz+r1hysWYqLO/zU4sj63LM3djmSv7GZ8FSu3nZx0fLZOXlFqSewu?=
 =?us-ascii?Q?1MI9J1dXV8+U0eOMFCEdRftlvdioVEIZRmJti/v/sdCJ0w5BXajb8l0XD+sh?=
 =?us-ascii?Q?2WSJFaAX3GmVeaAm6x1IozWb3xI9WdcTg3P1e0mFBvi+VJ6V12IsAtb1EhG6?=
 =?us-ascii?Q?7CRJ/USU3xbe7bFp1FwX9sEEM9SYI7WMn01YgHVGLA+tDp7Cnolia74oKRNw?=
 =?us-ascii?Q?QnegW1NSf3at/MyfXVEx9dkY50gHStpY0nAzTY7g855Lb1GImDFjbPV1/evG?=
 =?us-ascii?Q?av57jZ4hKdTLPs+eu81IEbLMJwwAlcTV9Exuo3T8DIOHbMqEvbj8n4kuLwb4?=
 =?us-ascii?Q?+rFILSxWGEYac5Ax2oeVXZa72oTLsMdNRxxpyYR5nuBe6NxJSAiadWMga3wn?=
 =?us-ascii?Q?MTJBoCfdGb4NVYJKA/HAd6PqhSdyRi9Xz18kHr5o+PgPjvCKyWujA1rcEQs6?=
 =?us-ascii?Q?m0JMojMD2hYPXuENnfaftTWV3ANuPGesZJexYogtbJjmJJ/RwVqJ3C70Bhxh?=
 =?us-ascii?Q?Uppk/vnYeytKOLtzh3D4w7+ePrXzupOSVrTTmvj/mFA0v0/1oiRqghlfDFDs?=
 =?us-ascii?Q?ve9rMPWtW4Qj6AzCpBwQ8ggII55M/i85Yx6FGjAY4MVO5DmUCNkdPtSSojTa?=
 =?us-ascii?Q?Mp9OciYE45EBFYatWoEN4dP9b0p5uyOqRn9BFFbEvicN2/KTw7MOoYoGeko2?=
 =?us-ascii?Q?2R+9Co6wJZNM/fvnBMhIvG4liXTjrXkXHoENDWdgqumJdhGiJJwfUdXiyaLg?=
 =?us-ascii?Q?Gv7ngNoksT5i+WmYjI1wDwndTTnYul/9zetPLjdn4gvghKOHE+OZtEsNeo97?=
 =?us-ascii?Q?Qh8FW8rmeT1zF/ACCMgEnVDArGZdGLQ=3D?=
X-Exchange-RoutingPolicyChecked:
	aj7kENejhcU5doDbqrVUnHOH0TQVBtwt5qaiAnZJlVNkg51s7mBiWKBrHpaYXhnz2p7BmKsiHP3anBn/+IKYdMK+3ZSM8UYxtMIRk9iBWe0bfy26vX1MeK3v+nFIK6/YxrXPThkafsj2d2FjCOP7HcpaCTto4GvReBcN/B9cRvOCjJfdcWtkZdLpiHUT+Rkg8wBlc5ViC+rgYZ4HUtgnj+SxbJfZCelR7Xi0gtEG8AgfRXUjk8LERZELEEhUTR1kFsdRH2EFtaGvGb9w5m/9WdknZUxPvX0P3S66+xYDnuPxVEsE3xi147sQXbcJCHmCmTkPev+aZVG9wplAWYma0g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GvQFnRdVwrap90WVyjSPnvI0ek23WHv64nkSRlW7kIMfESsmIpjItr4f3jDuk8CFuxgOB4sK87DWSTZAOw7/XRQgFEol1t6HS5LDwJ/Ofn9P1o2cgDwfXRrIWWises9uDv4gD/NPjtKX0DrPtXj4Aq4rhobyTGsSbI4RI/3zCTtJfeDUMyksVwuCfMUvhath8p0TmXLx3FmByjVo/aNyGIUADVIaufmaYwhcDWQZ+Cx0WM8DSLwxHRO5xFuIumKpZMqY8C/oZICsqZDN3PSN6QvceNaEg6cglKyRf3RI86Q1Ct15g5VdNE7jueB641VQWwHyURhP+y380U8F7uzziQvQYL3wE9uPzW/Iiic628oMOLUmxLSoBBRLw1DvI/pWoBjZfOULgJIfN3ExiTH52BEM6IfFVkMQR4NMikoXkp0M9l59hwglFo7FyO9zPk9NZoSAtVT1Mlx7GqGsp6KxacQwdDqbW3nB5vKFbkOFMP4lb6YSSzzSPy1nLVREFnAHRHAlmFlObpWDKRn8QRhxUvKVFtfpaXoHZa/3Mo5puWfEmfyDvXl64Wjf7pa682vW206t7t+G4QWe1HCymr1f3IACSXcd2q2WjVhY/EFPvpoft0kTA0b7fH8k5KUyWpge
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14921cc0-09d1-49d8-6b00-08ded1e67ddc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 11:48:22.2000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1t0J24EckAqjpTrP+URSmvsj/7liEreH9Eq6i92JwNvzhzVmuHLBDWDc+/azyxYF23HV6fiUFGyLwX5oYekb3DHYhdcxgyD0y2nP58iDYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9140

On Jun 24, 2026 / 04:44, Ming Lei wrote:
> On Tue, Jun 23, 2026 at 10:32:38AM +0900, Shin'ichiro Kawasaki wrote:
[...]
> > Please refer to [1] for details of the failure. Also, I created a
> > blktests test case that recreates the hang [2], which I used to test th=
e
> > fix.
> >=20
> > * Changes from RFC v1
> > - Instead of adding a new mutex to struct request_queue, replace the
> >   reader lock on update_nr_hwq_lock with the writer lock in
> >   elv_iosched_store().
> >=20
> > [1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinich=
iro.kawasaki@wdc.com/
> > [2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00e=
acd138d020de97fc6
> >=20
> >  block/elevator.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
[...]
> I feel this is still abuse of the above lock, which serves writer vs
> reader wrt. updating hw queue.
>=20
> How about the following fix?

(snip)

Thank you for the idea. I applied the suggested fix on top of the v7.1 kern=
el,
and ran the test case that does the concurrent write to the sysfs sched fil=
e
[2]. Unfortunately, the test case hung. Before the hang, the kernel reporte=
d
WARNs in sysfs_create_dir_ns() [3]. KASAN slab-use-after-free was observed =
also.
I also noticed that another WARN was observed during boot [4].

[3]

[   75.184223] [   T1820] run blktests block/044 at 2026-06-24 20:37:20
[   75.229561] [   T1830] null_blk: disk nullb0 created
[   75.234717] [   T1830] null_blk: module loaded
[   75.249186] [   T1820] null_blk: disk nullb1 created
[   88.092222] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   88.102051] [   T1842] CPU: 6 UID: 0 PID: 1842 Comm: check Tainted: G   =
     W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   88.102067] [   T1842] Tainted: [W]=3DWARN
[   88.102070] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   88.102075] [   T1842] Call Trace:
[   88.102080] [   T1842]  <TASK>
[   88.102084] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   88.102105] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   88.102117] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   88.102132] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   88.102146] [   T1842]  ? kfree+0x1d6/0x620
[   88.102156] [   T1842]  kobject_add_internal+0x26f/0x800
[   88.102171] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   88.102180] [   T1842]  kobject_add+0x139/0x1a0
[   88.102190] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   88.102199] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   88.102208] [   T1842]  ? kasan_quarantine_put+0xf5/0x240
[   88.102218] [   T1842]  ? kfree+0x21c/0x620
[   88.102228] [   T1842]  ? trace_hardirqs_on+0x53/0x1a0
[   88.102237] [   T1842]  elevator_change_done+0x26f/0x690
[   88.102250] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   88.102259] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   88.102274] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   88.102285] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   88.102293] [   T1842]  elevator_change+0x283/0x4f0
[   88.102305] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   88.102314] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   88.102326] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   88.102335] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   88.102351] [   T1842]  ? lock_acquire+0x126/0x140
[   88.102364] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   88.102373] [   T1842]  queue_attr_store+0x23f/0x360
[   88.102382] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   88.102393] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   88.102401] [   T1842]  ? lock_release+0xfa/0x120
[   88.102412] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   88.102442] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   88.102452] [   T1842]  ? lock_acquire+0x126/0x140
[   88.102462] [   T1842]  ? lock_acquire+0x126/0x140
[   88.102473] [   T1842]  ? lock_release+0xfa/0x120
[   88.102483] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   88.102492] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   88.102503] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   88.102511] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   88.102522] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   88.102530] [   T1842]  vfs_write+0x524/0x1010
[   88.102541] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   88.102548] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   88.102558] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[   88.102574] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   88.102586] [   T1842]  ksys_write+0xff/0x200
[   88.102595] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   88.102607] [   T1842]  do_syscall_64+0xf4/0x660
[   88.102620] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   88.102637] [   T1842]  ? count_memcg_events+0x37f/0x480
[   88.102651] [   T1842]  ? lock_release+0xfa/0x120
[   88.102662] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   88.102670] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   88.102680] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   88.102693] [   T1842]  ? lock_release+0xfa/0x120
[   88.102703] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   88.102713] [   T1842]  ? irqentry_exit+0xb0/0x810
[   88.102720] [   T1842]  ? do_syscall_64+0x34/0x660
[   88.102730] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   88.102737] [   T1842]  ? irqentry_exit+0xb5/0x810
[   88.102743] [   T1842]  ? do_syscall_64+0xab/0x660
[   88.102754] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   88.102762] [   T1842] RIP: 0033:0x7f96f4878bbe
[   88.102772] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   88.102779] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   88.102789] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   88.102800] [   T1842] RDX: 0000000000000004 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   88.102809] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   88.102818] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000004
[   88.102827] [   T1842] R13: 0000000000000004 R14: 0000562ec532aa50 R15: =
0000562ec5397300
[   88.102854] [   T1842]  </TASK>
[   88.536717] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   90.116333] [   T1841] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   90.127915] [   T1841] CPU: 0 UID: 0 PID: 1841 Comm: check Tainted: G   =
     W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   90.127935] [   T1841] Tainted: [W]=3DWARN
[   90.127937] [   T1841] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   90.127941] [   T1841] Call Trace:
[   90.127945] [   T1841]  <TASK>
[   90.127952] [   T1841]  dump_stack_lvl+0x6e/0xa0
[   90.127971] [   T1841]  sysfs_warn_dup.cold+0x17/0x24
[   90.127982] [   T1841]  sysfs_create_dir_ns+0x1fc/0x270
[   90.128000] [   T1841]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   90.128010] [   T1841]  ? kfree+0x1d6/0x620
[   90.128024] [   T1841]  kobject_add_internal+0x26f/0x800
[   90.128032] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.128039] [   T1841]  kobject_add+0x139/0x1a0
[   90.128044] [   T1841]  ? trace_hardirqs_on+0x19/0x1a0
[   90.128048] [   T1841]  ? __pfx_kobject_add+0x10/0x10
[   90.128053] [   T1841]  ? kasan_quarantine_put+0xf5/0x240
[   90.128058] [   T1841]  ? kfree+0x21c/0x620
[   90.128063] [   T1841]  ? trace_hardirqs_on+0x53/0x1a0
[   90.128066] [   T1841]  elevator_change_done+0x26f/0x690
[   90.128074] [   T1841]  ? __pfx_elevator_change_done+0x10/0x10
[   90.128078] [   T1841]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   90.128086] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.128091] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.128095] [   T1841]  elevator_change+0x283/0x4f0
[   90.128103] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.128107] [   T1841]  elv_iosched_store+0x30c/0x3a0
[   90.128112] [   T1841]  ? __pfx_elv_iosched_store+0x10/0x10
[   90.128116] [   T1841]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.128131] [   T1841]  ? lock_acquire+0x126/0x140
[   90.128138] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.128142] [   T1841]  queue_attr_store+0x23f/0x360
[   90.128150] [   T1841]  ? __mutex_lock+0x1536/0x25a0
[   90.128155] [   T1841]  ? __pfx_queue_attr_store+0x10/0x10
[   90.128159] [   T1841]  ? lock_release+0xfa/0x120
[   90.128164] [   T1841]  ? __pfx___mutex_lock+0x10/0x10
[   90.128169] [   T1841]  ? __pfx__copy_from_iter+0x10/0x10
[   90.128175] [   T1841]  ? lock_acquire+0x126/0x140
[   90.128179] [   T1841]  ? lock_acquire+0x126/0x140
[   90.128184] [   T1841]  ? lock_release+0xfa/0x120
[   90.128192] [   T1841]  ? sysfs_file_kobj+0xb9/0x1b0
[   90.128196] [   T1841]  ? sysfs_kf_write+0x65/0x170
[   90.128201] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.128205] [   T1841]  kernfs_fop_write_iter+0x3da/0x5e0
[   90.128214] [   T1841]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   90.128218] [   T1841]  vfs_write+0x524/0x1010
[   90.128223] [   T1841]  ? __pfx_vfs_write+0x10/0x10
[   90.128229] [   T1841]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   90.128238] [   T1841]  ? __pfx_pte_val+0x10/0x10
[   90.128244] [   T1841]  ksys_write+0xff/0x200
[   90.128248] [   T1841]  ? __pfx_ksys_write+0x10/0x10
[   90.128252] [   T1841]  ? lock_release+0xfa/0x120
[   90.128257] [   T1841]  ? rcu_read_unlock+0x1c/0x60
[   90.128260] [   T1841]  ? wp_page_reuse+0x160/0x1e0
[   90.128265] [   T1841]  do_syscall_64+0xf4/0x660
[   90.128277] [   T1841]  ? handle_pte_fault+0x54e/0x760
[   90.128283] [   T1841]  ? __pfx_handle_pte_fault+0x10/0x10
[   90.128288] [   T1841]  ? __pfx_pmd_val+0x10/0x10
[   90.128293] [   T1841]  ? __handle_mm_fault+0xa02/0xef0
[   90.128302] [   T1841]  ? do_raw_spin_unlock+0x59/0x230
[   90.128306] [   T1841]  ? __pfx___css_rstat_updated+0x10/0x10
[   90.128315] [   T1841]  ? count_memcg_events+0x37f/0x480
[   90.128328] [   T1841]  ? lock_release+0xfa/0x120
[   90.128332] [   T1841]  ? rcu_read_unlock+0x1c/0x60
[   90.128336] [   T1841]  ? handle_mm_fault+0x4d1/0x7d0
[   90.128341] [   T1841]  ? do_user_addr_fault+0x15d/0xed0
[   90.128347] [   T1841]  ? lock_release+0xfa/0x120
[   90.128351] [   T1841]  ? do_user_addr_fault+0x811/0xed0
[   90.128356] [   T1841]  ? irqentry_exit+0xb0/0x810
[   90.128359] [   T1841]  ? do_syscall_64+0x34/0x660
[   90.128367] [   T1841]  ? trace_hardirqs_on+0x19/0x1a0
[   90.128370] [   T1841]  ? irqentry_exit+0xb5/0x810
[   90.128373] [   T1841]  ? do_syscall_64+0xab/0x660
[   90.128378] [   T1841]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.128388] [   T1841] RIP: 0033:0x7f96f4878bbe
[   90.128393] [   T1841] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   90.128396] [   T1841] RSP: 002b:00007ffcb76eba90 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   90.128402] [   T1841] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   90.128405] [   T1841] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   90.128410] [   T1841] RBP: 00007ffcb76ebaa0 R08: 0000000000000000 R09: =
0000000000000000
[   90.128413] [   T1841] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   90.128415] [   T1841] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5397e70
[   90.128421] [   T1841]  </TASK>
[   90.128435] [   T1841] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   90.638084] [   T1841] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   90.646403] [   T1841] BUG: KASAN: slab-use-after-free in blk_mq_free_sc=
hed_tags+0x124/0x160
[   90.654950] [   T1841] Read of size 4 at addr ffff88818265ad40 by task c=
heck/1841

[   90.665102] [   T1841] CPU: 4 UID: 0 PID: 1841 Comm: check Tainted: G   =
     W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   90.665108] [   T1841] Tainted: [W]=3DWARN
[   90.665109] [   T1841] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   90.665111] [   T1841] Call Trace:
[   90.665113] [   T1841]  <TASK>
[   90.665115] [   T1841]  dump_stack_lvl+0x6e/0xa0
[   90.665123] [   T1841]  print_address_description.constprop.0+0x70/0x300
[   90.665129] [   T1841]  ? blk_mq_free_sched_tags+0x124/0x160
[   90.665132] [   T1841]  print_report+0xfc/0x1ff
[   90.665136] [   T1841]  ? __virt_addr_valid+0x1d1/0x3f0
[   90.665141] [   T1841]  ? blk_mq_free_sched_tags+0x124/0x160
[   90.665143] [   T1841]  kasan_report+0xf6/0x1c0
[   90.665148] [   T1841]  ? blk_mq_free_sched_tags+0x124/0x160
[   90.665152] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665157] [   T1841]  blk_mq_free_sched_tags+0x124/0x160
[   90.665160] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665163] [   T1841]  blk_mq_free_sched_res+0x50/0x170
[   90.665167] [   T1841]  elevator_change_done+0x4f6/0x690
[   90.665172] [   T1841]  ? __pfx_elevator_change_done+0x10/0x10
[   90.665175] [   T1841]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   90.665181] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665185] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665188] [   T1841]  elevator_change+0x283/0x4f0
[   90.665192] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665196] [   T1841]  elv_iosched_store+0x30c/0x3a0
[   90.665200] [   T1841]  ? __pfx_elv_iosched_store+0x10/0x10
[   90.665204] [   T1841]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.665209] [   T1841]  ? lock_acquire+0x126/0x140
[   90.665215] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665218] [   T1841]  queue_attr_store+0x23f/0x360
[   90.665222] [   T1841]  ? __mutex_lock+0x1536/0x25a0
[   90.665226] [   T1841]  ? __pfx_queue_attr_store+0x10/0x10
[   90.665229] [   T1841]  ? lock_release+0xfa/0x120
[   90.665233] [   T1841]  ? __pfx___mutex_lock+0x10/0x10
[   90.665237] [   T1841]  ? __pfx__copy_from_iter+0x10/0x10
[   90.665241] [   T1841]  ? lock_acquire+0x126/0x140
[   90.665244] [   T1841]  ? lock_acquire+0x126/0x140
[   90.665248] [   T1841]  ? lock_release+0xfa/0x120
[   90.665252] [   T1841]  ? sysfs_file_kobj+0xb9/0x1b0
[   90.665255] [   T1841]  ? sysfs_kf_write+0x65/0x170
[   90.665259] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   90.665262] [   T1841]  kernfs_fop_write_iter+0x3da/0x5e0
[   90.665266] [   T1841]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   90.665268] [   T1841]  vfs_write+0x524/0x1010
[   90.665273] [   T1841]  ? __pfx_vfs_write+0x10/0x10
[   90.665278] [   T1841]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   90.665281] [   T1841]  ? __pfx_pte_val+0x10/0x10
[   90.665286] [   T1841]  ksys_write+0xff/0x200
[   90.665289] [   T1841]  ? __pfx_ksys_write+0x10/0x10
[   90.665292] [   T1841]  ? lock_release+0xfa/0x120
[   90.665295] [   T1841]  ? rcu_read_unlock+0x1c/0x60
[   90.665298] [   T1841]  ? wp_page_reuse+0x160/0x1e0
[   90.665302] [   T1841]  do_syscall_64+0xf4/0x660
[   90.665308] [   T1841]  ? handle_pte_fault+0x54e/0x760
[   90.665312] [   T1841]  ? __pfx_handle_pte_fault+0x10/0x10
[   90.665316] [   T1841]  ? __pfx_pmd_val+0x10/0x10
[   90.665320] [   T1841]  ? __handle_mm_fault+0xa02/0xef0
[   90.665324] [   T1841]  ? do_raw_spin_unlock+0x59/0x230
[   90.665327] [   T1841]  ? __pfx___css_rstat_updated+0x10/0x10
[   90.665334] [   T1841]  ? count_memcg_events+0x37f/0x480
[   90.665339] [   T1841]  ? lock_release+0xfa/0x120
[   90.665343] [   T1841]  ? rcu_read_unlock+0x1c/0x60
[   90.665345] [   T1841]  ? handle_mm_fault+0x4d1/0x7d0
[   90.665349] [   T1841]  ? do_user_addr_fault+0x15d/0xed0
[   90.665353] [   T1841]  ? lock_release+0xfa/0x120
[   90.665357] [   T1841]  ? do_user_addr_fault+0x811/0xed0
[   90.665360] [   T1841]  ? irqentry_exit+0xb0/0x810
[   90.665363] [   T1841]  ? do_syscall_64+0x34/0x660
[   90.665366] [   T1841]  ? trace_hardirqs_on+0x19/0x1a0
[   90.665369] [   T1841]  ? irqentry_exit+0xb5/0x810
[   90.665372] [   T1841]  ? do_syscall_64+0xab/0x660
[   90.665375] [   T1841]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.665378] [   T1841] RIP: 0033:0x7f96f4878bbe
[   90.665383] [   T1841] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   90.665385] [   T1841] RSP: 002b:00007ffcb76eba90 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   90.665390] [   T1841] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   90.665392] [   T1841] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   90.665394] [   T1841] RBP: 00007ffcb76ebaa0 R08: 0000000000000000 R09: =
0000000000000000
[   90.665396] [   T1841] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   90.665397] [   T1841] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5397e70
[   90.665402] [   T1841]  </TASK>

[   91.124911] [   T1841] Allocated by task 1841:
[   91.129401] [   T1841]  kasan_save_stack+0x30/0x50
[   91.134237] [   T1841]  kasan_save_track+0x14/0x30
[   91.139072] [   T1841]  __kasan_kmalloc+0x9a/0xb0
[   91.143822] [   T1841]  __kmalloc_noprof+0x2bb/0x820
[   91.148832] [   T1841]  blk_mq_alloc_sched_tags+0x72/0x2f0
[   91.154364] [   T1841]  blk_mq_alloc_sched_res+0x86/0x220
[   91.159802] [   T1841]  elevator_change+0x113/0x4f0
[   91.164725] [   T1841]  elv_iosched_store+0x30c/0x3a0
[   91.169821] [   T1841]  queue_attr_store+0x23f/0x360
[   91.174832] [   T1841]  kernfs_fop_write_iter+0x3da/0x5e0
[   91.180276] [   T1841]  vfs_write+0x524/0x1010
[   91.184765] [   T1841]  ksys_write+0xff/0x200
[   91.189168] [   T1841]  do_syscall_64+0xf4/0x660
[   91.193833] [   T1841]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   91.202386] [   T1841] Freed by task 1842:
[   91.206535] [   T1841]  kasan_save_stack+0x30/0x50
[   91.211380] [   T1841]  kasan_save_track+0x14/0x30
[   91.216222] [   T1841]  kasan_save_free_info+0x3b/0x70
[   91.221414] [   T1841]  __kasan_slab_free+0x6b/0x90
[   91.226346] [   T1841]  kfree+0x21c/0x620
[   91.230409] [   T1841]  blk_mq_free_sched_res+0x50/0x170
[   91.235777] [   T1841]  elevator_change_done+0x17f/0x690
[   91.241141] [   T1841]  elevator_change+0x283/0x4f0
[   91.246069] [   T1841]  elv_iosched_store+0x30c/0x3a0
[   91.251174] [   T1841]  queue_attr_store+0x23f/0x360
[   91.256195] [   T1841]  kernfs_fop_write_iter+0x3da/0x5e0
[   91.261647] [   T1841]  vfs_write+0x524/0x1010
[   91.266146] [   T1841]  ksys_write+0xff/0x200
[   91.270556] [   T1841]  do_syscall_64+0xf4/0x660
[   91.275227] [   T1841]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   91.283792] [   T1841] The buggy address belongs to the object at ffff88=
818265ad40
                           which belongs to the cache kmalloc-rnd-04-32 of =
size 32
[   91.298776] [   T1841] The buggy address is located 0 bytes inside of
                           freed 32-byte region [ffff88818265ad40, ffff8881=
8265ad60)

[   91.315327] [   T1841] The buggy address belongs to the physical page:
[   91.321911] [   T1841] page: refcount:0 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x18265a
[   91.330919] [   T1841] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpu=
pid=3D0x1fffff)
[   91.338457] [   T1841] page_type: f5(slab)
[   91.342604] [   T1841] raw: 0017ffffc0000000 ffff88810004ca00 dead000000=
000100 dead000000000122
[   91.351361] [   T1841] raw: 0000000000000000 0000000800400040 00000000f5=
000000 0000000000000000
[   91.360116] [   T1841] page dumped because: kasan: bad access detected

[   91.369218] [   T1841] Memory state around the buggy address:
[   91.375028] [   T1841]  ffff88818265ac00: fa fb fb fb fc fc fc fc fc fc =
fc fc fc fc fc fc
[   91.383280] [   T1841]  ffff88818265ac80: fc fc fc fc fc fc fc fc fa fb =
fb fb fc fc fc fc
[   91.391530] [   T1841] >ffff88818265ad00: fc fc fc fc fc fc fc fc fa fb =
fb fb fc fc fc fc
[   91.399782] [   T1841]                                            ^
[   91.406132] [   T1841]  ffff88818265ad80: fc fc fc fc fc fc fc fc fa fb =
fb fb fc fc fc fc
[   91.414400] [   T1841]  ffff88818265ae00: fa fb fb fb fc fc fc fc fa fb =
fb fb fc fc fc fc
[   91.422666] [   T1841] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   91.431032] [   T1841] Oops: general protection fault, probably for non-=
canonical address 0xe066fc31c00000fa: 0000 [#1] SMP KASAN PTI
[   91.449248] [   T1841] KASAN: maybe wild-memory-access in range [0x03380=
18e000007d0-0x0338018e000007d7]
[   91.458755] [   T1841] CPU: 0 UID: 0 PID: 1841 Comm: check Tainted: G   =
 B   W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   91.469576] [   T1841] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[   91.474834] [   T1841] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   91.483316] [   T1841] RIP: 0010:blk_mq_free_rqs+0x38/0x790
[   91.489034] [   T1841] Code: 00 00 fc ff df 41 57 49 89 f7 48 81 c6 a0 0=
0 00 00 41 56 49 89 fe 41 55 41 54 55 53 48 83 ec 48 89 14 24 48 89 f2 48 c=
1 ea 03 <80> 3c 02 00 0f 85 fa 05 00 00 49 8b 87 a0 00 00 00 48 39 c6 0f 84
[   91.509311] [   T1841] RSP: 0018:ffff88815455f530 EFLAGS: 00010206
[   91.515656] [   T1841] RAX: dffffc0000000000 RBX: 0338018e00000732 RCX: =
0000000000000000
[   91.523920] [   T1841] RDX: 00670031c00000fa RSI: 0338018e000007d2 RDI: =
ffff888148d6f838
[   91.532185] [   T1841] RBP: ffff888148d6f838 R08: ffffffffa7baa33a R09: =
fffffbfff5c10688
[   91.540452] [   T1841] R10: fffffbfff5c10689 R11: 0000000000000001 R12: =
ffff88818265ad40
[   91.548727] [   T1841] R13: ffff888148d6f838 R14: ffff888148d6f838 R15: =
0338018e00000732
[   91.557009] [   T1841] FS:  00007f96f4807780(0000) GS:ffff8887afe48000(0=
000) knlGS:0000000000000000
[   91.566248] [   T1841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.573153] [   T1841] CR2: 0000562ec532aa51 CR3: 0000000144fee001 CR4: =
00000000001726f0
[   91.581447] [   T1841] Call Trace:
[   91.585060] [   T1841]  <TASK>
[   91.588325] [   T1841]  blk_mq_free_map_and_rqs+0x23/0x130
[   91.594029] [   T1841]  blk_mq_free_sched_tags+0xbd/0x160
[   91.599636] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   91.605159] [   T1841]  blk_mq_free_sched_res+0x50/0x170
[   91.610681] [   T1841]  elevator_change_done+0x4f6/0x690
[   91.616204] [   T1841]  ? __pfx_elevator_change_done+0x10/0x10
[   91.622245] [   T1841]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   91.628363] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   91.633880] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   91.639384] [   T1841]  elevator_change+0x283/0x4f0
[   91.644453] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   91.649987] [   T1841]  elv_iosched_store+0x30c/0x3a0
[   91.655224] [   T1841]  ? __pfx_elv_iosched_store+0x10/0x10
[   91.660981] [   T1841]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   91.667337] [   T1841]  ? lock_acquire+0x126/0x140
[   91.672301] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   91.677778] [   T1841]  queue_attr_store+0x23f/0x360
[   91.682911] [   T1841]  ? __mutex_lock+0x1536/0x25a0
[   91.688037] [   T1841]  ? __pfx_queue_attr_store+0x10/0x10
[   91.693674] [   T1841]  ? lock_release+0xfa/0x120
[   91.698532] [   T1841]  ? __pfx___mutex_lock+0x10/0x10
[   91.703815] [   T1841]  ? __pfx__copy_from_iter+0x10/0x10
[   91.709362] [   T1841]  ? lock_acquire+0x126/0x140
[   91.714306] [   T1841]  ? lock_acquire+0x126/0x140
[   91.719248] [   T1841]  ? lock_release+0xfa/0x120
[   91.724094] [   T1841]  ? sysfs_file_kobj+0xb9/0x1b0
[   91.729198] [   T1841]  ? sysfs_kf_write+0x65/0x170
[   91.734214] [   T1841]  ? __pfx_sysfs_kf_write+0x10/0x10
[   91.739640] [   T1841]  kernfs_fop_write_iter+0x3da/0x5e0
[   91.745162] [   T1841]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   91.751187] [   T1841]  vfs_write+0x524/0x1010
[   91.755728] [   T1841]  ? __pfx_vfs_write+0x10/0x10
[   91.760694] [   T1841]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   91.766260] [   T1841]  ? __pfx_pte_val+0x10/0x10
[   91.771042] [   T1841]  ksys_write+0xff/0x200
[   91.775465] [   T1841]  ? __pfx_ksys_write+0x10/0x10
[   91.780477] [   T1841]  ? lock_release+0xfa/0x120
[   91.785218] [   T1841]  ? rcu_read_unlock+0x1c/0x60
[   91.790134] [   T1841]  ? wp_page_reuse+0x160/0x1e0
[   91.795053] [   T1841]  do_syscall_64+0xf4/0x660
[   91.799701] [   T1841]  ? handle_pte_fault+0x54e/0x760
[   91.804864] [   T1841]  ? __pfx_handle_pte_fault+0x10/0x10
[   91.810371] [   T1841]  ? __pfx_pmd_val+0x10/0x10
[   91.815090] [   T1841]  ? __handle_mm_fault+0xa02/0xef0
[   91.820327] [   T1841]  ? do_raw_spin_unlock+0x59/0x230
[   91.825555] [   T1841]  ? __pfx___css_rstat_updated+0x10/0x10
[   91.831307] [   T1841]  ? count_memcg_events+0x37f/0x480
[   91.836623] [   T1841]  ? lock_release+0xfa/0x120
[   91.841334] [   T1841]  ? rcu_read_unlock+0x1c/0x60
[   91.846214] [   T1841]  ? handle_mm_fault+0x4d1/0x7d0
[   91.851268] [   T1841]  ? do_user_addr_fault+0x15d/0xed0
[   91.856588] [   T1841]  ? lock_release+0xfa/0x120
[   91.861293] [   T1841]  ? do_user_addr_fault+0x811/0xed0
[   91.866606] [   T1841]  ? irqentry_exit+0xb0/0x810
[   91.871396] [   T1841]  ? do_syscall_64+0x34/0x660
[   91.876188] [   T1841]  ? trace_hardirqs_on+0x19/0x1a0
[   91.881331] [   T1841]  ? irqentry_exit+0xb5/0x810
[   91.886129] [   T1841]  ? do_syscall_64+0xab/0x660
[   91.890926] [   T1841]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   91.896937] [   T1841] RIP: 0033:0x7f96f4878bbe
[   91.901471] [   T1841] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   91.921483] [   T1841] RSP: 002b:00007ffcb76eba90 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   91.930047] [   T1841] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   91.938176] [   T1841] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   91.946306] [   T1841] RBP: 00007ffcb76ebaa0 R08: 0000000000000000 R09: =
0000000000000000
[   91.954436] [   T1841] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   91.962567] [   T1841] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5397e70
[   91.970702] [   T1841]  </TASK>
[   91.973886] [   T1841] Modules linked in: null_blk nft_masq nft_reject_i=
pv4 act_csum cls_u32 sch_htb nf_nat_tftp nf_conntrack_tftp bridge stp llc t=
arget_core_user target_core_mod rfkill nf_conntrack_netbios_ns nf_conntrack=
_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet n=
f_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat i=
p6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_securit=
y nf_tables ip6table_filter ip6_tables iptable_filter ip_tables qrtr intel_=
rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp co=
retemp kvm_intel iTCO_wdt intel_pmc_bxt kvm irqbypass rapl sunrpc intel_cst=
ate intel_uncore pcspkr i2c_i801 i2c_smbus igb mei_me lpc_ich mei ioatdma d=
ca wmi binfmt_misc joydev acpi_pad acpi_power_meter btrfs raid6_pq xor ses =
enclosure loop dm_multipath nfnetlink zram lz4hc_compress lz4_compress zstd=
_compress ast drm_client_lib i2c_algo_bit drm_shmem_helper
[   91.974026] [   T1841]  drm_kms_helper drm mpt3sas mpi3mr raid_class scs=
i_transport_sas scsi_dh_rdac scsi_dh_emc scsi_dh_alua i2c_dev fuse
[   92.080026] [   T1841] ---[ end trace 0000000000000000 ]---
[   92.106503] [   T1841] pstore: backend (erst) writing error (-28)
[   92.112860] [   T1841] RIP: 0010:blk_mq_free_rqs+0x38/0x790
[   92.118708] [   T1841] Code: 00 00 fc ff df 41 57 49 89 f7 48 81 c6 a0 0=
0 00 00 41 56 49 89 fe 41 55 41 54 55 53 48 83 ec 48 89 14 24 48 89 f2 48 c=
1 ea 03 <80> 3c 02 00 0f 85 fa 05 00 00 49 8b 87 a0 00 00 00 48 39 c6 0f 84
[   92.139931] [   T1841] RSP: 0018:ffff88815455f530 EFLAGS: 00010206
[   92.140007] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   92.145981] [   T1841] RAX: dffffc0000000000 RBX: 0338018e00000732 RCX: =
0000000000000000
[   92.155553] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   92.155560] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   92.155561] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   92.155563] [   T1842] Call Trace:
[   92.155564] [   T1842]  <TASK>
[   92.155566] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   92.155624] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   92.155644] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   92.155652] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   92.155666] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   92.155672] [   T1842]  ? kfree+0x1d6/0x620
[   92.155682] [   T1842]  kobject_add_internal+0x26f/0x800
[   92.155690] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.155693] [   T1842]  kobject_add+0x139/0x1a0
[   92.155696] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   92.155703] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   92.155707] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   92.155710] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   92.155713] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   92.155716] [   T1842]  elevator_change_done+0x26f/0x690
[   92.155725] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   92.155728] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   92.155733] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.155737] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.155740] [   T1842]  elevator_change+0x283/0x4f0
[   92.155749] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.155752] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   92.155755] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   92.155759] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   92.155764] [   T1842]  ? lock_acquire+0x126/0x140
[   92.155773] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.155776] [   T1842]  queue_attr_store+0x23f/0x360
[   92.155779] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   92.155782] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   92.155785] [   T1842]  ? lock_release+0xfa/0x120
[   92.155793] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   92.155796] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   92.155801] [   T1842]  ? lock_acquire+0x126/0x140
[   92.155804] [   T1842]  ? lock_acquire+0x126/0x140
[   92.155807] [   T1842]  ? lock_release+0xfa/0x120
[   92.155811] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   92.155816] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   92.155820] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.155823] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   92.155826] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   92.155829] [   T1842]  vfs_write+0x524/0x1010
[   92.155843] [   T1842]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   92.155845] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   92.155850] [   T1842]  ? do_fcntl+0x605/0x1030
[   92.155860] [   T1842]  ? __pfx_do_fcntl+0x10/0x10
[   92.155864] [   T1842]  ksys_write+0xff/0x200
[   92.155867] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   92.155869] [   T1842]  ? selinux_file_fcntl+0x1e/0x110
[   92.155876] [   T1842]  ? __pfx_pte_val+0x10/0x10
[   92.155881] [   T1842]  do_syscall_64+0xf4/0x660
[   92.155885] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[   92.155888] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[   92.155892] [   T1842]  ? __pfx_ptep_set_access_flags+0x10/0x10
[   92.155897] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   92.155901] [   T1842]  ? lock_release+0xfa/0x120
[   92.155904] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   92.155907] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[   92.155911] [   T1842]  ? do_wp_page+0x57e/0xf40
[   92.155917] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   92.155959] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   92.155982] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[   92.155991] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   92.155998] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   92.156003] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   92.156017] [   T1842]  ? count_memcg_events+0x37f/0x480
[   92.156028] [   T1842]  ? lock_release+0xfa/0x120
[   92.156033] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   92.156036] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   92.156039] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   92.156044] [   T1842]  ? lock_release+0xfa/0x120
[   92.156057] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   92.156060] [   T1842]  ? irqentry_exit+0xb0/0x810
[   92.156063] [   T1842]  ? do_syscall_64+0x34/0x660
[   92.156066] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   92.156073] [   T1842]  ? irqentry_exit+0xb5/0x810
[   92.156075] [   T1842]  ? do_syscall_64+0xab/0x660
[   92.156079] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   92.156081] [   T1842] RIP: 0033:0x7f96f4878bbe
[   92.156085] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   92.156087] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   92.156096] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   92.156098] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   92.156100] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   92.156102] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   92.156103] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5394f20
[   92.156108] [   T1842]  </TASK>
[   92.156122] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   92.163427] [   T1841] RDX: 00670031c00000fa RSI: 0338018e000007d2 RDI: =
ffff888148d6f838
[   92.701628] [   T1841] RBP: ffff888148d6f838 R08: ffffffffa7baa33a R09: =
fffffbfff5c10688
[   92.717075] [   T1841] R10: fffffbfff5c10689 R11: 0000000000000001 R12: =
ffff88818265ad40
[   92.732771] [   T1841] R13: ffff888148d6f838 R14: ffff888148d6f838 R15: =
0338018e00000732
[   92.748062] [   T1841] FS:  00007f96f4807780(0000) GS:ffff8887aff48000(0=
000) knlGS:0000000000000000
[   92.763917] [   T1841] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.779232] [   T1841] CR2: 0000562ec532aa50 CR3: 0000000144fee003 CR4: =
00000000001726f0
[   92.831074] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   92.841145] [   T1842] CPU: 3 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   92.841152] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   92.841154] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   92.841155] [   T1842] Call Trace:
[   92.841157] [   T1842]  <TASK>
[   92.841159] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   92.841168] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   92.841173] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   92.841179] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   92.841183] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   92.841188] [   T1842]  ? kfree+0x1d6/0x620
[   92.841192] [   T1842]  kobject_add_internal+0x26f/0x800
[   92.841197] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.841200] [   T1842]  kobject_add+0x139/0x1a0
[   92.841203] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   92.841208] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   92.841212] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   92.841215] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   92.841219] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   92.841222] [   T1842]  elevator_change_done+0x26f/0x690
[   92.841227] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   92.841230] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   92.841236] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.841239] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.841242] [   T1842]  elevator_change+0x283/0x4f0
[   92.841246] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.841249] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   92.841253] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   92.841256] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   92.841261] [   T1842]  ? lock_acquire+0x126/0x140
[   92.841266] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.841269] [   T1842]  queue_attr_store+0x23f/0x360
[   92.841273] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   92.841276] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   92.841279] [   T1842]  ? lock_release+0xfa/0x120
[   92.841283] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   92.841286] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   92.841290] [   T1842]  ? lock_acquire+0x126/0x140
[   92.841294] [   T1842]  ? lock_acquire+0x126/0x140
[   92.841297] [   T1842]  ? lock_release+0xfa/0x120
[   92.841301] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   92.841304] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   92.841307] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   92.841310] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   92.841314] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   92.841317] [   T1842]  vfs_write+0x524/0x1010
[   92.841321] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   92.841327] [   T1842]  ksys_write+0xff/0x200
[   92.841330] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   92.841333] [   T1842]  ? count_memcg_events+0x37f/0x480
[   92.841338] [   T1842]  do_syscall_64+0xf4/0x660
[   92.841342] [   T1842]  ? lock_release+0xfa/0x120
[   92.841345] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   92.841349] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   92.841353] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   92.841358] [   T1842]  ? lock_release+0xfa/0x120
[   92.841362] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   92.841365] [   T1842]  ? irqentry_exit+0xb0/0x810
[   92.841368] [   T1842]  ? do_syscall_64+0x34/0x660
[   92.841371] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   92.841374] [   T1842]  ? irqentry_exit+0xb5/0x810
[   92.841376] [   T1842]  ? do_syscall_64+0xab/0x660
[   92.841380] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   92.841382] [   T1842] RIP: 0033:0x7f96f4878bbe
[   92.841386] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   92.841389] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   92.841393] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   92.841395] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   92.841397] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   92.841398] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   92.841400] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5382090
[   92.841405] [   T1842]  </TASK>
[   92.841410] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   93.347152] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   93.357995] [   T1842] CPU: 7 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   93.358003] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   93.358004] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   93.358006] [   T1842] Call Trace:
[   93.358008] [   T1842]  <TASK>
[   93.358015] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   93.358025] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   93.358030] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   93.358042] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   93.358047] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   93.358051] [   T1842]  ? kasan_save_track+0x14/0x30
[   93.358060] [   T1842]  ? kfree+0x1d6/0x620
[   93.358064] [   T1842]  kobject_add_internal+0x26f/0x800
[   93.358071] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.358074] [   T1842]  kobject_add+0x139/0x1a0
[   93.358085] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   93.358090] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   93.358094] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   93.358097] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   93.358109] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   93.358112] [   T1842]  elevator_change_done+0x26f/0x690
[   93.358122] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   93.358125] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   93.358131] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.358134] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.358137] [   T1842]  elevator_change+0x283/0x4f0
[   93.358144] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.358147] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   93.358151] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   93.358154] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.358160] [   T1842]  ? lock_acquire+0x126/0x140
[   93.358181] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.358190] [   T1842]  queue_attr_store+0x23f/0x360
[   93.358195] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   93.358198] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   93.358200] [   T1842]  ? lock_release+0xfa/0x120
[   93.358204] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   93.358211] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   93.358216] [   T1842]  ? lock_acquire+0x126/0x140
[   93.358219] [   T1842]  ? lock_acquire+0x126/0x140
[   93.358223] [   T1842]  ? lock_release+0xfa/0x120
[   93.358226] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   93.358238] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   93.358241] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.358244] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   93.358248] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   93.358254] [   T1842]  vfs_write+0x524/0x1010
[   93.358259] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   93.358262] [   T1842]  ? __pfx_pte_val+0x10/0x10
[   93.358266] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[   93.358274] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[   93.358280] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   93.358282] [   T1842]  ? lock_release+0xfa/0x120
[   93.358285] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   93.358290] [   T1842]  ksys_write+0xff/0x200
[   93.358297] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   93.358300] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   93.358305] [   T1842]  do_syscall_64+0xf4/0x660
[   93.358310] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[   93.358317] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   93.358324] [   T1842]  ? fput_close+0x137/0x1a0
[   93.358328] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   93.358349] [   T1842]  ? count_memcg_events+0x37f/0x480
[   93.358365] [   T1842]  ? lock_release+0xfa/0x120
[   93.358371] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   93.358375] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   93.358381] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   93.358390] [   T1842]  ? lock_release+0xfa/0x120
[   93.358395] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   93.358400] [   T1842]  ? irqentry_exit+0xb0/0x810
[   93.358415] [   T1842]  ? do_syscall_64+0x34/0x660
[   93.358420] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   93.358427] [   T1842]  ? irqentry_exit+0xb5/0x810
[   93.358430] [   T1842]  ? do_syscall_64+0xab/0x660
[   93.358436] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.358440] [   T1842] RIP: 0033:0x7f96f4878bbe
[   93.358450] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   93.358453] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   93.358459] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   93.358462] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   93.358465] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   93.358469] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[   93.358471] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec53929c0
[   93.358478] [   T1842]  </TASK>
[   93.358495] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   93.906005] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   93.916008] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   93.916015] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   93.916017] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   93.916018] [   T1842] Call Trace:
[   93.916020] [   T1842]  <TASK>
[   93.916022] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   93.916031] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   93.916037] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   93.916043] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   93.916048] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   93.916052] [   T1842]  ? kfree+0x1d6/0x620
[   93.916056] [   T1842]  kobject_add_internal+0x26f/0x800
[   93.916062] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.916065] [   T1842]  kobject_add+0x139/0x1a0
[   93.916069] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   93.916073] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   93.916077] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   93.916080] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   93.916085] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   93.916088] [   T1842]  elevator_change_done+0x26f/0x690
[   93.916093] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   93.916096] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   93.916102] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.916106] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.916109] [   T1842]  elevator_change+0x283/0x4f0
[   93.916113] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.916116] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   93.916120] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   93.916123] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.916129] [   T1842]  ? lock_acquire+0x126/0x140
[   93.916133] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.916137] [   T1842]  queue_attr_store+0x23f/0x360
[   93.916141] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   93.916144] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   93.916146] [   T1842]  ? lock_release+0xfa/0x120
[   93.916150] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   93.916154] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   93.916158] [   T1842]  ? lock_acquire+0x126/0x140
[   93.916162] [   T1842]  ? lock_acquire+0x126/0x140
[   93.916165] [   T1842]  ? lock_release+0xfa/0x120
[   93.916169] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   93.916172] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   93.916176] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   93.916179] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   93.916183] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   93.916185] [   T1842]  vfs_write+0x524/0x1010
[   93.916189] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   93.916193] [   T1842]  ? fput_close+0x137/0x1a0
[   93.916198] [   T1842]  ? __pfx_pte_val+0x10/0x10
[   93.916202] [   T1842]  ksys_write+0xff/0x200
[   93.916205] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   93.916208] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   93.916211] [   T1842]  ? lock_release+0xfa/0x120
[   93.916215] [   T1842]  do_syscall_64+0xf4/0x660
[   93.916219] [   T1842]  ? do_wp_page+0x57e/0xf40
[   93.916224] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   93.916228] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   93.916231] [   T1842]  ? fput_close_sync+0x137/0x1a0
[   93.916234] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[   93.916238] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   93.916242] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   93.916249] [   T1842]  ? count_memcg_events+0x37f/0x480
[   93.916255] [   T1842]  ? lock_release+0xfa/0x120
[   93.916258] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   93.916261] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   93.916265] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   93.916270] [   T1842]  ? lock_release+0xfa/0x120
[   93.916274] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   93.916277] [   T1842]  ? irqentry_exit+0xb0/0x810
[   93.916280] [   T1842]  ? do_syscall_64+0x34/0x660
[   93.916283] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   93.916286] [   T1842]  ? irqentry_exit+0xb5/0x810
[   93.916289] [   T1842]  ? do_syscall_64+0xab/0x660
[   93.916292] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   93.916295] [   T1842] RIP: 0033:0x7f96f4878bbe
[   93.916299] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   93.916302] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   93.916306] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   93.916308] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   93.916310] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   93.916311] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   93.916313] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5397300
[   93.916318] [   T1842]  </TASK>
[   93.916324] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   94.437220] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   94.447276] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   94.447287] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   94.447289] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   94.447292] [   T1842] Call Trace:
[   94.447295] [   T1842]  <TASK>
[   94.447297] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   94.447310] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   94.447317] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   94.447326] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   94.447333] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   94.447338] [   T1842]  ? kasan_save_track+0x14/0x30
[   94.447344] [   T1842]  ? kfree+0x1d6/0x620
[   94.447350] [   T1842]  kobject_add_internal+0x26f/0x800
[   94.447390] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   94.447455] [   T1842]  kobject_add+0x139/0x1a0
[   94.447521] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   94.447630] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   94.447696] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   94.447761] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   94.447849] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   94.447915] [   T1842]  elevator_change_done+0x26f/0x690
[   94.447943] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   94.447947] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   94.448008] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   94.448094] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   94.448117] [   T1842]  elevator_change+0x283/0x4f0
[   94.448204] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   94.448291] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   94.448379] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   94.448422] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   94.448552] [   T1842]  ? lock_acquire+0x126/0x140
[   94.448619] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   94.448684] [   T1842]  queue_attr_store+0x23f/0x360
[   94.448771] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   94.448837] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   94.448880] [   T1842]  ? lock_release+0xfa/0x120
[   94.448926] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   94.448933] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   94.449011] [   T1842]  ? lock_acquire+0x126/0x140
[   94.449077] [   T1842]  ? lock_acquire+0x126/0x140
[   94.449121] [   T1842]  ? lock_release+0xfa/0x120
[   94.449186] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   94.449251] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   94.449296] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   94.449360] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   94.449426] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   94.449513] [   T1842]  vfs_write+0x524/0x1010
[   94.449622] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   94.449688] [   T1842]  ksys_write+0xff/0x200
[   94.449732] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   94.449797] [   T1842]  ? lock_release+0xfa/0x120
[   94.449862] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   94.449933] [   T1842]  do_syscall_64+0xf4/0x660
[   94.449940] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   94.449945] [   T1842]  ? irqentry_exit+0xb5/0x810
[   94.449961] [   T1842]  ? do_syscall_64+0xab/0x660
[   94.449983] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   94.449988] [   T1842] RIP: 0033:0x7f96f4878bbe
[   94.450027] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   94.450071] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   94.450179] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   94.450223] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   94.450246] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   94.450289] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[   94.450311] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec5395410
[   94.450420] [   T1842]  </TASK>
[   95.163048] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   95.211096] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   95.221135] [   T1842] CPU: 7 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   95.221215] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   95.221258] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   95.221260] [   T1842] Call Trace:
[   95.221303] [   T1842]  <TASK>
[   95.221367] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   95.221528] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   95.221636] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   95.221768] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   95.221855] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   95.221943] [   T1842]  ? kfree+0x1d6/0x620
[   95.221950] [   T1842]  kobject_add_internal+0x26f/0x800
[   95.221958] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   95.222036] [   T1842]  kobject_add+0x139/0x1a0
[   95.222102] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   95.222210] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   95.222297] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   95.222363] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   95.222451] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   95.222495] [   T1842]  elevator_change_done+0x26f/0x690
[   95.222624] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   95.222690] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   95.222798] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   95.222865] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   95.222930] [   T1842]  elevator_change+0x283/0x4f0
[   95.222958] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   95.222963] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   95.222969] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   95.222974] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   95.222984] [   T1842]  ? lock_acquire+0x126/0x140
[   95.222992] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   95.222997] [   T1842]  queue_attr_store+0x23f/0x360
[   95.223003] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   95.223009] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   95.223014] [   T1842]  ? lock_release+0xfa/0x120
[   95.223031] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   95.223117] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   95.223204] [   T1842]  ? lock_acquire+0x126/0x140
[   95.223249] [   T1842]  ? lock_acquire+0x126/0x140
[   95.223314] [   T1842]  ? lock_release+0xfa/0x120
[   95.223379] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   95.223444] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   95.223489] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   95.223553] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   95.223640] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   95.223684] [   T1842]  vfs_write+0x524/0x1010
[   95.223772] [   T1842]  ? __pfx_locks_remove_posix+0x10/0x10
[   95.223902] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   95.223953] [   T1842]  ksys_write+0xff/0x200
[   95.223972] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   95.223977] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   95.224036] [   T1842]  ? lock_release+0xfa/0x120
[   95.224122] [   T1842]  do_syscall_64+0xf4/0x660
[   95.224189] [   T1842]  ? do_wp_page+0x57e/0xf40
[   95.224256] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   95.224340] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   95.224385] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[   95.224429] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   95.224516] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   95.224690] [   T1842]  ? count_memcg_events+0x37f/0x480
[   95.224777] [   T1842]  ? lock_release+0xfa/0x120
[   95.224843] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   95.224908] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   95.224954] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   95.224973] [   T1842]  ? lock_release+0xfa/0x120
[   95.225039] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   95.225084] [   T1842]  ? irqentry_exit+0xb0/0x810
[   95.225148] [   T1842]  ? do_syscall_64+0x34/0x660
[   95.225214] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   95.225279] [   T1842]  ? irqentry_exit+0xb5/0x810
[   95.225322] [   T1842]  ? do_syscall_64+0xab/0x660
[   95.225388] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   95.225454] [   T1842] RIP: 0033:0x7f96f4878bbe
[   95.225562] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   95.225628] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   95.225715] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   95.225780] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   95.225803] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   95.225846] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   95.225890] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5395360
[   95.225959] [   T1842]  </TASK>
[   96.121095] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   96.243207] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   96.254050] [   T1842] CPU: 7 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   96.254058] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   96.254064] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   96.254066] [   T1842] Call Trace:
[   96.254068] [   T1842]  <TASK>
[   96.254070] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   96.254079] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   96.254089] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   96.254096] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   96.254100] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   96.254111] [   T1842]  ? kfree+0x1d6/0x620
[   96.254115] [   T1842]  kobject_add_internal+0x26f/0x800
[   96.254121] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.254127] [   T1842]  kobject_add+0x139/0x1a0
[   96.254131] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   96.254135] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   96.254139] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   96.254142] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   96.254151] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   96.254154] [   T1842]  elevator_change_done+0x26f/0x690
[   96.254159] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   96.254162] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   96.254170] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.254174] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.254177] [   T1842]  elevator_change+0x283/0x4f0
[   96.254180] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.254183] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   96.254187] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   96.254192] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   96.254198] [   T1842]  ? lock_acquire+0x126/0x140
[   96.254202] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.254205] [   T1842]  queue_attr_store+0x23f/0x360
[   96.254209] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   96.254216] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   96.254219] [   T1842]  ? lock_release+0xfa/0x120
[   96.254223] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   96.254227] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   96.254231] [   T1842]  ? lock_acquire+0x126/0x140
[   96.254235] [   T1842]  ? lock_acquire+0x126/0x140
[   96.254238] [   T1842]  ? lock_release+0xfa/0x120
[   96.254242] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   96.254245] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   96.254248] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.254251] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   96.254265] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   96.254268] [   T1842]  vfs_write+0x524/0x1010
[   96.254272] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   96.254284] [   T1842]  ksys_write+0xff/0x200
[   96.254287] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   96.254290] [   T1842]  ? lock_release+0xfa/0x120
[   96.254294] [   T1842]  do_syscall_64+0xf4/0x660
[   96.254301] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   96.254307] [   T1842]  ? lock_release+0xfa/0x120
[   96.254310] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   96.254314] [   T1842]  ? irqentry_exit+0xb0/0x810
[   96.254316] [   T1842]  ? do_syscall_64+0x34/0x660
[   96.254321] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   96.254326] [   T1842]  ? irqentry_exit+0xb5/0x810
[   96.254328] [   T1842]  ? do_syscall_64+0xab/0x660
[   96.254331] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   96.254334] [   T1842] RIP: 0033:0x7f96f4878bbe
[   96.254338] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   96.254348] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   96.254352] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   96.254354] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   96.254356] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   96.254357] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   96.254359] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec53956a0
[   96.254373] [   T1842]  </TASK>
[   96.254379] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   96.715123] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   96.725123] [   T1842] CPU: 3 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   96.725129] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   96.725131] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   96.725133] [   T1842] Call Trace:
[   96.725135] [   T1842]  <TASK>
[   96.725136] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   96.725145] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   96.725150] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   96.725156] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   96.725161] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   96.725165] [   T1842]  ? kfree+0x1d6/0x620
[   96.725169] [   T1842]  kobject_add_internal+0x26f/0x800
[   96.725175] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.725178] [   T1842]  kobject_add+0x139/0x1a0
[   96.725181] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   96.725185] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   96.725189] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   96.725192] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   96.725196] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   96.725199] [   T1842]  elevator_change_done+0x26f/0x690
[   96.725204] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   96.725207] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   96.725212] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.725216] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.725219] [   T1842]  elevator_change+0x283/0x4f0
[   96.725223] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.725226] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   96.725230] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   96.725233] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   96.725238] [   T1842]  ? lock_acquire+0x126/0x140
[   96.725243] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.725245] [   T1842]  queue_attr_store+0x23f/0x360
[   96.725249] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   96.725252] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   96.725255] [   T1842]  ? lock_release+0xfa/0x120
[   96.725259] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   96.725262] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   96.725267] [   T1842]  ? lock_acquire+0x126/0x140
[   96.725270] [   T1842]  ? lock_acquire+0x126/0x140
[   96.725274] [   T1842]  ? lock_release+0xfa/0x120
[   96.725277] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   96.725280] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   96.725284] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   96.725286] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   96.725290] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   96.725293] [   T1842]  vfs_write+0x524/0x1010
[   96.725297] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   96.725302] [   T1842]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   96.725304] [   T1842]  ? lock_acquire+0x126/0x140
[   96.725308] [   T1842]  ksys_write+0xff/0x200
[   96.725311] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   96.725314] [   T1842]  ? __pfx_pte_val+0x10/0x10
[   96.725318] [   T1842]  ? folio_xchg_last_cpupid+0xc6/0x130
[   96.725323] [   T1842]  do_syscall_64+0xf4/0x660
[   96.725327] [   T1842]  ? __pfx_ptep_set_access_flags+0x10/0x10
[   96.725331] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   96.725334] [   T1842]  ? lock_release+0xfa/0x120
[   96.725337] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   96.725340] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[   96.725344] [   T1842]  ? do_wp_page+0x57e/0xf40
[   96.725348] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   96.725352] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   96.725355] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[   96.725359] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   96.725363] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   96.725370] [   T1842]  ? count_memcg_events+0x37f/0x480
[   96.725375] [   T1842]  ? lock_release+0xfa/0x120
[   96.725378] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   96.725381] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   96.725385] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   96.725389] [   T1842]  ? lock_release+0xfa/0x120
[   96.725393] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   96.725396] [   T1842]  ? irqentry_exit+0xb0/0x810
[   96.725399] [   T1842]  ? do_syscall_64+0x34/0x660
[   96.725402] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   96.725405] [   T1842]  ? irqentry_exit+0xb5/0x810
[   96.725407] [   T1842]  ? do_syscall_64+0xab/0x660
[   96.725411] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   96.725413] [   T1842] RIP: 0033:0x7f96f4878bbe
[   96.725417] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   96.725419] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   96.725423] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   96.725425] [   T1842] RDX: 0000000000000004 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   96.725427] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   96.725429] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000004
[   96.725430] [   T1842] R13: 0000000000000004 R14: 0000562ec532aa50 R15: =
0000562ec5399dc0
[   96.725435] [   T1842]  </TASK>
[   96.725440] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   97.266189] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   97.276171] [   T1842] CPU: 7 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   97.276178] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   97.276179] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   97.276181] [   T1842] Call Trace:
[   97.276183] [   T1842]  <TASK>
[   97.276185] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   97.276194] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   97.276199] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   97.276206] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   97.276210] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   97.276214] [   T1842]  ? kasan_save_track+0x14/0x30
[   97.276218] [   T1842]  ? kfree+0x1d6/0x620
[   97.276222] [   T1842]  kobject_add_internal+0x26f/0x800
[   97.276228] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.276232] [   T1842]  kobject_add+0x139/0x1a0
[   97.276235] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   97.276239] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   97.276243] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   97.276246] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   97.276250] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   97.276253] [   T1842]  elevator_change_done+0x26f/0x690
[   97.276259] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   97.276262] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   97.276268] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.276272] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.276275] [   T1842]  elevator_change+0x283/0x4f0
[   97.276279] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.276282] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   97.276286] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   97.276289] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.276295] [   T1842]  ? lock_acquire+0x126/0x140
[   97.276300] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.276303] [   T1842]  queue_attr_store+0x23f/0x360
[   97.276307] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   97.276310] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   97.276313] [   T1842]  ? lock_release+0xfa/0x120
[   97.276317] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   97.276321] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   97.276325] [   T1842]  ? lock_acquire+0x126/0x140
[   97.276329] [   T1842]  ? lock_acquire+0x126/0x140
[   97.276332] [   T1842]  ? lock_release+0xfa/0x120
[   97.276336] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   97.276339] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   97.276343] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.276345] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   97.276349] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   97.276352] [   T1842]  vfs_write+0x524/0x1010
[   97.276356] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   97.276361] [   T1842]  ? __pfx_fput_close_sync+0x10/0x10
[   97.276365] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   97.276369] [   T1842]  ksys_write+0xff/0x200
[   97.276372] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   97.276374] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[   97.276378] [   T1842]  ? __pfx_ptep_set_access_flags+0x10/0x10
[   97.276381] [   T1842]  do_syscall_64+0xf4/0x660
[   97.276386] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   97.276390] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[   97.276394] [   T1842]  ? do_wp_page+0x57e/0xf40
[   97.276398] [   T1842]  ? handle_pte_fault+0x54e/0x760
[   97.276402] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   97.276406] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[   97.276410] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   97.276414] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   97.276422] [   T1842]  ? count_memcg_events+0x37f/0x480
[   97.276428] [   T1842]  ? lock_release+0xfa/0x120
[   97.276431] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   97.276434] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   97.276437] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   97.276443] [   T1842]  ? lock_release+0xfa/0x120
[   97.276446] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   97.276450] [   T1842]  ? irqentry_exit+0xb0/0x810
[   97.276452] [   T1842]  ? do_syscall_64+0x34/0x660
[   97.276456] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   97.276458] [   T1842]  ? irqentry_exit+0xb5/0x810
[   97.276461] [   T1842]  ? do_syscall_64+0xab/0x660
[   97.276464] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.276467] [   T1842] RIP: 0033:0x7f96f4878bbe
[   97.276470] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   97.276473] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   97.276477] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   97.276479] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   97.276481] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   97.276483] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[   97.276484] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec53972c0
[   97.276489] [   T1842]  </TASK>
[   97.276495] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   97.804201] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   97.814639] [   T1842] CPU: 7 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   97.814813] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   97.814835] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   97.814879] [   T1842] Call Trace:
[   97.814923] [   T1842]  <TASK>
[   97.814988] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   97.815022] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   97.815123] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   97.815233] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   97.815320] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   97.815407] [   T1842]  ? kfree+0x1d6/0x620
[   97.815494] [   T1842]  kobject_add_internal+0x26f/0x800
[   97.815605] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.815669] [   T1842]  kobject_add+0x139/0x1a0
[   97.815734] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   97.815843] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   97.815888] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   97.815931] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   97.815998] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   97.816004] [   T1842]  elevator_change_done+0x26f/0x690
[   97.816105] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   97.816149] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   97.816237] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.816323] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.816367] [   T1842]  elevator_change+0x283/0x4f0
[   97.816454] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.816520] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   97.816564] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   97.816585] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.816672] [   T1842]  ? lock_acquire+0x126/0x140
[   97.816803] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.816847] [   T1842]  queue_attr_store+0x23f/0x360
[   97.816935] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   97.817002] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   97.817007] [   T1842]  ? lock_release+0xfa/0x120
[   97.817014] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   97.817052] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   97.817073] [   T1842]  ? lock_acquire+0x126/0x140
[   97.817139] [   T1842]  ? lock_acquire+0x126/0x140
[   97.817183] [   T1842]  ? lock_release+0xfa/0x120
[   97.817205] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   97.817269] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   97.817335] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   97.817400] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   97.817467] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   97.817509] [   T1842]  vfs_write+0x524/0x1010
[   97.817597] [   T1842]  ? folio_xchg_last_cpupid+0xc6/0x130
[   97.817667] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   97.817684] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[   97.817772] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[   97.817859] [   T1842]  ? do_wp_page+0x57e/0xf40
[   97.817926] [   T1842]  ksys_write+0xff/0x200
[   97.817989] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   97.818005] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   97.818033] [   T1842]  do_syscall_64+0xf4/0x660
[   97.818103] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   97.818143] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   97.818295] [   T1842]  ? count_memcg_events+0x37f/0x480
[   97.818405] [   T1842]  ? lock_release+0xfa/0x120
[   97.818471] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   97.818557] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   97.818624] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   97.818733] [   T1842]  ? lock_release+0xfa/0x120
[   97.818818] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   97.818885] [   T1842]  ? irqentry_exit+0xb0/0x810
[   97.818929] [   T1842]  ? do_syscall_64+0x34/0x660
[   97.818995] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   97.819000] [   T1842]  ? irqentry_exit+0xb5/0x810
[   97.819016] [   T1842]  ? do_syscall_64+0xab/0x660
[   97.819103] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   97.819169] [   T1842] RIP: 0033:0x7f96f4878bbe
[   97.819256] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   97.819300] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   97.819408] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   97.819452] [   T1842] RDX: 0000000000000004 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   97.819475] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   97.819539] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000004
[   97.819543] [   T1842] R13: 0000000000000004 R14: 0000562ec532aa50 R15: =
0000562ec53997a0
[   97.819649] [   T1842]  </TASK>
[   98.701369] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   98.743363] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   98.753340] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   98.753346] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   98.753347] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   98.753349] [   T1842] Call Trace:
[   98.753351] [   T1842]  <TASK>
[   98.753353] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   98.753362] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   98.753367] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   98.753373] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   98.753377] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   98.753381] [   T1842]  ? kasan_save_track+0x14/0x30
[   98.753385] [   T1842]  ? kfree+0x1d6/0x620
[   98.753388] [   T1842]  kobject_add_internal+0x26f/0x800
[   98.753395] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   98.753398] [   T1842]  kobject_add+0x139/0x1a0
[   98.753402] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   98.753406] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   98.753410] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   98.753413] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   98.753417] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   98.753420] [   T1842]  elevator_change_done+0x26f/0x690
[   98.753426] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   98.753429] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   98.753435] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   98.753439] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   98.753442] [   T1842]  elevator_change+0x283/0x4f0
[   98.753446] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   98.753449] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   98.753453] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   98.753456] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   98.753461] [   T1842]  ? lock_acquire+0x126/0x140
[   98.753466] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   98.753469] [   T1842]  queue_attr_store+0x23f/0x360
[   98.753473] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   98.753476] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   98.753479] [   T1842]  ? lock_release+0xfa/0x120
[   98.753482] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   98.753486] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   98.753490] [   T1842]  ? lock_acquire+0x126/0x140
[   98.753494] [   T1842]  ? lock_acquire+0x126/0x140
[   98.753497] [   T1842]  ? lock_release+0xfa/0x120
[   98.753501] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   98.753504] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   98.753508] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   98.753510] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   98.753514] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   98.753517] [   T1842]  vfs_write+0x524/0x1010
[   98.753521] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[   98.753525] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   98.753528] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[   98.753534] [   T1842]  ? count_memcg_events+0x37f/0x480
[   98.753540] [   T1842]  ksys_write+0xff/0x200
[   98.753543] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   98.753545] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   98.753550] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   98.753556] [   T1842]  do_syscall_64+0xf4/0x660
[   98.753561] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   98.753565] [   T1842]  ? irqentry_exit+0xb0/0x810
[   98.753567] [   T1842]  ? do_syscall_64+0x34/0x660
[   98.753571] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   98.753573] [   T1842]  ? irqentry_exit+0xb5/0x810
[   98.753576] [   T1842]  ? do_syscall_64+0xab/0x660
[   98.753579] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   98.753582] [   T1842] RIP: 0033:0x7f96f4878bbe
[   98.753585] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   98.753588] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   98.753592] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   98.753594] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   98.753596] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   98.753598] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[   98.753599] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec5399990
[   98.753604] [   T1842]  </TASK>
[   98.753610] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[   99.221237] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[   99.231263] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[   99.231273] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[   99.231275] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   99.231278] [   T1842] Call Trace:
[   99.231280] [   T1842]  <TASK>
[   99.231283] [   T1842]  dump_stack_lvl+0x6e/0xa0
[   99.231295] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[   99.231355] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[   99.231528] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[   99.231594] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   99.231660] [   T1842]  ? kfree+0x1d6/0x620
[   99.231726] [   T1842]  kobject_add_internal+0x26f/0x800
[   99.231855] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   99.231921] [   T1842]  kobject_add+0x139/0x1a0
[   99.231965] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[   99.232031] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[   99.232039] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[   99.232044] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[   99.232081] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[   99.232126] [   T1842]  elevator_change_done+0x26f/0x690
[   99.232234] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[   99.232278] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   99.232387] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   99.232452] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   99.232496] [   T1842]  elevator_change+0x283/0x4f0
[   99.232583] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   99.232649] [   T1842]  elv_iosched_store+0x30c/0x3a0
[   99.232715] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[   99.232801] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   99.232888] [   T1842]  ? lock_acquire+0x126/0x140
[   99.232955] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   99.233019] [   T1842]  queue_attr_store+0x23f/0x360
[   99.233047] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[   99.233052] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[   99.233057] [   T1842]  ? lock_release+0xfa/0x120
[   99.233063] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[   99.233070] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[   99.233077] [   T1842]  ? lock_acquire+0x126/0x140
[   99.233082] [   T1842]  ? lock_acquire+0x126/0x140
[   99.233089] [   T1842]  ? lock_release+0xfa/0x120
[   99.233094] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[   99.233100] [   T1842]  ? sysfs_kf_write+0x65/0x170
[   99.233106] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[   99.233163] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[   99.233208] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[   99.233228] [   T1842]  vfs_write+0x524/0x1010
[   99.233294] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   99.233381] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[   99.233447] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[   99.233584] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[   99.233671] [   T1842]  ksys_write+0xff/0x200
[   99.233737] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[   99.233824] [   T1842]  do_syscall_64+0xf4/0x660
[   99.233913] [   T1842]  ? count_memcg_events+0x37f/0x480
[   99.233977] [   T1842]  ? lock_release+0xfa/0x120
[   99.234023] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[   99.234028] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[   99.234045] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[   99.234066] [   T1842]  ? lock_release+0xfa/0x120
[   99.234132] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[   99.234197] [   T1842]  ? irqentry_exit+0xb0/0x810
[   99.234262] [   T1842]  ? do_syscall_64+0x34/0x660
[   99.234306] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[   99.234328] [   T1842]  ? irqentry_exit+0xb5/0x810
[   99.234372] [   T1842]  ? do_syscall_64+0xab/0x660
[   99.234437] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   99.234524] [   T1842] RIP: 0033:0x7f96f4878bbe
[   99.234611] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[   99.234676] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   99.234764] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[   99.234808] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[   99.234873] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[   99.234895] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[   99.234918] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5399ad0
[   99.235027] [   T1842]  </TASK>
[  100.030097] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  100.109352] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  100.119423] [   T1842] CPU: 6 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  100.119434] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  100.119436] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  100.119439] [   T1842] Call Trace:
[  100.119442] [   T1842]  <TASK>
[  100.119444] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  100.119468] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  100.119534] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  100.119665] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  100.119751] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  100.119817] [   T1842]  ? kasan_save_track+0x14/0x30
[  100.119882] [   T1842]  ? kfree+0x1d6/0x620
[  100.119948] [   T1842]  kobject_add_internal+0x26f/0x800
[  100.120035] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  100.120061] [   T1842]  kobject_add+0x139/0x1a0
[  100.120066] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  100.120105] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  100.120170] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  100.120216] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  100.120302] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  100.120346] [   T1842]  elevator_change_done+0x26f/0x690
[  100.120454] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  100.120498] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  100.120628] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  100.120695] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  100.120760] [   T1842]  elevator_change+0x283/0x4f0
[  100.120829] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  100.120891] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  100.120977] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  100.121022] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  100.121052] [   T1842]  ? lock_acquire+0x126/0x140
[  100.121153] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  100.121219] [   T1842]  queue_attr_store+0x23f/0x360
[  100.121306] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  100.121372] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  100.121437] [   T1842]  ? lock_release+0xfa/0x120
[  100.121524] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  100.121589] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  100.121676] [   T1842]  ? lock_acquire+0x126/0x140
[  100.121721] [   T1842]  ? lock_acquire+0x126/0x140
[  100.121765] [   T1842]  ? lock_release+0xfa/0x120
[  100.121808] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  100.121895] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  100.121940] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  100.122004] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  100.122053] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  100.122058] [   T1842]  vfs_write+0x524/0x1010
[  100.122137] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[  100.122203] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[  100.122224] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  100.122289] [   T1842]  ? __pfx_ptep_set_access_flags+0x10/0x10
[  100.122349] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[  100.122406] [   T1842]  ? lock_release+0xfa/0x120
[  100.122471] [   T1842]  ? do_wp_page+0x57e/0xf40
[  100.122536] [   T1842]  ksys_write+0xff/0x200
[  100.122561] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  100.122603] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  100.122646] [   T1842]  ? fput_close_sync+0x137/0x1a0
[  100.122755] [   T1842]  do_syscall_64+0xf4/0x660
[  100.122864] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  100.122911] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  100.123040] [   T1842]  ? count_memcg_events+0x37f/0x480
[  100.123049] [   T1842]  ? lock_release+0xfa/0x120
[  100.123083] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  100.123148] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  100.123193] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  100.123280] [   T1842]  ? lock_release+0xfa/0x120
[  100.123324] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  100.123367] [   T1842]  ? irqentry_exit+0xb0/0x810
[  100.123411] [   T1842]  ? do_syscall_64+0x34/0x660
[  100.123457] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  100.123542] [   T1842]  ? irqentry_exit+0xb5/0x810
[  100.123585] [   T1842]  ? do_syscall_64+0xab/0x660
[  100.123650] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  100.123737] [   T1842] RIP: 0033:0x7f96f4878bbe
[  100.123825] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  100.123890] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  100.123956] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  100.124021] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  100.124044] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  100.124047] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  100.124050] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec5394f20
[  100.124110] [   T1842]  </TASK>
[  101.040053] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  101.115173] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  101.125215] [   T1842] CPU: 3 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  101.125222] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  101.125223] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  101.125225] [   T1842] Call Trace:
[  101.125227] [   T1842]  <TASK>
[  101.125229] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  101.125238] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  101.125243] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  101.125249] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  101.125254] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  101.125258] [   T1842]  ? kfree+0x1d6/0x620
[  101.125262] [   T1842]  kobject_add_internal+0x26f/0x800
[  101.125268] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.125271] [   T1842]  kobject_add+0x139/0x1a0
[  101.125274] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  101.125278] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  101.125283] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  101.125285] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  101.125290] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  101.125293] [   T1842]  elevator_change_done+0x26f/0x690
[  101.125298] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  101.125301] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  101.125306] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.125310] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.125313] [   T1842]  elevator_change+0x283/0x4f0
[  101.125318] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.125321] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  101.125325] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  101.125328] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  101.125333] [   T1842]  ? lock_acquire+0x126/0x140
[  101.125338] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.125341] [   T1842]  queue_attr_store+0x23f/0x360
[  101.125345] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  101.125348] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  101.125351] [   T1842]  ? lock_release+0xfa/0x120
[  101.125355] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  101.125358] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  101.125363] [   T1842]  ? lock_acquire+0x126/0x140
[  101.125366] [   T1842]  ? lock_acquire+0x126/0x140
[  101.125370] [   T1842]  ? lock_release+0xfa/0x120
[  101.125373] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  101.125377] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  101.125380] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.125383] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  101.125387] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  101.125390] [   T1842]  vfs_write+0x524/0x1010
[  101.125394] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  101.125397] [   T1842]  ? fput_close_sync+0x137/0x1a0
[  101.125402] [   T1842]  ? folio_xchg_last_cpupid+0xc6/0x130
[  101.125406] [   T1842]  ? do_syscall_64+0x1b9/0x660
[  101.125410] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[  101.125414] [   T1842]  ksys_write+0xff/0x200
[  101.125418] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  101.125420] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  101.125424] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[  101.125429] [   T1842]  do_syscall_64+0xf4/0x660
[  101.125432] [   T1842]  ? handle_pte_fault+0x54e/0x760
[  101.125437] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[  101.125440] [   T1842]  ? trace_hardirqs_on_prepare+0x150/0x1a0
[  101.125444] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  101.125446] [   T1842]  ? do_syscall_64+0x1d7/0x660
[  101.125451] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  101.125455] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  101.125462] [   T1842]  ? count_memcg_events+0x37f/0x480
[  101.125467] [   T1842]  ? lock_release+0xfa/0x120
[  101.125471] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  101.125474] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  101.125477] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  101.125482] [   T1842]  ? lock_release+0xfa/0x120
[  101.125485] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  101.125489] [   T1842]  ? irqentry_exit+0xb0/0x810
[  101.125492] [   T1842]  ? do_syscall_64+0x34/0x660
[  101.125495] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  101.125497] [   T1842]  ? irqentry_exit+0xb5/0x810
[  101.125500] [   T1842]  ? do_syscall_64+0xab/0x660
[  101.125504] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  101.125506] [   T1842] RIP: 0033:0x7f96f4878bbe
[  101.125510] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  101.125513] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  101.125517] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  101.125519] [   T1842] RDX: 0000000000000004 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  101.125521] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  101.125523] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000004
[  101.125524] [   T1842] R13: 0000000000000004 R14: 0000562ec532aa50 R15: =
0000562ec5382090
[  101.125529] [   T1842]  </TASK>
[  101.125535] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  101.664224] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  101.675194] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  101.675208] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  101.675210] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  101.675212] [   T1842] Call Trace:
[  101.675214] [   T1842]  <TASK>
[  101.675216] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  101.675236] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  101.675245] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  101.675253] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  101.675258] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  101.675277] [   T1842]  ? kfree+0x1d6/0x620
[  101.675282] [   T1842]  kobject_add_internal+0x26f/0x800
[  101.675296] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.675300] [   T1842]  kobject_add+0x139/0x1a0
[  101.675304] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  101.675318] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  101.675323] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  101.675326] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  101.675336] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  101.675340] [   T1842]  elevator_change_done+0x26f/0x690
[  101.675346] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  101.675353] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  101.675361] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.675366] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.675369] [   T1842]  elevator_change+0x283/0x4f0
[  101.675382] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.675385] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  101.675390] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  101.675394] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  101.675403] [   T1842]  ? lock_acquire+0x126/0x140
[  101.675409] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.675413] [   T1842]  queue_attr_store+0x23f/0x360
[  101.675424] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  101.675427] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  101.675431] [   T1842]  ? lock_release+0xfa/0x120
[  101.675435] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  101.675443] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  101.675447] [   T1842]  ? lock_acquire+0x126/0x140
[  101.675451] [   T1842]  ? lock_acquire+0x126/0x140
[  101.675455] [   T1842]  ? lock_release+0xfa/0x120
[  101.675463] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  101.675467] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  101.675471] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  101.675474] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  101.675479] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  101.675484] [   T1842]  vfs_write+0x524/0x1010
[  101.675489] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  101.675493] [   T1842]  ? __pfx_locks_remove_posix+0x10/0x10
[  101.675518] [   T1842]  ksys_write+0xff/0x200
[  101.675521] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  101.675524] [   T1842]  ? __pfx_pte_val+0x10/0x10
[  101.675529] [   T1842]  do_syscall_64+0xf4/0x660
[  101.675543] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[  101.675547] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[  101.675553] [   T1842]  ? __pfx_ptep_set_access_flags+0x10/0x10
[  101.675558] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[  101.675560] [   T1842]  ? lock_release+0xfa/0x120
[  101.675564] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  101.675567] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[  101.675572] [   T1842]  ? do_wp_page+0x57e/0xf40
[  101.675583] [   T1842]  ? handle_pte_fault+0x54e/0x760
[  101.675586] [   T1842]  ? do_syscall_64+0x1d7/0x660
[  101.675590] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[  101.675592] [   T1842]  ? do_syscall_64+0x1d7/0x660
[  101.675601] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  101.675605] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  101.675609] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  101.675620] [   T1842]  ? count_memcg_events+0x37f/0x480
[  101.675629] [   T1842]  ? lock_release+0xfa/0x120
[  101.675633] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  101.675635] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  101.675639] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  101.675648] [   T1842]  ? lock_release+0xfa/0x120
[  101.675651] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  101.675655] [   T1842]  ? irqentry_exit+0xb0/0x810
[  101.675657] [   T1842]  ? do_syscall_64+0x34/0x660
[  101.675665] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  101.675673] [   T1842]  ? irqentry_exit+0xb5/0x810
[  101.675675] [   T1842]  ? do_syscall_64+0xab/0x660
[  101.675679] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  101.675692] [   T1842] RIP: 0033:0x7f96f4878bbe
[  101.675695] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  101.675698] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  101.675702] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  101.675707] [   T1842] RDX: 0000000000000004 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  101.675709] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  101.675710] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000004
[  101.675712] [   T1842] R13: 0000000000000004 R14: 0000562ec532aa50 R15: =
0000562ec5397e70
[  101.675717] [   T1842]  </TASK>
[  101.675723] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  102.235777] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  102.245750] [   T1842] CPU: 4 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  102.245756] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  102.245757] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  102.245759] [   T1842] Call Trace:
[  102.245761] [   T1842]  <TASK>
[  102.245763] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  102.245771] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  102.245776] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  102.245782] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  102.245786] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  102.245789] [   T1842]  ? kasan_save_track+0x14/0x30
[  102.245793] [   T1842]  ? kfree+0x1d6/0x620
[  102.245796] [   T1842]  kobject_add_internal+0x26f/0x800
[  102.245802] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.245805] [   T1842]  kobject_add+0x139/0x1a0
[  102.245808] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  102.245812] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  102.245816] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  102.245819] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  102.245823] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  102.245826] [   T1842]  elevator_change_done+0x26f/0x690
[  102.245831] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  102.245834] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  102.245839] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.245843] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.245846] [   T1842]  elevator_change+0x283/0x4f0
[  102.245850] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.245853] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  102.245856] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  102.245860] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  102.245865] [   T1842]  ? lock_acquire+0x126/0x140
[  102.245869] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.245872] [   T1842]  queue_attr_store+0x23f/0x360
[  102.245876] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  102.245879] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  102.245882] [   T1842]  ? lock_release+0xfa/0x120
[  102.245885] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  102.245889] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  102.245893] [   T1842]  ? lock_acquire+0x126/0x140
[  102.245896] [   T1842]  ? lock_acquire+0x126/0x140
[  102.245900] [   T1842]  ? lock_release+0xfa/0x120
[  102.245903] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  102.245906] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  102.245910] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.245913] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  102.245917] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  102.245919] [   T1842]  vfs_write+0x524/0x1010
[  102.245922] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  102.245926] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  102.245930] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  102.245936] [   T1842]  ? count_memcg_events+0x37f/0x480
[  102.245941] [   T1842]  ksys_write+0xff/0x200
[  102.245944] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  102.245947] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  102.245951] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  102.245957] [   T1842]  do_syscall_64+0xf4/0x660
[  102.245961] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  102.245964] [   T1842]  ? irqentry_exit+0xb0/0x810
[  102.245967] [   T1842]  ? do_syscall_64+0x34/0x660
[  102.245970] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  102.245973] [   T1842]  ? irqentry_exit+0xb5/0x810
[  102.245975] [   T1842]  ? do_syscall_64+0xab/0x660
[  102.245979] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  102.245982] [   T1842] RIP: 0033:0x7f96f4878bbe
[  102.245985] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  102.245987] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  102.245991] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  102.245993] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  102.245995] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  102.245997] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  102.245998] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec53929c0
[  102.246003] [   T1842]  </TASK>
[  102.246009] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  102.718245] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  102.728223] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  102.728230] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  102.728231] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  102.728233] [   T1842] Call Trace:
[  102.728235] [   T1842]  <TASK>
[  102.728237] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  102.728246] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  102.728251] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  102.728259] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  102.728263] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  102.728267] [   T1842]  ? kfree+0x1d6/0x620
[  102.728272] [   T1842]  kobject_add_internal+0x26f/0x800
[  102.728278] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.728282] [   T1842]  kobject_add+0x139/0x1a0
[  102.728285] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  102.728289] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  102.728293] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  102.728296] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  102.728301] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  102.728304] [   T1842]  elevator_change_done+0x26f/0x690
[  102.728310] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  102.728313] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  102.728319] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.728322] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.728325] [   T1842]  elevator_change+0x283/0x4f0
[  102.728329] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.728332] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  102.728336] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  102.728340] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  102.728345] [   T1842]  ? lock_acquire+0x126/0x140
[  102.728350] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.728353] [   T1842]  queue_attr_store+0x23f/0x360
[  102.728358] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  102.728361] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  102.728363] [   T1842]  ? lock_release+0xfa/0x120
[  102.728367] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  102.728371] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  102.728375] [   T1842]  ? lock_acquire+0x126/0x140
[  102.728379] [   T1842]  ? lock_acquire+0x126/0x140
[  102.728382] [   T1842]  ? lock_release+0xfa/0x120
[  102.728386] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  102.728389] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  102.728393] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  102.728395] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  102.728399] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  102.728402] [   T1842]  vfs_write+0x524/0x1010
[  102.728406] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  102.728409] [   T1842]  ? filp_close+0x25/0x40
[  102.728415] [   T1842]  ? do_syscall_64+0x1b9/0x660
[  102.728420] [   T1842]  ? __pfx_pte_val+0x10/0x10
[  102.728425] [   T1842]  ksys_write+0xff/0x200
[  102.728428] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  102.728430] [   T1842]  ? lock_release+0xfa/0x120
[  102.728434] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  102.728437] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[  102.728441] [   T1842]  do_syscall_64+0xf4/0x660
[  102.728445] [   T1842]  ? handle_pte_fault+0x54e/0x760
[  102.728450] [   T1842]  ? do_syscall_64+0x1d7/0x660
[  102.728453] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[  102.728457] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  102.728459] [   T1842]  ? __pfx_locks_remove_posix+0x10/0x10
[  102.728465] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  102.728469] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  102.728477] [   T1842]  ? count_memcg_events+0x37f/0x480
[  102.728483] [   T1842]  ? lock_release+0xfa/0x120
[  102.728486] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  102.728489] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  102.728493] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  102.728497] [   T1842]  ? lock_release+0xfa/0x120
[  102.728501] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  102.728504] [   T1842]  ? irqentry_exit+0xb0/0x810
[  102.728507] [   T1842]  ? do_syscall_64+0x34/0x660
[  102.728510] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  102.728513] [   T1842]  ? irqentry_exit+0xb5/0x810
[  102.728515] [   T1842]  ? do_syscall_64+0xab/0x660
[  102.728519] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  102.728521] [   T1842] RIP: 0033:0x7f96f4878bbe
[  102.728525] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  102.728528] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  102.728532] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  102.728534] [   T1842] RDX: 000000000000000c RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  102.728536] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  102.728537] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[  102.728539] [   T1842] R13: 000000000000000c R14: 0000562ec532aa50 R15: =
0000562ec5397300
[  102.728544] [   T1842]  </TASK>
[  102.728549] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  103.292307] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  103.302399] [   T1842] CPU: 7 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  103.302408] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  103.302410] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  103.302422] [   T1842] Call Trace:
[  103.302446] [   T1842]  <TASK>
[  103.302489] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  103.302728] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  103.302816] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  103.302990] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  103.303077] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  103.303124] [   T1842]  ? kasan_save_track+0x14/0x30
[  103.303129] [   T1842]  ? kfree+0x1d6/0x620
[  103.303135] [   T1842]  kobject_add_internal+0x26f/0x800
[  103.303258] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  103.303324] [   T1842]  kobject_add+0x139/0x1a0
[  103.303389] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  103.303476] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  103.303563] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  103.303629] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  103.303716] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  103.303782] [   T1842]  elevator_change_done+0x26f/0x690
[  103.303912] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  103.303978] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  103.304088] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  103.304114] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  103.304131] [   T1842]  elevator_change+0x283/0x4f0
[  103.304218] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  103.304262] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  103.304306] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  103.304349] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  103.304396] [   T1842]  ? lock_acquire+0x126/0x140
[  103.304481] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  103.304546] [   T1842]  queue_attr_store+0x23f/0x360
[  103.304612] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  103.304678] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  103.304699] [   T1842]  ? lock_release+0xfa/0x120
[  103.304785] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  103.304851] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  103.304960] [   T1842]  ? lock_acquire+0x126/0x140
[  103.305005] [   T1842]  ? lock_acquire+0x126/0x140
[  103.305091] [   T1842]  ? lock_release+0xfa/0x120
[  103.305117] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  103.305123] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  103.305129] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  103.305146] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  103.305211] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  103.305255] [   T1842]  vfs_write+0x524/0x1010
[  103.305279] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  103.305322] [   T1842]  ? __pfx_pte_val+0x10/0x10
[  103.305430] [   T1842]  ? folio_xchg_last_cpupid+0xc6/0x130
[  103.305539] [   T1842]  ? __pfx_ptep_set_access_flags+0x10/0x10
[  103.305649] [   T1842]  ksys_write+0xff/0x200
[  103.305715] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  103.305760] [   T1842]  do_syscall_64+0xf4/0x660
[  103.305802] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[  103.305910] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  103.305934] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  103.305975] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  103.306106] [   T1842]  ? count_memcg_events+0x37f/0x480
[  103.306115] [   T1842]  ? lock_release+0xfa/0x120
[  103.306194] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  103.306260] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  103.306326] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  103.306434] [   T1842]  ? lock_release+0xfa/0x120
[  103.306478] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  103.306547] [   T1842]  ? irqentry_exit+0xb0/0x810
[  103.306609] [   T1842]  ? do_syscall_64+0x34/0x660
[  103.306674] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  103.306740] [   T1842]  ? irqentry_exit+0xb5/0x810
[  103.306783] [   T1842]  ? do_syscall_64+0xab/0x660
[  103.306870] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  103.306936] [   T1842] RIP: 0033:0x7f96f4878bbe
[  103.307023] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  103.307088] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  103.307114] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  103.307118] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  103.307133] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  103.307157] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  103.307179] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec5395360
[  103.307215] [   T1842]  </TASK>
[  104.197683] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  104.269345] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  104.279320] [   T1842] CPU: 3 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  104.279326] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  104.279327] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  104.279329] [   T1842] Call Trace:
[  104.279331] [   T1842]  <TASK>
[  104.279333] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  104.279341] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  104.279346] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  104.279352] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  104.279356] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  104.279360] [   T1842]  ? kasan_save_track+0x14/0x30
[  104.279363] [   T1842]  ? kfree+0x1d6/0x620
[  104.279367] [   T1842]  kobject_add_internal+0x26f/0x800
[  104.279372] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.279375] [   T1842]  kobject_add+0x139/0x1a0
[  104.279379] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  104.279383] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  104.279387] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  104.279390] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  104.279394] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  104.279397] [   T1842]  elevator_change_done+0x26f/0x690
[  104.279402] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  104.279404] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  104.279410] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.279413] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.279416] [   T1842]  elevator_change+0x283/0x4f0
[  104.279420] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.279423] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  104.279427] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  104.279430] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  104.279435] [   T1842]  ? lock_acquire+0x126/0x140
[  104.279440] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.279443] [   T1842]  queue_attr_store+0x23f/0x360
[  104.279446] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  104.279449] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  104.279452] [   T1842]  ? lock_release+0xfa/0x120
[  104.279456] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  104.279460] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  104.279464] [   T1842]  ? lock_acquire+0x126/0x140
[  104.279467] [   T1842]  ? lock_acquire+0x126/0x140
[  104.279471] [   T1842]  ? lock_release+0xfa/0x120
[  104.279474] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  104.279477] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  104.279481] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.279484] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  104.279487] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  104.279490] [   T1842]  vfs_write+0x524/0x1010
[  104.279494] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  104.279497] [   T1842]  ? folio_xchg_last_cpupid+0xc6/0x130
[  104.279501] [   T1842]  ? ptep_set_access_flags+0xe5/0x130
[  104.279505] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[  104.279509] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[  104.279511] [   T1842]  ? lock_release+0xfa/0x120
[  104.279515] [   T1842]  ksys_write+0xff/0x200
[  104.279518] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  104.279521] [   T1842]  ? handle_pte_fault+0x54e/0x760
[  104.279526] [   T1842]  do_syscall_64+0xf4/0x660
[  104.279530] [   T1842]  ? __x64_sys_fcntl+0x10d/0x1c0
[  104.279534] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  104.279538] [   T1842]  ? trace_hardirqs_on_prepare+0x150/0x1a0
[  104.279542] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  104.279546] [   T1842]  ? kmem_cache_free+0x144/0x5f0
[  104.279549] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  104.279556] [   T1842]  ? count_memcg_events+0x37f/0x480
[  104.279561] [   T1842]  ? lock_release+0xfa/0x120
[  104.279565] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  104.279568] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  104.279571] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  104.279576] [   T1842]  ? lock_release+0xfa/0x120
[  104.279579] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  104.279583] [   T1842]  ? irqentry_exit+0xb0/0x810
[  104.279585] [   T1842]  ? do_syscall_64+0x34/0x660
[  104.279588] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  104.279591] [   T1842]  ? irqentry_exit+0xb5/0x810
[  104.279593] [   T1842]  ? do_syscall_64+0xab/0x660
[  104.279597] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  104.279599] [   T1842] RIP: 0033:0x7f96f4878bbe
[  104.279603] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  104.279605] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  104.279609] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  104.279611] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  104.279613] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  104.279614] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  104.279616] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec5395470
[  104.279621] [   T1842]  </TASK>
[  104.279626] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  104.808451] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  104.818469] [   T1842] CPU: 4 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  104.818479] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  104.818482] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  104.818485] [   T1842] Call Trace:
[  104.818488] [   T1842]  <TASK>
[  104.818491] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  104.818502] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  104.818508] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  104.818514] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  104.818518] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  104.818522] [   T1842]  ? kasan_save_track+0x14/0x30
[  104.818525] [   T1842]  ? kfree+0x1d6/0x620
[  104.818528] [   T1842]  kobject_add_internal+0x26f/0x800
[  104.818534] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.818537] [   T1842]  kobject_add+0x139/0x1a0
[  104.818540] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  104.818544] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  104.818548] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  104.818551] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  104.818555] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  104.818558] [   T1842]  elevator_change_done+0x26f/0x690
[  104.818563] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  104.818566] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  104.818572] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.818575] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.818578] [   T1842]  elevator_change+0x283/0x4f0
[  104.818582] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.818585] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  104.818589] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  104.818592] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  104.818597] [   T1842]  ? lock_acquire+0x126/0x140
[  104.818602] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.818605] [   T1842]  queue_attr_store+0x23f/0x360
[  104.818609] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  104.818612] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  104.818614] [   T1842]  ? lock_release+0xfa/0x120
[  104.818618] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  104.818622] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  104.818626] [   T1842]  ? lock_acquire+0x126/0x140
[  104.818629] [   T1842]  ? lock_acquire+0x126/0x140
[  104.818633] [   T1842]  ? lock_release+0xfa/0x120
[  104.818636] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  104.818639] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  104.818643] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  104.818646] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  104.818649] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  104.818652] [   T1842]  vfs_write+0x524/0x1010
[  104.818656] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  104.818660] [   T1842]  ? __pfx_pmd_val+0x10/0x10
[  104.818664] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  104.818669] [   T1842]  ksys_write+0xff/0x200
[  104.818672] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  104.818675] [   T1842]  ? count_memcg_events+0x37f/0x480
[  104.818679] [   T1842]  do_syscall_64+0xf4/0x660
[  104.818684] [   T1842]  ? lock_release+0xfa/0x120
[  104.818688] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  104.818690] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  104.818694] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  104.818699] [   T1842]  ? lock_release+0xfa/0x120
[  104.818702] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  104.818706] [   T1842]  ? irqentry_exit+0xb0/0x810
[  104.818708] [   T1842]  ? do_syscall_64+0x34/0x660
[  104.818712] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  104.818715] [   T1842]  ? irqentry_exit+0xb5/0x810
[  104.818717] [   T1842]  ? do_syscall_64+0xab/0x660
[  104.818720] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  104.818723] [   T1842] RIP: 0033:0x7f96f4878bbe
[  104.818726] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  104.818729] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  104.818733] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  104.818735] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  104.818737] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  104.818739] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  104.818740] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec5397d90
[  104.818745] [   T1842]  </TASK>
[  104.818750] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  105.300372] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  105.310342] [   T1842] CPU: 0 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  105.310349] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  105.310350] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  105.310352] [   T1842] Call Trace:
[  105.310354] [   T1842]  <TASK>
[  105.310355] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  105.310364] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  105.310370] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  105.310376] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  105.310381] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  105.310384] [   T1842]  ? kasan_save_track+0x14/0x30
[  105.310388] [   T1842]  ? kfree+0x1d6/0x620
[  105.310392] [   T1842]  kobject_add_internal+0x26f/0x800
[  105.310398] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.310401] [   T1842]  kobject_add+0x139/0x1a0
[  105.310405] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  105.310409] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  105.310413] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  105.310416] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  105.310420] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  105.310423] [   T1842]  elevator_change_done+0x26f/0x690
[  105.310429] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  105.310432] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  105.310438] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.310442] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.310444] [   T1842]  elevator_change+0x283/0x4f0
[  105.310448] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.310451] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  105.310456] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  105.310459] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  105.310464] [   T1842]  ? lock_acquire+0x126/0x140
[  105.310469] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.310472] [   T1842]  queue_attr_store+0x23f/0x360
[  105.310477] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  105.310480] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  105.310482] [   T1842]  ? lock_release+0xfa/0x120
[  105.310486] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  105.310490] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  105.310494] [   T1842]  ? lock_acquire+0x126/0x140
[  105.310497] [   T1842]  ? lock_acquire+0x126/0x140
[  105.310501] [   T1842]  ? lock_release+0xfa/0x120
[  105.310504] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  105.310508] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  105.310511] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.310514] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  105.310518] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  105.310521] [   T1842]  vfs_write+0x524/0x1010
[  105.310524] [   T1842]  ? folio_xchg_last_cpupid+0xc6/0x130
[  105.310529] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  105.310531] [   T1842]  ? __pfx_folio_xchg_last_cpupid+0x10/0x10
[  105.310536] [   T1842]  ? do_raw_spin_unlock+0x59/0x230
[  105.310539] [   T1842]  ? do_wp_page+0x57e/0xf40
[  105.310544] [   T1842]  ksys_write+0xff/0x200
[  105.310547] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  105.310550] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[  105.310555] [   T1842]  do_syscall_64+0xf4/0x660
[  105.310560] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  105.310564] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  105.310572] [   T1842]  ? count_memcg_events+0x37f/0x480
[  105.310578] [   T1842]  ? lock_release+0xfa/0x120
[  105.310582] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  105.310585] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  105.310589] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  105.310595] [   T1842]  ? lock_release+0xfa/0x120
[  105.310599] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  105.310602] [   T1842]  ? irqentry_exit+0xb0/0x810
[  105.310605] [   T1842]  ? do_syscall_64+0x34/0x660
[  105.310608] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  105.310611] [   T1842]  ? irqentry_exit+0xb5/0x810
[  105.310613] [   T1842]  ? do_syscall_64+0xab/0x660
[  105.310617] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  105.310619] [   T1842] RIP: 0033:0x7f96f4878bbe
[  105.310623] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  105.310626] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  105.310629] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  105.310632] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  105.310633] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  105.310635] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  105.310636] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec53956a0
[  105.310641] [   T1842]  </TASK>
[  105.310646] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.
[  105.851457] [   T1842] sysfs: cannot create duplicate filename '/devices=
/virtual/block/nullb1/queue/iosched'
[  105.861445] [   T1842] CPU: 4 UID: 0 PID: 1842 Comm: check Tainted: G   =
 B D W           7.1.0-kts+ #57 PREEMPT(lazy)=20
[  105.861456] [   T1842] Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [W]=3DWARN
[  105.861458] [   T1842] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[  105.861461] [   T1842] Call Trace:
[  105.861464] [   T1842]  <TASK>
[  105.861467] [   T1842]  dump_stack_lvl+0x6e/0xa0
[  105.861479] [   T1842]  sysfs_warn_dup.cold+0x17/0x24
[  105.861484] [   T1842]  sysfs_create_dir_ns+0x1fc/0x270
[  105.861490] [   T1842]  ? __pfx_sysfs_create_dir_ns+0x10/0x10
[  105.861495] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  105.861499] [   T1842]  ? kasan_save_track+0x14/0x30
[  105.861502] [   T1842]  ? kfree+0x1d6/0x620
[  105.861506] [   T1842]  kobject_add_internal+0x26f/0x800
[  105.861511] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.861514] [   T1842]  kobject_add+0x139/0x1a0
[  105.861517] [   T1842]  ? __blk_mq_unfreeze_queue+0x24/0x1a0
[  105.861521] [   T1842]  ? __pfx_kobject_add+0x10/0x10
[  105.861526] [   T1842]  ? __mutex_unlock_slowpath+0x15d/0x860
[  105.861528] [   T1842]  ? do_raw_spin_lock+0x128/0x270
[  105.861532] [   T1842]  ? __mutex_lock+0x2bc/0x25a0
[  105.861535] [   T1842]  elevator_change_done+0x26f/0x690
[  105.861540] [   T1842]  ? __pfx_elevator_change_done+0x10/0x10
[  105.861543] [   T1842]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[  105.861549] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.861552] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.861555] [   T1842]  elevator_change+0x283/0x4f0
[  105.861559] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.861562] [   T1842]  elv_iosched_store+0x30c/0x3a0
[  105.861566] [   T1842]  ? __pfx_elv_iosched_store+0x10/0x10
[  105.861569] [   T1842]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  105.861575] [   T1842]  ? lock_acquire+0x126/0x140
[  105.861579] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.861582] [   T1842]  queue_attr_store+0x23f/0x360
[  105.861586] [   T1842]  ? __mutex_lock+0x1536/0x25a0
[  105.861589] [   T1842]  ? __pfx_queue_attr_store+0x10/0x10
[  105.861592] [   T1842]  ? lock_release+0xfa/0x120
[  105.861595] [   T1842]  ? __pfx___mutex_lock+0x10/0x10
[  105.861599] [   T1842]  ? __pfx__copy_from_iter+0x10/0x10
[  105.861603] [   T1842]  ? lock_acquire+0x126/0x140
[  105.861606] [   T1842]  ? lock_acquire+0x126/0x140
[  105.861610] [   T1842]  ? lock_release+0xfa/0x120
[  105.861613] [   T1842]  ? sysfs_file_kobj+0xb9/0x1b0
[  105.861617] [   T1842]  ? sysfs_kf_write+0x65/0x170
[  105.861621] [   T1842]  ? __pfx_sysfs_kf_write+0x10/0x10
[  105.861623] [   T1842]  kernfs_fop_write_iter+0x3da/0x5e0
[  105.861627] [   T1842]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  105.861630] [   T1842]  vfs_write+0x524/0x1010
[  105.861634] [   T1842]  ? lock_release+0xfa/0x120
[  105.861637] [   T1842]  ? __pfx_vfs_write+0x10/0x10
[  105.861639] [   T1842]  ? wp_page_reuse+0x160/0x1e0
[  105.861644] [   T1842]  ? do_wp_page+0x57e/0xf40
[  105.861649] [   T1842]  ? __pfx_handle_pte_fault+0x10/0x10
[  105.861653] [   T1842]  ksys_write+0xff/0x200
[  105.861656] [   T1842]  ? __pfx_ksys_write+0x10/0x10
[  105.861659] [   T1842]  ? __handle_mm_fault+0xa02/0xef0
[  105.861663] [   T1842]  do_syscall_64+0xf4/0x660
[  105.861667] [   T1842]  ? __pfx___css_rstat_updated+0x10/0x10
[  105.861674] [   T1842]  ? count_memcg_events+0x37f/0x480
[  105.861679] [   T1842]  ? lock_release+0xfa/0x120
[  105.861683] [   T1842]  ? rcu_read_unlock+0x1c/0x60
[  105.861685] [   T1842]  ? handle_mm_fault+0x4d1/0x7d0
[  105.861689] [   T1842]  ? do_user_addr_fault+0x15d/0xed0
[  105.861694] [   T1842]  ? lock_release+0xfa/0x120
[  105.861698] [   T1842]  ? do_user_addr_fault+0x811/0xed0
[  105.861701] [   T1842]  ? irqentry_exit+0xb0/0x810
[  105.861704] [   T1842]  ? do_syscall_64+0x34/0x660
[  105.861707] [   T1842]  ? trace_hardirqs_on+0x19/0x1a0
[  105.861710] [   T1842]  ? irqentry_exit+0xb5/0x810
[  105.861712] [   T1842]  ? do_syscall_64+0xab/0x660
[  105.861716] [   T1842]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  105.861719] [   T1842] RIP: 0033:0x7f96f4878bbe
[  105.861722] [   T1842] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  105.861725] [   T1842] RSP: 002b:00007ffcb76ebbb0 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[  105.861729] [   T1842] RAX: ffffffffffffffda RBX: 00007f96f49f45c0 RCX: =
00007f96f4878bbe
[  105.861732] [   T1842] RDX: 0000000000000006 RSI: 0000562ec532aa50 RDI: =
0000000000000001
[  105.861734] [   T1842] RBP: 00007ffcb76ebbc0 R08: 0000000000000000 R09: =
0000000000000000
[  105.861735] [   T1842] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000000000006
[  105.861737] [   T1842] R13: 0000000000000006 R14: 0000562ec532aa50 R15: =
0000562ec53972c0
[  105.861742] [   T1842]  </TASK>
[  105.861748] [   T1842] kobject: kobject_add_internal failed for iosched =
with -EEXIST, don't try to register things with the same name in the same d=
irectory.


[4] dmesg during the sysytem boot

...
[   14.387131] [    T117] ata7.00: Features: HIPM DIPM NCQ-sndrcv NCQ-prio
[   14.387200] [    T129] sd 4:0:0:0: [sda] 976773168 512-byte logical bloc=
ks: (500 GB/466 GiB)
[   14.387319] [    T129] sd 4:0:0:0: [sda] Write Protect is off
[   14.387370] [    T129] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   14.387492] [    T129] sd 4:0:0:0: [sda] Write cache: enabled, read cach=
e: enabled, doesn't support DPO or FUA
[   14.387696] [    T129] sd 4:0:0:0: [sda] Preferred minimum I/O size 512 =
bytes
[   14.391829] [      T1] usb usb4: New USB device strings: Mfr=3D3, Produc=
t=3D2, SerialNumber=3D1
[   14.391835] [      T1] usb usb4: Product: xHCI Host Controller
[   14.391837] [      T1] usb usb4: Manufacturer: Linux 7.1.0-kts+ xhci-hcd
[   14.411827] [    T117] ata7.00: configured for UDMA/133
[   14.417307] [      T1] usb usb4: SerialNumber: 0000:00:14.0
[   14.417647] [    T129] ------------[ cut here ]------------
[   14.417668] [    T129] WARNING: block/blk-mq-debugfs.c:621 at debugfs_cr=
eate_files+0x162/0x210, CPU#7: kworker/u32:11/129
[   14.417681] [    T129] Modules linked in:
[   14.417694] [    T129] CPU: 7 UID: 0 PID: 129 Comm: kworker/u32:11 Not t=
ainted 7.1.0-kts+ #57 PREEMPT(lazy)=20
[   14.417698] [    T129] Hardware name: Supermicro Super Server/X10SRL-F, =
BIOS 2.0 12/17/2015
[   14.417701] [    T129] Workqueue: async async_run_entry_fn
[   14.417708] [    T129] RIP: 0010:debugfs_create_files+0x162/0x210
[   14.417713] [    T129] Code: 0f 85 aa 00 00 00 8b 15 e0 bc e1 03 85 d2 0=
f 84 0c ff ff ff 49 8d be 88 05 00 00 be ff ff ff ff e8 f3 ac a9 01 83 f8 0=
1 75 02 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 89 ea 83 e5 07 48 c1 ea 03
[   14.417716] [    T129] RSP: 0000:ffff88811750f648 EFLAGS: 00010246
[   14.417720] [    T129] RAX: 0000000000000001 RBX: ffffffffaaffa7e0 RCX: =
0000000000000000
[   14.417723] [    T129] RDX: 0000000000000001 RSI: ffff888119603418 RDI: =
ffff888116521060
[   14.417726] [    T129] RBP: ffffffffacf3cc24 R08: 0000000000000001 R09: =
ffffed10200b2365
[   14.417729] [    T129] R10: ffffed10200b2366 R11: 0000000000000001 R12: =
ffff888100591a70
[   14.417731] [    T129] R13: ffff888119602e90 R14: ffff888119602e90 R15: =
ffff888101ff5818
[   14.417734] [    T129] FS:  0000000000000000(0000) GS:ffff8887b01c8000(0=
000) knlGS:0000000000000000
[   14.417737] [    T129] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.417740] [    T129] CR2: 0000000000000000 CR3: 00000004f909c001 CR4: =
00000000001706f0
[   14.417743] [    T129] Call Trace:
[   14.417745] [    T129]  <TASK>
[   14.417751] [    T129]  blk_mq_sched_reg_debugfs+0x8d/0x1a0
[   14.417761] [    T129]  elevator_change_done+0x329/0x690
[   14.417771] [    T129]  ? __pfx_elevator_change_done+0x10/0x10
[   14.417776] [    T129]  ? __lock_release.isra.0+0x59/0x170
[   14.417789] [    T129]  elevator_change+0x283/0x4f0
[   14.417798] [    T129]  elevator_set_default+0x236/0x2e0
[   14.417804] [    T129]  ? __pfx_elevator_set_default+0x10/0x10
[   14.417815] [    T129]  ? disk_register_independent_access_ranges+0x24f/=
0x310
[   14.417825] [    T129]  blk_register_queue+0x412/0x5b0
[   14.417837] [    T129]  __add_disk+0x5fd/0xd50
[   14.417843] [    T129]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   14.417847] [    T129]  ? find_held_lock+0x2b/0x80
[   14.417853] [    T129]  add_disk_fwnode+0x113/0x590
[   14.417863] [    T129]  sd_probe+0x8b5/0xf90
[   14.417873] [    T129]  call_driver_probe+0x64/0x1e0
[   14.417880] [    T129]  really_probe+0x194/0x740
[   14.417889] [    T129]  ? __pfx___device_attach_driver+0x10/0x10
[   14.417893] [    T129]  __driver_probe_device+0x1cb/0x400
[   14.417900] [    T129]  driver_probe_device+0x4a/0x120
[   14.417906] [    T129]  __device_attach_driver+0x156/0x2a0
[   14.417913] [    T129]  bus_for_each_drv+0x114/0x1a0
[   14.417917] [    T129]  ? mark_held_locks+0x40/0x70
[   14.417922] [    T129]  ? __pfx_bus_for_each_drv+0x10/0x10
[   14.417927] [    T129]  ? trace_hardirqs_on+0x19/0x1a0
[   14.417933] [    T129]  ? _raw_spin_unlock_irqrestore+0x44/0x60
[   14.417942] [    T129]  __device_attach_async_helper+0x19f/0x250
[   14.417948] [    T129]  ? __pfx___device_attach_async_helper+0x10/0x10
[   14.417953] [    T129]  ? seqcount_lockdep_reader_access+0x94/0xb0
[   14.417961] [    T129]  ? ktime_get+0x35/0x1b0
[   14.417965] [    T129]  ? ktime_get+0x35/0x1b0
[   14.417972] [    T129]  async_run_entry_fn+0x97/0x550
[   14.417979] [    T129]  process_one_work+0x8b7/0x1650
[   14.417995] [    T129]  ? __pfx_process_one_work+0x10/0x10
[   14.418073] [    T129]  ? lock_acquire.part.0+0xb8/0x230
[   14.418083] [    T129]  ? lock_is_held_type+0x9a/0x110
[   14.418096] [    T129]  worker_thread+0x60a/0xff0
[   14.418110] [    T129]  ? __pfx_worker_thread+0x10/0x10
[   14.418114] [    T129]  kthread+0x35d/0x460
[   14.418119] [    T129]  ? _raw_spin_unlock_irq+0x28/0x50
[   14.418124] [    T129]  ? __pfx_kthread+0x10/0x10
[   14.418130] [    T129]  ret_from_fork+0x55b/0x850
[   14.418137] [    T129]  ? __pfx_ret_from_fork+0x10/0x10
[   14.418144] [    T129]  ? __switch_to+0x474/0xd80
[   14.418148] [    T129]  ? __switch_to_asm+0x39/0x70
[   14.418153] [    T129]  ? __switch_to_asm+0x33/0x70
[   14.418157] [    T129]  ? __pfx_kthread+0x10/0x10
[   14.418163] [    T129]  ret_from_fork_asm+0x1a/0x30
[   14.418179] [    T129]  </TASK>
[   14.418181] [    T129] irq event stamp: 4509
[   14.418183] [    T129] hardirqs last  enabled at (4515): [<ffffffffa7dd1=
1d5>] console_trylock_spinning+0x1c5/0x1f0
[   14.418188] [    T129] hardirqs last disabled at (4520): [<ffffffffa7dd1=
188>] console_trylock_spinning+0x178/0x1f0
[   14.418193] [    T129] softirqs last  enabled at (4028): [<ffffffffa7bc5=
b91>] handle_softirqs+0x5c1/0x8b0
[   14.418198] [    T129] softirqs last disabled at (4023): [<ffffffffa7bc5=
fe2>] __irq_exit_rcu+0x152/0x280
[   14.418203] [    T129] ---[ end trace 0000000000000000 ]---
[   14.445938] [     T84] usb 1-1: New USB device found, idVendor=3D8087, i=
dProduct=3D8002, bcdDevice=3D 0.05
[   14.456687] [      T1] hub 4-0:1.0: USB hub found
[   14.460399] [     T84] usb 1-1: New USB device strings: Mfr=3D0, Product=
=3D0, SerialNumber=3D0
[   14.468534] [      T1] hub 4-0:1.0: 6 ports detected
[   14.477755] [    T129]  sda: sda1 sda2 sda3
[   14.478903] [     T84] hub 1-1:1.0: USB hub found
[   14.479235] [     T84] hub 1-1:1.0: 8 ports detected
[   14.500815] [     T14] Freeing initrd memory: 58856K
[   14.511419] [    T129] sd 4:0:0:0: [sda] Attached SCSI disk
[   14.591054] [      T1] usbcore: registered new interface driver usbseria=
l_generic
[   14.624054] [    T133] usb 3-1: new high-speed USB device number 2 using=
 ehci-pci
[   14.630659] [      T1] usbserial: USB Serial support registered for gene=
ric
[   14.642060] [     T82] usb 2-12: new high-speed USB device number 2 usin=
g xhci_hcd
[   14.647384] [      T1] i8042: PNP: No PS/2 controller found.
[   14.783710] [     T82] usb 2-12: New USB device found, idVendor=3D0557, =
idProduct=3D7000, bcdDevice=3D 0.00
[   14.788031] [      T1] mousedev: PS/2 mouse device common for all mice
[   14.791695] [     T82] usb 2-12: New USB device strings: Mfr=3D0, Produc=
t=3D0, SerialNumber=3D0
[   14.798401] [      T1] rtc_cmos PNP0B00:00: RTC can wake from S4
[   14.806361] [     T82] hub 2-12:1.0: USB hub found
[   14.809380] [      T1] rtc_cmos PNP0B00:00: registered as rtc0
[   14.811778] [     T82] hub 2-12:1.0: 4 ports detected
[   14.816589] [      T1] rtc_cmos PNP0B00:00: setting system clock to 2026=
-06-24T11:36:20 UTC (1782300980)
[   14.875529] [    T133] usb 3-1: New USB device found, idVendor=3D8087, i=
dProduct=3D800a, bcdDevice=3D
...
