Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F9B136358;
	Fri, 13 Feb 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967534; cv=fail; b=G7c/1O0QpZc4dDgWgU0PMYZmAu0qmxhVKvAZzNx2yuoQmdOZMo4v1Fdc/aZbTL4Z5sBUn2IeWmEYU2aWlb1sLMpUjBj30xwM1wYatikPLPeUsCicxAntK4pJ4iVxPD16vQjJGyxrhUmHs5yk07CU0l0sQHiJ7Zh0MCLRiRLacFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967534; c=relaxed/simple;
	bh=b929CVvbeXVnZg12w2LETBHT+jPiyp8XI0SoLjB+cXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMnkPcMaxcBX+AFGr1HQ1ndW/NVu9MsxYN/W2PNSEsaKF2soPWmAcuy/sl9emu3//FAJbkE+d8WYSFis0ENBHljNAbiHdPo7MthWYvB4iFWdjAM8W5P7RTV1hdDbcAPCDHVRumd6iwUiRMFNRMoKqf2tnQYaeJobGb2q2l91SCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=OoPIRy9q; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="OoPIRy9q"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D6KivJ1478522;
	Thu, 12 Feb 2026 23:24:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=2dUS2pnG4fAAEjof/JK9EsREQuzLWEpTfm9vPnWg4Tg=; b=
	OoPIRy9qlCjHBTT6PXz6TbJeJjAspelFPpMcrr2FGrBgnxPMiQhXD4MxiYaDB/XC
	z11UBvwAUZ+Gp+Y6GQ7ZIil7jjGNpGM5bZkBh2EzGAAH3Pa/vAXmjSqZgCHHDTme
	k9HpHwehZj19lC78CmistiRDvmQShflN3gvKbRrTNDSuX4rnaxZh7MDWPCMc3nu/
	vuwXNBf5JR9VEqGDfGXS+MruHBxeEMVfuCoCu/S+sViNIVDXCE3qZdgrj3Kk+8xh
	VYyLy3+7sLkwAqkCe4gvEJfYAN2CCKUpM+5yhoxPiDVFYTF0l8gYGQsHLRodNoQQ
	qqCUEyv6Zk+NrGjwD+2cSA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c61j4xyxp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 23:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noE+lWMBMUoLIo9075xWlXl1VXcZtJYmiFH/pYLohdMQ+go/3rZm3G6/Asg7xLzwb+7Q7hFiQQmiq4bYApibuhcIkkaE6t0+8h+EeAkBHzuJQbph2HCLRzjOKmr9L9Td/yH3FdQsNRXKnEgJSW9pn/UK63Z5aAoI6gGMZcblOUavMJLTxSMkKMVIXI/z75ySbsUUvWHlhY6g7t0FWMAfrLyXKaHsR4P1e5OHdjsYAgN/0p4h2nPJ5jDpcffGMnobMbnRzVA4E+49oh3Q+DQDs7SBYGukT+VKn4vfjryRsJNqLt1vKd8YtTagygu6AunR0Gr2i2pKE7GAtMBsid8K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dUS2pnG4fAAEjof/JK9EsREQuzLWEpTfm9vPnWg4Tg=;
 b=oXNLeMExekAnBl/FfrJmii/bfzd/ypS0uBd2uCL5rSvWE1DXZVWPH5a/I2ywQYP2pnEHGj2VPx1wY4SLXglIQx5s7ZCxaXWo4w75+Xb65l/KLZLM45qcA1beywHqCvI2IUmep4YoTGTgm6O6rcvtp6K5o1ROU1ssQ9TzkfJVEcK4OCJqhuBpq/h7ADt5mW8yaW0CFR8oCqmlDxt2kknf/espLDfSS1BqRH35JBeQ4XkWnTqM0rUaeAzHubmu1qwvd8ULo+jO3IWQ/JkH7FDWNcN1WmdLzWk/YWvaCJnHszbgPB277RrBD74pVrP6ZDAWU/nbOLXdiTkuNKnToZU+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 07:24:53 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 07:24:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk
Cc: bigeasy@linutronix.de, chris.friesen@windriver.com, clrkwllms@kernel.org,
        ionut_n2001@yahoo.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        mkhalfella@purestorage.com, muchun.song@linux.dev, rostedt@goodmis.org,
        stable@vger.kernel.org, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v4] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Fri, 13 Feb 2026 09:24:14 +0200
Message-ID: <20260213072412.28863-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213072412.28863-2-ionut.nechita@windriver.com>
References: <20260213072412.28863-2-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0302.eurprd07.prod.outlook.com
 (2603:10a6:800:130::30) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|SJ2PR11MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: db9c014c-0264-4f7c-4f47-08de6ad0fb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxH0qOzxuXfVJCCMxOKlSzYO4eYcfHW9kt6gedIp3iAsdw83HMVf2bmhPQiO?=
 =?us-ascii?Q?hcHneFjJ3YgSllxG1mX+mU6SC5tJ9QzEt/8OgrecVFKUp6Qy/vrSuSj8XHZy?=
 =?us-ascii?Q?1ldX2gx7AVn37Kp53JRH1+89YEQR7Yi9r0+pN2ZpWhDFYYAGhxyfehI/9hOe?=
 =?us-ascii?Q?Fz9+PltSzDKEnrIUkfmPQRpzk0pCn3T/zFCb7qbaLpI2Wg1t9NbZsivlFxVw?=
 =?us-ascii?Q?sa6jUqjc0EBhSplY5uHpAnnMgXMWSPvfGSKMEfuh1DZON5vQ23tlG6ImTst6?=
 =?us-ascii?Q?xo1IOxV8AskbDo0KQvGp3HMPg6TJC3FINWHtRqsy4M0WmPH/aWNeabV3bVwx?=
 =?us-ascii?Q?1rhFY2lPV2AQdru8jjXp0HGk1iajmvKxr/iz8tErc0Bn2fMpRk9RppTw5hLK?=
 =?us-ascii?Q?Uym1sKFP86KHbqJqI4wWShWM7evphnzcfosV2FQ3dx5OJTajF7jG3TmLIRI9?=
 =?us-ascii?Q?ivrcncx+zvBSf5yGOz6CVAFXW6bVCfDjV87xPD3B8v+BdpOMXnxG5MYFdKu6?=
 =?us-ascii?Q?Klh4LZmCXl+1g6tJSrljwnVy00w8KAcmz31DRef+4iCTFOUC5GjIu0hk4wwB?=
 =?us-ascii?Q?7e2GhLMSV9/2V5D3Fnt+6FCebf8vbUtKxh0Ku2xVAjwGJNcmv++yF9iJSyjW?=
 =?us-ascii?Q?WGl7uFMpFC0UrQX5zaHW3Y5iOy53vH51MFDrekDNX4uAbaehgITTcqBVVJX2?=
 =?us-ascii?Q?uxoSvpiGHr99YuWPl8AENrSx+4poRkX0U0Z9/H06HGjKR71gxe+Dr6aHJg4Q?=
 =?us-ascii?Q?WekMlOO8PbWUnc340HKPovTeWzbd66WC2Wug7WTyUrKU+fLELqsOMq8QIVHw?=
 =?us-ascii?Q?fYqnaDod27eDLQMs7nxsecJVIyy2y4CdVQqWneQtpCzzALrNM1BwN2xGNKUQ?=
 =?us-ascii?Q?5fLEb21r/mpuGFlGjuRhQVpwp66E+Q1VByQUbDDDy8T9US5gLRDnf4C0aGg3?=
 =?us-ascii?Q?rBBxUU0EugI4fg46f7DjAQX9c/zeDeNKT6IL1V7H3HzEciJfY8ugUEJZLG5C?=
 =?us-ascii?Q?ke/hU5tTNl1ib6YnZmd9oTBpB+BghU6G6kbxcXKqezfKodBsOLoRsWYPDPXO?=
 =?us-ascii?Q?K3+Db8maDRwggHYSCOcjG0ccD2RNiZ2UwgTX655qivSn74e+4kYnaLRMEY/L?=
 =?us-ascii?Q?wDMaqO6JyJMcE+HhcLwrwJHDgfZ4xH00pwU15uF3fb4JhE1oZp/Tfx0xQXtI?=
 =?us-ascii?Q?o3z/1FBpKlGOpqKEtJMw7upFzGnkR6OQLnLGhqG12Od7hGAv4Rpmg/YaVion?=
 =?us-ascii?Q?VgzjQcLYiL/sKixSoHpDOwPSMua0Ij6BoL9mg8vCc3L2x3pBKcxqoFeYsLR5?=
 =?us-ascii?Q?L/u0D7fI0JdRGe/XsB4kW32CviMTHEyRJBuf+8Ex8gf/3bGz0bICI/yV9+m5?=
 =?us-ascii?Q?/BBvXAQkpwX2F3nYbM8i6HP7QWbPBZn6oMKA0+XPuu2xloeWpqwf+OIjwmjq?=
 =?us-ascii?Q?PI2T6cTFtARXijnYYr9mWkuLqrIy+9E+POAuGPrMWfHf0x+CFzsMPZywkAaS?=
 =?us-ascii?Q?wYn5R7nY6JT4kDmIm2cxrrr7dD8Pqhl0zDJmfQ/fhkCSAgP3itL2gwMZWZNT?=
 =?us-ascii?Q?LFzfYC/2V48zmjIMgqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4MAM1VDXsmHuUlpHwIDPBgkauiTDQkNZCD+JMEfwIo9uL3cxloLIsWz5Nyb?=
 =?us-ascii?Q?2hQkxc81Ve1cYA9pghfxI2JWHC516s/hPFLzPJ9wPKGZik65Y9gVFhFcLbYm?=
 =?us-ascii?Q?d233JErXZcQzu0LJiOk8eCKnS3t9f6u0Cu6D3awFjoqdCQUj7e5v5R49on2Y?=
 =?us-ascii?Q?GXifmMiLBspjDMaRyc3LFD+5zuW8GH3lIgiKOXxgAFm2rNVKavd0acEtbD0P?=
 =?us-ascii?Q?xKWspF7BhTJDVxEP+W6xdBrs5tpSuEur1ko+QoBhunrbZnbgWZN96IwFMquy?=
 =?us-ascii?Q?d58PjVWpBcORhRE4vyC3k+P1HH1ozSX2OsHyDS7LWlT0f7rSUWLFqaWKx4Rs?=
 =?us-ascii?Q?VZLA300Tkaj4P/YXma9/hPU4/i4lWW2GD1lf7VnpFTtlnRCKP7GEBi9YB/zi?=
 =?us-ascii?Q?nFc5fO640jDtSKmiDI2JabDy7IzVW6Je90TF8EhVI73BmqmNjHvm9+0pUqhR?=
 =?us-ascii?Q?J80LGKACfco50ocW77KD5rXLDivRd6ZmcXT5UPsmmUBa0D8r5NB4rY95wh7D?=
 =?us-ascii?Q?7kcOoD/jr2g/E8FiOO58hJFfzHKKGAirgP+rdKyLrySqo/KcvQBAOhw3f5vk?=
 =?us-ascii?Q?LNyYEfB3gG07wbhOD0a9rvVipKnkwton1VB9TRIOWE3KzRT7RfVDqzg3Dqnt?=
 =?us-ascii?Q?4m0Ya3oPVstMSbv5VfZs3Eq9rI66fc02iw05zHXdEfes9KAVUqKZjXJd+W0a?=
 =?us-ascii?Q?TrmYTtFf2ul0D7LpXJ8F+vCZeeCXluuuR1wKoUfBMwlaY5c00ShOsB3+9gvd?=
 =?us-ascii?Q?nikUlBG7mEBg2eb0zv8IEqaOsIEZP+CMnFbWUPJunJC9q5dYImDnkOBE7RXE?=
 =?us-ascii?Q?27AxmrM/2dJ93NDdRBvmt5TIQoMzsveGAgREOpy8oLr0Gip3lraCktwZPTj7?=
 =?us-ascii?Q?eejaggsW99mPxlSu9YVst34DC0Y/mBLHbvFAZ8LfRgo6qQi1OrFqziUldxoT?=
 =?us-ascii?Q?gEWu3dhUP3qEy+Djsr31DD3bznwXtH3rtV84+c04UD+t7cBDzk0QpFPPwY3a?=
 =?us-ascii?Q?8duQxcO3WmqwLB7ur5Yhj9sHCMOIpqVeEJVwsovucf0fpHyEe2A99eloG2VD?=
 =?us-ascii?Q?hnwlvjeXqNBI2JzQOlk0HhEa8obujm5GYkFrbl4m2AFAZ+26TkPaumokxf9k?=
 =?us-ascii?Q?5rSFu3bRDtHadsUSNBC2qoe7N+nu1OXoCbg/z3AvLjHw0sEFAp2CHkHL3Wzx?=
 =?us-ascii?Q?s1A7ZeL7YSrCyC0y3gUEitocMaArBPvxCe0z7HWk0mBEAPvW/tZeZmdBYf/Q?=
 =?us-ascii?Q?YSHqUt+kD1YU9aKwffCkJQ+dPIcjGYMKtEJqk8GUpsZlYM80h59JBcDtjuVd?=
 =?us-ascii?Q?XQa3/Pldq1Sy8Stm0YnQvnBrcl94kwEhcHZYCW13OguQ7oDAFzq+mZLmQGRX?=
 =?us-ascii?Q?CRTTCXMfQaeQFJL6iXt3e0gs64YkyqRqVXDeZ6UZV7MOL683FyQiSxsNnNsY?=
 =?us-ascii?Q?OkW7GKsNadgk+LDELiVF7E8Gr5zqGuGrPdKu2ctH//obuxpSCioAboZhrf5K?=
 =?us-ascii?Q?802LyW9GTqO/olCTlAHZM9ZiEBugfgPXqW1jP4B6Rr1ndeQoNGz35tW59c73?=
 =?us-ascii?Q?lCfauI8c8ull9zPhD0l2D4lDX50dz58Y3u3kP1SWEwNku7lvo3d4MezLxF5D?=
 =?us-ascii?Q?XdcQC5dJqKC3AOj/cs14YppGuijylaBHwsCpLBws6bmJNhNgyZm7MiSrtg6c?=
 =?us-ascii?Q?dObuJxrGkGxMcNcIxcUsnKbGDGhtGkIQmQm2iqm4MlaVzpaBqV5T8PYCCHtm?=
 =?us-ascii?Q?L/3wZCU+Anv+/YDvWUteAH2qTB6e9BdaCdegca25CEdXvDWGBTCEhuY2r97v?=
X-MS-Exchange-AntiSpam-MessageData-1: 9dr41lbZR6X05lZlk3fiiVHwx0nJC6Fv4XU=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9c014c-0264-4f7c-4f47-08de6ad0fb4d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:24:53.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDj89mdw4Qt82exthHwfwoLcs3xNwChmi7aRl3DT3Utt5wofsmL4WOGyYO5iFrhiDh7TcTQ0XGDZ8HAb3/g0OUDwt5gI6l79/rQFvIiZwbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-Authority-Analysis: v=2.4 cv=Wb0BqkhX c=1 sm=1 tr=0 ts=698ed1c7 cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=3tr2qsFa3FZPBZ7I5BMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: lUiC_U_bxxbMYtAnynLOf6CQv0dz9AF9
X-Proofpoint-GUID: lUiC_U_bxxbMYtAnynLOf6CQv0dz9AF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1NSBTYWx0ZWRfX+50/5j44BqFW
 2P7tVzsIarKVJzRSsanVfGuBRB7Ig0DgXX8q3QKQDs7zBVWDZ32kMQ53VAcQGhlfOKjGRNkdD5X
 PMoYyoWK/4BLfnsgqTWdOiDGOUtCtgyvE+55h4xj8NCEb0wjxn8CljEdbgkNJZaDfD/8T+n/nwx
 H91pX/0bwSYWFUpLiVdF+10jmH0QjW6710NuaI9dfImEz2ku23PyGckvjpue9mkVQFtXRcdhE06
 lXMlW+7nBMpMiXQHLixX8G8/lX0h2oRorWgzbQ8WSr1OSD/Sk7Uvo/nIY6F7yUWINWkcE6RwWlG
 of2hL3wk+VfzLk0gbPXvB54nSPkPtD362UZ8BBmwM3kEwhtGc4w8hupE5bz4LCbS89+4TdHSx3V
 uGB8dTX2es9TlmBaEH/DRNAlKQutqga+1eu+iz7BulATAFklpR3OkwwM/WV/KgMDdHmyhc9uC+F
 PGHD5PfrlpPQEPtbr4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130055

From: Ionut Nechita <ionut.nechita@windriver.com>

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
- smp_mb__after_atomic() after modifying quiesce_depth
- smp_rmb() before re-checking quiesce state in
  blk_mq_run_hw_queue()

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
 block/blk-mq.c         | 45 ++++++++++++++++--------------------------
 include/linux/blkdev.h |  9 ++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 474700ffaa1c..b6104c672547 100644
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
index faeaa1fc86a7..953e5e4ee63e 100644
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
index 0ad3dd3329db..64a5ce034770 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
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
+	 * Ensure the store to quiesce_depth is visible before any
+	 * subsequent loads in blk_mq_run_hw_queue().
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +314,18 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
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
+		/* Ensure the decrement is visible before running queues */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2365,17 +2362,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
-		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
-		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		/* Pairs with smp_mb__after_atomic() in blk_mq_unquiesce_queue() */
+		smp_rmb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99ef8cd7673c..f0506af2fa43 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -515,7 +515,8 @@ struct request_queue {
 
 	spinlock_t		queue_lock;
 
-	int			quiesce_depth;
+	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
+	atomic_t		quiesce_depth;
 
 	struct gendisk		*disk;
 
@@ -660,7 +661,6 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
-	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
@@ -697,7 +697,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
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
2.53.0

