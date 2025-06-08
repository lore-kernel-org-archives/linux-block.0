Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E21E573F
	for <linux-block@vger.kernel.org>; Sun,  8 Jun 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749378030; cv=fail; b=ffEttZwRO2sHNurl/EDEu+J2fntWc7RQhjFQNTU0sfZgqF1Nt7iNYGuWo5m8FxKqNNoAHq1H+XAVJQH1baLwUzFwTWmFF61PkWq5KmmF2Qf3ngIgCrbSMoe/HgfCNPIpfyJA0nWhxWX62ZEwFwapgrURrTifouifEjiotdi68DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749378030; c=relaxed/simple;
	bh=7sQx58oTyFystJ/GRgAINXu7S5fQIaCDCWbWHuEbxF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nb/ckM/VLfxKxDQsdgFAiX8c6PcLD2w/9u+C9Rfn76bazQ5UvNW4BVTS3Q1UY1R9TIhlqZLGGDipb5rCezodlYhdXNO/igXU08zG5E25/sj7ZtxM6MO9pcAzuyRxQzY6T8sqMsIZvAuQQa8CuAtbMzzGKbuN3rRL5UKfAgkjZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qx445eYj; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qx445eYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhwNgVIXlNVts8BGJ2pWclgxHDAFyI1Cl65PWvReE62nI5MpxppLHLrKR5uuKVwhV6LGWiUJ4ZHzpI/EhHNTnUgklG/rW2FIHlTad8Nlt8cZs9QdjMF0BD+PAHnJcsKZ5mWoCsEr4D/YKkqQf/fIp1XUxTe+wt1gVsnYUTvbC8u1l54ybRI/v5fmfWO2P7sIMocbxPXynlHu01x7JRDtj/wHUidAikcrW8Iy+yTHw8FfumZh+U0ymp4ittjph2kaOmKJk4py3fnFnILDQi7d/egHG8kDi5AD+NmgNeZeWi3snFEgmiqllBv7f0rAsBeNa3AmIEeDTsiXIdHwunEh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfKxnSzAe/9O1SgHTkoL9Jywpor7XFmuaUa/OZRP838=;
 b=G0q4jIXHK21XDQHaiSrr8SxUNYX1qU4ke+ys8U7fCcOzOrNquB8E/OUaagA8OBOCgBoIpHT/ThMwEGMmxJoLZSoRTXG0BSvRHo8rE2zy6rPU5mPFjhaGIGC2UWA4uJvluXr3t5BGzh4O6zeo3B4y2WWiF8z6vMweN7/38h7aBqgOeDkCmWWbdEBwHyfMrdRXXj8u7VP0aQlU1D9tx4Z5g49clWefckFojEf0avr5K4DMYVuu+i/xEHU9e2iNjf22/qe04NgwLBRKO4nOPj8IJAb8iFcQwD14zp2Ykx3oekFstO5wtUxBrcU4OCnfbvwShht+uvojHY3zPv5OGrpxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfKxnSzAe/9O1SgHTkoL9Jywpor7XFmuaUa/OZRP838=;
 b=Qx445eYjqoPmEMMTw6MLZaySQgDPM2sYwSxqAwMYFih5ep6/o4Uycw4AeRf+Jn/iANlonpCB21B2CLvgOS6L8r5fKpnP/W8tZrHYZwhiwJpUGHRBfifccMFd4Pdbik2Y1tndMNmakOqiAsaOCpk5Rx5Lldg3u8xPHOMarvRUO6Ni2MFd3ErGm8v/SvgQfYZFX8CbuyVJQKoVCPHlwnXjKJ+obrMakZNy4J5nXibscwQhI85JL8wq5aIqFnH2203U5Zuo4wn40/jUTFNGC0ussdNqlDMubzY4L40MXUC3GXnkgQgKmlgWNqVmYaeQZp07P6omaHZrz4A1EAeaEmypPA==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Sun, 8 Jun
 2025 10:20:25 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%7]) with mapi id 15.20.8769.029; Sun, 8 Jun 2025
 10:20:25 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Uday Shankar <ushankar@purestorage.com>, Caleb
 Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Topic: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Index: AQHbyzeSSRaVFqTPg0GnAQDdJHQew7P0ldE6gAFlm4CAAxP3QQ==
Date: Sun, 8 Jun 2025 10:20:25 +0000
Message-ID:
 <DM4PR12MB6328BB31153930B5D0F3A3C7A968A@DM4PR12MB6328.namprd12.prod.outlook.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEK6uZBU1qeJLmXe@fedora>
In-Reply-To: <aEK6uZBU1qeJLmXe@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|CH3PR12MB8401:EE_
x-ms-office365-filtering-correlation-id: b6be410a-c934-48c1-b07b-08dda6761578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u1uPm2DpFN/lwpYcRehOitGK9BrZVrsj9mOS0OA1whsyX5QgJJ6TYi9SFd+n?=
 =?us-ascii?Q?MKN/KoM5tmLsm7FHhR4zxxiwDPvH977Q0/8jRdVAcZOzuCToQ6ZKjRsy2kYX?=
 =?us-ascii?Q?TyW06YH+YKyca6f2kX8Qcw6C4siDwXIVxjZ6Y4W3ZVa7AqVnG/FEDZCtBB1K?=
 =?us-ascii?Q?F2Mpt2mCY0fe8GTaQPPjuGev1zWnUe3X27+c2yxxmFItDA725kR4nDFkLVuR?=
 =?us-ascii?Q?uFhW9BuTLK098H5Kk/0rZcJSFQDIt/KZNN2GQU1Bkuisqp8gvjNStgynxi1H?=
 =?us-ascii?Q?EHyTJ4DDLK0kUIunfGT2LqueWIyUy0Mn18q+E2zuecQmQfBJ7mCvK63U/6IU?=
 =?us-ascii?Q?mE9b9pQ1sBJsHbNoRmTmaLFbal5WTGIjuqxLh2/z0puSKGZ2OCWEOwuQeL8U?=
 =?us-ascii?Q?i+3GEuhh64SQuXEoRsOu8d9AIQL22fZcPQ8md5rz4y5+epUAaz4L6wk9LBk4?=
 =?us-ascii?Q?Mo5M4i2qH5qObqfThu46Kpl/QtSoQ4Aw7pEiXjugsKPUV0nhDD90oJUK9pkb?=
 =?us-ascii?Q?Gr9Nt5mJ/yDMQ7ZqJvRjStP8oR+kfs9La1szEl1xQd9gaVkgn64r9EgcGLaY?=
 =?us-ascii?Q?DJk45pd+O3ZHmo3UBbIk9bIZzDu/rlHBE9XjXB/FrMUj4Dlk5sw9CuA6rfLc?=
 =?us-ascii?Q?VL1wO5maoW2MUIt5PSZi5agwOUirPNUTh1VRuL7Hr+I0mahRAdzw9j99u6Ab?=
 =?us-ascii?Q?+SE1HP8EIbMkEYjDS8NA5vLVjYdRRpgwtXr4gOtCMi3/YOLuBhZ8OBBMmI8r?=
 =?us-ascii?Q?1uq5C7l39f/EvKfrSOBOmDGLx5VOZIoGTD4kqJ0+beTVgrZ9bmio4RbI9O77?=
 =?us-ascii?Q?zLWb5t2FnvHkskC65pvixu2ebpz/zLQPdhwfeXC0WQLX7Ktkyq5TcytY87B1?=
 =?us-ascii?Q?aJAs2ncasYUKPjtsLGMUBsHhWg1A0rwf8u4H3qmSw03ue69nsTW9ku+vZUcK?=
 =?us-ascii?Q?M6pHAFkjVat7bYnymylifPZiTPRfdgPDwNdHjCXaNA1vcBSIPq6xX+4DdsLR?=
 =?us-ascii?Q?2IEtRHKnlRBdFmK9q3d4191y+63Z3JuibGoWTr2rRAJ/0R2NSxDues/xffxm?=
 =?us-ascii?Q?6HNscsEE0O3XdR21TFk/m3iLoTg6SnPzPMu46OSun5AMu3O1JcMIaeqTBMfD?=
 =?us-ascii?Q?iHlMjClS+a77YGJVZyhXqBkmsV88mODxcU6Fsz+CfcuXTihcG8ofvrsJPYIn?=
 =?us-ascii?Q?swlv7q3IeSmQyBwrRrC3bPreGRrKUTmHPCJLZ7O8PxxndSDVEw2p62Ur6HAR?=
 =?us-ascii?Q?uisu1UNiBxDMfWTJo81fQEPu68GLWEdctL8SeKxjQoGsGTMZcDDuWsJu6ICx?=
 =?us-ascii?Q?B1yxiaokAoa+BSJJnFmyqs5/i5SQcLGa9b6t6kbMb3FLGl3uBWR+ztuwR6k9?=
 =?us-ascii?Q?EgsXvwbTZsPW1HQFkfWeauo7cPhVmrqH912hm1YHG9R2UdZcpFtWf8bZuZSR?=
 =?us-ascii?Q?FJHJbpGVwNgl0y3P7oPIT8MCHbF4cN9MxNHc+FejsIB19prDzxN6f6aoZT5X?=
 =?us-ascii?Q?Bs6Gd5Xb4qUwvxg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FphdkUWD0o3ReKuZHB1Jgxvb//5DMFc4hOavdS85IIITb0LJUAehKsyFS0Jv?=
 =?us-ascii?Q?Fe+zDmW0HWNUErIfV7ZUPtqC8pgzM5CCJLC6tGWpl+bSkyVxJ4rDbEXjC9Y9?=
 =?us-ascii?Q?ICtBpSF+ZT9GoxWjwPrE/8OdpinCD4P0O5rXyT7M7ZJIcYx0X6sOq/z2WdUz?=
 =?us-ascii?Q?fabglBdmPttFnexwu5k3rkh5zVeaQkwjxlYqEW6b/gT0aObU7yhtUKA/WO3z?=
 =?us-ascii?Q?nO6J6ImtAoEWVqF8kkqd97Et89V2lnrJs6I47qg9nSNGX77YYRLDBKtmjmJr?=
 =?us-ascii?Q?Bh4kws9W8IFVSZA0slkuupHsGZHFAMk5kyAspN6GnlMd1dCLUE1VmPscI7be?=
 =?us-ascii?Q?h9wOppeg7ll2e5nHlyRVHgabOOYb7KWkzx3Wr3tCPV9VAhX0jh6fPVO5d6E2?=
 =?us-ascii?Q?yDlAO0e4MFEPLkYSVlJV453GLT/GAVaWT547oeEDgmbO5ZvBdbU2WOAlc67k?=
 =?us-ascii?Q?xwoVhJ+9JGRBsK4nvRg5yd9x73iZw7+Gbg//BciRX3K9I0oNLAd6qxP7Y7Hw?=
 =?us-ascii?Q?ZSv/EbOhBhm6MPw4MAZlODtAKAFILKx0GjhGhCq6ZB7RNUhjt8iaGQmys5YU?=
 =?us-ascii?Q?ya+FOIFgR8QYkaNJi9UFB0F78GgvYoKbkRUrfCnEeVyQTdV3jKoQ9Q6SKh4l?=
 =?us-ascii?Q?CG2lQf0s2VAfgr1XlF9BS1sQrDS1Xktmu047lei+Y/TN5UCx9Y2LNCaeWdo2?=
 =?us-ascii?Q?wsMSomSCKhxwe5SCFZSKeTRyPHvBXAUKvlQF4/f211JN6tiWpP/pt5FX+Y9d?=
 =?us-ascii?Q?ft+YOU4eAPMeUNiDFm4Pm6K8rNSI1pIXCc8fPG+uhyidp2bnAIjoDPy5qA7L?=
 =?us-ascii?Q?dBVcoqQTvA5c55yDFrARalNOeHl32KcM/uW5foqSO9+3RgpE+1akEKoyXr2y?=
 =?us-ascii?Q?s5MuvFZaX+0vjSKKV9NZS808VRQsyzXOYO4nOryU34m3sxL/TMpEPJTxzhHF?=
 =?us-ascii?Q?OCEdklHbWbt1XSm96jxELjpof8LswHwcSh86Ws0tYHVqgOanbymoxpDXbXd0?=
 =?us-ascii?Q?/XbG6hgYZ+VO3kxUE7hhiY2KnzHpMAXQ53Al0fje4P40/dNpLQtaVsAHNWWV?=
 =?us-ascii?Q?ztFs+bmgsl6OZAxwV2y3SShTOj222h0yi8dXuzWMaHHs6XK+EQGNEiOVHwYj?=
 =?us-ascii?Q?KOAZI804baaQigoA6w4vsRvTC0254cJmbpS+C+sWB2Ud167voYap18dFaMGt?=
 =?us-ascii?Q?toBOK2ms31J6m774XxF8y1j+GzeQuTKbfF6MGRirw7XfHr1K6nc3y+SEmwvR?=
 =?us-ascii?Q?k/lz062tU9S+IXkB+c0kfcXP5P1d2ruBMi9m4hFxYH6iHl7fmHq8DGgETFkJ?=
 =?us-ascii?Q?tJK6h0Pl18TNn7GsZLU8Zzcr6BaugA9LVZlOmNmvxR0p4j7CJ7G1sQRGsqF/?=
 =?us-ascii?Q?LwnPdibacpy2LD6iJ1RL7JPeYdcNsW1ujgbH/y2zI8GXzOwvvHKyiy8T3bAD?=
 =?us-ascii?Q?I8v1tWtQuV+b5IsUlv3W0GaLtaya/ItX5mg2Rwwr9VlqE7BRX1GibhnMXZCp?=
 =?us-ascii?Q?0lUJUT6yA2sBnkTU0kvZn1PJiRAWkOwcZKLVCqEMKDe3OaIrFqVfoU7lCP/D?=
 =?us-ascii?Q?8T49X43fPN0CDazKpio=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6be410a-c934-48c1-b07b-08dda6761578
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2025 10:20:25.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4ZnzYsByA0yeltB4LggVQkrJFP/JO/0sLdOAMfx9GvSPh67dzI1ajxBmueqnCHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401

Hi Ming,

Thank you for the reply.
I understand now the requirement for the idle IO but needs your advice.
On our case the backing IOPS are going over the network, when switching to =
upgrade mode we are shorting the timeout of each IO in order that the appli=
cation will really finish as soon as possible.
On this case (until now) we used to prevent COMMIT_AND_FETCH on the IOP/s t=
hat are fail due to timeout to prevent the user for seeing the failed IOP/s=
 only because we are on upgrade mode.
Checking the code I don't see how we can do it now as there may be a situat=
ion where all IOP/s are failed due to it while calling QUIECE_DEV.

I saw that ublk prevent zeroed read but allow zeroed write(__ublk_complete_=
rq), is that just for supporting devices with backing file or a real requir=
ement for every ublk device?
Any tips if there is other way to make the kernel retry this commands?
Thank you.

________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Friday, June 6, 2025 12:54 PM
To: Yoav Cohen
Cc: Jens Axboe; linux-block@vger.kernel.org; Uday Shankar; Caleb Sander Mat=
eos
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE

External email: Use caution opening links or attachments


Hi Yoav,

On Thu, Jun 05, 2025 at 12:37:01PM +0000, Yoav Cohen wrote:
> Hi Ming,
>
> Thank you for that.
> Can you please clarify this
> +/* Wait until each hw queue has at least one idle IO */
> what do you exactly wait here? and why it is per io queue?
> As I understand if the wait timedout the operation will be canceled.

One idle IO means one active io_uring cmd, so we can use this command
for notifying ublk server. Otherwise, ublk server may not get chance to
know the quiesce action.

Because each queue may have standalone task context.

The condition should be satisfied easily in any implementation, but please
let me if it could be one issue in your ublk server implementation.

Big reason is that ublk doesn't have one such admin command for
housekeeping.

Thanks,
Ming


>
> Thank you
>
> ________________________________________
> From: Ming Lei <ming.lei@redhat.com>
> Sent: Thursday, May 22, 2025 7:35 PM
> To: Jens Axboe; linux-block@vger.kernel.org
> Cc: Uday Shankar; Caleb Sander Mateos; Yoav Cohen; Ming Lei
> Subject: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
>
> External email: Use caution opening links or attachments
>
>
> Add feature UBLK_F_QUIESCE, which adds control command `UBLK_U_CMD_QUIESC=
E_DEV`
> for quiescing device, then device state can become `UBLK_S_DEV_QUIESCED`
> or `UBLK_S_DEV_FAIL_IO` finally from ublk_ch_release() with ublk server
> cooperation.
>
> This feature can help to support to upgrade ublk server application by
> shutting down ublk server gracefully, meantime keep ublk block device
> persistent during the upgrading period.
>
> The feature is only available for UBLK_F_USER_RECOVERY.
>
> Suggested-by: Yoav Cohen <yoav@nvidia.com>
> Link: https://lore.kernel.org/linux-block/DM4PR12MB632807AB7CDCE77D1E5AB7=
D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c      | 124 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  19 ++++++
>  2 files changed, 142 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index fbd075807525..6f51072776f1 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -51,6 +51,7 @@
>  /* private ioctl command mirror */
>  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> +#define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
>
>  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTE=
R_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_B=
UF)
> @@ -67,7 +68,8 @@
>                 | UBLK_F_ZONED \
>                 | UBLK_F_USER_RECOVERY_FAIL_IO \
>                 | UBLK_F_UPDATE_SIZE \
> -               | UBLK_F_AUTO_BUF_REG)
> +               | UBLK_F_AUTO_BUF_REG \
> +               | UBLK_F_QUIESCE)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2841,6 +2843,11 @@ static int ublk_ctrl_add_dev(const struct ublksrv_=
ctrl_cmd *header)
>                 return -EINVAL;
>         }
>
> +       if ((info.flags & UBLK_F_QUIESCE) && !(info.flags & UBLK_F_USER_R=
ECOVERY)) {
> +               pr_warn("UBLK_F_QUIESCE requires UBLK_F_USER_RECOVERY\n")=
;
> +               return -EINVAL;
> +       }
> +
>         /*
>          * unprivileged device can't be trusted, but RECOVERY and
>          * RECOVERY_REISSUE still may hang error handling, so can't
> @@ -3233,6 +3240,117 @@ static void ublk_ctrl_set_size(struct ublk_device=
 *ub, const struct ublksrv_ctrl
>         set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
>         mutex_unlock(&ub->mutex);
>  }
> +
> +struct count_busy {
> +       const struct ublk_queue *ubq;
> +       unsigned int nr_busy;
> +};
> +
> +static bool ublk_count_busy_req(struct request *rq, void *data)
> +{
> +       struct count_busy *idle =3D data;
> +
> +       if (!blk_mq_request_started(rq) && rq->mq_hctx->driver_data =3D=
=3D idle->ubq)
> +               idle->nr_busy +=3D 1;
> +       return true;
> +}
> +
> +/* uring_cmd is guaranteed to be active if the associated request is idl=
e */
> +static bool ubq_has_idle_io(const struct ublk_queue *ubq)
> +{
> +       struct count_busy data =3D {
> +               .ubq =3D ubq,
> +       };
> +
> +       blk_mq_tagset_busy_iter(&ubq->dev->tag_set, ublk_count_busy_req, =
&data);
> +       return data.nr_busy < ubq->q_depth;
> +}
> +
> +/* Wait until each hw queue has at least one idle IO */
> +static int ublk_wait_for_idle_io(struct ublk_device *ub,
> +                                unsigned int timeout_ms)
> +{
> +       unsigned int elapsed =3D 0;
> +       int ret;
> +
> +       while (elapsed < timeout_ms && !signal_pending(current)) {
> +               unsigned int queues_cancelable =3D 0;
> +               int i;
> +
> +               for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> +                       struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> +
> +                       queues_cancelable +=3D !!ubq_has_idle_io(ubq);
> +               }
> +
> +               /*
> +                * Each queue needs at least one active command for
> +                * notifying ublk server
> +                */
> +               if (queues_cancelable =3D=3D ub->dev_info.nr_hw_queues)
> +                       break;
> +
> +               msleep(UBLK_REQUEUE_DELAY_MS);
> +               elapsed +=3D UBLK_REQUEUE_DELAY_MS;
> +       }
> +
> +       if (signal_pending(current))
> +               ret =3D -EINTR;
> +       else if (elapsed >=3D timeout_ms)
> +               ret =3D -EBUSY;
> +       else
> +               ret =3D 0;
> +
> +       return ret;
> +}
> +
> +static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
> +                                const struct ublksrv_ctrl_cmd *header)
> +{
> +       /* zero means wait forever */
> +       u64 timeout_ms =3D header->data[0];
> +       struct gendisk *disk;
> +       int i, ret =3D -ENODEV;
> +
> +       if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
> +               return -EOPNOTSUPP;
> +
> +       mutex_lock(&ub->mutex);
> +       disk =3D ublk_get_disk(ub);
> +       if (!disk)
> +               goto unlock;
> +       if (ub->dev_info.state =3D=3D UBLK_S_DEV_DEAD)
> +               goto put_disk;
> +
> +       ret =3D 0;
> +       /* already in expected state */
> +       if (ub->dev_info.state !=3D UBLK_S_DEV_LIVE)
> +               goto put_disk;
> +
> +       /* Mark all queues as canceling */
> +       blk_mq_quiesce_queue(disk->queue);
> +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> +               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> +
> +               ubq->canceling =3D true;
> +       }
> +       blk_mq_unquiesce_queue(disk->queue);
> +
> +       if (!timeout_ms)
> +               timeout_ms =3D UINT_MAX;
> +       ret =3D ublk_wait_for_idle_io(ub, timeout_ms);
> +
> +put_disk:
> +       ublk_put_disk(disk);
> +unlock:
> +       mutex_unlock(&ub->mutex);
> +
> +       /* Cancel pending uring_cmd */
> +       if (!ret)
> +               ublk_cancel_dev(ub);
> +       return ret;
> +}
> +
>  /*
>   * All control commands are sent via /dev/ublk-control, so we have to ch=
eck
>   * the destination device's permission
> @@ -3319,6 +3437,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ub=
lk_device *ub,
>         case UBLK_CMD_START_USER_RECOVERY:
>         case UBLK_CMD_END_USER_RECOVERY:
>         case UBLK_CMD_UPDATE_SIZE:
> +       case UBLK_CMD_QUIESCE_DEV:
>                 mask =3D MAY_READ | MAY_WRITE;
>                 break;
>         default:
> @@ -3414,6 +3533,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd =
*cmd,
>                 ublk_ctrl_set_size(ub, header);
>                 ret =3D 0;
>                 break;
> +       case UBLK_CMD_QUIESCE_DEV:
> +               ret =3D ublk_ctrl_quiesce_dev(ub, header);
> +               break;
>         default:
>                 ret =3D -EOPNOTSUPP;
>                 break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 1c40632cb164..56c7e3fc666f 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -53,6 +53,8 @@
>         _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_UPDATE_SIZE         \
>         _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> +#define UBLK_U_CMD_QUIESCE_DEV         \
> +       _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
>
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
> @@ -253,6 +255,23 @@
>   */
>  #define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
>
> +/*
> + * Control command `UBLK_U_CMD_QUIESCE_DEV` is added for quiescing devic=
e,
> + * which state can be transitioned to `UBLK_S_DEV_QUIESCED` or
> + * `UBLK_S_DEV_FAIL_IO` finally, and it needs ublk server cooperation fo=
r
> + * handling `UBLK_IO_RES_ABORT` correctly.
> + *
> + * Typical use case is for supporting to upgrade ublk server application=
,
> + * meantime keep ublk block device persistent during the period.
> + *
> + * This feature is only available when UBLK_F_USER_RECOVERY is enabled.
> + *
> + * Note, this command returns -EBUSY in case that all IO commands are be=
ing
> + * handled by ublk server and not completed in specified time period whi=
ch
> + * is passed from the control command parameter.
> + */
> +#define UBLK_F_QUIESCE         (1ULL << 12)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
>  #define UBLK_S_DEV_LIVE        1
> --
> 2.47.0
>

--
Ming

