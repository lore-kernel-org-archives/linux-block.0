Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80260305064
	for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823192; cv=fail; b=JVr6U618Ooi9XsJpNviCESHG4qjsgFIVBxLiZkNjduwBDVZM5DoHMZY/iwfqCq0QLaorG04dsgBDG1QmUwROfPZxX4A+2Ltbj8H56PMMLK6vkDf75YfVQmzXos+UN+2iFnL3D84cNEaKKFFj1SjoFBABtmmnSI99rxGTob2f7gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823192; c=relaxed/simple;
	bh=37ApreFlI5gSnxQxCn7SuMcu2PHpQR3LU8bev8z+5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QL76K5EWPuYQskS7PcgkEK0yCftsLWiq/YjMKqgTaEiHVoHXGN5aa4HlimrYzWzD3Bl1bFfrrje0jzvOQIGELM66blrTlh0TcZTDJ4qJslNKAsK5r0oiEFaXB7mufFLsOQ09iaRoRcRYH8sBJo0je7XKd5rc7+BP2vlK8hPGRZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bPsSC9nz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jcHIJh6F; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bPsSC9nz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jcHIJh6F"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776823190; x=1808359190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=37ApreFlI5gSnxQxCn7SuMcu2PHpQR3LU8bev8z+5TQ=;
  b=bPsSC9nz78qC1PN4aerWQYINzIucQ6PwTgo805W3NmjuNsm22OamQ1si
   ql+HX5sUw8EKk6sXeaCrkIF34WyGT5RvZ3HC1VubOPuMqm6kZ4smWyt8Q
   WUFO99nP0KTKgJkduOre+fOhGUMILgOutQoCaxUN/d7but6jzfCqAOqoS
   3saZrFCMj8itHLfW1jlha55TiO4HHUEc1b/b5/+hGXGzAMxWAuIRLKI+c
   GXEX5RzIXil9waezrdrquoY5MAnzGxKkLrNJMquj5cFxxqAJZcQcP6N03
   N59XL4jAWKGljoyU70jCEsoYa8iqLQGck+hlmqOGjXe7jG3zNtdlLy4U7
   Q==;
X-CSE-ConnectionGUID: Y9/i+yDNTBaK+C8e+t0O3g==
X-CSE-MsgGUID: UK5kd1+cRz2sC9OmGP/7uQ==
X-IronPort-AV: E=Sophos;i="6.23,192,1770566400"; 
   d="scan'208";a="143861377"
Received: from mail-eastusazon11011031.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.31])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2026 09:59:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrtno9k2RgSNnfoAim7ZitZs95bfMGN4ffZmLYVbF7QMTPcNZlOTLVsRWXjZN0aRwfyVuX9HOLkyC9Z+nqdtsiZkD1Tlg7owMMurDLZDrm9dcMH9oKSIUIACpbPxq05Dd01xv3ZGlaKNlGiAGz734bAtEj52MGpRhlzDPz/tjJ6cxajsAHik7G/5WKgh3TlOnjKlYiDJuTc9l+j/wZlZ7fGJC1FNWZiSWI0B9yozZaCMeJHf/4eyD2ZTVTnii9m0x6aqlCmD7VUOszyCT/H1rvVg29CheWK+rd77mPDZHKKdFDh6stioo1zZnZEAVjmYdM/dblrOn16ZpUsDPnnOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTl3jFzMZr0fnQyISmhoKF11a2x5MFdQTq/dAAafBIk=;
 b=MvrbdbJ0Nn+fAoF1JkG72U2xWMglycRERfatwXI6FjRwXXM5Mn60mkvRwwTB65WTrkCiP8zRdJJxOXDCKFOWBpMylACseNvYA/qysvxVfzmPmXvmvjOwulcFX5OhQKssJNXYYCIzL4WQJs3Fpc+crgWkFqSA3eBiOW2we20HORf0/rpbDkd5oxPSR/NEzZhLMxfF/1/YG7WIs+qpQ2I8R7Dv5Nd72u7N4nTm7fDhun2l06LyCflRF87i7B5veGjMMT5Qt5JcMCiIfkeZBwOs//Y3jJODFjynNePxt5h5JYkenRCotU+tKTSiQk7HFekh0Ykm/2IjLGt9tn6/xhE8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTl3jFzMZr0fnQyISmhoKF11a2x5MFdQTq/dAAafBIk=;
 b=jcHIJh6FR/85dY9poefLqzqoCV6wTkIAdDn2r2YodrRRL0mTrJ5Qc64FPSPkgGiLx6TUKSNk3MwvjXNjF+1c3qXemaVn8TBfZ0jtXYPOOzf5i9KH85yv3ybetcgSi4gSBHWWL8Y7oNARQgi0sgeOHWL/oWaWz5ggNE2iOjxiYmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN7PR04MB8603.namprd04.prod.outlook.com (2603:10b6:806:2e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 01:59:41 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9818.033; Wed, 22 Apr 2026
 01:59:37 +0000
Date: Wed, 22 Apr 2026 10:59:31 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Caleb Sander Mateos <csander@purestorage.com>, Ming Lei <ming.lei@redhat.com>, 
	"Liam R. Howlett" <liam.howlett@oracle.com>
Subject: Re: [PATCH] ublk: fix maple tree lockdep warning and unpin under
 spinlock
Message-ID: <aegqG_y2VXD_W8y3@shinmob>
References: <20260422000856.2362220-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422000856.2362220-1-tom.leiming@gmail.com>
X-ClientProxiedBy: TY4P286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::10) To SN7PR04MB8532.namprd04.prod.outlook.com
 (2603:10b6:806:350::6)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR04MB8532:EE_|SN7PR04MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbcefd7-137c-4905-e1c2-08dea012ceb2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i6JFL1zRcU7G4g1vpKa8YpQur1Xc+b3eoucy1L11sz32lANJvO2PZx1M+WXovAyNJO8UrhuynKIk5Rm1K3Fwp2VEqI+7BesNyPDe7a+tT1Zyh1ytqI1hYvdEGB7InUoOc/07khJQTuksqwlUASmhuc88beOZC6XmJHMLB7q3VBDdiBZRlapRW+qloq3HgWpxjE8FfojEKl9ue+TTdtpXJ0G+JofEzOtjo/7oaf4WOYW03X6raxf3JNqSQPSONyxLnXyssmtQpEAd1faubeEDEmR0YX7hmPvEsfHwaw6SUR+Yu6asi8/LX+uOCkgS1fYX2T2KylwJV1qNBuAudtPcx3yza47PpHLqZhr0h4ASzciM8ylbRL5uLs1FH+9c3Nva1EtwZQzWvlk834kkjD+PgOYzSd0gOIovQg4d4mBB7X55y5jixyBXzUnZnqK+aYZS6bKF/CbAVm2ifyk7IF9nWY+cBjKBQVND3BK3RDrl4WyjxGAUC974kBsV3Ch64sYHGTi45cImMM03aNvG4iGtayXMzSp576TapYlKTvk3rpJsa0buMpSW2GEZ89cGXfHHKomi947eKiviC8MyrkB4l/59qKzIxVCjryPYx/rPNjJ7r3r24xV4LLJ0ej6VnNfzeBtrwlSfiyaub985JvK4HP9T8TK0AvdfInTjWH1vbvzEoVrYNx5tr4ltU6qn1OUk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUx9dwa8r3+yypNhiHPeLsJAidj/hRU3pkhwtaCGEcplBdkbC9V3zRlSiFWu?=
 =?us-ascii?Q?IUGlVujUfoP9JpRv8D1vRq4aQMqL9mlia2shsSvhMoqqhXIu3yoP5CPKb0f4?=
 =?us-ascii?Q?U/+bkVK2cjpQ/NgiBPZuaGwnTzzeqWc/GtZGP2t7LGEQpAm3LWFRBhBu5za9?=
 =?us-ascii?Q?UbCs9O40ezViDjGUnJFAHx4oguaWn/OxF3hTIbUbWOt0AZIvmhNUehhcjqE+?=
 =?us-ascii?Q?gzzLcWbsNO9ZVnzLxu4yOl/i5oDflhzCAZxNAOEFq/zxDBLT5Xvhj7eoj1Df?=
 =?us-ascii?Q?QqNVZuEiH51iWQvil5UQYs082L0oS1RzKQjGGV/ap42qtvl1DEtdXPydD0sa?=
 =?us-ascii?Q?dHb1n8BfS94IMhjr1ODVb5AMfT8HV4XpmoYcC3rB7xJ2yp3A50TpkBvESwjI?=
 =?us-ascii?Q?I37zWuGpkF9zJBnFaFHMUk4h1odEWzRhWlSMgRD/8XWoX1W2sMkLw5AEpIDT?=
 =?us-ascii?Q?yMEYXp6DUIiWdUMB8wA6YaOlJtQ7Iq4dYoHtgSACRIyJdKJBssiqX89z6jLF?=
 =?us-ascii?Q?psRkgh3sCM1PTlSuuM0xfyTGJ1aUki+4M2M5t9s4cw3Fpzk09mf/9gG7NMd4?=
 =?us-ascii?Q?2tC303F8/MLqVEve+nRNS3oycaq8kqhei9tO9H9LBQMhL9Wy39yz4y/74Zu0?=
 =?us-ascii?Q?TUYluZij17+/4HEDsHZgu4OYXOtdZoadX+hHNmLA6GGBekUKZzgK4Q3W9PfE?=
 =?us-ascii?Q?ICd5Di0lBwQE2dGspc2PLGA8m9YWRUS845p2IhERaqL5fEsSfmkeKFuQ8BiL?=
 =?us-ascii?Q?SQdMyiFcig1e2C5CnzWqtB5NJFNjX+kKNNTrGoFMPL/VEOaF065BdFn7t27t?=
 =?us-ascii?Q?y16WmxUJYwPSdRwESw0aokh659/Z3OP+bNPASzrf2FdzvvX/eaPSy6LiymuJ?=
 =?us-ascii?Q?6PzkJyw8i+dYG0POk9jICJNMeOQNGFAuvcA/W9VEl/RapLfDOii8bmEjLEJG?=
 =?us-ascii?Q?EUjuGNDrXZ9oF8giVYtERHyD6hMp9bBtKFQy7xiltlNjOi55X28fYgz/t+oO?=
 =?us-ascii?Q?pLxaLFMBRXXZ5lXWhu8SeBG7aeX7rYZk87tCW0fLaZC5gZEDIy6EIPsDUEHf?=
 =?us-ascii?Q?px/uWqaHX4MYGZiFW/wNtaLpGUklaRwVcsVgO1UixqqPGJvce61Pz3P7PGhB?=
 =?us-ascii?Q?/uC0nUxiSGzP7hKksi1wtnc91ZCtTlB0dJkapFP//+ljkcpXTIbo/rWckTDZ?=
 =?us-ascii?Q?jc+S/PtBgSUXV9/GcKPl1wDNjrqPcd57x+bZvOSvdxZOxl0HQ27a30PVMHxL?=
 =?us-ascii?Q?QtRLTnAE0A9VLeOtt/ruT6Gj3mRJFsfskpkwSdqDltM4zu4wU05qhe6QlJNi?=
 =?us-ascii?Q?FLwykf8gAaBKEYNiA/H0bRfLNhlyyS+5uBh4T6Fsf10iRjWyaM0r66PnMiTP?=
 =?us-ascii?Q?gkY9HE5YYq2Xq26Z3BG2s05pB9wLtAywWX42VHzMs53ptxdwZKrreMCmzqqZ?=
 =?us-ascii?Q?YKI5osieUd1mY/lSOpRM2DmW2VPlrpggIdNvzOeWAA0o29AtNbEr8Gdmjc4K?=
 =?us-ascii?Q?AkglxyS7U+B1kSmoZxfqM6bwt5P2Pub7iu/gyGqpmrD/hSOMr+L0iDpdTKzz?=
 =?us-ascii?Q?1QIbt/8h3OCQaeaisJdHyikaF9/4GjxR/rg1tblIB1KCafckftcKzpxv7UWR?=
 =?us-ascii?Q?ghrdpQkLvmsSz4bLnaaD1ZnqFj6kzZASOaQD+X7nfrGEI+bB7cTql9ykDZer?=
 =?us-ascii?Q?wbPCTl/QNHnPzz0r4CWOABf/ND9vA+IkdzOLWweRMn7OiN1hSArLmZVIQCTB?=
 =?us-ascii?Q?1ACN0XRMer4tkN+BoL/Ey+bcP86Erz4=3D?=
X-Exchange-RoutingPolicyChecked:
	h3GrF1Uc3034PKSSt9Bl8Gyev+H7NHojF0G3ctay8wgCEAjU8wPjJAqyEUsrxkkhKr7sQboy/w149pxfOeDfFL1rbGH/IybMXcZmU7CTtsxFuoV7j/F73x6yA0MUrl+HbAGNEvSjaVWRlzHCKe+V5FxXwLaNNy3fYs3v4f/UjciW+98l+T7M1PgIzis22uYPDkwPVM7FdKupWLAGZtj7+l+xgIlpCeCmQ8r1gBN1yRvVx2b0dU+Q8/WD/qFSpqKXhsxkFYw5YqwB0s5wyvn70EPtED7eIcHBBnAZ9RRC2aVjgVruBUWWkFU3sOje6qejIBwS/vC+wQ9ZVBBm5EzqMw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EDJURAOFtkgmUnUdio7ZPJZDHbAOAw+PpoCa3rAqxSqBpfceunc6Vh3zWibyXIkwo8NseJeBTGOPpvqCZMB/v5zk0j98/o+cfy3h5se++g39D7qCCS6G1z3806P8CdPOfmNRHg8z9jw0B/a/Ef8IPgJTVckUWeChPTui9YokzR0Fpw+dQJq+tICmPtp/ifyXoARae2lph9eCWJaYl0F/XRPU0OMXbRR/p7A/BD1ugt7plO4HSVH1quIyfX9OAI66a0wBQs8kt7Ymz/lydeq/YcMDpGPt2twMK+Qy/dgPJI9OFw9sI0UczZpp5EHAIzf1abwvxcm3oOHdRsi2s292zH6/7k1DharmWuB/QbsYlMruPkOjCor/LvFE9sM4LyrJwW32TmHB6NwqYyGNkFNFUNQiBb3HsQjxlTGaDvy8F5bGFTchI4R75oKRirCRuoshR6ClTEKoaDsJbMzOIl6FDZS/kE5V1A4ebbLomZYkeQpwFzKAgjc0haFXfeCboPespHfQQ0nVfzTCLReeBB+rVK5+Tcyc0vF/G4EBtym1MS/7VnbDzJ1XXERhtFDk5jfAD/8cJetgJIn2nDBzqagTt/wVtMTzs1x7JjHXwtnLOSbR4hLABLd5ARa/FxD6pc0v
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbcefd7-137c-4905-e1c2-08dea012ceb2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 01:59:37.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XDWi+vAaqx0lI2JPqkJWZ2PPmkIwa4dydspshw/WD7lTOxQ3gl+ouKwfKOBlAx7CGK7sfY38+YDtycJBpyXIgn6JpzUZo3iM6q3Wae9XLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8603

On Apr 22, 2026 / 08:08, Ming Lei wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Fix two issues in the shmem buffer maple tree usage:
> 
> 1) ublk_buf_cleanup() iterates the tree with mas_for_each() without
>    holding rcu_read_lock or mas_lock, triggering a lockdep splat on
>    CONFIG_PROVE_RCU kernels. Add mas_lock/unlock around the iteration.
> 
> 2) __ublk_ctrl_unreg_buf() calls unpin_user_pages() under mas_lock
>    (a spinlock). unpin_user_pages can be expensive for large buffers
>    and may take additional locks if folio refcount drops to zero.
>    Restructure to drop mas_lock before unpinning, re-acquiring it
>    to continue iteration.
> 
> Both functions now use the same pattern: erase under lock, drop lock,
> unpin and free, re-lock to continue. Extract ublk_unpin_range_pages()
> helper to share the page unpinning loop.
> 
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Closes: https://lore.kernel.org/linux-block/0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk/
> Cc: Liam R. Howlett <liam.howlett@oracle.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I observed the same WARN at blktests test cases block/033 and ublk/*. I
confirmed this patch avoids the WARN and makes the test cases pass. Thanks!

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I also bisected and confirmed that the commit below is the failure trigger.
Adding a Fixes tag might add a bit of value.

Fixes: 5e864438e285 ("ublk: replace xarray with IDA for shmem buffer index allocation")
