Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38154C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0F215A4
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kxqsCWqe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xqB83TzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCJUGM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:06:12 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21286 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJUGM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 16:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583870772; x=1615406772;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xy1nHYvlca+0SW3S/1h2lIjATHr4sq10J4dbf58wSQ8=;
  b=kxqsCWqetBRPaVO5NH9tYPQbmYbW0EGRRJZkNpy8Q50CK+J23plnxX2o
   e/osqZIBSYhoQbLZTwfKSmG+K+ZctBlYhxvbmcoex2I52pOq4ai8flLYO
   SaDdErHLZIqakDjWSaaLU8y8cft06D9zepWAci2Q7ZbaFfSPkbtHtC+jW
   3g3VsI/VVUUpt3KeEV9/7gfElSJaQg8BBr3n3cJSEZVDLigBhv2G2E6Mo
   mLvJVI4krawwGnGlQm3j6LzaLsNvvLaEJmGQ2MMbxES1/BYFcBa8gnDSh
   BMfMWlXmea/eDxnMRLymCi61AkzELIusC9TpS0AE2tLYHgZcjP1rQh4gv
   w==;
IronPort-SDR: 15w1VcWKyNhVE7pA7oEyXSol0az15UjfY2rBZ0PyrOZ0pIG6NLP/vzkhOzatKVnvwDYeq5/eaI
 MHdKRrFoM5yeNqMukObCGkXGn+UzddNrEDuPQXnz+XQQFTBnR2SGQBKOpCM6mqsU+f4FvcIz6J
 U9TMDpBHdPul41w+f0OEFVq2YTojtX2VCb3Z00THipxkudyHiE5uAPw+BdCAy+h4ErAMwgTmjY
 KyLKhXDObg+3DMiXP5B27e7qR6fKNou8wsG+FfOza3ttVz0lZmlyzc/do7YGq4DTfpaJGT5bpY
 QDU=
X-IronPort-AV: E=Sophos;i="5.70,538,1574092800"; 
   d="scan'208";a="136465773"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2020 04:06:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czxJ8Gb2ameHysg2n/c1dtd8tTu4xDgh1B3xpfD83pQYmw0W8XTMyHrtBsiwNZy2bEy4XOhWj3D7I8lC64jRmro02or0lQuY2esr8w5cw/d8AaR1OypAbfi3WqUwv5B/p8xyZhSd+TgOlgUYsTrriOCO76dRlZrgvPHV8BayBOb76t0UiqsYnxeVEYjtTSkIH34ykiDRFU2I2dZJVbg31EGD3+N4pUQtbEsEdmuNM7bTD2zd7wvO9eZaQ5ubwvmtuiiPiL5t9/XioGKIWKWVeplTWVD18Tp8AufcurDOgqdA3otMED/4URG83fts6avBNIxPgyqDitq+iTDgKFJkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy1nHYvlca+0SW3S/1h2lIjATHr4sq10J4dbf58wSQ8=;
 b=m+IuZfF9nf4kB8WljIy9Zau3Q0tpqbwhRqguNEvKrOKNJCtqS/RSrJnNB10O/YjqLKIjsU5UNtcTHwp2uBuOOl7mKUt25lOcJINeqmDVIwGHkgTBP/dsni8p8xBB+byX8MUbDYqvrFl5MUjbDEdyLW89tA1c3yx1bsog1bdOz9wug+tFtab8NjJLZBx64eiUU+cmJ6dLZ5dWQLx4fDCqchS2RTcBURMwEmuM7LDo4ZR8VHz4SLS2cntAA+G2lmzPBYQa/OGfHpcq9xKugZgFV/o8iMiKZcG4LokVi+XhjI49XCxFvQkwIJ+t4p9ymUHWiCABsge4ZUFaIKt/MpihkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy1nHYvlca+0SW3S/1h2lIjATHr4sq10J4dbf58wSQ8=;
 b=xqB83TzDqD63esGbUvFpTwlvmpyopgLPOkproZ1KY4gJcRupvQUJ3MqiPfyOU9ivYFM4Exm2Y9EEl+xuZmtZMKU8mPcL7hZOfadbnyEvMehNVbELQUjwTqwjiBTrJjyGVrVC6COyl1FhKwAj/qukgNochgT2S4gwj6fXOo3YApY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5077.namprd04.prod.outlook.com (2603:10b6:a03:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 20:06:09 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 20:06:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Martijn Coenen <maco@android.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH] loop: Only freeze block queue when needed.
Thread-Topic: [PATCH] loop: Only freeze block queue when needed.
Thread-Index: AQHV9tzWizCqQ9yVzkSRTpgNoS0evA==
Date:   Tue, 10 Mar 2020 20:06:09 +0000
Message-ID: <BYAPR04MB57495AC9DDD87E250770419086FF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200310130654.92205-1-maco@android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 634818e9-0381-4bc1-eb30-08d7c52e7967
x-ms-traffictypediagnostic: BYAPR04MB5077:
x-microsoft-antispam-prvs: <BYAPR04MB5077814FBEB867066F47475B86FF0@BYAPR04MB5077.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(52536014)(71200400001)(478600001)(8936002)(81166006)(81156014)(4744005)(316002)(7696005)(8676002)(2906002)(33656002)(86362001)(55016002)(54906003)(26005)(66946007)(5660300002)(66556008)(53546011)(66446008)(110136005)(76116006)(4326008)(6506007)(66476007)(9686003)(186003)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5077;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72I6XgGBzbz7bcgbSO0JJxC6mNJBalxyQdcW9CEPFknk8WPJp5/mkHSdOEKP5FjVVk8GQcaJmjMCequCW7fVrJVcC0oDcdXcMqb/htXPtOPGDE8wGoYiU2JyosrZpTyqgkAeFIbAGXLUyLrUryzFDR2Z7zEL6xpB1fYlv3fWKxnXmlgvstCrEhKrbq73pXpiKDeFGq7CpDJ2griYjcDdtSv/rhRzYKtL8D/FcrkCluRozldrdfhENf/okVmzCh8tMLX6fjllBX06Be5DfAEQAnSHBd55NLzcNIN5K7QUzTqBH20eF51rCfvoUzY1uLAxx/Az/NQGsUHYUWKtOerAFT2EJk9m5myH5SrQRo82zUopW8OZISSWUGz7iTVQbRq/cz0XP0lpNcTE9nooeHVwVpnYy5FK/5JHJQ8/y3KlCvKMrcWMyri7KE2INDxFLcLZ
x-ms-exchange-antispam-messagedata: 0CWsKyonxF7GLDS/CVo0lyrRqZOmdS5kJquTXUkTNHMxSKLI+f3QVPiIgUR+8Xk0e35QiSD5x3Kyiz1cwzZUxBQc1OAJgZHiII5J7DlH7cZtiGf0ybnI5cRarl50LVmBG0MxSxFecVbTsR7r/OelrQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634818e9-0381-4bc1-eb30-08d7c52e7967
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 20:06:09.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FICMu/A12GYHBZaXA2Ty62It9fXUduvIJoUTzH3U2jdfts++U0XClf4Gdh2VzOe8CvROKbWNJbcnpzFO+mFIfOP+tKboEiCFJKNi1wCGgZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5077
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 03/10/2020 06:07 AM, Martijn Coenen wrote:=0A=
> __loop_update_dio() can be called as a part of loop_set_fd(), when the=0A=
> block queue is not yet up and running; avoid freezing the block queue in=
=0A=
> that case, since that is an expensive operation.=0A=
>=0A=
> Signed-off-by: Martijn Coenen<maco@android.com>=0A=
=0A=
