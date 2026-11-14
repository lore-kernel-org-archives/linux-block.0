Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794647437;
	b=St9dQg200DVNYDwc2EHZchcPHrf66W30ZtnGOn4kN3zW/jlAdaoZUctm83tHnHAUuHdI
	 qANI4JOaYMTcXS/1bdGPNnpgrSRgdEldpa3+NYgo9VFNaMcuHs2/WNuEVIgi6eGvLx82g
	 0afJp5wLa26T0ZkvJEonrVA5z3yI15zFoiM2BmMe5/vOonNHztas2QineMlW7iMHka75/
	 HHuTY5gW1YqOnJniQgpNy6613aLeFN2qu0F7itJbmeGybPm4r5HhRQkzFsEdcYiHLXU+Q
	 phTicN2rNHKSSk52js9KSgUN7uSliMPDRzK1br+tynzUyVj1EHQDrm8gjxFOMhOiFGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647437;
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
	bh=j6sMsdkBUFjOFLRJqUdEBLPv7wNPfXAc3qObJImtLxc=;
	b=G2oDAoB9mZjV1s/xzNQy+kZHl6CEkz4z2vLtbwN+nrtCkgiv+25zKvVkVkm09iTjEWKF
	 rpEGz+zFgrHbJsURTeH75GfarIhqOuDv6aKKg48fSiS61DngxJcyBnSPouzJ6ClgJdAX9
	 QeXFjrcADOL9zMKYkAx0rX4kVbCCCkyFlRHw2WVdMEDhe9RvBY3ajPVkpXfJEpwVTj21a
	 CGkpXgYATczU/LdwGgZQhjO2+HmjY1jUxdo6C1FkLljB6L6ZD2t5ukTiKGuimgt9cYLuG
	 /5WjzU+/18jJEC3/wT0+3qLPiL7hQ6azZ22ddetwtEMGhMqgS22SE12i0B0eOf5UZ1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=fail smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=VdrufDcs;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tQsxd+Ll;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324E606A323
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 09:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9324E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=VdrufDcs;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=tQsxd+Ll
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794647436; x=1826183436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3HarVS7Yhu9+TGpBwgFKFTKzsGxaP3jlT9+pdS+eDnA=;
  b=VdrufDcsOXvXdtZ68oacwNAGRU3TQjAndE7RHmSHkW+omVWKMGNucmTI
   pKju2Sx+kJk5SKR7PQ4pd+LMAt0fifR/n18LjWk/Vd1yWIUr4zk6ezO8U
   GrtKVwlCCxJKHxxdYkxxKNMzLTstubboj+3QYC26OC+TNenmZ9AF514+p
   c+2GngqmBIKDiBqyqdfv62VHIVUyFhtaUQCusEj/TWjwBUTb8fvFkTLwh
   Brp5h6r7DCwN6gZog4ut6jgii6o4ffFOXG7hzn8WvmqPUlhN2IgSsAHqa
   7DtkUGdeBifqJxYad4M6+emfW+h22KQrsleMOpO4m7o0BMFkkUkU2G9sQ
   Q==;
X-CSE-ConnectionGUID: TG1Yx5NxSFCETVCcLtPtjw==
X-CSE-MsgGUID: XuqIkUXtShmVSYDo2Z7bJg==
X-IronPort-AV: E=Sophos;i="6.27,213,1786982400"; 
   d="scan'208";a="156629945"
Received: from mail-eastus2azon11011071.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2026 17:10:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiMfdY1LDMjFg4C3PDbRi9E+sQSsesQMLGyihks19Gg+5vSg9tDWG/riQKhLu46ZjlmDwIQR3/e6bbbF/8VwltAH1eocf8NVWBFHAmUOlwtTGCEnfS5znt+ZFC0DTTtLhAi4shdQyCwFgvp0LSrIeVYrxO6rE/+hwwTR0ibX1YBBqVQlnisPGd77EoUwY8BvizxliijZMEiKbQ4geafV2Jj264D+ZXljFJjG9No+jgRU9Js3vpHNm8JSgzUOlrxAXdGX6mPCdVpS9FvOBiAU2NYYcz6TSjp2NBdTezUmdl9ytWJajyQyXuauhj8J8SNJ/JxF83kI4oM+ln4oMMmSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6sMsdkBUFjOFLRJqUdEBLPv7wNPfXAc3qObJImtLxc=;
 b=mnswaxaEkU8xIuUINppWvgnrBnreWAOaS6v8dIGnfY52zjxbbPvh5Ui73q84ac8d+4fkYktoNPw3+WGcHvtj0vXEb5z7Ts/x4T2RfcPfT4F4d/SdElr6pMfQ1HaGUIvZTqrQ7Ap3q6pdn2/XW4RUcMijErdzA9mEnJ0ha2yPfdjZdxjG9NKvw2X7YPQermJ+FMmyQLY04icojpfQBvp92y9UKiXVjjIhyQdyuooyq2J/1ciBE7plCHR6UPVo2IuVA0AT6TUixrfRGpQf1JhuVgL/gW6sngAWwXv7f+tzrkUEvtpQ9JajIGYZUKfdwZxZx+fCaDDJRaYaZUwepcxfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6sMsdkBUFjOFLRJqUdEBLPv7wNPfXAc3qObJImtLxc=;
 b=tQsxd+LlGkGB91Q7kx8fnlynk7V9fXyItXS/G2ZHi+oqFettZM0vJPXS1C5Nuhf/PL41aMH/1s45AvttSbHdoPrlOnLj41AwhyGKi4OIK45DAcnFj4/pWGsOoZO70BlWoXl0cYjDOejHhS5omN+ONQHSUlk7UYe8s/wrcPxh94g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH8PR04MB993561.namprd04.prod.outlook.com
 (2603:10b6:510:40a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 09:10:31 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 09:10:31 +0000
Date: Sat, 14 Nov 2026 18:10:24 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-block@vger.kernel.org, nilay@linux.ibm.com, 
	linux-nvme@lists.infradead.org, dwagner@suse.de, hare@suse.de, sagi@grimberg.me, 
	kbusch@kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai, ganbalagane@crusoe.ai, 
	sjpark@crusoe.ai, bchen@crusoe.ai
Subject: Re: [PATCH blktests v2] nvme/081: test the per-queue io_cpu sysfs
 attribute
Message-ID: <avglC5DZBx6_P0M5@shinmob>
References: <cover.1794015622.git.saravanand@crusoe.ai>
 <20261107095350.98072-1-saravanand@crusoe.ai>
 <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
 <20261110115005.47367-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110115005.47367-1-saravanand@crusoe.ai>
X-ClientProxiedBy: TY4PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::15) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH8PR04MB993561:EE_
X-MS-Office365-Filtering-Correlation-Id: de765c8c-67a6-41e4-4314-08df422f2217
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|19092799006|260925021911599003|260925021311599003|260925022911599003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PbTn3kJFk0Pevr0ruup1Mth7aBNAMHZEPSGhjeppkwY2o2VicAVqTmxrcfiYUdXFVe16hs43qrr+Blpimw5/f68O+gb5p/K0eLgVK6fBZQRfskRfQ7ikc12XckS0B5mony527+2MN6gQFZcPRxFXTffoczsaz0gPLASKGJR15LOZEf0F1syM+a9Qk2zM+VDnUFh3n8i4FhUaRdCrJgUwXTb83y0D+dyYQIUPGKdy6Bv9JnCYdkpsWJBm5htadj+a9pqh4UglFEjynTDY55FKlwWPRrY7jYti0tYku5MO91kDmtsGd0CEWKk7E6aQQ02FbY4jb/Awjvd4IrjduGq0ugiGhYFPdLK8ehIG4u1jX2E/sLIU0Y92Tl5Iyzf+Uh1ZqWYl8AthhDh3mQUBU9ZoZcXnOIFVTlb+YqB4cBbtvO5fTzvznyOtpBHT0bfSVfH/T+7JgFIpxy5+1YjkmnuJEJGI7gsE2+mKuWx0zTW4y2xdUfbNJdcmFIQ6ZpvSLPI/W76q7ZEleD9txz2YH9We2drjv8p6gudYIz50eTlnADFDK/V+seqZoU0CM3GtWziQrwrM17/hBMWpxVG54Mjdmo30brCPxGKPF1FV+ke5Wvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(19092799006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FC2FA4MBdAtbSQGCg+Ba72a3Km6MabE07crRJBZ75HvFBR8quwEj3nIOhct6?=
 =?us-ascii?Q?EygciuEMTO3rdRVqh1qsc3cWNmJA3zPk/fp+xdDJiCRzp3pb7OQGujRLjxot?=
 =?us-ascii?Q?8P0RMq3H0QTYaCrN4VhM9tGRu6nDLwg410dguGchTFIFQfpsXkM7UzNOTDPZ?=
 =?us-ascii?Q?VlR1HOH/3vQHi0/hNwtic1DB3lyxs3s3xSjLxg+Dnxo5wd0Y7//4Ry3ksuHL?=
 =?us-ascii?Q?B9OtdgoO9cESdDPCUI5+e4vFcF0LuQI537ZkS+hMHCCrzP+ZLJQDojqyrXI9?=
 =?us-ascii?Q?TpVLIy87Wm29pRxcDkJHShbGdHK3lG/1nvmxCCD1TyX8kVXOtFMG6bl7RANX?=
 =?us-ascii?Q?SwHTuropqkYV+BrAallCtJd5s5oRG+cqRdPNl7sdKpLPjeql/Mj1Jzo/5oIK?=
 =?us-ascii?Q?7dPKqmnO3A5BNnM1vU4V7Or1WNCzLJ0KPw8WwMnY+sjo+dxq0BxlCPT1GmBT?=
 =?us-ascii?Q?AqDK0RJ6BLvGN7NW6N1SyMyBs44uDC4gMfYqg+RtS4/Z7XfCwcHWosawty7x?=
 =?us-ascii?Q?uAa/9viQ+480LOZMVwbym1/rInCQAttq+XSqeGlcdvxgVMkB35pimietci/I?=
 =?us-ascii?Q?zR2HDTCpwvh6BiIYUheo5z2cW4ixGthLfHirSTEkmm3Klin+oWLVf+UQBIkr?=
 =?us-ascii?Q?yOMFj1Qd/PZBIcQacPEc5iIqipzQvl4UWXNbQAErTOf9/SFGIwNp7tTCscIe?=
 =?us-ascii?Q?cYaWhQHELbq9fRYk8Cvu6XlF5dNEd1KZxWyxziSU9eKGbUpzvjkns490EVGo?=
 =?us-ascii?Q?T/S0bN53WcJ82vgKVmAXxB4zJwC4Hk1Z/0KOb73atQYp73ZffVSnTR3O6cTA?=
 =?us-ascii?Q?Jo04LtydirMC/tJiDxojvgy90KCwyGaQAPUN7+5zXPFvUGANt3UH1B+1MChz?=
 =?us-ascii?Q?o22eGYU+CGl3LwguI56OYpZPWNXulN5bOoG2W41mtn3U200wv9jL64FgEfBi?=
 =?us-ascii?Q?uCGe4bvftnwU/Z0sOi7CZpzCQ++Ko7OntFpgfXa7QE/sNTf8fSeV6kBXNYcp?=
 =?us-ascii?Q?x4iNoGqbfDEvXpQ6AI/9QLNGHh8Sdjy1qv9xk8M8VN3DIaSMeaDtUVrYvT23?=
 =?us-ascii?Q?B7lDxhXp8tj22EaMhd+NG8r/+07julC6bDUEAzbu3HH4ipjQE0WjVP7oDepm?=
 =?us-ascii?Q?bwl+GU2qcjveYhWBo44zv2x4BKib2L8taPnc9asyFuYzPzlCRRUI1vvAzrrK?=
 =?us-ascii?Q?0GHD1IaE8wiC+fNdUvJ7Bhqn+VYP1VvDdiB9zi4BTQYkT4UrLQIxT9m3QC+8?=
 =?us-ascii?Q?naim5dezW6DxbbGhkk5AIejGWZ8lOPo45OHctRmBPmQH8g8KjXD7ha6FmH6i?=
 =?us-ascii?Q?gbc9ACmbWFZbKm1vl2GCa4N638NkWmbnacdC+ocS7z600nvvYmoh0ZxotnTx?=
 =?us-ascii?Q?5gyI+4D1BzDT3UpUhD0kDdLHL1lNAp/x6Zy8PtjMmyHGBAfuw5BoFOie8VXc?=
 =?us-ascii?Q?pp7RP3Q3K1FrFihtXEB6+a4OjKYTbhEkgYuH0JVflyGVH83lg/rI7eL3zyct?=
 =?us-ascii?Q?kjC9weSk0esq9fHpg83+bQQnlip25HakadOGK3wg2lV5eu2EPWCNg0Z1wKYF?=
 =?us-ascii?Q?UEqfNSG7DmSSBPbWHToISoKvuolJzLYq0uOQpllPsHPEiATAcPZGkJ99FDeS?=
 =?us-ascii?Q?JAODWWwb+LDcNnzUNytdSSpUKbPDlFIlH/2TY1eb31G+JVRYk/b+aZT8hKyV?=
 =?us-ascii?Q?xc8qr3AwaQ3gahn2z9xPMS2I7m/Zjw1j8NlHI0iwpKjKf1jgvDqKDneuUXF+?=
 =?us-ascii?Q?EWpmVtIylu7/bX2AzZFId1UtYCegmgs=3D?=
X-Exchange-RoutingPolicyChecked:
	m8bRWCLNlmXKcfHkR32qwq0YYblNLIxeTgVVxS0DpQw1EKmwsZXrwlCE97R0YpMFDx4s0oe0QU5kcyMRrwqyqxheAHxfB7Vgy1JqQlDOmZs63lQxrCrxUgumHvYL2zGwW5rB4UDGVVKj1tRn6jARTzM0Hxv3lsIdDV/Blq2r8DEDjTYjNpK5MinC+JI6JunxDSNDySdA8/f2RiSRef6TuanLGwoP99wSbYYaYLD2uOLvBg/oJQZhM36gk5y8q3xp6HH+Oq+mvQ5zeP/lsl01GEBGBcR1n5EX/B7kqUxMiX1TCPnzLysUPBOYmsoyaZ7LD3ZZvVlugEESzFeHaarrJA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LRfvD3l6Ip1UwFSLO78ERanySVf3d04/FjIrm2pw52znNqINqq8FkSA1Q/iLkWH0l/dnsVIa4hX5m9GUepZ3nP2IJbT3uafw85s41vTKRyI+dF4lyL5gWubldL6Vdt4wGIDIAwKxcDChhQ4PT+TsjiJQh+NnMpI+4LTVP+1AX9q2xpmTMibfKbfIj309rcUm2Z6cyn7ssMM6q3pmubipT272qUztBnyxVaH/xWLPGC2NK0u9mLsicFcoXjxmozhNhX7/vs89YmslF6ApDHotnvEQJJ8mug85CsnThEaeoeb3Cr4hX4MxCJL1iH7xkiUhzUhLBZf03ytJXNBp55jR4LUzFg0vDtffUawclWz/t4WB2/YE4ZwVZ5Q3izsJGTIzppTgXDX13GSBwDb1/kk1fMiublvA/LibpLHo87whAbaKZM5DA1sqVJlBAZZHrx/fEpgB1tEifH0UasZoqyh5Ua2H88YhbhrVMHK8/4In0m89/i/MNgf/98EhB969KjuVwD39T8FjzXbACn1EsEDrbxqIMhU4KDMI2hJLizA5AqPD4dEP1Z47OHHdEVVZ0gpcIYPciMOgC9PvaepqN0co6UrAvgiLDFagmtKjvQpC8n+XCMFs3FpsuRsK1zLCnX3u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de765c8c-67a6-41e4-4314-08df422f2217
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 09:10:31.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB2br06TAqT9GaHBAKWW74TMU9dUBFO+LfNHwKrQa5GaLe3Egv9oxpoJGXJcGmwSEnS1bWiZFflSFO0Xmlpryak7pUS3aXlY0f/hQFCRi+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB993561

On Nov 10, 2026 / 11:50, Saravanan D wrote:
> nvme-tcp exposes /sys/class/nvme/nvmeX/queues/<qid>/io_cpu and managed,
> so a control plane can choose the CPU that runs each I/O queue's socket
> work [1]. Test that
> 
>   - io_cpu reads back a written CPU and rejects invalid values
>   - managed is read only and turns 0 once io_cpu is written
>   - an assignment and the queue directories survive a controller reset
>   - the queue directories follow the queue count as attr_qid_max
>     shrinks and grows it
>   - removing the controller while io_cpu is written completes
> 
> The test skips when the kernel does not have the queues/ directory or
> the io_cpu attribute.
> 
> [1] https://lore.kernel.org/linux-nvme/cover.1794015622.git.saravanand@crusoe.ai/
> 
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D <saravanand@crusoe.ai>

Thanks for the patch. It looks good to me. I would like to wait for the
corresponding kernel side patches get applied. Please ping me when the
kernel patches land on the Linus master branch,
