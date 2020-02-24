Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF4C35671
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E02082F
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A1zyTgOu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q2igZOrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBXLbg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:31:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30252 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBXLbg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 06:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582543895; x=1614079895;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=N5vrQDbF/OQrDY4oIUK1WLAh97WGnta5GY/Jk+jMfxI=;
  b=A1zyTgOugglkmTijQYwdtUBxqr6NpWE2TD1HGu2pBtflUt5AFzHwHVm5
   T4Im73uU9NK2QZoM8Xc9LSlv3n3tRYzdrqTtPrgkgD6P633gQGYv/Z+oh
   hnUKh4y1gSHTQWZ+HbOFs4+6A6Owe/C6vfuN+pkR3+V/dwySCy4DlNhjD
   libdhexRosnKRoEoQOrcGZbJaKeC9iJsEDyerdPG22rem3xl3ancftXTV
   tSuNP23JJGZUFnXOUBG5IjYZRETUdouPSeGRaZcRJMNSvKFZA9zC0W1bP
   G/FZxV8B1cBlrFMQ612EMhB3bJr/fHSYatJhehx6kbn1HDDXOHALir0LE
   w==;
IronPort-SDR: AuFR0qHdVb9VKyVHK5zwMiGBXSIz8zjOIi7xfORzUDQkvChFsed9Cm/KWNkN32mQTqJr7iaEAZ
 ROX8xqlwqLc9A18Sjfws2VBJyF/tcTM8erNe8BDvIeFf/TcUeeshOjDD5aW51xsBIhjhfV/d4G
 O5q//6bCVPY8CVmeHAeeBlrc/BnCJE3zOqWqYubI0AvGjINxtEvgJJLrr5M9IV8qWu06EOBnTI
 csLeS199cdjTjOfNjLoTXhPG1xCIG4yoUak8a9uycO1tbL/0K+hLivNmsToQ1NMRiOmLs/1yFk
 h/o=
X-IronPort-AV: E=Sophos;i="5.70,480,1574092800"; 
   d="scan'208";a="238710888"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 19:31:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k26eL2kLsSpdTQ3uM0QiuExT0lObQBPvLq11uPO/S9v3Pg2zPmSBRodaMI77/K5EvvJi8RM5YXk06qoxec5F1dPLUaefWtGKG2vIX+xNRujxhyL6kjvAym3EPI+L5B59k/d3y/nD981Df6s0S/fsbFc9CSL3ut/gLUCs1OuwnLJp7Jne13hfrRnrEgXjjU8PV5O3un5ag6fVqrpiSb3S7mKa5uP7HtVCmLLSv7+UrrO2aSJRlkRSKR6li/pFW9Nviu3HjVYdEgBuCQgSc9alpBRAqHWfhv8u9rxm22stdguj7mCHTWpt6iXjLz/ak/7KkkjSGIUzxIM/ofI1854EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5vrQDbF/OQrDY4oIUK1WLAh97WGnta5GY/Jk+jMfxI=;
 b=lDt3w6ubJAPqDeSgVGa0auiUhPMIApdSsrRnVM3+IjXn961n7PGv1qAygg5EsAVls/eDxIfpL8ZHgqGkTufm5tBZ80EVp3FCzkr+ptIrIn+0aNWllwsvOX76oRcfeYiKuIMCF5sHs9aUOPeJ39dYWmOspNtCE8qrHnzYMSv+t0OS3wuJlCSEw3sVuGyuB43CIWot0XdYg8odlrxTSRfDSlKuPWNRAbl5IODo+RAvx8Pm6MzwP1DdUixAkQ5LiM906xS4D02yNifMxUC5v9Dxk3x94gPuqkLdqW1LC0r/OoSOVHUgaJa7Ya+eM4fd+6ECdtFTVtAJa4TR0e2jXV4q7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5vrQDbF/OQrDY4oIUK1WLAh97WGnta5GY/Jk+jMfxI=;
 b=Q2igZOrlyUNsZSL0G+CmlpbdMlBe+nWZ837A7q3EeNkGUs2JDwHuuGzBg9+jF4aSIbbyn4QlX+kZ7K2p+rSgORdENZ2P3snQ5DEUH+Z4XFK1nI/sL7pXWNA1pI+1rOapxH4vClvkazMIUOzFkYGGS/IerBZJ/ecZWqoSr7FZp8s=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4632.namprd04.prod.outlook.com (2603:10b6:a03:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:31:34 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:31:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v3 7/8] null_blk: Handle null_add_dev() failures properly
Thread-Topic: [PATCH v3 7/8] null_blk: Handle null_add_dev() failures properly
Thread-Index: AQHV6GY9vGIf+Ftcy02c9olu45CAZA==
Date:   Mon, 24 Feb 2020 11:31:34 +0000
Message-ID: <BYAPR04MB57498BB6E240CA5336F57C3E86EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-8-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1f8de82-80e7-4704-42aa-08d7b91d1aa9
x-ms-traffictypediagnostic: BYAPR04MB4632:
x-microsoft-antispam-prvs: <BYAPR04MB46327A848F3A9949476DB4B786EC0@BYAPR04MB4632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(86362001)(55016002)(4326008)(66556008)(66446008)(66946007)(64756008)(4744005)(5660300002)(54906003)(110136005)(316002)(66476007)(2906002)(9686003)(76116006)(52536014)(186003)(478600001)(33656002)(81156014)(8676002)(81166006)(71200400001)(8936002)(6506007)(53546011)(26005)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4632;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /N3B+fY25vGWUS6vJIlfV7RQFycFGLMhF1Vu+LkWeAd9SwQicgd95IAFMG8VqNkkoaqouldr3DcHsLxSrMD95wHw50WNjZcdmcrZQQ+vGdzR9TAYDgtoW5xCHOsBe/UOemuloLD4GP2FizIitdR5YXjdqsiVsVdkpjCDqV5h5JR3VpScC9SQIMeTgFt4V39tH8Uy/2aYkGGmfUuA3mqYD+d8Rvg1iCLokhXEZj4PTjyK+s7PdB3T12Xplot9S8ceRPIkHiuS1L/4g+tU1tyH7Rv7X555Jou7t9566aLxp/pISwY5iTbo4e3QM+nvjxPWJNXue9+/3A+01KAg4KqMk6elVDQiofiZNjavGzhRwIaydIJdIZE+BHh3XqjzzYKydS8hvyfZC499GrA+0F10v/EFFaQ7dIt4mUZczxhlaNfnFQ20WvjSlZF+EashkFNy
x-ms-exchange-antispam-messagedata: auV1Fsuxy6KA31tkt3a+4muTIw4WGbwVLy57SFMaXaHpr9y6qfg7jjgMzlfpR9BwUge0Je8n1m4oFaJzmTWubbBWGtjdzSItsZZVyKfcJEBDAD/LD+Pvn1l5hmIuh+Ql/QfuqDJr4DF4gH5SXiPzag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f8de82-80e7-4704-42aa-08d7b91d1aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:31:34.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6Hr4raOkqr8FCKH4rw99SWpDdcEV7GmNMcHvVNoEZt8kcjsbVTycTj9DrZN4K8LVYGqqpVewrtwlxaPIpyTgeAXRZbeMIBoGPeM0pz9TiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4632
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 2/20/20 7:23 PM, Bart Van Assche wrote:=0A=
> If null_add_dev() fails then null_del_dev() is called with a NULL argumen=
t.=0A=
> Make null_del_dev() handle this scenario correctly. This patch fixes the=
=0A=
> following KASAN complaint:=0A=
>=0A=
> null-ptr-deref in null_del_dev+0x28/0x280 [null_blk]=0A=
> Read of size 8 at addr 0000000000000000 by task find/1062=0A=
=0A=
=0A=
