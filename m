Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0179FC2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762420771
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QyAwaSy0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="khZkkElt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDIMBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:01:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36707 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDIMBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586433686; x=1617969686;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QyAwaSy0xjXRAJrFgfhi0OU9XMHbw8D0KGz0MJ/ZNZxh8uQK3rkdup/w
   73BKeokQ1dZ9wmtC1xidQfTEb93MNAoQ1aI7oKMYJRV0pYxm7yXOhRkQj
   esKHzLR7OhWBVPVvuhv8+tAocObxbeBFwAwNrA5W4UmW7IV4eiBk8w++m
   2ugaGxCaL5fqrVBmuf9YdiomdJ1rSZNaj6x0Fwod99YG1SpVv4NknlOhm
   AkTpVlqCEFG0TMkSjLYIjikejHB1auMqTcFgmDQAyfRpnJWOVJqtLWCvu
   B2xHHT/LOaOwyFQJ+vskyuLWsQaGqN/yXGm5HoStlvFNiN1fy2uCJ3y0K
   w==;
IronPort-SDR: LV/RAWcU+X6me22X4Kre/jy1Yy4yMGrad1BuvTwLvVVmAQbgJVkU0MGmVKhsGPOLsRn+LhY+/D
 aGYeNY/4Gj591q4WjDzwtkW3RDm8w/vtLOGpRimZZ0k/t3KGp1CHVU6CQm+Ms0h2+SNt1fcXAK
 fSs4odMV78nshH/pvgFvSGvJqEw5O/RwECPUex9Zn9MpV0RwvDekwjDsz/pwOBOG3jC1vg4bj2
 uKNXNk+GM1qTexmybdhVOcq2q9h+u/agY0+Pk6Pki+cWMIr0Gg9N3RxB3VaNAf19ruvbr2NjKN
 Avw=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="237301929"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 20:01:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtXkn4TyQK8hztAaE0vjV7JwMPa2YikyVYffU3xbjCH18GHZtGa4RaEejVYdZF/nDOeQ1vhUo4CXB1Fv495Ujt/a7MZfGNCK9vkWJsXQfyfkdvxl/Kv5KitUMaVf4jWzLNxPfBCzVrheN6hOjPe6GV/fXySeSc/qzlwi4Qf68yILtotTF0uPviPGP3S62TfwQzy9p8unCknceQYY16O6TOE/e435asMuOUlYEj7ErItswNU7iqlURYIQI6QV2rTXATSvsMzhHe+t3VE3FTlymZxObHfG1myodUGuW4FVbHdlDaf0uFyCkXHlsN8Gy5feKzkqoqAK6Tvm08OowqntCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Yd2nI89Rjh66f8Fli+e35En5ePvZyQaRVf73pzFuLpyYqQVqWXD6qdwbhsh3YdcEIt/qYP6PVdufkwNFRSctlskaa1LgPzczZmIXKJciscfePxYiSulAPW5rM7iru55vkeKrdML8OVUZ6rOO6Imu7xfYA0/ysQIPjTlA6Sd8/XZnRXqcOh4AGSPMr5JXuf/1gHDRn5czDOZyhiLLdNF2GXvZGXEQAtXFnRBZmJCP1KXMtaTRSisDxiVX+2606UAK2hBEr9LnXP5gYLwusBa/vNtCvPAaeN7nvLddMMN4UyvzPvoOpcjw9SLj2AEu6mRlMPu8s7nFVjU1yvj/EZUOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=khZkkEltG0P/9Siw8U9chKL2qTL0e9aCaiP6k7po6HHsk9r6Zh13ZIgpMrDQC2fEzD1ZvUlCI8+c1rCLysJEi/oL/fflDar9fjsg0VMyIAaEPn/hdPrREzoGjhcRqSzTz+MBYoGDG/JzvAjhM0xB6jEiFcnQNoyrC65fy31HDBo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3631.namprd04.prod.outlook.com
 (2603:10b6:803:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 12:01:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 12:01:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 08/10] block: simplify block device syncing in
 bdev_del_partition
Thread-Topic: [PATCH 08/10] block: simplify block device syncing in
 bdev_del_partition
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 12:01:21 +0000
Message-ID: <SN4PR0401MB3598C1B2759CD6557C1CC6059BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c90e85d1-24b2-435f-020e-08d7dc7db84e
x-ms-traffictypediagnostic: SN4PR0401MB3631:
x-microsoft-antispam-prvs: <SN4PR0401MB3631D3ABC336113DB7DB2B799BC10@SN4PR0401MB3631.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(5660300002)(2906002)(66946007)(478600001)(76116006)(186003)(7696005)(4326008)(33656002)(52536014)(91956017)(26005)(19618925003)(6506007)(66476007)(54906003)(55016002)(64756008)(66556008)(9686003)(71200400001)(81166007)(110136005)(81156014)(558084003)(4270600006)(8936002)(316002)(8676002)(66446008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRQisBJnRFfaacp7POlFJScnu5HNeT7PRHGQ6LeaKX8qen1nLlltEGqBJRXGOj0nPJBrTvvgjzNg2zBmwLRDbeqcExmGD2z6JhW9UeIit99Uxou4C1dy2TuteAapSqLVPuzpSENX4yCo4ZV6ocR3UT9+vmbdy3foPOLN0YbAkLbEe2jAP+0MMLpNQKDJVzRT2eBCXAMSQQSNttMZ8UfF0gFWJxGqZ+CvcM5zaEekUj14QVICvWkFIiGmpiOLNuCLPCQEo8C5xA3N9+WxYUxKeDrFBPZSqCx1cptsve+PnoArTr9kuMOdYBbH2HQD0P+NbnCMzKASqbIEJGKCkWXDHTRcd1iYN6Vveo7cjUTJHULkV8cNa7HxwAD5Tqdzs/IClxr8bZMzgV86uKPZzN3fNpXTcSn6empZMGO79sCUjsrg+Iaq6ACxq3WqaQUd5eQV
x-ms-exchange-antispam-messagedata: GcQUskNGXdZhXaa0jDAvYAORb2bGegNeN+eRsdD52a0D/fD6fITgULEO7agFFi3eJI9hg4XytKMjzhKsn0sPyeCVfunv5uUFJQoIZmXwnNWiZ3MKZpuPE+c/tZqstt5iRRZsv0Ai3beoQ6Q/4VMLQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90e85d1-24b2-435f-020e-08d7dc7db84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 12:01:21.6048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MG1uWro/pkvTB+ngS2UM3jqWwHb8dmb6Fg/ZvcygOOgxSjAYvOFcLUM7EPBt22YHSzPeBodHNuxfa0aMOxvpRbP/f61GNNVKZrl/kl7mG3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3631
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
