Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67994C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303C4204FD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NmTPm6O4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zBDXQle2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfF0IiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:38:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45821 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0IiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561624682; x=1593160682;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YAw/JEw5DWf1Gs6D6lMUb6/R+nx4wAn1Zuc1ChDVE8E=;
  b=NmTPm6O4AMfm/xXMUMeeR69ngQE/IZDswsVhp2zbAa8iwswg+p0hCv3R
   5hmOOdFIY2gEML9DGCujuzcLqYJ3aLgxd805RcgBjOwMh/ifZPIpirJMc
   SwzNIVDklqvXDgxcdfNW/7ulSzujztL1NMi2/dsNBFSrU54TSrGrNEwV0
   XDIu3ZxQs83PhMN95KJbhZLLGUhjzC1c5rDUvgYM8fAzvod88H1TkyJef
   /Wsep+/P6OZ6+cDB2m0AnEJ4MLYw4DXrWzR9uYPEQPOh5NPFLkZIyAm2/
   2gkrCFkRDIV3upAJX0TneQH6tSND49k6bdsdtQJQaQHl7oavSD67q5iRy
   A==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="113299494"
Received: from mail-by2nam01lp2050.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.50])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 16:37:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=t4+coCV2synPuGTOp4v/6GH1+Jal+mzZ3qeEopvafLpDEA7NWPVSU0wXyxaBBKT6gLR/a/+x2nfBlbbg+FqnYtUxWJLiBHiRmxfk7UZp5XC65rvCELDA2kDzLLaCYWtKiyvIdRAxeeo3l2xTwuyC2NGt7OJrYEZdQ+hY15Fr0z8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lP1A1XUT2u1+z3gjDp1IX0hXzjd+I+g7e0pfajDg9E=;
 b=cqFfj4bGVDy0CG1fUyoVjM8MgPD7dRr7R6Pw6ohplQRnsnAm06QjX61p+V56aM3T/lsAsiTwlYTozMvGQMENpKSh40HiphEWJbLv5MtXOGDOjIA89ifRROrEg8fHj5Q6ZttpZaJpPFNRSGdWQuJVlwcUPwOIaJ5GiHaC2PEBgpk=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lP1A1XUT2u1+z3gjDp1IX0hXzjd+I+g7e0pfajDg9E=;
 b=zBDXQle2hLFV4NNurVNRLyYn6AYzGKPtZCL+bC8AqRhPlUTRLHyx1GEoxdfsg6dsxy3NDNgmj01MjpnviSWTonDZKYE14ytLDitOt0fxshWetZXvkazwOd2u7S939zD88clW4ngO7VN7llX7DFWYskAZQgjoskGJ2Omx4pDzOuo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3832.namprd04.prod.outlook.com (52.135.214.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 08:37:50 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 08:37:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVLJMD9dFUXSCKoEarjaRxND+ocQ==
Date:   Thu, 27 Jun 2019 08:37:50 +0000
Message-ID: <BYAPR04MB58168A5EA02BC1AE58008F5DE7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
 <20190627024910.23987-2-damien.lemoal@wdc.com> <20190627072800.GA9949@lst.de>
 <BYAPR04MB581674B8668D6F3015C5C0C6E7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190627082545.GB11043@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 180f18d7-d906-40b5-4e42-08d6fadabd7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3832;
x-ms-traffictypediagnostic: BYAPR04MB3832:
x-microsoft-antispam-prvs: <BYAPR04MB38320B111E0C9E37AD0DD559E7FD0@BYAPR04MB3832.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(81166006)(486006)(8676002)(256004)(25786009)(68736007)(33656002)(186003)(14454004)(72206003)(26005)(66066001)(99286004)(53546011)(6506007)(476003)(4326008)(81156014)(8936002)(74316002)(102836004)(7696005)(305945005)(76176011)(446003)(316002)(71190400001)(6916009)(7736002)(55016002)(71200400001)(6246003)(86362001)(53936002)(478600001)(6436002)(54906003)(4744005)(5660300002)(66556008)(66446008)(76116006)(66476007)(66946007)(91956017)(73956011)(52536014)(64756008)(229853002)(3846002)(2906002)(6116002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3832;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z6CPr4jpHisqu0/61Jow06pSdNmyKOZmh98ezba6z++y49+kO04OTv/CDT/wZA5rsm3yOX7Fj7r0WW5jVLkmyh1H7chMAq5lZnXfciANF9pHd5c8BwZkqsH4SDmEyDlGdOI3SqkvwqnQfDmrEsCTr6+4H6lENAMLKXZWnuvI4kKG3CRbPQ8fxOXk+HL/tTuBXjB7FB7tqcqfG4kJDxtvBZA3MzMtcXXRJkP3RpvANIdJhSksDfl1UKsgw8E394P8vZN8jGLemlo3CdjxI4ulrfcoUiNtROLynJwKc7P49hc4qUYYkZZ4yxWJHB3exlESSKZQRGYWVPo74yt6tMLzIQtD2diMUlB2Dport/bSlPc2DnfUQc2n93mqeHEC3APAlMtnmVwRm4USbv+rCeqV1p0s225aEq0SZbZZbGDs1G4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180f18d7-d906-40b5-4e42-08d6fadabd7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:37:50.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3832
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/27 17:26, Christoph Hellwig wrote:=0A=
> On Thu, Jun 27, 2019 at 08:14:56AM +0000, Damien Le Moal wrote:=0A=
>> which I guessed is for the architectures that do not need the flush/inva=
lidate=0A=
>> vmap functions. I copied. Is there a better way ? The point was to avoid=
 doing=0A=
>> the loop on the bvec for the range length on architectures that have an =
empty=0A=
>> definition of invalidate_kernel_vmap_range().=0A=
> =0A=
> No, looks like what you did is right.  I blame my lack of attention=0A=
> on the heat wave here and the resulting lack of sleep..=0A=
=0A=
No problem ! At least we checked twice now !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
