Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EE6CA0FE1
	for <linux-block@archiver.kernel.org>; Fri,  1 Sep 2023 04:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjIAECV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Sep 2023 00:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjIAECU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Sep 2023 00:02:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDEE49
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 21:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693540937; x=1725076937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XNvDkD0aFZd5Eg8jChpGLysAk7O/7e4aKnpI0GqLt50=;
  b=h4zVZ0OJK1cyID6i0cWnOGAGAg3AgLKf2VzYF169FKvL/51EUxYmnNJr
   88JAmo9VsFVcmUUVtiuAP2EfHl+bcMQ69iQ4LeBxHadnwzI0Z/I445RWi
   xHeH8460OD8PMlmaue9uxpaVm67RfcS3ONP24qcM9POMnZGtZNohexs7C
   QjQDJVOwxrbsUKes42/bxts/GZee6ZxQzYJnQT1AVZsQVvKIMcaVXqu0h
   /putOjJmE5P4eYOuGx60ehQvAJaeWEEHh3my2aP+mW8A4/vUvtGfym5F1
   YOPtMoGBZxnhtDU9bx6AfJypIf5v3UauzflZY53K/AejDJZcCsRuBRbAM
   w==;
X-IronPort-AV: E=Sophos;i="6.02,218,1688400000"; 
   d="scan'208";a="347929397"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2023 12:02:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKxvvCpmUYhBRNAbOEMW5iXYwX2zT1sLtppSrkVZpF+C5HK1lm8r5nkCarhgK9QvLgnowEEW1IhvPcx2+ODvMN/wity/sbiujla6ta4NjJ3/ZBsSk91JB1jVDZ+a4mN0+AFnpgl1Y9VJzOZotbCEF/sHYULy+XC1H0+YY1/HCA2JiztumHT/xB91RUR4v05d4S3MubIKGVDln8QVivA2boJukrfi0aP1vAQCTcLzH1L4cpCliGb9l5Hyr7wwcCbis3NpyZxy2d8I7zLDG8fnDpbKlcQOG32qXqKLavt9i/GdG13go+yHvW5IqDEEfHFL4xzRM094hOln+yOJRzxDbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og8EODvPIuz391u95sQPaoXBcUkwp9M+3r40JlJUqEI=;
 b=k3YoUMq2Vnx6NTsnEZN0LeTr9L44sZ8LOxNVscGQNEcplINDOP3JhqaIUggWLZHiX6ca65B9cPv9Ue17uw6NFZKPF5jcr9jV4EVQz0UcGgK3xiKcGejkBbZUlD5uNrOQDh3K31uFF1AJ0NYE+xAVbjynxtVeuBpUwbhrZ0yAqNX1/cEUxpIgcigYHg4aFk3gctVusH4zvacJekvFhgs5KowRBK3mehkcSj1VXmNwM5YRci5LA8KMOYBHqm+SNezTB8wqIhh6tsTrPwlyVBBTfGAT1BVHYm7qUn4eTfzmfEmftR4Kqh8XQ9xqqzO26LsVrrx/gRdY+DuCJhPXGhJxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og8EODvPIuz391u95sQPaoXBcUkwp9M+3r40JlJUqEI=;
 b=qsZ8tAlJL41NXn1wfcfRKgYkO1QKK9ANVAMQqqqP4fYi2+b6KdSQxQKzF9DwdFQN3kpjjxv6Qhwt1BkwD7lfnf6sjf4Z6FJx/jVKIIVE8JDRhJT6mf6pcBLSOxEh8Mrv1EHbfZ8TztqYZJmsHC46SVxZEneBdYkY+/+Ntbxdlv4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6422.namprd04.prod.outlook.com (2603:10b6:a03:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.14; Fri, 1 Sep
 2023 04:02:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6768.017; Fri, 1 Sep 2023
 04:02:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [bug report] blktests nvme/043 nvme/045 failed
Thread-Topic: [bug report] blktests nvme/043 nvme/045 failed
Thread-Index: AQHZ2zRGpr+odBsX90y1YnPAmCZwELAFW8MA
Date:   Fri, 1 Sep 2023 04:02:14 +0000
Message-ID: <5h357gpm7i5yfp7hrem6x7eb5dcg7frpennafxh4j445p745ps@dwaw65x2vdp2>
References: <CAHj4cs_eZWuYDmxi3T0WbkihLHJS6=36XGyx+xjE6JvgwRR-fA@mail.gmail.com>
In-Reply-To: <CAHj4cs_eZWuYDmxi3T0WbkihLHJS6=36XGyx+xjE6JvgwRR-fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6422:EE_
x-ms-office365-filtering-correlation-id: 414fd7df-f9a4-4b6d-6551-08dbaaa039c7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gQAheuNQcPjgRwq57L0kQlNLWjAI28FJPxbjh27uWXeXxjunIWQxSubFOzdGeXq49qgYsFMc4wRA/hS6eFJ/IGmE8EnTSGEYQnjHzwlOQssKYQiVp0+aae2GK1pUhSp60kU/9DcGM82ZBUPE5Rf42unh5cNEKu9gspxIS7p4jop+K8rMKypOdEwGoeYTrUgoYhhZFeYeegzlPxx8dPq4hhAyJI36BsPZwY5Tu9TQjo+GJLGiAcjUvzP3EDEQVb/vvAK16eGOJnDjShyk69Gs1zgKE9l+lQqEdmF8+ERev5MYEye94OdBi2r+1pO99Z3gStcbJyt+fc+kkTZrlnfN/kvYeztYwBtLsSUsBSK30Nf2e9JInxc9HFD6wHM0u1oMfCpG4RmXfq9MrJhP5xprJiXYYQNw2QSB2ymzDZCpzbHmD4hozxyl47iQz2AmlGyikpu+AeKrfLmD8zSknauXuOfUtQGuhq0aVJEymyye8Qm+CsIJr+D6qy6L2ToFtbkL39NZeOcDPhVBOlPB452+0hOnwQv5B2HXv9IIeymw5Q7ZbOV5O6azuXFA2iuw9xe8iGeaa99xj1CWuxAzW4Ygkdv4YQmBYOl2St5ZL/uJO1l9S50sjHe6lBlSKmt/I3b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(346002)(376002)(136003)(1800799009)(186009)(451199024)(9686003)(71200400001)(6512007)(6486002)(6506007)(82960400001)(86362001)(38070700005)(38100700002)(122000001)(2906002)(26005)(83380400001)(478600001)(91956017)(76116006)(66946007)(8936002)(54906003)(66476007)(8676002)(4326008)(44832011)(5660300002)(66556008)(66446008)(64756008)(41300700001)(6916009)(316002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7pOpTHZM3z5J4I0qvQ6r6zNtQgqrslrautMBE8nLl+tay2BZigNx5gzq5lm7?=
 =?us-ascii?Q?ceqCHkKN6jHrt70RLuxovQ4C9kKPfFcx208qTBjBUXLShdtYULZe7/ZAou7l?=
 =?us-ascii?Q?BOugKAiez9IgmliLvQ3rtO5vOUuZot91xCTcl2n2r9BymesOm9BgDgDCNsAo?=
 =?us-ascii?Q?o+Uh65eoRK1wRXoweprG0v/VsIz9Ebpbg/13mLfOS8Y157TyocaaJ7MXv0UE?=
 =?us-ascii?Q?emd3Xx5WiZmkxxfvvzUIkUUAr5plRzd3SQho+4WQruNQxlEHKK0WQe74+biP?=
 =?us-ascii?Q?Xv11HVYZNszFB01z7ApKLnK7MA586TiIU1tlM6yF66hmhssH8D7fpi/eeV+w?=
 =?us-ascii?Q?p5SF5xSxLm1TBb55NmpA5D/7dhZc7qWtissmkpBTj3T/lYA1Yl3llw1wpmDH?=
 =?us-ascii?Q?ljD4BzgujB1mTbAJ8niFDpTeuXyDxQeYTq/f6CeErF7lRXhdHF9VOEbjZ1ot?=
 =?us-ascii?Q?srKrYWQOzmIAoZzZvEFaWg5EOXdhd9HGAjIHJVU+OV4UfmKBvG/zoz7v0aJB?=
 =?us-ascii?Q?3MtPY41GukpgWH9VLwMIG4afstMB8yw5k99PHLlCAvHyKWbMFSViVhuub4jw?=
 =?us-ascii?Q?7jAIdnPWD6C22WIM1e2+08L0TSI5lG6vdW3rIi4kwHkvVqpjyXRc4LCqrMrG?=
 =?us-ascii?Q?D7a2pWqqUDWlQCHhB7xuEFFsnIEOh0UvmGYBdKkmz2QEVz2RgtM3Ia35cuYn?=
 =?us-ascii?Q?NWUsizd+O5f1OfAmdXEMJYqkLheOrHyj9qHQta/zSYh9ZW1kslrXbPkEXxMB?=
 =?us-ascii?Q?w5W1Yfmy8JWRN9QZgdSdao9YBBa/YwanMzjUl7hxNh7yRw7BEA2D2oS2b6Xy?=
 =?us-ascii?Q?y0XEbg9H7FoMo9Q7+tkl7g3lZKOZYESMdtLyL3YxRlxC3uJBwsL0B3EGdYj+?=
 =?us-ascii?Q?X30tzFaPvuVPq8RX1tLiFEchw5LoP2d75YFPGB5Nj8gy5jIZ9iXtd9iYDhaO?=
 =?us-ascii?Q?3y5oYvsZfMI/rDVdllykrOPgE/YARZ96u/tquxRviZ7N/Al0HuMgMHK+HONH?=
 =?us-ascii?Q?ASgALFK/FPhVKEeM3ZwzI366BsQaDQVllMxC3+YGlUeo8W1+13a25d9R6C0A?=
 =?us-ascii?Q?sAA0ZYK76xTPEDpj1jM7+kdTyVEYrvadgm0d7i+Jd59wKjK8s/1RXxcPWqGj?=
 =?us-ascii?Q?UH/XKjL0EWlhwJMkp+LmTlBTzm/o3pw20Hpv6gxCCPeEU03vf/of0wruGDwI?=
 =?us-ascii?Q?Rxxxfl3RF+ctbNVjmZrLoaKYU+evTbc7lE2gG0L3lvmmKrf5e+ZTe6TCoyvU?=
 =?us-ascii?Q?+DfmREgzY+mHymh9seqP9+ufmqp33dd09310CqVsmeYyNH4wLC66i+jr50MZ?=
 =?us-ascii?Q?+57SQPXhK6Tf8DCEwMEnYrv6SnKx8vmLM8yuHpWLoVLHjVa27XACoIa80jAb?=
 =?us-ascii?Q?/UPdPGIIC6ebmIZn7BLRqUyG8G67SizbkdwiJO4PCxj/cZoNqhyC0jw/IZvX?=
 =?us-ascii?Q?jk+dyOijV37DLPA1kCg3Ypw3BW0Dqh7SniphVf//P5cn0+JdkNIsyLXTxgf4?=
 =?us-ascii?Q?vVtJsV6jgJtCbEAQyIeVfGqILQV7eejecbibyPidKrbhKD0b68/LwQRj8gbq?=
 =?us-ascii?Q?bDz2a1Xs8rXhhhKNXollZwimQuhEz+XMfMp+r6H4/wuUOtsrLHe+d+Il5I+l?=
 =?us-ascii?Q?JFEE0TSfYfm2nEDEX6fadGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B051D8220CF1F840BE97C94AFCC0C576@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +e31Cuqb/J9FmjH4HKj6tGEmUfcSdp4ZAPVemzmbkqbGCJ7WfiTGVRMyGehBvKbvJaH8E6jhfzUMDgwpS/B44hyldoyogpl3qZKwK09nwuhmMambr/l7RFuHW6Na+Vw3Q4miSmK48bEcV1KoQdA2d5i85p6cR6vAMBiHmT7CY/RW02Xwk/+OIjTrDXOGeGe/84yEUQzldIOQJKyWHgq7VQzsbCRtHjrmBMiO6RATXP9zSJwtZd88ZmRnT/WPwXB8bnMfkNSsdjG73uBgHrfkmHQX9DiBMY8otGDcEGdYJwVNvAvxPNmfpeiUJxE0nvmNrscyZjGfdaTQtkXphnQSnCeonzDiEyoBqW9vJcOQZvZBtX+9dAecI0+PUF28OmYKd5XKmAMZeAm3VDZL/37GnmOf2iixiHwwtWvYO/XNAd2vLscgYyyzgdJ0yzMTFJIIpWpfp6iFK/dMuN0/5OHbebGUwWAThNpP3yefztzyX0Fx5E9W8oHzsUwv9QAByX2An1QWzcl0JMprNaw5gS7fFc3ft8V8HFjqqZx9bbXe7H7aZ451IeoyLQr98N3Bj3OrVoeEEIHcag4CwfE20Sw7WvfjDyerVU7e9UFoaz2a0V3FfHK6dyDnD/zAP4+Y2ai9k9bZ7ItHeKISLpehX3lNcXYTntFCCFPj1jMp1L1kjzeOdUJHnMrYfP57Y5h4MeLpTcbNyZZKv0fBZneg329iNQapbnmiYk7UwY6lLTM2jkj0lIPk0xzWCQrMqWYnIjrNBcC7axJEi34hBwhoGRAuMgiaobfYndRW7SkBxgix99fsFOgTFrD24XjINYPeqiAEZDBuQmYGwF01SxFt+JBDcRlqQ16xtfL9jtKp/EzBr7SwXSBW30CBp670a0sXrxv2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414fd7df-f9a4-4b6d-6551-08dbaaa039c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 04:02:14.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGQz0/zFK0BBQgmtXx5HdSYsu/O241E007fDCHYilsLKfXjs7fi/866XBuW+g4GnwPfQw8Gk/cVj786+JVnfI08HiBTsAuAldF5wQ5r39yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6422
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 30, 2023 / 19:22, Yi Zhang wrote:
> Hello
>=20
> I found blkests nvme/043 nvme/045 failed on one of our x86_64 servers,
> and it works on the other servers, from the log, it failed when
> Testing DH group ffdhe6144 and ffdhe8192, is it hw limitation?

Hannes, may I ask your comment? I have same guess as Yi.

If the DH groups ffdhe6144 and ffdhe8192 does not work always, I think chan=
ges
in nvme test cases will be required to avoid the failures. It could be some=
thing
like below (untested at all).

diff --git a/tests/nvme/043 b/tests/nvme/043
index c6a0aa0..81ccb1b 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -56,7 +56,12 @@ test() {
=20
 		echo "Testing DH group ${dhgroup}"
=20
-		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
+		if ! _set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}" &&
+				[[ ${dhgroup} =3D=3D "ffdhe6144" ||
+					   ${dhgroup} =3D=3D "ffdhe8192" ]]; then
+			echo "DH group ${dhgroup} can not be set" >> "$FULL"
+			continue
+		fi
=20
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 				      --hostnqn "${def_hostnqn}" \
diff --git a/tests/nvme/044 b/tests/nvme/044
index 7bd43f3..3f11693 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -44,7 +44,10 @@ test() {
 	_nvmet_target_setup --blkdev file --ctrlkey "${ctrlkey}" \
 			    --hostkey "${hostkey}"
=20
-	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
+	if ! _set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"; then
+		echo "failed to set DH group ffdhe2048"
+		return 1
+	fi
=20
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
diff --git a/tests/nvme/045 b/tests/nvme/045
index 1eb1032..8e17ef5 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -48,7 +48,10 @@ test() {
 	_nvmet_target_setup --blkdev file --ctrlkey "${ctrlkey}" \
 			    --hostkey "${hostkey}"
=20
-	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
+	if ! _set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"; then
+		echo "failed to set DH group ffdhe2048"
+		return 1
+	fi
=20
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${def_hostnqn}" \
@@ -88,7 +91,12 @@ test() {
=20
 	echo "Change DH group to ffdhe8192"
=20
-	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe8192"
+	if ! _set_nvmet_dhgroup "${def_hostnqn}" "ffdhe8192"; then
+		SKIP_REASONS+=3D("can not change DH group to ffdhe8192")
+		_nvme_disconnect_subsys "${def_subsysnqn}"
+		_nvmet_target_cleanup
+		return
+	fi
=20
 	echo "Re-authenticate with changed DH group"
=20
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1ec9eb6..46c8d60 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -803,8 +803,7 @@ _set_nvmet_dhgroup() {
 	local nvmet_dhgroup=3D"$2"
 	local cfs_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
=20
-	echo "${nvmet_dhgroup}" > \
-	     "${cfs_path}/dhchap_dhgroup"
+	{ echo "${nvmet_dhgroup}" > "${cfs_path}/dhchap_dhgroup" ;} 2> /dev/null
 }
=20
 _find_nvme_dev() {=
