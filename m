Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33D3C6AC;
	Sun, 30 Jun 2024 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719785495; cv=fail; b=gT/OU/fRsU1oUQJWkda0CHJ24Pixu3F8yWRwkyzGAYfDF3iultUgyOgL9Evw/iJBUW/46Dmsq0PN7R6M+ofHx0W5mBLdWJ+knMUY8yJV7Cwd9N3f56MWtue3VknJ/lIcro492Vdstqu0Kko7lDSfUWl5R0WFFTXiOhmyvIkAO0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719785495; c=relaxed/simple;
	bh=A7nBiAaLWOhEAb5rOezQmOAxlBn1CgGdNRatCcWjy7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+cIB7ovlRYD2PtoaSWyq9ZxtcjRf/4baNrcu6CzLIaSQTPI6cytpxgYCuTJHYzDLihgEzwZM993wFsWN9ew7jlCA2izSJLzvfnVoqQZTooVqtu1cDFsjp+M5qWimFKb/n9+/bo+JyA6kyePSdcMLOJjbAl/s7ucw1jCHhrc6vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WJyN2RB+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DWGCsVpS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJyN2RB+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DWGCsVpS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ULOEYS023834;
	Sun, 30 Jun 2024 22:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=2RjbH2+o1LU8fUt05PwgurSdssSfOFU2goHmQaxF7F0=; b=
	WJyN2RB+R/7CdSo7mUCNRyTNhYKJtyh7BGGk36cVsw5nLFsDJOK4rSvjBLZuVbFu
	9VRqCRuAk8PmLknYI9L0soi1jacLm5ALSNppKTvKDuPWizSBZGcbha29hY0pcoRX
	1DElaRkw1Es7CUDZBkdSkI524PnpXOmWl9STrYZwcCwhpVX8K1N/pUmWtfPcC9ov
	3b+Y1j1q5Tx8qR2MoKUnDgbO1UBLWEzPHFqOLJ+yR2DjdogEO17cgMe/MmlTLvXG
	xpmybw0f1melJL9TYvenVvK/ZVv1PerIWL5We5QiKis2LsUJxlfYzY0F4xh1l2Wg
	yG0HyNTbgPIPtUB8mXt2Mw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vshhfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 22:11:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45UGfT4w026293;
	Sun, 30 Jun 2024 22:11:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbt868-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 22:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW0CNMusCNa696C2z6k7n0Gl17geupQJnq7etgksmE0ISxBUH7ptDcgsTHDNB8xshh3A1rxrh4av0hA7ZOKeeJVNtZ3MGnbYzvbb7CFVVc2JF/NmQQ8SV3qi+Nm54LqBmch1I6oRroMupgj61qXXcXmVFvySqF2/vfY6pCmmrVP0aa8cfiwkLVdevbebBtutuuheNK4P4oalLSWvx3565pPvS1plt5ygz3oemxrz54fEi0+N/VZ4mDZ/WOtR0mDFdnHvhCyiUoZxSkYlZHXZCWo429R4oGSV3xJyDmoWEwev9VvCtRSk0kXQ7e65agtKkY6g2S1MeauiguhclQVjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RjbH2+o1LU8fUt05PwgurSdssSfOFU2goHmQaxF7F0=;
 b=oJkSCuebXTOrpuLpYPu+QlzOXZ9ynVwH28aJlCrGlA89U9rjrmQe8kxV1Xc7aIm9mhoFy/RjzcGHnN8Dzn/3s5ZeESKgjkf1nVHwM+M0wocBSoYAbI9m8McN4mlpySrxLrja+sBHNydJJpIb95exSJzCwbubcn7I+aGHiLlK7U1ZFEJfQTl8p/kJX96ETtvR99OmAjPfpHVEZDNsR4UA0hExM74bp+buylvE5PGxqKXz8oEMhfAH4KRSeu8tUm1H4Iet9rOzOt9113qXhVftuvVh0HCRmDLia2FPrXGJzHdC1FWtJfVT9XPEgfdgDAeiZBc8zuSFuj7KaIiAxn9b6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RjbH2+o1LU8fUt05PwgurSdssSfOFU2goHmQaxF7F0=;
 b=DWGCsVpSi90x0YyqDJJHvSRHs3ot7NHkh2JGu6qLKSt9H+YRRDBW4pdpxiJAxwOa3Ibg3Mj0i2fizp+MWgK4hgUwWtl4sbTv+S7uI6Zi8JdihmsX17dyIr0OuzlqqyZDpKiyV28V8frmo5lC3tI5p/aZZkg7oPsDiQDguzc9CZI=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 22:11:14 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 22:11:14 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHayR2JSOf+1W/UnkG1CxXEGa2wWbHg4dcw
Date: Sun, 30 Jun 2024 22:11:14 +0000
Message-ID: 
 <IA1PR10MB7240DE46976A3B027DE5484998D22@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <202406281350.b7298127-oliver.sang@intel.com>
In-Reply-To: <202406281350.b7298127-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|BN0PR10MB4951:EE_
x-ms-office365-filtering-correlation-id: 87484b65-1aff-44b7-e949-08dc99518eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?uGWdh+BMAdL3WoFuUAaiNinFZNLiHnZTHguzc7Idla/zt2EyuXhMQKDTpGux?=
 =?us-ascii?Q?Twm3wTVTEMBnbtR2dWIyV36hGpve/cyKZvfcI9amagXQs1IaGmY0D0t/FgpZ?=
 =?us-ascii?Q?+oA5vRmjXsBjia4BoU6DcoKRSA1D0/WCpTu/lkUfqFbr3QCWZ8T97XVgv8YC?=
 =?us-ascii?Q?IrUiqGgx5mJHsp3ai3jrznwysZU2NDi5E5oyQbvTco3AaNGBQL8D5L7SQ/ET?=
 =?us-ascii?Q?czH6TWg1gpI0V/kvkbI23Slr+t9JQlBBIel/Onnhg6W9a5Es4iRwJrRcsD+K?=
 =?us-ascii?Q?7E70UfNLER61qia40eSOXcquVTvWpGdw1nRZA6u0s448GtSLBr7FKFEGHZwx?=
 =?us-ascii?Q?TIKILKnSDN7li9IBukgt8YIsuApZET1dEHDHW+n+yyZzK83FCZi6sYheZ+dH?=
 =?us-ascii?Q?jW1lpuiF3BtEfzt8NvA5WmyDreRGHnMWEV1Q4ZEMV9g3tgAwSiykgN2504kV?=
 =?us-ascii?Q?CERVM4jDrDerilenX/Rq5Q4AgqVKhZ4T5bb8VJ74FEek+Z5evP0SBXyroUwc?=
 =?us-ascii?Q?STEbUnwY2idkM/e7JNjeH8MOFcF8SJyuUckoumtN5xOvAro9P9PGtA0bpKQ4?=
 =?us-ascii?Q?367XSMiIMJkzk/ATWLGJCEHi7TNU6fulyZogtUg1WJdjF2V7F1EeMja+P4TF?=
 =?us-ascii?Q?zBSzM5yJh9+LMdQsYiuixNPt3lRKKNmsNx05YCa1e8HWM7Rf3sBOqGiR7g+n?=
 =?us-ascii?Q?qYelSkA7vkJ01t3K1M+vezAzSdP0iWuL26/zBqfLsTAmww6bbkhwZRVGnCKH?=
 =?us-ascii?Q?pZuCe2S+S3uds9Fb6ydr31LUZOLPbW2fOOhOVVFqO4+InUVsHxdh8QhNN+F9?=
 =?us-ascii?Q?C58JC/Cd41YFQvb0DLHyTuuR0UAUSvQUFCmGDEy+aQKKbK9Wo5Yt21EvyyLG?=
 =?us-ascii?Q?/UoQQPiwslCI/kdjfv2MqIQJgm420oXqA/Eu7FUi7bjBsTsvl1MjnHjhkK4F?=
 =?us-ascii?Q?K0xGrSXBx+dzqAgY7bA0IdiTmZJy7wpWrnc3gTLtEl08LF1yez5v0YwWkbVZ?=
 =?us-ascii?Q?92x/COhCcsumUnt2bBod5FAmm1xy50GglUtAp8QMKbBjO0mqppXHpKS4D8/a?=
 =?us-ascii?Q?4eZX0jGzthoIkLD8cIrUYgH6J99t31Difxp8Hzfd16li9OXUTH8VmM2bt1BZ?=
 =?us-ascii?Q?7mQ3U78FD9mz31iqcd1Jr3Gyv+nmoRYAJcFGmPaGdXsJZvllERBDGh0krlS1?=
 =?us-ascii?Q?df3jXrHO3KiyjzJrsf/+sVbK7pDRgrQZbeEEt62rI5b+xUMQWBZERb+zj+nS?=
 =?us-ascii?Q?GNg6tWpr/8uSzqNsIHdjq/GzlMrTO7VWiTTY2pdkx0NlDEWN09HBnTuHIGAZ?=
 =?us-ascii?Q?JlvlbuR1ijJq0HlRYWTsK9rl7AJMWMGOQKqJauUKz1U0nMXIaJpOKxpfPo2B?=
 =?us-ascii?Q?NuuIvNM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ekf14rBqDVGoJn7+dnRjp0mbrIBqOSQSkKUe3yP6yQ0ZhsFMZkkDToLNVM59?=
 =?us-ascii?Q?/IeFRka5EcBlOg9YkI5gwy5lFUuQSsKhHrQfjENtozL2ZB1sJ8qMTSGieERX?=
 =?us-ascii?Q?5tH+zyXL8EuYLAtCnV7Iou6MLJN199e4jTwdww+8IQfKNJFYfFuKAIZUQGRv?=
 =?us-ascii?Q?scGNdh2aepn/86yG+aa9GKpGDroNrie5xaWLpxumLSx0C1ktnc6dHQNwLuL2?=
 =?us-ascii?Q?OT4/cNjg7q0hmornGDal8UioQbEnCQexCFTgp0q1SuXxMSQSuLfVW/j9jp6O?=
 =?us-ascii?Q?O5MJCFxHsa6fEZm6NPJQ28nE/PwYF7lhmOChA479FZdRw+0fE3iLgrnf/gWu?=
 =?us-ascii?Q?v3LmtsYfgnAuQ4daYncHZ5AXc5wRJuX57QOGk9rYFQNJhjNsufj/E5KBQPTh?=
 =?us-ascii?Q?uyOM2wUUjgFY26adqiDUR7TGSgke0/s30xDBUgjoqiH4hL24b4vJ8vvAxtqa?=
 =?us-ascii?Q?rsoHKx4+CcX+FmcHER3rRdheTsisrsWleXYEiv38LZXMIDCMpKTAxcdfubi7?=
 =?us-ascii?Q?ZwW/v8lszNRPF7zVoDikDv9X5tgO+6EAL8Jq9YY5lO3QSqYUgOaRCfeoHjbE?=
 =?us-ascii?Q?rMFuZdVNhcAiDya8JJg4IDnkTrEN4F5UkgDKee3Dp8lJpD/lhVFaoA9cZoop?=
 =?us-ascii?Q?rOWh9BSZjSLvZwPtA/YNOXB7HVTlYqADECm09m4lmT9bo2vKxG8h3QlpFFTL?=
 =?us-ascii?Q?aHcsbNe3Q+fcQuPfQzTgWJ1wjyINQQvAJRaRGoJuryyDPODf3+z97OBQOTE3?=
 =?us-ascii?Q?5fRDZCsGMxwr5hPmusDI7i3tdxYw0Cv3W66JJvdR4meg3XwEvniv7Oyx2U7f?=
 =?us-ascii?Q?8Y16vdGKciXbx7gNypM2Q4fagE+T6tk4VNcVlzV7h/0Wqf4m0x+G9yheXA3u?=
 =?us-ascii?Q?phBBHo6QeCBdbnWCao291m89vPAsjTU2cGmd1MZXphNoWXNqpUf8UWRzszow?=
 =?us-ascii?Q?iBzoHTllJeB2HWN/fLYLY2SszXvUllgWcGU/yO1mnDJU5krFa0PJE1A+HIEZ?=
 =?us-ascii?Q?Lxz3iDRBMhr18h62dkfwzmxjWmFyX+06MW82vjfIk3TJhgZfI0BZYAPKkuxm?=
 =?us-ascii?Q?a/wIlp6peXQvs4IcV13AiTMJYqFw3v4Y52v4wphMGkIcgrj1PX96VP4MhVU7?=
 =?us-ascii?Q?k71HR586AZVgllm8Uf3HmV7yxW4cpZ7+nmENUZY48MjxqBAiOTThydypT3Xn?=
 =?us-ascii?Q?6kv5DHwuFf+JE2uMpr94VcsUQPbRKQSukuLvzhRhiVWkpRNQfaxAl4lka5qU?=
 =?us-ascii?Q?noT8yOgywV1mAzjEr3NGuNlzoIfjXmoB6m3XjOX1S4nRsfNlnGoxNy579thS?=
 =?us-ascii?Q?e7MCrUEK8Gqg5QxRuzhS8q2FHCLHAE6EFP6FJAQMBRKYPk63PrzGL5nn48Tk?=
 =?us-ascii?Q?bvC1kZVHeGKqeELEDavTe/2mMEuazqbgjuUDjqN395uoDS1jW72G0lwnFADu?=
 =?us-ascii?Q?/v2q8lNcpdmJ9dpsV5qA0ZCMDUxC5LLI0m2ffdHIGO93OULAgwTQtkQgv4Aw?=
 =?us-ascii?Q?KB3PwAvyeXrPWYOsiqo6095X9wDn7BHn8Ezqer5xttY0ZqXLq/a0mxHM3IVA?=
 =?us-ascii?Q?qx90UYLCuJxOtuvaKo6KpY+C1S7fWDFqh6m10dXT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q/56XrkBiMmtpzQmW42SW1D5b9UDUqRLrrwig+he4th2q13Qd6hMFc+iSoDylSZEnOsepMoA7zQQwm+RLvof1CQjjkkL3K3sQ24tFdTkARc8kIQnLc9OrbEUrmkZuM29btb/LnRUrgAESoubBeOrz20R+g55PwJ4M80NjYrjr0dy3mfezUVV/ChtmXufa0nC92vGvlarOCmmkGWLxTDGr9kUBQlY7Eix4vvZMGjQKJxOOS7PN36mks0cCmkRXYm+j995MsPL4iERsK5lHAXwVhThvANhfPOuU0qq8fCiWSUswKxoTmIpFqpJnUoulJMW2nnnoqRZvr598tjliPNTZOB4bVohMZ5O6zqPVwP2M2ZJTPGg1MxKXfejaTrUw9j1dlmwZDU2W3FTrbjB2l4EPcaKcXcI27+ysrgSi1g0EcgtD3SzSDHSvDVk+eedVE+pKzcyrSW6SAA+cIvtCGjRbFXrssFzVjlnzZnA/yZFKLDWaHkrtQ4nNzqqULNo+q2k3PjABx6jOB+oa10n093M9tdrKQEOp3EdPRqnhjdP01uyQ4QQ4AIvzD6vIOYS77fA1AMKiqAJTMwq87++QkQ7ACzTMrO8GqVy+XKlC62bh1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87484b65-1aff-44b7-e949-08dc99518eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 22:11:14.4956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqYYq/fZ4Ubf2G0GtfVWChzyzsc0336vo2PHIzTDAt19UY7LmCs2vv1uW8OLO2D7E8Zwe1huq0NtcUJZVKeWsCt0INwNVnstuoaVcKZe+Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406300178
X-Proofpoint-GUID: H6xD19FSeZE6vgbYCozYJ7m7u5DHdTPE
X-Proofpoint-ORIG-GUID: H6xD19FSeZE6vgbYCozYJ7m7u5DHdTPE

Hi Christoph,

With our latest version of the patch V6, the "kernel robot test" failed in =
the ioctl_loop06 test (LTP tests) as in below mail.
The reason for the failure is, the deferring of the "detach" loop device to=
 release function. The test opens the loop device, sends LOOP_SET_BLOCK_SIZ=
E and LOOP_CONFIGURE commands and in between that, it will also detach the =
loop device. At the end of the test, while cleanup, it will close the loop =
device. As we deferred the detach to last close, the detach will be at the =
end only but before that we are setting the lo_state to Lo_rundown. This se=
tting of Lo_rundown we are doing in the beginning because, there was anothe=
r LTP test case failed earlier due to the same reason.

So, when the LOOP_CONFIGURE was sent, the loop device was still in Lo_rundo=
wn state (Lo_unbound will be set after detach in __loop_clr_fd()) due to wh=
ich kernel returned the EBUSY error causing the test to fail.

I have noticed that a good number of test cases are having a behaviour that=
 it will send different loop commands and in between the detach command als=
o, with only a single open. And close happens at the end. Due to this, I th=
ink a couple  of test cases needs to be modified.

Now, as per my understanding, we have two options here:

1. Continue with this kernel patch and modify few test cases to accommodate=
 this new kernel behaviour
2. Go back to using the lo_refcnt=20

The first option doesn't seem to be flexible as we need to modify a good nu=
mber of test cases.
Can you please correct if I am missing anything and suggest how to proceed?

Regards,
Gulam Mohamed.

> -----Original Message-----
> From: kernel test robot <oliver.sang@intel.com>
> Sent: Friday, June 28, 2024 11:09 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: oe-lkp@lists.linux.dev; lkp@intel.com; linux-block@vger.kernel.org;
> ltp@lists.linux.it; linux-kernel@vger.kernel.org; yukuai1@huaweicloud.com=
;
> hch@lst.de; axboe@kernel.dk; oliver.sang@intel.com
> Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "ltp.ioctl_loop06.fail" on:
>=20
> commit: a167a9996e22ae0d108307fbc66b811d821ffbe7 ("[PATCH V6 for-
> 6.11/block] loop: Fix a race between loop detach and loop open")
> url: https://urldefense.com/v3/__https://github.com/intel-lab-
> lkp/linux/commits/Gulam-Mohamed/loop-Fix-a-race-between-loop-detach-
> and-loop-open/20240619-
> 004334__;!!ACWV5N9M2RV99hQ!KYjjKXzy4egkNOv4NcO0tNoEVElMSquM5Riz
> BqquFexq6ScoztvIJUysVnUfltmEDSSy4LXCb1bKijp8xq-V_CM$
> base:
> https://urldefense.com/v3/__https://git.kernel.org/cgit/linux/kernel/git/=
axboe
> /linux-
> block.git__;!!ACWV5N9M2RV99hQ!KYjjKXzy4egkNOv4NcO0tNoEVElMSquM5Ri
> zBqquFexq6ScoztvIJUysVnUfltmEDSSy4LXCb1bKijp8JTiEzBw$  for-next patch
> link:
> https://urldefense.com/v3/__https://lore.kernel.org/all/20240618164042.34=
3
> 777-1-
> gulam.mohamed@oracle.com/__;!!ACWV5N9M2RV99hQ!KYjjKXzy4egkNOv4
> NcO0tNoEVElMSquM5RizBqquFexq6ScoztvIJUysVnUfltmEDSSy4LXCb1bKijp8v
> DJnm-A$
> patch subject: [PATCH V6 for-6.11/block] loop: Fix a race between loop de=
tach
> and loop open
>=20
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240615
> with following parameters:
>=20
> 	disk: 1HDD
> 	fs: f2fs
> 	test: syscalls-01/ioctl_loop06
>=20
>=20
>=20
> compiler: gcc-13
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz
> (Ivy Bridge) with 8G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes:
> | https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/20240628135
> | 0.b7298127-
> oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!KYjjKXzy4egkNOv4N
> |
> cO0tNoEVElMSquM5RizBqquFexq6ScoztvIJUysVnUfltmEDSSy4LXCb1bKijp8aKJi
> x68
> | $
>=20
>=20
>=20
> Running tests.......
> <<<test_start>>>
> tag=3Dioctl_loop06 stime=3D1719063458
> cmdline=3D"ioctl_loop06"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> tst_test.c:1734: TINFO: LTP version: 20240524-41-g248223546
> tst_test.c:1618: TINFO: Timeout per run is 0h 02m 30s
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
> ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
> ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
> ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
> ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg !=3D
> power_of_2
> ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
> ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size < 512
> ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUS=
Y (16)
> ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size >
> PAGE_SIZE
> ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUS=
Y (16)
> ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size !=3D
> power_of_2
> ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUS=
Y (16)
>=20
> Summary:
> passed   3
> failed   3
> broken   0
> skipped  0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> cutime=3D0 cstime=3D3
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20240524-41-g248223546
>=20
>=20
> ###############################################################
>=20
>             Done executing testcases.
>             LTP Version:  20240524-41-g248223546
>=20
> ###############################################################
>=20
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://urldefense.com/v3/__https://download.01.org/0day-
> ci/archive/20240628/202406281350.b7298127-
> oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!KYjjKXzy4egkNOv4NcO0tNoE
> VElMSquM5RizBqquFexq6ScoztvIJUysVnUfltmEDSSy4LXCb1bKijp8ZxsxyCs$
>=20
>=20
>=20
> --
> 0-DAY CI Kernel Test Service
> https://urldefense.com/v3/__https://github.com/intel/lkp-
> tests/wiki__;!!ACWV5N9M2RV99hQ!KYjjKXzy4egkNOv4NcO0tNoEVElMSquM5
> RizBqquFexq6ScoztvIJUysVnUfltmEDSSy4LXCb1bKijp8xUKSK2Y$

