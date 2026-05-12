Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4425B0A4;
	Tue, 12 May 2026 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567438; cv=fail; b=GX0T03kJP91UXYuZf47cH/L/k15sZyKResRZ2G9ZM99/CYR2HlKPUhGyw9J+iq8QBG2J9+GzDIiAdwzL1V02MC6TMPmwEUzr1dwXbDn/8RwEEAhaDKT7cVH7l7wy5LY5P/NBHgc7tThMjjjfVjDAq8zS4cQQvIGrTf5ZD1h4E8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567438; c=relaxed/simple;
	bh=dBNWRIlB3LXRVdENWx6TFcy6ZXrEKj/DP29qgGd1mr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avHVtMxpS09jyZiVD7+OSRBk8sfeXv0zkXaOQ2C59q83WdYBQALkfPWz/QBChXWTmIsy9vRLg/kBwVoDxxvSF/yqan6UTBoUGTNGQT985C2+kk6Ob/pPUHtuRncDuce4ziCmf+cOrM0UOLiFhyBOw/7nhsihE8EFW+KHbkARESE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sG8m36l8; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sG8m36l8"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C4iIgF3410609;
	Tue, 12 May 2026 06:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=PU7rNz69BmCOy/JEkHKHWmGn/qoMNZE5leNC/prBp6M=; b=
	sG8m36l8NCx+GQ72kh+36YWIKcFxWmKlwoKJcTOIsT+KiHmXGDxnTntxZIj24Oi4
	1IlJRB9lq2tSQR7dl0dTZo9S5Mk6I6lnUzZKSgvDvYJQCXobUrwUdMH+ihlUWfgk
	MHZTjYk4XXzv0W1xXuvo43oOk9qYQAcz5WdbeAsEjLVpNcexzD/kJe6WZfCFqIYk
	b56jkfBVHP3Uyg2y4B6uze5FcCUbrExgDypmBWRfjGZQASO7uupVx/Dm9ljUg+ga
	scEPGChI4y3GyHpFqw7bxdGfSSSxH3Vko4MZ8OM1Jn2SWv/rvA+jeu39hwOgyRgd
	NzRkG4ZyNLe9XopExYlRvA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e3nvhrgem-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 06:28:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkUSWBYd24bWzDco7PCxrq20fbrfbqCerJX8d0OMmBATZP+CPYK9fpxoVzmLARMYJG/zf5lLaEybGRh7ubuvWfwEj9A8PHHKJbYtpNij4p/0ErTl2EWMLpf5ZsQAX2PFpYvo9AsIP7GG/RecwuOl5HdpL9eFarqsqSo4vQeSVbiHIh3pS2lzYrvz7C+Bm0CWLxE+BHbv7kOYBGYVwwYY1G+VH9/hqqTWry9GELeIpkRZQ4kyDhXMZ4BMQd4hivpai7s/CQmSsxe33ueWihXEFZZPVWjUf1THH0amOE7jzyzD3txGsvJFkp33h637pDYhgRzVLbLsLFuyniWA+Z0O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU7rNz69BmCOy/JEkHKHWmGn/qoMNZE5leNC/prBp6M=;
 b=UEcUbyiEvwCpIH826mZZ2FqfLIs2i7LGjab7EvEJ+qLG8CiOviJkjEiFbjNJkmxv4vhgYIuUtB5DJt6nwLrQFOCu2tKdVOLLp329nX43L3u3lrz1wgUjrB+BxOOrri+I35cGLET6FOrHjWwUhuNAEmzqhP52n2op0zSIpgPsQDKylePKr0hFOYOoM5fT3Q3RUV2iN+/HbW+0sites7Zx68HJ+AMQsneJudeGdHsWO3YwR+sdwgVRKOqCPog5anLAwlOUu/IBaepV/U9e4w1oBVWFXePEKUDVUFzjvtsmpNALtpKL61qEg8d+KAzNBjl0Z49h47ezsdorifVBhOnAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:28:35 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:28:35 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v7 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Tue, 12 May 2026 09:28:15 +0300
Message-ID: <20260512062815.10815-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512062815.10815-1-ionut.nechita@windriver.com>
References: <20260512062815.10815-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f386ae1-c79e-4311-d580-08deafefb21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|10070799003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B4PmXTjVa3o+PPVsajTQpOvIV3G4O6NN+AixPF+KIxlXBx0bgZ/lXbl55/7iojiwe2qb4gWVzArWKGkOUdmu4tVfXNWbs6How2iztWt1kxHw7I/wcSIm6fZjCmldU2pXs1jiyYBundq9LnPTeUEPn+ykazxoJxkYRT+aCBr5kcWm3E89kKRkvTQe+0TVwinz0drFI2si8NAhtcCUlfJobiXedtvfEgCeuDIqZRUtHQTHv8VVYtdd/ACQMTMomuVhlByHS9ZTIWBlw4z1dTj53W8w64weFqPM9REy5XfbB28G9BYGyPPj27O8iFAxXcguvlPBMCVsVnndujoQCH42jrYUOKHaWL7DkxBrRzjQsZmehfhue/te59yHjC+C4lz82G4GI6OafbalA8+JkrdOywv/8liJui5BLW9Ziv5pwXyVXPH/VXDjCFodbvKI96XzRvjl2H3QymCDj5sn+O93jaxDYBKRQzEuH2bAVjapy++zr/g11HBf4zm6frMYccgXNe1flEXBkzldz53U0yWlvldh8h2WM/+iTp4sqecwW3Ov6L2TT7wE8kJTqSLgmqKkeNYqVSrnAlran1XgOhExeLAvIfG2fn9CuQst5dbfopyohZ0W3Vi5AQ7Kl0eQzM3d4kvjvkEpRwSQxBeGWfBSIAS0Ry71S3cwNyVeDioOu+9Z4ZSQROuZpbnSHDJkujCW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(10070799003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/QVMq4gemOEoiRVY9jX54xCyAwCTt9V5sSUcSBqItZiJRZHx8qhcx5DlmPpo?=
 =?us-ascii?Q?A3QXkgrYJXH93owXXkMkDhfQf/kl+Xa5KPIE+HvFOvAOcxvFg5yvuMJSYUya?=
 =?us-ascii?Q?X0wG7tAkUWHALpxa7NWdv0OmnXNPYC9gntGzN1yJS81Lf1l7BxnMTi2i5n5b?=
 =?us-ascii?Q?89lutAi3PsjAyS742DijuSzBpN4p54fwDdYcp+ulC7A7D678s5BV3kGMrw8p?=
 =?us-ascii?Q?WdALIxuqOp2TnIamRFsGDuo/2YeyFJQX3Oje+q0GYr/sekejaxL8a70hWqtL?=
 =?us-ascii?Q?BmpgSj+fFdlNxbceWsk4eq1ugNModIBZ/AC4CfHzJrJrL5nuv14TkLD6MXlu?=
 =?us-ascii?Q?j3GLGiH3DLlBgb9jZQJrqaJzKk6+eejNHJzQKxoqk14aSxKvH7g8JPMH5MbY?=
 =?us-ascii?Q?H0tr5mllKojXAjYNsWJe3H4nkFj74M1rjmHZ3lFU5Oe4MxZgNSejZBQiphPd?=
 =?us-ascii?Q?PRBRtHJI8tbGnynf60Qve6nchdQV3YStmFYTW+RV7wZ/PfEm1YW4aw0uBImT?=
 =?us-ascii?Q?oGSue0KDko0sFUWWHCIU3i30BkuAVqDFxUPtFTnY9t1e/DoNqMf7mzQZKaag?=
 =?us-ascii?Q?jyHCUEJy+68UxfQLn1qUxPYk9s9GGSeGHDXA5fQiq/7yJhLmTqVml2iKR+5P?=
 =?us-ascii?Q?+epCDTyEcZ/ABn7kEiadzhCmBsrfNZxRteKyGOhTiEW0+uSdXGQmO1F7omVn?=
 =?us-ascii?Q?MbwK8qEx7Y0x03ioy/kB1ox5s6ai5mxU9argqkUbq7wisoI98E9zydBn6xSz?=
 =?us-ascii?Q?3ggrfLVhiADOFH2vK6CMVGkqwGCWO5ujk6Gduul0nSEI4y34kZau2C/I/bjn?=
 =?us-ascii?Q?JwVjw/Dya//o+gYihjm6eevJODJID1L+g9FMxlw2GEZgvNWwwYSRY5xNoxwB?=
 =?us-ascii?Q?xcWpDUM6LO41WqWFW2CG6ZxHRn7lkx4H1uE6e284UakPEkrHqSQ5gt9x8o6c?=
 =?us-ascii?Q?L/OCPLtoH0/UtXsiYsv+RY4bCWtpONnX9lPurcZhdK+TzG+xbjzdgV9cz7lX?=
 =?us-ascii?Q?0lKvgYx8At/rFB/BfEjL7mLPPHynZIeme1YkafSJRlQZjFcMuyhGxW4HV1Uq?=
 =?us-ascii?Q?YsD+EiQMNyvfOrniJRBBQoswS+xvxafQz52aI50MnZvKa1oHrRVyayxMnTUX?=
 =?us-ascii?Q?aJvwlmGzOO1Jeo8e5taK+syLV0RWxEXBW7jctFEuQGhTsFhKkkXcbynw0Iao?=
 =?us-ascii?Q?2mX8Snr6v81B3Tssm9yrbkWLrIDEHUXbhJgsWgVP8DQfz7p0lzwobvKPSqVH?=
 =?us-ascii?Q?5hPXP+DHkbmkZfaN75XhW/+cx6kW+xiSLK/cp+Tp4o1QQ7Kaep4k/uzoo6eE?=
 =?us-ascii?Q?LM+dvj3ToNeMNtXrvVJKFis7nRWMXfHqSB9WmFbRK98Ba9uxqiP0K1vQAfLQ?=
 =?us-ascii?Q?9ajjM32izTR7kNqxaZg9SmBFcZS4YMhTbg/aw0wYnHgCMV0qI/IuIL2mxMew?=
 =?us-ascii?Q?m/zECfdCzyiL+KcbeAmu6l3udHDDfdGImSKaAKfBERKcFPGlW9s2kc7iHzsR?=
 =?us-ascii?Q?Rd5RgNm6KpSlXZlyYX535536tH6hXa5KrysdwfDrrVXc4+xpSfe241BqvsdD?=
 =?us-ascii?Q?GkFVlgNNUaN1kkB7V0h2d6ynPmkvP2JauK5kDGdJjk3wnBdAH2VEe/D5shzA?=
 =?us-ascii?Q?8ylhLkYgHNfctqXC8ohNJfxSi/nCFHsO5oWh2Ks9B2PDl+5dLiblt3Y0g6vk?=
 =?us-ascii?Q?BxQW1zJX6+nluI3u11UdkYI142rYoVYviQilZENi9Zeay8efmcW3TP5tbxfC?=
 =?us-ascii?Q?946LOnL1vPG/+chpHyEND1q1WOZlK1CU64vQyK58WJSHFlBPtAojmHOR4Gro?=
X-MS-Exchange-AntiSpam-MessageData-1: 5poYqhYH5vQXaBrWT3bhNJCRIUBRR9SZfso=
X-Exchange-RoutingPolicyChecked:
	SBfNohZhJOKjfL+cdjW72SLaZEldtWAXUKTEKu0J1W6ZH3GFn1HiBV/e5XosO8ktCFIeVBwkk20REDDCm+IFC9E/2eJUv06FUTLgiLZ6BQNhKURaTE2W9N/fbWD9Hy2+kxRIyd2V6p7lp66QOGmstPEqoQ8TdRrrk2GKANPk60TzC9na8OjjDe3hoAi/0eO7eW2hoD1DG/UD4OMbLG46lWosPobat+8PqOE61tzAhKt/6qEnaDM6RfsbNg1n19AenDbpXPFXTeUFlRRsvjQLRGl0eLnUGYzReH6hYp8mvF69uv5nqCWMKsdaYCw/j98qbYwKFkbgaxnGBrEGofJgKA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f386ae1-c79e-4311-d580-08deafefb21d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:28:35.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fbKZ9mb1e4ri8TETP6u/ZmsNTke1amT3bvm+IjnuiFSt5adFYOiodo70Edmk6xE0MJ07+7VXD2bPdee1VKOKJo46xyDyQDW3PU6pS3fbYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-Proofpoint-GUID: L8EhgWKJlAvlKZNRRZ_seZBwDimAtjTN
X-Proofpoint-ORIG-GUID: L8EhgWKJlAvlKZNRRZ_seZBwDimAtjTN
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=6a02c895 cx=c_pps
 a=hjCSP9ZXGz/ZSNNiZYHiPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=zP3pESXazX5nb-h-ESEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MSBTYWx0ZWRfX9IhPAkclhH2f
 j8GLhdNouCJaJCdK85rRHSr6hQcxLETiEXJIJ18nvTgTpyp6LS/4hHY8Gbul8s4i9hF3plnRJsm
 VUR1zJgd1r4CjgMB28GJPHMQa7OUjbCqM4mc1uT1Wt9BDd96D/b5Aa9Lo0HW97P+hj7UyXa9ukv
 tP6tcd09e0Xf6+/GoHgbyW5e2CRJfEhxyKymjYAIs09yrFPFdnJhH9MRtoXP8VsSyVgfRhRsR6x
 49zZkUV6hvvohByrNQioOLW7S8jbWToNS0Wu/C7W5baSQaDNw/B9h+LThbxKi9hf5I259g5tfAO
 4dBUsZ8+yDFcn5BPduaZXe4TebOIRnLrD/GmdygKdg2m78vDwpyNNbudqFKskGGF64U7zl0S5jw
 irk+Pyx/hMf+3wKTb3ttm30aCf7eddUL8QeDsw3OnS8zAqZUf92taiR2fapbDR8VfciJKY6Hvg6
 j+Tmcr5tX/6THJnDD9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120061

From: Ionut Nechita <ionut.nechita@windriver.com>

On PREEMPT_RT kernels, commit 6bda857bcbb86 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes a severe
throughput regression on systems with many MSI-X interrupt vectors.

That commit closed a store/load race between blk_mq_run_hw_queue() and
blk_mq_unquiesce_queue() by taking q->queue_lock around the requiesce
re-check in blk_mq_run_hw_queue().  Its changelog noted two ways to fix
the race -- (1) a pair of memory barriers, or (2) the queue_lock -- and
picked (2) because barriers are harder to maintain.

On RT, spinlock_t becomes a sleeping rt_mutex.  blk_mq_run_hw_queue() is
called from every IRQ thread, and the re-check path is hit on the very
common "nothing pending" case, so all IRQ threads end up serialising on
the single q->queue_lock and block in D-state.  On a Broadcom/LSI
MegaRAID 12GSAS/PCIe Secure SAS39xx (megaraid_sas, 128 MSI-X vectors,
120 hw queues) throughput drops from 640 MB/s to 153 MB/s.

Take approach (1) instead, and while at it turn quiesce_depth into the
single source of truth for the quiesce state:

 - quiesce_depth becomes atomic_t and QUEUE_FLAG_QUIESCED is removed;
   blk_queue_quiesced() is now "atomic_read(&q->quiesce_depth) > 0".
   This also makes blk_queue_quiesced(), which is read locklessly from
   the dispatch path, a clean atomic load instead of a plain-int read
   racing with a spin_lock-protected int update.

 - blk_mq_quiesce_queue_nowait() does an atomic_inc() followed by
   smp_mb__after_atomic().  The spin_lock() it used to take only served
   to publish the state change; every caller still follows the quiesce
   with blk_mq_wait_quiesce_done() (synchronize_srcu()/synchronize_rcu()),
   which is what actually drains in-flight dispatchers and makes the new
   state globally visible.  The barrier here just keeps the helper
   self-contained for the few callers that defer that wait.

 - blk_mq_unquiesce_queue() uses atomic_dec_if_positive() (so the
   WARN-on-underflow check and the decrement are one atomic op) followed
   by smp_mb__after_atomic() before blk_mq_run_hw_queues().  This is the
   write side of the race fixed above: a full barrier between the
   quiesce_depth store and the blk_mq_hctx_has_pending() load.

 - blk_mq_run_hw_queue() drops the q->queue_lock around the requiesce
   re-check and uses smp_mb() instead.  This is the read side: a full
   barrier between the just-inserted request (the store that makes
   blk_mq_hctx_has_pending() true) and the quiesce-state load.  A full
   barrier is required on both sides -- this is a classic store-buffer
   pattern -- so smp_mb()/smp_mb__after_atomic() rather than a read
   barrier; with that, at least one of the two racing CPUs observes the
   other's store and the hw queue is not left both un-quiesced and not
   rerun.

No locking remains on the dispatch hot path.

Performance on the RT kernel and the hardware above:
 - Before: 153 MB/s, IRQ threads in D-state on q->queue_lock
 - After:  640 MB/s, no IRQ threads blocked

The non-RT path replaces a queue_lock acquire/release on the re-check
with an smp_mb(), so it should be no worse, and it also stops taking
q->queue_lock from blk_mq_run_hw_queue() entirely.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Fixes: 6bda857bcbb86 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 69 ++++++++++++++++++++++++++----------------
 include/linux/blkdev.h |  9 ++++--
 4 files changed, 50 insertions(+), 30 deletions(-)

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
index 4c5c16cce4f8..c6aa49de6d1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,16 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
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
+	 * Publish the quiesce_depth increment.  Callers must follow this
+	 * with blk_mq_wait_quiesce_done() (synchronize_srcu()/
+	 * synchronize_rcu()), which is what actually guarantees that any
+	 * in-flight dispatcher has finished and that later dispatchers see
+	 * the queue as quiesced; the barrier here only keeps this helper
+	 * self-contained for the few callers that defer the wait.
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +318,30 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
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
+		 * Full barrier between the quiesce_depth store above and the
+		 * blk_mq_hctx_has_pending() load done from blk_mq_run_hw_queues()
+		 * below.  This pairs with the smp_mb() before the requiesce
+		 * re-check in blk_mq_run_hw_queue(): of the two racing CPUs
+		 * (one inserting a request and then re-checking quiesce state,
+		 * the other unquiescing here and then checking for pending
+		 * work) at least one sees the other's store, so the hw queue
+		 * is not left with a request stranded on a now-running queue.
+		 *
+		 * atomic_dec_if_positive() already orders the decrement on
+		 * success, but spell the barrier out so the pairing is obvious.
+		 */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2362,17 +2375,21 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
 		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
+		 * Re-check after a full barrier.  A request may have been
+		 * inserted before this call, while a concurrent
+		 * blk_mq_unquiesce_queue() drops quiesce_depth to zero and
+		 * then runs the hw queues.  This smp_mb() orders the request
+		 * insert (the store that makes blk_mq_hctx_has_pending() true)
+		 * before the requiesce-state load below, and pairs with the
+		 * smp_mb__after_atomic() between the quiesce_depth store and
+		 * the blk_mq_hctx_has_pending() load in blk_mq_unquiesce_queue()
+		 * (and in blk_mq_quiesce_queue_nowait()).  With a full barrier
+		 * on both sides, at least one CPU observes the other's store,
+		 * so the queue is not left both un-quiesced and not rerun.
 		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		smp_mb();
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

