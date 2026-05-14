Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63F3A718D
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751713; cv=fail; b=RX3RwTIMSyre2QwVEhps6iTZ8QxwhHrNJcc0b1NXM/Zhkfy/tPQdmIcOq1AGIkngZUTwobZARX53pF4uYMfQXthad69cKsN6hjGkStDriC5oHk9aMvDBccd0bv9VaeEefKYZaWqRxko5lpyETy+berySBv90KRqotHexUhBAN/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751713; c=relaxed/simple;
	bh=NVlv96qWAqhg0PIfYgZ0kb5tyXI0oibISdtqsrvzHzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXwvg1cvaA6ot6Sfw1ZytM+BY1zur1P9nOeOpuIWk+ZAYVAvqayJStNxoDZ2ctwcX35j6Nqi6/iM5e8JPvKbLPH4RzsxcItdZAjlgt6SI6rpnndjt6ih4Imp8kGzAkKmo3yHZprN8WzuV1dZlF6Oih3Tz4TihXfwT28Nx3gPGco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LJhXJWN6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vHlDDpk7; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LJhXJWN6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vHlDDpk7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778751712; x=1810287712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NVlv96qWAqhg0PIfYgZ0kb5tyXI0oibISdtqsrvzHzQ=;
  b=LJhXJWN6NhXlMyVkM8uYexl0w1BF5TraFpZJVq1bdsCbidUFPPl9wjcX
   AQyLs6A/mLiZ3kba6Ssa/NK1787TFyXtgLeOapxR2NzGeQJnwjEFYgxMN
   MkFjrk1hmAZ3AMosIx6DrYuGqBUZ27fL6C1JuzBreT9crkNbRrep7s0sH
   AECtLrF8K420Q9V+fHSx89IK3W1gT5OlzrpNIyvVyckEoJnGN6FlwQ3R8
   T47TYvM4xo1Qoh9mkMKWyRlre8xkWcwTywUI+/YkDt9dY3xsGd7R6K1q1
   Xa2R3fVAbu326eJllVLaQDnm41zFJqTTdTUK6aNCnUaEKU4L1jdya9l95
   Q==;
X-CSE-ConnectionGUID: M0/qCQMXR8CDtM4SzNj/9w==
X-CSE-MsgGUID: qB1n/JKZQY2go56yyMx3DA==
X-IronPort-AV: E=Sophos;i="6.23,234,1770566400"; 
   d="scan'208";a="146549169"
Received: from mail-southcentralusazon11013032.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 17:41:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j334EVQYv/RIeQYRw2EJm429KZyOmLVrcbHyk9G/DozKQVg+gPiREiJhdSHCaaY+MOhblIZ4U3YHHu53Hbn4TfY7wnojinW4VDTp3JYLv+LAvi1yTBW/yhrjFsS9OKXbIK2VHCFFrCiyAMbSQm8Tn16JR0p/WBhmm79F3AB6ZTUT6tr4G4sk8eKAQSTpGqXQ7Lk29YsuzpzTbBrN5sfFY9A+auSTJvTVK9PkcnGc0C06WWVJbZ+xOvwjhZuqApqlmPoIoopedz21E+U8F+cOtMH6RepeHxlJHwwHM5V46il0TVKIffgHWjGFLV2vS7WDLKzYaoE5Led6kj/vEpxqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urxfgzdgNkNjalYzsW15GYRkhaFvQNMbTlcG6Tm7mGE=;
 b=Ey6Cu4vvREUogGFRirbhMp+GsQ/NKqGl2MGH4+5eytHD5nTFbpywKlYQDxoq6kNTMjg5yuh8kt/MFfKXJqrH3qCRlSymC/OVq76YgLbWY8foae8cTHiPiFc2SryFI4Jxy83RsDHWPWJhbjiOKgegMsXh73TA3TN7AuXWcQ+PiqPSrm2kQ2sVM08UzpUYHUISjQ7ciYm41TGIGXL7env54xIcHM+EMvqpru8aSAyMsznz+YFjOfeVWTfFkTdtOu0tDAFXGFKvnwkflqsuSQ5h8/Qlip9Nw/qdfZX//RuC6/B8LEZBXgedVZoHJ+BxHHz8maqqajDwOl2yl+vlwTx4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urxfgzdgNkNjalYzsW15GYRkhaFvQNMbTlcG6Tm7mGE=;
 b=vHlDDpk7Ps6xOFJVDysSE4NqoOdyquOdDewka8n2OEPw1ctHhpDRSuWlwWAk3NLOjmaks0etZ3UCyoHvMp8wiouKkGFZ+FVqphXezPRNWoWjjtPYsg11GuqK3QDnAj7VgoNOpwtQshYWsQEIxT0SV0WnF0i8xnu7GploX89gVVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24) by SA6PR04MB9216.namprd04.prod.outlook.com
 (2603:10b6:806:416::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 09:41:44 +0000
Received: from PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f]) by PH8PR04MB10005.namprd04.prod.outlook.com
 ([fe80::1f70:77:cbfa:e80f%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 09:41:44 +0000
Date: Thu, 14 May 2026 18:41:39 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org, 
	Daniel Wagner <wagi@kernel.org>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests 2/3] common/rc: add _echo() function to trace
 sysfs attribute writes
Message-ID: <agWXr9Yntf4OiQ9e@shinmob>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-3-shinichiro.kawasaki@wdc.com>
 <a1668df1-a93a-442a-ae95-e015bcbeec17@flourine.local>
 <3ef4e2a4-c0ec-4040-a4c7-3687ed7e2d93@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ef4e2a4-c0ec-4040-a4c7-3687ed7e2d93@acm.org>
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To PH8PR04MB10005.namprd04.prod.outlook.com
 (2603:10b6:510:3b2::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR04MB10005:EE_|SA6PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d0dad5-5f40-4331-57dc-08deb19d0272
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099003|22082099003|18002099003|11063799003|4143699003|3023799003;
X-Microsoft-Antispam-Message-Info:
	+/z1wKKsSQsjJawmxORLHDVp0CQBCdOstLTUhr3fW4/1E9qofvsN6ZfIRlxw0rZUGQdzJEHBnKN6CTyIi958Wan1iN0JyWxspEn7jjhYsANhXc1ZzyOp57+fx9hCiUjTObCGhT9kAWVUdylD8KnyEfTXmE+qofrRbydN0IpMgojQXDZkW0thYWW8eFYVzutQl+lgBx+zOgDKEeGo2/xf34rSKNKnKoYuru4Tix49OgIHiG+HJ+bnM2tYgQtzhEPzfIdgfKmXncvAC5wYT94ntnQgoTDkCNeEjLGnVsZgLj+i3kIk7aywesAWdbxF/whURD4kflDzxjyK+H1mkZuOfXyieqRrgPWPsiZayCFEW+Sp/pENG54MZQzkjj+qZaUjbIDF77sXx5GLN9wa4zEWQN6+HWiaI0Joe8t2qSpUGw9FTGDKXgK1DIHnBndqfIL2H+VvsIhrkJ38Uh5n1V6NKgNyOn521WRSz9bj2uPq72ISn28jQJXOVWgqhMD7GobrH0lc4cJ5E6gBPEDFGp17p5V6sFmQj6vUFJwXTqeBP2I3wbOWyVMXpV3bnzI9RJo3qte1x3x1i3MKKw/+ihHHY/SSk8ByolMm+WdnV8lSSATiLmV6J8ZJrUlvKFQ9tNHpD0mNl1cxdmCIuCU1SVdjIf2VcJpEBpX4FlPLLOAB1RD2klV9Kq4TMXAs9vXdLLWb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR04MB10005.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4JZyF1dfQAU4y1ccKNTlYmQvc5kfflk2U0GUq572oXfAVBJki8YjK8H/UcK?=
 =?us-ascii?Q?tuvvK55/K6/zpP9OHEVDnlYCJWDSHZT3osGdi13LtW64CqrEqBpkw3rw+tOi?=
 =?us-ascii?Q?RYaeOYl7XQZDtCMsduzl1SrxrxGbv/cQF/Y7fBWF1U9Q8RFeUj1HHUeFGQXt?=
 =?us-ascii?Q?D3cGEMwjlEPkahyD3TWsblsKW4tF8tum3iJzBII4floxq9QdDiy7Oruq9Fxu?=
 =?us-ascii?Q?21KDnlbs9o8MSrrvIwGOo8zn1MfthnmI043UJfWpwb+joVa9PfuBLFdb+BVK?=
 =?us-ascii?Q?/YFP9KFGaoXjfOWKjrTFm3VgtlaFUjjo3bE6DKUEp1g694XcJ0pDZJRr+Oow?=
 =?us-ascii?Q?nIpqI7cDwgv2IPF3rzy0XILTAKCpSdqR2xRC3qzOQ94W0SDHQeFoQjMauxPy?=
 =?us-ascii?Q?uKBYsplQKuC2t2zjm2qJa3M4Yo39z/wUouaDsPhVhO0uZAHYNJGcJmiH2n4n?=
 =?us-ascii?Q?YUoE5yI8IzSegWyRLauTr+w0HAG8sUFNiFHYZjU694tRwRv6CqdQngR3adz3?=
 =?us-ascii?Q?i7OSU/F9fEsl3pMTMrGho0bW/eRJBBGL5BMuPTMSie8QClC3JeJGs144CJ9j?=
 =?us-ascii?Q?US65qHmJ3Srs+OaoFu2M6LldfHnOo0cYblkA9Nak2eqg1FmJAocUjqhQWC5S?=
 =?us-ascii?Q?4sNjXITzeK2kn2pswMLmRJ+VS436oCOXyL+lm9hGDLj34ONY96mQ6LTkpt79?=
 =?us-ascii?Q?V8KbZr7wcRqyEBkt+g+u7OCz9veNf0gFCpnGLQVztAgGM1744qfXWZREATkr?=
 =?us-ascii?Q?QaQrbeq10m5fyTdEgwt0wRt5hXf11DcQPFFM+vayhEdLhAjKaHt9tyCYsxOe?=
 =?us-ascii?Q?zWGlB2uMnsE62pbpbQ1WKPa6fvROVVogn9yDaL/yDwJdaFxOjcmoa16xmnaZ?=
 =?us-ascii?Q?XRUCMCqAvjFHBZSfnEB7vQd+O3ZUEpNT0Y5YngOVHmliUdVg6O9RUXZTL9U+?=
 =?us-ascii?Q?56SjJhj6a0haQufEIdkN7/5rQENqJQzAr663NmSZYmCufrCryH/Te3dXpihK?=
 =?us-ascii?Q?uBsZc2dO4AW1eCgsmQIXpr6e0dj+pL+3b472OFGGuHni49QpAI4dlWvGIXDR?=
 =?us-ascii?Q?4bH4oXxe+ePfUnEsJFq6yIL0F9nyNBqEz3JZPytGYtHdKWWCXjXfDqMrR8dN?=
 =?us-ascii?Q?uHbOvR60I61H2dG9IipaxhsGkiBSXrM78ZH+j6bO9REeSPPJflFxBSeShGgu?=
 =?us-ascii?Q?0hH2cfUKVTz8t3CZ/6ae3RWOwOw9Ur8KVTdPHU9ia1bjzSWITvcPnIh84rZZ?=
 =?us-ascii?Q?emD72FS06bpph/kuxpiSQZQRPde+k53qt1THIwmEDiY/AyDsZM+lo4sBkmBZ?=
 =?us-ascii?Q?L/xm5tYau+oVs9nmUefi99NCoMZ4dzq3/41TDNyJg9hz5ZvTfLCkG1m7uBbM?=
 =?us-ascii?Q?zC9BOEBjIfn+9jVy9mwUDp4372bZzFxtNJwzCz50TX41oH/oBYqhTAH9Qo7z?=
 =?us-ascii?Q?LsgSK6C2gOsrPp7AvsypF4JynBxjPQIXxqB9Jd2B0pq3VFosz66lEK7FCAVY?=
 =?us-ascii?Q?0wTpWoiStYy69CDcjexI+5a3yNgGmuTYYZKGkAHaSHTNoQcDVfqOcHPX7wAr?=
 =?us-ascii?Q?KnYXm5tNm6NOOxb9NdP/OQu4Anp7lndM5GexOkLw8JVoVV2C6MK+jAklNjOv?=
 =?us-ascii?Q?vPyjdZrFIZ+RipElQnpmrLi/gFzBMmzp9Dl4TM9qQeNo7cmz1sqmqeTXEiwg?=
 =?us-ascii?Q?I5oJxLgRML9s9c5+cR883ZTv8e5KXsefxPlb6CQ33rG0tttzaB9YApgW47FB?=
 =?us-ascii?Q?ZOMowm3ebBJJOfC8lo/OA3wWTAscaaQ=3D?=
X-Exchange-RoutingPolicyChecked:
	PueZJpgpWOmHN6sGjBQgTEi7xpaU7tAHDBS1uig1dn6vud7Zd+EI/k6oDP/glmfu6ZJK/iv/eHhuVb06VCm7J3p4h6CoskYUoF6Gm72XZWGeRsIV1SOxuaa0udSwzq5I7n9FUYUEgizhtQTfcK/AnKsN260F6ybgEcRcgJHC/pmyW/kIx1HlJOlRs5lWVwJkqxbkXepYsEO49Wj/9WmixkC7DJ0YdcE2JTbc/fSZfHPwL+Jt6/VjGJi/VIsSj3vtS/3gkzzBbhun3Jcq5EcX/LtO3o3yd+9A9/DW6fphMfXvPcG9hYiQxYDrNRX3tAuL8YbI/ZW18GMHlJwfwBfl+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YaoeAYYXrZ6fUuOilUF4vD1DyYu8V8PXpOAF/WmtgJWCiZGvzJgXKV/pcEl9mahu1hvAtIA5c6eEZDd0cFV5xhAiWu1gBezlnT4EaIv2x8mbIPPkVOuHsqs99HzzIZToEFYVGpUN1RlwjbBlpiLqSw6+nsFeVaAnu00BpiH++/OZUe4jOkI3L0Vt3a+nrOi+Wv+NVrUoI9Pd5SOtA9e4kwEQC10qoWCv2Tx+dXSt0WUsJbaXcYY5sLMBbXFqbyAL9zaaEvvTAOO8oSDztSUPyK5Eg0SRBII5b76BSmjzQLI2W3D04oeG34zoadoqPBXN0xYHiLtipNvfV0H39OH4TLC0qpLvYUD3mUfaeteOKhxtCjwXeKxO31MgavXaY5Qqllg0oYPyjkjTYvzWyilz6ax6AsZW7Qty777hLYey4wkNnWgkflnJTzGwWc7GZidLskiQoaeMDt3vVlNLg90U7TlYC1G/uJRfbaLLY9PpfCVE8Y0JOVX+r0erZJUvitJDKDah4N27higjJORfNR6QBmC6Z9HwErBuRzz5+/7av+Im0u3tEd1rpqccjcgEReaerDL/vvXEao0tEvwbRcPYYu9xh3s7vFLAtHXfS9uAPVFaLfw+VzWoowsMixFpiJPr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d0dad5-5f40-4331-57dc-08deb19d0272
X-MS-Exchange-CrossTenant-AuthSource: PH8PR04MB10005.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:41:44.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poeO/0UPgPE6fH5p7oxtUK5wdcci6Mn0W4wEUpIRihixSayC4lewIxhfYOrnY4iJyJycUwCJcwJaJi1IQkdomg9TGY8Ue2fwAF4SlzpUsOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9216

On May 13, 2026 / 10:07, Bart Van Assche wrote:
> On 5/13/26 7:05 AM, Daniel Wagner wrote:
> > On Wed, May 13, 2026 at 08:23:25PM +0900, Shin'ichiro Kawasaki wrote:
> > > +# Echo a value to a file. This wrapper is used to trace sysfs attribute writes
> > > +# when the --cmd-trace option is enabled.
> > > +_echo() {
> > > +	echo "$1" > "$2"
> > > +}
> > 
> > Stupid question, can't we override the echo function, something like this:
> > 
> > echo() {
> >      builtin echo "$@"
> >      builtin echo "$@" >> "/tmp/debug_log.txt"
> > }
> 
> How can this work since the sysfs/debugfs/configfs attribute is not an
> argument of the echo command?

I guess Daniel's idea was to do as follows:

echo() {
     builtin echo "$@"
     builtin echo "$@" >> "${seqres}.cmdtrace"
}

This can capture both the value and the filename in the .cmdtrace file.

Said that, this will not work when printf is used to write to
sysfs/debugfs/configfs attributes. So, I'm tempted to Bart's idea to
rename _echo() to _set_attr().

