Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884833B47E3;
	Fri, 18 Sep 2026 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700270; cv=fail; b=KGsPFlQNNawkWtK9UCo8fkPrW32wjnDFQBo2sFfw8g2imi7E1ybZdcFIBlW3JIMi7Vet1FFLeU1MFirI4pDraYtRMKylnfM0wFo7Kc0d1IF1qrJ/CjaxUUusaJ4SIEW7KJji/IfWmtZx6puF02sfxqueb5x1R3Ct++9v9/uMoH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700270; c=relaxed/simple;
	bh=hFj+oc5cX9LJ8mhqQAIl1p/5qPx/cRvLi7LAXx9H2Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gpbOXRaN1+lXKBXP89FVuec8hoMUPz4xlMaECg4eFoenvpdFKoOH+Ckm/9raqJxcPeSaK0a+pw39L7h0a6mucgVW33rZvcus9QjzLFzALEb+8pQ+zcwEZNjHnX58D/fQ+mUdIw6LqCtbGz09fej7tG3+9DSNVhZ3g1ZQ7o3eIr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h1YUqxmj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aQfJ/b1f; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h1YUqxmj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aQfJ/b1f"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789700266; x=1821236266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hFj+oc5cX9LJ8mhqQAIl1p/5qPx/cRvLi7LAXx9H2Do=;
  b=h1YUqxmjeHBfb6ZfY8IhlLxRUWl1ACHVfhn5rIsGnr6SBtDpX2d0MDPC
   aKZ5AOZQtx4bZ+9qcoLMW0efhJpI1Hr+b9nmavwlsDfR/p+xrsVATe8mz
   dE6tklQ4WicDWu/OPXe9yH7vi+1puvh9C9UxO49/pedxVNTru8a4VCI7V
   4wzqXedOEo0DanniYv42Ud5j21QFvW1nbmPq1Rtv6SnseRiQLQmdNdydZ
   b5m3zP1TrL8zAnQ+MJIAwCT2/t/GJp9rpI4MtnRfdh43GcrK7IiIYEQC1
   UqnVgfmVZt37Rgo8dMaf/TrDb7ZiUzgrXDE7H75Bu2L4OZDOARuLyV0+w
   w==;
X-CSE-ConnectionGUID: rmmtybuZRDm7FczYNcykGQ==
X-CSE-MsgGUID: /0iMotGtQrWzKuzYP0QENw==
X-IronPort-AV: E=Sophos;i="6.27,103,1786982400"; 
   d="scan'208";a="155788987"
Received: from mail-westcentralusazon11010057.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.57])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 10:57:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhKbZWFGdE4W1XoEaSa7gblSlgnYhOgB1DdgQCE3ov4Kj0YYR1xsRf2S9WmCWHexZVcQPZY8I/PreW2JTjEKcNzD6ZGMzrXmOcV0+Vp8kxeawJnD3PAhBbOIVeBwYMwzox1YGWX6r0WoAuzHn3w6SFfB0rOZhK8iYjqDwG4wCl5he3mTZ2o/+Z9gd15Usp8ZXYuL+Ogl1auZk9lQdxe24ouaPsIohmJCLuEQDfLMTB/VIT8aiqdDcR1ekfGb6nHbc7epsKlOwPPVqcgSsKPmsLVvXEzWfX+0TB2mshZTVqfzMTzJSiv5O61hQX0Eh7KReUMCO8w3a9VnNoKxL1zk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL04EPBaGEEWRC+0jwGk/Fb5eT925P1aBnyBFWmPAjE=;
 b=rNf5vhDF4tGVsaDRuTOOU1KW1YZex6WII7B2A4lsSayNg0jThrqOnAleoV1fsKXTbHcLcs3AcfMGiui+ZuoO/MK+skaCPflggl8m7WMvgjL5+dG+OLGt050G6+kKX54g+VXAQZztDNrjazc/OyHN8A0xP/BIOWkRGxmAsv8W+wFrP6lGfpAOKFQuRrfzQzmJAxkcu2wqDT9g+sDebgSPn7M2/ZZaOOVlEzoU5cEUyGEH7OELmLhzm60GO+jcNUDklRUXVoHRaSco2+e3BgziMg+JCgHwpInryiq+KocMOE7WZmp0HYbbrTBs9MsOCwA1wSncIQUgnI39hYLXYGBhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL04EPBaGEEWRC+0jwGk/Fb5eT925P1aBnyBFWmPAjE=;
 b=aQfJ/b1fJ2o8v8HK7taDnN/F6DTDL6zYqDO//Q/BTunbXcQRTMggd/xI1qVkIypnqEizwB/5c8GBG96UEOpTLV5Zhg/o/+lbzYvCn1ZtXJc2tKfcHSnxx6vzBeW6+aQkgManznzilnaVM4S5wc4ImyrvUZeK7VEXz1O7459GgeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH8PR04MB994023.namprd04.prod.outlook.com
 (2603:10b6:610:332::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:57:35 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 02:57:35 +0000
Date: Fri, 18 Sep 2026 11:57:22 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Hannes Reinecke <hare@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	John Garry <john.g.garry@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] block: take i_rwsem for the splice read path
Message-ID: <aqyoQe3ZU9LPpULU@shinmob>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-3-1a5222c6e8ad@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-blkdev-fixes-v3-3-1a5222c6e8ad@columbia.edu>
X-ClientProxiedBy: ME3PR01CA0028.ausprd01.prod.outlook.com
 (2603:10c6:220:19f::22) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH8PR04MB994023:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c99973-6b70-46aa-b904-08df1530975a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|19092799006|4143699003|22082099003|18002099003|6133799003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ae2EA99BQT99MYH81pU7EtSldI4AvOiAwk+6fnlIEUUoiAMWTzB5DBFYJOLNYMbfHDlB57B6dsvgNV5ADPZBTZ0nZpNT85IRQnX0/SbaXu9U2llBLvHBYVlZnTKVPJKRmENvBhUP2+sX30+7ZUvk/rFws1hxdwFxbfJoD7lWLjOjwnhL/1vcLXPa9nm4pUeWr+ajW+8vOyf+hA92DeXre213Y3Nu7s4n5iX5GJGJ8GmqEXYsMA+a48D29/6PtOVu+H4DtJCh9ysRmxUGRroutXr6CD7soYdpUSt6WeNAnS5L8sgcSxi2Lg8J6ONv0dKpn4baz6LBFM0GVlMtjQbqMFGtBsBl2Qc/453BS66xthS3aHDv5wBPdU9jVCTdDX4uk9X2soWNDMZQntMjjx1ZSF/BMzRwMIuZIHRylcxaW5IymxGioWAWzYWeUG7KEBJsbcaYADJY7UQuk2cqum0UthjlUnrSVkmcPXP3AcGu7FZih1S1QKnn9S/re+wIJEMPzs7SP7xQUXUBqGUDsAOTxlUPh2CPwOHZGBkoev0QXqLIbj/WP8vWlXzPhic4cxRbyNVT8dodzoDXX76VEJTiAdn8lxT8YGFCVZeLpNjjaTwJgav3oekLTTZ/w9x68orkV6FSbZRR8Mb8ZV67d1Ow5zr/kGwMwHcqXvKy9TSywEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(19092799006)(4143699003)(22082099003)(18002099003)(6133799003)(5023799004)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mthzjZHTBqrlUn6tqMx1HasWX857GnPzJYaHnfPt2iFm8U+PQW7MFVwSUT1A?=
 =?us-ascii?Q?VmzXzbK494llMn2JF7ljzJtAMmx0k3M+bk3Oqr/EZBCeenecC+2PM0wr/Smb?=
 =?us-ascii?Q?b6Yp65+UwKbEMF7//QZLyjwuuJtgP2Za1Z8QxeMs6lx0mQwr8OmEPxJVPbRv?=
 =?us-ascii?Q?HFKIgOZaKCWXoj0p7bjuuiBDVMg/0LVWzMibkaEpwe1wBK8+4CDtIJdoCYRQ?=
 =?us-ascii?Q?D4ja9/aEu2JpIlmToOX93wJOWbUz4rjfHfR0xIyyuh1UkDIF/sbaZYmWD3ZM?=
 =?us-ascii?Q?9EjmrO5+BXBy1I23kaagCtcV7cvDVUNs5Sy2fxjMP6cMFzfe+vjfw7ZL06Um?=
 =?us-ascii?Q?ZPBpvX01OXKd9x960xLiAeSp5EB+QFdIuEJYctrG11t1NXN8Augg0GU9gooR?=
 =?us-ascii?Q?T7zdY4BBQXHd6kZ8l2Zvi7VbacyeYvWoEabApPtm5CWU7bKDbKIS1HdLXMBv?=
 =?us-ascii?Q?7PTyib1oVUDDaXij+M09uzplmKRLUBkAkJV1GscQPUIDJ959S7lXRjpBfZWq?=
 =?us-ascii?Q?XMY3emAVHEXYslyNCm7bE3ChbxtMX5uWtR2sLGESzpUJYQ4cPhTesjgw7TPp?=
 =?us-ascii?Q?ziZV/UvIdTFeNr2YHB6D0D0LAT5TibdqZtvYAN7p7MXsi70Qf+dxyBzZKLmz?=
 =?us-ascii?Q?EZujkeiG9QNTy1cDgAbRd2xubgegjwA1YYqaBF7aWzNRIkOlmm4cNO2nVXZn?=
 =?us-ascii?Q?U7aOARY1hKRUDyCEcqj5VEdlF0KQ1UBFCKhaKf1fRT6Py1DmjqdgGvo4w1jn?=
 =?us-ascii?Q?JNt/tWcu4OIs6PSIonTN2uFGNBvlCdIgteom24uTa3S0RlQAHfWRu4dYWqfE?=
 =?us-ascii?Q?+bUSST5B9JMzPeoPRQ4ZZA113IlYAbzbiEfeReNBZDgsmRZkj7TmNyQnINHY?=
 =?us-ascii?Q?Dx9PV5ka3aGaRTCMKSO+9NO02efjgf8bOZvoZMZcSpH8jZMnWK/9XAduL678?=
 =?us-ascii?Q?sex06YLDJPiTQj23QI7bAyJwrS0Wa6tW9kjOw5/JlKFUvdcWfFhw4eWvjzbA?=
 =?us-ascii?Q?iUDUG3YrklOeUKPZe2Dh94UXS/GCwNXo8HqzNYbT3LFrn0U46+BM+DOgCcsz?=
 =?us-ascii?Q?pik+XUimEhCrcHdHvQPE1VXZcvObleoxYBmh4SM1OiUQQ6HS/z3Bo/TE0D2i?=
 =?us-ascii?Q?TL8u6Q+if3Op+3Z1r1FKjGwNBM/gXeTKQHdSUgZUMe4e0Uld+1zozJKa9d3F?=
 =?us-ascii?Q?levYxE5tQYQx1T6CuhJxM/nLppLeCjlg6UHzQTv6dzUekqkf7YwBp0n0LgDN?=
 =?us-ascii?Q?18/RMnq5JuDTtfCBzsBHye9d7eV6/Sr5SEvwIjIGoJLvuKqVqYHvY/V6K1+V?=
 =?us-ascii?Q?yvPBEfVodmzcd+FrfGSG+a8sRx9xWRaDTobiebTkXeRBsjci2F4jnl+s8jC8?=
 =?us-ascii?Q?HJqZRl2nZQX9v5c67W16I/WKzRxpshRV32y0GYvGOipBpDEVxwERR/gu7cfE?=
 =?us-ascii?Q?gzOYsxYFRwPlCtew/KCYloZ9Hpzm1EEjTjFj8x6ur7cvVuE8ULdv9Qi/JCjc?=
 =?us-ascii?Q?KstkpY5r/rRmpMnU8Jl6qxgPumqKiuuFDMYXd3rTF78IUkVX5zo+enwf8/uO?=
 =?us-ascii?Q?XdFmmNw8QpoIJZhDrIa1AB137ki+KQdKpXIcPUqLX5fp/5LNx6G/etsFehUW?=
 =?us-ascii?Q?P3Ss6ytrwF4FzyrRIufy+2+f1bh2MlFO+17Yvc157JoHGtRN+4ZllBzctq8b?=
 =?us-ascii?Q?/UE2cfKcZCIq0AxlYJcVO8j2d27gMox82RgNNrnWmjEzuIZs826r3hTizlCK?=
 =?us-ascii?Q?C5JGI0JqSI4JD2yiOBtoOd+tdFzAqsg=3D?=
X-Exchange-RoutingPolicyChecked:
	FaG+W83+obwnANul6eRC/aReogA9JM0hGizye5KvbNXlEzbCktYNySYpVrfWhxN9WVeC6sVxklrhA/EntG0Mph85Jupf749eJdOvqvXUmdIlcSou1QPpyvldF4o8dNUnrKWmjf+Cf9f/Qml8XEZceG/Z/0MSdEc2yQ6RcCwu2qs/+0NZZj1I1zgqtTMWSnqL6E9ZVNBkDPvsYFOoa/CMqDg1negAvNxbVVMJV0ii8SJpfpScNeaiFlXGlRAGxkl8NCSJup7IxDAtbd8XvAmj1gGy7xk7YTyLZ9/twWlIGh9Frwqt9XuxEsLEA3VDsax48jmcbkYqMGyvQF85Jexz0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VISYj15c6EV3Nv2+rMv//vHka7zWrYO/JdQ7bxMulqCnc/eYvapLtVSH2sNltEZRuwXiKvRofI53OlWCH193aO4psnGYezeTSL1Of6t1GjeczmB2kyCYxsMTW2NE6BWKjF5H1isb6wFOtMGoqjW47VEMRdU5QfihJtPiR82WO6mBUvZQbeEeeAMoR2xBKBDVo5+G3/c20qdDMcxwN/f8XivSpDr07YuZpCiexAOPmkzMXvU32mfJS7cA9AylCRoB9RkK6/viIMhzpkmJByzaTY+38ohQ1AhfI2//d5hpQ2woS8PbUUipWvlzaAH6N3Unj3SkubEpxpbYQgzypI0l5gLo5n2aqqQ/pJY3mBUWfpPTcXZ8pvIYoKirPhHgCHwTjz2wJ4pdLE4PVEASEoBoKTEP1XrUjCvLmuPoTTB6w2LapvRycZpX6pRfOMVP8n6UvX6ROj1AQTe3zWwTAo2u4kQa5dTgYg65OyKR6J0hgAqymGobUSj19ffwyY0gVxZUHFlHZpNLZ7bTcIwVD4F4WU5UFCbnuo4OSKXNP0kYg4Xpl5omEUOxDkgJPEtL9RQUE1Oa+jojfU+MCxXE1Q90YIQErLj1FFSrkuAanM/G6VAqU3mxnGxyEUnb0NdAlCcY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c99973-6b70-46aa-b904-08df1530975a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 02:57:35.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCcDeHZudCLXK8cBM4jbxmKfQLSbNyGNeLtMdOtwL95q5oldDKiQWhq4MWkRWCJ/w1zgrLTe61TA7H75JcT9oDNqpFP4YQbdqIl656p9iXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB994023

On Sep 09, 2026 / 17:59, Tal Zussman wrote:
> def_blk_fops wires ->splice_read directly to filemap_splice_read(),
> which allocates folios based on mapping_min_folio_order() without any
> lock against set_blocksize(). A splice from a block device can race
> set_blocksize() raising the minimum folio order and insert a folio that
> is too small for the mapping. blkdev_read_iter() wraps filemap_read()
> in inode_lock_shared() for this reason, but the splice path was missed.
> 
> Splicing from a block device while toggling the block size between 512
> bytes and 64K with BLKBSZSET hits this within seconds on a
> CONFIG_DEBUG_VM kernel:
> 
>   page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
>   kernel BUG at mm/filemap.c:858!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   RIP: 0010:__filemap_add_folio+0x51c/0x570
>   Call Trace:
>    filemap_add_folio+0x64/0x140
>    page_cache_ra_order+0x1dd/0x3d0
>    filemap_get_pages+0x153/0x760
>    filemap_splice_read+0x13f/0x300
>    splice_file_to_pipe+0xc0/0xd0
>    do_splice+0x6a8/0x890
>    __do_splice+0xb0/0x210
>    __x64_sys_splice+0x80/0x100
>    do_syscall_64+0x10e/0x520
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Take inode_lock_shared() around filemap_splice_read(), like the read
> path does.
> 
> Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
> Assisted-by: Claude:claude-fable-5
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

I confirmed that this patch avoid the hang triggered by the corresponding
blktests test case [*].

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-tests-v1-2-1f8af8665d16@columbia.edu/
