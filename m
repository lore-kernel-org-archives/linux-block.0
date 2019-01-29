Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6FC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 22:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BB72087F
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 22:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="icJ1Zvx2";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Cgj0OeX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfA2WKd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:10:33 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49584 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbfA2WKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 17:10:33 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TM2DVT017655;
        Tue, 29 Jan 2019 14:10:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=98qNGnFfmm4viGIOCchn71sbA9VsNeq25T8MHvJuxpU=;
 b=icJ1Zvx2caBm+5QGmMfOdgbbrsJiJIz7dd0Rsxng1ogP7GxYu4ga1PuRB3u6hHF6TaIy
 i8A5AeDrJDsmrWxfGLPjoFy0xrXpPZBkUh3J925STAv6up3A16ySXq/8+2BihYKoU22X
 m6HQcdWpNPqrm7sUeOg+dQwYzQgTv4ehW4HFtijJ586qA4Tj527dAcxCS4QO9DN/uPew
 hpls+JYS1B1egfCIEWhrEeTSlP/oFkFH7/S59M69mA+z8WTzqOhhcBWSMmfrCy52Kx7N
 50OAugwCjCDPE6kgBWEuW3KVy82ilQxTIASiNaHfV9/+WY0njhVWJVxhm+WqyxCRmrFX sw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qahm737pg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Jan 2019 14:10:23 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 29 Jan
 2019 14:10:21 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Jan 2019 14:10:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98qNGnFfmm4viGIOCchn71sbA9VsNeq25T8MHvJuxpU=;
 b=Cgj0OeX9ZzLuCpREvae/uqX1sk7Ysa30AIi4hvBW9KNfXxKl26EN/lEXSqHcPbqQbDqUZXedE697DcHRGqZU1RPFanCY/E+qklLP9FvTN3cSJo4U9QyfEIfARcBOZowPYqpJgybNdsA7emUlkblAXicfleI52b8X8guj9q0gaI4=
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com (10.164.205.31) by
 MWHPR1801MB2045.namprd18.prod.outlook.com (10.164.205.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 29 Jan 2019 22:10:20 +0000
Received: from MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::d467:8dc2:e78b:5309]) by MWHPR1801MB2030.namprd18.prod.outlook.com
 ([fe80::d467:8dc2:e78b:5309%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 22:10:20 +0000
From:   Zhoujie Wu <zjwu@marvell.com>
To:     "hans@owltronix.com" <hans@owltronix.com>,
        Matias Bjorling <mb@lightnvm.io>
CC:     "javier@javigon.com" <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: RE: [EXT] [PATCH] lightnvm: pblk: extend line wp balance check
Thread-Topic: [EXT] [PATCH] lightnvm: pblk: extend line wp balance check
Thread-Index: AQHUt69Wxp69Whgu/EagayzimjQ1m6XGzhiQ
Date:   Tue, 29 Jan 2019 22:10:20 +0000
Message-ID: <MWHPR1801MB20300A1F6E55F7979DC0072ECA970@MWHPR1801MB2030.namprd18.prod.outlook.com>
References: <20190129084737.718-1-hans@owltronix.com>
In-Reply-To: <20190129084737.718-1-hans@owltronix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.128]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1801MB2045;20:YduetZL/XZCK4D8BSlP2XNamhKS6jD3bLP1OXSdgKZzPUH2TKcw3T5MFuuZurlIL7YD/oOIK+7VMLRZhD5AftZY8in4af61mipDTtfkzijmMKfis5baXib+H4hqzDhVcT2aw19zpVeOLe29roCLVJdObkY+EPXX2Afi4mNnvOeQ=
x-ms-office365-filtering-correlation-id: aaa0fcff-43c0-473a-9de5-08d686368ef1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR1801MB2045;
x-ms-traffictypediagnostic: MWHPR1801MB2045:
x-microsoft-antispam-prvs: <MWHPR1801MB2045F506006C6940CDF1E0BCCA970@MWHPR1801MB2045.namprd18.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(199004)(13464003)(189003)(110136005)(8676002)(81156014)(81166006)(14454004)(54906003)(25786009)(3846002)(6116002)(11346002)(316002)(4326008)(2501003)(305945005)(6246003)(99286004)(7736002)(186003)(486006)(86362001)(8936002)(105586002)(106356001)(45080400002)(97736004)(55016002)(53546011)(229853002)(2906002)(71200400001)(6506007)(14444005)(446003)(74316002)(66066001)(256004)(26005)(478600001)(102836004)(33656002)(68736007)(476003)(71190400001)(9686003)(76176011)(53936002)(7696005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1801MB2045;H:MWHPR1801MB2030.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hS23dQTGIcitxzodQUXD3gZBBZLyCSgVNWEli1zv0JL100cv4i3k/U5Gio68UncDsR5e0oVvYCtWL85X0Hwm+FOwXUQYLcT+TKVbYWv2y7xOy3Au6jOEEMV0PQCnsNsdElWOzRqkRgQ/zCESRoQ47CYm7gb9tg//db25eO73hJ45oVvo6qrD+JHX95OQ4EmH8NZPJOCbWT22eS6ttE2cxPdioLflpOmRZYd2F0wdeRDxs1CVvri2ru/j+zYk+c6UOx86GoOdgO+aXOBO6gk6cO8VQtUK5ptH2S4RqGTAyIyZeg7ZbG/KH6Frl4z+V2Dyb/uMbA0t/xMDZWSgte3Wh37I2E/+gnR3OonWb7KR5I8ALcopCq0RPcRc88+wGIGpmiIYLCsgJOfbxQWLQrlCRFfoXg7Y7NtgrkF0U0zeD+A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa0fcff-43c0-473a-9de5-08d686368ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 22:10:20.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2045
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_17:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290158
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry that my Linux email client has configuration issue and can't reply em=
ail. Used my outlook to reply as plain text and hope that I won't corrupt t=
he format.
Tested on my board and it works well. Since this is a good fix, I think you=
 don't need to do it based on my previous v3 patch and can directly apply y=
ours:)

Tested-by: Zhoujie Wu <zjwu@marvell.com>


-----Original Message-----
From: hans@owltronix.com <hans@owltronix.com>=20
Sent: Tuesday, January 29, 2019 12:48 AM
To: Matias Bjorling <mb@lightnvm.io>
Cc: javier@javigon.com; Zhoujie Wu <zjwu@marvell.com>; linux-block@vger.ker=
nel.org; linux-kernel@vger.kernel.org; Hans Holmberg <hans.holmberg@cnexlab=
s.com>
Subject: [EXT] [PATCH] lightnvm: pblk: extend line wp balance check

External Email

----------------------------------------------------------------------
From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk stripes writes of minimal write size across all non-offline chunks in =
a line, which means that the maximum write pointer delta should not exceed =
the minimal write size. Extend the line write pointer balance check to cove=
r this case.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

This patch applies on top of Zhoujie's V3 of
"lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced

 drivers/lightnvm/pblk-recovery.c | 60 ++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recov=
ery.c
index 02d466e6925e..d86f580036d3 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, struc=
t pblk_line *line)
 	return (distance > line->left_msecs) ? line->left_msecs : distance;  }
=20
-static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
-				      struct pblk_line *line)
+/* Return a chunk belonging to a line by stripe(write order) index */=20
+static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
+						  struct pblk_line *line,
+						  int index)
 {
 	struct nvm_tgt_dev *dev =3D pblk->dev;
 	struct nvm_geo *geo =3D &dev->geo;
-	struct pblk_line_meta *lm =3D &pblk->lm;
 	struct pblk_lun *rlun;
-	struct nvm_chk_meta *chunk;
 	struct ppa_addr ppa;
-	u64 line_wp;
-	int pos, i, bit;
+	int pos;
=20
-	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
-	if (bit >=3D lm->blk_per_line)
-		return 0;
-	rlun =3D &pblk->luns[bit];
+	rlun =3D &pblk->luns[index];
 	ppa =3D rlun->bppa;
 	pos =3D pblk_ppa_to_pos(geo, ppa);
-	chunk =3D &line->chks[pos];
=20
-	line_wp =3D chunk->wp;
+	return &line->chks[pos];
+}
=20
-	for (i =3D bit + 1; i < lm->blk_per_line; i++) {
-		rlun =3D &pblk->luns[i];
-		ppa =3D rlun->bppa;
-		pos =3D pblk_ppa_to_pos(geo, ppa);
-		chunk =3D &line->chks[pos];
+static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
+				      struct pblk_line *line)
+{
+	struct pblk_line_meta *lm =3D &pblk->lm;
+	int blk_in_line =3D lm->blk_per_line;
+	struct nvm_chk_meta *chunk;
+	u64 max_wp, min_wp;
+	int i;
=20
-		if (chunk->state & NVM_CHK_ST_OFFLINE)
-			continue;
+	i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
+
+	/* If there is one or zero good chunks in the line,
+	 * the write pointers can't be unbalanced.
+	 */
+	if (i >=3D (blk_in_line - 1))
+		return 0;
=20
-		if (chunk->wp > line_wp)
+	chunk =3D pblk_get_stripe_chunk(pblk, line, i);
+	max_wp =3D chunk->wp;
+	if (max_wp > pblk->max_write_pgs)
+		min_wp =3D max_wp - pblk->max_write_pgs;
+	else
+		min_wp =3D 0;
+
+	i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
+	while (i < blk_in_line) {
+		chunk =3D pblk_get_stripe_chunk(pblk, line, i);
+		if (chunk->wp > max_wp || chunk->wp < min_wp)
 			return 1;
-		else if (chunk->wp < line_wp)
-			line_wp =3D chunk->wp;
+
+		i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
 	}
=20
 	return 0;
@@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struc=
t pblk_line *line,
 	int ret;
 	u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
=20
-	if (pblk_line_wp_is_unbalanced(pblk, line))
+	if (pblk_line_wps_are_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
=20
 	ppa_list =3D p.ppa_list;
--
2.17.1

