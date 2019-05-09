Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07CC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DE22173C
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 05:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Eu+RuYBd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TSqTBu4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEIFwy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 01:52:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40825 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIFwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 01:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557381173; x=1588917173;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DjmspzCOUYLMyYoWtjAA06S+S1HMC7srn4InVsa/CMo=;
  b=Eu+RuYBdTe4j3WEwFQ5QF9aN92mwaiSODznZ/0clYn6a4DFt2I1HDs0h
   cIrC39zOQVIb88yKpLcJF28uKQC5aY7kob+vPgvnAVKcfChJsGIu7sY6M
   XbhEaPYSMEtQsXzFIOtpAA3ndOlbt+t3XwQjdhzJk6Bu19XIYsOYnov+S
   ITK+RX99ExwJfQopka7uQGj8ADqzuBxEcDxk9dZMRYxKZ7cYZVlbQ90zp
   9Bas5XWsdvwEvgxuy3gRJGJ/PvE2vVztHQfGN3u3gP9cRtR3dkftDTqWX
   Yiq0APs1hpUXWBQlcdASH0SEw5p9F+de9DtgCK7n+BQrqiEO6BSLiIlZ9
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,448,1549900800"; 
   d="scan'208";a="213877508"
Received: from mail-dm3nam05lp2054.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.54])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2019 13:52:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMNvkAoav8Zb5of2o3uF1vWSYNII9Tj9rv+2Ndb5r0k=;
 b=TSqTBu4uaw5xr4mzPkh+o7CtPNl68DoS1hEL9YB5RqyPeAW2UAx2oQGvoYNwdDz/cww+IxwM+RcJdroPjMkApxuL47Ov/EFbaIcDrHmXg9XRIykbJZmPla3C9gwIWSH65kBsYu3eZF2QyMGp334BrtyRfHdxVs9ul2XiUVolOgQ=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3839.namprd04.prod.outlook.com (52.135.81.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Thu, 9 May 2019 05:52:51 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 05:52:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
CC:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Topic: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Index: AQHVA1Q6zH4CttIufkWRxlafayMhPw==
Date:   Thu, 9 May 2019 05:52:50 +0000
Message-ID: <SN6PR04MB45275DE10FC6434B85227BB686330@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com> <20190507062034.GA3748@x250>
 <e118dbb7-51a5-d013-8c85-391452846411@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:eee9:536e:c194:4e76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d38b7371-2723-40a9-bedf-08d6d442927e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3839;
x-ms-traffictypediagnostic: SN6PR04MB3839:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3839DBDB121FC1D20FB10FE286330@SN6PR04MB3839.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(46003)(478600001)(53936002)(5660300002)(72206003)(55016002)(9686003)(6436002)(68736007)(71200400001)(71190400001)(256004)(14444005)(4326008)(14454004)(229853002)(6246003)(25786009)(53546011)(6506007)(6116002)(91956017)(52536014)(73956011)(66476007)(66556008)(64756008)(66446008)(186003)(102836004)(486006)(76116006)(446003)(476003)(54906003)(110136005)(7736002)(316002)(99286004)(7696005)(305945005)(2906002)(4744005)(66946007)(74316002)(81156014)(8676002)(81166006)(8936002)(86362001)(33656002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3839;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cf652UPAMMPBZv0au09vKNnrvz7NDMx5d2l1pvoNgbdzFp+D547itAPTOkSGaoc+wLfXwZbubOfFOeSlwEl9K9JDH30Hy+4Wgg6Dsnv7lV6Su+GRpr3EY1ndvfcAL5BXvdzakfI1YtoMZMemg/IDz32IxFv9SeEE0ijXzdoTkKdUQzm7mTOLy0px+gguR89Al3jMkFNG+gXHQrd1POHK1PwPg6auqFwKeCk3m+t0TyAlcqDesW2ifUvuO1VKPqY7A7A3W5fIuyaAls7VCSjxGr537Sf672+aA3F7Y5egwTMnOivbxya5P3AVfEagi0IVBJ48Kn2iHQksa8D3bChc2TUQHmhsv4WcKFbrnSGPu92kOSxnTHzu2LMxZKYCvviPsJhofoV1T1iCAwTl2/F0XLScTxQa3aAoKEUCFh8SIiI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38b7371-2723-40a9-bedf-08d6d442927e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 05:52:50.9413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3839
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/19 3:23 AM, Minwoo Im wrote:=0A=
> On 5/7/19 3:20 PM, Johannes Thumshirn wrote:=0A=
>> On Tue, May 07, 2019 at 01:54:09AM +0900, Minwoo Im wrote:=0A=
>>> If Johannes who wrote these tests agrees to not check output result fro=
m=0A=
>>> nvme-cli, I'll get rid of them.=0A=
>>=0A=
>> Yes agreed. In the beginning I though of validating the nvme-cli output =
but=0A=
>> this would grow more and more filters, which makes it impractical.=0A=
>>=0A=
> =0A=
> Cool, then I think I can update the pass condition of this testcase in=0A=
> other way.  Once Chaitanya gives his comment on this, I'll prepare it.=0A=
> =0A=
I think responded to this one.=0A=
> Thanks,=0A=
> =0A=
=0A=
