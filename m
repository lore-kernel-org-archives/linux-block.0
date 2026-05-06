Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7E367F3A;
	Wed,  6 May 2026 06:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050667; cv=fail; b=PZP/hl2INsUJGLZYESXJLRjX1eBm22MLpN/rdr8vePSLP+fRKUWHJfTD72FvGLo8IKMI9a+uf8kP2/cbDn0o/1u7qny3DaySBy79nEn/i0hq6BlNljtjYRHdr9N1rdTHTf5ITIKX8OuMf719/ue3ufFYjTiQ7LgRQM2kHhzeAFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050667; c=relaxed/simple;
	bh=TdBaoBXcUAZ491+fIeTDr0AcjrlwyJhDYdLh4ezK7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYodKIxhJiWadzsF/pyJskmPXvN6+LsvK4KZWCrslkfPP/vdHmUfaQxB1jeHAaEHogEqzjBlQ7KyUFNgJLs/qEwjpORnllxqnbVCDJxNevvT4qSXn11kkqLOAe4GjzPQIHVds8ttJBAgp8D77aR4ECIKID9YS6rkR/jQb6zHiYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Nc9BLcVC; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Nc9BLcVC"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465oG6F443744;
	Tue, 5 May 2026 23:56:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/Eqv8vpXQTnH9KScNzOGef5QzVzsy/cx+TQnFGc9JdI=; b=
	Nc9BLcVCZ3Nj5eEhr8FlI5+r8E30pmDjskCBHa+fn17dGMLOrC2pnwYOSQ3/7PkM
	jZQf7WdMCXo+0jAdlbSY1unb8x71cA8VRQAs/aR50hvN4677ktLBibnHh2kgutPb
	f+dULLv9yMMBsktQ/G2fBDox7X/1Ot6SLNGj1TQBigSFdLI8yXxdUUgmYXt1/Bqf
	FvQ5JkpDjCACPlfcxNUbHEds5riA23EUKkeaVvuX/hIk1fdZvivuqRT+DwKoI5Nv
	8YoSamZJazgPng4dL+BcXKCzBmY7Fh0d3EhT2HcDRvOiaA0ggrYrTim+dRW7upep
	oHRJf7KRsgx9Z/VCbI/VJw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwchyvdnm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 23:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2rUojVa3JqAZbNGBWOMmW1j5vhgqyBxLOyE7P/YUhJPCNA0cRijQthj2/ZgkOgqSUopbwQBkWYhPEGT9a9LoeOWsgC4RvGKL3b98MNavYWtlOrfGFr1d4JIpjxAnmhvHR7DhT1QgZuDUwqKFkEF/FhJwBQGur2ZRHjeRA4c1aBoJ2nyPuKwMoo3Qm3MEDZEwSPKZrA5UdrB6IbTXuWSDK8vhgS3LYvccVdiU8WZI3+aj4JHCQOaHBcH4O/sYQ7Xng99rJQC4G9yZIt9YACAy/xzGXvvpgpuEWT11UAABXv8tsLH8Yj+dQWoMrdUoTmDRo+VqJheJmEzXn7X2h8ziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Eqv8vpXQTnH9KScNzOGef5QzVzsy/cx+TQnFGc9JdI=;
 b=Zv7XZptpuVyc4rsJPYsfRtRe4KZiurWVoPBlN4u5V4eKBalMlP6RNoJ7euq2tIH9GBlJW2ZrlNWCfT3/l4xmRFL5XrGHL9n9SCBKysW7sxJ81vcaCnCgvns83zUpd1NExNXCFHLwRYiQQko3IrswTXP+B2EXkLRIn1wmzjOI0n5e7LFRs8WU2DRzqkLsopHTwdTqYW7Gxa7sONIQKuNMjaicumwaiDu6U8JWUSgKCcXMcBVcYLv02qWe0NbHZUe4rHlV5gbeVNFkndVagwUKEiT1An1x7nTeYXihfy+OYI+Dcb5SB5X0dC59jOaqzwAkoIBeiZnmO4sicWluQFPRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 06:56:37 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 06:56:37 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v6 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Wed,  6 May 2026 09:56:12 +0300
Message-ID: <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778048987.git.ionut.nechita@windriver.com>
References: <cover.1778048987.git.ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:802:16::24) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: f875e654-7ef1-44bd-6317-08deab3c9e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|52116014|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	J51aEHMLULWR+2z5SPRVAuh9auSxz54xXj7S7hMwZU9UAw4ccEylgazrma0nZHIXDowR90vHu9FMpoxqIsebe9lZRi7Vtnau56Pzb8CpXW0PcKCZ2OX4+6uTqVpAQYgBnC4CoIpo22v9nt8OkvaiCBgpjD/g8UCNWXM/1aXvXDTTUV9ggO1R/0OdaOY4Ylw565FK42hKuFAXld32rlhytn3dMI69NNks0ABcvPqkx+etCYYjFtIX7vJRBpe3TSnGT2X+crs/3P14l4wEXAxUMmtbk076IHhdkQUhgp5P4PN+NWnRCHK79j8VcasFBUrdKbcK7itw5vM8bxJZv2pJMUnVV/M/H+ydy7JzFzpOHu+RFgl0Moa9DuI/qnWxReSDt5pTpbr/J/0vmunuzaUMrI7Sf4j4ioZRIf0u3elYtMa/bReXoXcyu9uuDvogXzTsLsaY3BlsM310qhNUMSMCHkqSc5Pn5vhagBtVy7DhbtyN0CBaNAZ63PJ63DULleAVvouPhoyuiD74Juro9kznYup8Z+6TxJ4WOdqDvkY9qR7YN/6CEY1PsarJO5w0ioB+kXTZz8Ve376ympJsbQyIPcVLL0LP9RpC18ffI/C5vXkSKzd4KE7JaA111Wpy4rWCUkPLEnI7WTvCS/MU/zkkTtmPiuP9BWi6aVuJTIrgm82E11wFgkkul3lXnZ3txNEo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(52116014)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9qAE80GPDq4qlymGic1oqmos/clrs39jsV56Jhk084e4wdzZA0G6J1nQjki?=
 =?us-ascii?Q?UDeNj6XChwhpXznvAIq7HGLgQJ4gSf7NIRwmilWDcAxpj37BWM4+WnFM5+FF?=
 =?us-ascii?Q?Ekr/qAyAj2V1JR0jTPGARQX/4o4OYrItJtv209H1lJHYEo0B/BpTnrEW6/vG?=
 =?us-ascii?Q?/XCC0a2kcsJ7DLsuzjHwlZrcaES+1QV176MLppm9V1UmjYKpltiO0/dmwvUM?=
 =?us-ascii?Q?l4Gmlfhd0ZqzOdm8/FxUoJ/HZyuSA9LnhbCMwwGxG4k5NIn0pl9vc3OVOhHT?=
 =?us-ascii?Q?fMlZgZJbDG83pb7QKlkbzfxh2PsU2EeC6fH1QaGZETVy26Z1fdeuoQa80Iub?=
 =?us-ascii?Q?mAQrgqFFf6uUeLksxS2Im2c0R82HCE0nrEcRsFNJRsUCxlI5Vrk5Z2rV5vk1?=
 =?us-ascii?Q?ihhH2TGGyOFWwdVTlPlbeebQyitW7KEohOIu25TVPnKgM+8ZxiuOaGVeJ5pf?=
 =?us-ascii?Q?E7G0JbwCN3MhPl8tBnai2tSXFuYRfgI0x4f+PhIDRXA4H/8gfwyri5ZDjZru?=
 =?us-ascii?Q?Ee2q9zqi7QFY5Di9E3s3i4SDGN9jbCnCASikzyw7AJ2afUWkGy8lqrr/gPXh?=
 =?us-ascii?Q?SY4NlZx7feRHA7Pvd+jUZXq2ZaLexeCf7wys2xD+8Uw520YfzajdtuJx8fsX?=
 =?us-ascii?Q?ALDYqYA2vrGGgSKvOM+76OOw5+OZQX60QTE4oWLHMZGhuJa6eOANZmT92oXV?=
 =?us-ascii?Q?BCCa5lMONyYyZgHtIpa0L95IbT8PMkPK+U369ZZ+uK36QU1dcV8RmWhH+Caj?=
 =?us-ascii?Q?/BchEdU07vqaProQeSeYZ3AFIsUZQDjkQ043p7kGuvH8IdZ6ZkU38Pc4j3Lu?=
 =?us-ascii?Q?/iy5ThJqJwn+HjDKkFq/2bLBWfvcCZOMtWjjiRukNySTCpmjmaSQsheyaS4g?=
 =?us-ascii?Q?1iqFc2Hv7xkSHw+kP1C7cB8trA5oZnep/3s9Q6wSTnx8E0cIykIb8ea9fH/u?=
 =?us-ascii?Q?WpIMBu5QPI2ajL1cjYyVT9hQbLjHs3PRXIDfwzsQd9BM7vYYgIIXAlK5yjE+?=
 =?us-ascii?Q?TV1EzOgGNhKQWENEvE0WljvB251JqctWKIbaa5IWQtUIL364W/7YYxy4gxxk?=
 =?us-ascii?Q?o/4+4d9O+yVQtBTU0QTLsKDKW2QNgi5p66LmICW0tixjOQnISoBramNIcoDf?=
 =?us-ascii?Q?3zKGKTbAbaFQB3FehUDskuZN7bWk1xAvjTYGQk2KCqHN36ZWd1P4cUwaMj/d?=
 =?us-ascii?Q?YkrDRfjiLTIaySxXHUDDtMp4LrV3xwK0nIvLpvXSaos9AprM3Z3DNTXeQ0L/?=
 =?us-ascii?Q?8tqt6XN0y+t+4qpzO/+L22iqAYcx4ilSnG19X0iJDhSU/ZyzSgCvGES3SWYP?=
 =?us-ascii?Q?yMuFHGsY089gOhB96bSMRtteC5prwPdU3NdhJCikmT8PT9gk/tuNUOn/HAue?=
 =?us-ascii?Q?lwpSzH4oPfraLdJaJoMbxmMskQJRURuXq38HUCBD9rkdwVhewYpCB8O1ihsU?=
 =?us-ascii?Q?NhDpkAc/Nbf0UWr/L4zCBT1YzS2owgR6jZEKQLvWY3aNYdGqoQSPH4c3kJYP?=
 =?us-ascii?Q?aroS/plhqiYOi5fMMRRW7XLZN4bDOdSlme1abB69exj31kp4y8hMYpTEpSEZ?=
 =?us-ascii?Q?gBL4VTFFbnNB/yCO84yzI6H3VMi2nUhHseCIDAj31Zk+9e11TRJsAGoPDsLC?=
 =?us-ascii?Q?7K/2O4YQsoQmWDjXUOyBr9YKX3k5e746aHUOs2yJUbAF+w+idA6DmRiKrvBx?=
 =?us-ascii?Q?gLdHss1yVDNJbGuiejQnnLbqtmM8YL3B/Kvq11j/mLZRs9XOdvxFVWUvOobD?=
 =?us-ascii?Q?Ok9NpWlnZZX7Aob2I1mTNA0i6uI+YRWZ5ddwGvPKetuToRywXefgrzz+E1kW?=
X-MS-Exchange-AntiSpam-MessageData-1: STeqjAHXIx1tPZmIV0Saj60todGA+IJRXno=
X-Exchange-RoutingPolicyChecked:
	bmUVXC3FYtLe5imA/xdDo3WHD36d2KyLmPeHxhazY0sRvC+PTpGMTdtMWufiVxXt15Bp2fekspRqCEmDSFuwiaL7BqBVQ5c3h22hRlpZPCSFclDIGHgvYXZpzBNe9nuizkV+MuHDN1agPXw1xjeUjnQWEme9azzPR1VVuwFrk9ssYNgB5t+zGNap+bWS5xzhACaVIx9y19eecoaykD6HpdxykCY3Br/z5tVw62NwAtYPJugvCgbAdIrWXGlfA5D8iTyFj/3NkwqPznwHrVXxlSzoEtXOVOqpScwxEJpEcQNM/fLEaXsCY//36EsOT3Tz6b5YidkWxquHVKx1SAhgWw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f875e654-7ef1-44bd-6317-08deab3c9e01
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 06:56:37.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z/K1Tvzp4NsX9tSzCwsFtfWvR1b37q/K8IUezI1Ra/1TK+2RE4kuMjUiwGa+sD/6nKUTmsf0jy7Hj1GwQWNZSGedv/Po8G9n1Z8cnKLOBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA2NiBTYWx0ZWRfXyHV/UGRwp9mK
 KKZ6MY1toX1XtPfIOcx9gm/aIvM8xrAL4+6VsblahFWytBgd5jyFgivAsV+85usJ/sLVzRzJuRa
 jC1dMoCD6X258EDeE7u7KsbwA9Y+jwmmp56sT6I/BRQbr78sdc0Mc30x/OCdecjzoYs9SeJVD+/
 R8/4EHtZB5F2cNmp6SSXLNkoh7OnE2YQAj1IVHxEu1KJQBcBnX2XpUZort24pmUVUDNT37Q5jkB
 i4adsn2lK44/OEhAdPQmAIAcnwtGAxPTfqLtik3i7cUZGkoBOErpOAi1OaBodRld8gOcWqrnSvp
 8cCz60d3T5+KUPuUSe8WUK9dPxdMGi16mqRYPOjsTHQqtWjMmkCsQS+9p22H2YfhIwmZF2e74VI
 AxH64X+E/0BpOFEgkdUFXOOYl9L0kxZN5gEf6I3RmUFxUTDauPHwQZsBAvhNPhi+FIqGQMik+HV
 HoY5KT1xpvahwVYjEvQ==
X-Proofpoint-ORIG-GUID: BmG17TtYRDN8vCPm5uJUYjYGpveRJdGE
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fae627 cx=c_pps
 a=+Z8LngAnY8uKoQL+MiJmWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=3tr2qsFa3FZPBZ7I5BMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BmG17TtYRDN8vCPm5uJUYjYGpveRJdGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060066

In RT kernel (PREEMPT_RT), commit 6bda857bcbb86 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes severe
performance regression on systems with multiple MSI-X interrupt
vectors.

The above change introduced spinlock_t queue_lock usage in
blk_mq_run_hw_queue() to synchronize QUEUE_FLAG_QUIESCED checks
with blk_mq_unquiesce_queue(). While this works correctly in
standard kernel, it causes catastrophic serialization in RT kernel
where spinlock_t converts to sleeping rt_mutex.

Problem in RT kernel:
- blk_mq_run_hw_queue() is called from IRQ thread context
- With multiple MSI-X vectors, all IRQ threads contend on
  the same queue_lock
- queue_lock becomes rt_mutex (sleeping) in RT kernel
- IRQ threads serialize and enter D-state waiting for lock
- Throughput drops from 640 MB/s to 153 MB/s

Solution:
Convert quiesce_depth to atomic_t and use it directly for quiesce
state checking, eliminating QUEUE_FLAG_QUIESCED entirely. This
removes the need for any locking in the hot path.

The atomic counter serves as both the depth tracker and the quiesce
indicator (depth > 0 means quiesced). This eliminates the race
window that existed between updating the depth and the flag.

Memory ordering is ensured by:
- smp_mb__after_atomic() after modifying quiesce_depth in
  blk_mq_quiesce_queue_nowait() and blk_mq_unquiesce_queue()
- smp_rmb() in blk_mq_run_hw_queue() before re-checking the
  quiesce state, paired with the writer-side barriers above

Performance impact:
- RT kernel: eliminates lock contention, restores full throughput
- Non-RT kernel: atomic ops are similar cost to the previous
  spinlock acquire/release, no regression expected

Test results on RT kernel:
Hardware: Broadcom/LSI MegaRAID 12GSAS/PCIe Secure SAS39xx
  (megaraid_sas driver, 128 MSI-X vectors, 120 hw queues)
- Before: 153 MB/s, IRQ threads in D-state
- After:  640 MB/s, no IRQ threads blocked

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 6bda857bcbb86 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 53 +++++++++++++++++++++---------------------
 include/linux/blkdev.h |  9 ++++---
 4 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 17450058ea6d..1cafcca0975a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
+	atomic_set(&q->quiesce_depth, 0);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 047ec887456b..1b0aec3036e6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -89,7 +89,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c5c16cce4f8..c1281e4d4d83 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,13 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (!q->quiesce_depth++)
-		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	atomic_inc(&q->quiesce_depth);
+	/*
+	 * Pairs with smp_rmb() in blk_mq_run_hw_queue(): make the
+	 * incremented quiesce_depth observable to readers re-checking
+	 * the quiesce state, so they don't dispatch on a quiesced queue.
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +315,23 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	unsigned long flags;
-	bool run_queue = false;
+	int depth;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-		;
-	} else if (!--q->quiesce_depth) {
-		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
-		run_queue = true;
-	}
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	depth = atomic_dec_if_positive(&q->quiesce_depth);
+	if (WARN_ON_ONCE(depth < 0))
+		return;
 
-	/* dispatch requests which are inserted during quiescing */
-	if (run_queue)
+	if (depth == 0) {
+		/*
+		 * Pairs with smp_rmb() in blk_mq_run_hw_queue(): make the
+		 * decrement of quiesce_depth observable before we kick the
+		 * hw queues, so a concurrent blk_mq_run_hw_queue() that
+		 * re-checks the state sees the queue as no longer quiesced.
+		 */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2362,17 +2365,15 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
 		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
+		 * Re-check the quiesce state after a read barrier. Pairs with
+		 * smp_mb__after_atomic() in blk_mq_quiesce_queue_nowait() and
+		 * blk_mq_unquiesce_queue() so we don't miss rerunning the hw
+		 * queue when a concurrent unquiesce has just dropped the
+		 * quiesce_depth to zero.
 		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		smp_rmb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1c..5d582c70fb8a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -521,7 +521,8 @@ struct request_queue {
 
 	spinlock_t		queue_lock;
 
-	int			quiesce_depth;
+	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
+	atomic_t		quiesce_depth;
 
 	struct gendisk		*disk;
 
@@ -666,7 +667,6 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
-	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
@@ -704,7 +704,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
-#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
+static inline bool blk_queue_quiesced(struct request_queue *q)
+{
+	return atomic_read(&q->quiesce_depth) > 0;
+}
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
-- 
2.54.0

