Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E36C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 09:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02086214D8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 09:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NIYnto7s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OVH2xSLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFZJPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:15:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65134 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFZJPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 05:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593162916; x=1624698916;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MSesirUQ6urRk5pEvK4vW36s6lDxR28nW4Pbw4yIIbo=;
  b=NIYnto7srf/RtQvgccNDNOWjsJq7D8Xf3u+h8uDgrlE3fdHM+mb1t9zF
   cTQxCUCN9IwJeHNYeU5X7FwDcFtKnCb2nN4w/BU+7WZ0C096zd8+B/DGe
   s+LfABq9TCcUw2AUHw+GhH+85jfd2su2LggVKjnpj1AgXXibXC0XLDdAo
   oldaspkYpE0rcDSStJiYZtorF/zYcfoMMYhRIAiFBhejtNtNDQKuSJXoX
   dOCIkfx+rST4krbxRXKzZZF9ZgJkz/4ZiuXInWe5UWPl7RiicTOkrpfdK
   HQZoChJaXMYVQY1SsbfLEfV5qDzosoJPPmwGLOcRo8inT+uUqdyZMuEqj
   w==;
IronPort-SDR: cq+eqDv7Q62CmzVqcvj3ip2uNcQYe0UOnCxkBFNwKPkSNMA3d80nNxmPI23lLqZ3np2RsjNJ/g
 EneyhMVpJbS2ZSWHpchf9cDqP76M3Y9WpDYmDtGf89Ip26d8IJuVmSFJfPd9L1A4zNzo23oy0y
 5FIDRrtFsBvtq+au/RA1ZsdgRS2sBGeA/A11CSeoIUljJKAoho+sxi0O5iB4T+tAf3rvcs+U6p
 DdGesOZLVcIuH8TcjTY4sugV15jGRrKKogFbucatAX2f98kluYHmZ/FNbDZ8pHODTd+A/nj6ok
 bso=
X-IronPort-AV: E=Sophos;i="5.75,283,1589212800"; 
   d="scan'208";a="250213706"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 17:15:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNOCxlNAXGSdPw8dOMdD/ZqGV+x559sD3BYwquOmSmJ5idFxEcSYxwRo05CW0aUHC0YPeds2pWXTW7A7hYXQB8izMOayDV39WO17MSAQGFaq39wBGBfjPS5XUHiqqdDxoKqLLP5FlJeP84KXBp5k3q3AtV4z0SzlJSa6Doc+znTNxLOUOXeJUaM3XOF34gZ3UeCpsXRZUzCc5uXNy/XFMeeSZBvO5ix/WbXXUhvsF0HbUQWVF7sLTS6B5DVGeOUpw9nf2zWGnZo8XkUfna6msBLgBdpNK4oxbwc84eU8jWnuZrZ3JeoEBglScJ/tlHA4YlL9cLas0cn31KqMMhOxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ZGOpdmGykzK6Fz1NrJwuYDbgcCPK4mpSU83RhsJDo=;
 b=m5/z+eYs4/MFkI7gLDmNiwp1GxPXYaj4xq9rnOjyhTeqf4l1yM4g1enDGbzQyzCLMDsdiHsha4asHDLJL0+g8QQDrGLuo5/Y50nlclEfdrOhS1FAPMJb84nMrzBwxzGXRa1KoinULgbdeAx+yC2+fVC2DE91WIf59TachQiqdCh2Bflf1cpKz4Biqg656LYmsMZKTtfYMnNtEhq5N6ffjUxztDv8RJXLVIT5BUw9iV3h/f4KdBQ0Ihyk8Gdytzh8P5WKb8uj04mWE9jmGsPc/pYqlxLWpE+oVMMasWZTdRfCHxVn+w8pDXx0NQHGh1YpiV8aH7SNfFbR+S4UPl71Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ZGOpdmGykzK6Fz1NrJwuYDbgcCPK4mpSU83RhsJDo=;
 b=OVH2xSLm7ZpzEdwDLQbdBFm5rFxXs2kbeYTFhBMBtfVlY+QABJ5kjhpg892KxMed93BBY0WLjGqEkS6varz6A9AaF7kc2k7ImaknYHGgWbH3QownlBtLYkiPRO1hZ1YW3eQNxyWgQvetTCnD3k17MJujLb/77RRX8nSdkYTkGjo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0248.namprd04.prod.outlook.com (2603:10b6:903:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 09:15:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 09:15:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Thread-Topic: [PATCH 3/6] block: add support for zone offline transition
Thread-Index: AQHWSutT3xCQHGem9k+D54mKrpOEQg==
Date:   Fri, 26 Jun 2020 09:15:14 +0000
Message-ID: <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
 <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091113.GB26616@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c08c900c-c7d1-4797-7cfd-08d819b16fac
x-ms-traffictypediagnostic: CY4PR04MB0248:
x-microsoft-antispam-prvs: <CY4PR04MB0248BB10000F5139D1566BA2E7930@CY4PR04MB0248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3AhdWEqV7TQR3KXMMOZjdy4bipZaehPAA3XjPZiO4uCEnZjoEpKp8Yf94Ag957Pf37anCvR0p1uVEJEYsG+SOer8mvpV7qlnZeAJRuHLNhwflwlvSIivYjckI96CZHRpiEm+7u1esejzQW2JnBI4yZr8U1JOK4r0JC6bS0kfN3B9VcG8ZH5fBt8U2xcYwriHuMJiZYOE02vO7d2DMZstnoWqhpbzAUJtRSuFHevNsWSqfLJt0yHXEtejNIdJbGbKnNAroUJozdW0Q9UPfVzcABC1/Lv+VgMB04eO8DPFQoxgVFf3CH43zW9ESiQCV0H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(71200400001)(66476007)(52536014)(91956017)(186003)(2906002)(4326008)(33656002)(83380400001)(6916009)(86362001)(76116006)(55016002)(66946007)(54906003)(316002)(66556008)(8676002)(478600001)(9686003)(7696005)(64756008)(5660300002)(66446008)(7416002)(6506007)(8936002)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aoRpjNHiYEfyptG/I7lgyojohUyyLrdHDNSZSu5gMxX9ttE9OwC7M9R0nyo7EYUfjUAhfmK2Dz9PeTzRr6gFuUzq87LjUSPrNP7rWYtJHbcjZSaSz5kPFqWyalvXI1G3/mcZUx7v+melOuq2qaBPd73WwG50rxOzpgzaJRMOrQes4SFL2nmp6E6KuH6K8CDALbVFaWD6pAoAWIL5f9pvZGHpzsnKgRwNMdOc62K0qpiyc5qnA5YE+iYEIgBg8wDN/R8+Z5AuvIMrQL64cI8JI03ouf04xisitm7YrmkHxAkMmO+LU/nDNEQxnWAx6ZV/eq4TQNU/Z6BLEBKWqsiinCKkvSlgUHqxXRFur6BHmGYBpg6oon/zBHL6CHuLphyTwzyxst+5Fh7OHLjmt3GwpAogrN/WA5A0fm6kG6hKxJOcMvwtX3E5e2cr90dpOk7G/tKqpQD7hJFSA4SCvtazS4JsaKZ/aMXg1xZ+e6Bpj6UKLYBam6yKSKl7M5WG3xCr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c900c-c7d1-4797-7cfd-08d819b16fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 09:15:14.5646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SejZewhKfGM0uKgGc+jCNZu3i81hoUQ6PFC3qChfOPpyCebIhCYy3mqfIU8GU8jFB1mugGUzpWsn/jgeD9KooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0248
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 18:11, hch@lst.de wrote:=0A=
> On Fri, Jun 26, 2020 at 01:14:30AM +0000, Damien Le Moal wrote:=0A=
>> As long as you keep ZNS namespace report itself as being "host-managed" =
like=0A=
>> ZBC/ZAC disks, we need the consistency and common interface. If you brea=
k that,=0A=
>> the meaning of the zoned model queue attribute disappears and an applica=
tion or=0A=
>> in-kernel user cannot rely on this model anymore to know how the drive w=
ill behave.=0A=
> =0A=
> We just need a way to expose to applications that new feature are=0A=
> supported.  Just like we did with zone capacity support.  That is why=0A=
> we added the feature flags to uapi zone structure.=0A=
> =0A=
>> Think of a file system, or any other in-kernel user. If they have to cha=
nge=0A=
>> their code based on the device type (NVMe vs SCSI), then the zoned block=
 device=0A=
>> interface is broken. Right now, that is not the case, everything works e=
qually=0A=
>> well on ZNS and SCSI, modulo the need by a user for conventional zones t=
hat ZNS=0A=
>> do not define. But that is still consistent with the host-managed model =
since=0A=
>> conventional zones are optional.=0A=
> =0A=
> That is why we have the feature flag.  That user should not know the=0A=
> underlying transport or spec.  But it can reliably discover "this thing=
=0A=
> support zone capacity" or "this thing supports offline zones" or even=0A=
> nasty thing like "this zone can time out when open" which are much=0A=
> harder to deal with.=0A=
> =0A=
>> For this particular patch, there is currently no in-kernel user, and it =
is not=0A=
>> clear how this will be useful to applications. At least please clarify t=
his. And=0A=
> =0A=
> The main user is the ioctl.  And if you think about how offline zones are=
=0A=
> (suppose to) be used driving this from management tools in userspace=0A=
> actually totally make sense.  Unlike for example open/close all which=0A=
> just don't make sense as primitives to start with.=0A=
=0A=
OK. Adding a new BLKZONEOFFLINE ioctl is easy though and fits into the curr=
ent=0A=
zone management plumbing well, I think. So the patch can be significantly=
=0A=
simplified (no need for the new zone management op function with flags).=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
