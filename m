Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795524178;
	b=XwreiEKzZOqlkswHb3jommeLt5dD22V4SZyBSJkkXFkk450TfopWZKFKX73699f4/LHG
	 LiAztLzBm/6ZMmRiHp8StfE5iZhs4VC5yu29BdwVMF4TI39vDdp/D2m32oruq0jVomCcS
	 N5V2ByADAf6yY72Z/5QUenrFjUYw3sLTWo9YYjDTozcnSjNrnQ/lGCKFV93yVK+asQAjG
	 Q3UOQTGXHOM5KsGB3B7CQncoqHfLFw9ajjvg6ulV1UjpKs97Xx0XHQ1R5JqAdZ9u9lkzP
	 dzHpjSwTwvMD/NzKTEKIJyXpyUjfANtni6QuhtMaJbLANbx2+zxrvyGYWK6rurw1dsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524178;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=DI3WP9nyTfzpNXytQH9zDp+TU/5xlfoHCirE/6SHSYk=;
	b=pjEGofib5uOInSWR/JqcxzeyigL1ejG4+tn/2T5FEpPqkMdmvKhfFLdlLK3Gd7wl8gRF
	 1AphgOVMu2oVPOK+zkS9VEu96kW05x3wOtDzyzIPnJx9mTVOi/r4I0lGk5FIsxtE1SZH3
	 pYDwQmUgflwuSenPs/WO8JwHcW0wWBrbw8AuNRW0qea7NxrprAzxoGvi1+r9VbIsokCoh
	 DYPrSotK3i/KkaQRMkSqqfT8bPah8wHJjUYOzXyXaxyYBnvxljHy1JppIXgdEZi7ExWJJ
	 xwArlQb2q2M4Aw4amk2avwskLwXqNGykaddac1/MV9yr80rr8krfFvWE2VKRrZurNEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=I+LxUz5B;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=SmD6s2jp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F56606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 12:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F56606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=I+LxUz5B;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=SmD6s2jp
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795524178; x=1827060178;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=a2/MYuRE55SHSt3Zi67WRIMl1YUj1fOusQ3SDVBTuJE=;
  b=I+LxUz5B9p3JqK6BXSROOmEIwnY1Ix+kv3H5088Dw5rrOVyjKkuNwGQw
   zoTpjH0bEBXM9WKRrOQpbAgZWd8Fxlqi7X4wcPXlk0/Vm2Q1BT6QZmcus
   nMUgrjwosVssNQ8PcHHpDi39QBv6aaIpPAdP2YSpA/e3uKd9TfMYasbHz
   5XIg8YXTbYuLzAGRUVTkornAP/JUnKdbdhkAh9XBUI5SbPtpI8gEbZR3d
   0yxzdrnmL5kePVrpA7rQ9pLOTH5Hv5LnG6E8PnOZ4onR//R55WaLz3jPW
   C6QleGTskgvLoq1RzyF0gNjCd9IGXycrwGcMHm+Dzu4Oq4zCbvXcNCgqM
   w==;
X-CSE-ConnectionGUID: 7ykwr5gLTxWXWmgbCJ8ZQQ==
X-CSE-MsgGUID: gwTIZDs6QvukPa12ZQFJ+Q==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161646648"
Received: from mail-northcentralusazon11010037.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.37])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 20:42:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIOJpkwsownpYzbsahJmudBd/+SHsgYSN6WWC72a84OeabG7DqK7RnQdsLUAFmu4sL4+eegRwuVw6nGBKkd4VxMiVMy/U6+XI30htix59rbrh3NcQOvvpk7PgIlt/1OTBAlPZMjdyZlzpBlLsV7TnqA4XthZukjWQWglZVookIOzrMvHWsJxvCgXj0Te+1xsF2Z9gWu8pLL/GkgwOx5KvK9lI/u13iqIfUqcX1Wa/IkY6DiFnCezVU2TQtvnqDzUXeh6+NbpbvQjUMfWt4hGOOGBQeZyGhp13iZEHCGLq8WbswBjfwurl3aA5UMc283VR5ca0W6ka/ycM7fK0of+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI3WP9nyTfzpNXytQH9zDp+TU/5xlfoHCirE/6SHSYk=;
 b=WaicDfIydc+gPEbnXTAUkH3iQHsIdpVPSNgxZVIsYaSROblCbYtBv0SAWpmx8op0hmAAeRGJWk2UqKP0suFA9P12x2o7kcT8vCT1e2d/e/qP4P3dEinz7Hzh64SSQRbP0Vnmz3m8uruXprDVQXLhZiGhdpUlTcVtM57fJlyuBBc9/m02IndODwWZm2K0Yj/sIA1fSmeb7c8FvmPlKzmlRpvWjZh+qsjRV+g4XLgDrruV13nBFHNfTe9d24YHOKLYkYlsEFkaRhuwz7p9HSA38Z4BHpEzrQqVnRwiNb2M1eH/ULhxO6rYD/YwFXjwDQL5ChnP4nw/yZJQaCeseI4j8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3WP9nyTfzpNXytQH9zDp+TU/5xlfoHCirE/6SHSYk=;
 b=SmD6s2jpPjPeYKHxlC6LEf7yi2ZaFqtcMAq2zp/DDpXHhfc200cC8aBXzksXhqA+u3D5g+d3i0pfaDi96Gu4Chh0W2wkIjPxDcXtQ6Mijfom3B1PF2+wl9uQ+qQ/B3GrWtFFwqA4EQod1j9rf/KPQS/FZHd6la3WlWdqAXGjeqI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by SA1PR04MB9873.namprd04.prod.outlook.com (2603:10b6:806:49e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 12:42:55 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:42:54 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] blktrace: fix ftrace record generation for v2 format
Date: Tue, 24 Nov 2026 13:42:39 +0100
Message-ID: <20261124124239.146858-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|SA1PR04MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4e7bde-f931-4d0a-dabf-08df4a2875b4
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10070799003|19092799006|261026140227099003|10067099003|56012099006|11063799006|261028144727099003|261021121427099003|261022115727099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p23VY7Z30MZxZPDGwcg0eHTy1odBVt7DPCTsmKpkQj5h2SNmb2uaBjiKuaCXIKPo7sAND4XQotB2vlL/tqV1+qYstBd7ui7wfVriokIPkCnHXAv7j/7mXPUw/cQvyP/9KkB8MTQSgMSqQkeKuIj+aobrPe2rfSpGQYg0W096CVH7LGnpnbGLd/V8Fbf22ULLbCdgaK8J5rdVaZCCteKcKDapcJ59PkPfbdgnCIxIEe7G4Tcy9hK1JI9AttTxn0PcNVDales91OuxjqlnT/KJyuOZHt03m8iWgrFWblKUW3gmsXOP48sjlnsQO3iCX3bUGq4wHHmWELYTZk4UW7U9wGErWWNT256GVEA9KR0mflWbm7IVFnQ3YGaXkBWaQHoEcSVJNO2obcaPu6m9QglIrgS8HfZFWzOh5TbCM6rg4t+ZoDPqDWRpxFQSxUfg4Y6A6dXh+qrPgcDhaXdMz1gjxcxYGxTqlgXPKsmrkdq4AZRoQwGa880edvPA1SOhK8cO2KTfp9TEfRdeByEk4tBp9e/nwCcHnCUImIGFOgPES5LsS0q8BXx+cTS82nKtF2fsKLoAZ8SfKLBQTc4z5aZoC2gTdkbSPfHd2uiJdnhF0917sHFZgVyG6gHRImrVB9DWCMAhEYAe7a6kmSOjIgXIiKp/Nn4JKgUa4Fy/ea8l1dk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(19092799006)(261026140227099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261022115727099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d0WP3h82gFoZBxyL0SwUyR9hNR5zZYif3BPo+9mp7WdVCCYSPXRzWagofXwe?=
 =?us-ascii?Q?U1eQqp5kykHvtD8iqm1F/blHWEYoIwYJWDyxzRmBC0+ZBAuSJAgzEoYOm4rm?=
 =?us-ascii?Q?CRhuWVoIxHbiCA9sl5uhzJaEAQ57+f+5Lfom7BaqmsuFyq5PY3eClQOO0ZRJ?=
 =?us-ascii?Q?kdSj7aKt7vV2yPlIUcRg+YDdb9jiu8x/iZPFsQS7i+OQ1fYUo848/Rr+HHaj?=
 =?us-ascii?Q?RoC4h0srY05OFKzkBRRwFK5jpR7d6a8ZVt5oxiwGPGM1lG/ral4YYfOkI3r2?=
 =?us-ascii?Q?r6G8XiEoP9Q6eta+Kmk5sKaFM9PB2xiLfaeJRFhJTK1dgrKwS72sqAWvsEa0?=
 =?us-ascii?Q?gMv8yOGKuAT2IgD4OUz7xbdjukhbKXeda0IBRW2VJ1z3aQaj3PHqfj1jPs42?=
 =?us-ascii?Q?fMRj28eQ3yDi3I1pgCJnb1C52iQKNQr8+fEqbyJiKum/cFrjgd9L7/aS9GzT?=
 =?us-ascii?Q?zzc4A+SK7D9Bkie4j/xsHMc0vrNTUDiwpHlXNYrJg7D3eUWWd9/XsHtQCa4K?=
 =?us-ascii?Q?KhpMqOMfLYrXyJ2GUq2VjJ7t2Sr3UQyqfweu6EMM+q/MSJz+2f0InnyDXyWd?=
 =?us-ascii?Q?1vNuXBfo6/d/gf/JCCE+WIcyZg6LjpErC3X0Wcz3Xl/VWt3VlpgfMEmO9Ypv?=
 =?us-ascii?Q?Zg1a/3sNMqCq8BAUn7PyxZm3PsCD6YUpggXbLIWh7pdexX8XK+Gdo8KXCXIy?=
 =?us-ascii?Q?4Nc1ZUf7sZL8wYwsdOXhzBRY2vJ/UkGZRyYymgiZv16+Vx+osIl8BHyfqPP7?=
 =?us-ascii?Q?Y36x35llFqNU31BJ4jEzAe+7HMpfGQd54bK9krQ/pd15GBC8kVlEv1D59qwj?=
 =?us-ascii?Q?jJxmh9DOHqM5Eu4ptpKEOpHLMl4abNzCth9QbcCUvZG1G5X/FGAhgfkFf1a6?=
 =?us-ascii?Q?m0ciSrpvBK1xbGtal9OZqtDiZ8xuSQHXzygoaQCeaUDUYtcV3X5EDrtNf3Ex?=
 =?us-ascii?Q?5Ka4V/LSRWQ5oZrlNwR0lduHNVxpFQ9u6ne7Cy9Y1xQreYjvN9EypAR09uLF?=
 =?us-ascii?Q?nz9sZnp/SUe3kJqwutgyTS+RsO1tgr2+aKcuoID/VrOfeo+8bg1U2JUYzLj/?=
 =?us-ascii?Q?+YTvQChSWZEdzdVLiTF9eH+VkfftgZYx0o3bmo3ZIp5rVELBb1Ol0p7h3CAw?=
 =?us-ascii?Q?wrG8smK9Q0cEtDBJF9u/hNAhazE1Cg3wKABSqAxl8a0DYVBmVj/G1eRmsr1j?=
 =?us-ascii?Q?ga/PmOaQgB2G5LhF/czJ3uvUazPZw3ucVAM2fk/rwfIuIWOllJAei3L13bsd?=
 =?us-ascii?Q?IrwrhXVDX/oG1iA5GQbjxmAT60/vXL3FV6urgo9KeaxnhKA3Zz9NNbp6Kp0e?=
 =?us-ascii?Q?c+IP8Et7iyPRjVGgARL56eD29iI2whlwhk2lpnyT/ek0RosfR32thLu9+C1z?=
 =?us-ascii?Q?+EA+I58tczXgYatcWw1nmRghm5mi4oEKbr8gyhfCwH7gG4TAMcCgvnrdtGBF?=
 =?us-ascii?Q?DNX0D8xHArhMZQaRor6WYZnteXtlO81QpM1QRp7Ffu3BHugt4GQbNBezgtSI?=
 =?us-ascii?Q?l0h/2ueDFqhAc9MJ0Om1AxYMqSCJXfoUwPryPJDY+kIAWx+q06c9CZUHxFy8?=
 =?us-ascii?Q?+XhWGwU0uYqqXqi/Su1F5G2xUv5HdobnstC8/zfmlE/o2XCtH5XpEYjf3Xuk?=
 =?us-ascii?Q?TpdpL3fMq4EeGcQoGhzXU8ZQhwEomApwLdE3MExmZMPjJgZ1wOHCFR4AvLtk?=
 =?us-ascii?Q?yIs1+D8JL2zUmJBzki71PhU0FlxzFuoT0OYgFabuCHirDHq/oVag5zQJMG4e?=
 =?us-ascii?Q?gVnQPzXOyYRCTxNyWtbyVVu5btnyLH5uDYf8TDRO2A3POyvA/UVO2Y6t2yCo?=
X-MS-Exchange-AntiSpam-MessageData-1: Q5pNqybSfl5E6poGzuIgAiZ0CmRq1cl4COw=
X-Exchange-RoutingPolicyChecked:
	PkPFsIVirZPQr05OiwwScadLdo++GqZ5AW0/IDtwmDqp0iVX0WQBgfVjuNM76maGqnqPie7D9UX+27K1uR/CNo0TYwWF8gF8DP051g7tCAhryOuJDUeoCvjHtP6LSE2yC15s6pueOixG8fiHxsBkWz3bdGKnHnRS4md5w+0zQxj225j+mv5BakCdwfMHgOUkNbvIagQXpyorkPTKQbqqzWM0343X22qjQW5TGtFaU8U2YbT3a5YxrMYKx+PWIhBLmYNiBxNJQuFUZVWEUNpaBCjbjl2T/cZdi2q8K63DRMkBV3w9Y5aDm269K+XW1zHoRJFK2io4Qfs3fp2VQ53gBg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LXtY0Qa6pJ5+jEJSgVwfTsdJzKSQM86f4WPC2AyChB6zQguXtZDb/CDd7ZwKVnAREyQVjuRTd/xqGq5xhmj1eEGk0WjpeEor8i1XO8lha0Luy8QrwwYMmtFZr5aaM2l5Z158P29W0Tkt4/rVyY4Ul3B32o7EDWdsjZ1j0a000yaSrTDm2LLkNV6hunYv4ArQhoStGuiKtLpj/pL+3G8At8Pfrw8LBjMlAZaYrA1+/xOndIxt6oAWMCij/tQ+7uDXQCBSArUcw/t8/AqAAnCt6OecEnjlYYt/BQinrJpc57KiBHmp52J2Ipu0WcnwTbt7CZUZDUe1q9pbrg4YtHtt4gZmr59ixkrXFjOs/Q1bMCfcGyxpNHSZSerLDDd8Z6/SLwMUrllE8/cDGqAYEqE9gs86vA7Xq4c7N/m9FnbwwBImEVW9aS1/SmP+6x9wvYpUBZDOePf5T9VnYYb8+Tuv8DvVVVO9ZHAQxRyfB2j8BhDEyzd2P3SYzww0YTiL2hcc9yLBeGEkHzuivqOSEwfQ2X/xd62VhV9RVAq3qraEyIahrVRztRLWwZO4zOPghAndqNb9JHuyTi2c8fUib9tbIhWME60wZuCaNWdkPke7n+J1eSvmD17+SZNhYweXSByO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e7bde-f931-4d0a-dabf-08df4a2875b4
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:42:54.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNvqu6qojeH/wCpIylqAkBQAUBQdQuFLknnLSSz4eFC+j7eFPY92fShKXGInRRJBW/FrZ3h0NqarN30Su5ZwS2uiKSaJDheXh56KzswmKms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB9873

Since commit 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to
blk_io_trace2") ftrace's blktrace records are in the blk_io_trace2
format, but blk_trace_synthesize_old_trace() still copies the raw bytes
after sector like it did in the v1 layout. With the 'bin' trace option
set, the synthesized v1 records therefore contain the pid in the action
field, the action in the pid and device fields and so on, and the PDU is
read from the wrong offset.

Manually create the struct in blk_trace_synthesize_old_trace() instead
of copying over.

Fixes: 4d8bc7bd4f73 ("blktrace: move ftrace blk_io_tracer to blk_io_trace2")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel/trace/blktrace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..27936cd64fc2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1770,15 +1770,21 @@ static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
 	struct blk_io_trace2 *t = (struct blk_io_trace2 *)iter->ent;
-	const int offset = offsetof(struct blk_io_trace2, sector);
 	struct blk_io_trace old = {
 		.magic	  = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION,
 		.time     = iter->ts,
+		.sector   = t->sector,
+		.bytes    = t->bytes,
+		.action   = lower_32_bits(t->action),
+		.pid      = t->pid,
+		.device   = t->device,
+		.cpu      = t->cpu,
+		.error    = t->error,
+		.pdu_len  = t->pdu_len,
 	};
 
-	trace_seq_putmem(s, &old, offset);
-	trace_seq_putmem(s, &t->sector,
-			 sizeof(old) - offset + t->pdu_len);
+	trace_seq_putmem(s, &old, sizeof(old));
+	trace_seq_putmem(s, t + 1, t->pdu_len);
 }
 
 static enum print_line_t
-- 
2.56.1

