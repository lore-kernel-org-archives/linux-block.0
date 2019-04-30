Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D79C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD74721743
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 21:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VgSICh9Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BqxHLiGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfD3VjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:39:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61447 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfD3VjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 17:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556660348; x=1588196348;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SN9xhVslqZTCkBvVqs95t6dxMFebOJn6q4t7dxAcN4k=;
  b=VgSICh9Y2do5Lr8JAXIu4QSC41e3+Bm/FVYDyMmihhJ/3dx2Lmbdx2fy
   FoBS7Rcic3GFFTVQ/jLlUPpI8msUQ5JX7kUDAhv/9i9nCEODpVTgpQ7SC
   sAUknvgN8UPHuRNTE2f/0ITyRgx5Zov+RdpJF9UiTqTYBwK5nhapdTQp/
   KSips+P7noSlg27ctSrt3yG7bvXLCmkVYVVMNkx+XXVUSGbY/ZesasOvP
   8NNOW5eCKww4mKC/GfeVnRPnkHZBZrkCwdm7jTuXjdS6Hp6fRKxzJGpzc
   pAqprpAwSG/PcRPB1LfbemjOWPrcD4tynnjUzDMvQaHgXYq9Kw/srFFvZ
   w==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; 
   d="scan'208";a="108420254"
Received: from mail-bn3nam01lp2057.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.57])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 05:39:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn75yoPerFL4hD5ANjmluZyFW/s/84nZwQm4BKDqcKs=;
 b=BqxHLiGWCVFodl+NJRa73CIVkw33/OcPYBFMWyNEyHFTfKquv5/YKi9cuaWvKeJ5QkUiVTXd+7n8fDxnwprtiinQTW3KJVrmuWoIYPtkaovDNasNU9uXh7H96EEF+RPmoJIIuWyw/bFBoRdvBSsUssvZ5IT0ZLAkAZHyd2+9T24=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4272.namprd04.prod.outlook.com (52.135.72.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.16; Tue, 30 Apr 2019 21:39:04 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.015; Tue, 30 Apr 2019
 21:39:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: add a SPDX tag to blk-mq-rdma.h
Thread-Topic: [PATCH 4/5] block: add a SPDX tag to blk-mq-rdma.h
Thread-Index: AQHU/4SuPRvnLG+sjUiPf6xqvg8bKQ==
Date:   Tue, 30 Apr 2019 21:39:04 +0000
Message-ID: <SN6PR04MB4527EC337FF9B0B57371336D863A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190430184243.23436-1-hch@lst.de>
 <20190430184243.23436-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cff0c1c-cfb8-452d-9871-08d6cdb4448b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4272;
x-ms-traffictypediagnostic: SN6PR04MB4272:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4272DE92915A3E6E725FDC82863A0@SN6PR04MB4272.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(54906003)(99286004)(26005)(4744005)(74316002)(25786009)(7736002)(6436002)(76176011)(68736007)(66066001)(53936002)(6116002)(33656002)(3846002)(52536014)(6246003)(4326008)(486006)(186003)(2906002)(305945005)(66446008)(55016002)(110136005)(446003)(66946007)(91956017)(76116006)(71190400001)(66476007)(14444005)(7696005)(64756008)(476003)(81166006)(81156014)(86362001)(72206003)(256004)(8676002)(102836004)(478600001)(14454004)(229853002)(53546011)(73956011)(316002)(6506007)(66556008)(7416002)(9686003)(8936002)(71200400001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4272;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ct7kCn0A46Ft5vdd2Gq+QcewZIP88Ch0CWIlztQ6jdtbIr5nz8EiRgaUhUg2gAUaVbwqVr2RTTmjtwZmcmhwERy5fw2WtdKElfK4OZm4RVck86h4I5Q0vuJD4HylMLVO6ZBwfNmGbb8FfDkulnMAa3wv+F3lNI9r7Un2iR1l52tNhOFd0BgS5vei+hv0Qs5ix4kc4TAxruXPwGzDUdyJgwpMxbCiYAM8Qsc4OB0Na+T3QkwVL00XeC0fcPrkpCcLnpSHU8G3TJgPtkeEe9LG68N2NoXQaICUACmgqn3C3ixAcZEObljuhOIcw4OsQ7rX15XznAThHpMzxE82BGnvkrwoTOmjbdWT9gtVKLQkDcsaAxyInaHDTK/4v2o2fzxQ3nENKsr5mi9WZmhJWDMpbuRw2t8q25MpZy++KMk5Wf0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cff0c1c-cfb8-452d-9871-08d6cdb4448b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:39:04.5038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4272
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/30/19 11:44 AM, Christoph Hellwig wrote:=0A=
> This file has no copyright notice, but was added as part of a commit=0A=
> adding another file using the default kernel GPLv2 license.  Add=0A=
> a matching SPDX tag.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   include/linux/blk-mq-rdma.h | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h=0A=
> index 7b6ecf9ac4c3..5cc5f0f36218 100644=0A=
> --- a/include/linux/blk-mq-rdma.h=0A=
> +++ b/include/linux/blk-mq-rdma.h=0A=
> @@ -1,3 +1,4 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>   #ifndef _LINUX_BLK_MQ_RDMA_H=0A=
>   #define _LINUX_BLK_MQ_RDMA_H=0A=
>   =0A=
> =0A=
=0A=
