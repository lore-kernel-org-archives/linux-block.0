Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021140.outbound.protection.outlook.com [52.101.100.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EA37206B;
	Thu, 21 May 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406236; cv=fail; b=PVO7dPSvfmzNTlWZp7a3IT3DBcCDxPx85q817ttedONFl7ErRQ/zIb+jA2oPslCV+2t2j9fmQBiU9e8q63Rsw5h+Cz7DtIqbqby+JEUejTEdUWUFSmgKYUXmuyHFBoY3IJrUi4sgKsJaQA8z9j4I5mlUP+2wJmimJMtpAXFLQKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406236; c=relaxed/simple;
	bh=DkYl5gSyzPssM6U7YdR72AEn0X78rHvBW5MNLL/9k2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fc5tPLBIX4SSsfy8UfNrz1mnPFZD7eoCkjMyLCDvdQlFuZ+1H3HSsIBEElu8LpJUEyRo6lOjNBzbqP27SWNHqwrbZarcn7GyGsJ9U29StkaZj9LP6auS9fyxGGrSo3PEChTtSJFA6ZVhVQR0Rtnu5AUTz7Q414r1+eExL7I5d2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3RoGiv/Vt3IupV8M+Mk2Vd+SA1D1f/EXoCrBKcFW20a5unRX/CcqJ+QDib+2k0Kuj6z9hilBNOrRpkcF3p3VkajYGhj3Zlp2OkIxxITZsYpVhXHSnQ6lV9/DrgTc/UY/qltOsfUrCRrzZuAaVwAcuWOXZuiXAwcKwNVnd2DbFLjwUTeQ2P20X+TvopOeoxsT23SXStGUZvqxtN7H3535Ir72X0ZsMrCL1dbOloAIgvKqYZf8ReNv3bURB8Csq6SMF9+PyUfxVfWzlw3ctAQk6OSraNjcbYSDa/Vw/jPYYf+faaQA1jozl1fjcDsDsX+t7zLKlm0YOGJ9fPuMorLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbqE/oS98kSBFc5DReMX920shdwvRa0zRECtM01NNo0=;
 b=P6ar9TMhPYtrR6xkZrnY7QEhNKS63L4ki1MDGD/9Gji+NLSx5doBUgDHt5AZKlOjSoOIakQd0lxLlY0AXGw6PW1MuCtoEEN/3ILwNPtrkWRT8fcgQfKpo36kZSel7yJu9lgps/HHrwPa4lu9rKrkWX93iFiEYR0KdaevfMHY5WmLYrVUIuUQdu37sJC/zw/J+In58iW0e6+itSKUz+VdGiPyuWKDmkQMZUUNZs7zBkMTMDiU3Pc6OUg3l7fzUra2NQmSdjisVH7wFLRIB1K7DVjL22BF7kQu8QLNcGRzGmi0mPP1ZqiKYc/NGopLsoHvWSCIAF3UmyF7BHBW5dT3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6796.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 23:30:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 23:30:32 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	mst@redhat.com
Cc: atomlin@atomlin.com,
	aacraid@microsemi.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	liyihang9@h-partners.com,
	kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com,
	sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com,
	suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com,
	jinpu.wang@cloud.ionos.com,
	tglx@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	maz@kernel.org,
	ruanjinjie@huawei.com,
	bigeasy@linutronix.de,
	yphbchou0911@gmail.com,
	wagi@kernel.org,
	frederic@kernel.org,
	longman@redhat.com,
	chenridong@huawei.com,
	hare@suse.de,
	kch@nvidia.com,
	ming.lei@redhat.com,
	tom.leiming@gmail.com,
	steve@abita.co,
	sean@ashe.io,
	chjohnst@gmail.com,
	neelx@suse.com,
	mproche@gmail.com,
	nick.lange@gmail.com,
	marco.crivellari@suse.com,
	rishil1999@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 8/8] docs: add io_queue flag to isolcpus
Date: Thu, 21 May 2026 19:29:56 -0400
Message-ID: <20260521232956.553287-9-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:408:fd::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: c633fd5d-f8c2-4b56-7524-08deb790f387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Wc8PuNZDFkc4bC+zpz/bIPXMmqfjbFG7U35n5p4aUvlv13v95HbGw2FDBvMw7VwIAJrkwDAC3G3I/eUbYwfMZZyYGB6FVezmG88k3UG+Fqu8I33iYGXqbkL24R6pAMBQd/hVTIu5DJ4uobSJ03e4mKCLEY+UmJAZmdyqhSr38Zt2SVVpRABF9kuSighhvZ4QbqvIJfMk9QTCJ9KNiEa/4tL2eZHSv3BBkdJU5RCLJyidW4TurQjINtWeqMkdXVgIdZzZx7delPfMD65NqsMgdbOHy63rIWEvMrxf9CM6Xj6tZ0J4lVy4pbjImpXKAtAti/NmY/N1Ks0imHn8inzStWiK3Yr8vPqZo6+8AnYitiPHRjFpOtshOLLLjb5vZt2tgpkH/fO+YngKJjjxtLVjA9fWnh/dynHp3C72/VQADWrLZX6eVcTf3ZewBbW27tlXYvNc6F9OOUO87e+QEwOexpPAEcKtE2zSxuSfoDmLlFIDytqQs++MV4cZ6Sy/WCQctCymWr68h6YUDJh68HSPmc/QcADlqgTS+U61xJeRK0j92WSjY6ZpdiwWONTbMRTAwktk6S4nnF5ctely03Lmf9PfLKq5g0HiTAMYJyvlNURUEnVLGtJDD1KNghAZ9suGrWyGoM+S3xrXhAJVm2fw5XjE+nRdK0Xf3dryju03eqhc7XRFXfMGS+UnKjACx9HB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5OSp51d4MO1tkhSB7mPfpgI6ThppLSquEsElqlD65HQV8AE1U+C+U9KgC5q?=
 =?us-ascii?Q?tU6P2n4GaI4Zp/4t3j4v7KEUzf/ozv5T4jz1eX/8bNM05oBfDhHD8ADJlT0y?=
 =?us-ascii?Q?MgYwK2JKSHEgVGcKQ56CTae6R8wq4nhSh7Re7P2HSXLC9GhQoUw5Xf2rsjXB?=
 =?us-ascii?Q?ds1t67dUtK/uMBJDlwFwIvrxR9T81MG1I12tMn1ktcImIQKTKXRosSEze3xE?=
 =?us-ascii?Q?SbNNirFiUxEM4b7UT6VI6F1I1MZ6SklxRqlCVERWG/isykCR7DIoMpfQgCHM?=
 =?us-ascii?Q?nX9FvUDLcetVfYKWLY1PWea9nIeg7vCz2dlcrgaRbTlkcwyUR9Ao61lFM/jV?=
 =?us-ascii?Q?km9nXoPkL6p82PNy0THc4DOya/EbpWfMIQlWEVrVHf/sG5n4Rn5aDjkG1tjb?=
 =?us-ascii?Q?JZo1BfgDO/Zbu2znfiBl44dMT+CdlJo6i3EIF4ZThmTlxlbuil5QWbzJBLWJ?=
 =?us-ascii?Q?9fyT/90EkXjQ0dV4qd0jnSLSXjNn6g43jhcwMccQuNVWSmBoG6wZQJy2vUGT?=
 =?us-ascii?Q?ZVcxTcfp8VHkRmRZ9Z3SmRj8cs95/OnCcI+KaFidL37ATWXfmuRE+xL78Pd6?=
 =?us-ascii?Q?zNw0V/8Htp+uyzI1nkdvxy+QNGkq8Xe+pXChJW7QUVdTGNejKydFgJuQ9GXp?=
 =?us-ascii?Q?zbGivFDhsRHuV3hwwG2eRcgXINNPY54GJw7/hz1BS8CDOkLQ8Aj5YyQ25MIi?=
 =?us-ascii?Q?xrRXk0mSxwWqkMO2XCaP3bC+h7oDvMzawDhwcnTNwshZt+NfXrg/05CBAc5G?=
 =?us-ascii?Q?E5J7qUgTUY8q/wujZnWCuJLQEoLBD8AZ6GL1+vzLvHSTNlJ+7A0NQnZuwiio?=
 =?us-ascii?Q?ybuvVtRM4sJoADPv7PLvqaZTXKcSDkarnmyi3F/4zMLSUlNAhdZMe4i6K7u/?=
 =?us-ascii?Q?g5hJF9f/3OtvjlZ4v0OslBtU0MQ/LsuIsdFIqXtSvMnWmbrpyKGRHcnJ3UKC?=
 =?us-ascii?Q?3mBTmk17RK32zWASwqH62wPi6KZvIyUXhm4CPOReIZo78sIPDi2SvAQVRXZ5?=
 =?us-ascii?Q?o6rIDFrARb23Z7ZLFuZ3jGaKm6iCkudN7kMPT5M4brlS5DOK/jITjvYrVqTd?=
 =?us-ascii?Q?dfCI5NGXxKvHojfxi035I+oC5jY3fDrCz/99usEHaf4h1p0kBEJD5p4jNHuz?=
 =?us-ascii?Q?1P3W6R5NPZlwd9Gjktf6At8l3bR5e+TAOvvk282f1mq4yJKiS7dYkO5rFwEN?=
 =?us-ascii?Q?RySM/Y8Kc+5zMAZQJ0rtnYRuO4E+Imp++uVVCI+6Kaz5X4ghiNyrEZNsVRXy?=
 =?us-ascii?Q?15TShCRcekf0c7+IFEuK657YYvZJYO9hl8qURv4nKo3xw7cpF3o06NprsVSd?=
 =?us-ascii?Q?H5mbt+TbIR7zjNgvSldMBBN7Mo/gqMMV/QoY31rDF8yyf51MOYEdgnoYBdDq?=
 =?us-ascii?Q?Id0PFjUZKLzRZ9Lu0nmhF1VyGnYbb1iYSQBc8sel+QIwhowjEvSo6gl4Hhq4?=
 =?us-ascii?Q?q4MkOuLh0SEm1halh+u9RdkBhUR8SDF796xhEk7gDAJtRjQS8l7MuwXxcplE?=
 =?us-ascii?Q?Rl12OeOWOvVfpmoSW9X+66Zkblc9og15PrzB9VRl2iFiFQCvJRRim67w3xAg?=
 =?us-ascii?Q?HE0EFhr1N6/TGDtjdxGZ2vC1FDBUJSP/5jQU7syHiai377hdK5G4JbAfr3vL?=
 =?us-ascii?Q?50iJQaH4bWiW7u19+U5b0WgEWQIgno/CZzWysU0RwB3HYzS3d2T5O7CWvYNu?=
 =?us-ascii?Q?mq0vdCc4hxnH1IZCCtDocfF/BkXwpOaI55gTZEnPL7kLY+Y4voWPfdMR0bse?=
 =?us-ascii?Q?3W+EpgN79w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c633fd5d-f8c2-4b56-7524-08deb790f387
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 23:30:32.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwO0vVMGZxE5reiRbfXvXlk1M7R5CE5VLAX5ZJJLD3oza27ZwEPCLraRG8fNjzaO9eaw+hxc6AgnqNJik9G+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6796

From: Daniel Wagner <wagi@kernel.org>

The io_queue flag informs multiqueue device drivers where to place
hardware queues. Document this new flag in the isolcpus
command-line argument description.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
[atomlin:
    - Refined io_queue kernel parameter documentation
    - Removed an inaccurate claim in the documentation stating
      that io_queue takes precedence over managed_irq]
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..fb828bb60b9e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2792,7 +2792,6 @@ Kernel parameters
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
 			  Isolate from being targeted by managed interrupts
 			  which have an interrupt mask containing isolated
 			  CPUs. The affinity of managed interrupts is
@@ -2815,6 +2814,31 @@ Kernel parameters
 			  housekeeping CPUs has no influence on those
 			  queues.
 
+			io_queue
+			  Applicable to managed IRQs only. Restrict
+			  multiqueue hardware queue allocation to online
+			  housekeeping CPUs. This guarantees that all
+			  managed hardware completion interrupts are routed
+			  exclusively to housekeeping cores, shielding
+			  isolated CPUs from I/O interruptions even if they
+			  initiated the request.
+
+			  Note: Using io_queue restricts the number of
+			  allocated hardware queues to match the number of
+			  housekeeping CPUs. This prevents MSI-X vector
+			  exhaustion and forces isolated CPUs to share
+			  submission queues.
+
+			  Note: Offlining housekeeping CPUs which serve
+			  isolated CPUs will fail. The isolated CPUs must
+			  be offlined before offlining the housekeeping
+			  CPUs.
+
+			  Note: When I/O is submitted by an application on
+			  an isolated CPU, the hardware completion
+			  interrupt is handled entirely by a housekeeping
+			  CPU.
+
 			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]
-- 
2.51.0

