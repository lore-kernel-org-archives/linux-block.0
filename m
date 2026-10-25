Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792931031;
	b=cMOccQ+GCyLLN9GncRHGJgr9zn3Cg7HkNGDp8F38BkGdyzDAT3iXwOaqQJdSg45lp9bZ
	 gL9Ride0H3XVlwZLZ83guuRn4D9Y1FF/RtJT9aZlbNQr+0/6KZyW/bVQ9pJcPdQWdjOtD
	 0aiXNilQm5vjl2Smzhq5f5lG9TzsWPs8UKVtnrj6kfvmEja/TBNbRZ/IXnC1WgcTF8YCZ
	 2C8a0gPrmpDjD/wnJaJatBN4AZhQ444SdR2ijRlyZoQjR5lPo4fVw2/DXvJRtn2xcXLqa
	 kiLqwktG5ziKibdJFhyXPFerz1ynLphanMSSGyGWM6abFLHofg/N5X4aH8fxHqcre9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931031;
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
	bh=+uU8vtJQ5rq6A8R6gzcSLjCPn5AfGS7UwCHYZ5t7l34=;
	b=iRiUy8hvJQ2VIDilFyXOJzt80Lzux5zNvrHgroN50rlmXyhTp6OyNNb4Ug/Yt5Mi0lgg
	 ozj8HffAFhxVX1C3SaQIoMQd6UmD32Oij9kdJjpMpajORsGxewOynCipCl4eOtyUBJFOM
	 IJ97U7TUKQuCbu5ms5l7p6ej9+jn3QVqzAYyj73whobzLD0J0Qo2kjMffdn7SaouIM2eY
	 nEIZFCcnneeIFRSEBFFhhnvG6VoiP8Z+zz2Lw84IQyhf0eQHhPyaSR2GWdOM/ZnIVlyKg
	 f0CL2j1/0jeW4Q5RXtElVoZWEm1vho1QsOVfZinDh4+1h8c6Gdvs1RP7/M4sIG5OSeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Z1yGRZ0W;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="Z8wgz/gG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F29606A31F;
	Sun, 25 Oct 2026 12:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F29606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Z1yGRZ0W;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Z8wgz/gG
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792931030; x=1824467030;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v0JQQ7ldpnWjTf++UGKCcVScSaR2N+K+6KsVUiEln/8=;
  b=Z1yGRZ0WOUYJvNsIrrxHD9UEcQI1t3Jlzqvyb0BP7c7s4NJ+ge+geVsm
   fJcO4ZLvdZw7vhhWXINVXVP7oR6Ntxrq96k3EGzNOXyP5kaPQKBBH+OMP
   +H6DgTEVotBNNGCjfb9qTv1iAOo7TmMC+iWyfFPTrY4B9Hbnm4xRCeDtB
   jhdfIZ1oIn6+KtIMPEgCQrhzBksRBnRmKKJtBUgd2sBBq40x2rWRH6JMd
   NY6vgLG8kbnoeFuZpJZ/JkSp01ykNjNehMd577ht4WK0ldifCuU/QUYzI
   b69cF8RBLzsQftlIrRBh5iTDYd0eFRqUVIlkO8pVmYiSrdGtpkylrliLm
   w==;
X-CSE-ConnectionGUID: aIl6+Bq1Sd2pxAWpmAkLbw==
X-CSE-MsgGUID: OeNAAvgtS/26o4fCWyXOiA==
X-IronPort-AV: E=Sophos;i="6.27,177,1786982400"; 
   d="scan'208";a="157338542"
Received: from mail-westus2azon11010021.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2026 20:23:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA88RMv/POGrFxmmxr/YpRWUggIvqUwOwoql/4EzxvfeCR9bvuNTVE9JHY4h4vqzagG4spz35nE7kOGpvBWsu31Lffr6pNtAZOwfnuC2Ze6DX2e++ECXY7V80tKdr4LIAbSY3gv2s8k4ojeOjlbb5FS16ffRLfGSCtRwptevMo89HjqviSujzBluFFn3F9NBRKtoo+fd+ewA6NrILQpZqJsRnNiYhzDx2F8LaTQkMdOH1qYjoMaBEGjA1fLjezn10/Y27+vrAaawPMEbK2WSJ4Q1Tx0lI+Q5Tmo2psjgZwuDP3E/7Dbcnm6xX2ga8OSOfijzQIWBio+bHSeug0zMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uU8vtJQ5rq6A8R6gzcSLjCPn5AfGS7UwCHYZ5t7l34=;
 b=BkgZy+GQVBNiHvGtVbmdoiZ+gs7Z5Bi42ETmNh/oYpqopVPp11qHW4DQSP3y+iEgvcTU4g/efBAMHjhZzh4LSH1Nfkx7onDTXiUHWTCS1U+zm6/fG4xP/uAu3ANBng/8UpLo7ZY14xywfebE6tRdyhXKj501xAhratzn65tUsH1MLputXdyzvV8/6c5lY9vpeQRnLEMDajZpLg56wXK9a8MGfFZ3XsgsLVEfqQX1J8IGwR9CRvyCIMFpK0X8dTzBczw32NMmJp7+TtSlRQUT55Jxfdgl7hAR0qsVz8qPMqRy6kkt4eKVElqb32QN+4AiTJWayiKTT7LY8bJRIRyP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uU8vtJQ5rq6A8R6gzcSLjCPn5AfGS7UwCHYZ5t7l34=;
 b=Z8wgz/gGyOF0baszCbFfRlf4YJh1M+RI9TD6iyRBuAi+YDCPBOOcIy30/XIon4THYQm33zrPRj/1VAHyki8nC2gftfhtcu/+PldGQ9u3KJf0mDRxAdOnnUFkxWN2JmSt6J6g9o/J/wVnmk9mGgxw7e41dgDC0WA7Dpb2xsFcE4E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB8256.namprd04.prod.outlook.com
 (2603:10b6:806:1f0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Sun, 25 Oct
 2026 12:23:41 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 12:23:41 +0000
Date: Sun, 25 Oct 2026 21:23:23 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>, 
	Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fygo.io>, 
	Reindl Harald <h.reindl@thelounge.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: only serialize elevator switches of the same queue
Message-ID: <at3xNpJLZ1PeGKUA@shinmob>
References: <20261023201704.20577-1-laveeshb@laveeshbansal.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023201704.20577-1-laveeshb@laveeshbansal.com>
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: cce48d01-3862-4756-71ed-08df3292cdc9
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|376014|22082099003|261021135927099003|56012099006|261009223027099003|11063799006|10067099003|18002099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	MNUQ3BhfBFsXytPn7sGo0BOII0ENd0DZm059UBmbJcAY8X+MUHiSYftw2bJiJnforNNu64swAWozM4UhI5G0jM0G56qcxho6ukw0B6/xUP16gpVOq+9ZvS2smcLLNeDSS5bLqofAw3KbGCLnJDisWuNXg8w2/gANY+L8T6tL3s4VJwae7QbTnt8MZyo/OT+W8NVP8f6qzaulOHQZb4zYF/cp2b+zPC9z0GZDEZadcDwl3t3/MiWDOWDahf7ppHg1MpYhnEn/tFaKnZJrUwWqiHmpFIR1CTO9a9acaUokNa2cGsvV9Uv+CuP8TzIz3dtePt+ui0QYY1OnsmRCHlWFQ5MTA3/6vJZNLskF+p9KzG8bw8qJbcUb0tFUg0AxchaLE8auOtZUcQP0DQlPqgJGVTn9cEcgFMzZhCZJnzxjGutR1tp67l6dfdTPgwTsbONlaA8rfBQhUXSKkVy8DE1fp7PURYPV76rjJeO7M8e0JPY2z9z+Id7efK5oQjZ/c0KmkkqTwwa22JT0sYIGEVUUlsTK6UT+Nr8CF0SNZ0guy2iamE5Lx3iWA7WxMc6g11VADAUUxgor9SPURcRWLtvJObK09a5f9CfayALJwA4a82J4y5yH6diyhdC7biva18m0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(376014)(22082099003)(261021135927099003)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCSyYejADu2Cg8CPCg7ng6kNqpPG1+VVDuLw5ESD+BPuZhT+PU0+TxheV8Pt?=
 =?us-ascii?Q?epHJY9bHZ7e6By+2VlkIE6UYJsIgUEF08GAhWdqPQYD27O/ZcI2FJBq6m4PF?=
 =?us-ascii?Q?eMz50A1yqoXfZyJn0OLCBlvSSBqL6wpEpAa/YZQguXcqtUBJRlllMMYLo1FH?=
 =?us-ascii?Q?Vo/9mrFKbOMABcR/KHMQsFMbbx6946eiJ+LPYVpqCQ1uMA8RQxoMnaD82uj9?=
 =?us-ascii?Q?OVpLb4GGSXqAEVWoCBrH236suUe/gajZokanSMm2FYVmoXWvTs69OyLuLwg/?=
 =?us-ascii?Q?yhpH9g5s1S4M5j+G+o1+14STmnyzA2VTzYPiyj4fMQrgZlhAlVQleC5Voulg?=
 =?us-ascii?Q?h4CuwMFOQZbaPk3hOwKg/r3zpGXwqF59kEHBE+1Innm4H92q1DE8QHavp9/k?=
 =?us-ascii?Q?N81nyZi55/6hC/00t2HOLLZ1EEaxaDZGyLrwdPIBH8LO0ypGWXl8zhw3V3gT?=
 =?us-ascii?Q?ncBXR0+0px8vci/hx030QO8dtKwey6pcsTQtFiptQ2MM8Vm3SKIsFRBtjIDK?=
 =?us-ascii?Q?7+1lovtYG0WicKL42Nc4zxK+QfCgwS9SY/N6x3ApuLOnCwwOdhfYS+AuU6w9?=
 =?us-ascii?Q?KEN3ybxkiLCpHneGDLBUEkDZ+7AB3CnEpOSJEsynZsiFqo2CM09AyesHWxiG?=
 =?us-ascii?Q?OF+htPHCYy0otobVRUKJ4tJboTUQnMant/P6zdmigjuPQHRsEX9cPzEU0rTp?=
 =?us-ascii?Q?BgsFMNRcSzhpjQEFFwOnQ37p4ItDkN4LZDbRva6QcHtQEDNptkTFYfWNLcTk?=
 =?us-ascii?Q?3VNudTEggA7OxXOUjj1fzlUib6FDJRoCOhXww+py/V9PrUDmDT9+XJDSpBL2?=
 =?us-ascii?Q?68QYYjeHa+MwMzngvfFKfnkDTXgKQZ3HTn7Klr9j014ZPQ3uESI0GZIlKbJa?=
 =?us-ascii?Q?XZbADAGWcLZmJ+Bf2Kv+5pC/pjz9y5i+3jPex3gpMaXuExH7pTPPOpMifnZw?=
 =?us-ascii?Q?aaJ+hMlhjjNmQTt7j6PtpUeQL2YrEmo+2Mjt23SI7Ko9aEPRzh7fvdrf2WBE?=
 =?us-ascii?Q?/fVcldnQbKZtf3moZTm6JpAq489okNZJKRs1f3WbUOqZrjV3rAdLIsN8lg/B?=
 =?us-ascii?Q?baDRJDDSugE8I8ZiNlLVnP7EGk58/80L7HeeMltVMRMot8jWgWID0DTYWuMG?=
 =?us-ascii?Q?Z2kBxytbKC2FQ5fRGyny4wZaIOoR64sA4AjAVoW6najhWJsSviUmE0oun/P6?=
 =?us-ascii?Q?qH7bH4oXrvtTpnQg5POElPKGeQdDomGihQxGSjPwX5Yc8awGIgkPn0gTokgk?=
 =?us-ascii?Q?JRakMFIEODRA5b+nVGorZjWTX0Mep60DonXHXnaG3ZmeIr99Yib3AJxIk9YT?=
 =?us-ascii?Q?BMbZlBzhXCzmW0KHRSN1PHCZlxVRkt5FnrOKH5Mb+IOym9B2bOEKWXROqEzZ?=
 =?us-ascii?Q?0F/b8hkW/ntEQTVN8hA4Vscb2yUl2jtJcyFB35JETRaE7vbcVsMUX2PFA6xj?=
 =?us-ascii?Q?PntBTO8ZllFw3Xtce/KuO/+wixkpzyjblOde2wXXjugKRQV/7tiPpiS2Fyir?=
 =?us-ascii?Q?AUl2L/D4xSlmXmR7wxvEn6ledeISf3t3HqZmkzr3NMOwiMtsDuO5CTmrlZy5?=
 =?us-ascii?Q?fC+NDZKZq8RkYUidkni5V2ZfbFq9hNRGWfrJR6E2tQ/za/lhb2pEfBvMSwVf?=
 =?us-ascii?Q?4WqvtwWXUfxP5rLWr9PC8ag1uttYH6uxR67sqMlcM1hhCJckcfWunEIy8uaA?=
 =?us-ascii?Q?Cde7RiB+Awyw8/QDFnQ6+IwQ9mJ+++r9yRY5TBDHN9LHb7pQnBTFJdXusByx?=
 =?us-ascii?Q?bvrndNqmuJxWxFrEPkV6cYp9i7Nzq2c=3D?=
X-Exchange-RoutingPolicyChecked:
	EfKB/UuUHmvzLQ/rl013vwK5n9gvqCB218rD7DBQ1f9VL/qyEW2Dt0SQSpsq73M935lEv8WwWxY7B0I2xVrGe30j9QbDHnyg1akKwSxpProvn1piBB4aUNbw5MJ4gDZ9L2oT7vqjsYmZt9DK7uXwMowJm2pbhkRKGGI4tLkUKe+m/pJxIMeZnkBVhW72TrLpFjuJU6zx4KpKNXt0b6r1cD88DUarUrk2ysDXNF7CvMC7V5BPIbe0rB3Am+CDwikq5LscVqHD3QhSS+0H604nc34Y5J/oAGPFCuREKGGrl6CapLcv3bMopcIXgBQ8CZQVpc6H46tK5z8OaCaF+2aLuw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wYBDqJThIuAG4SZKPeBQgIaJLdi6dxglTUIFu+pDatoEmcEuc8tgYDDSeCEbyVUd+JpgO6e3npyzWclVUDfjeyeW7JuLJdfZ0VemLy9RD64pBqBfMgUKtgAkJioE+Yr09bfUhpMutzUA9ccQz4LoITK5vObgIXutoRJvXuNo7SolOVApAjA5mx59S/B5FK9eigVEjRcFOM/JSNZrd0QxgbuuG9EVQiPbqrclv1lB6isUtto+KnDSj0sHcXnQZUqkofRdCA4ihnORpRjpiS4Ak1p5Im/BqwNZOdU6UvwMJOfcVdmGxg9y52MgqwowLpaXK0JtqonYbgsFhAIw1291F2LTGOb8ips2R7C6Onr2hhwGMY7OSgsmuTcybmMJLy+2QV3ghrCrcW6btU7EWJC5AOC8fQ6Dksqjam6O3sZv8vP67vISt213x0/fZEmv2p25WmgrJ9edfk9cbFOP8qLUAFuSDbx4Rlrk+q4ZGO4mTdmH0ZtW2AIpu61+tN5AoPEXdM0TUZjoXO9n29d/U5CMNdPrk9zVZJfVdEr2mlzTV3vOgZEVmt3QIYYny0BDDxH0NqiHN1XEYeDZAw+u1Qc1mag8cvbm7L8rIepZxsDatIZLhXlyB5L2tf0enpUTwhzk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce48d01-3862-4756-71ed-08df3292cdc9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 12:23:41.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kytO7JoeEh9Qtc0pIDiH/j9JpfCTW/HP08ResuW8DEeLSPGpCI6EmvM9hl9VKM+D7AeNOQs01ncaH/WTggBG/PJjtivai6Ub2P17cinj2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8256

On Oct 23, 2026 / 13:17, Laveesh Bansal wrote:
> Since commit 4ff58d6bc9dd ("block: serialize elevator changes for the
> same queue using a writer lock"), a write to queue/scheduler fails with
> -EBUSY whenever something else holds set->update_nr_hwq_lock. That
> commit takes the lock for write, and it has to be a trylock because of
> commit ce8ee8583ed8 ("block: use trylock to avoid lockdep circular
> dependency in sysfs").
> 
> The lock covers the whole tag set, so it is easy to hit. A scheduler
> write fails while another queue of the set is switching, or while a
> sibling disk of the same SCSI host or NVMe controller is added or
> removed. That is what breaks the udev rules that set the scheduler on
> 7.2.
> 
> Go back to taking the lock for read. The write lock was there to keep
> two switches of one queue from overlapping in elevator_change_done(),
> which touches the elevator sysfs and debugfs entries outside of
> q->elevator_lock, so use a new mutex for that instead. It is held across
> elevator_change(), and only the sysfs store takes it. The other callers
> of elevator_change() run before the queue is registered, after its sysfs
> files are gone, or with the lock held for write, so they cannot race
> with the store.
> 
> nr_hw_queues updates, nr_requests writes and disk removal still take the
> lock for write, so a scheduler write can still get -EBUSY while one of
> those holds or waits for it, as before 4ff58d6bc9dd.
> 
> Fixes: 4ff58d6bc9dd ("block: serialize elevator changes for the same queue using a writer lock")
> Cc: stable@vger.kernel.org # v7.2+
> Reported-by: Reindl Harald <h.reindl@thelounge.net>
> Closes: https://lore.kernel.org/r/077dd42e-cbc9-4c23-a5ef-3d20e4fc7757@thelounge.net
> Assisted-by: LLM
> Signed-off-by: Laveesh Bansal <laveeshb@laveeshbansal.com>

FYI, this patch looks similar as the RFC patch that I created before [*]. It
adds another mutex in similar manner as this patch.

[*] https://lore.kernel.org/linux-block/aiqaXfTqCLMu2DwF@fedora/

I ran whole blktests applying this patch on top of the kernel v7.3. I observed
no regression, then looks good from testing point of view. In case this patch
gets applied,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
