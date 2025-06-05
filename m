Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE38488
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127028; cv=fail; b=MCDh9PpomdvFMITl9fUoln25Ll6dgZR+H5BVJ8KpXoLT+tjDzLHbwGjJUuY6+M5RX3NRH72Y+hUqjpgrcVODwajRjrhb+fLuqen8Rhae2bWx5FgwPb3fUW3oR3R4N2wG+xIytNErKg9FdLSVRzh01re9o/+8lpRsWfPcCOJ9HAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127028; c=relaxed/simple;
	bh=JJin+gom4eHFm2aCXIjCmyNNnDpyH3W58nkNeEGsby0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ee75MWZJ45PfrHQwLl49cHH4o/EHrRgdH7Nv6L32ppBdpf/D9yZCkRcGND8OV5d/zPcAtBjz95XKa4EZUjvHtM2pY1eNr7WTa5hftkAx8OVhq2qf+/AA1+wKv13ZfL+oMGadvpQHGcZiETSnlqADIL9Vf6k4ONIG7H2VRGC+gao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9Oubj08; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9Oubj08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh3lyModOCS1D0fT/qP9Ua1oAZBqcGJ12mpTVFgkwkQg5j8uVSWI2ZIk2EKKvFkqAzhRlax1GH7XXJDDlpDrl5f41R5VkFZocVwO57w1M7hvjdRSFMFzaYYFvJ5Jk7Fm4jykCtmd291WvVJgbC8CVqugWdxFVanJtLb/mVOwQvyt/DiLMITXfTyU5ckj+4zXVVHYwy51mSgRKbKEkU9c+cmw1XPvM8O0HDOPvU3pPjQZ16OFi02JX96/y1BQp8pZ8STJ/nr+65lG3IRC5nnNjrMLL7PFtff1aqlMOvxxe7DryY70Bfd2FHitC4rRY8eInp9NqYQiyqEvm1LYPpsWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMZDgA883/zD4EEE5melFENW2OR5GXSwT6D6RCtW1GM=;
 b=CBCX8oNtgdKwMcEDD7axaTcpPsfSj8TC3wZkRWrNKZCQJyakUW3heuCMZuJkecGapX9ctNg/rHAni5tu7W9s6IPSNpOZZsWsA8O8Ov2eOUj7EQc37LPuZmqRixn0VK3of+9bRBCdPlTJSFDc+Jc0jJpmsYj9biv+ZF0Ts5/RuGNAHGiYJCnENaIFk6/8li6JVMxQ09pOhIRvWnIL/ssse4rkGYbFF4p0lmkWp1gyljzmyG6nOk8uC1Fvl93cDlIIm9C3DdaVPNOXfyiJoNu2d7umVo0Z12toDx7K9AbytHd/L8JVuZ2+2K9STEQaD3YSjDPrTIRi1ZlUxA9zNS8wdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMZDgA883/zD4EEE5melFENW2OR5GXSwT6D6RCtW1GM=;
 b=a9Oubj08QR+O5HaC832N7RAwVgtF0kfGJ4zJ7yRla1iIyNA0FYUlOWt+fxzGvgAXR/zX2Dl2HWic7YYDBIk0Clo9DXnbKujTWkMc74fxHXD09OEVqKBJJtp/JT3v0OdyBKgCBgcBsVN2qxURmHfSPNbsLa+0SCvgtCvWudazuH+iSNK3UAwaLJcdIQr4GaYIeRWOkdYEUX2c32fj0y8U46tKC1aYCVJ65hiXRGYB/vHBxmDdxmPWw3hwB5OJcV6AWg/BMEoKlB8MEL7W6f0OcwAT5Hb26NzN89Bj+J/n5ZmgBtUt/+tucLss1AXYY8usoEtAfgltiv8Vrw+YvjC02g==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Thu, 5 Jun 2025 12:37:01 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%7]) with mapi id 15.20.8769.029; Thu, 5 Jun 2025
 12:37:01 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Uday Shankar <ushankar@purestorage.com>, Caleb Sander Mateos
	<csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Topic: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Index: AQHbyzeSSRaVFqTPg0GnAQDdJHQew7P0ldE6
Date: Thu, 5 Jun 2025 12:37:01 +0000
Message-ID:
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
In-Reply-To: <20250522163523.406289-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|DM4PR12MB6496:EE_
x-ms-office365-filtering-correlation-id: e468b68b-4e73-4576-669c-08dda42dabbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3+Y1blRoGOK/SDJbRf4huLQ4FGC3EkmPLDcwDwIe0zvUO4D/S0O0Gz6OWu8L?=
 =?us-ascii?Q?luCimYNTDmL71a+Y2QhETheAC3PJM+mSZi+JlZ63Iw4EeiLF5MpEpHKNgzMg?=
 =?us-ascii?Q?TZ42uwRgQMOiaF8Q0n1hB/lWjBI3+OO7JYyDre9oZ6tBKihlsSsmXQcH2TE+?=
 =?us-ascii?Q?mbZdSchWpPMPO0cBaMyD9mdg7Do3tAL5si8dp9ZZF2sNgACPg06VYqzkwFyR?=
 =?us-ascii?Q?X6a/+5Hb92mn4O2FrrffEkKB6yiVHOvRIb0igAJ3pA+acHOeb4Xadld6gcOc?=
 =?us-ascii?Q?D6K1JQErGFY/jeuZkXgaUUQ1R9ln1bdCqM3R83zqaFUXcr+pkGjXPDl1W09A?=
 =?us-ascii?Q?s5SSIdB64NDX3PaljtBawOSyQE93S21sDmhZcxWwj3eqQirt+cmKQ3C1HD4h?=
 =?us-ascii?Q?VAGO250Bw6Pzpvj05ZOMqJr6VrK6l0bOZW1bGFOHB1TKojaYzdgmZB2rzwUV?=
 =?us-ascii?Q?/gFZwud6HQ3dX2yM0ANCL4nCS8T76sUHfnMPBM0kjFrknGDbvY+LvYLFCtt3?=
 =?us-ascii?Q?UUh8V2hZ7JwWnSeGt8SD1SXrnsd27Jvpn4BPRL53rPn+YPqzXfFxsGvqvCGz?=
 =?us-ascii?Q?YK/irhPsAO1UWXqSDefPht83OBhQ04t70jqV1vCIOwgOe8KNND7H0Ao0lKKm?=
 =?us-ascii?Q?5m8F1n1IPLj/0BK8KjSIqt+VrKEDL88jjV7kntOmxPCaH9VP2aCev8jAx3dT?=
 =?us-ascii?Q?ntAn91qujDpFFc4cit+Y2cIYiUqHuzO7cQbjT3+lpY15PUK12Kz0jLA3LbtD?=
 =?us-ascii?Q?eGXM2Jiiy7juz51TaeVyvSfZ6Iku47n2TpCDHLSSvLMjavnj/rFCvAgyrOBE?=
 =?us-ascii?Q?kt3nef8TP+MX+sAbDTAfFuiW4ZpqC3ofdam+t4DkWNi2DU/6IQ41Wnnm9Sx6?=
 =?us-ascii?Q?tr/SJ7rutopPGp7wI0QW6IEuDD6+DFszadr3PP7N/hwyMp5ZiJhdvU0/yd/2?=
 =?us-ascii?Q?DlC47AOUsfLpBF6AakkaHO1s7kZ5v6Z0iXv3I+gFt1DG1+s69ileMlBo38Am?=
 =?us-ascii?Q?MMU8qjRijTkb+MluG9sm7oxtzLdFSKstNykn32Nmvqcs65uIo1i5SEwHSvEI?=
 =?us-ascii?Q?jOSkvveFZ2R2KMtYB2RiEgbhEAIWrhmjas1t7/XiVFjcpeAd9DrAFi00EjxL?=
 =?us-ascii?Q?jRjf2gxmnpbtbB4Jd2X00qtdxGruIRJL1worEbqaUKj0fhlPA9orTsqSPGWj?=
 =?us-ascii?Q?LLAmXbSd/H0UDJwIxqEKR5U0/GzhgCbvl+g2Aqv+1/oH74/RLKRvG7vovPCC?=
 =?us-ascii?Q?BJuMKewaF4jJQj71EXK+PujsukxfY6z5f3TQPolggBIogb3NNITF78kEVwbU?=
 =?us-ascii?Q?Wq3yfg7+W2EBOjzKb3GyI3g+v601TnKMRbj1izVIB8HFNzQtw+D5jJLh1OQY?=
 =?us-ascii?Q?nfN+m5qGmtq/pn8AJ/dOzEUihdMhGSEjD5HT5AvrH4QXyK2JHbp3YDVpi1V+?=
 =?us-ascii?Q?j/zAAyedoNYkMyLKXGlRjLJeIM3sg/Juy8XZJ8yt9422etgd1q8YkhpX2sPz?=
 =?us-ascii?Q?QQWtFbqTugAxYPE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GZ41K1xJAYfqWUvDBuAqDCP2GxrpUx1Kexc++AoM0HRBef03ZBOrD6GeISYK?=
 =?us-ascii?Q?0G10WSa6xl4+sk5UgepwSiMyQtgy9ZewiSehMYtSgBSMK6mp3EThVMHQQK4q?=
 =?us-ascii?Q?OCDWAzGvhrdxXoffW0Bet+oi3FPjuEY8KQqt8hvTXF3ZWvc00BFfecD88NCM?=
 =?us-ascii?Q?DQXSJFM6GE8A0r1u7Hm8O40onbhOhKyRiI4gnjjepmpM9uvXiEXMwCFnVfe7?=
 =?us-ascii?Q?Bw+aXj1ndcdoumec1r8/fx/OVxSX/E920uMUWZD7FVC+r/lom3jjorO39GS+?=
 =?us-ascii?Q?e8pY5uknnnDUqMRmO6dj98bsphiUd9y/X9jJAjnL8mFEHIj8mJAvL83Q0OqU?=
 =?us-ascii?Q?CvBRUpAA1nrjD0C5Yb1K+5mVjjRID72OSpJQMWs5Dg7oT1Z6gmRdOMfF0q+G?=
 =?us-ascii?Q?M0L0svE/YintWx4/JESe9nyskfiA0qJsCIOHZA822z6unuyRC20QAgdksNQX?=
 =?us-ascii?Q?5aZXYz7xRPXy9YQzS7SAup6TFyQEFDtjm74V2rH2G3hNiOl31jgTp9YZKk6/?=
 =?us-ascii?Q?S5EjM78V+jbl9mCrjCOxueTYK8Z4Zs+tKKxyWy33VszQ3D/xXfadxRd2CYRP?=
 =?us-ascii?Q?1YTBB2Wjk4qszWcJ+vFDdyVpFzso/sfT9G0E28zKGjVIyoFhuCWL6tN5GYSy?=
 =?us-ascii?Q?RxqMvOug5ZhUsszMmliMVLmv6JVaVbybl9NCYbrpRMVBelq/WBpeAGlsyNRg?=
 =?us-ascii?Q?j35a6T+AGrJJwWx23hMSVJDqjyAXPf3c9eF4bfhtJDf5i/HtDKnS3t2AmFQY?=
 =?us-ascii?Q?dIL/CPbwZA+OZKhIEPzyp8VAxc2/+aYCRt0OKsKJkx9CShvvhQ0uPD/uSZsG?=
 =?us-ascii?Q?dGzy8W7yuf4EqwExN31TW6J5Y2dkCqM2Gnw1dhcg42ZmWbZkCInTLoIz8g6e?=
 =?us-ascii?Q?Jg7Z9NKsyUPKxOcbDU/LNEjMsNTecbD+0nSijv2+LB7Cq88VmtwkMm9aUrrS?=
 =?us-ascii?Q?OAN1P/+nweq3NYDIjgh20It2XUITHJeOSTKENx4g7O7w2XGaC0rNhSddyLSZ?=
 =?us-ascii?Q?PYEYgaO8nmKH0ejhFFIuFNbzdysaWtir9RInGrb6agcybXXxCzjkQVW4qKRJ?=
 =?us-ascii?Q?AFlIXnUbkLTvEm5+v30ajhYv+oxdcINVpEgQZFr/nP6XPhhiwdD95vjcRyPj?=
 =?us-ascii?Q?Me8NuWHa2AIB/zfYIfce1A/e3kFl7LIvw1ZbI8Ik/olLhMKXs3QvqQzNytlm?=
 =?us-ascii?Q?p9Alt1BHgolztndz5GFe0dq5qpn1aJtx5xLpOeyTIJ/JNz/1r/zwI443oa2/?=
 =?us-ascii?Q?9C+OmuM4F6xJLOztRQP0CpUPhtHKSyA1pUfYWdWpaxY1xjjBmbR0+yzJK5rY?=
 =?us-ascii?Q?+M4+bu8U+YAvkJIj9Xr5tGOJdzvQc/soZXWiYPq+7BkdjEKH6imyUQjiex/h?=
 =?us-ascii?Q?2YhI0EjR+7bPAk6pfIku5fWOCSvnEfvcjarS+6swc/j+IspHvqiIJOnA+UB1?=
 =?us-ascii?Q?mdj76fnfQ+jt23XaN0FoB44rBywXUBZnGBfq1NgtSIQNKjYDQgndcYwV7RQ2?=
 =?us-ascii?Q?vS6P7I3SE3f0+I/2KsFsRyVZ9u/NtZ96eV5C6eJjKEKbsTAjuVXesF4byfl/?=
 =?us-ascii?Q?zdfC3n3eQHgjDfDFzNU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e468b68b-4e73-4576-669c-08dda42dabbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 12:37:01.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocV+r3HYfJTTKMsNDnUjhmlLDECsmIAOGAkcMzJaaIeXZKFjIh4+5wP7aN24eRWn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496

Hi Ming,

Thank you for that.
Can you please clarify this
+/* Wait until each hw queue has at least one idle IO */
what do you exactly wait here? and why it is per io queue?
As I understand if the wait timedout the operation will be canceled.

Thank you

________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Thursday, May 22, 2025 7:35 PM
To: Jens Axboe; linux-block@vger.kernel.org
Cc: Uday Shankar; Caleb Sander Mateos; Yoav Cohen; Ming Lei
Subject: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE

External email: Use caution opening links or attachments


Add feature UBLK_F_QUIESCE, which adds control command `UBLK_U_CMD_QUIESCE_=
DEV`
for quiescing device, then device state can become `UBLK_S_DEV_QUIESCED`
or `UBLK_S_DEV_FAIL_IO` finally from ublk_ch_release() with ublk server
cooperation.

This feature can help to support to upgrade ublk server application by
shutting down ublk server gracefully, meantime keep ublk block device
persistent during the upgrading period.

The feature is only available for UBLK_F_USER_RECOVERY.

Suggested-by: Yoav Cohen <yoav@nvidia.com>
Link: https://lore.kernel.org/linux-block/DM4PR12MB632807AB7CDCE77D1E5AB7D0=
A9B92@DM4PR12MB6328.namprd12.prod.outlook.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 124 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  19 ++++++
 2 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fbd075807525..6f51072776f1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -51,6 +51,7 @@
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
+#define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)

 #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTER_=
IO_BUF)
 #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF=
)
@@ -67,7 +68,8 @@
                | UBLK_F_ZONED \
                | UBLK_F_USER_RECOVERY_FAIL_IO \
                | UBLK_F_UPDATE_SIZE \
-               | UBLK_F_AUTO_BUF_REG)
+               | UBLK_F_AUTO_BUF_REG \
+               | UBLK_F_QUIESCE)

 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
                | UBLK_F_USER_RECOVERY_REISSUE \
@@ -2841,6 +2843,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ct=
rl_cmd *header)
                return -EINVAL;
        }

+       if ((info.flags & UBLK_F_QUIESCE) && !(info.flags & UBLK_F_USER_REC=
OVERY)) {
+               pr_warn("UBLK_F_QUIESCE requires UBLK_F_USER_RECOVERY\n");
+               return -EINVAL;
+       }
+
        /*
         * unprivileged device can't be trusted, but RECOVERY and
         * RECOVERY_REISSUE still may hang error handling, so can't
@@ -3233,6 +3240,117 @@ static void ublk_ctrl_set_size(struct ublk_device *=
ub, const struct ublksrv_ctrl
        set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
        mutex_unlock(&ub->mutex);
 }
+
+struct count_busy {
+       const struct ublk_queue *ubq;
+       unsigned int nr_busy;
+};
+
+static bool ublk_count_busy_req(struct request *rq, void *data)
+{
+       struct count_busy *idle =3D data;
+
+       if (!blk_mq_request_started(rq) && rq->mq_hctx->driver_data =3D=3D =
idle->ubq)
+               idle->nr_busy +=3D 1;
+       return true;
+}
+
+/* uring_cmd is guaranteed to be active if the associated request is idle =
*/
+static bool ubq_has_idle_io(const struct ublk_queue *ubq)
+{
+       struct count_busy data =3D {
+               .ubq =3D ubq,
+       };
+
+       blk_mq_tagset_busy_iter(&ubq->dev->tag_set, ublk_count_busy_req, &d=
ata);
+       return data.nr_busy < ubq->q_depth;
+}
+
+/* Wait until each hw queue has at least one idle IO */
+static int ublk_wait_for_idle_io(struct ublk_device *ub,
+                                unsigned int timeout_ms)
+{
+       unsigned int elapsed =3D 0;
+       int ret;
+
+       while (elapsed < timeout_ms && !signal_pending(current)) {
+               unsigned int queues_cancelable =3D 0;
+               int i;
+
+               for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
+                       struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
+
+                       queues_cancelable +=3D !!ubq_has_idle_io(ubq);
+               }
+
+               /*
+                * Each queue needs at least one active command for
+                * notifying ublk server
+                */
+               if (queues_cancelable =3D=3D ub->dev_info.nr_hw_queues)
+                       break;
+
+               msleep(UBLK_REQUEUE_DELAY_MS);
+               elapsed +=3D UBLK_REQUEUE_DELAY_MS;
+       }
+
+       if (signal_pending(current))
+               ret =3D -EINTR;
+       else if (elapsed >=3D timeout_ms)
+               ret =3D -EBUSY;
+       else
+               ret =3D 0;
+
+       return ret;
+}
+
+static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
+                                const struct ublksrv_ctrl_cmd *header)
+{
+       /* zero means wait forever */
+       u64 timeout_ms =3D header->data[0];
+       struct gendisk *disk;
+       int i, ret =3D -ENODEV;
+
+       if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
+               return -EOPNOTSUPP;
+
+       mutex_lock(&ub->mutex);
+       disk =3D ublk_get_disk(ub);
+       if (!disk)
+               goto unlock;
+       if (ub->dev_info.state =3D=3D UBLK_S_DEV_DEAD)
+               goto put_disk;
+
+       ret =3D 0;
+       /* already in expected state */
+       if (ub->dev_info.state !=3D UBLK_S_DEV_LIVE)
+               goto put_disk;
+
+       /* Mark all queues as canceling */
+       blk_mq_quiesce_queue(disk->queue);
+       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
+               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
+
+               ubq->canceling =3D true;
+       }
+       blk_mq_unquiesce_queue(disk->queue);
+
+       if (!timeout_ms)
+               timeout_ms =3D UINT_MAX;
+       ret =3D ublk_wait_for_idle_io(ub, timeout_ms);
+
+put_disk:
+       ublk_put_disk(disk);
+unlock:
+       mutex_unlock(&ub->mutex);
+
+       /* Cancel pending uring_cmd */
+       if (!ret)
+               ublk_cancel_dev(ub);
+       return ret;
+}
+
 /*
  * All control commands are sent via /dev/ublk-control, so we have to chec=
k
  * the destination device's permission
@@ -3319,6 +3437,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk=
_device *ub,
        case UBLK_CMD_START_USER_RECOVERY:
        case UBLK_CMD_END_USER_RECOVERY:
        case UBLK_CMD_UPDATE_SIZE:
+       case UBLK_CMD_QUIESCE_DEV:
                mask =3D MAY_READ | MAY_WRITE;
                break;
        default:
@@ -3414,6 +3533,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *c=
md,
                ublk_ctrl_set_size(ub, header);
                ret =3D 0;
                break;
+       case UBLK_CMD_QUIESCE_DEV:
+               ret =3D ublk_ctrl_quiesce_dev(ub, header);
+               break;
        default:
                ret =3D -EOPNOTSUPP;
                break;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 1c40632cb164..56c7e3fc666f 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -53,6 +53,8 @@
        _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
 #define UBLK_U_CMD_UPDATE_SIZE         \
        _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_QUIESCE_DEV         \
+       _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)

 /*
  * 64bits are enough now, and it should be easy to extend in case of
@@ -253,6 +255,23 @@
  */
 #define UBLK_F_AUTO_BUF_REG    (1ULL << 11)

+/*
+ * Control command `UBLK_U_CMD_QUIESCE_DEV` is added for quiescing device,
+ * which state can be transitioned to `UBLK_S_DEV_QUIESCED` or
+ * `UBLK_S_DEV_FAIL_IO` finally, and it needs ublk server cooperation for
+ * handling `UBLK_IO_RES_ABORT` correctly.
+ *
+ * Typical use case is for supporting to upgrade ublk server application,
+ * meantime keep ublk block device persistent during the period.
+ *
+ * This feature is only available when UBLK_F_USER_RECOVERY is enabled.
+ *
+ * Note, this command returns -EBUSY in case that all IO commands are bein=
g
+ * handled by ublk server and not completed in specified time period which
+ * is passed from the control command parameter.
+ */
+#define UBLK_F_QUIESCE         (1ULL << 12)
+
 /* device state */
 #define UBLK_S_DEV_DEAD        0
 #define UBLK_S_DEV_LIVE        1
--
2.47.0

