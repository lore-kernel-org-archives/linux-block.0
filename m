Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA4DCA9EC7
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 00:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756182084D
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 00:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DHJSXiiv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v+kzyV5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfKCAZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Nov 2019 20:25:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42414 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKCAZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Nov 2019 20:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572740755; x=1604276755;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DOB0uNZvmD55eCfeEyuTDLShHo2MaRCALu9IbEIjKQ8=;
  b=DHJSXiivg8TE+/2sYvbzixvdtpuuFjzaU+VS3cr8ahfE7fZx15qqpYwC
   SL9C210c+nwE9OkyxSoYtliGhl9VLwmZmA0PI3Mkvfw3/yMEpTcqdwxwP
   9KhLm1OgZgEBF9p0RsXu2XO3+h65/m8Atct1m4yEVoRJBWqmIlGGXwTbh
   1ayZH25nxV6mc1/I1nJoecaz7lQn+dExDqgoqpy8rYBsVVY9hlcIPWHml
   sRuiT7u6K0VHc+RDG0eU7t4u+H49FctlC17IzmbrY6/88pQarHPEJIN9w
   GYl4ggEDdIIgoJmalfKOMoHau865GnUMY8SVONH38nFxjLOUIy/Rosf3C
   Q==;
IronPort-SDR: M+Rue7Gb3uNVAAcMk6w/zbeVJVr9d9DbMEAhYEFbHmTkNeN2PhhA16yitaynVmCBThWxiYYeGi
 1ke0YjMrqnLwd4+n5H9DHXQJTeO4loLwb9kJjMYHtmU1fmxhyMtgth7cTD2SUGhQ1d8tbJ5vG+
 ZoTbShGR1fUxet8inwNvV31vreu7oYim8Zeun9P2jcGqWtYgD7ur4LpcvufhclZfmOGRzvxKLH
 KpFCtiNNkA4+KNvJRuvP0KXePZ+REqrCWYaS/LBcPYsiWaCE5XMfzVHy/NozYNXpJEzFoxi56p
 dcE=
X-IronPort-AV: E=Sophos;i="5.68,261,1569254400"; 
   d="scan'208";a="121989740"
Received: from mail-co1nam05lp2055.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.55])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2019 08:25:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRY+IuNi7qD6xq82OJoLbJbjzcCGEiULZK/z/kFZLvY7tQl1E96mNFiOVJwzsUERWSm2XhielRQs6qT09dT3igFXiXTDoL40yzBca5bnUB+27AmuqKteHq6hG9OxuRG0YViFDB7Q7kAxqEqa1lbl8p+xBzIHNeVOFk2ME5t2p7oLeshy+CMp6VioPtzQF5uM9T281Ch+qKke4I/ALp0hx+cCEzYmJsityab4xALGsVBq4hHi3UdWB/9tlGp+qb1in39Wtes3jkPF2NvN8A2KuyauHIpDVzww+euEenf4sgg8vEFPutldUqgsvTXCVzyQqu88IlvJowNcCkQNeqT+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOB0uNZvmD55eCfeEyuTDLShHo2MaRCALu9IbEIjKQ8=;
 b=UIrbl2y2M54EzFK4o62kE74pvp7KAgGi+X19aIFCKuFaDLjNKc3ubtjqBnmFn7WXCUE+Vp9coyw7tiF/MjHp6mkJHW/4h78oq+hG5fiokVGDL3OL6TpR7lJqaO7HYhz7ayFEmZTY0wkjtPUE+kipl/n6xsB1N/tebMr58fi0dP2a6JcJPxQj70e1k0X/OlGzzTyT8ITVMRzkTRg58PiHqFN7w8fTvHyY/a9l+ff8bwEKcURxQ0cULAvidFJMF17JrVmi337BsePdYvOo2mw1goZMfMSvGX8Fx7ax0qvc+pCvLf7+j7z8ExGXMEy+9r1Yg9JDNnYGKAJNAv0o5fB3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOB0uNZvmD55eCfeEyuTDLShHo2MaRCALu9IbEIjKQ8=;
 b=v+kzyV5xm+d/CasRqPcWmLw+0WoX/DN//C4QrNDyf0K1O85bUtK1s20XtcmVk4OwYTNihEAslhjtUTUyCxdgdJ4Wp4BOKh9pWB+NRi256HvORs+pMszmIVU4l+qhQJbZuvvgMBiAZfvA4EFdYyx/2Piv+DP8dyqr0qAzsoWr774=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB6133.namprd04.prod.outlook.com (20.178.232.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 00:25:44 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 00:25:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Thread-Topic: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU
 cores
Thread-Index: AQHVkVPqDb9QIWc6hE6kE3ixbLET/w==
Date:   Sun, 3 Nov 2019 00:25:44 +0000
Message-ID: <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191102080215.20223-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fa78424-8b77-44b4-f4f2-08d75ff45db4
x-ms-traffictypediagnostic: BYAPR04MB6133:
x-microsoft-antispam-prvs: <BYAPR04MB61331EC55FC3EFE18BACB028867C0@BYAPR04MB6133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(3846002)(2906002)(6116002)(476003)(66446008)(66476007)(26005)(52536014)(7696005)(74316002)(305945005)(7736002)(33656002)(76176011)(8676002)(256004)(8936002)(102836004)(6506007)(86362001)(5660300002)(186003)(71200400001)(478600001)(71190400001)(6436002)(81166006)(6246003)(66556008)(64756008)(66066001)(55016002)(9686003)(229853002)(99286004)(4326008)(446003)(76116006)(486006)(4744005)(81156014)(25786009)(14454004)(66946007)(110136005)(53546011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6133;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiOX4M9199KlJAuCRuihg4JKE01ETBAVYy/LSjNn/Uw6++4SzxwGrlJJywkxqvnb54x2Cc+BJ8CDpLs6WXlEQOAd+ZDeLJutSRYc5QkQT/73CSXR96WWJXd9C9l513TUitXdKZNgzWNmhfK/v2oFCZkcTH1K0jPysP8M/UFjYF3c5NUmjayfvEXqJtLZX9+wqjd6RRX53BI480cpW9nINk8oClb3u3hpLCSWcyJu+sSndx2LHKiudFsbVW3pt5+qM8sXS4bWAm9jRofJWg+L91T/uatIKiR7AWO8MJa6u0COT889vKWUHTb51xrTaSmLYx/nmcKOGSq38Rnb77sHodsnncg34mIY8FqstPHl1loWSuOo2hWYPc4Gh2zjk25YiiY77YjrLBcQymIzzPEYI/nW0PbJZ4Nq6Lo2Fx7ykAzEDZUpXgwSe4I1r+9qXV6y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa78424-8b77-44b4-f4f2-08d75ff45db4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 00:25:44.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qs+bg9bjRi5xNmhmt40jSWUtWOhjY1avXuOVxMXmdtyC0h9E1lZDb9jBltuE3GwhdFs/eVBnX2dGWQHqwC3i0jdwMmGJF4XmBFGjJpDA1m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6133
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming,=0A=
=0A=
On 11/02/2019 01:02 AM, Ming Lei wrote:=0A=
> It is reported that sysfs buffer overflow can be triggered in case=0A=
> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of=0A=
> hctx via/sys/block/$DEV/mq/$N/cpu_list.=0A=
>=0A=
> So use snprintf for avoiding the potential buffer overflow.=0A=
>=0A=
> This version doesn't change the attribute format, and simply stop=0A=
> to show CPU number if the buffer is to be overflow.=0A=
=0A=
Does it make sense to also add a print or WARN_ON in case of overflow ?=0A=
