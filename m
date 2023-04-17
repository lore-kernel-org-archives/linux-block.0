Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6038C77B70
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 10:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDQKej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 06:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQKei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 06:34:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2054.outbound.protection.outlook.com [40.107.114.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E2173B
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 03:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSs/8jQTQt5zVCzIRL8iCcA/lzIPFzAesbJUtju6AOeJPWxpXwpIkWKjL4FDETVQRhum3wRK6tar52SWMKGFOXNCCo629FzxVjRImZh7F2WXuJ3S8CJhAmbeOIQeXW0ob6AVst/Zr4K70G68OnzbIcnxnv4vziKL8wPUgEQW9EDIfknJK6ExtKGOwQ9/Q52maIcHXrDZ6PHFIvDZ4jEFnHODJiwsNsIVlu5kfk9smuQmNvBVH2TgkAFwl2J6LDnpq7ScWT1RVEgNfQUjNlBY3fTVCApInXh3byGeUlrus8oPqldTjZ1TULA7xfOFBjflG74UHL3vlnF+HFWmkmb1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7qxKCTsVkwD870Ou9LRtnXAQEPAlerwh3KTDvGZXCI=;
 b=LkuwXHR3OS2mhDKs5JSAe+8NEm4+R4WMIpf8H/bESiV7mAJ/DmNy13IOIUdooRdKePwC8iEMPs9IM+Dm+x2nrmP82acSQGP7uqUwAAyFtAIJ9iefNxtI7/gD6u6zyrCqsnHej3jKXAVrUvxA2tBOacuzMe8q1u97zCTcMBZPAqeOBCRDb1N8cHjWF8JL+RVrFjyOMI/8waItmfaO32VAzmqppOF+XWQbdYM2xZRJcMDgPT0AN31LgiKmosq9mimZC/kBdEKh6/hHSG6bk2FwjugUrOZ23YrYRQ8Og/KL7Aw/7BqRB5oHd+fh2c1ye7mch0aolb+GYxXLnElJh9GbZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7qxKCTsVkwD870Ou9LRtnXAQEPAlerwh3KTDvGZXCI=;
 b=Opte02lW32x4VZQR5ijrtJ361xvfwNpkhDbRqDF/wvXQZmhH/vU9M0UnXlsX+S7/lXXWM8P8HxBdXOSCwG7MQTJ1B1sftJ+eyaIB33kKTO9thcUSxV2cqVpweLIJ6+aCQUQTQDPXcQ2K2V1D6Fj31gwUJQSYDPAxVmdEfZCucyo=
Received: from OSBPR01MB3288.jpnprd01.prod.outlook.com (2603:1096:604:21::19)
 by TYBPR01MB5439.jpnprd01.prod.outlook.com (2603:1096:404:8029::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 10:32:05 +0000
Received: from OSBPR01MB3288.jpnprd01.prod.outlook.com
 ([fe80::439d:68e0:ea8a:7b2e]) by OSBPR01MB3288.jpnprd01.prod.outlook.com
 ([fe80::439d:68e0:ea8a:7b2e%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 10:32:05 +0000
From:   Ken Kurematsu <k.kurematsu@nskint.co.jp>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: RE: [PATCH] block: ublk: switch to ioctl command encoding
Thread-Topic: [PATCH] block: ublk: switch to ioctl command encoding
Thread-Index: AQHZaSxey1jvRLG9pEuAFZqbuHTD1q8vXExQ
Date:   Mon, 17 Apr 2023 10:32:05 +0000
Message-ID: <OSBPR01MB3288694686DB3AF6B776CC39DB9C9@OSBPR01MB3288.jpnprd01.prod.outlook.com>
References: <20230407083722.2090706-1-ming.lei@redhat.com>
In-Reply-To: <20230407083722.2090706-1-ming.lei@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3288:EE_|TYBPR01MB5439:EE_
x-ms-office365-filtering-correlation-id: b3ee1c2d-5394-4cbb-041e-08db3f2efd63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZuS/c20ECCFLwbDSaeYHw2b7b2uVE+8rnI5qYESvEkm0ZoRu0rIrto0rTDtWAEwsybcwHpE47wPGnLNgkELetKwuwirJLrIf5vEYtIb37utfEO5kloeWMB5MsEpUGIuvmMV58aKl9G617c8fCEHU76B+qXa4E5LU0ouH1x9NzRr9Ppn7K0E0yn5YvRiXyGpt32K1jGXjkf72UMT6imAOH94YCnMKMxwnpRlUy0KyRvbHb0yirVg60ion92wHfII2gWAgXqMz0kNEkgerufej5ojvj8OVr6fDChCYIsp3pbbGKHVjUqyFo3hFEWjFDVJhPPejrSoKWsP1o5vB9JdItLQmLRqpGIhn78KUijunU3KcUDourD6eCBKYbvM4wr3+fLSeW03kCSsZP4M1aJcpYevhHa70Z04pxVTCDPB6q9+0OAsBORu4t1KnTkfGZN225m4RhEB+B68+t5bzL3id3xXEIdnLnIszkhYQeIIUNn8ucL6RGWlZtqUo2mRvyGfeofgbZpk1h0kaROC5YNSnSQfcxkokuA92mDDKBvBDwaCZ1fWHjvsk9mdu1ysywCfcD8KLtaZ1EQpXL6cY8fvnXB+LyPAwuVUQl8IKXxfM1/03duUThjYJq1CvdDoYpfb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3288.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(52536014)(5660300002)(86362001)(107886003)(83380400001)(53546011)(186003)(26005)(6506007)(9686003)(122000001)(38100700002)(38070700005)(8676002)(8936002)(33656002)(54906003)(478600001)(71200400001)(7696005)(316002)(41300700001)(55016003)(76116006)(64756008)(66446008)(66476007)(66556008)(4326008)(6916009)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?spilO3agNJdwWY5HHOIT/65xD3W+jqF3ljRUMWTSt8m8V+HtOA/awbPzLO1l?=
 =?us-ascii?Q?alTsv/NOATuEt9A5l5l7OlJwrq8zYACgYLdsozoTDeKmruDHurrw6AVlyMbR?=
 =?us-ascii?Q?DQV9cUbqjVlNi06rZrZ4c1c2dRY5KPYQymIIm4D0APOsO5AFkTm5IBNk/Yhh?=
 =?us-ascii?Q?/NsvfLolia2qgOef8bRrLHFtpB+OItOmwnJqBcICN9f+AXLNHKdytyWaYvxf?=
 =?us-ascii?Q?jS4YJnzbotz/zcBeK1nAs2p3k3PkayPVyR74BH3LGXgxo5uU65oGcBtVVD9N?=
 =?us-ascii?Q?NpJSYK58dguUzjMxHb2K4S0dyEyhgW5SqY2uAS/YNs6jp+OQTTMHHhmNg5yC?=
 =?us-ascii?Q?cqHaOQtBvAyPBHkiO4XwCBNQ/H0xw+2kvZO2/1ZOdAb2LPJxUEUdm4y+SGEE?=
 =?us-ascii?Q?wMk8pQs1n1Rh28oTD14v0H3QyEvL2AOnpQ5IN+aCRdjsDKCbmlhJf6azDR/E?=
 =?us-ascii?Q?pkgFzlkMr6zfjE9vXp/vY/Boo689pvZm5WhXZA8IcHVa1bEtVB3jvhA0TJkU?=
 =?us-ascii?Q?/r/bM4SXLZCTXRXmZGDgR8nceM8l06NMugIC43tVRLHQoelybnyWF5LviiWC?=
 =?us-ascii?Q?rMv4xCbKP3W7kjOM+JIQ5qsIOl0MQLl/iaqBCTSaTl/XHCZJ0rvVqSQlmfW/?=
 =?us-ascii?Q?5Z/+bZFXJJ8T/qiy0GwPcC/iMl+VxFofyFpkyFEoVRH8RP85ZwIO+A17fy/m?=
 =?us-ascii?Q?c0Nz2Ig5cWMSeypqjjiU7B6HPQgKrVK9HTDNe9vaBL970j0OrtHKmrM1XVXz?=
 =?us-ascii?Q?UEpnM1gFlJpH6IUda+Ruv3dskogZsJCzf2iKAF5cbai8ddwqxo5nf6lIelQs?=
 =?us-ascii?Q?TeYaekOy0HeG5G1IImBeFG4ZBPJMp1VF1b8HR+9+8+GVDrEyBg6yIVPM/U4P?=
 =?us-ascii?Q?+grph6q4yDhgAAjDITWS89xXY3xRnW9d8hCCAwnJvcHA5n/SHe4O4GzylXo7?=
 =?us-ascii?Q?YoUq+g8i2j/lJ5DLw/DbsiGXgri7G6XOCztc7OuRA3fyAupnF+pt0xJ6cj56?=
 =?us-ascii?Q?kYQJNmXzAwzl6holMfwhZd9s/n2BM8bEDYNW+ZP8WCbOiQP7iokCP28dtrW7?=
 =?us-ascii?Q?/Hu1yDBN00IVwb3nuFrPtmlYvsmcX64O91fIjMXJjyrm4Si49sD4xL/bDHz+?=
 =?us-ascii?Q?pSEoHvdzq0D0PvZ4zihY1RbYdIp8WHXn/t3gjPT3JefHE3QKu/KwdbxEr0pt?=
 =?us-ascii?Q?2uzxuvEkyIBIkrIlhQDBpy95qp+R6J5YhzeYGDRFzw3NGeswdXGj1GPKJmr7?=
 =?us-ascii?Q?Fd0ylguHEZyuz0F6XJYGl48bEXgsg2GskO4zAtXsadB8/CQSw4sbLVl9CVny?=
 =?us-ascii?Q?euDEi7N9mYm2DFXsaMnsXFZpkgqXLcEh+i1Qc64EgZyavdm69uPgGQvoaxuo?=
 =?us-ascii?Q?iN4hnkL0ZZmIl24AxX00/Ava16EZ+fqNuEpxnN45rR/XXTqbWLi52f1Ae7Hp?=
 =?us-ascii?Q?hYWI5yBIg74ZJu1ufq74fW0YNYoXJ94c23Q5OE+gpxs9d/DrhRrtyhPAJ/q4?=
 =?us-ascii?Q?Ez4UgINPXw/vFETJA6lpwJ7SdYIGRNwG3yWP9lL0lwvTsMWEUqTxVF9+kRKj?=
 =?us-ascii?Q?i7Seug2omLkNvQpx8f16QNdZkXm6hkyQ5JcpKxJt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3288.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee1c2d-5394-4cbb-041e-08db3f2efd63
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 10:32:05.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AT1y/5sMruBPohwdztwdL559jcUKLKcCglj1ATOkv/P6512fuayr8MSA2Eo4JnMmLmVHQErgX/CDndAMAj0cLqCpOCJrZcq6rgG/P7HqfGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5439
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

The commit message below is=20
"we still support commends encoded in old way"
                      ~
Is this correct?
"we still support commands encoded in old way"
                      ~

Best regards,
--
Ken Kurematsu

-----Original Message-----
From: Ming Lei <ming.lei@redhat.com>=20
Sent: Friday, April 7, 2023 5:37 PM
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org; Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: ublk: switch to ioctl command encoding

All ublk commands(control, IO) should have taken ioctl command encoding fro=
m the beginning, unfortunately we didn't do that way, and it could be one l=
esson learnt from ublk driver.

So switch to ioctl command encoding now, we still support commends encoded =
in old way, but they become legacy definition. And new command should take =
ioctl encoding.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 45 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c index 1223=
fcbfc6c9..668ce8240787 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -53,7 +53,8 @@
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
-		| UBLK_F_UNPRIVILEGED_DEV)
+		| UBLK_F_UNPRIVILEGED_DEV \
+		| UBLK_F_CMD_IOCTL_ENCODE)
=20
 /* All UBLK_PARAM_TYPE_* should be included here */  #define UBLK_PARAM_TY=
PE_ALL (UBLK_PARAM_TYPE_BASIC | \ @@ -1299,6 +1300,7 @@ static int ublk_ch_=
uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
=20
 	switch (cmd_op) {
 	case UBLK_IO_FETCH_REQ:
+	case UBLK_U_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret =3D -EBUSY;
@@ -1320,6 +1322,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd=
, unsigned int issue_flags)
 		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
+	case UBLK_U_IO_COMMIT_AND_FETCH_REQ:
 		req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if NEED GET DATA is @@ =
-1335,6 +1338,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, u=
nsigned int issue_flags)
 		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
+	case UBLK_U_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 		io->addr =3D ub_cmd->addr;
@@ -1743,6 +1747,8 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd=
)
 	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
 		ub->dev_info.flags |=3D UBLK_F_URING_CMD_COMP_IN_TASK;
=20
+	ub->dev_info.flags |=3D UBLK_F_CMD_IOCTL_ENCODE;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
=20
@@ -2080,6 +2086,12 @@ static int ublk_char_dev_permission(struct ublk_devi=
ce *ub,
 	return err;
 }
=20
+static bool ublk_ctrl_is_get_info2_cmd(unsigned int cmd_op) {
+	return cmd_op =3D=3D UBLK_CMD_GET_DEV_INFO2 || cmd_op =3D=3D
+		UBLK_U_CMD_GET_DEV_INFO2;
+}
+
 static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
@@ -2099,7 +2111,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk=
_device *ub,
 		 * know if the specified device is created as unprivileged
 		 * mode.
 		 */
-		if (cmd->cmd_op !=3D UBLK_CMD_GET_DEV_INFO2)
+		if (!ublk_ctrl_is_get_info2_cmd(cmd->cmd_op))
 			return 0;
 	}
=20
@@ -2130,6 +2142,10 @@ static int ublk_ctrl_uring_cmd_permission(struct ubl=
k_device *ub,
 	case UBLK_CMD_GET_DEV_INFO2:
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
 	case UBLK_CMD_GET_PARAMS:
+	case UBLK_U_CMD_GET_DEV_INFO:
+	case UBLK_U_CMD_GET_DEV_INFO2:
+	case UBLK_U_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_U_CMD_GET_PARAMS:
 		mask =3D MAY_READ;
 		break;
 	case UBLK_CMD_START_DEV:
@@ -2139,6 +2155,13 @@ static int ublk_ctrl_uring_cmd_permission(struct ubl=
k_device *ub,
 	case UBLK_CMD_SET_PARAMS:
 	case UBLK_CMD_START_USER_RECOVERY:
 	case UBLK_CMD_END_USER_RECOVERY:
+	case UBLK_U_CMD_START_DEV:
+	case UBLK_U_CMD_STOP_DEV:
+	case UBLK_U_CMD_ADD_DEV:
+	case UBLK_U_CMD_DEL_DEV:
+	case UBLK_U_CMD_SET_PARAMS:
+	case UBLK_U_CMD_START_USER_RECOVERY:
+	case UBLK_U_CMD_END_USER_RECOVERY:
 		mask =3D MAY_READ | MAY_WRITE;
 		break;
 	default:
@@ -2159,6 +2182,11 @@ static int ublk_ctrl_uring_cmd_permission(struct ubl=
k_device *ub,
 	return ret;
 }
=20
+static bool ublk_ctrl_is_add_cmd(unsigned int cmd_op) {
+	return cmd_op =3D=3D UBLK_CMD_ADD_DEV || cmd_op =3D=3D UBLK_U_CMD_ADD_DEV=
; }
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -2174,7 +2202,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *c=
md,
 	if (!(issue_flags & IO_URING_F_SQE128))
 		goto out;
=20
-	if (cmd->cmd_op !=3D UBLK_CMD_ADD_DEV) {
+	if (!ublk_ctrl_is_add_cmd(cmd->cmd_op)) {
 		ret =3D -ENODEV;
 		ub =3D ublk_get_device_from_id(header->dev_id);
 		if (!ub)
@@ -2191,34 +2219,45 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd =
*cmd,
=20
 	switch (cmd->cmd_op) {
 	case UBLK_CMD_START_DEV:
+	case UBLK_U_CMD_START_DEV:
 		ret =3D ublk_ctrl_start_dev(ub, cmd);
 		break;
 	case UBLK_CMD_STOP_DEV:
+	case UBLK_U_CMD_STOP_DEV:
 		ret =3D ublk_ctrl_stop_dev(ub);
 		break;
 	case UBLK_CMD_GET_DEV_INFO:
+	case UBLK_U_CMD_GET_DEV_INFO:
 	case UBLK_CMD_GET_DEV_INFO2:
+	case UBLK_U_CMD_GET_DEV_INFO2:
 		ret =3D ublk_ctrl_get_dev_info(ub, cmd);
 		break;
 	case UBLK_CMD_ADD_DEV:
+	case UBLK_U_CMD_ADD_DEV:
 		ret =3D ublk_ctrl_add_dev(cmd);
 		break;
 	case UBLK_CMD_DEL_DEV:
+	case UBLK_U_CMD_DEL_DEV:
 		ret =3D ublk_ctrl_del_dev(&ub);
 		break;
 	case UBLK_CMD_GET_QUEUE_AFFINITY:
+	case UBLK_U_CMD_GET_QUEUE_AFFINITY:
 		ret =3D ublk_ctrl_get_queue_affinity(ub, cmd);
 		break;
 	case UBLK_CMD_GET_PARAMS:
+	case UBLK_U_CMD_GET_PARAMS:
 		ret =3D ublk_ctrl_get_params(ub, cmd);
 		break;
 	case UBLK_CMD_SET_PARAMS:
+	case UBLK_U_CMD_SET_PARAMS:
 		ret =3D ublk_ctrl_set_params(ub, cmd);
 		break;
 	case UBLK_CMD_START_USER_RECOVERY:
+	case UBLK_U_CMD_START_USER_RECOVERY:
 		ret =3D ublk_ctrl_start_recovery(ub, cmd);
 		break;
 	case UBLK_CMD_END_USER_RECOVERY:
+	case UBLK_U_CMD_END_USER_RECOVERY:
 		ret =3D ublk_ctrl_end_recovery(ub, cmd);
 		break;
 	default:
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h =
index f6238ccc7800..640bf687b94a 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -8,6 +8,9 @@
=20
 /*
  * Admin commands, issued by ublk server, and handled by ublk driver.
+ *
+ * Legacy command definition, don't use in new application, and don't
+ * add new such definition any more
  */
 #define	UBLK_CMD_GET_QUEUE_AFFINITY	0x01
 #define	UBLK_CMD_GET_DEV_INFO	0x02
@@ -21,6 +24,30 @@
 #define	UBLK_CMD_END_USER_RECOVERY	0x11
 #define	UBLK_CMD_GET_DEV_INFO2		0x12
=20
+/* Any new ctrl command should encode by __IO*() */
+#define UBLK_U_CMD_GET_QUEUE_AFFINITY	\
+	_IOR('u', UBLK_CMD_GET_QUEUE_AFFINITY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_DEV_INFO		\
+	_IOR('u', UBLK_CMD_GET_DEV_INFO, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_ADD_DEV		\
+	_IOWR('u', UBLK_CMD_ADD_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_DEL_DEV		\
+	_IOWR('u', UBLK_CMD_DEL_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_START_DEV		\
+	_IOWR('u', UBLK_CMD_START_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_STOP_DEV		\
+	_IOWR('u', UBLK_CMD_STOP_DEV, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_SET_PARAMS		\
+	_IOWR('u', UBLK_CMD_SET_PARAMS, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_PARAMS		\
+	_IOR('u', UBLK_CMD_GET_PARAMS, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_START_USER_RECOVERY	\
+	_IOWR('u', UBLK_CMD_START_USER_RECOVERY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_END_USER_RECOVERY	\
+	_IOWR('u', UBLK_CMD_END_USER_RECOVERY, struct ublksrv_ctrl_cmd)
+#define UBLK_U_CMD_GET_DEV_INFO2	\
+	_IOR('u', UBLK_CMD_GET_DEV_INFO2, struct ublksrv_ctrl_cmd)
+
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
  *
@@ -41,10 +68,23 @@
  *      It is only used if ublksrv set UBLK_F_NEED_GET_DATA flag
  *      while starting a ublk device.
  */
+
+/*
+ * Legacy IO command definition, don't use in new application, and=20
+don't
+ * add new such definition any more
+ */
 #define	UBLK_IO_FETCH_REQ		0x20
 #define	UBLK_IO_COMMIT_AND_FETCH_REQ	0x21
 #define	UBLK_IO_NEED_GET_DATA	0x22
=20
+/* Any new IO command should encode by __IOWR() */
+#define	UBLK_U_IO_FETCH_REQ		\
+	_IOWR('u', UBLK_IO_FETCH_REQ, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_COMMIT_AND_FETCH_REQ	\
+	_IOWR('u', UBLK_IO_COMMIT_AND_FETCH_REQ, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_NEED_GET_DATA		\
+	_IOWR('u', UBLK_IO_NEED_GET_DATA, struct ublksrv_io_cmd)
+
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
 #define UBLK_IO_RES_NEED_GET_DATA	1
@@ -102,6 +142,9 @@
  */
 #define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
=20
+/* use ioctl encoding for uring command */
+#define UBLK_F_CMD_IOCTL_ENCODE	(1UL << 6)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
--
2.38.1

