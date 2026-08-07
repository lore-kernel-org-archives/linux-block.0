Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6A2DF13F;
	Fri,  7 Aug 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112559; cv=fail; b=cMYW8Owc5MJ7Esbk3/3Q2Sj1D7A8fQnSiZEEXsFSHWnwGz80FZd+UXw1764uYLSGSC/E2sj4buWEf4/I0jUaJYoXQ96Q6xF7QP3SUKAH5Q8bcjJbBBgbCDX2v79vXXFZXGkU16ix1QqsYUbzCy0n+mFZmYzh6BYg3J7yuewBgrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112559; c=relaxed/simple;
	bh=frZ2sZQPcHm2GnWvvo2pVbdpmBQiukH7ihtEeT65550=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8C/SGcamsORh0y0KvQhQT+95QEx62bVMO39QEnLorfiLKz8L1ADRyPYEQx0CkPSpobDq3gGopD2ypaedykKb9RSSMC75Q5FsUX8hgqrrzkVB2QqotzeZUW/CFkVoCt/H/NEwSKsUlkbV1NpQd0MT+31DOX02Hy6pk4o1O1F1Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QwVnsa4l; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QwVnsa4l"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Cf7GR2656775;
	Fri, 7 Aug 2026 14:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=frZ2sZQPcHm2GnWvvo2pVbdpmBQiukH7ihtEeT65550=; b=
	QwVnsa4lsIYdQHlAc1RU6hClTP3/Uozd8aSV4LxciMvBAeZq9Jex7+XEG0nDThjt
	cNj1NudV31qRr0D4HKAGxB1Vk3pBu89T7PHFH0pg1s1iac6RGM9TVq7Kc2xiDr6/
	z0yL5HG02b7onPk/fT4n2StmbVvM005xW5exaF1hHZFLhLsy2iJuEVCKUntsFHON
	NSHj/V0ieST2D4rnjLTkzrMCDEAssc4HmWj4fH+TT0vosWeUpwZkWt9KbQ2coMt4
	+COzXAixcQulaub+MZHrn7e2PRV+djXM0l81+RpjkAI/EW6lnxZzz8AA8nIGdHC0
	nTTf0HLcPe4ruLCAiQQWpw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fvpq92t2j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:21:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPyktjaHy8078Ufq5lu+oKIZkhYHDGR4B4+Bm6nHegvxMyiv9GVFw5IB98gDIZFyCJrw++5lMO5FMikd2oAesLBcNEAe/96MBO2BQd/StEFWjj389unwZbwuz/loyi7iNM87QEX6HuqYLx2R2QHGy31gzJ4kQwfINT9FM01BSCdzbBihT0Opr1zylhmwfkdkISxpZq+1clvoKaC0IbzebXn8YxPr6czl04bwxOa5eIDpWunh06DjoU0o32iSL2dsLpiF4C5EropCeW2AJ0Y64S53Fj4sjgJ5F8hTJZ/nQQfJNJk1BeECDDHfQ2Lb6GHwFRNBS5bJqz3a4VtzllRudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frZ2sZQPcHm2GnWvvo2pVbdpmBQiukH7ihtEeT65550=;
 b=AffsKhy7lsQb1tjjy6890DMqhDC1lqFA14n0S4rQMUvL/Xj/J/UZUewcInb0VfvIKWaHhllNpJux24LMmb1w5evcOWUwvhase25fwAmKXx34e9F1/zzU/mZv1KS2WOYPCqHWwpJSRFQq5Hp9fqhf0WRyNvsH98BkBZx+wwCfwMrpq3YKlYvGd4WohA4ssVhhtkCTKz82EWXVZfNhLZIUXLivO0Vu+QowO3ZC4F26h8EPb8fg/TBQWXzkg0fw0OOoyh9xVXg6SffHBikRYmwynuMj48ELf+D4TCaG81t41XzLpuQj5/BHGa1ONWyNuoW2GzQif8qNEwIljlZyNWDq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:21:20 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 14:21:19 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: atomlin@atomlin.com
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        bigeasy@linutronix.de, wagi@kernel.org, marco.crivellari@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Date: Fri,  7 Aug 2026 17:20:45 +0300
Message-ID: <20260807142105.382726-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CY8PR11MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: cdca0498-eba7-411a-772d-08def48f257d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	xZKWD2weO6MYi4V9KEvCGjbTCXGglIFU3qfRoIFaDb9flCTioLrITJO8vekRUMUsSJLR/b9P9a4y8ONx+uUmzmeA551jX6zxNHr9ryi5h13vxY/BMd40GyIdbcdjIgiSSWtlq6Wo/jj+P5UHA4lFjXogMs6YV/bswisWTihAuO76i53n+NFY53L66lTYNGBzOfxXVL7tNtAWmUP+UIvHPfPyrM1c8esSapT8LeFAPherab8XtQGBeKynIgfi/eYqnNaGNCt1wd/6BYfAjT4qO7ZMYj5447Sdc4rb8Wm5nWTHD3aU6FpLaPvpLx/ZIBM4ONnS1jmezPU0EhgONOB7G+0fXlHhFndUvtBxpvBpl58Mm8RiCD08ZnSnSfbHK4tp2NLB+t1jldgwHkBUibZSg/uVrQId07OGQyeEipT/16dnxoa5+WuaJMndNrCoPgXHadU54djwoo5PSDY5/uLkD0MdWzUJ4JsXShPdY0+l0Z9Kgk3IY2pH3rAWIXwoJZY5l99xRdeGm8ueRa/Zm/K6Fvj1JVp3WsPtIo8btraaSJQkMQtazb8Dqw6sEcyuCWlEoJL/+kJnFEPfI83IJ8/THRnG6E/E08+dvMe1oVa7lnqGuQ5d0L2+hCa6GfXh4G2cCjPxBvCGh2P9QnzTHq/ga8b4Y8SKs0TfqYu/Q+y3bg7qZWNeV3PjBJCIsMbtOV6/f8xtF2RbynFzx5uO/vCMOahbcIl85Mf6OWrijKGmJB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/adf6rGhv9VwgOreVFmlvZTfhblVvh7b+T0SnYGknkgBIKkPu7Pum6qUw+g?=
 =?us-ascii?Q?zOiF+xQfuSb+BmAqqIzNnQjjwfo4Pgeg8uQ/r70GoZfsuzw6uAynARkVhZga?=
 =?us-ascii?Q?sIHvT7S4kFpchrJYmys3UYV1ijfL3GSDp1cqUNo89iLbFhVgDC5+D6IN0PdY?=
 =?us-ascii?Q?hVmF0h7Dy1hs/ebRaUkVN5L3dvZNb+8RBAUIn2RbZtXkKfqgCnokeAxK19kS?=
 =?us-ascii?Q?jbQSN3cRURIKK/y4yHuVL5Mr1QJuUEWIWtenOenXO31uLdcE6HzIOO7ps0E6?=
 =?us-ascii?Q?HfmiJcZJGDvOxUirXLQ0vpVZLQLGPA+24tur3j73WtRLfxC22Go3fRCSoSqa?=
 =?us-ascii?Q?HebFRqrnuLhJSLsDkNvIm1jWGHj2UUoasEsvpzlIxSrzhLlg0MbIzdZK5Xy6?=
 =?us-ascii?Q?vJeH0Eh/NU8y/pRes7suAzu72Jqta+JCdUuufQRDqoBQqJiF/+hsOhCiNlDR?=
 =?us-ascii?Q?4q5DMy0FyZ0hZ1KPMD1kdJ19TkeW+p1vCrbrU6xKBvXAXSYDZkAi1Mp0SybX?=
 =?us-ascii?Q?e/KeiuXswYlJRBzY9GfVwvNkyvxai+r/fCFTTKXnZJMgrdznVsn15cBJZqYm?=
 =?us-ascii?Q?5cku/HMGnIJOwAalYCs3XFf9fGu12ZwLsGn2ttW09uPCEpmGqJ8IRmL6Yh5Z?=
 =?us-ascii?Q?G9Xmp3o3BRT5Vd5vbgEyBn8Jjxbax1AIT8msctK0mOwqVtZk8iX7V/7etJDg?=
 =?us-ascii?Q?nsFvOM8ALBlMqYcvnP4ns+tYIOl5xJWjRTrucJwm0h32AW7lYGLIpCeb84wk?=
 =?us-ascii?Q?4Mqf7MjiWtXiGUJFFPArqkBT2KVv1F7xGYIdRzcJoc93V6yH2ROqbI2OaZt4?=
 =?us-ascii?Q?ffwfp1xPhwD9RiNw5LRzwlQBKOm4/mC5sO3Lks/4OpJMcNs1O/BPZ80U52jb?=
 =?us-ascii?Q?sY1129iaIT0il2bwO0HOY3xeaBm/cUpexCxAFdyXMFgIu4aKe5GqMqAF5MX+?=
 =?us-ascii?Q?hnNABGK0zBOROpmA8chc2tEXenzbvY9btfsWN5s4yxQOMILm843d7OszmiGE?=
 =?us-ascii?Q?GiWSN53DZ5ShdrhnY2wQ9Y9Y6/8W+VlG5xxNcwWcNBx6SJ5vYQ8FePGHqh0F?=
 =?us-ascii?Q?Im7sgk4EVOEQ1n70iczzNhrz8Nx6hvXxaEmjriG/lcA4MDtErxOnrQCOo8H4?=
 =?us-ascii?Q?BfGWbbkJdXdFe65QGjgLUHOVMNv4ULlBNkXZskK18Sz5zTO695SX3BYsoIB4?=
 =?us-ascii?Q?YV9cZfh82DnMP/AF5roQHXCbhmFV9sbsXHOvpZYnyZGCtVVLS6guUF1ciVVT?=
 =?us-ascii?Q?Yu8cv13N2xEW/quBRpdehalXYMbWc9otwfahgzKfZeeaIXT6gCEGQXFXBZyj?=
 =?us-ascii?Q?6cW0osNZgY/clMdWRPdfcC7EUPGE6nE8WNlGhdJ/5oMZNkteLCRe9R/hDfZd?=
 =?us-ascii?Q?sv+0ktVDIa2DjixWNKOODuR6Rpn3mkx3w88sj1cyPGIMWGH678kqPVxkTTaz?=
 =?us-ascii?Q?hUCG68JTstB10xHciFInKBtG+5g4SY2GEXAf3XR6DPZkaZlLZWNAE64DUyns?=
 =?us-ascii?Q?dssI0ap+EVV7e0mxkg+EnEh5xLHedZ6utm4gz6Mexx4By5RQtWutP37uSQ12?=
 =?us-ascii?Q?/HgfdzA2WDtzrL1z5B2yGrhAz9DPKY4jWs75aUMYhMgu8kr/SrGwJGxg39m2?=
 =?us-ascii?Q?Bi7XDNpjnsZsLAdA+3cUUNTsROs12o3DvqpHkVQ7zyyloW6hNKs7vZxogI2Y?=
 =?us-ascii?Q?KZ3gC2pCmccuUGfmjpN3g+MAQB/ov53RIWTPeSs32jW2oAVhu/B5l+b6pBgQ?=
 =?us-ascii?Q?0fhloFNPSa8A1BqJEWWU3q3zItRaTHw=3D?=
X-Exchange-RoutingPolicyChecked:
	BCJD9zbvqhc4wgL8ys3YUD7WN5aUmLbqPUPkTQAEyZIWT5U10zvhYvLi8Sz5USnEO2Hag+dZvzsgm1K78gYlhzWHMC9qSKN2G5s8tInwIfVp87MsOkHP0KeCe0LruGX3Wx7hIBeLQw50C0+Sqr8pBs82lvVhgrQRbSqXZjre7a54KH8ER9TL/bPGgLN5pCsgFmoBBBqI80y4sWB9KoIYHEBLByA44k4KHmUvPINDCVbRfBpyZfDCIWsQtYI6wtpsRD5Jlr6MTLVP7ChCfPidVF/qjIakk0Ju6ZzfRzXc8BVZ0yowfNKPOEMxalH+mfUJRY+gmevjYAsHlFNGAZCwww==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdca0498-eba7-411a-772d-08def48f257d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:21:19.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwxRBbl0dwEYvqrmXuazQB1YkFHlOo6MUQ9D8WFEKek2gKtxVelokOhZN5JSZ6y3DrOl1KZzuA8JvPOiQXJ4WnGF+DGOuHOlwJKebgkpHfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7009
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a75e9e3 cx=c_pps
 a=mt+QW+PagoHSMqpqf5GGBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=uQJ4LXeR3KBhi08MnjIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXxLbakqp3qbop
 oYT86Tqn7N91QamGY5nVAppY3EKO43U+9lvr3YnEMxPReTb7+rq2fmtc0mExOpnGhbtCkOu8t4H
 Jeblvh8ix8KaXC7++te/Uw4h48/AT/8GO5NCA5yZavdQfvfnaWuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX53ctnK4g7BIg
 b9+gS8vFL5WRjeMxjXW7dc4cD+ib2yhWdVSv715G5ux2w1g2X2tOt0hxaJwZQZEpiHwq1xM7/FO
 fRf6Ociyo0VdGsDR7/TROq8q2arc4OiPIAKi7kMY1LrGWlwsJy4GNufVl1bNwFYSBdz8FQPeh2h
 +6AofrkvBBjD1bCcKtHPBGoGQ+s3lkFBicfOnB21HsoumaLxlS5r8r4FHtILh40WyF5OcyDtYkI
 MUp2V1O6LGouMQjRsbe/8/EyjShFEwj77aVzLMN+heCWTm4lWZi4gUizjC5c+hykcWkEvjEwq8q
 c20x9H5o9mgyCvJq/JV+0Rh0fKWfhymbmiUeBHQPAUU5avmtYOwEHp+9jBjvKp+xHfLhEYAxeAf
 789ca+/4lGcs6iHsCpLidnp+/raoCZ1JbmCszFTgZSzlKGyieWdiU1b5//x3s+5FnOV5RDXFuiu
 EHbLKNBHjL398WKghHA==
X-Proofpoint-ORIG-GUID: pxLXeC-1bLfiz9GpYFk8Bs64PZp2NBb3
X-Proofpoint-GUID: pxLXeC-1bLfiz9GpYFk8Bs64PZp2NBb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

Hi Aaron,

We're tracking this series downstream -- the managed_irq best-effort
gap for blk-mq/NVMe queue mapping is exactly the limitation we hit on
PREEMPT_RT telecom controllers with narrow housekeeping pools (GNR-D
144T, most cores isolated, 24 ice PFs + 2 NVMe).

When the next revision lands (with the naming/integration changes from
Sebastian's and Marco's feedback), we'd be happy to test it on that
hardware and report back with effective_affinity + NVMe queue mapping
data.

Thanks for driving this forward.

Ionut
