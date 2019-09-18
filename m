Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E8DC4CEC4
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044482249C
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 19:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EkjnYffT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LJOSj1Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfIRT2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:28:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27425 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfIRT2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 15:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568834911; x=1600370911;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8Gwe8iro70ZyooAiDugMpO/Pm8wK3vNAh2B7KARTZXs=;
  b=EkjnYffTkNUgj4UeeYx3mOURJoYeFdGHNJzsWAhjiVEkNlORHDTiW4+y
   fRQlVqVirnuQ8XMaPGUh8qGp8X82R5KaP9lld4aT8lQneH2rGNdqeyhlv
   WIaP8Sl9rpVBjEG756H7q8Tdpx2gHnMTXPIpi8asHDeJLtCfvT9a175G1
   ytyImj5CwntiV+hGeWVTYzhlMUYsfwIrxmbjVT35lx6RygbLGJtFjOlO/
   8ed9tO9r2XzmHi2MpDGtu+Fngvw7FuoCTSMfnogJxMMYEJagraTvz4vzy
   ajVWDkc2wKUsJofo8RrDEChcvQHy9DSBpT5FjQirNz9M4ioqknS6/Fkyf
   w==;
IronPort-SDR: vs0XgVq+ZrIW0aB+J2qfiCuDlCjNN0g43pPNbllI6vy16CzpMv4Y8XVIh4M4Lmf1kjbyXAD1y/
 bj0/z2E7bR3CLIJvepi6h7/LxZ8qEJOC7cp8ucgoFP5R2MZw+IuMsFE426xjFTseR66R29Dv1g
 Bh0uNN16FT0ZiDCmfKdrboHRMTrKJ/Pn+8epNkGTS6X8fw9pDfvL7k6BlXsBmxeAhf1nIR6Hnv
 NLX3XmGvay+hA1gka0jT+M7Lxfrxxe3S2Xp8UsDLQ+X71Nn5fK2hs+nbanMoIHEy2NA+jC7aTr
 zHs=
X-IronPort-AV: E=Sophos;i="5.64,521,1559491200"; 
   d="scan'208";a="118559843"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2019 03:28:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8xyhEf9quqWHJI7ul2fwze6vGm+Pv9cR7halW3EH1k2hD6dvvOLFCkBDg5t66B0cGKyrk3waWATAUmgf4yAbpcs6XiBUXERofPqNqSVa6oPg5FTUBID6+3hahgeJydYprWeQN+Qx5Njy8iC+kVnW86DOTSDnkROFSE5ZUM7goPADFh8PXDwXyDssToiccgFZl9WDbyXDy4a+vYwHPL1ic1zA2k4LcnnHWqaKbx5W1G/7LD56WSP/w6YA7EuRwUCIJ3y8dqFY9XOinfCDnKbxyeCq8FwEA9bnGXN5huauG9zNV9l/dw0O2g/e1k5+m2XX8OKqOC8Q/xmRNoI3DdTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gwe8iro70ZyooAiDugMpO/Pm8wK3vNAh2B7KARTZXs=;
 b=b/nSIcxDG3+HndEhd6LPyw2KRYo7NElpJ3yHFBWZkiMRt4T4LHljpi8EA6pOtjPj1ncIaHaD1ZAFCBHzufRoXGOoZ8opgPeWq1MbzqPowJXVmXTX5p6SaGQ0IZuycj/r8VDxMuBGgxkZTGHB2w4xVC5c6ym8shzGAqz2nkIk3QHKIRTZgr3rL/gziYGJ3IPWbMGHkSvD4jF/rsXICnbUgAJJ13nE5At7xgh9m92+CuUl+r/jfjTZoerpK5NQ1OPw/lZZ3UfEu67BQ6PIYzfT1YkkzO+4xO/41V3aOWutEhD/kdEffPlECVB4hzul37UVseha881vHGMLbBZqtmmxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gwe8iro70ZyooAiDugMpO/Pm8wK3vNAh2B7KARTZXs=;
 b=LJOSj1KtboLE+j66w5yPJbRF/fjvcsw5EAsOS8OuX6DYnfdNBMj5OnDJZfXpZz+7DOrKIBwT51jmlS1F6CpZ9B7xSdXirMmQ4UlI7ywqG/5niNNsQBR0FdWI/xeCBdPro2mFVOm1/sJaXHRIu5CMqC7c/b4z87JM31TW8WmI4ao=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4997.namprd04.prod.outlook.com (52.135.234.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Wed, 18 Sep 2019 19:28:28 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 19:28:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH V2 0/2] block: track per requests type merged count
Thread-Topic: [PATCH V2 0/2] block: track per requests type merged count
Thread-Index: AQHVbbu3jcrUtbDbWk+hQetm7bQSVQ==
Date:   Wed, 18 Sep 2019 19:28:28 +0000
Message-ID: <BYAPR04MB57494B7D18A17A97A09C6661868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190918005454.6872-1-chaitanya.kulkarni@wdc.com>
 <369ecccb-06ca-68d0-1474-34abdc2e8851@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7902efda-7d17-4ddb-7543-08d73c6e622a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4997;
x-ms-traffictypediagnostic: BYAPR04MB4997:
x-microsoft-antispam-prvs: <BYAPR04MB4997E0578EBBC3F527CDDDF2868E0@BYAPR04MB4997.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(199004)(189003)(66066001)(14444005)(2501003)(446003)(7696005)(55016002)(99286004)(110136005)(6506007)(305945005)(26005)(2906002)(53546011)(186003)(102836004)(476003)(6246003)(86362001)(316002)(66946007)(66446008)(64756008)(66556008)(54906003)(66476007)(76176011)(3846002)(52536014)(76116006)(6116002)(5660300002)(71190400001)(8936002)(71200400001)(8676002)(229853002)(256004)(81166006)(486006)(74316002)(4744005)(7736002)(478600001)(81156014)(9686003)(6436002)(14454004)(25786009)(4326008)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4997;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jyjaskfkk+N/uI05zvzj+3KTJ2NreQPYUe6aVAIDpIVoHIsjTVn2McybKgcrK/1Mu2tVQgciXV8WOtNBH9jQuZ6EIdf8ml6kE5C5LQjiLGIl9Tpam0fBzrqjdXHqPgecEtr+L9QUIfGc+2C7jyjWBuRbUfXz8IfNGf7gEnihACAtTBv7bItncphBM2tGl7UX0DqXKhs6omsYlK70wlkrQPNpV+6kH7i23nexG6m7yVBRQ1cKW9Z0mokZSCXXiTAtbdNwbtoR3nRbyAfWFaPIDG9+fyfsiODUSI3ubu/P2NhHAFTa4ZohefV/9emMsXwljkE0e72tRUepkIS0lG5C9kJPzpHeOWXb0g+c0pS8AUZD3eWarCgQF3B9F0bwbRuNAH1ifeY54bVpIyOcgardimIJcU5zSQSlOWGwqUHYJYo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7902efda-7d17-4ddb-7543-08d73c6e622a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 19:28:28.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzcPC8gPMEdBJKqAL+Df/njvvi2t2qP+tf8ymm6HBBaFHNnOQbKjPg0lxxji8H4WFSS7rYQ1P51iyZxRCSaXmZvceo8SZdPffWY4xjm5rLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4997
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/17/2019 07:32 PM, Jens Axboe wrote:=0A=
> Regular io stats get merging stats for read/write/trim. Why do we need=0A=
> something else for this?=0A=
>=0A=
> -- Jens Axboe=0A=
=0A=
Yes, but we don't have a mechanism through debug-fs to have such per=0A=
request type information which makes debugging much easier.=0A=
=0A=
One such a scenario where we want to add a new request type and=0A=
examine rq_merged not as a whole number, which is not covered by=0A=
the io stats (since it only covers read/write/trim).=0A=
