Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E5C3276E
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 22:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1FE21835
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 22:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MUHMOoiV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="esDXn28s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgABWVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:21:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7828 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgABWVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 17:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578003695; x=1609539695;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6q3ThP82AciiuxrMhJc2aJNx6FrGfWPwXaCZHuy4gyY=;
  b=MUHMOoiVCeKPg5DGiAAdciDJ4GoWRfm6BapnKPpCTpq9lht6gYDqDhMh
   700Q4M8mnyEoIu7RbOoeJk7+Uk5XgnFOSOv+Fb4IwT9BWRD7CZqNICcah
   j9pbnz/VnB17E39NIbTbQtALX1qeaKnQnVVNJVWHTzoYgeFUMwNrjlN5C
   nupIQTA2nHFwW5KvCUr7YqYw7q6wNVFCUzrcZe7AURltnXN8/h0QR6fPb
   9Nr/dfwv5XdfzADrhifkoGiCtivGSny/HtUpG+NtAPxcpVRFDY20q2b0D
   9DfEOQiUFgDDDAnAVrTCdVLXfYuXdHmo8oeFXovXsUAOO5Vnx/vtNtnFO
   g==;
IronPort-SDR: VAywryTFBLudoxVlLX+QA1N1A7Qp7gGfVPz2XAiaqHi7fVJe8YNH9HbqlcTQiKuYu3mKnxMbKi
 VEbPQRoiRXWiA2hK+hN3v7MVbxNbRf/kE5Vd/f5qNx8jxJx7qLdS6UWEoMSXxGcuqKe6503ELm
 OObdf7FJuyrlX/Uwl/zM+Pz5KYvUe1QXp2B5Y0QiyqBanzOyOYvO4rAYHBYb5ouUWvGM7kQcfd
 zRbEOKS1MOvFukFpLzUdmxlJZ5DaT4F9V36hXma1fUX7mbxmbup/afJ8mg0DmehJYN3bbvoDTL
 QHw=
X-IronPort-AV: E=Sophos;i="5.69,388,1571673600"; 
   d="scan'208";a="234360199"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2020 06:21:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB6Fr+FK3CNZ0/kBml0UL03jrIoa+SzSn1byqDyECMVSLI5taZRczSjwK/GYl9LKSOv7++u5DJXIkBmwkq2whj1EmNfR1ngmG2CetHFDBeYgJ2yIXjXrME5hR16esimgDGRfJqlDdqGOZuoTUaa+ITBXl1h2JV31RZEPDcqlohRt+tYcREX/qtff3AVIeHi5yOgnUZAqmgITpCGJm5Y1JmOxw1SloV3DJctbCrU5tIHmOK7pe2TwsqygFzPLmagbOGcH9JSVE09B4NvzQXBG+YGwt+FMvyjD3REmdKDb8lgdQsCR66fxA9k62gLUdmLWBAv8wpC/vWtpDCGt6J6lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q3ThP82AciiuxrMhJc2aJNx6FrGfWPwXaCZHuy4gyY=;
 b=VqwCKRkR1c7JW5LPFGQLr92RqDGqqgfNv9kP1Tqn7bFEaYBd2NThlpvN2E37jWBZzJsIjvVJ6NbX9GziCg0bgr9YqlkVM7hrzTNno3qjjhrE2bQ4aM3bNRNjkUbRCC1Q/4utoAg7X5D3tYLn8AG35G0jxusbKSXTdkkWAEd2qy5MIhILL8yCNxDuvr+u6v8GaNBFywBaz6dRb4g0DWmWndFmdO6NKVO952vHrLSvgZXfilxDfMZQOT/YJsA0yLDunp6sYMiSAEnTgy3s4l7teAZCY1MJc6cgGOHymsOSiooQTMlumP3xR3nHW08zULpy/1zqiXm7htQvj7p1oWzXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q3ThP82AciiuxrMhJc2aJNx6FrGfWPwXaCZHuy4gyY=;
 b=esDXn28sHmrQv5c1pHtzL70UBwCWQt6s1wGsuADMeyfY7MhjBafalx2YpP0ks+PcxgkzSC/0/f7/b8RRoXszJfLGO+oOZh/ISt8VsnCls5v15poVV2+CUcBq9K9+CLBtoj01NKd2OED56ZKhXQ56VoYhupl3CNsi3Fu9Z+R/U+o=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6182.namprd04.prod.outlook.com (20.178.232.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 2 Jan 2020 22:21:33 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 22:21:33 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Balbir Singh <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ssomesh@amazon.com" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Topic: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
Thread-Index: AQHVwUG9IR4HOIdwfki8zg3ec4/H0g==
Date:   Thu, 2 Jan 2020 22:21:33 +0000
Message-ID: <BYAPR04MB57496B5D29688B7DA14F53DB86200@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-6-sblbir@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffe38698-04f8-4c60-4061-08d78fd21fd6
x-ms-traffictypediagnostic: BYAPR04MB6182:
x-microsoft-antispam-prvs: <BYAPR04MB618263963C6244E1F74DE39586200@BYAPR04MB6182.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(4744005)(81166006)(81156014)(5660300002)(8676002)(316002)(9686003)(55016002)(26005)(52536014)(110136005)(54906003)(8936002)(53546011)(4326008)(2906002)(186003)(66446008)(478600001)(71200400001)(76116006)(66476007)(33656002)(6506007)(86362001)(66556008)(66946007)(7696005)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6182;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plhAYnd3AJiCqfEJrQDjSWHpgM0AH/qymGO2ROhRKBE028yz1cvHPMwP4suqlbNTvuYWhklwQdn7SeZUl/FU2oYU512Pes6GsC8QPIDeCVTyGIY/v65v0SHkrtaPwD32ztw5fLl0hTebdIPx2wqKUYy4BGqmFtd4qE37w9LCC/HHqOV8HIG+aAt11D4N8c2v4le6RIoRNrMF5lHEgNbg1yDh1kuQcLAbVmU/3kISwkxyefqnOajczzR4QZEjfK20Nk/C5606dFQDt67/fhb7ug4GbA+nzAfyzbVdth9gNVBBLtseak7xImlWwG35VRhl2d6KPXkY9dgBdxgKQ0+kF4578FWwhMmy3JZxTVx01e8vjJSBh5QZghJs5bvSqPpw9DaMy9iW94OV00QImWOQO7Bho8670vPjwEgyOx6qq7ko1AGhtqxgN0UFP5c1/ada
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe38698-04f8-4c60-4061-08d78fd21fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 22:21:33.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeNjZxsri3D4RK3mDeqrIMhhwikxRrD9Qi83oc03Lum6hO0Nb/ktgQE7IHFyndamHM0Cz0FOYMQwP6kFQmvMX47A5I7hJQVZEOKlQv1jrj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6182
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/01/2020 11:53 PM, Balbir Singh wrote:=0A=
> block/genhd provides disk_set_capacity() for sending=0A=
> RESIZE notifications via uevents. This notification is=0A=
> newly added to scsi sd.=0A=
=0A=
nit :-=0A=
=0A=
The above commit messages in this series are looking odd from=0A=
the ones we have in the tree and is it possible to fold it in=0A=
two lines ?=0A=
=0A=
[Can be done at the time of applying series.]=0A=
=0A=
