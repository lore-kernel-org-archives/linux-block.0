Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF0DC43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C616A2145D
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SdsLb3c/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IZHJCwP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgDABb0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:31:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49071 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbgDABbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585704688; x=1617240688;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o/2rG8m8UGPq9DOpb3tN8DcEGlNRwdjI3ttrCNWM2a0=;
  b=SdsLb3c/30nCsvqUcnlvMzP9c4fQpincd/s3eP+ZHvgDUreTi3czT8z7
   PBrvZCRX4ldBmtlQL/Bckhj3t1dSH4UNNLTVDjpEoa8SelM/mTBlFCin1
   kFAVnqIULldLhiKch1pYGNOW6cv1ownTaqT/VBLm/Gm7h5n9eEG6H+DvC
   FwPT9GqEpbSfuTfcuNrB4Ycowrgw6e3ZY2RkthU09ymCVbZ3kr9lMbpar
   rhDyh3V/mlGMhijGXj0RzjtgUahhsPRGrV6HJyCnixj7N0hQj3jyjqw6j
   BMk+WMGSkMVepIFIEBf1JYLkHwzVxcnRjPq+Qo4K5NadS0G7Lmbcnrn3w
   w==;
IronPort-SDR: xUv8cnQH2oGh/Clp7OueFm7CzBRUqVTEtfyNS54JoXY8LD5huIKqEUJfsfDUBrZs+PFodJQTnK
 hcjvMVZ0QdNxOczuFh6BjMEdde8JVCgq1LRzNc00r1x27MfEHojJyMO/E72Hcaujy2bTVjHs4f
 OHwx86vZYQcYnD1pRb4ZGFOvUE7AxtlAWV+TzvHujq8SD2xWx+xeushUGWzquMWIasf+oA1XwR
 csM0UjCiFrOQ7tnbDMXMr18kG6HmnE/v0dGelB4doeq3wECGK5WshqM3LskNb9h0kbVwrYh3L4
 RxI=
X-IronPort-AV: E=Sophos;i="5.72,329,1580745600"; 
   d="scan'208";a="236452382"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 09:31:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAaEUpwQTcarZvuN2xEY2mI+MvYHPzE2AYc+F0C/YtXCo7B1ng2YhP6bpvX0MBTRB1aGU851/VhmCy1j7Ua7W7d8mRVNOctPG1E7uqzYsyBzC5DB1Dw6LRA9OFBN1wQ4TXHCNXJpR46GVALQ7NAKwKLsQgrHJYw5f+VHog494copX5zF8AxU77bqYrT6ONv/2wZBQ+kVtfoJmknWYtQFPtFXa6CUdMcwRGVdxE5ri5uy7Y+l4uvn4SiGSFXG8lN00yJ4Sx598v2pgE0xB8QObC1YnofdtOPO9a6OR/p9kAm3YMeY7BD2hB5wz2mzGtedb73y5e88YmAXWkWcorbnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/2rG8m8UGPq9DOpb3tN8DcEGlNRwdjI3ttrCNWM2a0=;
 b=ZXiNCnU1yU/2rP2/ZQY5bqAgE3/2GlPJ9J/gPnercKMXr8nfbTDWePOR5B7U5osOVCCMIp33Hy9TiqSscgbo2Ql+0bzb38WvKU1VtfsMu+i5MLxR+08fsl4IIe79e8kJ4VsxyQ/20+NkVRlxvntY1lA4e1JDLTr/j8EQJWCT4dqlqdz4TYb4pA91rONMygKKr24D3sJ50y6Paw5XD3mL2XDIB+jr/zN+eMbRdufmbV1SBbpSB1gjLRzbYfZKQchJQhcnqKQfejnuHyCJx3UK61CrzQRuL5EnJFVgdOqt/rRjUhYEScT7ma7UvR9sbf5G39Q+RohmE5hpNZ+lQz2qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/2rG8m8UGPq9DOpb3tN8DcEGlNRwdjI3ttrCNWM2a0=;
 b=IZHJCwP/0hS8ysDH/O1LRrGLFDwXUZIm0o5mqf6CQN4D1E/YlVRl7IBa7M9zjhYGPpRHctwXMJOkGVQfTTl2vA2MJYimMh0fBSoEpnpPfm3BKPh4LzgyescWuUOjFP8e3KQBeb2CA7Ue+Zln+I5c9Is4Lex7TM7yvAIS/wThL7A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5973.namprd04.prod.outlook.com (2603:10b6:a03:e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 01:31:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 01:31:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/2] null_blk: Cleanup zoned device initialization
Thread-Topic: [PATCH v2 2/2] null_blk: Cleanup zoned device initialization
Thread-Index: AQHWB8Hy4YMwXjRMdESv/npaGsUGzQ==
Date:   Wed, 1 Apr 2020 01:31:23 +0000
Message-ID: <BYAPR04MB4965E7F09F72C833849EBA5F86C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
 <20200401010728.800937-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61370662-7b22-4acd-506b-08d7d5dc6368
x-ms-traffictypediagnostic: BYAPR04MB5973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5973FE810BFED3642CFACF5586C90@BYAPR04MB5973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(71200400001)(4744005)(66946007)(33656002)(76116006)(52536014)(66476007)(64756008)(66556008)(66446008)(2906002)(81166006)(8676002)(7696005)(81156014)(6506007)(53546011)(9686003)(26005)(5660300002)(4326008)(86362001)(478600001)(186003)(316002)(110136005)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WibhVlCVk+C98R2de4b4AEmEhlsLXFKdNztXs8Ge3P0yA/OOFRW1e3ATyBBWRN0SfkJMVC2zfiVqiSwPH4RfPz7p2yVSwsexw/blk36UHkvmBQc1I4DwQW3DZtRS0FUwHlxIG7hFB1iMYdqB1AICRhtqCoUmYNBOg1VvU3RZf1H3Oc+583TZ7CYdRuY9pBM1nbU6iR3wkjmgb8whLkdOdf5sMdJ5uNWI/6rm+vSQ4ugnqDhNbW9qtQLNWfvyLSmfkKYI/cuo/8pLJDwa7qC+yHGFjea/YvMNWyfWgVFBoXwGw3HNAEYa+TFAG7w/b9BFWwTlFNE2YTSPjHduNhEmQ/OVsLAnBmBdOy4Ri+SiZiQ2o/Np5yyRyy6Ka4/OBX6YGW/oLZPk5PaAqtSen71XTAHgmTxOTpRESUnlx9+qks/2rPJL5OcKKWKnlpDU57MF
x-ms-exchange-antispam-messagedata: bGsFt/JmcupnDWRSqpgfR+ZD3VPGe/BWKns4u60FEnSmJ05D8SDJ6351+qAKNjJ5TNJiWUei2jasglamc+3opAs0GQ/D27fN5R1/4NxjjQlydPGzoAlSl+IyK4+YCgAkGnXcdbNTgUa6NYkEmS7yow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61370662-7b22-4acd-506b-08d7d5dc6368
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 01:31:23.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0iSTsk6KjA1563KKHVLPpMm1GDgM9I/LDh8FE7Hn1ow/2Pn+cKM6JvqA7V2wmOoDEHOaPCZdYXLDQp4An5UvgEW7Odxn7YP9R5nrkgvMfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5973
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/31/2020 06:07 PM, Damien Le Moal wrote:=0A=
> Move all zoned mode related code from null_blk_main.c to=0A=
> null_blk_zoned.c, avoiding an ugly #ifdef in the process.=0A=
> Rename null_zone_init() into null_init_zoned_dev(), null_zone_exit()=0A=
> into null_free_zoned_dev() and add the new function=0A=
> null_register_zoned_dev() to finalize the zoned dev setup before=0A=
> add_disk().=0A=
>=0A=
> Signed-off-by: Damien Le Moal<damien.lemoal@wdc.com>=0A=
> Reviewed-by: Christoph Hellwig<hch@lst.de>=0A=
> Reviewed-by: Johannes Thumshirn<johannes.thumshirn@wdc.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
