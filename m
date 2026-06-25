Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853003C278A
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371125; cv=fail; b=DJJJaOxljTGbqf+ykcLSjdk/7wCcjwSsI03RxkMtbomWpJ/sMdXQuM2joxs40WuzwYwDlno5HS7Z6gD95hkyhfuIzqwOoZ0qr6XsBmvC9Pr4Y00kzQwvvIDlYNESDGDZVhPUOFo5wfdbeGu9C8xgj/m1yfYNR0vWSvw3RFP2HXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371125; c=relaxed/simple;
	bh=MgO+AkSWv1CrpK6P9L4pjR4I/AbxqnBw9C+WYSYvy6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kgGWSUKtyzRV9XxL5lpZXh6rZs07TLJxPpMcPsYWl5I0+cggKOdsHMHQ5koBUCJAxMRoMsN1xTKdYKfWH/f+BFpkNZ/aiGadVve9ZtX3GZ7/SZrLF+pPKKG1SZ1ecb6MjeNL8kzFe1YbFI9InmVDGute8KIqPdBt/o44htiGWPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bMJO4o2a; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pISQNfGn; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bMJO4o2a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pISQNfGn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782371122; x=1813907122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MgO+AkSWv1CrpK6P9L4pjR4I/AbxqnBw9C+WYSYvy6M=;
  b=bMJO4o2aT/HFkshxM7muju9ZZYGdHi9ShoIw6r1THGK08qXErTyq5kIu
   v2rUZBXl9pphZRQQ2dLPBN/JHGbdzu0k1ycVTVXjtUjUpba6B5VM5yCoU
   UN6H3+lRAZSSNIrhH2OXsZPiDInQBuEtlyXYaT7GrLIlyGaHslbBbCiBD
   4IuPBNMdnnlseZbgDkHR/B5EexEd0D/0LtGQzKfIoIwgcR6Va84g4llN0
   AAYXKXcKzpk7wOumYYHotjF2VPaHPdKxHvhD20t+SGlCDg9NMH0wbEzoD
   36AsKuMsVLsZmiapOLsJ68NxojH1eZwDe9v2gLK7xY9xHF+yh6zH1bIW3
   g==;
X-CSE-ConnectionGUID: Jor+fu3IRZ+m958AeRa5fA==
X-CSE-MsgGUID: 513gip41SniwxbM3Dw+i/g==
X-IronPort-AV: E=Sophos;i="6.24,224,1774281600"; 
   d="scan'208";a="148283925"
Received: from mail-northcentralusazon11013027.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2026 15:05:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp4TH1oBV1thzafpqO5ydq7ghSdR8WQIoaiAMp+NVjj1X+DCeKO5R5Qx87dTrYM5rfV+1KAI4O9rhlZV1QI5LnX5dQ7ncW1hUVPFjtxpQJAGp9C8VGePavqPWlhaYTFk+VpmHGbOpZGnRcRvdb+yAoOm9hliPEZfgI5dpiR+8aH2I8PGcUcY+Rwgcerul+JDgvXEv7WH23ofPNhCSJnT/vi2hcpds0VC6NhDGmFvqbh/AWGwdxJiPZ3tCcMblMOimpYm/0s8K4TL43uK8S4mt1h/webJ2AKXhrYgsHGA/XiNAHHcFHW8qFdQTsfLsSRXDCRPbGvY67MlZF9sPXCKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHN7/P+Rj+gmw28HgV+5PfTAf4xsAjp8C+vs4psyd0I=;
 b=cpQ1c7Mr5DVI58YRX5zPFNIvKzL9cE70K+fQ8aE7BFMshrQd6msGxR3f4OzOdFw+4sCW/9wp8yIKMzPO5D7KnR/hHEyMfYUXTZKq/yWQylImJkufxT54JfOJUp12a+diVOW4x7jSDF49MGZ5ZWs4gnbaPgnTSfPyHVaJdJr19jzZaaSbuBJ9ylvEfrRqLPQdLRIcx/jE0nwuMybKgoqh1ouvhZmVxmQIyz4ggJROigRl+GS+FGdkXqznNgrGZC1DY4S5KFajsLuDdAJH2LZFmkQRWwbFfxxFPEI/1zR+89Fxfss5J/tZG7edCOFblVXy/QZ9O4ZLknL9TV5WaL2Enw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHN7/P+Rj+gmw28HgV+5PfTAf4xsAjp8C+vs4psyd0I=;
 b=pISQNfGnuYM//JwgmmiJj+fW/DKfjWpUDligCHtRdjfWMr0eKEJO82CmJSBi8vH3eFBvy+tSemowlT59vF5G8f7YC0sORYPMTcWkn+rcUWS7kcdGXfJRDF1nEZbh8qImDspKxk497AwGRfUANwcZrLKW5azojg3U4lbdJgQeaYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB10218.namprd04.prod.outlook.com
 (2603:10b6:510:119::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 07:05:07 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 07:05:07 +0000
Date: Thu, 25 Jun 2026 16:05:02 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] block: serialize elevator changes for the same queue
 using a writer lock
Message-ID: <ajzSWeaR9K-aF5Zm@shinmob>
References: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
 <ajvz98mmlJEaTNxd@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvz98mmlJEaTNxd@fedora>
X-ClientProxiedBy: TY4P286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::13) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: a16ce89f-44d5-472c-c7a1-08ded28816f8
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	QLBdlFX4/O1R8b8KlzGTbm06Q2G+0Qmn5M5iizS0bgBfkPElhIGbFoQIA2vpufTICmJ69jZunLCifJ8NAQw3kuA0Fgw/cTeo3TF6Xm6trnWbFNzMJKGzP6bMIGdXhX8c/6nlQ3OcGXUb3DvEjX/59JHvPN0ExUF5lxGPLoOf7H/9D1+wU2T76K7BmncwiNUekf4xcD82GaF7Uu/HwUJGcwF8NPeR5O5hk+NREmmXvG81q9NtXPrpGz/fPk6xa3lHrZqjeCOmHLUsaGfs48GdAyV+rYlBVsg0ndgBG9xKLR+K7k/lU0iEAZpXEWNkaNbBYg4DiM/UaArSizm9pwchCmoHiZWJp93H9li7YMx9gdyspaBtILZwWSlKlXfHLg/t4Jp5Vbb2/nI7DHOuytfSBKs6qeNReE/2+rGQ3dnc69i1rQDG5Z8lGww/2by7Qp2mMXOmw8zWekW1wftikggUUof3V2VHXel511+dzth+1jtQbTXxafhTvl1QMS1BwWUVLs/CN8YKFLdcnandNwZvWmJn2Y9uYk8maPRIg/C3FcLZg+uXvzKQVqcxGa9kSpr/lygnTMluTmanatQeOqIeGgXtUIAV1aoHJP3Oo4C4+ckMeSHCt2IacI+FzN17KghPv05cFXCNsEw6xk80NXyiyQ4dvB+RiWDAxH+gV4OVhRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VzjHLe14OjVAdc8IGyXFQjfYXHo/9kYK0xSI7auv+nQrnzwcN5qd8vqEtSb?=
 =?us-ascii?Q?b9rBdJ/+DhuS5ig4cVnNSUCZf4WFAjPL+0rxU07y2XCTX4zm47jGtUwpfHUg?=
 =?us-ascii?Q?7YXHhaB47vQ9x/LyjWWQ9Ic8CA41ES5KSlMkMJK00QXp3ltKp4A13bXeALhC?=
 =?us-ascii?Q?tBXKtMGotMgufWi6VXz8JJW5Pj8Bkx93TSR6S9YGE3oBR8hM6+pv+g2ptl+o?=
 =?us-ascii?Q?bRqfjR7drYXsYSQWAHiyWdY64akp4EE5tZqaKS5pHV0syF7s9X9RbkExH2qp?=
 =?us-ascii?Q?+pHi/BlfhUN9IOjGkOlxeqTSHsrlHj9rmcMq9bBLMSOZmqvOqcgQ6LkD/Z49?=
 =?us-ascii?Q?2u4UUdekQs3Ey/VoLqFw2ppugICOP5OENLoANgYQcOq+ucZBLDHcdHmI3H7G?=
 =?us-ascii?Q?1d54RxMM7VRhhCh+EPaA3hS9gCs2qMeIgkchfFTw/cCay+suSSJypuEGUjNx?=
 =?us-ascii?Q?gxClznfjnwX+vXMTdvs7eh6yMIQB4rPJuloZPziELyTvFBiT9a3l9FoaAa6M?=
 =?us-ascii?Q?nsYP0eqPgUrIxhbxMmz5DJ7rOGa2TCzroXYYJIHeUIfSuBmABHlaMLeUxVIC?=
 =?us-ascii?Q?H9N5L9VJDO6KuzPLKfMB2JGHPDJsMaZlHHYh4SdyYuGb0pxs7dy8Ccz62sZE?=
 =?us-ascii?Q?wAmeo5DIqVf7e8MZ4YJQ5lWrl5pWyo9nlFY5i7nrQmZ58CtttgJhw0Vh4QnB?=
 =?us-ascii?Q?QfGb7Cstk6EQcl396j+bqFLJGJThqJQteP0HSOOAGzK+GJysf8fPntyKnXRG?=
 =?us-ascii?Q?vQ/stESTxeP5B9C1TljrXB8IhMBefJawzA2NaHD51qBMp0ptiRwapIR5pXdZ?=
 =?us-ascii?Q?kYi3cCT7c0ZaodTD0Ujj/NjG/STgw2wcT+eAkHX4ilyc3xelZ39jNwmhpDhB?=
 =?us-ascii?Q?1MIsJpchQT8U93s0DAEC6cB5p/wkrGIAO2/O11htPTM5RhKPWEhDKCrO3lX8?=
 =?us-ascii?Q?My/7Y7AhyviXCB+U6GObVRiyinKA9EjYG32fqDKXQ7KWYtDUKD/uyUT90d4c?=
 =?us-ascii?Q?povubz1A5JPzPAjQKbGq5g9nHSLjyfKBJU35v0BiBebGl/spJau/2aBd26vV?=
 =?us-ascii?Q?sUlO0wlnnGXXiUETPoJkdxNPTj0OphaJCcOij73bBN6JEJvuEYWmIHI7DReV?=
 =?us-ascii?Q?1ygBXSTlxPrW1B2OKw8+jJAGdqxtLbFE4822UjHzRBPOSrnogJnvPgHxm6zF?=
 =?us-ascii?Q?kHez+B9Bc0qk0vyJpM8YaC+X2qZtOtY36+WP5PtZ6VqEYpMe32gW/JUR0Bvk?=
 =?us-ascii?Q?4as6gYHX9v1B1Gn2OqHnOZXKBo8i65K7kU8o2hgq2O8Af3+q/9ARyZjjGnpf?=
 =?us-ascii?Q?7tvC5TGWtfRg185r2cbK9tKVIsMgnsOjwDM1WU5slbrIKgT7nhtm3nzlLnI/?=
 =?us-ascii?Q?GcNaC3WJasucCbQKni16uEkI7R8gFbpcmfYmYjFubLN9m5ybVIEsJ4+mdL9X?=
 =?us-ascii?Q?2CN+VMjQ7BbZnIIwaCvoRUTitb7+IxQZOCauAHqj1TzyA17Fjb3Km7u8LcvD?=
 =?us-ascii?Q?Qxq8Y5SrHp2wVv/Gs+/Ec2KA9VuYqyPnWrov/RFFD2D6IfiGfMrqN/0qxkjK?=
 =?us-ascii?Q?CUqALS6ITCtc3EUrP4/Xa7M2PjOUgmkuQcfH888yyxkjWDqNIO1PJcsrPl1v?=
 =?us-ascii?Q?EYEwE4eoA61we4jnNOCkpWjQl6iPxe/fRzU1ozFhweWzXB/M5gWRnRy2LuyY?=
 =?us-ascii?Q?0K2j6ypCCQULtVaNQ+r0kCCz0qGGW5b765NZ77EaKgwdiBLPI6owNL0UsU2U?=
 =?us-ascii?Q?Z76pWLt8MUTMdP2AjNYzJRadx7NkV1A=3D?=
X-Exchange-RoutingPolicyChecked:
	VbI9n+oU09Hr2/r/1O/LsKIlxfFJUIkts0rQXaFEWoF5sdw9oNwgH8/Hkd1F/hN9kQD9oT7JAJ177VUUaA/QuzaLAAQFj9LzAbZjnr35wn4NCp43vFtNgxcYE5aEX130Nu6TLkRfqhvRGxlzGmKIEBn1MTOIly9fr+8xO9I2B/sfFf8TaNpQr1J+6PGUaYZhMZxYToBmYUUqkoVV6M+tb7xypvbDbpIgDgCePkZf6nAH8bhKKE21I3Y65IuyKaAwBQxGzgnr3kRluc500n6wIgk87sGhkha09iN+IvG8vfW8SPCbf/oEC2Xkl6oFgnaGyCitno5lWOxkFFJIIR9yvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oLJlgb3hWTtCjIiiDZ8QL8r20G6yIM8TDCX5YlB/oaebZc2CshJQhdOO5VSjcViW1tNQSGIBFoZbzHPWZ9Ykh7/6i7GaJVyRpo3tNZaRGZbsUNwPsbfILeYzT1TJPzSpUaON/VmEdl7K6q+aQdksA8Zyp63Dx1/Er5FnMzsXrbh0pzURCADgWks2xSk0uqQ6DZF8yfs18NFSctE4NarGMlY8qSqGw+AalrGbjKhbUWd4WHozK2z8PeZlylqMpdRfeCtEaKtwXt75B1winWnmRICum0v0iTeTBker1uKEcC60olnQluAqgmjOrfvIp4j9YKJ5j3OwvCs73muXyubXRgJS0X3Az8wTTDzvU+kxX0Mu/mY1A9p4JQYxA96hV1RMKPC/tTM79gY/zG0Rjq1XU+sQ2oD2rpKvavDQ080jmOrsTnqUf6byEJsTUyJFWGOVeXkaK0BOG7iQMFoeSd0cBzIQ5idC2XwenHAhwitBPsXjAd2PGrXpavkPPpTmfIRbMYIy8n9cWvGNbzaexdYSRV9tF6QD+1aim1aoin/Q4zpN5ar4dEqHgqHGRJizYHkVXBjDLXx5k9+2nhqTX469c0xWQt7JxhTa6fHyN6g61Mta/xZZJax0z3eqI7v8Xf0t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16ce89f-44d5-472c-c7a1-08ded28816f8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:05:07.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3J4XQ/HjIlBJXpOYGLkc8in2+jHLNrLL5X2bC1iaKnnnw4tx6N/ZKmlQhO0N0+xnonRtipxhZiNh6k86CpQKK0rZcLV2EpXhWpUHsTjz+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB10218

On Jun 24, 2026 / 10:12, Ming Lei wrote:
> On Tue, Jun 23, 2026 at 10:32:38AM +0900, Shin'ichiro Kawasaki wrote:
> > When elevator_change() is called concurrently for the same queue, the
> > elevator_change_done() function runs concurrently as well. This function
> > adds or deletes kobjects for the debugfs entry of the queue. Then the
> > concurrent calls cause memory corruption of the kobjects and result in a
> > process hang. The core part of the elevator switch is protected by queue
> > freeze and q->elevator_lock. However, since the commit 559dc11143eb
> > ("block: move elv_register[unregister]_queue out of elevator_lock"), the
> > elevator_change_done() is not serialized. Hence the memory corruption
> > and the hang.
> > 
> > The failures are observed when udev-worker writes to a sysfs
> > queue/scheduler attribute file while the blktests test case block/005
> > writes to the same attribute file. The failure also can be recreated by
> > running two processes that write to the same queue/scheduler file
> > concurrently. The failure is observed since another commit 370ac285f23a
> > ("block: avoid cpu_hotplug_lock depedency on freeze_lock"). This commit
> > changed the behavior of queue freeze and it unveiled the failure.
> > 
> > Fix the failure by changing elv_iosched_store() to acquire
> > update_nr_hwq_lock as the writer lock instead of the reader lock. This
> > serializes the whole elevator switch steps, including the
> > elevator_change_done() call.
> > 
> > Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> > I observed that the blktests test case block/005 hung on a specific
> > server hardware using a specific HDD as a block device. During the test
> > case run, the kernel reported KASAN null-ptr-deref and slab-use-after-
> > free errors. The failure happened when a sysfs queue/scheduler attribute
> > file is written concurrently. I reported the failure and shared a
> > candidate fix patch as RFC [1]. Based on the comments and discussion on
> > the RFC patch, I propose this v2 patch that avoids introducing a new
> > lock. My thanks go to Ming and Nilay for the discussion.
> > 
> > Please refer to [1] for details of the failure. Also, I created a
> > blktests test case that recreates the hang [2], which I used to test the
> > fix.
> > 
> > * Changes from RFC v1
> > - Instead of adding a new mutex to struct request_queue, replace the
> >   reader lock on update_nr_hwq_lock with the writer lock in
> >   elv_iosched_store().
> > 
> > [1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinichiro.kawasaki@wdc.com/
> > [2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00eacd138d020de97fc6
> > 
> >  block/elevator.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/elevator.c b/block/elevator.c
> > index 3bcd37c2aa34..b03185a217ff 100644
> > --- a/block/elevator.c
> > +++ b/block/elevator.c
> > @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> >  	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
> >  	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
> >  	 */
> > -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
> > +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
> 
> I'd suggest to document why using write_trylock above, such as serializing
> 2-stage elevator switch, anyway this patch looks good as bug fix:
> 
> Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks for the comment. As to the suggested documentation, I think we can add
the block comment as follows. I will prepare the v3 patch tomorrow to fold-in
the comment.

diff --git a/block/elevator.c b/block/elevator.c
index b03185a217ff..2161b6eea680 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -812,6 +812,11 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * reference during concurrent disk deletion:
 	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
 	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
+	 *
+	 * Use the writer lock instead of the reader lock of update_nr_hwq_lock
+	 * to serialize the two-stage elevator switch steps in
+	 * elevator_change(): the core switch step under the elevator lock and
+	 * the elevator_change_done() step outside the elevator lock.
 	 */
 	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
 		ret = -EBUSY;
