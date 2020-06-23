Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2410C433DF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992EA20724
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 09:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OZ12Dkmw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ESowi1yO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgFWJUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:20:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19179 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731938AbgFWJUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 05:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592904053; x=1624440053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=acr2u++7FQrbfQL2AxGLahquLcPGe1nT+TWZ2Dvzsw8=;
  b=OZ12DkmwHNyki2T/Lw3EUpNDmi4TV7Uam+11ODPS3PoZGse3aRxgpacV
   jmkhgK1J0AiOUJOjZxlTxP/3JIQMbzJPU4DEx3DRqFIVk9nYSgB0lTDfO
   MVa5kaVdbZtRVW7rD9Csrhvf1Y1FQieHf2sHd9V7zclJ8zTIUHFvILOh2
   Jkib17NPoOoahpvwTX/Trz6wddsxllTiSvG//rbFB2UwMqEpQAalKmAjV
   N3HGKpPyBcwBJB+q5qfw3dtQrP2K6IwL1DyeyM0q9XN9V8cCtgW3iAO8D
   t4djKsc8kTaDOGvwwzsLqjRu+RmYmyIaRhpvEUw4g2RJN05VFG0WRDAko
   w==;
IronPort-SDR: J92kb4ChDFaZmHcSlgO432iFcS170L1DTW9SY6Ec1T4WNoEB92HjHuN6QvHmCPcKMWv7QojDT/
 l7QNgPXPne8Wav5dXcjfWkOyn3+cf+GfkHJqh8BpfDXAQdbDgPt9a+F1wJ4ate7A0xEtUegI62
 U2KPMswQ7tEHVh63jAe9goL1xfTUU2FN+0srxos1GV4lMcMk7Z1zmJQFuWbpg4V5k6wKD3UjAl
 ycmL5062vRJgsECeg4iIZBswr9taxzYCautkRhPL9dwHAfCtL2+SAEiA6Li8P3c4EJ5LKYp/Zj
 EGM=
X-IronPort-AV: E=Sophos;i="5.75,270,1589212800"; 
   d="scan'208";a="243680213"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 17:20:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkPChqMv1kgJYCroHpGmmH3P0mSqTrfOXMLh0ZTy3KLdAKjndpIm+vawV8dHeYbrfJsC5HExu2oGvCDOJui1je1rQMQE7uQ4LWLct1E2wmQ7IH6G0SgtYotRaG1MmP1UWIBvz6xUr4cUr3/GOwicKbqB4Uh8jm2mzwlvHjyytz9gBiURi6DOrLqgOR+h/noGx48tgTHfYW2xPF7sbC0vyJTNjLHvHXWW0NEVsz9zcJPgsZEJj9mqCwFyKk7gr8mFHFElJGWQPMAcAecLc7JG/oJBhIW0IuOvgjM044tBRpvUZsb66GrZ2036AjlKJG05tB0UF8FnQ70fVhxc+S8zcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x8Pv88pDEatJsVDrF81bK0a5nl5fpRz6B+/2IBdpX8=;
 b=lX+PsgIFSY9JNk473qO00OAAU1tJ14YW+1N1uZVxcjlqg3khihg9Uht/FiuG5x318EORpVPHK5Mc7a4u9waGFjqWQBS2ZhK/5Wt5YuVixckQt8lYVEU/ZfHzAhgkLtyoj2gLpyMwOfD7M8mp+SNt2xrC9EHUvanmvfCfR0QQV1gzUST/eHuAf6UlOb/coUNhkIjPzuZmOTlg4lD+xhPep96MJK2XDzTSH2QOOFC23Zy2LNNP4+ONsDpPjU0YEksRde9At/EGOBl9ylC1U5IaD1TgEJjBM4Vl1b+NkN4Uuk1+vhRvQdVkhgXDCfBeLjTuGAq6dO9/yn+OY+1ZO0Rl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x8Pv88pDEatJsVDrF81bK0a5nl5fpRz6B+/2IBdpX8=;
 b=ESowi1yO3fdu6ixtyd4YHOf4/cEcDbXhqDwflINNjGzfau9QvIwh0F2vXq/Otm6NvR0au2wn33x9RceQkB3E24wPf5wTsi+MbmK4qhxRyME52VXJyaIB3+yjMm5xulzLk+IKoHhHv9szhseok+BcZtABmF1UQibjIEG6Wu/SBlU=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB5941.namprd04.prod.outlook.com (2603:10b6:a03:109::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 09:20:35 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 09:20:35 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Hannes Reinecke <hare@suse.de>
CC:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Thread-Topic: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Thread-Index: AQHWSLHEI+avTIAeykKLqw+a7Aouuqjlu12AgAAyVoA=
Date:   Tue, 23 Jun 2020 09:20:35 +0000
Message-ID: <20200623092033.GA117742@localhost.localdomain>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <5b9af756-f99b-c1b5-ae2e-7dd2177208a1@suse.de>
In-Reply-To: <5b9af756-f99b-c1b5-ae2e-7dd2177208a1@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 256aa8f1-0ec2-4928-5a33-08d81756afdb
x-ms-traffictypediagnostic: BYAPR04MB5941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB59418273BE3513ADA91C4E6FF2940@BYAPR04MB5941.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qD9ex7UvfxCFZUcButx/KtvJTrPYDofhW0Xjxsc2fqMW3naHBv0LXfQB85TYCw1qC8JyigVxj3WY2coohNJVFZpsN+QOsNA/IzQiQkTwZLDGl6ntN/w4uUIMt5VjCUpHAqFJsej893PRjH7DsHxBDNRxv5D2qlaf1fcTaL3vmMMnQmiM0+F7LuC3QmsmpQvNTtqT7Ib/moYrk0168H0YsL9g7pTvU4TEnirqffmP6uRT3JWvToTHAITtp7ZJ1yP7D6C3/qsPCxArwj+v+ON2jKISssLRNejfxApP47GZUGOz4zyBto9RJPGRvbv591qUjj19WHna1c4CWujPp9oK0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(54906003)(71200400001)(6512007)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(1076003)(76116006)(5660300002)(33656002)(6916009)(9686003)(91956017)(4326008)(86362001)(6486002)(7416002)(8676002)(26005)(478600001)(186003)(53546011)(316002)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1yfwLIrT3ZTdIRBrlv4wTjvU8n2PBJbZa6uqBiCiWSTBVCYFuUoYyfgQpcgqBJ7NGSwzEPRZNNAdzNFtXSQDNXowJ39HXNuXFEyKqsU8uN3+LXJFi6cTg7USvm7VLf99W7y+zaPk9Ge3FXleUcEu62C8CiAaeOviwVZ4oAKWROZ7dEv9f9d6LXe++s4vDRZCkGAXPvnS/zKJ/OtC1+5DlW3A7uT7VP/8uikxygu2YkxEffX4dhWW429PkdLg3ITGb+9xDPF7Zr96eETEjutPs0PUxg+maeOH+mNQxeUUjGzcE17CabuAn+he2Gv2Jaz0+kk9vSpWkUZrsqCQoOOcwW5wNYPoUOW/BubOF9vlN3ofOc8NUt58NupYG9Cs+NUfXhU4PxfQ5qpT5XWc+tTTGGGBedt4nNjV8MnPIeoTAk9qsqTXN2kL0pCU6b9E5QQDv358l1zFDXhiBsYOwasByHCiyvajkPf3b8paxxjDAWG1pI+BTe4NSh2lssVcys/q
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DC14742D6C69154095969E8AF9CD682C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256aa8f1-0ec2-4928-5a33-08d81756afdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 09:20:35.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXpQ5k9cXp0Xk2Mb6aE5/y4YjikKQrYUsgP83yNKW9DHPYdqLnqmL6D5bw+C//TGkJH/fTdrpQaUWvKMmFye8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5941
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 08:20:23AM +0200, Hannes Reinecke wrote:
> On 6/22/20 6:25 PM, Keith Busch wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Implements support for the I/O Command Sets command set. The command se=
t
> > introduces a method to enumerate multiple command sets per namespace. I=
f
> > the command set is exposed, this method for enumeration will be used
> > instead of the traditional method that uses the CC.CSS register command
> > set register for command set identification.
> >=20
> > For namespaces where the Command Set Identifier is not supported or
> > recognized, the specific namespace will not be created.
> >=20
> > Reviewed-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Reviewed-by: Matias Bj=F8rling <matias.bjorling@wdc.com>
> > Reviewed-by: Daniel Wagner <dwagner@suse.de>
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > @@ -1792,7 +1811,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl *c=
trl, unsigned int nsid,
> >   		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
> >   	if (ctrl->vs >=3D NVME_VS(1, 2, 0))
> >   		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> > -	if (ctrl->vs >=3D NVME_VS(1, 3, 0))
> > +	if (ctrl->vs >=3D NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> >   		return nvme_identify_ns_descs(ctrl, nsid, ids);
> >   	return 0;
> >   }
>=20
> Hmm? Are command sets even defined for something earlier than 1.3?

According to Keith, usually new features are not really tied to a
specific NVMe version.

So if someone implements/enables multiple command sets feature on
an older base spec of NVMe, we still want to support/allow that.


Kind regards,
Niklas=
