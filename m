Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE91EDA05;
	Fri, 11 Apr 2025 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399236; cv=fail; b=iWp9UiU3glOG/7U98p90T0UEPy7Bikx5f9ipxHR5Nxk6J3lxcCgJj1kas9NzN/8sUjQ7IgCy4WBxoWK/RLTYODFfaasKeuGg8/Oo0T0sz9IbfrH4oZPmsrMAebvofGNN8pgjAvAYp5AdaInHKtRcJCexLgvIVpvyLuSjQTI/Qao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399236; c=relaxed/simple;
	bh=s0j78mPEZO96SV9gONxKcu+cMNs7AkvEBZpi70IZRyc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nFBoM5WguAZfzwzUgOX7hYJpnvnQHd8iOsRa77rLUtKX4kC2vIzobFxrNVFwKubwIhFAE9EfOaeAPLPYlDqo0ELD3CrRubeRUv8kdCQ811u220/4h0Wt4Q6vftTvBeBEr+NQnkQvchlgqAwkT4XNJ/Zj8JwciiXjXm+/Kod/TjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Yi4Ap9eR; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Yi4Ap9eR"
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BITtfg031062;
	Fri, 11 Apr 2025 19:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=s0j78mPEZO96SV9gONxKcu+cMNs7A
	kvEBZpi70IZRyc=; b=Yi4Ap9eRvaeMIt1vfeQAkvs7shW0HrDv1MIzR7mQuPXkX
	dLOU0kl84rUTmXW5ebYOAm+s0BlP3cDMzWry5gNr1MpsvKT1GDMDOX/HPbpIMnKX
	gbb5KcJ2Q7wUAKJPMhrkc+eY9jFb+SM9rKA2NjmJFACrFKq1R225+9TJ+UySVHKY
	XQbyyIf5qcJ5MVhWL7Djm9M38hBmFnTGC0tLO9ZPlYPmhmadNrqo+vzn5ZC4I8br
	82aojulJN1In2DtsxPOxUMsfgXxt7RcvHyYyPuhoJ5cYUJLnbt+n7q2YyG2qKHvu
	woqFYCmXrHWR2gCx7vJ7Xsk9Nft9OzOASelrbiMtA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45ttdjntq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 19:20:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FY/0KTSJVTakSF2hA8Pbuq+5Z2XE8vrc1zJ0Ygnvbi0KKo0RygWO+slNepWL955AH3NRNWCeVNc4LoQvTLqQg28a1RZpo2IALNWTCILy3eND4bos1QTvIZXbjRc/U+JF5lg+52T13jlJUm+cmY9ua1yfvbKBu+F/VdbJrWry+ML3Ck0ysOF6yHf41IumUwPkX6uxiHIKklaEVoJU3dmOEWvaZ+QMiT8NyNAJcN63M8EtdxGacO1E4kdgZcpTvunv4guhlh9ULWPWKzvENu00a4mqBNDZvgjJC5hOY0WGhuBaREcgWvSnanEgAj92eiVD0Iltv2FULQ8pgyiNN8ejdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0j78mPEZO96SV9gONxKcu+cMNs7AkvEBZpi70IZRyc=;
 b=XWFDn/EpYknSWWcaqGFqHCDDm4rD0YBy0ebOrFDIm1kzWJXzQNgybToNSGKA7ya7J+U4hcNJVaafACuBnZ1sg3I7YcWhR2NWoVHFcXL/cE2OfwXC5AFYfopiplYZsYYS5m/tEkFgNZFuQT6+Tz4AM3dE+9IjTjVMQmjKYDEqrNChf8cAaNhJt/eIPlfr74QiG+WBevT68eldqjrJPqsRw8GUxWRfiamLuf2mk5w4mRwBZ8KgxeEVFbrgVEEwQQ/pdKqeznLmvfdVoYrqjJ4V+/j4l/PQ3joozHqKNIwgNCkje+R8Mk/j5X9SDU2xYxvtUrdfz6gXd+0PV7pirAy8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by BL3PR13MB5090.namprd13.prod.outlook.com (2603:10b6:208:33d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 19:20:18 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 19:20:18 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] block: add SPDX header line to blk-throttle.h
Thread-Topic: [PATCH] block: add SPDX header line to blk-throttle.h
Thread-Index: AdurFsImap1DWHxxTeKjU71W2qzN/A==
Date: Fri, 11 Apr 2025 19:20:18 +0000
Message-ID:
 <MW5PR13MB5632EE4645BCA24ED111EC0EFDB62@MW5PR13MB5632.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|BL3PR13MB5090:EE_
x-ms-office365-filtering-correlation-id: 50fb892b-5d68-474c-4ee8-08dd792de571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sMCHYMMLI06zcxRq1VbD7/eXyYIZ9eevf02IZjWhqt9dNIndMjA9NSp/D+Wq?=
 =?us-ascii?Q?2GTxqaoX+t5aOOQcAE/CU1f1zfOmLswAQIspfXOEzX2cfrhAtzUxP6K1FW7U?=
 =?us-ascii?Q?kMlm3gU9uVgoceNyPev8MCOqN5FIcbz7ixUCkBSO25+dUsguM5UTIcWuXnKG?=
 =?us-ascii?Q?eQ+iGlbUVpwL5OEXEGAZZJUaDjuxG1kYhhEJsDaH6mLGBUnFNgh7oWtR3V1Q?=
 =?us-ascii?Q?fZzqZ/lTpsWFh5apXpz04nEzFfdo3ImyehCwUqvrySaSXNdMwwdVbtiAX5iz?=
 =?us-ascii?Q?eIl0VAdJDxe8R+daDJTjZNR5Q5JUcLQCcA0eaZHjeMWhRAsHllbM5DJqyMlr?=
 =?us-ascii?Q?lcRvdCxv1dU7xBu4H0uF4dtSd+xbLKCUR39qdg8uk/GLZB22/zHGgIKPhGQy?=
 =?us-ascii?Q?qjgDpvYHEVyyQkwG91htqHvCAQCDC5vf4VlhDlN4tNH5ZqAQi3fA1zA+UzfG?=
 =?us-ascii?Q?CXD4sfzvhicv3jKUX9j3MkH3IpkTBKpkL05381xXKPdXJtV9gGU+cLezojrR?=
 =?us-ascii?Q?WP70Xb5GLq2RbP35csgWClz1jqcwYZy3kqoMOSyjqK5ndxGShCKxgj8stwxb?=
 =?us-ascii?Q?BGsqHvHBuU1sV6rnXtKA5PjcsZSzBM3d+CS1Zgxw17eFmsd2TOqwUNBmp2sg?=
 =?us-ascii?Q?7OgbggXuidg/XZLLFUQ+OTzDHfFuWEewjJ9zd8mA1XilBauT10jaPf0Moi7M?=
 =?us-ascii?Q?a1HObulrn2Z0gN3xbAZVYLD2XSZf1gP6eHf4Mqm5ZF0T3kBMfm316Gg07wuC?=
 =?us-ascii?Q?1SO0+VeWZOovfEIA9xhgYy12UuX4MD1G2uIs1kImroQZBGF7CI+R+1kHk8DW?=
 =?us-ascii?Q?wQaObuNdBkRpAWa8UMeKtHltSai5L6vijN4CY0b+PKZHkwTsHbAeWodRs0kX?=
 =?us-ascii?Q?NcJ+qHeTeyAORUldI3B4vUELqn5OPdB2EnSsmSC/29WB0J6QoTH14AYL8jyh?=
 =?us-ascii?Q?5aAtHc/B7X06XVLroUD6AEtEqnuzp87uBXsgnFaMBsdtqHDvYsUb6+HNjeiY?=
 =?us-ascii?Q?4OKPjRXSsote2XDHU2C/WIC9ti76wJ92FDPEuUF6Nas3Br/mkGYEWgRyoRQU?=
 =?us-ascii?Q?F5XZ3hTFsMxhNeplrI8ide/JpPDojo/did5JtrmNFt1NLGT74QYbHLY6wP+o?=
 =?us-ascii?Q?9J1Bp036NNB27lR59EG9Bje1B5QEg1S8c33fGHBEt4nu9/ZHXkjD4MUbh4Rm?=
 =?us-ascii?Q?lOWbiZ34D5S6j/OtEAPx4sU8HqygxPyDkjDEpMA5LMRA49loBEFGw+J8VuC6?=
 =?us-ascii?Q?+UiJtEbAEJD67ICgcFjwsLqaUpHn5TVqjNESHzwCAN7X/Xs+Xm0A5QdCNsnD?=
 =?us-ascii?Q?cJsKviI8XSZjkgb3xF3noqJbUWrf+ny2jhy3ZRRK4YdofwBxqb+m8W9JuPDV?=
 =?us-ascii?Q?JTq2uj3BgrYweI87YeSH9m55p2ohb22t8z8VtsE76yjaC3HgyhANDIB1pHb5?=
 =?us-ascii?Q?gQe6JG5iDFXB/HreVGdWZztzwYXTgB+AafQTxkwNQ3PyDLemMepuwQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fr2fInmPiCzXVuOD6p/0Vf/qn6nM4zjFXDpAe7uFP0Hd29jZeITOSorrtvhr?=
 =?us-ascii?Q?GGhrRTtiaNaQWkFaMQ25dSEkNwLAVmB6b/Rfyg6PLxEr4d5uIFJ3jrmHxkv+?=
 =?us-ascii?Q?lfVjbFpp1KZ8uHcIQZ3fz65Gb4w91/fDhBm+5GOCz6koQB0X6SFi21HMMaFm?=
 =?us-ascii?Q?WDMnB/cI1jsIv5H9jG0SG2DypYT6QOpJ3Mp/fOsF36ZDf8E3MCj+WZBvSKkT?=
 =?us-ascii?Q?DWYqnfBYIOoIvGkut9ASNwdkmfLre60kL7HvSRnhlj5ziNfgj5FYs2lPuFLI?=
 =?us-ascii?Q?9Wa9Zgf/dlCfBunDzToutLqoL/znWbAXQH7pmDoUY2QVam//uawAZymPfu2R?=
 =?us-ascii?Q?8rWwQnvSk/ZIO4d8m/XhQuQc6w1O+icd33i5X2AzaGo1btqDQFgjZzzVOscq?=
 =?us-ascii?Q?xLyVjSDQsq42/XTQP7iwiFuu2Aypbyl33NtzZItj5sgkdvkcHKZ91lqfigEb?=
 =?us-ascii?Q?Hrh5xrtonFRrw5TqB3tWXQ4ZGzKqNxvZetOPlxtkUHhCMEkrv8x4mNxM9y9i?=
 =?us-ascii?Q?o+R+Tx2vI7Fvq0PBWUXdwtEQO60N3cLR0KCDbkAYJzhbsPgLKHWcE5agVoFI?=
 =?us-ascii?Q?LpTNve8LhEkfrt8yF/3/rNpetWfsuNbpVNa8/CLTSQVwuAGfu4AiOUt7Zrou?=
 =?us-ascii?Q?dsVjl2GOYcDKRlrDRlZPqJmzaPpV28OJHsd5sXiJov+XrNxIZSfdL0GodOeU?=
 =?us-ascii?Q?J4eum5i965oS5bw1fewmcjkIHPz3xWVkEwfGtOIaSDwAZogGkWktTXEPHKn0?=
 =?us-ascii?Q?OEJmnsCsaGOeywe24epyW+y/XGGybmJn8m2nCpxD687ujypsna1JYJDdBawP?=
 =?us-ascii?Q?jMWG+hsXHQyJB7irrOyjyZhtbf+dcXzra1rWS/kDfuJXYD2/hR9TKfQs/qDq?=
 =?us-ascii?Q?L/n1ohepwLCg0MocKDLfJWQFyWZqfY1xhG/y/82GczcSbF6zxE8ckNEflR1/?=
 =?us-ascii?Q?4H8OqJRxoRykBzJnjkD99hCXS45JbUmrtGjmWKtKNEnkQXKgi7fEuek1OlJ7?=
 =?us-ascii?Q?MQWb2FuNXzIJK4kq6OtDARPvZ2xCGseIehCii9oiY55FlC76hg0HqlaoFVZU?=
 =?us-ascii?Q?GgWG1yvvi26BwLX3mrLFD2s0fBLgg6dvUFyvay2jd6Np7/Nsd67e9rKIvGqp?=
 =?us-ascii?Q?N/9S1ycjYGIK6E/xs1h7GToSteN2MBexpgufkKPRY1fI0ZT3z8nt/lV5fObc?=
 =?us-ascii?Q?GAcDIQgHAjS3IRRkJMsba284q5XSRFmtzlMC5H16FwKLSfJ/wdXZuClChTz1?=
 =?us-ascii?Q?OGGfb6JMXgsyIQJEZJs936uANwyKyuXKmqFBCCt3KDO27pdujKUQK7EjnEKA?=
 =?us-ascii?Q?5uTLpZd/tw2KgkC3tcbch1GEj/KOOgSZCI6UoiAx6bOwnB5XaSsX9H6Ed3ot?=
 =?us-ascii?Q?9DBVbNiNcaQEaeCkSUrf2Tqn7pkm5M4AMW6b0hhywwEVDEQ2z0HLIS42B/r0?=
 =?us-ascii?Q?uEfksab/eWU898yu4lmhX3oQCWD2xOua9wPEzR/x3ZVKc5fVmtTMGXm8/mmI?=
 =?us-ascii?Q?fWiELrdsvuW9vxez6PkpsxEeUz53CD0LJupolHgm1t3Hql/Oy6ytx04Gu0yI?=
 =?us-ascii?Q?fLV4HynY6RXMlqMyUxY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QoLWIa/gVCw+HAu18ODbihkN5yU0PycQkOiZ5zqfiruc9svniPpmdKP5YEKfKQNi2WQbTrUgoMkdCZt4EKql5PG5mdiwar7UK/Qpn7xzYcBGAo/jpODvygu+OYsC+ulgSMcVlXXKy3QK8zO0X7EVaLndYZT6c6xkzxXZfo5NLK38HehYRRT8Q9I6aZeDNKsnv0Gm391X6BaKlT9H0YBh2jr4XRWxObT4IoaGxXGjX9InLrdDOOnMMKx3y8R+9pG6keIU4giiQW8lTddFEO39tmLbV1tAS3/QoIPtxKltpwbK8oDC3KwK7/x2XaNS7T0GhImaBrZ9ITJD10E1miuAfXRqZWme4XYu76ra2X3F+Z4Sq0s5G01IANKLBP1v8fqbQ0yG+rsQh9TifY79vLuAZFP4oj2F5QWaJaQrFRDFve8TxEsV+zKMJtuingEIhonNDM/F3a0MK9ZuaeoepT6KX5NJDwKkuwJD2yaqEgfe9aTggSr290NJnRHfg2zV9uzcqtufG2lDq6YAazk2LyHbP16ngPkyH2FnFhtDF6ObCwoBpYjUbqKQHNZ3i4Fm1s1S4bM58U91uzSuTf0KrUrU95P37P7zS1EmL9zVEu6Q5bDspp8TI0ynNPCTQz4lYCUw
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb892b-5d68-474c-4ee8-08dd792de571
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 19:20:18.6341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3rvXmajlOV8Gw6zR1cA1k98Nf56Uv+o6zE+w+JYAsjePdmTODUbPdBeJJiPWo44teQ5iUPo0t2LKJoLpkW7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5090
X-Proofpoint-ORIG-GUID: nb1j9rNJwHTTlJ9qOcjVcl7-W8Jltidz
X-Proofpoint-GUID: nb1j9rNJwHTTlJ9qOcjVcl7-W8Jltidz
X-Sony-Outbound-GUID: nb1j9rNJwHTTlJ9qOcjVcl7-W8Jltidz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01

Add an SPDX license identifier line to blk-throttle.h

Use 'GPL-2.0' as the identifier, since blk-throttle.c uses
that, and blk.h (from which some material was copied when
blk-throttle.h was created) also uses that identifier.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 block/blk-throttle.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 1a36d1278eea..3b88ef4a9a40 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef BLK_THROTTLE_H
 #define BLK_THROTTLE_H
=20
--=20
2.43.0
