Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB675816;
	Mon,  8 Jul 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430248; cv=fail; b=fF8T43VfDA8O1S4tibsBLOWyJkP+5xVGUGlmSfrNwT+JFsx6+qiUQ/nrhSSMfWYIEUGqvbcb7xWirnndjqB1urR1kpJjgj464KsfX9xpWDYikOzOMUUR1ONiHkQIwr3BKhdqqzJZz3OIYu9ic36YKXAzbi25f8F9bgzhMakbdnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430248; c=relaxed/simple;
	bh=Ao+LYfLnBtDukaK3ZQFhuhZ0F/4p56XpSXcqwn6rIcs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Mzdq/V/ScOAEB+negH0wCCAYjNXAYCR1lIGYP5N/Pzd8DPh9v52KoC8Zxu6/14aSZRon4W/h7IzWSUQnW3a/g4/CVwFs2JWxtB0rUhF/hBpyinW6SSH04XNYe4b6o2AsOcuyzF6/HRjHE9C25PWk/vUoamPTo5vl7qq027GrEB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CAdqGiP4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kTg0Jv9s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CAdqGiP4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kTg0Jv9s"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fVcX004189;
	Mon, 8 Jul 2024 09:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=oLKZFO2TI0dlIC
	277jH5LffnMIClYMsIyT31ttZ254Q=; b=CAdqGiP4daV5Q5qYou1QUrshuqE6Ut
	nHybLmAYT8VGz2AXJl/9Kv8jDhZzRWXh31FFbPhYA56Zmb1aV5k2B2+wDzXH49Zl
	9jTgxvnsKsWM418H55smCUNmpGS9C0cfqtPxIiBecxSSxtH8gEo5TvW4EGXyVloa
	xoctvq93sLO3YFE3XnvMmai9tBqvXzzmb0OAOrs5BgUWe1NCEoLRkefZl1DilUxL
	+htdMVUuocHzkV/zkFz1Md7uWn25ETY6EsPlNpLNoxrSyWepDukx8D+nWWfoTf+P
	XoeODp1+jFsHhnZG/nLysQw6Eg9wuilH9IPQzoqmF6uYFRuk62kjm3pQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8a5tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468787xF005017;
	Mon, 8 Jul 2024 09:17:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvbvpeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpO321WbViyZhgTvW+VTmU/d0PN/DsAsmf34Sx3AKPNog8gPDaVuvuyk5KEEsp3Yq/V8PXzyz344ZFMozYrSz8DZHTvRCk5qh188cVxhqg34+zjiSS7P2nGVfe9115YuIn9c4xOETyxTxGxav2pvh7jv7F1Vg0TizpMvnMfZGF0ymvMs0m2cCvA0TjE0XAN3qAB+8M3bbL+hphIyRa5d8LAXgXOdPqbFuvE8M0sPmePGiFWNbUJfA2zTBrTnffEHof1TQG95couMSo6dW54HgahUmMJbDjXxdJ0BgDiapNqcTwtAE1Ud3tkX5o0W0yiw51wWumi6kaSrpgwXVVYhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLKZFO2TI0dlIC277jH5LffnMIClYMsIyT31ttZ254Q=;
 b=OxAX9+xnwcPl1MO5ObsHqPNgWISiv8GNdfqJRPHXHIhimfV4dtsTZpugF/rsMk10xVsud7aXPdssTc1UZ9rL55TX9GKIns5TPWdWqH2l3Rcqs0iCnnAVYSXdOWtDCIARMdHJHINxi8J1sxfLH4VKt40QytIg5LLN4NMq76neOfdhB71litQbSegcQAMwivFe/wZXxCFrrEhpMzumvY6xhTXAVydU+WIaPRgbrdqSgyXMv3/uLZ6uwwHXFUYLB/4wGmMUnP6pLt0EZvM+hxDi2vL/zeaoyfZyUL8sV0bi5RU10tK6kKgACnVIK6buQKGod0/9P7djTDkY1zzWe7sC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLKZFO2TI0dlIC277jH5LffnMIClYMsIyT31ttZ254Q=;
 b=kTg0Jv9sN6HyGcmClWhdzdmimyRhyBlRzkS3+7/YH2AsCh1qQ63B2Ng+1I7sNfFk3j2igRc0pARWxF03tcsQ/w4Urq1X0QtkFoxbDy7DWWhhRRCKt4T6CS1v+8e21JK4oVmUwZgl9Vc1Q19DEpOF15YneB07J6mZH0bKyjY6veE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:16:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:16:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 0/5] Validate logical block size in blk_validate_limits()
Date: Mon,  8 Jul 2024 09:16:46 +0000
Message-Id: <20240708091651.177447-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 8994f060-95c4-4aa7-9799-08dc9f2eb7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tMMBPNMQcCORfNqyPJa6D+pf/cHmDqtbNU8Hgn8WSD8r9uwbfRg+Tvbzh3Y6?=
 =?us-ascii?Q?VO2X7/hzTJlTkuNclfPVCUE3EgIEYet6xAzQUzD2316bCRqZSN9UoTRWAeyb?=
 =?us-ascii?Q?Ed7xwdb2GheVrApR4K6v5D8EHLqh25jI2KCVfQyaa26/y1BbNfdc89+JFlAv?=
 =?us-ascii?Q?DlkacUybwot4UULeepKayMhyV/H/moiLVlU01RPCsiG9Utu0m0coEEBmS/Kz?=
 =?us-ascii?Q?bdHNRjGZ0qCzgjZJj2E2teP27hpntx3uI5GvFyaUsgeE64VBUe5oZfCox6WA?=
 =?us-ascii?Q?rYIlQHZsrw0KWh2rSRd9y4fzwlRd90zbQSDqWHNHBl+oS/e/4Y/1Lu0AyfwG?=
 =?us-ascii?Q?rik1DKenYj9Bt95kcBdSkdeT6TF+uVd0daRB9vx8BtJvzXe0MWLB+YFdEq5q?=
 =?us-ascii?Q?C+aM9uXGI9VzaqboxLgC32IW6J8ATy/9QjTErmvBMXL8nqu+u4z3RfoRvfDN?=
 =?us-ascii?Q?DeNkea7aJ39ycKspDP89EZJv1qQp70Bu/EvfDRXGyqFrpyyfY40p38d1fqq6?=
 =?us-ascii?Q?2PZaQV7aIp4R6bYJjPURW1N9XYG/wKpNCessWouEnE+/JmTakmXU3SV7SWP1?=
 =?us-ascii?Q?DL8SyWghMAsNiHZiELVbmykU/NBgXnc9gJYFQlaljDfCrWqA5uwp+pf3HiPl?=
 =?us-ascii?Q?XF+vuelJfEggdGhmJGvear3aBGtj5YMt+78a+TDeWZ6A6iy1iBLKzcZHbeun?=
 =?us-ascii?Q?Qk7X+Kqv1UolQdZvDbDvCKA/RZ7rGeq05H02m55RVB/4szcBkU4HtIheGBhD?=
 =?us-ascii?Q?8wU/OXoHMHDEGVfIhCgQsg0lCwvzNq8/Fg9uhPNAsZxOJ9fO2QNkF4861CIk?=
 =?us-ascii?Q?tW/tvYsc2NxpkTT05tsMnirQ1a4a/weZMwxilGFa5iwQySkQcKiss+g4yZkC?=
 =?us-ascii?Q?tBvJ2Btm3O3yChlVxLD5rY8N0wns8GajkRB+eIQ1CUOL55uM5ZGqyW26iXhU?=
 =?us-ascii?Q?iFr+Vsb4Sz/h204RRBHrEhQk8JQ66ZEpHm2TJu13c+gyB+eRbU7xYjRSZaF3?=
 =?us-ascii?Q?Z2jL8ZSLcqzelHmtr+UfnNrbYaduT4KhpxkNGRjQFHketXUx6vsOpgjVNsCE?=
 =?us-ascii?Q?6U9H0DyASGPD3iyVDpDoTglf55Xj1HxHkWfsLhcIaXmlmoYq3sZmOWONS6co?=
 =?us-ascii?Q?v6PRaqDxiDR/vcrRqMLB69JhP5l/thNVRsNRgQWduK1uezeE0gIT2T6/D9Gg?=
 =?us-ascii?Q?C0O2VBDf5hvN00VJ2ktD5dm9XLYxgOqEAa/bCgm4t485FKFrt1NRbMI5vqc+?=
 =?us-ascii?Q?dOFAtc7YNWUg24v6MGfFZV/qWjGlMEJ5AodUQZyRWuoSp2oFsn3fUprbjDAF?=
 =?us-ascii?Q?JfUoVY9iL/ETgNNZOFeTFwtWEqrTsOdt02QnaIxbZVBpeuFWIeTz3wu9dGqQ?=
 =?us-ascii?Q?4CeoB08=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ndv9ggxNamEH95Yw0JGxShTGhfS79a62Ntj3eycq10pwe9X/JjofOJ/s6JLi?=
 =?us-ascii?Q?RgzCxc8pZzKqag3wASMWgmfRdlF7YGTRoFbBZKzf9QRt0VdZT900+G4uC4PF?=
 =?us-ascii?Q?C+p5HD4Vif05VnHqnpZyhmE7dIvLCLDoc+zCPTFy1QJil3XM5KIcOQzzog3q?=
 =?us-ascii?Q?33iH8ma/nqsEauSDK32m2S9T3/REeKxfTn1w8wxG+JMJqGp3i8vjO01Udjt0?=
 =?us-ascii?Q?40fQIcyW/LFQ3hBWDqQm+rdoGF56tIJu3gtCQ8YDwkGgL3CEYvvBfIPO/R9N?=
 =?us-ascii?Q?3+/MfYwE39A/0PrSb4D3c92RrE+5eNMRp2YHAjHRwuzumWPkVWC37LrlAip3?=
 =?us-ascii?Q?RnoQ4DLVxNst2TFOx4pfRQ98NRr60cqDvjtL0rowW1ptv1NXvnFKIX1HKIfG?=
 =?us-ascii?Q?WAik7F+99SWzj4/yWG95Vqy9qsKEZ8P0GSi4MMeclWQZzupwZ7J5PZgtgVVB?=
 =?us-ascii?Q?pZqXkAuIzPcVhCoOUO0w42/HxEY76Zz1zOfq2k2avee7+nN955AIDEfnpDmf?=
 =?us-ascii?Q?986zSvC3XYrACMl0umsrnOJKs5LONfl1Os+Lk1o/yhbX60s1epnurs9O0EhO?=
 =?us-ascii?Q?sDvvBvSi8dC92vMZcOyWVEd0/8H/i7cLaKiv8FRM6PfislqnjheLLroN5e2y?=
 =?us-ascii?Q?YDSU2L+Wm9i/6EsXGivs3CRsi8StvtRnqxAm+MhUv5uOKtfYP1zRvGA9TjbA?=
 =?us-ascii?Q?koPGDB+kYxO5N0wL02hFfyxeYoTSKwytgqQuj8RSdWQa1VYU45BV04OaoY5h?=
 =?us-ascii?Q?OuLKMxSR9tSbM0wHgOKjSFsJ0Tm5xL7iBLDUMapdqG2SbUJPaQfPQuQlCY9S?=
 =?us-ascii?Q?UCDuskGcTNEZyxPGIIv/xqhVC1LTOZ8GYQb5tvdZB8N/1Hk2Da858VUDln9h?=
 =?us-ascii?Q?cj4qIfxdEN4yfYhDWYITJ3gYld8qPrnsrMwuhLRhXUwBLg/Cr9SvpkeSys4z?=
 =?us-ascii?Q?u+PcdDY8WWSNZPqaCftfQmxkPOSi98if7b1GNfHfhSOxn4Dc4aSHQU14NoTA?=
 =?us-ascii?Q?k+mJFKEaj7eMlLQIivBarGARV0ftW0LSqi6iw1aR8FFJXrYE9toDM66bnrbz?=
 =?us-ascii?Q?YL6aC/mrMM+uVZNz2tGXU4Qyu6FviaaHKl9mEiorJ/wbTWT0xc0yvlJRkC34?=
 =?us-ascii?Q?Yp7MaPhszYI86pgV8xrWtjwqApog9ZERTVKjtZ7DYBX3Ndz93yp8waqvRNag?=
 =?us-ascii?Q?7vnc04JfSMn7F7lkBpxS9xKj6EmuWulCjIgD8YrhMPNQe0y+UxkwFZbVlkK5?=
 =?us-ascii?Q?rSoo+aEr6363SWCqFdFi7zSRw6NYLMT2GZutjjDl2814Xo3i1mKs1jEOOJSx?=
 =?us-ascii?Q?b0wRYR+q2dNGHgEAtHScrYK06WWEgUwk2uP/OYq04VwKQ7T/Eh87INYXkX22?=
 =?us-ascii?Q?g5ML3d6k0wbncfiKFOflbD/0aSmSEmMyByZyM/A2TAY8HKkUJisMklilPW/8?=
 =?us-ascii?Q?W1i9R6hmurmNaQciF5kqC32ebqFwF5DFuQmhXVWcH8OP8BNu2D49aPJivkOg?=
 =?us-ascii?Q?OaqEIA+sx1CLPrtPJLkkPym+Crau6zvwGkBRSdxLTdA4G4FTtoN1kBZeUXIC?=
 =?us-ascii?Q?GfG9bSle3pq1Y8py1Q5/2cU2CztFW0LsGyhWvR4cn1K+KMRc8lb0VhSXO+zO?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ObVfI/e2In84qg/vn8mPKVBOMyecchS57kj2JyxM2RBgMUQHo0G+mYNUfzPLatPa5mkr2af/0UDRWdK931l196hkY8AjtHl+8VMtsdFDVNnQ/kNqS3X/npUQD7bl0H/rM485baFVL0l6tPfqVO4AH0apPqBYHhDABPSOynVxOGCqfYS/YdmcrUFdCKuE/Q8W9ClrJ+9gibpqkNyTdnTEhC20OVEgt3njssCu9wp4523A1QLCWFE8xwaDK5yoLj+nglCoSrgv/eSIFfw92jGCWwWPXL4kDacZz61qWcAYYSPKNMe/YlrzlwqiSe6MQfvAM7S52IysA+pZkHSm6E4z8qtAmcm7L7THcoMrCHfMciI8Ls/V4W7zdgMHDosaMdYxyt32v+qx0w4pYhWUBSyU1Mq6i8YH8g24d+dIhjlUCOv7Ur5e48PtCMiSnivOxT5TxDEAiJsFRBtV7tKKFIQnuVhIMx3B3IlKMfOQXa+GkEuvpi5O+IQpjoCikRmoJL+AZom1Ml400M0ge+TZvgwT0UPqhmoj/v9AodkBARDKE3L7HMZya4khDBbvZDj7Y6GT5uAugyutL12SjHmZ4LEo0OTzo/lhCAY4pQW4q6RPK10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8994f060-95c4-4aa7-9799-08dc9f2eb7c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:16:58.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0+tQUs7FY0cOcRLkuGibU2hw5VP+quXojxwJ4/G9FFuUgjFpvifxJsNqs0zItONd+v+JkmPGsbmIq6fXsWFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080071
X-Proofpoint-GUID: HarITWSbgwtiIm-CTNaNCFuh0J6P7GkS
X-Proofpoint-ORIG-GUID: HarITWSbgwtiIm-CTNaNCFuh0J6P7GkS

This series adds validation of the logical block size in
blk_validate_limits().

Some drivers had already been validating this themselves. As such, we can
mostly drop that driver validation.

nbd is problematic, as we cannot only change to just stop calling
blk_validate_limits(). This is because the LBS is updated in a 2-stage
process:
a. update block size in the driver and validate
b. update queue limits

So if we stop validating the limits in a., there is a user-visible change
in behaviour (as we stop rejecting invalid limits from the NBD_SET_BLKSIZE
ioctl). So I left that untouched.

This topic was originally mentioned in [0] and then again in [1] by
Keith.

I have also included a related virtio_blk change to deal with
blk_size config fallback.

[0] https://lore.kernel.org/linux-block/10b3e3fe-6ad5-4e0e-b822-f51656c976ee@oracle.com/
[1] https://lore.kernel.org/linux-block/Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com/

Differences to v1:
- Add RB tags (thanks!)
- Update comment on blk_validate_block_size() and add print in
  blk_validate_limits()

John Garry (5):
  virtio_blk: Fix default logical block size fallback
  block: Validate logical block size in blk_validate_limits()
  null_blk: Don't bother validating blocksize
  virtio_blk: Don't bother validating blocksize
  loop: Don't bother validating blocksize

 block/blk-settings.c          |  4 ++++
 drivers/block/loop.c          | 12 +-----------
 drivers/block/null_blk/main.c |  3 ---
 drivers/block/virtio_blk.c    | 31 +++++++++++--------------------
 include/linux/blkdev.h        |  1 +
 5 files changed, 17 insertions(+), 34 deletions(-)

-- 
2.31.1

