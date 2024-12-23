Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C00194C69
	for <linux-block@vger.kernel.org>; Mon, 23 Dec 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950537; cv=fail; b=G3sAcjIlxvwCvql2SePhJoKb4EEVI28cL3rTKyoXItRF4u367UFvD69QGoi2ovF4wuWUfrlYQ+zr7ypXU2NskfLysaVnScH8oLe0wX/gnI8KSxZddy6cYLZQyp0qpN28ilOEE/D7HktWdhwwtgepyjuPpHk0GjACuh0+G7+K4UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950537; c=relaxed/simple;
	bh=rPOjo+GhdkT89eT7EolqyLniVwkPxFEFk5R1yNYOtoY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IBXRtXDKttgHfgnEz10ze/YCsElUKC75gUaSlZXtpSs/h/4ZJemB9XiPqYq+RxHCezJ+usR0ptVpDis7aelaUkWsri4V3N7gcAIfTPkuDwVJ5WgJH8DtYrYLyGzB18oXpFTQrq0w5OAudF7WHFsIJRFh1tznIaKZ1LBeAs7rfWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UwbOwnHj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wzLUtJQD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UwbOwnHj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wzLUtJQD"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN8fiDf007890;
	Mon, 23 Dec 2024 10:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=7VljIvm7uBvXQMCX
	XnljxnOsGuwW7RYUzo/+1aQbT/E=; b=UwbOwnHj/xSgT6klclA6JKGd7bp6tZWg
	O7Z0ZaZ8WDT1/0Wnx6jb6SnNSahvjYYmKzubTrBkF6aIS4KbK+Q901jW1qt/0L07
	dICBe3UgtYGT8nFmf+DsdUpxhO3AqslDs/287znx9wzEdEFQviMBt5UlMoDBq6jg
	MiDQXLQnGShriqoTBvoCU20nxCmsD3OrkOMlUM8RNNOpgOAhfJCs8n96spQr4Rsq
	lorLfmavsSSw8sH4FP4Wo442ojbnJwZ7ENdwu24BPdla6ueJqaPrvCCepd56et6J
	s0UKCUb2TXRx0zmuBAOi0b1XffRMI85vpV7tfdrNpvF1242REu2dWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6saava-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 10:42:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNA3TAu001081;
	Mon, 23 Dec 2024 10:42:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8spe5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 10:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wERTmzhKPHbXwDvQy3ZQlv2my1NmC7p8rF/5pZGNtu9zrO5aun8XDB2hUdsxAMhT4LxkMilGPsf6cRv0AOIB3Dd7xflm+ftWWzYKPIypieYIq3iPQqWiBsDiLsOMppwNeNG7j9VvnHYuzufvltgCdxMO9anbRvlaPCAFF5gR3XmWhZr9xo1Ba8n9T/CV7VnCy/0EkJMziZm8hQb4v0CK1UNqQJe8tnOMqvL5TaFsobbBiPovsi42+fR7UL6es+xYTehgTmgiaRHbE2iNKQHQ0OHd5ZAVeMFJ8npdVGXp+Cc1EVJYZu2binJ587GEiroeRms27srFQHjvrTyW1ZeYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VljIvm7uBvXQMCXXnljxnOsGuwW7RYUzo/+1aQbT/E=;
 b=KWf999r+AKSMj4bqalLRbEW2ziUE48pwaA5JILjpff3Hot4OBjLOETw+lHNgJVSkeYamb9E4LQi7B8kf3RN5v8zUcQW/m8HqWF7kNpA0LwCyGYMVr8YeJ7uUh/wC4/2Ptp/JU6C6nG+EmNxa9QSEXkcUNkjYC/w+CHFULDlVoukWuMurnFA5fhqg9rUHgIIpo5Sf48ZRLO8z5++ApjpmxDyMBdk+aecMieNbAaWU1VUzdy+XZnbS9Hq2T2wfP6O+AYrc3fuvRfpHcjADPMTAV1rbDWs3P7iRBnSrneog0hRH03CLDsQG+hbE8U9Dn0eiacP5EUNhEHdx63Oy2147hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VljIvm7uBvXQMCXXnljxnOsGuwW7RYUzo/+1aQbT/E=;
 b=wzLUtJQDFod6ObWRiZzCmbeuBZ6UkdQ8gavjipiHNEBswCVpTMp2tdd1EdI5ItP/YaNC5v53sDVirCpDYF6SfpvMQnDq9fcnwVN3DG6kFMP502HWwpYX6iDjC4bwYOWjLPjZsIEnR1WRbojcTRqRK+ze8yY0deOjknJfcQEDKr8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4239.namprd10.prod.outlook.com (2603:10b6:208:1d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 10:42:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 10:42:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Use enum for blk-mq tagset flags
Date: Mon, 23 Dec 2024 10:41:53 +0000
Message-Id: <20241223104153.857953-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 61752173-59af-47aa-269f-08dd233e6ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATubxVBoXd7bGBpQBxKBsPgtg47HcLg+d6h7FEVFrsyTbDH+qTcfvOIVabXF?=
 =?us-ascii?Q?8dOjzMyY8c3/yWk7Mf0G+iSUGdsg9L2kyZOYnOHvkd0X/Abiw+HPCpzuSAI6?=
 =?us-ascii?Q?T8n/qexQvGDkOR6BHCTk5+cGWxzkJUeDSsSXyAhYqzcuxlITXNzD6IlB1hdN?=
 =?us-ascii?Q?9CwVxZt+OoOYDojeeMTc7KtG8YvhkgCy5fYbFArv5G9qnI/Uerquq9AYltq2?=
 =?us-ascii?Q?HfRUS+/XUGgelCmd4fQrzYp39NTa4De/cKAlHzta7LgoW2CvBu9b710ITLeY?=
 =?us-ascii?Q?nbKewIOKOXz4UPhw6Pe3CKgH3Y75XIths0LpsmdTmcmrORafHhtb7QFwmirZ?=
 =?us-ascii?Q?ZDqpJa5tui2ZZmhqWBsT5fgWqFZuRx5ymyVkQvpyvsbhqus1dgoESJ8lxvrv?=
 =?us-ascii?Q?kobRWLDcRohBmw0MCaNPHvmHKliguoeeRklPEprFIsC8honGWGYzZ16ZfQL8?=
 =?us-ascii?Q?k+jUt4q1HmWsl5VSkApHcT3td6gfvdTSUtOa0ePN0+neDCmHiUYvIMaq0pq7?=
 =?us-ascii?Q?ym40YgFMKdEjZE+Wh6j4KuMHmuegpMr7I70QIu48TED4yh3FkzPYOTBgLnHB?=
 =?us-ascii?Q?xCjuqDSCvMOotfzcqHWFuZf0jkYiF7EegRWBhvxvl+xDu9EOIc1CFrimvdEq?=
 =?us-ascii?Q?3HPCFjtPXpMT3gGXgVAJUlasGUyUnGHo05BZKsoaukwOqI0Bh/A/kyn1IxMt?=
 =?us-ascii?Q?oXNMDLjJtnbvAc7CQ5q0ihXxeUmkdaiTIEYP91LG6GYGINjY6f324JAEhj0v?=
 =?us-ascii?Q?KZTMV64U46LKJr8JAaW9kziIYSl8PWaZxx0r1q1d4EY9pQM+3mDROqdUx2TV?=
 =?us-ascii?Q?ssC2OC7MlpwHgziABDsg6Fo9CZJV0AfW3MA8ybx/EEqYs4KaDW7rVOaeuViG?=
 =?us-ascii?Q?allHD+y21j59fH+nLRyUf0xjgkVtQalEmiLAdUZkSNP0oCjGVMa909ex3+ig?=
 =?us-ascii?Q?g6yUJcFZKHgsKaCAEEieDFIbI5nKJ9VrK3rnsANU8CsTyK619s3OhSDpefLF?=
 =?us-ascii?Q?46uOC5bc3X2flkh0yjpZFT3+WV9FjEdWVGJsOxDmnnXzufav5f9HjSF18LtG?=
 =?us-ascii?Q?DW8QbHqKPbJDRnSl9p7pit3VZqFz/xSFJG2jTywwfwa0Kr4PZLqmh7NkjfY9?=
 =?us-ascii?Q?D+IJbQBYoCroDUREqbpdgzcZQNSs4HaXni2M2gOj3jgbh8tezkg00P4ronVa?=
 =?us-ascii?Q?qAOLzjU5kAxinX7NGHx4iIkZl4bXZ9oP/dMxIDY2BqunjXyk1ZgzMstKBo3s?=
 =?us-ascii?Q?s2fdtFehaZU3FfgnTwiYu+u9d/A8kayFSoc2VN6c8fQZb9JAZYDyUY/sMCUq?=
 =?us-ascii?Q?T5GnWA9XNpXTRQ7Ez9kCcb8MSxALWb1b0aj4D3YEiEul7yDdYn0rYkQfbh3g?=
 =?us-ascii?Q?2xAQTeaHHy2thFCUSe3bLAngqedO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfGFCYHVS6JLJbktN5TOi1Q6ac6wBUidz/gwiRCNH7J1BkF0Jb/Dgx+eHi24?=
 =?us-ascii?Q?U9Wrr9XNrhNa5HMNTHn2b7Tta16mhExfTxlrzf0CNIYeFoloqK0mWSX/gjnG?=
 =?us-ascii?Q?SzaN3elfkd9G+mkN4kVZ443hIiZrrSZuORwbmPUfRUPEMhLxYbBdQnZoAzVx?=
 =?us-ascii?Q?pNY/pIAqg/Phxk85svBg/SnmAIEezPjnswLm4TfvpnmpjnWNzUJI3BVSNup1?=
 =?us-ascii?Q?zBOVGfPgn1x5Uku/FsiOTCABDKOhfHCIVWC0wV53d8Mh62u6OdST6vs+DV3L?=
 =?us-ascii?Q?F+gScvz7JEXG1udTwBlSyR9ZPZe9J7TN8UHdqLoY2lzg5QmqqmYKJ2sqI31H?=
 =?us-ascii?Q?AjhHnLC7Ph8KN+0+4WFkoUTHajwOnHQUkJZFEYZN1D1gVO+GI+RgxTGi8SnE?=
 =?us-ascii?Q?w7M+LP68qkvSdn6cCtAUNsv/GjT0758W3+Iv6TsBISwd8Mrj025a7MEkgR1J?=
 =?us-ascii?Q?QKIEGfwLffUzSR7aQi7LMkPDVFQe0grQ0FLwjffaLN7iFzBbtc+IQdXQp/kz?=
 =?us-ascii?Q?2RcrlXDt0i/CnWS339G1hUXKVM02Hq1lfRyvZg8XM4EChvNOLlUD93cgScAB?=
 =?us-ascii?Q?y32j7h5bx1tdtV09lGJtWcebSZMkBsof9G3kCjGJVkYc51jZvktXYYhvm+mE?=
 =?us-ascii?Q?mjq6JOpkKUQVBmup5OjNGs6AuXVvsoKzcZqPDRkazQfQZGTz3llOLjrXmw3D?=
 =?us-ascii?Q?ArAt4X7CHO9YB2D/6U5mFKGI8ckRTUAbeDUyxE94Ub2empPij+sFoPyZmKKC?=
 =?us-ascii?Q?pO1lWIhb/1beal9DH6ma/5Lhe1bgQqLe0lnEt8l8q+oqEjkYEgQ784Z2gGHG?=
 =?us-ascii?Q?docbP3EJM+lyISy5wo30gFhHQzkmEr2ozRLBeMeOcceKDVJ7yxUE2FXKzN9M?=
 =?us-ascii?Q?31LR84s345QA2zhpx5W72PSSrDmv1gP6G0ljzx4P5HorUc5jZJwkBW+wfuWl?=
 =?us-ascii?Q?Tv423GFdvzJeULrhPmBt4tEFjK23cVvyp27VZSItgEYvFWPTVWDmcXXOjd48?=
 =?us-ascii?Q?4tba9xjPCQX0CJol33hg/VuJpTt6ow5PYlviO7m2ho29qyZTgs31SMLvXtmU?=
 =?us-ascii?Q?owsx6Yn0eMdSPgd3QEHSaKmzwG7Q7xWds6sxWLgqYY/Mp/GHrwKfxvkkiAZZ?=
 =?us-ascii?Q?XRYC1VYhsC86uk8ihsaJ18Ux1/XneKbaOvFZ628UTyu1IsjLvyWr3E320nDf?=
 =?us-ascii?Q?GB2JYCY7de1W1TID7ANDedGXOcZxsmfrXVk8qa5YnfK/H7Q2pkWhAmweFPgX?=
 =?us-ascii?Q?+i+4iMvjDKbJHIqdR1pQezR8M8kPQQZsMzN71iJjZhGMZQX7U1ub/1aVGufC?=
 =?us-ascii?Q?W0ibQ9VRWtzy8+Otrt+RgG+4ERlIsTmq0AnR3z0xP2hIpT3i8cadEuP/dGW/?=
 =?us-ascii?Q?+xGW9P2j43hs1W8TxfjJoM6uQkaoeJY2NFflaPwv3IOrIoyzP5tazssIfiMX?=
 =?us-ascii?Q?7xoNo6TE2E/xLcUqdHVYdF/PE+6sgee4TUWSdEEbxJPOdD1GYPYlgT2LCPt2?=
 =?us-ascii?Q?3KMjZrBRPlN/Atchyuqk8JrLpFnlh+HN9odcf28IGMdf8xm4NKlBfvmKuAhu?=
 =?us-ascii?Q?6kxX3R4gnnaB5uplv9rfbwn65oE/Ddnuf3vbZjS0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4KPuPVLg7HeqvmUU81Ja3PFZ7NsAW5F2HP0CQ8Z+lXvDz5FkR0hty2rqwtM6JGNVuY9JKJuF42f2PDE+6AVgLyOe3jt/U1sZ+4CFecko/gTQfPou1+5eRy815MZaT6nGV/TMuhLlBVa2TFn2AVUPoQZ6JbjCAlkXk2k2BvyyuxkwXucpVBuxti0fltM1rlAxsmA6hNlPpHRsW5YJc8npJ3ph8hGJ3bJmQQjPtJzaR2/DHx0NxwHvZZNHzRb5KwYjUvQwmSXB8APdHD4unlR5RpW2Wm4X/NyqyIon5KhKk/E003s/0FsFD4a46q113nq2qE3z2lX2+OpA9o5bJ4B8X9sinEy/dHBlYCzzQuBhmvrTsu1v08gfbJl4o6jOzGXLfsTXo6N55fOVNT0X8jSqNCkcMApAoGMGeunwAVgYTSaMRkOJZAxvj/EkK3iH7P2cS66hZUyqY+0bTYEgsBVFsuWonaPtcRts6YpTJhh5/hXOW0yGzfDen//r5jYvJuvOHwq97LwN3m7SNBRYq+Vx/75VP6kevnk7yHntdOD48ISqStGHmq2ndVs+GLTc6MHmgE4iOyMli5NcSmaZQ9Yhzs8IGgTeC3L3sAKy0lwAUTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61752173-59af-47aa-269f-08dd233e6ff8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 10:42:03.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNoP7LI4bsxDoljeeyHTJA714sTL3PJxa5FzjbRk3xgmztuw0rFRowargK/mQe5pcbPXYkr2TdLDDqw7J9yThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_04,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412230095
X-Proofpoint-ORIG-GUID: DabUGg55h2Od2utJLdurkisXhuNUI3l8
X-Proofpoint-GUID: DabUGg55h2Od2utJLdurkisXhuNUI3l8

Use an enum for tagset flags, so that they don't need to be manually
renumbered when modified.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b6b20ccdb53..d00f1cb016fa 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -196,7 +196,7 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
 	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) !=
-			BLK_MQ_F_ALLOC_POLICY_START_BIT);
+			BLK_MQ_B_ALLOC_POLICY_START_BIT);
 	BUILD_BUG_ON(ARRAY_SIZE(alloc_policy_name) != BLK_TAG_ALLOC_MAX);
 
 	seq_puts(m, "alloc_policy=");
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7f6c482ebf54..8ef1a2455490 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -666,33 +666,39 @@ struct blk_mq_ops {
 #endif
 };
 
-/* Keep hctx_flag_name[] in sync with the definitions below */
 enum {
-	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
+	BLK_MQ_B_TAG_QUEUE_SHARED,
 	/*
 	 * Set when this device requires underlying blk-mq device for
 	 * completing IO:
 	 */
-	BLK_MQ_F_STACKING	= 1 << 2,
-	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
-	BLK_MQ_F_BLOCKING	= 1 << 4,
+	BLK_MQ_B_STACKING,
+	BLK_MQ_B_TAG_HCTX_SHARED,
+	BLK_MQ_B_BLOCKING,
 	/* Do not allow an I/O scheduler to be configured. */
-	BLK_MQ_F_NO_SCHED	= 1 << 5,
-
+	BLK_MQ_B_NO_SCHED,
 	/*
 	 * Select 'none' during queue registration in case of a single hwq
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
-	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
-	BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
-	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
+	BLK_MQ_B_NO_SCHED_BY_DEFAULT,
+	BLK_MQ_B_ALLOC_POLICY_START_BIT,
+	BLK_MQ_B_ALLOC_POLICY_BITS = 1,
 };
+/* Keep hctx_flag_name[] in sync with the definitions below */
+#define BLK_MQ_F_TAG_QUEUE_SHARED	(1 << BLK_MQ_B_TAG_QUEUE_SHARED)
+#define BLK_MQ_F_STACKING		(1 << BLK_MQ_B_STACKING)
+#define BLK_MQ_F_TAG_HCTX_SHARED	(1 << BLK_MQ_B_TAG_HCTX_SHARED)
+#define BLK_MQ_F_BLOCKING		(1 << BLK_MQ_B_BLOCKING)
+#define BLK_MQ_F_NO_SCHED		(1 << BLK_MQ_B_NO_SCHED)
+#define BLK_MQ_F_NO_SCHED_BY_DEFAULT	(1 << BLK_MQ_B_NO_SCHED_BY_DEFAULT)
+
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
-	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
-		((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1))
+	((flags >> BLK_MQ_B_ALLOC_POLICY_START_BIT) & \
+		((1 << BLK_MQ_B_ALLOC_POLICY_BITS) - 1))
 #define BLK_ALLOC_POLICY_TO_MQ_FLAG(policy) \
-	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
-		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
+	((policy & ((1 << BLK_MQ_B_ALLOC_POLICY_BITS) - 1)) \
+		<< BLK_MQ_B_ALLOC_POLICY_START_BIT)
 
 #define BLK_MQ_MAX_DEPTH	(10240)
 #define BLK_MQ_NO_HCTX_IDX	(-1U)
-- 
2.31.1

