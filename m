Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BFB3AB466
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785396465; cv=fail; b=Lms6AKi93geE9cD2gSk6nJhEgUvs85qMk8n+7WJCZ9IBiA68kgRo/DFa/PTTOH/PBAwo6w468VQdTftSrzm/JQ4FE8X05/G1cP6Y7xD9AWOHDZfEHqDXUvDu2f3l5RvPuYjMKTUj7tXCIkhPhZJ3N/vuepasZjJLiUULd/JYY3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785396465; c=relaxed/simple;
	bh=MZt8C13UcinykIQD1gg6SvJVlfWCntWOzVnjXtAU0XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pFqHUuLs5REK5KF4+UPdd7x4RBRR/t2ZpLPRlRVPLoQ29p4p0ILvkdXWw1Z031F+jyShNWnHDguQtRjSjip9xevBVi9Qk6TH89ScyzHSPPkB9cfIGY47aGfd4tFZkSl70k2Hm/rRzS+ZRL7+C83S3hSdVQs5vv5SM7q40eYmh3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e4UP6ENj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ac7/xF6l; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e4UP6ENj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ac7/xF6l"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785396464; x=1816932464;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MZt8C13UcinykIQD1gg6SvJVlfWCntWOzVnjXtAU0XY=;
  b=e4UP6ENjRdJl0vi1R+cStmFydbVOlrUKVjEwPU63Pk70qsPBQps/8ZP+
   tcyjLVCoxfrJuo8kqHkbIKZnRlryjxCzUkhT7QYUf47X4xRHO+D37MJXz
   6dn1H06qmWrmtGgVAiQEJ61lmyFYQTMzdhWFDpY0pIBoTVv3tHQkz5Mmr
   hEWKDmtCq5tjDwyxcsMAlmRMXaFVp5gYj3ZaV+2fhB6Xa8d8yLD60vdsM
   EyFgng7yTj72mnFCN+k88pabIvy+O1qgmgZaAoXJeHDxA9fySZiNPUQmp
   Rd9cR+OPgO5dAHeisA+XQwd12aK4LWQpeIdYuvWAA3qVmZqsmoOdTMm7Y
   A==;
X-CSE-ConnectionGUID: M8BshqV2Qf+1sRzy2FrB7g==
X-CSE-MsgGUID: NSRM8yaLQr+1tgvWdwOBMQ==
X-IronPort-AV: E=Sophos;i="6.25,194,1779120000"; 
   d="scan'208";a="152084985"
Received: from mail-westus3azon11010022.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.22])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2026 15:27:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8smPLgbewGiVKi7PXstRhJn1sq8YKWargLXVlU08ZM1pDAoAH5oP/CoA1VA8y1l7yA/dEB5ekGAZXzPHCCCwkwt/eTmWtjK3+eeO1EXgXZhXBlSAOntc9QI/MbU/IQU5FSJmWpqkXm+RC8udxhYfPpst+3riNy9iHZBDtICYTtzEqaZOBZFcoxoXKbXez9Pdckbi1DkH25+3xppq62ZEqntrORlUKd82s1aNqYC4x5EQmHMpewUMnCkT3ylmNQFfvguFtDArKfC3ISVKgV1iJwgvTu9zjkBg3gbPjg9R1b3ZwSTJxhyEE+5Te5wan5G1LNovhDP+FvqnvR/Ton9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klHt+K0QGiKXlE4Bs21VAgks19GLpMAuvU0v0RNisKE=;
 b=Y5tLBYVUp/q5AlqINwSwZonPsbbgRdl1zm4z/fZ6HXqD/Shh6KWp8TMD3s+Kr0xYtK7s5dbKwbQL8xTUAkMm/04clQ5424Sf3Xn4xGinm3oE2UBqPIsSv33JyTprzTw5jY+DU6GiP6bGuI3+yv0gSMzGkTKj2Eh4Fysjdfu2yATIssFMBgU3D+FfHIjxFv+T97EtUPY409d5l8VqHHpebntWbETYotswtv1ydSK8kAbPe3vkkFTJ4+Bu8PsluTpItqFHWKkprSbOAVroIgqc8PxVlJzsHVlSgeaesA4KhgwbqDbp9hyRJ8v9doyPvqbvinH8y895xW6f/Kn1YTd8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klHt+K0QGiKXlE4Bs21VAgks19GLpMAuvU0v0RNisKE=;
 b=ac7/xF6leb3hIePe0PRmhhutb3gu+4VS3dyI4Vn2lF22HXl4WhTA3lD1BspcBFICVrLmr2VvHBkzXWiJHFgQv+e/nRCx66rqZ1dkav23c6t2r1Z6a0X4FoIl2L8p/xZzB+1IVINzUqqjEO0dZjn3jm3J1BhFt4SEPpbEEXvi5ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by MN2PR04MB6672.namprd04.prod.outlook.com
 (2603:10b6:208:1e5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 30 Jul
 2026 07:27:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 07:27:41 +0000
Date: Thu, 30 Jul 2026 16:27:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] zloop: zero out only the unread tail of short reads
Message-ID: <amr8tz3Bgh5lQr3H@shinmob>
References: <20260730055832.1826093-1-shinichiro.kawasaki@wdc.com>
 <4f18395a-7ff1-4a9a-8aef-4790d0cd8944@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f18395a-7ff1-4a9a-8aef-4790d0cd8944@kernel.org>
X-ClientProxiedBy: TY4P286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::17) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|MN2PR04MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c331ca-1b0b-455f-fc1b-08deee0c0a49
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|18002099003|11063799006|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sy4iP9y4UGUaX7aPgPwIEYU3v8XVFykbnX/L23EFpRrX1JqQxEVWkm0wNdYl2cBSB5oPZDSUelMq8Qi1aTWRyMcezo5Dv9SVSMhxiBHxhoW8er3lDVoKXBmcYZvuk79zTBxDviZdnPVT/LVZQx/LHUr6BqfjofLvazKyTQZPqV64fNb+mcOVdTovmZ0a51xFDDRMa2xJ810CdvUxih6HvK7J6MzxFuToqm1HNrDa06RtmasnhpgsfOlcaRNNC3T5SnGQSaj9QkjXV0fiW8SLSnAqRQ0SKZvDuCL19S7FeRyvXCnKMDdGCC+q45NWs312BAEVUpcwWQIyV9lYfTaB5SEkK7G1ex+kp8ER+nsPy3nilcknIC+XKdV7VPM6b3AxgrvjfTNNvt9jxSOoVi57fhjpkRGUY5ewtneQWuHCJ38aoJtFnqEI+ZUNysDfkzQsfUw3UbIvuINWXSbHa80lLulKs8EtYkjSKL/JsTfpffbZZC2ctI+8hxWfTzX8Dkwm/Bo2rUY0y9LaFCOkkvaGaSagYMEUIXhNKIFm5Zqr3nSe3QUhOamTM+NChjvp4PhIdP7eXd/dgIhZ777gTRx+iX6TzgHuFn6fKE5wok0CA9xWcQnNII7mUfWU7jP1twkoWgd/b1JOfggMtTd0oQ1jSGekSBh0JnUWRq8Jrts9SN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(11063799006)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UEefC9qC9rceU79Qbwl3ve7gUNxdjkPhTBH82otENpJL1kf2ywI5fiQYxKi?=
 =?us-ascii?Q?ZlI7C7SzolcZqHo+b+TBKucZrRD8PLGFIRgD9X/KmEGDmIlX+5uV+9liC0I0?=
 =?us-ascii?Q?wAu4zd/kkCpNltFl0PxCpTyWj4JecJae0Lj+pZNhVhny1AppWMLYNgEj+grl?=
 =?us-ascii?Q?7uK5A8TVDTRB7jOMSJaxWEOzcFCJG0m3o7MotEIXMULxRPzo9SeHSJuK1bZt?=
 =?us-ascii?Q?/xPJc/1GOa85EoHoZ+tHWprvWAdLaxV/I2Z01eIntfcCIKzD+NTBTbudqyCU?=
 =?us-ascii?Q?oxF3WM80FG/ay8wOcGSRgNMEHQqa3KmQ27NLAif0oZeSYtRJVAkvskgTqyQP?=
 =?us-ascii?Q?2QcPo5EkuHIoQN8a2DCWSTT/bQhv9BN5qM6P5kvvBIP1/fDGXGXpCIgnrWEV?=
 =?us-ascii?Q?MEiPCG4AThdGz3zITCDgf5kVmb2VP2bv+hEKeZAhyLvgZg7TAfP7pST3p9NE?=
 =?us-ascii?Q?wywzoB+QvQVyqonD3GyM8MWJ66F2Ok3k9pzVMwJ83Np+T9eiYqoh51200YJT?=
 =?us-ascii?Q?tptgNls4o5Zy267WUGk9EbDOpDxmRUv8SXOzz7CMSt0WjMWxyFycM8eF5zVm?=
 =?us-ascii?Q?MVaoOuOsLgtQSLhng6oO2BMail3Kpppxj38a5naXYgpINHgqJniTCzCOBXrs?=
 =?us-ascii?Q?oUf14cyxihjvbKn+OCTi40tIFQsN5NJ0KzwY+2/w6wTFU6rDZq1vi8It/7ip?=
 =?us-ascii?Q?S95MOky56i8UVBKYs8o6/dhwqsqQVYk3rV902kPKAHtRxIks/n2NNfwRQyPN?=
 =?us-ascii?Q?ULwRy9wuY+9tSasQlN62Nf/yxQ6soOSCJLlAFMY49iTgqu3ANE7g748lSh6C?=
 =?us-ascii?Q?Tit/REPoWDa1wJyGT+QXnfuj8ePTYy61OLji2R3aSC4K5UaRRLmTgjiOoWkX?=
 =?us-ascii?Q?FBwg5yyFaBU86eL69RoFljOkRFMg7PSayy8O8dOrn1OrdTr82mrkZBphdMbj?=
 =?us-ascii?Q?hx8M2WgINfcRGAwoYLybp3oSRrDZ2xH9aDHzqcJ9KQh8McnkkFM5L5Jp4CO7?=
 =?us-ascii?Q?Jq/D6go8zBmIAfBi099fWGFaXKUTHeaYf10HueAx3YOu3CvdMJsJvYGbpZYl?=
 =?us-ascii?Q?k/7uAQfW4sDCzoeYWfLW/Y1K3vs854RTpLiNsCkl4qCSi1i1zsXCOz0VVaQy?=
 =?us-ascii?Q?/1bXXlBo6ufip9rHM5vRaD3wzeWrv/0ybL+T+DD41+qifD/5UrOl5iy5IDOh?=
 =?us-ascii?Q?bt3nFqhCsZ12/F2lYc4qWHo/FAtGJktb5PECucNper+8s29Vm06uAm0Ra8Uc?=
 =?us-ascii?Q?nnAlgZs/TAtFEOAPoPA+Wio5f4x645mxtqaMwRMlS+WbnDcGrYO65YeFYH3+?=
 =?us-ascii?Q?m/LellqoIE+WEU/abfQCN3r8ieBNU8kgXia5pHTHwIAAJKf8lFFBZrulTLET?=
 =?us-ascii?Q?VJNf3R888r63zGAhPiq2ebvrzHzWXfGNI0h+i/W2Qelhl2OLP9qZgVtyrESi?=
 =?us-ascii?Q?f1ihOF8NqMdX0TAMHHa/gjeD3ISR1HysKMYSrUgE6K7HFRWVbBn2JbZA/u+u?=
 =?us-ascii?Q?hOW+Z603gi+Thln2taRTM9l7u7ejuF/OdftmbCQ1hCA9p0TQCJGjqYYXoB3A?=
 =?us-ascii?Q?cFMqo/+L+HWPpl66UdHS1cbz3MFlfeJilF9nKwkDNvmFcb6ZlRYQD22RSAeE?=
 =?us-ascii?Q?FC4aAoKMs6wlWnlgKYWyzAdvmGNJwdAVnJO/Zb3d4X4HrgASqssUe3OpNh8+?=
 =?us-ascii?Q?Kvbext0gctsE6vNGKQTjvkh/42plp9IrqUcWIWqOJXK/tIKLCPeP2P0EvFGy?=
 =?us-ascii?Q?1go9Cliea0CxcGiKnCpN+oMqg/dJJY8=3D?=
X-Exchange-RoutingPolicyChecked:
	jTx294uUVIDgbPi4F5M0unxe3KUagLIBGXuTLSJ+s74RC32sy7PTAGC6DelN+T5JYNXTeZqtm/s8dQdkaYU7UvclSW9wB49RMNB0HmjrQ5xE347bjqn9v8kJwvqW2OUSN0a+XQp8H0j+BWEuZPQnp4ZlGR2yiIw0J2tT1X662JdOmGSXLEolC4p84EarwIj2LkOtdwZHOno/ypK8Ft1ObdmFXZibcSH+kJNtDYcMJ9pOlSXdyuV5L2rbDupw1dMF9XjMrhogZpclTpZHn0aSGInLjEwhq+sFkEpaVmLVOcfc0ro1x2TjdGaao43pphc0HLseSZ9ucaYO9BStBfys1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m/8gJwHtdBkXXJkUu5kQIY8sLfzyaqpJfFQ3LTNPMQjJs2/ivza6xPOekG1/gLHFMx4GYsDMABZ4Efj3qjVRvTnNQDIqVWksZO0r6BtWTjC8lEsXQhtRebBQ5L33cJNMs1gNw0A3W6C3fO6WnpxUEx+F7k0xStXJ61ZH6h0MjJN+zhHU9si3wLqmB7WAA9qvid6Gxaa6xqFHjZMfpj6dGYIEan03YLqR6GoI9daDFNwYzB/Q9WnECCMn7ihW0rIMG+IQzZB+XeaQZ3hGcW4rsMbRubO7ykvAeE1MZ07x2vBhl8FH7rzxwvvr6HbKZJ9EbEtjOMyR34Fv4FKK3E88d8PpY+UtfBg5Du8Ey3OlzS95lda93RAqnaGgwW1w2K6Xj8h2Me3yXuvaYagbNr4gUkJu3G7rajfart8GifnyvjoT6dsJJ08ApXPFEzQR/xOqgZ5ZmRuCEFqIUpSvJ/BM1EE+X8jJEgT8opihLvcCX1+5KBJ+9AKR7x+6GzBENfPLGlt4U4TjOE/dOl67IYM26Dq6hdN3uRIJ8JtfYtXpWT+IcpQbyMzEmCax4cZuXLBtX6RJflWt4TQ9qRGHhzVZ3ufeDZZjdUBzEUpfbV/DQA70lqlciC6qmWxnchKYuWpD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c331ca-1b0b-455f-fc1b-08deee0c0a49
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 07:27:41.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqW6gzxzBjEkpGHeQMa5lfC/SrI0zwazJO3EI7JVsDkUIdHLQbf7n8VtMwtsJIZ5OzdcYk8puEBWuOgLUvJ20syeBOTX+72zGUwQ4IqThu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6672

On Jul 30, 2026 / 15:07, Damien Le Moal wrote:
> On 2026/07/30 14:58, Shin'ichiro Kawasaki wrote:
...
> > diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
...
> > +	rq_for_each_segment(bv, rq, iter) {
> > +		end = pos + bv.bv_len;
> > +		if (end > zero_from) {
> > +			off = 0;
> > +			if (pos < zero_from)
> > +				off = zero_from - pos;
> 
> Maybe write this as:
> 
> 			if (pos < zero_from)
> 				off = zero_from - pos;
> 			else
> 				off = 0;
> 

Thanks, I reflected this change and posted v2.
