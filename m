Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44408C47080
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC8A61263
	for <linux-block@archiver.kernel.org>; Tue,  1 Jun 2021 08:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhFAIlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Jun 2021 04:41:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23924 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhFAIlK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Jun 2021 04:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622536768; x=1654072768;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o7Yt0fVvsU5pE5v66Qp1x5LtL9qknyVNOjPHQ9qC0nk=;
  b=dg/swW436t//oQ+ASedOTTEXKYmy1kvTZIzgPaP64awKbxdy5IANHUmU
   51EPGIRq3HOaO8UinWy8GSBJqBY/AwVkTqG5w1RaOzo8FSgSZJ+D2pMng
   HZpub3+O8m3pYEJooBMQlp9MdzcpLtfNXkM3sF9EfFwZ8nn3GOJgM3zuY
   u1PrOG4bCEL/2oirVM56Bi/Hm/PuOtDQ9zWiATF4jFh/XQso5c8+wtUpJ
   ba4glkZ/wwE8MltXx8vMY/1UuVvTp9kHvsytwSsmoD2IuJp/bwmHrZpYe
   VH8f3gP/doAMblFZnRcDP8jlmvNX0hJ1bxDah5GBUnfp5zBIbzBupXgwH
   A==;
IronPort-SDR: o7gMsoqb3fOrBk6SArwRr+Lt4dS0Gdc+A+DMdzQXqNNV7RioYRzQERe2ho4Y0Lkf+T5cuyG97Z
 Afs+vCTCLHN0jVqvNCQWrDlfeFAlHuTN2HwDg4VbhTS0lWjkLEiITOK2bcVVuULVkSn5Ol/w8y
 yjLfCGUCxBg15lgrHy6cfg4HOeitxY0KkU3jnd/ibro5MEx58Boj4n2ars1D4tdA72LYEst0mu
 AYRkHuNkSzy46ajThuwsb7ADXWvWiGVY1KvMFdexaE1mWGuxu9u9/lnzEnhSQ6A26qEZNEqCiE
 M5w=
X-IronPort-AV: E=Sophos;i="5.83,239,1616428800"; 
   d="scan'208";a="170253876"
Received: from mail-mw2nam08lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 16:39:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8WLF+V8Ig/V/bJZpCAnqExQI+ytRAPkvyMRfxL1bvXWRLbGe7b4PQexx/79U4+IkCIkAewGAU4379Wyxw7Xqkd+OH5K+cR4v764Ll2/dCrGYSXmK7XNvEB8UvuJd9Odfq9v4Q9aGsGv8k8Zs/cSmhq3hqM0sUo692/A2EXH7HF+/ls8Wj3ye1DWywXmhzwWwjdDuUKupqIojclVCdnGr5Eg8TnZeXkYpc1dBDqkaeylDNat2+neHv96HtUaN9Z97zqxEb/0n7JizmHBOsmydxkg7Na4DaFkQOcxXSUc8jDga5ODCc1rhZ9lO0ZqaC0t5mT8wkSEvG/ATsOJYzpB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7clz0PbtWw0rkqiNSXEQu73jWP6Lo+bYgEDgIWQJdg=;
 b=ackrC/Eul9h8devu5xf8jjg6g7GMKxK1Ku8xJzhm2aFUk68mR3GlagAOiNLdMjjjvhDFsxnIPPaDcJ1ReG0XLVJtyKMo9RXSxRla9lbbRIKqhit9HOG6z1zUzNwufFPSVaoISmkDn+4e1xPy/ShEqR70GMN5w1Q+xn9cimh5EjYCpZkENNgTztwRyERcD+Bn5An3rNRhHizz1XOFDUIox51ftUhnz8aJD2fVsUSITSXvopsYY2JzfoKiGDZABZACeQHzmnR/wNjSVIqXCnLe6ZAgjDqhUOG1K2G4tlp6eul2AY36sxQqstHKuKEBNnyx+BvcFoW8ewn0ZA8n6K7t2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7clz0PbtWw0rkqiNSXEQu73jWP6Lo+bYgEDgIWQJdg=;
 b=RSrY1FQL/HZvLkD24QVAEuVcCiBl+PXvWV6TPTgyF4iXWiQXHjMmBdB9ZgSEbi/+4OaIcQFiyKVu6xNTl0jfFyExjaT4Vons5gSHAXClTsDOW4DFFt9m+5msFGW0OpFB3RDfH5dqs84XNEae6YRtji1xbxm+v3Svkno+nFCF+9w=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7317.namprd04.prod.outlook.com (2603:10b6:510:1e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 08:39:24 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::45d7:388e:5cbb:ae1e%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 08:39:24 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Shaun Tancheff <shaun@tancheff.com>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v2 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXVsGfFY7pG1hAmkCFCeeByrGZWQ==
Date:   Tue, 1 Jun 2021 08:39:24 +0000
Message-ID: <20210601083915.156476-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2af908bd-16c1-4cd8-8737-08d924d8c286
x-ms-traffictypediagnostic: PH0PR04MB7317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB731705170511C80AD3611BAEF23E9@PH0PR04MB7317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xn9UX0YWyRNvqB0Z8A6Peoz3Q7q56ikJYGrgQQIGQApcUepDMVRcIlLaxKh8JHIembUlXND9pmwjBtFa1AFTXkGcfk0CfpR0U0mRv+Ppm60dDCJ6/FArwIrOzRF36iBn76k/oqsnzhe9QC1aZ7TCwtMBR9BabvqfuSrkL3A5R2nvFtDeR6C2V2K8CrqiBXgpIwMNg/Lu1rruO7Gm7k5Vk0MxyOnpMZT3SO9radBQYPz7ns9mKBa4XBHZjs5nWTB0jpaPQsiXH6cWsvF3BPQpSk5gBaJ+lzhERiV0qEEDLTNEoiIMsW6S6MaBF3JAeei8hXYu4MfZgevbRfXiMWHwh1Oi3j3DXMnDzAriaYpyS1g7qMHhjcnMXiLfThNR9P6ygppl60xvmC4eCNbXZOl4YOy+7LSPxqS+gHMcAF5kxG/XAoqsL4XyxwW4CNq0mGExv17Na9OUcHZK+aasFWfWtP1e3w7Yvcg1x2bFoFzA5iwvNIfag1DKEToPQ4YSqbqHBSFOCfQ8mQpEzIPSZlPE0++Ajh9iLAV1QlnTf+Regka9g0XtJkFjAmY2dFZnG511NkcruorkU3diARb1cS6xdPkSp6byMIDDZb1agTIAQ9k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(122000001)(110136005)(186003)(54906003)(38100700002)(66446008)(4326008)(64756008)(316002)(478600001)(36756003)(5660300002)(76116006)(2616005)(66476007)(66946007)(91956017)(8936002)(4744005)(6512007)(86362001)(26005)(8676002)(1076003)(83380400001)(2906002)(6486002)(71200400001)(6506007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?awGfd8cvYfI/J/RE8eVfK/RUjcAd7RhhS5WcUNUd8BsaJXZil5gxEraMho?=
 =?iso-8859-1?Q?Tsw/NuHe8kvRqxzWaZspZHliHMPgnBDn2VlFdKtJZBeay61jEgz0gGKKlj?=
 =?iso-8859-1?Q?4nS6IoKSLDztPe8CRBzcwstB0O5NyVJPzl5INtkPJHFrvjo8UuM+mHk9+1?=
 =?iso-8859-1?Q?RwKv4bW1xpjR2MYB0y11et3tMWO61O6D4OB0juGgYRQLcjm9LjR3/gfXWz?=
 =?iso-8859-1?Q?s4J/zvzuipD59m2r/OhUC/mmLkpWNCkE9FDKIGvnthPbwW8tKfKWIa0rSS?=
 =?iso-8859-1?Q?rKBgIFTIPMTxgr+Biikmf4HAEGDNK8WdPmW/nbKZsFCRrjbNrEm8okTmDW?=
 =?iso-8859-1?Q?Pv/CyXfIfHrvB92Gt7qKvbWO2tjZDSOexoxJJY8gjjLlzOMeRg4EKSPyip?=
 =?iso-8859-1?Q?3Ozxi1hhetbw6UL6iLET4T/ve/FPJ0cG3NcuJtVeHQlGLseHP+kjBoxkkr?=
 =?iso-8859-1?Q?4PXKk1JJBQKjxFVfoS2mBupB88lZloqtb6zUKwTli4x5h0+J5ut9uk+X4a?=
 =?iso-8859-1?Q?3KG4CC+YQ8HL8Zo9xzW9VintIwpY8qRaFurKuF+aTa6pODPHI/1+R0gj7+?=
 =?iso-8859-1?Q?/RBcc4wC1DWIdKanELnaMJHy/DmM/ALihBLy/SnFH/MKqX1iMH4Luh2aeB?=
 =?iso-8859-1?Q?p3ItwMaUSUmDI3QdFiEvLTs0145Yw1H1Q4r9fkfJ1JM9c8TXrZpvriYKPo?=
 =?iso-8859-1?Q?3iSyMrRrBvZYq62nalgdckrFPbr16kLntVm0tUdG+pafUypWV6H278iwyt?=
 =?iso-8859-1?Q?xZ1T79FHhwGUswOKfd/Er+FCMB4gPpd67V0aHHEIhDoUb2xYaj5QDh8EJc?=
 =?iso-8859-1?Q?MMvGNVxcYpT80Pk/RtuT+InyXWZlKR/MBSSrHTWA69z566tBhlrwHbaP7H?=
 =?iso-8859-1?Q?fZK+8pvOVs4iKLculw4zSVliIik0T2YqWauzcWAfsIwYq/gXDrwYl/bVsy?=
 =?iso-8859-1?Q?zKt81yBk03rwD8nQVJeJvHa46hLuMUQ8U1+aZ+klpDnBN9b+W3/BBCWVoS?=
 =?iso-8859-1?Q?5trbrwU7gFrN7kSd3UHdCDobVyWABmZDDjdN1n0jJprS18Bcsr2elHNRrF?=
 =?iso-8859-1?Q?pEMA9j+ckrtb6kVp6ZoSRLiepJuXHtUYxcgSL592N9Cf5j+vdI3SPAzO7Y?=
 =?iso-8859-1?Q?1PSbPM80z3w41nhAJoag/hTplzQtrQUEZvUyAijJ06xYMc+PrFAIRzhTUc?=
 =?iso-8859-1?Q?dQ47Lic0JhljYhpf76f6BqNJGFiWL5BXtu3q6oPP7KcNzBvQV/+dSqeOi/?=
 =?iso-8859-1?Q?gOzNDXXZIiOw/XozBsHWR/oVUkdsaFyBNoICUo5dQk5bVxSS7vWUR1x5wt?=
 =?iso-8859-1?Q?97oLqn10dASX8rU51H6xSGPtFLMbTP+cAWqaXObILEO55ymj2dYlBZ53V5?=
 =?iso-8859-1?Q?n2llXr3y9r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af908bd-16c1-4cd8-8737-08d924d8c286
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 08:39:24.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: El6BRMKiUfwJWRc3ECgAQbQBVQ1YcLZHw2zgLlip3SEjvdN0boeuTLEkE5OmiuyB+EDGeWYWH42WUq9AiwO0gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7317
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
CAP_SYS_ADMIN.

These ioctls instead only requires that the corresponding R/W access
control flag to be successfully set on the opened file descriptor.

(open()/openat() will fail with -EPERM if you try to open a file with
flags that you lack permission for.)

Niklas Cassel (2):
  blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
  blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN

 block/blk-zoned.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--=20
2.31.1
