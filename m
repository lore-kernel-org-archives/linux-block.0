Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C171A08BC;
	Fri, 13 Feb 2026 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967532; cv=fail; b=dp+BpMeB8boa92RsaGvmaSH1gaXiWnGAR88iTyB0QumqdCfGGanFrUMtUs+2CVMtfStK0EhONeA2ROaYmvdCfThi9MGpkCCc/mEDPuZoWHu6jfan0CCded2nj84Og/DdQAwdpKvIaxh9tEnlWy6dMY3PUwKqR3m7z/m4059S2mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967532; c=relaxed/simple;
	bh=nA495hI3JLbGTBPmdCWhg0pSgmza9JC2Bx2Tm4G/+GI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WMulFvZ9aPP+MfeLY2Dv5xF8hGOt7xYD9D+3B6BUXKB3Dq33YWoE+gq1NbfQyBnr9UQIqX4o2IPxLBAybyYwY6dRnioqVIFXhiluk0dAI6fIklkHFIjX+bLFvDpRHufm5gchvTuMkV1EkpWfMMPEoG2uY4NGy8vxBvDzchxzWAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QWyyGnYa; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QWyyGnYa"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D6QQPu1457212;
	Thu, 12 Feb 2026 23:24:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=6n44ZWXVc
	1FHm0XitB62rbRSjRQuQzVcuT2YayibXQ8=; b=QWyyGnYaxg459pHdBvRzxHzxA
	H1FUttFrHh5Mb+bumYFy9EAxHoIAsEifGCtK3Vn7rpBPiPYvYOpYsN6tE/rFM8UT
	P9ZnFbxDWpxPYnIl1+sARxFG7zmqe2NPLWM901YHtBj1Wq9gax7t9QZ+F+mCDTIc
	JmeZoiqeT86ivZ+ZNOWcToor6YmCeJp0DOwzK4Rlb25I8FaW4tutp5poaystkKLT
	HOjkKckVU9bScCjRHuTkZrzeZvCKObDUosq0BdyoFJYs1uyv5XcHK4Y7BxU1TrCY
	XO9klU3R9J7xbkXAehKL3l3XLoTjC3n20/0hSShv11LDIffqiL4UHPQ+5wyLw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj6uyq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 23:24:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhsJ/cQWdv/FGhrl3DDs1kkmnWpirhlic/rnEdfSW4myskPWiMJLlwksJ/nQ1G4molCvD3Hw6XZDlXS1od4ajv0iewz9BXc/xr88fvx6Gq0CcVrT3a+BaBMthnPK53SBTTWeKYRt/hhWNhUdmVR7Xoc8tCLV2CxK85Iuz7aaDg/830lXhmlxZF3DXkyVG64OmSlc3y+r4hKkDSi4nvu0M5jqBjPPl2wr8cEorutp7PbPv3pJ8Qz6fx4DKq2wuVE3cVWpb7J4U9lutuoO1EVKBwSrumVTZ9BGPhofGTX26OCYf3XgeU4GGYJfTbIF//Ibjkp2o8r5bb9ztaw/bSiTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n44ZWXVc1FHm0XitB62rbRSjRQuQzVcuT2YayibXQ8=;
 b=h5bBE2syta0+7Hz5GSvWstmk5KJEtfC7k0cujC/7iT+ve9w3yDiczv4jWwe0C3DayvfHefAyS5xQ3yLzwWM6+XbUiRIpS1aOUMIclHrv1wjOXWWTdvYBVY9CWKZzScgR9YWpyFQ5iZA/dNjBkfAGDeeh4YkHxBl7JF+4o6iopKkV2St88HCcIhybQwODNHu5dPmdOKTf0tLIihwwsDl6MKboqPDFkzz0z3CrsA6jlzFhY2ccqbib/g+San5dVfXhqqd/0jKxR+M3Oq/f0XQmsEPIPwiCdOUr9KxnK6jN741M2KkqPxZF5WxiwluoCW+C+W4omVQzfcO5FTkE/1c4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 07:24:44 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 07:24:44 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk
Cc: bigeasy@linutronix.de, chris.friesen@windriver.com, clrkwllms@kernel.org,
        ionut_n2001@yahoo.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, ming.lei@redhat.com,
        mkhalfella@purestorage.com, muchun.song@linux.dev, rostedt@goodmis.org,
        stable@vger.kernel.org, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v4 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Fri, 13 Feb 2026 09:24:12 +0200
Message-ID: <20260213072412.28863-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 3946b45f-def4-4de1-98ec-08de6ad0f5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|52116014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJQQSmqieyIlzpaRL3P6RJ5uQoNjNFn0disvEL2qcaWMu2un6X6fe5kdp/W6?=
 =?us-ascii?Q?b6uuYyBjLPNHlbCaxBUjPGMpotXFKxbXXRF2glYDtRuM0N6uFtj5WQw7M17O?=
 =?us-ascii?Q?zGfUlDOJs/e0wTH3wwmiWpo5LWL6q04K+kBu7xY3WyH+obGH1qm5M30wOxve?=
 =?us-ascii?Q?WVJ6d3bK+sSHxliBOdA7dri4m7V4+UzV0JvpJS4ftlmBUHos9/eaiFk7wHR1?=
 =?us-ascii?Q?Iadxsd2Sgekj/eOT3Mc+KsW6WwzrWdZPstHl2ZdACK5xIJSlRWe0YrM/PRbh?=
 =?us-ascii?Q?vYNPxcjQpsd9Xpm3+Mhb5aGVWKkxTsx/oAjKjKpqi9UBl8Vo5wc2vUn+VQof?=
 =?us-ascii?Q?54PnT843XOjozXoxnvqpvduCGt9AQHjIJt15jWo9EcsC/19mzRLTkCR7/OVP?=
 =?us-ascii?Q?JdHZ2bAOaqjewh2adTK+3vO/jT4ZHS9tGAheFrTYLqDlXs3YJTevhkY+mKOK?=
 =?us-ascii?Q?rpohEB+11oUEan633MIzpjRcSCAQbodeH362SQ71SEmSP3jNGZVm/7ScWHkn?=
 =?us-ascii?Q?sR6eR5lK4BgkHDvbiBfKzAajKwrZS3TPBX3uPuQcfGL2+MqlU0XHEtsgMqD3?=
 =?us-ascii?Q?zVg2LA+NmaiZdL9XsaypbvsHO2/XARawymKkD+KVGk/qLbidIs2zda6jFqqF?=
 =?us-ascii?Q?wrbAocfgl/IKdSf6dlXEMtpVJZbtXxWA4EjkfLfWmfXIjHNcXJmXqFXoqjSt?=
 =?us-ascii?Q?l6aj2geqNvsaniXqnm1tmKJ0RRJ5Ki1r3iOpazCYqUsiBtgnojEg1bcuQGnu?=
 =?us-ascii?Q?lFk30wvGfkmMCvDHuLn8peB36z/ulTK/sFchMCPl2Xib+cKpDFByNtzVKE5w?=
 =?us-ascii?Q?ObQSdY7DrygVK0DT5ZhBBRmSAyZc1peDjBBe+C5KKRZ99j2OG8opasnrel6M?=
 =?us-ascii?Q?cwfYN7Z5x+wRTEPDJryxDiWag4ZOLYyAt+AjYSd6WvSu1ZtfA+wxrvpGXkYZ?=
 =?us-ascii?Q?nKwk26BgZ1s2IJSKg1Jowl2I0SoKgTmleH9LgFnnZBOll9eb+BAJ5OMe6W2B?=
 =?us-ascii?Q?dvLBBbh0QRAqgXWu+1dDphQgQW6A+zNZLV8V5mR2QwsYQSzpojku1fgTzCzW?=
 =?us-ascii?Q?HoxwMQAa5EpiZXZFXOAOPFlK3bEqTfGSTKhoKiaOsIlQLTb8O0qH5j++5Xv9?=
 =?us-ascii?Q?ukYtIyAeJA2fL5ax4VBhPczyD9Dl2ofpJmccsS5cnofEM9pOxl2UUnvJ6Lg2?=
 =?us-ascii?Q?VEEljZpMjIh+cvxW6IrZD8zNT5WCCkP8b910l6cjVEPPDBXGLUgHwsTl3UfJ?=
 =?us-ascii?Q?IUqtyH0zNsftCjO9siAvCbposFW5fc3mp0RH1w5DxsTUgDFvl769KFQdlU7j?=
 =?us-ascii?Q?03r09MjqImm3a30yfIusLvu3VflHpW6z0NKRhv3mu9hhA6Te/CsgfEP8THz0?=
 =?us-ascii?Q?8NU3zQVxmFlZ3FeRLVs8oiPvWFejwBK/SIX5BRZrsn6g/4ID5mF7NoY9QKex?=
 =?us-ascii?Q?VyEjdsBsFstkgVmCgzfvsx31pqgarV2xt/rOUtYbm6LtAANWFSlSCXOktOyf?=
 =?us-ascii?Q?1PdcnmVHJ+Fcqk6ZqUXPBRO9qWowjoftVhmc4X1R03z4RIOFwfiHC3Mhrkz5?=
 =?us-ascii?Q?AutcSP/NAopsVkO3+5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(52116014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTXzrPrN2DW4dbiwI2dywSY3zELWfB/BGOTj48ntAKp6u9GuEfgDPnTbbcth?=
 =?us-ascii?Q?cfjOTFLFxPccpJu1xmXQ9HRTyGwi/H57oDzvAdjif5ALKhry+bqjq098mOGM?=
 =?us-ascii?Q?2Pzm/Kg/+cH5hzyvbtdIoIXSIh/pACwqtTwFOlcpJLDNwjrwEfnKga01rBOU?=
 =?us-ascii?Q?NzANLc4mPHAEj9OtpDNa0sI0wLqKEMs+b+uv6nzvwKEwfBrirJEPHh3g51qV?=
 =?us-ascii?Q?EY+cMQrELVMgQwJPdAA06ue5WT3g+e3FvkvZQKDb/wGnJShF6ihM+mRMTaV4?=
 =?us-ascii?Q?AAKApS/QqNEcy9YSOYIcJ6ti8fWvpr30NJgI5zTloW0guxXSuGTBcm58hG2B?=
 =?us-ascii?Q?S+Pw04KVmMij7nq7393tgLUuOJA/9kQMMMdvX/gUf0hN/9wTz7xL+sOUhn6k?=
 =?us-ascii?Q?L9kiqkf2GzaGvlP0qcbr+yOjMWRdCfMS2dw/mWAdh/THDPmQQy1jklZ84pLa?=
 =?us-ascii?Q?h0glvny0U5GjfMwpJkc5v0F5brI2gUxac/FAgnYXgN69igc7Es3sH0k6QXaT?=
 =?us-ascii?Q?bHOZK3KouZ1FbHXhvV3v5KU05Qd7S3SC3J+MHZotMFlfEL1DrDF06KRAM4oM?=
 =?us-ascii?Q?mEq+pTg+8To30SfM9lJKjvFWsBQhRSU1VHgUQk5Jn6EzMzMiEyvK7a2Zk5+0?=
 =?us-ascii?Q?tgeNpXrfWxkCVB+h8J6+5kfMKpRjYN3rR90aVQcOfP+/IKbV3lAGptmsSNjX?=
 =?us-ascii?Q?enNZNW80FHb27jIrNTjP7B2bjWgE/dG2JxZERFbr8oIFeg8TtUtMMoIS8tRO?=
 =?us-ascii?Q?AjO1FtiIehtZfMOzoYu+WP+LEqBbwWZw81RimR+lJieOaizyi1hBgkQgpcjl?=
 =?us-ascii?Q?+SLE8OsrerUhRPn2yQGXtbbsgG6TinYv1OZawlKwiZFS7D94hRuAvV9RHUw2?=
 =?us-ascii?Q?Jj020O+4fkaZijxkd8hE2oJi3KFv6aWRGMfkfPFkacneqSKe03XH8K+dLvZy?=
 =?us-ascii?Q?pvLf9tHS554Fs0kKnejaKkJ5fz6Hv9TDgLmrRw0fz6kHCKya1Ud8Wl7fdm11?=
 =?us-ascii?Q?qzgIhqL3mY5Jf2TZ2fK4Rk9Zmh/9mdCqagfJFqmsCWzF5p+PenARL7CtHwP4?=
 =?us-ascii?Q?DFwsO9NtWYwTucQLFcykCKIFPj/DD9+TfhehNxTanLa8zyKMqlCWaqiP5x3k?=
 =?us-ascii?Q?R6Hi0lbSAiiXN1Zf0jUz+1aKAsoFktKyvRkey0FHUNJcy27cAnW9fsuVKzzr?=
 =?us-ascii?Q?k9hZiix8FD0x9iPgVj/5pgiSbwK4CGnVOajSi/UhD/c1vvNCJ521u7bVWiYb?=
 =?us-ascii?Q?/yN5+Go2MlnUOLOBK+PxeUMP3YU57D2XlugQJrFdRt+YYGMbp0MO/Kgk5fdE?=
 =?us-ascii?Q?nvlrIbtXHqHbXVM6rLISqXww7v5NLjL/T3ms+LIIc99A8RjCVZlH7v8p3JXi?=
 =?us-ascii?Q?q/QA5Z+KIQ5UqMSNXXo8wHBHG2cjEWvMysHhLA/W2ycK/0OugDgt9A+UpcW5?=
 =?us-ascii?Q?1TMByD9DQP8+6fol33hNKRDRPL3Wd8uburTfz4oZtdwijHAYA/Edel5LCBvO?=
 =?us-ascii?Q?7eW6N1xc8wweZWpBPxv6iCs4GJoqG8YN88IQ3AjPc2Hpqm4edGY1qK6VIo0t?=
 =?us-ascii?Q?x+51CxbEtUlpfrPYtYKPmv8+XdlmUwZOZ7rsmkB76dvkN2O1vKdatmyosffK?=
 =?us-ascii?Q?WYJWounKdVflGvXTMKuGjCdjsDbIS+wbQym24WzHoZUSSJarw5TLgAzoMyB8?=
 =?us-ascii?Q?pNR60jdawMdEcoV8x+zVCzc8vJiEQF46yflKn1uvO0pTJ0HTic/BbWhXHO5h?=
 =?us-ascii?Q?Mb/+5WSLY9oaQRpmSuVZJPFneIA5XvTxtAB5lKOKSLiEDDQRiSDwYqvVI/nS?=
X-MS-Exchange-AntiSpam-MessageData-1: /9t1iWXc4iDWrjzqBDhmI+ofJdvUOp04zhM=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3946b45f-def4-4de1-98ec-08de6ad0f5d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:24:44.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8s5xl+hilMZJqG/5kKFqby90r8ZG9ykKG6sfYxmI2uaWdW+4ay8IuSV+wuhAl2ojAXPW0ys00C4/hKf3aLg5B7U/boI0rhfHcglhPGKOXTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-Proofpoint-ORIG-GUID: t39__j9Yukxovcd0ChQayp59oM7JpC2z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1NSBTYWx0ZWRfX9Z1SAFV+viqz
 9+2lanuDa38eJeQZF8vQZdc5I36fUZUDoesJ66nZ7JVBemdGkzsypYT5MIvqtK6BIf5cLdZEwSU
 7kmVHMn7HGucdoVAhQOVri8EFlsFO8ycQJZDGyrFFbTcxEmPkxQlUhm5C244IibX7eF4uVDJYsZ
 Jh5cTS5ZObP2KDRMRjPg0H/hLJI1RhMw1r36/0GjZRwrOBxV5F9uaXcYc8ZmJlXL9w0TanpyxKR
 Ph+Tpziq5SuovNobjZt2IzdOHBiLLB5kHcTJNrhatLdSViaVorVP0FPoUAzrAfJK482GaeUUhNR
 VkEBLbwCOEd9uDQHNDjjFfAvHbF0nPZnhAT2hXyRKKWp62GBNeijlDD3wVFXtXEmOTFh4Ajtq4k
 awSOyofLkD+/aVCHPrUmHWWhg6wfIz2fx3EH1AhfzwaHXx7j2DvFr5UiQVYXXWk+IhnvKxu4C84
 Hjv5PVG8ggomT3v/bhg==
X-Proofpoint-GUID: t39__j9Yukxovcd0ChQayp59oM7JpC2z
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=698ed1be cx=c_pps
 a=O5ql0vl6PVxeYGQXc+vjrA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=9nd0r87i4cbtBJwJiegA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130055

Hi Jens,

This is v4 of the fix for the RT kernel performance regression caused by
commit 6bda857bcbb86 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v3 (Feb 11):
- Rebased on top of axboe/for-7.0/block
- Fixed Fixes tag commit hash to match upstream (6bda857bcbb86)
- Added Reviewed-by from Sebastian Andrzej Siewior
- No code changes

Changes since v2 (Feb 10):
- Replaced raw_spinlock_t quiesce_sync_lock with atomic_t for
  quiesce_depth, as suggested by Sebastian Andrzej Siewior
- Eliminated QUEUE_FLAG_QUIESCED entirely; blk_queue_quiesced() now
  checks atomic_read(&q->quiesce_depth) > 0
- Use atomic_dec_if_positive() in blk_mq_unquiesce_queue() to avoid
  race between WARN check and decrement
- Removed the unrelated blk_mq_run_hw_queues() async=true change
- Removed blk-mq-debugfs.c QUIESCED flag entry
- Uses smp_mb__after_atomic() / smp_rmb() for memory ordering instead
  of any spinlock in the hot path

Changes since v1 (RESEND, Jan 9):
- Rebased on top of axboe/for-7.0/block
- No code changes

The problem: on PREEMPT_RT kernels, the spinlock_t queue_lock added in
blk_mq_run_hw_queue() converts to a sleeping rt_mutex, causing all IRQ
threads (one per MSI-X vector) to serialize. On megaraid_sas with 128
MSI-X vectors and 120 hw queues, throughput drops from 640 MB/s to
153 MB/s.

The fix converts quiesce_depth to atomic_t, which serves as both the
depth tracker and the quiesce indicator (depth > 0 means quiesced).
This eliminates QUEUE_FLAG_QUIESCED and removes the need for any lock
in the hot path. Memory ordering is ensured by smp_mb__after_atomic()
after modifying quiesce_depth and smp_rmb() before re-checking quiesce
state in blk_mq_run_hw_queue().

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 45 ++++++++++++++++--------------------------
 include/linux/blkdev.h |  9 ++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

--
2.53.0

