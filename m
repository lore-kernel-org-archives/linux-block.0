Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E3387372;
	Tue, 24 Mar 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362894; cv=fail; b=sfCbzuIZwVeof4Sh0HpKG4D8SjjBAllvcSjvXiYq9IhYL84xgf6HdMfBHZQavv4E5ofoSq/AvQM5ZQqAhPiCG8990su7SjlhXnJavrsVg2q+S7Zx5W3dxWBL94RFINToOGaSE1rXjGrITpgTXlO31uz1tc3PMIpzoMW+3zc66Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362894; c=relaxed/simple;
	bh=zvW3EGoLCm1DNJyrd0eiTspimNcNBsUFaEeWEJM1FbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi34diZSc6XHUHvyfKFe+ISCvgoPlG+jPXqCxvaWQ5TLJwboRj5ZktUUq2/2Sjp3+NSZ7qLZwOAY6CkIV07Vc3ceCBNXUzNmcTyNiVghE3Ip7EYNiilnGsuQjdh+DW03Yznw1bbS+Zsx8I99VKbatfdw/oCdc0bnVLGJzMhK/dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JH2nqgMK; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JH2nqgMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1r9stpJ5KLilhJkY/QDGXMOZG5haGHUzJOCQ6SYW9rve4OyTimZ9HgeQpN9YAG2R+Bd5e/gfP51ExtSWEWsjDDsibgy84fd7I96bL+xf2FWB8LNXjtdkXgOiGvz+YxmvhtaVIgd1dr6nt+P0fb/AH2o/8NQMxtguudzP4Dti2Qbo8DMNxoIC15pdl/oxM4b5A6ILh1XJTu3/rPJWPu4pXunX2wclX0NOhJwDjaosG/xknmMacRckEdzuJM7l7h2Pu3xJGPpvhAKU+A3BxenTCIW3EEcXGvdME0VIwC7IYkVW5SzoOJR6PvIG+0uhnOzP5wVy6l1aMohFYg6vkcVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXUxc8qLGLpDJtx7JN0U2E+JTNy0o5OPphETKEiLLOc=;
 b=GtzCveD8rxtWowaHd4YvUJasnlzPUL0lBbJ0jF5xoZTOkH0MKU6zWfrnqveIihAj+TsrEu2rCPlzpvOYrDU5oPcMQtIRoA56Jfq0uhO8H+29PyB30jstCX+1VTRhrGWBQQ56+Mn97qsdwqAa94Z549m3PupqbrMB4GP6rZHZu5XV0NQsgPvdsCPCwG2QBcELty7RCyqflINIRyQvLgXvFkJtxBgJ1c9lJGy/iF6qUOfqGAvH1OmMcVjOByE7qZzInLQix0KxaMGPH0u0YquDIR7AmR81ahMdziD90ZCBH/6NZ8UQUnjhN8qVtcaD88dqKCCJm3I3A/kxOKSp06N3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXUxc8qLGLpDJtx7JN0U2E+JTNy0o5OPphETKEiLLOc=;
 b=JH2nqgMK2EHqwwiIL3j3fxJMIe7V9RIM7gqIEm+S0AQLhCl5Qla3uKyC91ghaE4q1hyj1PZWDf1++b02Mu/0MClu2LjR+Nl9wNCk5bFa2KHXgkCCNrHY58JnW4QqF/eyQcWIZOyol9vbHnZsJUsiPiBpqgS6KHWKDkuRx7i5RFQ=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:34:49 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::78) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 14:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 14:34:49 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:34:48 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 09:34:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 09:34:47 -0500
Received: from uda0271908.dhcp.ti.com (uda0271908.dhcp.ti.com [128.247.77.70])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OEYmfa2786579;
	Tue, 24 Mar 2026 09:34:48 -0500
From: Bin Liu <b-liu@ti.com>
To: <linux-block@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <axboe@kernel.dk>, <shawn.lin@linux.dev>, "Bin
 Liu" <b-liu@ti.com>
Subject: [PATCH v2 0/2] mmc: block: use single block write in retry
Date: Tue, 24 Mar 2026 09:34:46 -0500
Message-ID: <20260324143448.2631888-1-b-liu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310160408.3976760-1-b-liu@ti.com>
References: <20260310160408.3976760-1-b-liu@ti.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a4c173-afb7-4f63-900c-08de89b280d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	M0T2xK9YOrtEeXFlGuMntcfsWR75vl9IGL/S/IAHC1F9zJUSv2gzO/dROAutdmJ4dukTBHMH43dO3yzCuLn170Bot6DoH2i4DeJHz/iwVaLx5ycqppH0TYwDnrUpWks8Ng621NpAy0L+KAHUTCtAJmGhH0GGsyGdfI4GzPI0mvUVN/2dKsZZ+7Tn0F9NO1Fucfr/Ox0EH61WQ45R29MMv7Ld1gC2IXcu8y4HPAK5JhRTcH4rg5V5D+/0rTCXlyOjqsFs27peKl0pUXGHZjNjGCcPd83oAOZaqUmB8Y9wrXkP/44updrHOZktey5qaCZwh9KpYR0ZyzFtZItSg4TtwJP+mVnNpnDIJF56Z/0K0u8sw4D+IEtmJsTSLzw86K4FphMKjJlSiHzSCoXY17Qh67YT5aIaknqD1MbxnXzwTZ52JCmdsZHhxjlx9ncbdelOaygzyNLGGJnvjPZjPAz0Ju7Mhsz+9WMQBlsfZgF7BPU2+bj2MjHSMKSvwzkZUz5SulHyvMtbXSuRtoqz3lm8oR3yP9h0gRQAxTrGK5xpr71BE3oD5iLnEBFBitc581BiXHQ4Ksx8a5pbaSM2DGuO3veKftafPpqK3Q2olEd34m/LsD1RZWRSFdaS6rzJQz5WNKeArKC92RN6Tpj2F8IOkkNkcXjNRnBy2g8sZsNx1J5ixaHAPk6KoYRNz7ecnGSSoMBYXb/ScjTClNPL/WWs5HeU8zENg5CThsCkQTcH4aV37WVo6ggxsfraQRQs7lMaVRD/ryrOBHUUZ2qE/HeNw+564zKa7S7azj4fg3xdNxc=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/vLZo+7Yti1bvP3cuorvXo+xSnTYWb9d8gWt7IIumdxKTTbB1/RBSRRmsTNhjXLzXm1AAu3VcrWCLQi59wmDaqMeBg24J5nETN6WntyYRuEdh1vkAWVc2Ypk5KT7mTU6Z4pJpaM4FXXSdZV3s6SwlrHliPqkZiSrTOPZ1sPi6Lt3wpFO1OhBAcQ9UupX13kRKaRUFmO3WjccjjvQ4efu3ExxUl8HuLN0w4n+NKT9AoL8mgIWu3cdWa9TXUAqepJY7A9qLmRRebb2h/aDVITmbOmacmax4Cmz6cFDwe1Ycy5kqbl9C73w3cwqbPMjU4uansvjqlXwRAQwk7liXVWanXE3VmbJiqf6lLsNCVJZAWaN2E4bz022ZlhfX4Xc55dyywUVDuaTW4yUBq9W4INim/OTYNlQsl0MeAXibh0shuuIC6H0OWAQpTIAg6JGne3B
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:34:49.0930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a4c173-afb7-4f63-900c-08de89b280d8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139

Due to errata i2493[0], multi-block write would still fail in retries.

With i2493, the MMC interface has the potential of write failures when
issuing multi-block writes operating in HS200 mode with excessive IO
supply noise.

While the errata provides guidance in hardware design and layout to
minimize the IO supply noise, in theory the write failure cannot be
resolved in hardware. The software solution to ensure the data integrity
is to add minimum 5us delay between block writes. Single-block write is
the practical way to introduce the delay.

This patch set reuses recovery_mode flag, and switches to single-block
write in retry when multi-block write fails. It covers both CQE and
non-CQE cases.

link to v1:
    https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u

[0] https://www.ti.com/lit/pdf/sprz582
Signed-off-by: Bin Liu <b-liu@ti.com>

Bin Liu (2):
  block: define new rqf_flags RQF_XFER_SINGLE_BLK
  mmc: block: use single block write in retry

 block/blk-mq-debugfs.c   |  1 +
 drivers/mmc/core/block.c | 12 ++++++++++--
 include/linux/blk-mq.h   |  3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.34.1

