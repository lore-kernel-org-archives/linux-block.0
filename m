Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE019DF68
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710549; cv=fail; b=awc3t8+aDzgS3pJM8AEG8j9MApA502cXsHB/wydYoMmL51LrqqaO4JTWSCwoJ1XOknR/b29iIaSJtFh8HYCzLv34iHqzVolzdc70iFdD9QIfGyrXDV4VaXAy0BKoVYUu4p5AfkEWSX+P9V/cjpsjzGOuBrlWAf3mTdEq1f8QGSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710549; c=relaxed/simple;
	bh=mYQ5Mie45qFkGUYt4goT6LXyAN1Fo5YMsI4Hve4bsZw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qwDaULojWxrEFnRmEUCGS/hL7cyFWZ5cI4ggwh+/kPnR9hTYaWWV27jVB4YUvT+3RpcTqxOoG8CiA6GO2uQcNOQ99kSQjPIcaufZZHS1XH9VxyV9aKbdEdfccw20mEaGvuT58kNx2FFfLN42aC4VqXw8+Ky1ngfbqRcrNGFZbSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QCiufkDq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5tiPL1E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QCiufkDq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5tiPL1E"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F83I57013818;
	Thu, 15 Aug 2024 08:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=15iItwbYeHo3Tv
	g1fSkLuWENcug2G3i+YLiusjiTEDE=; b=QCiufkDqB4gNLlnCcYu+ZQIZAn8rW4
	S3woT98GLuIhZqA+Qx83U4ORzJcBBXVdM0uypsa2sRVAOUNngLn6WCSmwzFUH86c
	UFg7C4D+H8+bujaBs7Ekm+tewb7gIyfMFZlScI6x69DUpRDkayI3ipgH8EBV2SFr
	E+eOhFkFxCIyyZI4Qa+4flobP2YS2Eyl/zX8CNHDUZpn9vaAdl2oR6eBfeIoZKPd
	CTGPpV1F0ZkcmwMl9oDEkbfOGSf9uKYyv+JaZtslcNOzhcuZ8uD0MhXpaXqeY7WX
	2JFUgI3lpx0i3RoU+psb1thc9EMrjvBC5iLtky6Nu3tgvU5YCrjHyv9w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtt2mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 08:28:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47F7owbY003825;
	Thu, 15 Aug 2024 08:28:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnbvxtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 08:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/EWL4lubsh5QGSXSGmavb2JlXbnzqctjVDGx3VxweBpG1fLpmeeKxr+0BbfJTHtrXmFHvt4RiUO8gqWhkD3zkNZfa+tdEtG5F3IRdxpA45DH2wwfoVSWZAIqxGS1/UPUhX6Ca2jnMe/S54caWjfRrk2sv+5HauYmJUl0bMTB/ih22OYIcvP17T4K/oOL4wHmf6/hBlJU+9T/IC270tbpehuOYW+oTXRXazvxSoDFXTvv5OLjORqn9HaxONvhZVITo1cH0Crx/TQnpn98YR+ZrA9A5FRuCn8C1JlaIzyRpWeQmXtEIUnYv63pSgHjZdtR192r785lDOQ9y3ahOON7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15iItwbYeHo3Tvg1fSkLuWENcug2G3i+YLiusjiTEDE=;
 b=VZLYhXh0XOG9cdznIp1vEit2anSwf9djtqPmRRybAvzY+sZXZhCVo/OBha8/oH5+Z6L4w0CQ+Y/eAxfXCp51q01EesKaYood1AOCFvUZBSahhyx8oB5OWsawLxwy3LcKCULCk5tAG2VGA0wsPHORLaCTtQ/t+Ukp+U9i69iiNc/LQae2zzBdhg/yO2eRN3nTjtqltRLQ4p3998iAFBxvjI4l+2T6a+Lh/SpsAJrNvZ0Dh6Pal1ggi+2gpAnIDb/looFvtEFuG5f/VuzwWk377HbtyDHhTSyI20IDPV8qdl9mCAQRLdCY9Su0n6mTa3dlDaQziFZyS5B/GUe11pNbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15iItwbYeHo3Tvg1fSkLuWENcug2G3i+YLiusjiTEDE=;
 b=O5tiPL1EJj1gS310hkAQvi8wvS3U/nCcyKFA7Y6nds4hS0zsxbFW5ZWsTvXinNHR1/o+0QJUeexNSdG66XaPE5xdET7ut53J76SJ71BGcG43h3BNzAVDVURbutpzlhCz7bcA8n0EK081ZsV+JWWpmcSis5KGT8htJlJD+/e9K+E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.9; Thu, 15 Aug
 2024 08:28:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Thu, 15 Aug 2024
 08:28:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, kbusch@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/2] block: Fix __blkdev_issue_write_zeroes() limit handling
Date: Thu, 15 Aug 2024 08:27:53 +0000
Message-Id: <20240815082755.105242-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0279.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd126cf-140a-446c-7b5f-08dcbd043180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hj/Vu+6yo4NxLm2p1r66CwxgxRDBwsZVXkMeOK+W7/h/DHXVk343ZlsUM97h?=
 =?us-ascii?Q?+DiO707SPpnOvJkoRCnBMxFNhhNqrPv3SopG5gOf/oIz6fgmF/l/qrA86B83?=
 =?us-ascii?Q?haIgVjT5TyMo2p5Jd5UPHYwp+Fa1xiE85D3+WLMrviSsWreDrC4hqv1omRXJ?=
 =?us-ascii?Q?3OgCAC/TVrfxaQIIUCU6cyGRv3jyjjMQTk1SIFY7kpoJmvJHo9HRIv44l7HV?=
 =?us-ascii?Q?G2RZG0FeC85KsH+Iu5tSi1bbIDNyvtYkOtPD8pDru6lFUKCLzal/9WZWL/ab?=
 =?us-ascii?Q?cMVyo4vjIqcmohY4KGCjCawbiZUFRoqXI+ZejywcJYuypqnEjeqo0dIarpXc?=
 =?us-ascii?Q?knxVL4R004gayZi457BIAJ6D+bDa3JvgPPzuAD0qaJ+RDnYC40GDbBxdALpp?=
 =?us-ascii?Q?mE6/qLe1wW0COduNQguNPfYB3kx6DIojzQuLRbTylsZizaZ7SPzfgL6Cgrdq?=
 =?us-ascii?Q?0Q6iOb9Qf86+9WE7KCVteYjQ+MrAxrMHTh3EcYACICrVuEH03v0m0mnzmXnP?=
 =?us-ascii?Q?u3w0V5lh8ucivfl0xgpamT9j1oRTd8ZJqV3K56ouoWeoTve6Tfi9wsF4jwZs?=
 =?us-ascii?Q?Q6RNk9d5qPVDEn2a7zK5CaYv7dYvlxOGh2Ql/nRwUnnIza2UQ4wkou2tGwfy?=
 =?us-ascii?Q?poLwML6t+qad5Yo+UgJtKYXYH/nBw29CeUDdNZw2vh7iVPVxvksqyJo9MLDI?=
 =?us-ascii?Q?Dv8+GpMae8neMzFnLsJ5d5P0fS8XjyOJ1nyvBQ3qjoIN+bbxc45/kMuEPxP5?=
 =?us-ascii?Q?FiUW4BqX9LtIdxnjqJq58ra+0X56gMGLdy2d+i2SOmApVEZu0+8M15TPNkgs?=
 =?us-ascii?Q?S2vEGD/+RDerq0uZk/QJlinUYT/OnlvyllT6/tnzUcafv6dyNi9yfxZjDiDu?=
 =?us-ascii?Q?KxinwaAHrTUmE9PF3v+0TCH9Jq72g4X1yC258NnrfE/TGAYTVOWBXqXfiSzc?=
 =?us-ascii?Q?DMSZRoBIHzDpjpmU/43hB15f1boJ+jHcDd/yOa80ugLP8BixGPlDVCX2h8wX?=
 =?us-ascii?Q?smywO2LvAoZ4RIvX+nQHYGtEHwRtBVdTfPw9TrAaJY2K+9KKokpQATBZTU98?=
 =?us-ascii?Q?uzTqgxCG4564bMmltBhGiKjlO50vf8v/zBdqMVcIldMSoAG146p7dQ4rEize?=
 =?us-ascii?Q?0dwXK7h4bbvfFNI9WCpgL5QSUEM+AWk+rcNd3QSN4b77QFC+9rgXw+s+EpS3?=
 =?us-ascii?Q?5ZclhTx+oqjDU2acKOUtJgjNe01Q9ZRg0zVFilk/TOEsGbKQFTEf5BGh/Fbl?=
 =?us-ascii?Q?WWz0+BhJqgRlH4QG1DpEvRLMzis/gL24Bj3gohwxz0LiQ+vFJVe5yvy5T1j/?=
 =?us-ascii?Q?TyjF4c3ViftA45JJTh7SoZwUGi26hyq5lmBg1PpStCkgCHjxf8rxHNN5gYW+?=
 =?us-ascii?Q?CZ2D7OY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3MS/Xjh4xVGnNOI0wg1j49pACtoAh/+z6Ad/VXJJYFGK+QtFsRmrtxbxTvhd?=
 =?us-ascii?Q?vsW513eiaHku49nkCNYoYc6uDGog+KtzKZSR/11GL0O/OA/ZXCDEs0VVWXNQ?=
 =?us-ascii?Q?3bXq7+PbpfAV1kERrhDzVG9MNdyKzzQ/y+3lhEu5gOhUxcxehubXAkUxBOWI?=
 =?us-ascii?Q?+40iEvXnvYIa9BM3LpsoRGrs7SpKWJ/s/mtC15VFarb8h1my5xiDuMv+UBoK?=
 =?us-ascii?Q?WW20VIZa1jgWjv68vkrQZZiKTfhUjBxZymIWA/0E6zR4Dcqh4E4ePYhXzpev?=
 =?us-ascii?Q?sASVunM09gsf1LY4L+FAO7HqXpZCP8vZ9uVsXCGedIw9xzVh7iX7xqd6/h/B?=
 =?us-ascii?Q?a2N2GUfcdddcVkl9EhZB00wZFqJ7oij/B7FDWkmHDe8KPP0PHBDmBtdEgPPO?=
 =?us-ascii?Q?MTSgC37VBFx9X+cMqyKAdOyubL353Sa+MWuWV0VTXQKUfgaKuxrmhICpXXIk?=
 =?us-ascii?Q?67vjuaL9NPSBwgSmjo98C+Zw38B+JwLmnhWowT6AIVXh120+PQV04HI0NuHu?=
 =?us-ascii?Q?GwhRwPDHplUwnTwVjtQPP/12PMJNVzcK/q2GFrZvgBS3DcIct8uL3IOfdP7m?=
 =?us-ascii?Q?m4VxNKwJ7RLOANCPf3qajGO39/AnJug8g7o+EJQcAxepOLehjjEk567jIlYy?=
 =?us-ascii?Q?fapDchkvsTF+d2B1xIybzebx8szXfcXGRdaYNmGzSMUBJgv7xpYp8yDcqTrK?=
 =?us-ascii?Q?hy6pcHwCat/CDntzdO196gSCnkzW5dSoO+YEc7xqnXv8QXAJlpuQ6+Q2btsv?=
 =?us-ascii?Q?Gf5cni4h4i2QT5ZUlxcCjlOioUGdfSgcGg2xYF+z9hUY8dt58pwiuMA70SEo?=
 =?us-ascii?Q?Wk4gsUWU+4oO/WM0AGMMq83uus9zoGTgucWb3nBNSluVIaeVsdtV9QdbET4m?=
 =?us-ascii?Q?ZmenjVt13NmHvXyL2LwNpSOPy/gAceKgUcEObAzWGzLsPfCIM+nf9vtYECOp?=
 =?us-ascii?Q?tuwomqJ3M9VAZrl/G6ATUawWcguKKvYGpoKKCU6cg/hLbVm8J2653gjv+YIq?=
 =?us-ascii?Q?gg/FRgFDDCEfK8AQwK+0raDpI4bju0hsDWn/ysiQfazrG2Ro1al+bZQLAomM?=
 =?us-ascii?Q?urEn9NtYXTOLTZCjWFRjErD4LXb4Hkv6u57Iu161OyGEd2EWH2YuzatoTnj5?=
 =?us-ascii?Q?EW3dYTkHsD0Eztzimq7emYJvgjHRq5EfmNxOi2cIy6DKfZnj6EPI6lR03AD9?=
 =?us-ascii?Q?IUPKv9FDfyPWSYzyJ2gm7B8wtdXIohwSG8ZBWhg6oVxDgi4UMFrp6LwLYHiu?=
 =?us-ascii?Q?jnJMCQUJE3skqj0ywwXIYylUUXAarSOKRKVJ8TeaXW9sNAaCeZG+DqBo2gML?=
 =?us-ascii?Q?46S4DbRbKFFgAfKBXpqF2jTJBMwe21OdMI2lkkm+9KwS2x2VWvwz6odecQsZ?=
 =?us-ascii?Q?TbLAilYO307agc6xW1+WWqn3fX81z3TX/87hr1bv5keRi5JcKKupJY4P3Doy?=
 =?us-ascii?Q?4xNS0MgCYpOw0n9ySBKNn9Cs04aZXh740VAICKaePrHWQt95qKFZtY4ywzVo?=
 =?us-ascii?Q?tJjfocw/FtsZg2nSt6Z3flC5wm001sJ6rXdta8xzlAjw/ew1JhdNtgkM5Pld?=
 =?us-ascii?Q?0caSKaovb/rwHzSYAi0oV9l2wF1O8dbJBsQ2pKP9IthDCBOV4cSr+HXEmgsM?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MB+18gNOvYE7wVf0oSjnmqtumPwaFKQ9eiTao2bX7mVtYMiYh5sYRPdMyh+r4DHkvuSmOs8EWxoZRLiqMHelRtWNsChjHK1YwPe6DKkiO/U8nCCeUMvagf0UsXW/Y0JjHPl+JCRDzVHqzkl7C3ve8dVjcbLkKMK4hq2EEC/NAT9cUhYMgoTlOxyYC8GhQyCu7RlVn+YLU4S2ERUeSX6qtsN1AUFLtD9BIT6uSX2QUK+UDBuozEuNtNhGTalULNFw3h+8QSZAZ62ltyc/s8rZH6as90CDYVsyfHm6VolKDhIIZ5i2rvOs7weyRGBTsoTr9O+T4SgKgUB3qU5n112MDwWAoEF+5hRE0vvObYaBHb3vYp354iTSK4eOuBSrN1capw7fgfvQycMQ9nJU+EJv+90oWFI+Rpsy4b7x1ipt9aZWseQXWoBC04izoPUhMCwQGesW0VMkHUz6h5hHltt50Cbxxju55vAuVwaYQt6SuxZtwqZk4oYGO0E7iSMPeG9B6wXxPXPJlgFh8ykBI2XGTilunxnAOHcalWuAzQiZ3Ru+vkKhWoFujtTuJMEdeTKqYOD58uyBgnj95WJE3jscGcesan1vLOBCXuhi83PVCOU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd126cf-140a-446c-7b5f-08dcbd043180
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 08:28:08.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPHfacNYya5cFeF+5zVfrzQ/FFtLFIdbucLpODC5QfH8VtgpSk1MwRwxwZUWqxjzOVDSCjWrpMfPppwBNeeKxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_22,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150060
X-Proofpoint-ORIG-GUID: BQ9cGp4g5Wc9QJlLuQC3Mgyy2dT-mHK3
X-Proofpoint-GUID: BQ9cGp4g5Wc9QJlLuQC3Mgyy2dT-mHK3

As reported in [0], we may get an infinite loop in
__blkdev_issue_write_zeroes() for making an XFS FS on a raid0 config.

Fix __blkdev_issue_write_zeroes() limit handling by reading the write
zeroes limit outside the loop.

Also include a change to drop the unnecessary NULL queue check in
bdev_write_zeroes_sectors().

[0] https://lore.kernel.org/linux-block/20240815062112.GA14067@lst.de/T/#m14ed5d882f9390a46cfe2fcfa2b51218aafbd32e

John Garry (2):
  block: Read max write zeroes once for __blkdev_issue_write_zeroes()
  block: Drop NULL check in bdev_write_zeroes_sectors()

 block/blk-lib.c        | 22 +++++++++++++++-------
 include/linux/blkdev.h |  7 +------
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.31.1

