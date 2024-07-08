Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237377101;
	Mon,  8 Jul 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430252; cv=fail; b=etdhvdnX4UxpwauBfO2KDwj7ihqKQ4aR9WEeUdUfV6s4e3UcLj/Ieg30yaO25uAnpDNF41Al3mN6WKcUaQkWiiTKi1jLUhvNB7YN2ZVBinRYlQLnwEE2w9roOITqNSbWPmnDaM8XqhBry/z+Dewl0ZYjYzJ8jLElOzgMKb7eLSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430252; c=relaxed/simple;
	bh=Uq/bJLtSOBjRXl5cGeMNU1JHzTDkWCZFS4o3Q1Nlf08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBmt+CCzf+JDW0rXBv2AMbQHhL3vB5MGxftG+LdfRSKYBZsjLcLTMKKREYSB9fxH3+wCPd9YXpAWejSRsnPTTjOrB0UwQeHjmqJK2HqVaNjYZUBPJBa0duJ3/IKw919aJ0at+dfDqaEu8tjNo2bwCOCaAf63zlP2uO3eta49gAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIJgqZda; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GAp/O0/K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIJgqZda";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GAp/O0/K"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fSga000593;
	Mon, 8 Jul 2024 09:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=RuZnVWj9aHY6FuajPxHNvSf5ZvdhJmMHCOONsdJ7Rgc=; b=
	QIJgqZdaJBjd0OfW4r/5EmT3HlkU5JLrAGecVjQJufPfreIyqUhjHRMBbeEogSRL
	doQf4v0Ti99Yr/k9RdRUiDErsyH6ND5D/Qn3EZr5Gg0QdmzXrcx/Tl3ETxV+nu76
	YGnrhAwkdbL3753dG87yG67/1TWFIG9PNmquvITu0GbAgiO4cK+Jkg//Pe6H3VQ1
	WzF8eyC9iRHPq66ed1OqPHQO9lCZcI9vMVEJgUaSa/mPhqu942+9xOCFKsfwe0fh
	gIKsNU+Xgz2dan68ShRpxBm6jUtQIVJU+dyd+j7zsu8KUM7lDlf6OQ1JsAxlha+9
	JWFNyOolq9c5TkwynXRpoA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkca62a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46876pfh013662;
	Mon, 8 Jul 2024 09:17:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txf4x2t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMtfstz+VuUK0Rzirulmduc+4k024j3kuG6OiywZCKcG6kHLqjA8zZ5J5keGMG0VrRb6mMqda9F8mjYM1gIvPq7RrmQUTfFkNbecuuqi+LrY5ZVQtCI7+mNAgOla16bl0dOAsT6xmoRiK8y+I5zxGIRy+DIeNcuWDv7wGWvXqqwuKmrd5pJloG8dQbW4JzM33CfPcrTtZczN62PaILuFvzEqMYRbfZ4fAOGVwHQdHuZ1ekusGtSsxqvAll3kl2Are/tbamZjxZab5dLYKWKkOrmgQXctT00LXlrHMnpc89PNC2uJMGI9Z617wNFKSafEa9tRtiId6iJLNNRcOUaOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuZnVWj9aHY6FuajPxHNvSf5ZvdhJmMHCOONsdJ7Rgc=;
 b=dkHkV27+b7LZTJ5B72GjF7DmKaA+kl5i9GXmfK/OA62lHpcWXFuNOpd+n34MGI3lHG9a7C9MM8H3RNtxJ7o0g4XkrQ3xAXRvnd2Oibm+PW/YLYAet5ZorhicymtBlUeEyjVPLkVgEVPNrCeLvkNPp+H4HFHmeSIY4ybRzhMZEmKmKBYUe3nGMdlV7D+SYOiQqdek9osM5haIwHcerfAmKBiegFNeTxj9AF7tMKzHqVvaAHorCmj6khVJaqnrHN8Dm+RlLnc0VK0YYjS0ZKcMRTymtB+Du1LfyITCjg77FKhH5Unr5f8lA38nnOh0y8ppzO+jyCF0H736UtZjMqQ63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuZnVWj9aHY6FuajPxHNvSf5ZvdhJmMHCOONsdJ7Rgc=;
 b=GAp/O0/KieNWNWyeNt+yz6Zm2BHE0NqCO+b9FhhGXBuT+lZ3H3R7paqyegB85GCI55ZDkmsA/V3Txyy0PhAWvtC80gSeEd4E0YK/laazZjP8aLe6V6as6uxlgknA2pY5Sg7vqmcLSI94i4uni3tmTA6lLCqHaFLx0AZ/2NFUqGE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:17:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:17:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 4/5] virtio_blk: Don't bother validating blocksize
Date: Mon,  8 Jul 2024 09:16:50 +0000
Message-Id: <20240708091651.177447-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcf7d7c-4a24-49f0-1bbf-08dc9f2ebbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VzbYAug3q5T3qpKKbPZ/uGpjLpjb5AsySozDtEFhi3gC6DSyJPthQnXpCWVD?=
 =?us-ascii?Q?v9GNLPE+AYT02NubF32gViLqoeW5dqtenNuNOnT3KUYrru66BpxSTrzBytLY?=
 =?us-ascii?Q?EaSFXXDsesXx2tOfekns5jKKrhBe1nE7u1x0FkGHvn2kEIdTlZ9p6rfo7RDw?=
 =?us-ascii?Q?JccLEurtXKH8oxX1+va7qsqA8toje2h8Y43sgIfCMMkYd9jmjyxcRtHAYZuC?=
 =?us-ascii?Q?4iA4mzR3pbD9gZRYD4tM4pKEYk+oxza2iI7zLdGIQVqupWWUe2AXNj0xhfDH?=
 =?us-ascii?Q?PTDRe6IAYTMhUFtlY2JYD3Dxk837FFMwQZ/vNbTs/gajGYTZFPuJ0icHdoOr?=
 =?us-ascii?Q?XD6HapdcLcX7AmfDoFvalJ6c2O32cHvG3Ry/hNDV1WcZ6+YaxO4XI7LVpguA?=
 =?us-ascii?Q?WLRsGG8LzMxCfrHwG2ZMMv6McyKYQRMQwjqei4Moevx4588lxApma6TheVzd?=
 =?us-ascii?Q?5xAGnHNCYy8TsELKO+nN82hf3MLnqPnlxFZsNkgczg7DsSPtfN7Wxn6ECAwk?=
 =?us-ascii?Q?V2V8nrj/tjsRDsDgK4RsMAzdXYZnrGckr/Wgywx16XfnPb6sNOaDIFA+NZd8?=
 =?us-ascii?Q?A5PafVUzvK/DIiaiLHmYHUi+gJV7GWDhyYmJBK0FwF2Hs3sa+EduZ1kIEuxm?=
 =?us-ascii?Q?2IVSkXnyzpvlG/5MyuvI5NY571pRXErmXWqkHDaJTtMyQwdGzQXx5jFMJxIn?=
 =?us-ascii?Q?PuDEfheoqL1HtfR3CM9muTJqjQ/y2zsFHOdEeBzaTKZK4Hcklwwqy6CxqUDV?=
 =?us-ascii?Q?syqKSrsl4oceppR371EkvZuU2lk3/RfU5DE/mH94sViO9dukWsvukJgbHraO?=
 =?us-ascii?Q?+OnYiwPy72sjA/ro+ce1zc8ukzqfq77754GhUyMEug2BAJ7Qh8CuoMIdOCMz?=
 =?us-ascii?Q?NHP8dpd48tiaPME0yUd8a3TUeCcoEZaKAnh/yv7GKmtVoKcjtDCdI3b2PqTc?=
 =?us-ascii?Q?6ZxrWfb0Ajwb9vvGwHwQ2zGwIEAVEjPhx/cPyN9l1sLwOLprXSuaPuWGSnfn?=
 =?us-ascii?Q?x91jZZggKtu+OzgePjKL4v9iD2dvf4dKOD7BveKAE6ZqC9FqTqb4Oc0pp90z?=
 =?us-ascii?Q?bEX5DS0sMHHfHdSLPAh15QJsphwTW1kJunM/Xuf9LTrfS6UtNChPN8b468ev?=
 =?us-ascii?Q?tBailCTYxBfxUVO8SPal8x5X8+6dCL01gzHU+rGw0S/Kf1qCFmquhQx6Rlb+?=
 =?us-ascii?Q?if4m52DdORFbDqknmBGD3Bfdb00BJyqNc5o2ytvwzGEWD6qZPpmJo205lm8G?=
 =?us-ascii?Q?X2rSlz6Hjq9E2Z9FMlFYfChL+oPjre+wzZ04qjWvmchasvXyYErhKPjukBV6?=
 =?us-ascii?Q?GmhzW7VoajoOiM7w6001l0nE0butlm+3MsQykJl3LfnbAFRP1dSDSVxWqHSS?=
 =?us-ascii?Q?NLPK9qsTxuRsM00nIKzJJyVacsX8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4Ymf6XsWErFDNI5UuclKkHx2pRLkis9Dc37Mo80UBWOD5Ct1eafEhDJJxa0u?=
 =?us-ascii?Q?XR8lFKZfDtXLpGDlko+7tflEYmPell4yW/mhRHkPpEf6tGfTsX4svKf1fw+c?=
 =?us-ascii?Q?IeP7rc17IY4bqlgJ31UL1WJ3qhR7Sqe+CEGBiy+4FhZR6taroGP8fvGFGqAm?=
 =?us-ascii?Q?AdVt1hpvsh3gry7mwBMjNh5HUBbbM9AvgNEpCe7WIRfErv6lmbxo/8OE6FOK?=
 =?us-ascii?Q?MQ2SKPvglU5D03wSR5WNMO5UaZHVt4+zr2JygOQhzTFY5bbIc09K3LLZmkQg?=
 =?us-ascii?Q?xb5U6urPn5PLGWQoFPMoM/9fqYKOkyHyI/8/BT2Pi2lxRToqmKK7DbXAjYd4?=
 =?us-ascii?Q?G7rk66Np1PXQ4LGTZO5SvHZxsXVjy/UsS14GJPAwvAvRRoW01k8yjxv+s9Li?=
 =?us-ascii?Q?AMcfcrk6La+tUgy3PJB686pA5gy4szAwgJc4d0Xgc/JMsCgE3Zi4Xy1s6JGl?=
 =?us-ascii?Q?XLyO8SsLlS319xBx/cUMuBEwQ7eJI8pMeHN9uSRcrXFv2MrY7hX6mSncuRN3?=
 =?us-ascii?Q?iE2LJkA+zG1eAXD5olOtB2bWUDZh2M3C9vf1QUrB1sDlSm3BFX3OuIwb/mzq?=
 =?us-ascii?Q?II9ZFgAKQDpHMy+Ve6iZ1W9xMkavbI8wIj29/YlUv9fNLaXyKAQjuekwzAzP?=
 =?us-ascii?Q?opXic70EeviO3RufXwgB2pPq7y0te6hLuabhqejoMipqOyHeZxTKySJe5DwN?=
 =?us-ascii?Q?CJ79UinmlFElEdd5+uqw6IzHutWzRZqJX0mE8xSv9FDBujtXjtSM+cTTCDNw?=
 =?us-ascii?Q?m/+po6eTuS97/ouLm16kywvk+du1FnDnXjtox+9ugldmpztVM1mm5ptQDw66?=
 =?us-ascii?Q?csNB6y85M4rmS9YbO+yZrXIekWH44Gl8/HBAkpFy1pZcL3u6e6UUX3uP75cL?=
 =?us-ascii?Q?CEBjhAzfGYNM4wwfC6zKnVG2S8nkfmmjhiL47EJjBKrglZM8rqI9Y4xWGVhU?=
 =?us-ascii?Q?O4nt9PF1n73XVy3NapBu3yjnBVjHThoZ2ZBa9Oi7z8rcbJVHaD2tCEo6cCWx?=
 =?us-ascii?Q?dOghV9hk8leyAvC10qeOs/0xT4KagXNodJ8lL7m6EGDV/PncEZq0WuM9MsXa?=
 =?us-ascii?Q?S17YlsDVBSMXGZDMVc5JXiNQPmLlqn4PpDQaCoY3fgoqQbspiGEQeVMh3Ewa?=
 =?us-ascii?Q?mnyp9Mlq7KwDEcIFZB7up1AHS0ofeR35pw8zzRvc6065T1s4lH+k8BBOEa03?=
 =?us-ascii?Q?nPIkSnAJ6yyScakaE2bo0zNArmQS64k491neXVNW3w/HAbTgPP/aLSCk7Fqn?=
 =?us-ascii?Q?MutYwVGOoC0/v7GCdCZ2bFlCmwsb50rijnFO2kerSLbu37AmFk0iDTsbXXnK?=
 =?us-ascii?Q?mUy00N+2IwP3Gad26u1yksdoogXM4yq9cySlnR6xjVbGiHhub3uAeYYn4Sqi?=
 =?us-ascii?Q?rvTQ5uOsDnVdDYvYQzxIS9Y8kiZ2KA4Emzbho3XO4nbn6SXzIMzNfOs06sbp?=
 =?us-ascii?Q?6iGBA9J5xnVCpcje/J1G8FcE9m6CDdmxqU4exJapWSDqri9c7luzBfsXIOsP?=
 =?us-ascii?Q?Ut6Ns1HY8yH8mkpfNUdeE9pTnfbwLo1iJ1/38QNDoi5jcRHKadqpMZSn7+AA?=
 =?us-ascii?Q?DHLVUZFJ+eqOwg9hOma11RZuagi6Qj5+xcSqCY6FvqEmaTuHOiJXyM0VBpL/?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VOLwY+ZaN1/y5zrv6Inlsov5LOcx418mznCjD3pfW4kDFR6r4QrPwnD3av86DqQojQRqKgwVPgySvXTQJLBSJn/59XXpSSOYJpTx4nUBKBteitvL50Q9squzjfSXMEO9UphMb0q6x7qPEnX0pKGJv2GMqHKcFa9neVpYSLMnkYxcPHRCB7F8O3fYa/wLSXxEVuatpIeaOaCIo2v5oHMO+U4p7O7cVcefprUuSS04YQSvyqiWDQzvLfauri+gsDXJI6IUSb7m68rCDVPoW5e4//wKmjqHQeV4WVZEqdD8DnfWNqDHb7A23FvcgwmWcZNquJEkpWbB4E9iOc/8duV2LClWzy/NLB/vFrYs5wScurigJuj9Mfb1+zyiwPKdf2f2GqnY7l/3ugqCQ0/1ore9wVJdbuYA856UGI/9DoNEC0TaRDcU4YtPJllWzHAClMPgX6CeGH8wWcrhas3c/hMUz8DSOPfVnK/X1c9Nb7PRaE8TSoKzFNvkRPRvCcEJtyHXC5sjPIWGnZDNxxNJho5+wx8a3+TlOUCMBG44671fI3pgcoottmBXXRW5uZ7TT+adeZ2uZ4Y+0hFFkqOzUCkzz1AGudUaY8eaO8DbrAboJUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcf7d7c-4a24-49f0-1bbf-08dc9f2ebbfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:17:05.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kuv+qI4lMvC2KUrXyF/jzH14lWyKjeLowYjNOveaTY0hmY8gnoG5USh8Uu5IFSNszCR7h88re47fzPVMU/DJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080071
X-Proofpoint-ORIG-GUID: ZYjOm_9BiKcZafr3nbFwl2zb0flBZ5Ek
X-Proofpoint-GUID: ZYjOm_9BiKcZafr3nbFwl2zb0flBZ5Ek

The block queue limits validation does this for us now.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/virtio_blk.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f11b0c3b2625..e3147a611151 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1289,18 +1289,9 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	lim->max_segment_size = max_size;
 
 	/* Host can optionally specify the block size of the device */
-	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
+	virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &lim->logical_block_size);
-	if (!err) {
-		err = blk_validate_block_size(lim->logical_block_size);
-		if (err) {
-			dev_err(&vdev->dev,
-				"virtio_blk: invalid block size: 0x%x\n",
-				lim->logical_block_size);
-			return err;
-		}
-	}
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
-- 
2.31.1

