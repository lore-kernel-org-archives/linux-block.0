Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C4C433DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 09:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A0E23100
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 09:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbhASJGQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 04:06:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61959 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbhASJFh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 04:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611047136; x=1642583136;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lUUDP41BbcEVw18NkOOme+gZu9vRi/abvAFwQUYm+WY=;
  b=YUjbAPq93e/829SPeaL63wJR0YjbNJayXF5fdEFYHmIWAEqS0o8utR7V
   8t1V675/rOMrregsMPxR++Tw81m4ipmqr9QJKorH6//xXOSDsoqtnkCYE
   fwf4ExN5OWr7dGxkJmMJxDVDAB1xGsgZ7c/VMnNGgukMjOXiZIBM+Hpjl
   WmwigwVwQpalVg724CV/AjJw5f17yWnHBuK6hQBl94K83dNPkbZIl+zDE
   ndC5STKS7WqabUtlAMxtpJbFj3Zu51BwrpSmlNsLK3BolPa2ofx/+ssiC
   RenJh9YC+r2NEtU/MxjZuvfqaoHUrNtJqGfJbXdUWVcjwZFWnhDmEcKUe
   w==;
IronPort-SDR: e/6TNsKgCS4dQa1j2DmQuNMU8ihF9JOyUKQXHAe3vj2F9v9ydTbmfUij0XQtdkGTkQfcH5Su8x
 FOEodK4RjOYBK/qpZOOvIJdx/R7yf5O31nEqzQZEwSo2ssSorOKfVVata716nmu+2++DOkdYuZ
 jRV1/l8Af8+Q/LuEfDmAghOdBac73wZ6W45IQ0hdA7bgKTc9lSQXcIh3Cid+ay6odJ7zlcRTdp
 ZIVDZiylecZJcJAG33fLxvmgnKLrlhT+9jb172Axm7KIorv2WC7rpsjGlfMe673VxAcK2PJSmj
 xUE=
X-IronPort-AV: E=Sophos;i="5.79,358,1602518400"; 
   d="scan'208";a="162219957"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 17:04:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrxIJL+VL2EgxG/6BNBPrNqcqGa00IFHrxcuActQxHauxq6M3DIUAkDResmG3H6d4jtwfvCI4J4TWJxsWonr1ZBfQMNcteaRx3zH9ZdOzcV95iEqif9Ep4TCD5k2QtvtVtsA3unnEcW9OpGwjGb4u6PqtB0JrD89q1gcBN4bEFLWvbdk9pDG4vTaacuUX247KKKrTGf3GjLM6OUyY6JRCLYiwzKbHjjC7gl+FciZ/g0lomkR0sZ46s/GS+2hJGo3mMHPUnMNxRerfed3FyfXXvnLIuXboCJa9Tq/QTDqtQ+5FAhRHW8Jta6cn28aIwOUneCcHcvtKjqhZ9ayvOZ0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj2gM9V6JYoZ2D9sE0kRunkSV5UxEa7/eAloyjO4/N8=;
 b=V3GhEE8C7SqVF93pjg56jzXHYC3BkM7463GURf1mzo0upVFzHcyr3TcL8FWFFod7jw6R2HcM2v0+nixSGh0CcyDklOUiS83UL/1+Hq+v6DWue5NR7rqmI0Xi4Gvrrx4Lj8jNdTfkNNlg4xuRtGTnrF1zvyfbtKbqtHE2a669kMZD8hlPIzv372jV73BYspkEOzwM/qMgDpC7vfiQxFqttvpLF6qwFCV+1PLYYy/lM3lIOUkBK1eDUQNu3crhQuyuxHYtmlDHBliHs9FJJ9WapRXP9ntdCGuqn4sd2dOOCiMRPmxLSi+N37T/dcpudHPXl8otStinWsVsPyqTQJlQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj2gM9V6JYoZ2D9sE0kRunkSV5UxEa7/eAloyjO4/N8=;
 b=ZTqSX7UEiUocir6KLwNr+BwA4VhnAeeiY02IbMqfw/RV9uEkrp/E27kSJp4d/CR7rFs5WGWkewNCTIW6HhHpmx9h1PZRvN9coojyeu8zpVhxhh1ka4DWKpWv7VEq3Ar8Eo3L5T3WykEksvJxMGey3bPBFcJV1CcTVNE4dzMpRiU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4159.namprd04.prod.outlook.com
 (2603:10b6:805:2f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 09:04:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 09:04:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 2/2] block: document zone_append_max_bytes attribute
Thread-Topic: [PATCH 2/2] block: document zone_append_max_bytes attribute
Thread-Index: AQHW7j9IsllC/XqUBkiN53SwsWuQEQ==
Date:   Tue, 19 Jan 2021 09:04:26 +0000
Message-ID: <SN4PR0401MB3598768AE668AC6C6F1319869BA30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210119084103.1631698-1-damien.lemoal@wdc.com>
 <20210119084103.1631698-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:e43d:f567:1fd4:4217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 888870ea-250c-461c-0a82-08d8bc5938c0
x-ms-traffictypediagnostic: SN6PR04MB4159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4159D344C82077BA32B97CA59BA30@SN6PR04MB4159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZ9aWFWgcnKLiDW6dt7ZHMjF/CppvK/wCWG/c/gDriNqbfwMuhMhc3F+j2xRiqAqs0+6bF1eoKkfEpI09H1+AjA5bBTmnfKiQbl3MgaTW/oEkY+VYkoeIZ8pprX51FAXXJ0XhJ6L5/gzbdoiYwJ1m508x2+2pwltK08Ll+H18F08KjEkMeGHjr9KISnkoobeW6LgsvjiPO5NbZAjLJgiKrQ+kbtp9z1OXkhzCVDQKVv/MpLDa/W+ZNOwN0/KQ8yLgiCx4eqD63GwMx1MiPZ/72Ko0rq7CYQuZ+rl9ARJr4vNE0bTIeR8yGLO/2WtI7DIuDZ+rJdnW5rvZpLnA0IzsoFwaFK0DA3qRCcOm9WCXXxAflRcR9D9kRwMGO2GBi0WitELr4bXVF4ycw15YnTMAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(478600001)(186003)(71200400001)(316002)(6506007)(4326008)(53546011)(33656002)(83380400001)(8676002)(7696005)(66446008)(64756008)(66556008)(66476007)(110136005)(55016002)(8936002)(76116006)(91956017)(5660300002)(86362001)(9686003)(52536014)(558084003)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H8c5S7JXhCisaAo3stdv0rk2NVbVvaDCtajRwgkFEPmZSaswJt+xfKa/80DP?=
 =?us-ascii?Q?t9gaKg00ixPaZgB6vqorW5Atsa0VQHyToHKHrbscfVKTocoWB19HxB4VGF8r?=
 =?us-ascii?Q?aEx2ah35riWTgM8tiW0zN6RIbuKlRO1A4LXEan0gE3+sFAR/OHo4Xwl9mJfU?=
 =?us-ascii?Q?evKAASRFum7ldYK0AVrBSf+vfAuBo6zOdCh9K+vsQ8tBexw69PgKp0qP7KDK?=
 =?us-ascii?Q?LlCCObaLPOMaJK6Ew0nLp7mNnNHC13KoGFNiU4MVpn6N5D7grDpuV8nGaC71?=
 =?us-ascii?Q?wwrtd5JseE6PpgHCVXFCEtyECxBiesclezut8Szy7880/4Ub5BtoOsg3K2n/?=
 =?us-ascii?Q?Qs4jxJXg/u1K++ogzoZL/UauiDzIqfamsjQR1ySlc/tsXCMC3iee6DjR6reQ?=
 =?us-ascii?Q?rsaMqVKATasFql7LSWjsNyhJzxRl67ea8KTFFOn3GazKNwthJ+8X33Cv1a8V?=
 =?us-ascii?Q?sCaQVaodo8vhIeevtupoAM0PxlP78uUrExopyFi4cs7235O4MHcTKG0GOnfD?=
 =?us-ascii?Q?mnSk8cw34/Evv2OfaEBDGAJqrGlUi+rLlPyw+1Mael9XyTgRfqJnChDNz8WX?=
 =?us-ascii?Q?PfUbMRMleBV4gOqCRStXY0YLfCaoQumyy2xSuLmgh7WHH0Ow0aXT9pOtxe/G?=
 =?us-ascii?Q?4CRRtVyHgJQnFpdqIyII+VLkmcSzc80xURec/9/uw60j5XLDxrV60dCnYCHF?=
 =?us-ascii?Q?zrhTzAn2jwaOtnAFmftJQW6kWkpT7rJmaV1CnytgCCGWGOJ7Ym9JASs4A1Qe?=
 =?us-ascii?Q?IVWs0wpKLGznVtl0aRU01Gxj5DRPKeGjRm6c8nI1rLivRtGHC03dTtaFXvwh?=
 =?us-ascii?Q?sY1DQGxONK5JVtQuC53CGrBe7dHrbN463bDOAED2sVH71Ju+a/2AerzpdJ6d?=
 =?us-ascii?Q?IQKGEjS/rxd6eCSDURMl5zjs6wkZjlyNxTbajwadOea6v2HnGRSlc9qvmJa7?=
 =?us-ascii?Q?ga6tiyBrQeIl8nXuFpRXcMlABNhXytRUHmjQItc7r6gNn+iD/9YE/2TGpCqz?=
 =?us-ascii?Q?8Ssw4gj7MSiRIIGkmA15O2Wl5cOLXFrFbliyIJxlJuF868rrDIXtIb0Env4a?=
 =?us-ascii?Q?3SKNCPuk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888870ea-250c-461c-0a82-08d8bc5938c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 09:04:26.1906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcLv+A3VFtR7dct4cqzCVPD9q3S19qli0bwKFNFqSSsxEiJBdphtG8tqo+WsMLfMfroWP7xVy2T/W4GuqHxQiar7O+Mezjz7ulQucGXOz+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4159
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/01/2021 09:44, Damien Le Moal wrote:=0A=
> +(REQ_OP_ZONE_APPEND). This value if always 0 for regular block devices.=
=0A=
                                is ~^=0A=
