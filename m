Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650CCC0650E
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 02:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADEF2053B
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 02:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SCh/dpnl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ee4LqQup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfGHCCK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:02:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58453 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfGHCCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Jul 2019 22:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562551330; x=1594087330;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dywAFDrj0MfAgVkHqaTVZ9P6BjevwEczcnCxLBSf4Sg=;
  b=SCh/dpnl7SFmcielTato6fuyWH0XXHRNt5Som/CKI4XUsQf/f8cSvFlp
   rpBWofH9JH938WQK0k6HLQncFI1jp1+fzA4Ie60bBgxl0/kzfi9KmL4Tt
   xCWvIXLAugWkI27QJrx0rVCEG9MRGDZvgtjXoaYYXVllXdOat+IptOoa/
   gIEYd9usoZk6oui1ckuzIsAc8qFBJnabTGP6+C1Qw/wCq/XZw4dzeRY3a
   Th0wOskiNpSdOiZSjposMsB9KJIP6T2GP1DNDwFYjIjzpiD5ZYXhgjw3n
   6rnNkgMR3hPUmIMfmnTH3Ai6d39rqR4GqWiP+QajfreawuW0/69BgaGVq
   w==;
IronPort-SDR: Nuwvt1vSYB9AK/4EaB3/mkm2iSck6iVQOHpsJiylSYGGHgRdPHP5Fxa0U2uM6JwiHfYX2RqS4d
 nnDW/tm6lxfDOo2cXQaD0epQwVdqoVhAQGnRuwzENrRquLXqYwb8EgVfUwN4ciwFg/QEPbaxag
 NRs43ByCufgghDlalQK7TTqVT2iDll2WEVAgLPRmB116un+dbVqzZpsp15wohvyKL5fmipJU7h
 /p61xz+iaZbEHBPQWWD0qE2m/mSYH0I+5M20M69aXQK/xU0ZPK2zhSF1edxTIOhDBb7csuTkO8
 LXA=
X-IronPort-AV: E=Sophos;i="5.63,464,1557158400"; 
   d="scan'208";a="113580885"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2019 10:02:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dywAFDrj0MfAgVkHqaTVZ9P6BjevwEczcnCxLBSf4Sg=;
 b=ee4LqQuprJ1WGiHqfCiM/XbQeJ6M9xrEiDBXoHTs4BtNAjQlyNRDtFSkJ3tARCZBC79kIsJL2gq/TUQ1kkiYfTUB3IkzSnKFJxaORzudzWA84Ps+PYeCRJ85e3ATbtOrzqT/Yz7FnqxkdxmZkV7nydEZGIyO8MJe1DUC99u4lEg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.59.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 02:02:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 02:02:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
Thread-Topic: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
Thread-Index: AQHVL8ssJYyertgVkky0I6r2FZ0yYw==
Date:   Mon, 8 Jul 2019 02:02:06 +0000
Message-ID: <BYAPR04MB5816BC7EC358F5785AEE1EA9E7F60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0f2b04-9a7e-408b-18e0-08d7034847a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5864;
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-microsoft-antispam-prvs: <BYAPR04MB58643D8DB32AAB7739ED6344E7F60@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(2501003)(486006)(26005)(6436002)(54906003)(53546011)(9686003)(316002)(53936002)(7416002)(476003)(446003)(55016002)(102836004)(76176011)(186003)(86362001)(6506007)(110136005)(7696005)(229853002)(8936002)(14444005)(2906002)(33656002)(81166006)(72206003)(99286004)(3846002)(81156014)(256004)(8676002)(478600001)(6246003)(66066001)(4744005)(71200400001)(7736002)(25786009)(71190400001)(4326008)(73956011)(66946007)(76116006)(91956017)(52536014)(68736007)(74316002)(6116002)(14454004)(5660300002)(66556008)(66446008)(305945005)(64756008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5864;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XSdjz4wqQe6MIde04G1uCKnIysFNjimO+WZUG9lZ03I1rJ/w0p2lygjCoM4s73jCaKXmbNBRsIAgDRUcBx7NqvSreO5D3xjEqm/UnyAVj7qhv1fnyDKkYLU1egwO+WWy/8TrPuK2VaptGKvc7dWdbQB7S5UBKYfA1bkySRe5TFTvVH3b7fqvkSs4l2YEITS7DbKdyMHa9AIBq9Ot+TnTLAIl+7uz8DArxvTnuF7vDuoCFHbpak5YRBh0HvCtFz5rHoi3OzsqUZhoGO+MQh3dlAZWvKVTuG70PZgE3kKCGfhIvVgsmf0OwFQjMwjDgEUiARuU+kpeJdcf/XT8cVcTcUfXsaaiLymGoJzcP2W2r00IWSKuuECUc5ebXtVuwkoMISfQE6QbxYSTY6izR5fOfVMLy6ooHwCH4IND8JJdm64=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f2b04-9a7e-408b-18e0-08d7034847a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 02:02:06.8556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/01 14:09, Damien Le Moal wrote:=0A=
> This series addresses a recuring problem with zone revalidation=0A=
> failures observed during extensive testing with memory constrained=0A=
> system and device hot-plugging.=0A=
=0A=
Jens, Martin,=0A=
=0A=
Any comment regarding this series ?=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
