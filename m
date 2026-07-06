Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434A351C22
	for <linux-block@vger.kernel.org>; Mon,  6 Jul 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306577; cv=fail; b=gEbbHuqCeiCS1O+wPOmd5VVMQebPQH3eYLWlquYV4fKWHrjtLxXtC4HU9K+Ox/ND6ILozFU2a0LiMhdmRqCH2ABT2LUytmuL22CZQXI1v+D/mwZoQAcHI91rFRrA3/VFQhrgzyQ5ECJbUd4v2FLLRhzvh/N0EWKV1eEjLRTwAKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306577; c=relaxed/simple;
	bh=jvA7mdvFxu+hDF8S6af3PVtLMU2x0NCzCKfvvFNFyAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e1OPw4zesz5i7cOoktFpfOvPJ7YGFMxY00Qn10ZVrk7ZiC5TCIb2UNhLuc15xwx1DBP5ItGRKA0s2sLeybPgbTtz/D57K/v1ILyg1XxhfAfQd0FSVnT8efxjNTkUXPw84iY9+4lfI7x1Iydy7e1GSzUDZaEOd+l00eeHZ6iD7CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ToqbZKdZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RAjhgeg2; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ToqbZKdZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RAjhgeg2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783306576; x=1814842576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jvA7mdvFxu+hDF8S6af3PVtLMU2x0NCzCKfvvFNFyAo=;
  b=ToqbZKdZQi4ucrKpi+Xi64z1lKv1rqE7E6AkvaNUjFBHtQnsbLKX4zJj
   SZmxqbfcL6+sp2gAoCrx+AhF3W0ER8Cj2gtf/xfXGnyGTDR8Q4Ecfl2JF
   xOHFFiG5V6xkoG1heAqelhgnJN7+fnhHGNFJX7gjFL1w4JeyrVV5tp57S
   a5baAGPI1WpMPQVyFfAtfUBuF5tMn0AD07zYq/5hkG/8bOKLERUu2t+0r
   dJiyVl5kuBHNFa9aRYj0WeTQcHjbXOCNAlQ+5eAK133KuEtDT8EQ8NR0r
   mS7QKGgrI82N6CedTrhY6F2pOhuy/zlhtvrmV0HsrthSejBOOUUZRnWa+
   w==;
X-CSE-ConnectionGUID: XM4Z6VZuRIaZ3KQKFD0f/Q==
X-CSE-MsgGUID: r3/X6qbDTaOJM5BuRtBvQg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779120000"; 
   d="scan'208";a="146282233"
Received: from mail-westus3azon11010045.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2026 10:56:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpP3VuV+qLvIR6ssdmlels2Yj0X1z85/djwwXUKaWrAjVJflw6jngBtw5Jm0VCzrpVHSTIBSvq9RLoCaE32TB+EXyw0P/vCHmScWNIH7LPKmVvuGgiWSVi4k7rOvFFTdVOvwA5Hr+oSNIBOROgENRBdeYKYiqmhMPmJCiwmA6ySdMrc+LDPEXeoNSWcEj41VGHOvTpQLFDfKA0oQPzjAqUz7H8+cbxFY/uHm9riBxSR+1Ow2C1tJY6GkoaoiguJXYC75u0HyKRRjedxQq/xNjh3htFRTYBgtJ15D4nbwdddhsKDdbdr78ULUxx+jiMl1eROBAwUnFqeUicJ6jJzlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnYSJRIoKrFpFG7CaOj7qFLNyY8SgPu9jg/vZujZUss=;
 b=MUJlcQu6izQRW8flvYUvCMF+b5SF7u7dSNhWdHe78PaxGxPWkispY/4bpmDVLvJnDYOSZ/uV4pI5uiZIduVLV3v2MQZFEBKyYW6//pI2+cwuFfrqO+NqFCO6LafY+gGx3TOgqgFuPKEGf2e2kHJL5p0sduc/Fn6SzK2gOdJF23/b1OaBHZrKSD+KxCJAiu0115yZIslWNTCNnUg/1x8y4VcKR1hq0cH3Gnl2uIIBdNOBwVD3qzCVNOlhxv6W89tI8GAm6Rr3g4xJh2TfJ/23uZS4/aI/9PgEfQZ3UE2JTbxbCBSl3/z/FKsqWRUm3mKEZxBJJ3F8g8Xk5I2fb+PFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnYSJRIoKrFpFG7CaOj7qFLNyY8SgPu9jg/vZujZUss=;
 b=RAjhgeg25Wv4hVsHYZBoW6Vx33Gw4Dd/Qk58G31MIHtCTtYo3ef5BV57eYiIZAk0Z7QlXbKjmmWf5Yi1UatES7Nzl1vfkPIt8y0rol5hPTfRd6bZQzO1Vu+B/+7XCJL/NfJKk9Vi2wfOHJZQtD2faOKwNPJkVAckigrRxL2L4Jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB8246.namprd04.prod.outlook.com
 (2603:10b6:a03:3f7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 02:56:08 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 02:56:08 +0000
Date: Mon, 6 Jul 2026 11:56:02 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH v2 blktests] block/044: basic block error injection
 sanity test
Message-ID: <aksZLGgSJdqbt7SC@shinmob>
References: <20260630113739.3601443-1-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630113739.3601443-1-hch@lst.de>
X-ClientProxiedBy: TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a6693b-3554-4277-cb35-08dedb0a20f2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Sh8eQUffvis1sHVUes7QfLeizk3GYPFAg9ztPPFEKGRD+TLSpzy7qFfcGEmQ5ayyX1JT8Np6g20Pu5AVLpbXSKQiiMoOFdiNf4KsXnodEKdEOayUAERN90ffe4wC01DlcXkTBNMYney5twfNgkPd1pPusCf6Z+pALy0DAFUctQShb/lp35MFyuZzd7mOHlBrat6HspIzruRqsRPCyD4n70RTCRyCRcOhCmJs5j9fpWL2X03vfD+vCuXnu1aKcHSi4Xtkcvfj1q32jD9S4KTIsMwT/LLRARujjaJLJb7cSkqoJ9/hXUA/wAmaW8uR56IW8gxLStT2b6kJ5t0XDttZN0sBo6ZzDdNZrcCndgmiBHvWzxV+gCgNyrfXOd/5Vxw4uJKdRSEOZPtPlmlItQZwMgTs2xNOE5NaKUHRkFIqqqceL13xR1G6ukgk1i47FaqDV1toVAgeISfae2wM9wMuZ2Vl6dgGBeg86Ljrui2suFCLNyZEsak33u0MC42Y2AFVhrx3omw02XxHvlWz4OgSb5/C3sGqV6bob2x+GZ06i8PbPcRto0dC2PF5DC4JmiRejNbG6NdOMQ1mpCuT8K7NuqiwFN7kWzHkBFcSlVgy1KJESuVSFtiJzYQo6uCEthim4pRsfDRnw+jf0yFGkmPbo2c/eIQjQTulwCA1oa4G4VU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23FFnN7ktJaDm0vEP9anhoBVmqRIhiiv4cNlFinirqnXcnNu/YvhlgPDWUDB?=
 =?us-ascii?Q?dlu4lB3bfX40gQ1vQpOlQ1p4wOUAXdfgvj8cRSuZUFFItW+eBsL1YfJ//7NB?=
 =?us-ascii?Q?v3ZBeiyfCBhNxWBhbv4FlGZ4ftjZEFRaXkvETKMzSfEuTJbvrJ3/Bwnat5H2?=
 =?us-ascii?Q?vK/WDzo2nklygQL1KSip8GU7/g4FOIrEVzvuyKZyFMmhospV5fkMhZEJcsJp?=
 =?us-ascii?Q?t5fQqTPP1kawOaoLZKvoZRQULmJHgPoWMiBVzeaio4KEacCE7pB3lFahwexc?=
 =?us-ascii?Q?L5nE51ROm0hVMIz4ayKjlk2W4AjiRBXVZ2na4FfYyTUJ6p0hWW3G+syZZeBG?=
 =?us-ascii?Q?rsp5YTIA0z4g8jypycG9C4YkLfEx64Sra5gjssc7+T2j2+fOpbdoJNAF8Zjp?=
 =?us-ascii?Q?DZx1BUY18cox3SEwqx81HGy1gcVW7+ydat1R4wZBLbAw2gjS4iI0kdpOacPC?=
 =?us-ascii?Q?29afo7UXGFddtik6m9WnRxP0va5M5WWCVJou5eQ0F9riLC4iNl8Og7bbpxGf?=
 =?us-ascii?Q?5+8b7S+EjfLGsd8Fk6m/eMhWrPNQzrOkhydzoY8VE7+zgt4/MjlfPd6BePQC?=
 =?us-ascii?Q?3w8eThZsgwhD3Vfx3qmxSRubiwIQPBVILHWeKSOkdaaAHQ4q2FrWfHxfX21G?=
 =?us-ascii?Q?rM3B07xNR9heFiBP83X+5LqM2DNltO9UQUDToCrhuZIz+8QU8LMw6szDjT3R?=
 =?us-ascii?Q?vVBxL1U/Vg6CkDA6FFHS0GC9opjzC98ixI+R3LmXbo53lAc1WTndNZIs0oZQ?=
 =?us-ascii?Q?BouFiOXH7hlFlzL0P63KSIa2FKVzfNgKEvlaEXjZ+nmH/q5g5c02HXbF0hR0?=
 =?us-ascii?Q?iYkgm1zIwZoSEHL7bRsLPMGWm7PRM+D3oNkhyVYXluR7IsBzcVNHaWFafVrX?=
 =?us-ascii?Q?wo5Ia5XbZPOeG1eF86mj4+AojW9QNPEfNvR+NofxRJn+X+h7tQSxDn0+um5C?=
 =?us-ascii?Q?OjcYgAI9zxVZnN2yynOcPDTSoKJGVlT/edrh2vWvgsV7+TUm2grcNruZubDn?=
 =?us-ascii?Q?FnxHz6hFwuLzgINF4OWE/CryJWjwBJWWTEsV/DNhYni9vBckBgQxC+6Nbdgr?=
 =?us-ascii?Q?SoIj5jE1gc6Sw2U+DL5B4asa2fClbsHxAmsFsM4pC32NW/eOQuK+HCRw3AcH?=
 =?us-ascii?Q?d+HaXJxHr2dpI/Kxd00jGdhN2KekKRd5KRV3AtvlWG/qMlVq7ZwzeMQhhXrn?=
 =?us-ascii?Q?jQ9MABv7BGdY4u8/M1FM2kkt0M/nHfqxW7BL/TvGR5+B3wpCV4WO0klI73Dz?=
 =?us-ascii?Q?fxeVoYX7nV8XWkxd3IV+T6tSlbnjGA4cQRX5xxfq7WzlFoUrP/2EbxKkYtOQ?=
 =?us-ascii?Q?8K/tZ27fpvY/zWuDjWeqHrDqvnvJxG4waKornQrR3o3cEMIcSg5dhVXVWwFP?=
 =?us-ascii?Q?uafICO4r2x2GZhE5Ys7PBOp4IBBks4Vj8uSofx6hEkYic7BYPC3VIIjFdOld?=
 =?us-ascii?Q?lqXyRyxnz/VBHaVCTjWlO+RdBABfls90PujMYHDsc5FZ01t+qkUbifsAukfS?=
 =?us-ascii?Q?SjFcOQSk1xF2DIImXSeGZWykvM9DsisVn0PmPvY41ICCNPuwhGJtKCJvW1q9?=
 =?us-ascii?Q?nC4MmRYru5pyEdG5LLBt3b4IledMehSb1nIPW79bFyeLd2B+eo8wTI86LaZC?=
 =?us-ascii?Q?FXbq7psKMl7q3m8gtmH4dezp8RUTbT1pqQXcssRzV3BfH20p+B+SwZi/AzWk?=
 =?us-ascii?Q?U4ZTy+BCHPP1OjugrrnkIGLIR/AgR97LYoOcYFRyDXGX92+9veeuse9z/uuM?=
 =?us-ascii?Q?YER5FDtMIxkY5TxP7qZnfAThu/niAHs=3D?=
X-Exchange-RoutingPolicyChecked:
	hwbfZqdp7CKAx3ULlig7PhDObcTDc437ESoo1DrhczJtyuupdCrxfHfmrpzHPopoupc417icrmS80JM2CCb6DHiARVyXiN+vl1RINzL5pEPlESWMQMZg5/2qzKOXhJVNy/fQJ0gOKiSxHhHD0BTLoCsE445edjIivUs2VvoPY+vZyRKpl2aJWM/dewWwhYMjXjulcMlYXoGgpC0GFxb4yMqob10Jm4uIHQmeifw80Hn+1ctX6l8VAofCascEBJSa/6ntgxMJx4725WDOfw8bUsfrOzC9AYLAt+AZyWYaBzFqG7FBH2z+GKKNrBlmcOD+ewyzHnDiC6UsiHLnk7rcCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WHTLotmk/OnP6xPFYe7fxm61/ALjWT7W+h5GzH++uSoZ2kEvUvDJyM568svib6aifL8+NX8kj8jF0G/C5e8IPZ60OEjt2WL7tLXQgNBFc6/ylkFUcSsNkIa/68256xqgHkSrKPL9yMMU9m6lppbR8+sHu6vbX35AavCjODYf3mNVsR72vIdHvveA29zzObmSzFunDKxz+RVQ4JVspcxvjVV95J7QGV8JY+kmmHinDJAjQ6AYTPJ/yZHDeCZirYp3pUqvPkPOzbmgQHv21rvQ39fcNajUoiVvkGOqDeAz1C9x4TKX6TU1LTP3B8FUzclmiHUGKi9GhSgfzPVYRlLxEVSqsy7ISPCkqI1+OeqxTz1ogA976stc9EGZfKXq8C+sdEJFhq6SaK6krW+kgbXlt87FwVLCG3ME8lsroTABI4ciB7lnOCLxT7afJBPfBHz6mtG3rCg7Ljyy9ipNT0cIgg8xtlgeFPeF6wT+pyKhXuVZmBAHVfM9u/TqPQGSBbnFy2NqG+kFQL8+0VOhVCRAP3hoKBQyVmGX/+MLCsuwZs6lrKYsr5xB7gaiAeWhDXYvTnaC8m2QMNRYgGMdKU0RSRU0Qj7CH3QruyPPb9AGnSIEY16Uxn7wb77hC8VXnaM1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a6693b-3554-4277-cb35-08dedb0a20f2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:56:08.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vwSGtfsu0rtwlG41nBx6HM2FslVoNf+dUFHbfAtQnl7AH48eU3/95B0D1AmYhRlGbewCX+ZEyNqfftxmXUOJT9mn1zIlTsDsGbOxIL7dVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8246

On Jun 30, 2026 / 13:37, Christoph Hellwig wrote:
> Test the basic block layer error injection functionality.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, I applied this patch.
