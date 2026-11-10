Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794272426;
	b=oV5EtCerdkiSZcOFx7jUT3T1fb71TU1QuDFXT9qah1m6F7fLeXE0TzRzlSIa8Kj8t7A5
	 1EYCr32ebcQ0KQcIv5Mnb4P4UR00UGLciLIJmlSfGHLePnxwh6S6rIOaEmqD7iCJpelzT
	 Srle3Y/927WNd1VOWnllJ9gCOr2O/w0/3TcpgdZiiEC3LRixTb88hLQK51vWORnahNUxr
	 NwyxLtZRlJDOF/3NH8ZCWRdde7ZnYWxLAum6IddiwapdJMUneqG6tkNL3pB5vRezeK6g2
	 OOsQ+oAJ5SSsr2UQrYRmExKso84ApCkH8GVRXJXyWFDtyX9RzUdtDefMhccnIxQL7Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272426;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jVwf3MRyC9SYxr5MRCstiB3XFChxzrBDywF1q9MEhBA=;
	b=AULJCdM9pjyrnHX5rBdBbacUuXP1LCU7sgGsqdc3/UGU/YZfgKa1rbdIEePsXx1nWbqx
	 y3fRyYkwJPPlqO/aoboZhQi0zt8pkufGIyCK+ikhhG1xEof3FSKi1WaPZ5EqNtnkRmCJ6
	 ml1Gq3xeOKCEDpvUyqSQ/nXoNuwNKzemX8gGpDD+p643nyBpjIDHMTJZIw9hnWhy7PnL4
	 gx0CmcWLFTzSglCErksUKT2Bw+4ziO7Kg99OCA3B0Yi5OkKoSj4V/yJ3z72YeGirVwIVn
	 aikX386RidNunURI/BH6GZP4Jp0Pr1/EvSGXMB0n3ITL8Efy6it5IMjPQy0BsBBY0OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=DGxZRMpc;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=iUtvLrXw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04165606A32A
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 01:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04165606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=DGxZRMpc;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=iUtvLrXw
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794272426; x=1825808426;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s/JWjSn40PbUhaC1cDi6AyeLpydmJMPSk98ZVBvQUJE=;
  b=DGxZRMpcsYk2kzUV5UcDFy2UWVTWOu9Z2r93g2kTBlepYZg/cMdmVNlz
   6gmVlZxGRWzTwjvAFZGo/eR9lixee9jAyOmrLzmQPcfIcGMOZevUN+iex
   gD7qD6YaKQFhKc3OtKVghwNATZ8x3AWqy+XeehELKWmUsxcE3F8UWv7f1
   21rFzsFzFyMtx3v/8/CE5ot+Gu+Ykv/cujtUPX5EAUI9a76IR2INv5fye
   +OT4oSdjIxYoNl0jWFzYHso3lTxvuaWu6tOZeVvnOAKiRZWjvmYDtCnUU
   jqEntlBKOxcFsXzJzcdnQNzf9XIf3FcXv0yqc5ADIQ+SdKs/Q+DDM2Drb
   Q==;
X-CSE-ConnectionGUID: /GZp4qu6R9SaBJRt4aQazw==
X-CSE-MsgGUID: aAbjanYhTYKGBp5A+EAvRw==
X-IronPort-AV: E=Sophos;i="6.27,204,1786982400"; 
   d="scan'208";a="160464621"
Received: from mail-westcentralusazon11013026.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.26])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2026 09:00:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wva7IBuXjOCOfAmRNGTauaC5dXFgvCGD341FNfaGs4+GAW35cTomlKKZQ73QkyYeyI2RHAC423F/u+SvjAO5NuO+DEAJfmw6MoWhMS07ywwXozdoxvIx6fps6UXeV3qyBveqXQjYHBNP9d6i8fGklE/6f5j19gDt37WlQkFYZr+ePeN7VmEq4cQiiYAOnjg9r1C1PFSFIQyb1MwnBOpHmc2FEQ7M0IqSYfXA7+O5WR0ZAU4CCGs2dIve1uLlzBvA8YGlkAnb40TW6aSdpR1/AUu7b3cpAw+30WUeinMOqVAq9GpZTocZct66oygOFFHbuG8I0p767Sdx0MOmqVl/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVwf3MRyC9SYxr5MRCstiB3XFChxzrBDywF1q9MEhBA=;
 b=YAoshCBhelh7OdRHB3D6vOMor5qcxoiLL8bO6SLt7FxA0eWo1YtEIijQqAYy0czBirBoMaIZh8Lns2YqLGlhzcNUbu1jOqleflluajhAg8AaBNkeMs1ZYcI8ht9DjF31rN9piXnR6bLru7dPIV/KP6TbzoevDGtUqT42RnRD4dmVlN51lOoHP8xIXOB03+7AtKT46k3KvfEcQDvBzrWtVnGMH7Lhsk/9sEogmUflE7dPI/7qrdnqUmfFTRewVdhwHjJvDn8iL3rIDCT/SMx7QYI1rZiXj3DcSuD543lLQ11Jo0S4MlsPf4Z05tNNsBZ2rNbM7ke1+ZJp+gQHpOfwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVwf3MRyC9SYxr5MRCstiB3XFChxzrBDywF1q9MEhBA=;
 b=iUtvLrXwv77RPhDxVDjRwqAqlWw2e+/IAaYw9+aSHJQ+jYiFJj7jJsSQtvgvgnNTanHrwOV+NOIl4p7QW4Lfxk2e+aTm1Qn6frlrjvE49TskmwQhGFi7u/HCS7PBsAe+z9rAEswkXjnfgIbRIGb6zj0qUQW95UUC8AyYrqy+Yhg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV2PR04MB994015.namprd04.prod.outlook.com
 (2603:10b6:408:427::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 01:00:23 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 01:00:23 +0000
Date: Tue, 10 Nov 2026 10:00:18 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, blktests-ci-bot@kernel.org
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
Message-ID: <avJne0hJsYHQtevc@shinmob>
References: <20261104112744.1630864-1-stanleyjhu@google.com>
 <e8553327f2610f51d7800c1bbb1544201cead9fe05828d82975a7f4e9245d30e@mailrelay.wdc.com>
 <avBj_fY_cZazcdXU@shinmob>
 <e33d5a5b-0fd9-403a-8a3c-36370660c0bf@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33d5a5b-0fd9-403a-8a3c-36370660c0bf@kernel.dk>
X-ClientProxiedBy: TY4PR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:405:378::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV2PR04MB994015:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a9de95-f13d-40c1-9f25-08df3ec5ffff
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|22082099003|6133799003|10067099003|4143699003|11063799006|261102123227099003|261026140227099003|261021121427099003|261022105027099003|56012099006|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	X3pl7/o29w/uzjQZfohLzwJorSPeWxMOu8tV/Gj9JO25I1baqVUZ3k1GONEigWPaTX++5dlrr+MARFcxKsrlsnfiWlddurOKVyVYbrwtIrR30F230Ir0nO8eq5cTCkfNDrlA1qdx1uoxQ7szjliUyJLmjU7X6GLHwkztE9N0yxQLqflTJlL1AsBBDWkpHIgfJFAADnoBvs50oyOnrQyfxW7zp03rXRbfC2obgWNWjhadnmW/WqMMhiKelwRrKwvf6AQlxyTVEjWVtX58YyojZ0rK8Qxg7KnRWDz+/v7gYwDnuZu8wSJOShrhowzf5TbUezegQK+lB1RcyefJo3oFXk44PlNR0WCEpm9qDHxJfiE9sOlyyrfU4Coa+t/gwwbTAAYxHvNZxGSRfquaNsD/4Vm7hAlwZs0K4/vvkCYkNvQVKJRmscU/PWQYF4323H154uInorP2Kww0jCZUKGBl1GeBl+F1g5aqo8BTwQNEIgnDCJdM5Cc1fZvS7/+9PEEmEHrv21AxyYTWRk/P27aQTWFj8p72h2yTFYJjIzkbSdj/dWJngiBEyGeOOrcK7jWOma1JJ/jpybyKvf6/mqlp0hfW/K3L7WBWF/w9F8YvtBRlOhUZ5VnpYPm4wd8bxRZGVh+uVlatxJqfgGwlKRzqm8MSkZ3hz/B7Frffs4YvYNs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261021121427099003)(261022105027099003)(56012099006)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ud4LTdejoWgfCTrnP7GoEw9laTApv+pOwiLX6+s40rwjSWwFW01FbQcVJ+B5?=
 =?us-ascii?Q?6XP6kIl0L/wQoup0z54d0qRTH9GOsy3aunYSVloqOC6rc97lWpa06xr68JQx?=
 =?us-ascii?Q?vgIlmeF6jhCyM9DYSScwZOm5lo/QV3sLStW+JCeQ4kvxKfPNY5x75UX+2FAG?=
 =?us-ascii?Q?MdhY7wVmN1R7yWr16dHQbTJTHSCIhDId0oLpVjbmzhuojrJ2/KP+efmgvT+h?=
 =?us-ascii?Q?DvfqTUKpsHcpS/IYLGX4wSd2AFg3aG78BG1avFIS5zsIsmqzXbDuswZv+93c?=
 =?us-ascii?Q?YlgoP9jPC35wjcxmA1SoKsQqe29JqWxBGU7IHbJIYE/AXivS1fcYS8IxKbrh?=
 =?us-ascii?Q?iNb1gMfFRskg6zmn55oVlP9zPczw+ieY7hCtdrS4DlDYjTOOhAIH+UBCTd85?=
 =?us-ascii?Q?CughSUW8DKbbiQ/D5933uK0ej9im2wCWaC7e5nPyPdoqG6Q34gLoWVUZWm14?=
 =?us-ascii?Q?DAa1LGtwY+mlejzabVRiM3mvxC4Nm+zduXd9Q20TcUo6vx2NVRa3jKxLXrz1?=
 =?us-ascii?Q?p3B+6KOhtHg0hOzLcywt2ftllaUAPpEvkdaSoAN6inISLpw99IpLzei+ES0B?=
 =?us-ascii?Q?VmI+Mb/QcnMwbvz6oBe9HteF8i2wZNgMx58SQUAgt+aW/HhDPhTY/piM0mcj?=
 =?us-ascii?Q?m8sZXKCjfvuejucZU4ABIUMKOTARmXqxcKlO7G3JT3tBgxs3A5xistTYa2ER?=
 =?us-ascii?Q?D5yZPCSy0kfxdF3XMHp/t9d8vn1Mi9He6DmBq1SClAbYlkL9fCs422aySIgr?=
 =?us-ascii?Q?Rxnuvx96++kcuqXQkz2txkUnd1dFLZEF3V3pfq6Bw4LAGIBhSk5ancsfDOay?=
 =?us-ascii?Q?7TeBws2Ysln09USub69MNECZ9vVB3Mce8H61HixdDqBN2BjAdALyn7GUNZ8u?=
 =?us-ascii?Q?kje6AX6gCqoI81c+plfP9TI6+80yfXDyllmYmg8bAH/VGdnany5DGhlg4BSb?=
 =?us-ascii?Q?BQ6b+Nw3ZFRNq800ZyidXIm5Un9c/pqaN7SJyduzktDG68fQfcb68OAmD8hR?=
 =?us-ascii?Q?Uwb3O6+2bGI/jqjNSOs1otb2XMveLybAwX6XGKKV2ykoNcuoKOF9EhJWY24X?=
 =?us-ascii?Q?ZoQVtJYo+6IxpVLDuwleDU6qpYAzzjdmkVQiFtJTeqgJSGsvOLGoBaL/XyfW?=
 =?us-ascii?Q?FR/jO7N60y6vDiaDOg9jNdSeDUmIZKOfG0j9vaHp9EmwRMkqALSb9Syd3t2y?=
 =?us-ascii?Q?4CSGdQzs690WWCCn6tVQqVqFLnyvwuCYYWl6VS2Ro2tjRh58+8pUzAGfdmYZ?=
 =?us-ascii?Q?YniMDoRBANrgFUqYu0Kilt+7owzONGL+6tkcF8L/yjjjXQoKL9kuajiPfwrk?=
 =?us-ascii?Q?NcEHRcLe5pQhJwmfj9vu5HqweLAGl2ny9uYFA0N6MvlFhe1Y+ZOG9V53IA5V?=
 =?us-ascii?Q?RTeAeHp90JxT2QF4NgtfoMDWtqpkY9STUB97bqrQzxdI/YafNgNIDqVMFvQV?=
 =?us-ascii?Q?khQo//XEy0Q7e1ju5aePeQmiImefTgnDy9Ly0sBuFhLF+PpWs1eTBYkZTZFp?=
 =?us-ascii?Q?kRnPmxulfi4oD/5YgtAPIHKp4KJTFmE6d/WkW9WrD/Ag4mvct5SV4xY/mSFC?=
 =?us-ascii?Q?6uOibCdy1Oe7sNTklboBODUXRJ4vvnQMjdXQU9PKf3jkVuv3Nv6tRJh+tYoJ?=
 =?us-ascii?Q?Pm11rmOJfif4dUq7vik6+u8avZOYrxXnjlTUcdtR3JaSYLEMOgLmb1j9b4c+?=
 =?us-ascii?Q?LfDmgb4eWm8KCns694NiO56sLHbrEeSics7WlCyPNbSgUz/0zUXska0R9q8P?=
 =?us-ascii?Q?jbfIcOnyApV6OFxSTqoKd+a4b153V4s=3D?=
X-Exchange-RoutingPolicyChecked:
	0VGaYrYLVx7avjhLosubjM8cRFS8VijCVjeXs8TAnDhesdHbZqK4YCAxYvfZjx89mZClmlSBBiekWSYwHjn48OXGyVlXdmcMFeMSGL9ufXYATnrvkYhDhGrlvD/A5lehoV5NpPAzWX9XQb3eJDgwJy/4SMrBC+R2cC24xRAAygXK5WEriyTtTIi2dx+BRJ96j/AbGFKpCCOzfsG6iFXaRyS9du9c9ic0nS3xIxj2wFUuoOz1kFPI58QOOYjAO7qZnjZFBcAWIolN4m2QHpOU9qyh47Lc67OxC0mWQY52krKSIOPAfy0zTil3RwY6fmX2rPtbc3/uAWnDg2IFC8qNMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UDzaDD6wFQEVaR8Gvj6t6uYFOREl5ybldmyeYd+DLefEiknBaYtMN0Gjo2bbTiZJTAIrpbNNbfups95cvLz0C2buH3gC5bG+nQVcwbpfPFoTmc7NhInm2ToGhtifzWGVhQ8YALmLxl/qiGys5/mwg83R3oa2aLaSISjOZ4qCgzfqwZlsp44PHjnca0m3d+wAaMIljpVvVIJCsy7MmQeJ7koxajXq2+RHAcpTS+XplIuZUG5g0c+RVgRhygb/zNnHUhRtxLtiEhE6/JrgjLirtuukoiGPxjLRZcoRI4ce73JGp3jzD68AW2vMElgwH320xHLmNP82YL4CnXMpfsKsYarRe1KWVrO7QRk2H1aTptqXe3hVRrfMsbPl6abj0500xQXv69eFrWxibIj0LL0fyIASHuV7HNTdR9g64jT19p9/Pl/VH6pUgWF76kVOOuxcfZ/sJNjTfM38DwQUho9JGn7HjBmlmnmqfoVFf+/bjrrLtYcIhSE+kyi8k1FTrJDekkU9I/PEU25SZVbz1LuVB4GHdGv4jT/tmKWQfZs4SG/XtwZ2OMdDvbWYWBdXCwoCytqRNNZllTJod60rXQFENbuca9A/qbZ9KogQnzbj6GmYIic0P6+wqt2jv9Cp/mEr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a9de95-f13d-40c1-9f25-08df3ec5ffff
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:00:23.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVOaR+6BBwVDIMJyL4pKwu1vd7IgygniqWRDR8hM1SoNXb/cQT1edRzGSDF9qCpLTKK8uEhE2Izg0pXyPTgkcxEobA0B+Muiz6WhhVHPY4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB994015

On Nov 09, 2026 / 14:40, Jens Axboe wrote:
> On 11/8/26 4:59 AM, Shin'ichiro Kawasaki wrote:
> > Please ignore this report. It was sent unexpectedly by blktestes-ci
> > misconfiguration. Sorry for the noise.
> 
> I would say this happens fairly regularly, but it's actually
> more than that these days. Can we improve on this? It's a
> lot of extra noise.

Sorry again for the noise. The blktests-ci system has been testing patches
posted to linux-block for the past few months. I enabled automated e-mail
reports to linux-block about a month ago because I did not see any false
positive reports by then. However, false positives have now been sent out. I
will disable the automated reports and keep monitoring for several more months
to confirm that no false positive are generated before enabling them again.
