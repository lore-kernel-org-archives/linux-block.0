Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714AFC2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BFC20771
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L2v6o5jm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="J0dAIQg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDILbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:31:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30303 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 07:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586431874; x=1617967874;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
  b=L2v6o5jmpk4pQlF0Kenp89SKwHftHa1HaKnphL54XqnAR+jXdp1ZjqWV
   R/KJEXeEindu1zs64t7xh7MLaTdkNG2mXQchtwHmzp9n+bVLXFaNr37Z9
   my+zWnlBuaEmups/xEQEL4QoXtor7uP5d5m1TckgeRQzIXkH2x4yiHhll
   zmVg0nPaV+Jh8uMUdl51scUz52Ocodfw/wvewUFEhXMmIXV+mrauypxa+
   SfZbDiiUWVIM4+JqYVqme5Ha4MWqLzddkcAQQcwIB/VQ2s0adZxWa4Syx
   OqYyRuGaHvoupRdDhMZggnYpcphyRZtr6OZo1TTPje8uG8FNGeTfbRc2b
   w==;
IronPort-SDR: cvoXibe8gkMmUmUhpkqKZzpIKS3QYkvYTWbPPYr3Qr+ZULYw5tKezxU/FIx4dYT/g1BgTIDx25
 56CqmgW0gCKcjtWTEB1WI7W0wKRpkQivCICbMldXMHblcD8T+T2A6Hwr4l9LuR54nPAhwWJU4E
 t2FDHxkuaSaMMh3/tBKJ1qU6C7zImQIxrkR5Pp07N1IyA64eudn4aZeegoEb5dO4iX4Hq6xXhX
 ywugZXRW3LwxExsyvpyWMKzGuKxEjsFSFTYgYHiW9qRoWs1rjzxAilq9SxqtmyKlJct/c8RbZp
 000=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="243523233"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 19:31:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmTeQwy31A3crtm+GGG0hJjuplUTx3dAWjgHTs4c/M3YyUmq+W5B0xeKaQZDWq3mtTho133N8tfxiyXLaNAu//RiM90NHW3004lHC3RErxMHh7bNGVm004Jhnk7WU/QmRXRXd+wildC1AbTCfflNPCq0tZ33IVYKxknWxkgo2wBJ/2KcsfloklBpbZCOyDGEQGkTka9JdnX1W8/uy17WbqU3XMUdlDDpF8nqKFCUxUxG1KOn/9cQqLx5Fe2QJVaA3xwe6oRLusHTR3+Xdx9SLQtOJVnQNmeKDWixjvJC81zzQwU+vADfg1kc3oQ6CFTXVLc78uxwNjDarnXiiARPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=Ou9nbg1QGFYaCGMVFya8t5VWdmtmMjJ8jDPVZ3RGWMVFQNat6qutQX/cdmHpujAHRdSTCIN5H6jAidtUd+OrV7Y693prk3F690whvZmAg3yYTLdB4lBeJYInLIWcinUU3Mf7B3AnBBvjELQ3ZV94Zb5Z+6Lk3SpnYadWfq/G/uHqnFxmDCB857Bq4qqnOWsWznbkRE9Kn7wZ7zv4e+FfEWjpD9JK5yEO4pcdG2kGzkptLi/BfeYAKaT+fIVY9+Ifk6wflSnsv/qMnmSs6yUVtmzcTGQ5Yb1McFSWZpJHV0+xRPSdGj/75PYPeXsuSGNLpx1GRqAsLkhw7WZ5g61X6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=J0dAIQg4SBf+TuzQv7BiqaATw9kVR7AED6LWMBhCUECQpqrpvxJx5q/CaHmlPxyorerDXMoj5qbgaZGwmABt4r7K4KS8nPnkYA9ziKKeTzdfwt5PQENGZyZpSTTSwPqCVYoNKZ6tfcaekMeog0twfL7h9ViGVftcoDvQhOXmX9Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 11:31:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 11:31:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 04/10] block: remove hd_struct_kill
Thread-Topic: [PATCH 04/10] block: remove hd_struct_kill
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 11:31:13 +0000
Message-ID: <SN4PR0401MB3598EB361640A0AF45411C8C9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 711488bc-4350-406b-10e8-08d7dc798279
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB36780276190D5C03512D4B0A9BC10@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(26005)(2906002)(8676002)(66476007)(52536014)(66946007)(91956017)(5660300002)(316002)(81156014)(64756008)(6506007)(66556008)(7696005)(19618925003)(66446008)(54906003)(76116006)(8936002)(478600001)(558084003)(55016002)(9686003)(110136005)(4270600006)(71200400001)(186003)(81166007)(4326008)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9PsPNrpl9sMc8zGkUY0+FbVIvk4Rb/vpBW8hcXXudUKpzRbHBhRaf2JVPfD2Ey/S0oKZZC0eEsSid106FwsoGWHomDjce+7tWorvP/czj0KUqB7ZD7Ju2YOFW4HjtSOTLRNUN6Tso7fmDPUYjAm6D8ZncmNbtnwIZIfVN39kCkflX1KNFi05YNYzHdTs0ms19ByPD9NYQmHLC7tppjPsks+4Ej/CtQWjyeSFzKUluFM/6JWoYZfmomjYqTzhlAt55Lc+xGVku4IZbBC2ESABjK+Ponph7D8R5kBdkbhDStq0MrObQtPEyh6NfcWWALWMkUm7UugExI9fCx1W4+ew/iUhIt3UwsYAsWXWSyEV89QK9IBALoJH3jTykGxQYHnYDe/Indj0f4J5wYqLtI24gm23G6MybxLx0b0fAwMmgKC6dxa+OkD5WcZ/Scu/Pdd
x-ms-exchange-antispam-messagedata: PEcm3YConckGMYbQkwRY/E6IgAJieWrsoQqeNWhEXxJcDvzv2Jm+5DO9t3TGsj++O2EeddPNPs46L0pN78LaDzM+reml2EQtPvOi9P5UYc9BF2HOxbg1yxt831hc59vW4BEr+jdF60EY/mhj3M/Giw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711488bc-4350-406b-10e8-08d7dc798279
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 11:31:13.3290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkEAdPfEhmDZgnAwr2w7XdKyqi5VaQuMHy8r7lEwDdTYjxfNSYtFdDcfTkWEqf5WvMS65BLHKtrP2p5PTtSHGr43IDHgRs/LRAWK2FMyGTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Easy enough,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
