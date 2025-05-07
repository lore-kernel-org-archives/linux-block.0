Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3B2153C6
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644155; cv=fail; b=Q7X+v0nHWYzvEmDScVdvUfIB8aIw3mscKxmbdt5a/sU0nAhuclxTXV+y/1mkOv8rt7AlL2Omzswm4XTB/eFUTApuWzrum/u29ox8J4ICGc4RC+CVKZNrxyKqgjJp/PkwLGzrs5ALiIQrzAFQ4bqj2hnZhAJJ92jc/l/VYlpKcOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644155; c=relaxed/simple;
	bh=TSwHaDoLKPWijr4wEdptDHUdVLmvruXWcDk36vcCoFc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=h0KcTdFRXiXeVUL9w2JEzLpW4aLMRmeEFpp2eYtwJ+WGMtCMpXHWp9i7ai5MbGJvygcqFMi1wC9SppvrmorQdfWmznv++5+RGsCblsSK6CtF+glmgpTXC8S8ICCZxnKXI7zYE9Yez5QMt4wKUSWqFB44UAR/bRhFb+Ko3ut9x2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gqMGtRg4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qpx5Sh1m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gqMGtRg4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qpx5Sh1m"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547InWkg020252;
	Wed, 7 May 2025 18:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IFoBQMExB2eJdQvoKY
	WCP6PWnF6DJwaD9qUGAbe4Uxs=; b=gqMGtRg43Vh5lnVg0lcvLae9dd7N6k0PSm
	7dSlCL9g7FwrzM1g5cYY0+b19Ut+lwRT47Bmf3Rp60uU/i/A/zi0z69vVIaUcchk
	UeCLL4+N/zb5vGOH5BZbegLRYQ8FlKrr6W8HG6uAaU4c5BJ0aDuSYrbjwhTeYMs6
	dGyDfXj6JunedFcRuTJrfdORfOyP3pVZdPZUoReoxRuJsTW9V/ZhJ3mDic9+mX5S
	6CrtJkXvwMtri72Uqd/PCGL6E5h8QI1kpnL0/nAHLqp+nV8iYvbvJm9D3V/pVVfM
	VzF8bjR/kstFNnSbft+mZ9z/XxkDqXvpuh7bCWTA2QNL6aWHqPwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gcxx811s-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 18:55:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547HHpWC036131;
	Wed, 7 May 2025 18:42:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kbh8m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 18:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+5otXJoKfrrZYj3PJkInoUt5DCDdsgxYt4CjLL0JAp526DJGe7JoigOa2MKTv8s5syvVU0p0UAwzGIK6cXkrsJHvqR1wEOy6lpl6JsgSnq37b+fOrOxMUmwfiiN+RntCvegXDXm8mjHbI0nECu39Cdg4xPPLMQ9EqIWLcFRpOdIX6Abj3WRbh6OxulaA/rhr/Qvjh/VsZN2RL4lrghF219N58qOWJTNaiyqAVa/hVW7B+htdTiaGRjEZEkw/wHIPqGWCQZe7WHEMXNGpShr+A02+YKEdpkXp0zhqNA0lJm8x5P2ktG86mqrF9ZP7jWxDDKBD96354iBOJ8xdI9WhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFoBQMExB2eJdQvoKYWCP6PWnF6DJwaD9qUGAbe4Uxs=;
 b=hlfHEKcrrA64inRBHnAtmKZjKapaNqolzpcIodhUVYk/df757M1Yc65eMNlUFlkPVGaWzjdYmH9rOWbbMaYhCu9+fCaw+D6xUdhzirPxUfUeX0QvB4qrInrlEyHAbFM1ufjouLhqmKEtrDFbPzEK6+vtFRN4rnYtFi0ONyPEXq8DRwtzlO3Lm15V9Gnd6BGQsecgvNrpPGH+ubyEV4qmGgd1ZRPxjK8VIvQJcu6yCw10BZsY1OqPvM6ARTTem6XCYevqx9AVgp7wrIHbbltxpDaVdPBLMK48CgTclTCEKaIC7YNC8ymRiOsAjuKN1pgeHuF769lFCtT+8ZFweqCE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFoBQMExB2eJdQvoKYWCP6PWnF6DJwaD9qUGAbe4Uxs=;
 b=Qpx5Sh1misA/YVACx6Ov4e92zPSxH8uEraV+ppRWHkPzKm5UHYU0EPzsv7pOxha7lvldPEjGN1Cz+S4+mQISv1ciyeIRvqLvjDHxjb3LMjF5v7K+FhyWMmMbmvWi/bt6Bhk9fyee+T1Ysp0iQddmpTLNNyfo0cbeioVwtj3rwc8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ5PPFCC3E08AE4.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 18:42:21 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 18:42:21 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: always allocate integrity buffer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250507153759.1199895-1-kbusch@meta.com> (Keith Busch's message
	of "Wed, 7 May 2025 08:37:59 -0700")
Organization: Oracle Corporation
Message-ID: <yq1selgtgao.fsf@ca-mkp.ca.oracle.com>
References: <20250507153759.1199895-1-kbusch@meta.com>
Date: Wed, 07 May 2025 14:42:19 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ5PPFCC3E08AE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 9278b42d-b1eb-4180-3671-08dd8d96e6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9zbQJIZ+wY8eNSc4nCo6mgPqwr4RvH75hOhiAhXlYFkMFkNGD62pRgVl6OQH?=
 =?us-ascii?Q?FVfZQix784cReW6dRg+8GwAh7SnDg8G6I7z5iRimletV9ICH8zD5rPnZjGPa?=
 =?us-ascii?Q?D350JziytQuWu46q3/6/Rh7mVzVQxqtBkuB9Omi7Jsk1XWY0s8t3Ewy/yQBO?=
 =?us-ascii?Q?BtUbLqnM3N17iGzJjXUh7nq55+mEEWeNhVTg4H4/7kjRXg4b/QT08hhqz/tE?=
 =?us-ascii?Q?ion8Owag4+BMkbTkdqSHaF5yggI5D0SKeToGfHN7sJS8SJtLcZLjfPXKK4yO?=
 =?us-ascii?Q?NsKNKzcKll50XIySLOhoSUEYsUJ1eqEtGBzNVU5RGgYfWlpG6bUXZyP87eSJ?=
 =?us-ascii?Q?7Bt7A+/baljSjYXyv2YR81DrGO8lb/a1zbf0sY9B5Z2fUonCchMlW6c2sfao?=
 =?us-ascii?Q?XsA8Ggn6Ggu2YUqDiRdwKVO4w3TZo8IhI8EkY2LCY+k25zrkZeKGcoER1fcl?=
 =?us-ascii?Q?MS/3zSJmC87JN+e/2y8fFjU37L+0gEktqATG+xS1aQNKgIasujCxLUMv+gJT?=
 =?us-ascii?Q?J7Z7ovBFAfHMVyRYVhJXef2ObXKkYxHJXZlwIVPAd6fvP+djpDfC6XlHiJhZ?=
 =?us-ascii?Q?kauS0GrWArjGzEgF9gFebBp7CDme87IVp38bjfqu9fpO2tlQ3jFLBaxKaXBd?=
 =?us-ascii?Q?Mi8yghEtYtTFyvEi8p02bIAiYJ8Pn5vEXaWe2QL1ZR4zh8nZp1SMm9Z/iS1U?=
 =?us-ascii?Q?i3z/ndud8t0vsY6gSHMU7PDXo0UBKkdYGp64i9h3PtADOY2DfJjPfShIfWPo?=
 =?us-ascii?Q?KFi1uSXoLNuSeHeujkwytbOliJOfmxFwRtlVT7ryQ3OVR/GrfnAHWxzNG1V2?=
 =?us-ascii?Q?lcnYNkQxEe0h4rCi2ybJJW3DSgHijMgdWmIIi2QMOYmdLvKGot5Nd2jlWdhJ?=
 =?us-ascii?Q?FfI3KfL6Upz+tU6QCT2lT76MrAjrlWZAZbvllwqaDpfUaj+zP3qmEwQtahcq?=
 =?us-ascii?Q?N0z24bjOzgflrzZl//O3HA5eRoxQKRWKlU/f4suulehyGdvVKLqoYs2saW69?=
 =?us-ascii?Q?eWYLnlJwnxg3tIsD8PmINwAmUvczwRXSbzxvOYR5bbx93twy0rF4+McSs/Zo?=
 =?us-ascii?Q?wCMLdfVd0sVjbFj6ATCs2Kj3k4vPlSbEPSYEEYjpmRH71sjb1WtQOjdHuVni?=
 =?us-ascii?Q?UsOThNQn7sLx+54djPII9jWYKjMJj1MaZhSU95hKp2TLemi00V6ZIqL3WsoM?=
 =?us-ascii?Q?aW/s3BbRgW9C0N3UrwHpL6DEhSz3KSFbw6sYUblf1eP/BwfPRxZ2GpqKa04d?=
 =?us-ascii?Q?WADPwR7CW8/viKUE0d2tct9IK/no/jsvJXDZE6/uzKKz/f+67vqyrJ0lDI1K?=
 =?us-ascii?Q?6H+O0aag7XD78F23lPyW/HPT62jqy5TOasogMh8l3rImnxatHvdvHQH0TICW?=
 =?us-ascii?Q?YDvMDKBwQo4zf9PleOdkC2c3TG0dIsfMg7lh9yA96gSfSstdZuLEWIs6ojWt?=
 =?us-ascii?Q?YzwuxqRVPp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/C/5lZeVcjWXrrNt08JrfikGrjlSaTNys3hallDi9Ruj2klNsscw0lcvH1n?=
 =?us-ascii?Q?WHF79mLJ4a+2zPdYAMP4iN/RTmVj8+bU6z5nZQb0jWaS5KU0NNnRVzL82W+u?=
 =?us-ascii?Q?1rQ6m9dGLpzZINDztDAeoidOzTbDWT8N2U5ZE2TDLznGlWHFTI/hwipqZT8R?=
 =?us-ascii?Q?wRl/EeaMiZK/47zrGAiz7uuSaFO8BrZAxMWFwlZwWhMXnVbhdmBkPUgLS3rE?=
 =?us-ascii?Q?oKRiBuG69Ery5A4yA+7jPFFGb4WOtAthgs+xgKKEajhloXU6Nrib64KCS8/l?=
 =?us-ascii?Q?F6sIprJagZnMLcOF6bi3fjYrdLV6T9eeMttc6AWJo2Iv/N8Zjqt9qZCWJyj0?=
 =?us-ascii?Q?WYu+0wcQTRjSxKBQhRRonOYjf+HvXSNc10ZTGlG6E2oc9QxkZIGHOBjlm5rj?=
 =?us-ascii?Q?wbdPHP32FT0gR3vnrj8IaFeb2wSfE39skjBe6Q/+WcUzKlPYj1qfq8KOvR05?=
 =?us-ascii?Q?+Recmv9O2s/6kmRdipL9cECjvWv3u0KpkM7d39TTbWKCCjYodGAvpCsTudxp?=
 =?us-ascii?Q?moerGCn73BOvwQBHTBM4iGfVRGWYmwyvy4OHGANx6b7/YsAHOdmxB7UHaNQU?=
 =?us-ascii?Q?/RGyRnuFOWvqevF/RKfoX2EPIow1c1UfO8XtEHaJK8/Db4XpRPrsa4V0WAmW?=
 =?us-ascii?Q?EPntZuUf767IhR+DBqWTKJZW+HttIFh6azJt4KbxfMq1CgESpUVfrH8IXUYH?=
 =?us-ascii?Q?dZBzPV0wJ69Kk+hWEh545SPsmSU8cEX1DJ4WAaL5+9yYrPFlIl7S0uJuCKBg?=
 =?us-ascii?Q?GnjtGn7cH9edzFBceMS2uLYVIjfQ84D3URZRfzErikR/3uztXieu7OmGCZus?=
 =?us-ascii?Q?tvKCNkBYpYCg1QhG4RnwTC0ouLjbhRmZQebYNzajIwJhbVczyB9FZXXOm1Ad?=
 =?us-ascii?Q?jA1ofMtS6xxLtPrmtXHDlBp2ccMixlSmyS92iZJEPBDSNHrChPJJ/OHPHkUz?=
 =?us-ascii?Q?JQiQNrTCjEVeHCg07kzV/V2ogR7JnHhNgcVN/jO9lAi8wwWTLH8aJImcdQYL?=
 =?us-ascii?Q?lUp9LDEeZ31NlObUjuvHRg2835F+W/mJ1vzLZsK/3dbcCyV/b/uuuCQAfRBq?=
 =?us-ascii?Q?f0KW5m5m3qLu5IZ1fSI6PD6g31c7b+dVnKuIA5xe3LNGFssEzMxUoFh4TLoD?=
 =?us-ascii?Q?1SBo2B5Ylvg1BdYPVBr93cKU1FO+a0f1rSUlJrNMnREoQNVqXBv6kuJYp5s8?=
 =?us-ascii?Q?DV3JaAPP2ZihzlBHsOncmFSrPy7/gLmcXzcgIiHTN6lAW0J9eArcd14ltArQ?=
 =?us-ascii?Q?pI2GIsXBAnh6eNGs3B09HAMOBdRRNJi+MXYFE58H4Ps1CwzYrsGJDJcqVWJf?=
 =?us-ascii?Q?YFf5vMUzkIpNE1xpdlhvsf6is8IEMxQHK5pcywPJiDveV+XGr6fz4RDnsscf?=
 =?us-ascii?Q?QzL2CJOepQQaWg9+0B+6fB2S+8W+FUCsu0JL4uZ1V0X/bip2O043rvrRoyZq?=
 =?us-ascii?Q?0bFy9WwHbOQm+ftsCIbTbsq7TnZwmkCGAoanGSHZnMMwIOaL9f1quI0VX5nl?=
 =?us-ascii?Q?qFQqosehWuQjM4qVaavMNQHdirLFyu8sHFyffBb6+QXEvGT4aexm4iPbh6Zd?=
 =?us-ascii?Q?O6+P+ONsYWRYxABeHB9y/pm8TcXQg/tL81pO/Y/oi3BUtf+LvzFercZSHp9w?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nn+2ZWiuoALud6DenbQBnEbQoelpXsvfl9IgWYdAEVgFAl/BQL0W1ez3SOY21AGJfmeYOu0GHfqUSIUr6CMmP1qa48Z0XuaisJFxIC4D6jsqPcWwbik4ZvHc7Aftap1YXb+jd04uZ+Uii6x7w1WXFnJzAK4cWhy6c1zgUZ/bnexlX7QVFdG4Z6rX7wvUxhJlyjTa/7KsiHUjlyaj9u2jPIkWA+Ff6EWYcYa4ad7+G/BkGYZT1oGTfZy+MJ6lHLcQGp5JO2WgQbl634aBQ+QteEPIgEkUbwpOnOYrlWccH/XR+x6uR0q1njxt6IR55hlirq2gnGYU6oWg4U4vhvhVdKb+8VBhfYgBUzd2q+Jqm2ZU8P4MzvaRkdUaRBEErHX/0YmfdPvrp2bFXCGs32QbrerfSoqODrw7VFTLV7jZRSfVVT7TqBYPmeyhaZVCZiMMu81ISHzgc0DvYLeLD+YgiIggQcI6vng+68ShstJv9xnUp/NYppr1pTq8ydgwFkk0XxSJffkP7ev1XeqrZc0M3perRyKNyw8pn7JdxlR1urc7xmCKy+H0xnkcUMoDW6lYvLZiALHGYq7m4Tys0I5iHweWeXcFoqaaZFAOIi4xq5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9278b42d-b1eb-4180-3671-08dd8d96e6bd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 18:42:21.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0GSvZLpbauBKQTlcLV1G4IHi5L5f3ea1nAHrrKZp9hun/n0vQIsDQcdIUH1jxeAI1XSsO7vBFlKR3YAxtbHagZINXWlDZf+zsccNvFv4Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC3E08AE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070170
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3MCBTYWx0ZWRfX8OMMIyAlOAne OZHpxz26rJhkkDFUgSfvbbLsh0qjJd4xSDjO5/XHADRGhJ7WFfQhzIcdp4oIaYpqIVaJrQeHZzR zAeGeDg2NAg27tuZ4rg0Qdmz2mNiKnzeoYXKYohS2MHaBLoc7cpjcSIrO2nmjCY7w1xFrvv/PZ9
 qvW6EAqT6whAMNifg/GE+vyR7/qAKNIq6L7d9zxJLnvdLsETp1REPRHXE+bgZ39b27oKcYVWlOH t5XS2KRdWqbYq2kW8JYie5gjMNEPr8Yvu15Zj7LEJdZEnB1rWExtn7i6/R+YPb/bHoyM7N5wisa Gs5QKtBPc0By4U2D96JXMqrhUNoSGU4581R7EGPjFx0tOM8r8EA7OzSyZ/EyLezqB914hFPwK54
 YpZTEfmZgaHKYEBXs690/G+VSGHxKTYbpVRux4I6eCd2xb8hnUMzpSPJc/WTH9IsNPs8RlxG
X-Authority-Analysis: v=2.4 cv=feqty1QF c=1 sm=1 tr=0 ts=681bacab cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zO3xOo_Lllvy5o5VCegA:9
X-Proofpoint-GUID: pgEEzAuCE9pWr958Tbn0Wg1tXy1Pf2lm
X-Proofpoint-ORIG-GUID: pgEEzAuCE9pWr958Tbn0Wg1tXy1Pf2lm


Keith,

> The integrity buffer is mandatory for nvme formats that have metadata
> whether or not you want it generated or verified. The block integrity
> attributes read_verify and write_generate had been stopping the
> metadata buffer from being allocated and attached to the bio entirely.
> We only want to suppress the protection checks on the device and host,
> but we still need the buffer.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
