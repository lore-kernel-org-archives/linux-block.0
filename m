Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9591C2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742E12137B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SXZ6+Ulj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B0HdIofU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDILVQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:21:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29495 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDILVP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 07:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586431275; x=1617967275;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+doEzqLUbKIHD7UCfctCd4P1pEHGNPoETj9BaeEAC9Y=;
  b=SXZ6+UljTp/hlrVvZ9yGlClDpeDHVRT3HQBstfGI+he4iGvDQGv1vtZA
   CVuLNAjpDkgRt6S1ba442Y4Fk9kro2geZ3wpihINeEszt7idjTvs+Pehq
   Ql0pd8e8ARYynaF8eC1iWVvGs09ycHq21NB9vw0FvPx0h6NiFUgDSVClU
   QIeI9LFzm/wu7wr7X9jpF798oVlxUsb7ipBFP6WG4KVNn0PFD8lNEWY/C
   ZUFS+GqsisYBBZbWgxXfrbvvLDxtlbmIqHq4OXytbvEyltzUL2iwVUXMu
   FhaZqmBhf8DOnRgQ4o8I7qFY0Z9mTveYyMq6Qz98NVScOKHyFNo5YsDIw
   Q==;
IronPort-SDR: 6pMLA9h9qpD3smZ2YniQqQ62dUbcAVl4c/YMufUB8QGXzfobpLwRV9kW9jVCVMeCZX5KMqESPR
 x82MMmzrWZP28jdiYNB655B4D7Ev2KutIFCgZi5upQBhuioF7idePpsVQMmcw8LqDCeD+kbPLw
 j0eqZjieoseAS6bJYfoQCFOyQj7Pj1itEevn377BIDCqMiakxJrQGTJZvO6vhWdCP2poByjVU/
 JNKgofsiH1frdaayQ74CfHiOmIkOT8HwcXVC3roRD7l83QnsjRbIuvWet8w0X4Iu7QTKRn2xFW
 txM=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="243522831"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 19:21:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdR9JEoTwKSxnYUBN3AotIr4oKuhfgV9FEeNqgXbmhjLAHdhseRZ1nleNmKSeNx2bfG4sU6CwIZcFyY+14o/5Y8+xjAUFVOjiuT2YTo1j9nZG6FQlm4YmZ08EsKokACLJ6yPx/bvYALN3AIK/eegXe2jh3YpXoPOXUENZ2d80YLBTWyVddu1Ayig4G2Rks2gPdzFSKQFoCXazVuzR9FJY4OCgAG0OVFZZ9GxKHBkEn0fr8M26K43cbry/iUniYTTgD8ZTsHBDZw9vqVsgnXpcGJsZkQx4ll1mNmwKsoPSde3ml/8ao2QhfSc+8PAAhCxBCtTg70qdQG5L7hdLvd3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LX71rBEw66vNil6DBPidS2b2I4tcSAQKkVOc7rLb6c=;
 b=KeDzWFrJesGquiAex5fGd7id5cn4niXlu/BBjv2kG8Pn5BveJtnMsnwNqLy+uoBI9F0Njd9ThV3eKkfY9biMkHPR1/1olLD4EoV3xzNb4OxP9FrHHbj+0Yr8899wadt+6HvaxWyYJDUDc7FraMXT+yU+37dIkf4QSVy8Sd5vXYyy8i6gNL9RIu+kIDinPD4FId21iLGDKexD31XSbF+6MXQ6vvoKpqACJxMYl3Ato1wZar3NzSfjm+UC5BI7nuCTDQENZyT2b0O6N5HAZ30mcy4lA6S0PdBDphwmZP46T4TydiOiTs6XgKLa+ryA16WA5mPHhQmUvhrIqUwGT+8dQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LX71rBEw66vNil6DBPidS2b2I4tcSAQKkVOc7rLb6c=;
 b=B0HdIofUqu0UmfqpCly1ucgSW4ppI/AcyNRlFpKf2GzG7+4gjtuLhAs7RtMmGgnb/eU1fGkSkLi7OpY+iMao+oWC5eQzXMKWK67ObES7FRiDuer9ugdjGs0nr2GahgkMMrdRKATEPgAXp0RjSwc7uPuqF+WJXYNx5guyfSOJmjE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3581.namprd04.prod.outlook.com
 (2603:10b6:803:46::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 11:21:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 11:21:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 01/10] block: refactor blkpg_ioctl
Thread-Topic: [PATCH 01/10] block: refactor blkpg_ioctl
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 11:21:13 +0000
Message-ID: <SN4PR0401MB35984BB0C3BC58C396E7E8739BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a793590-be20-49cf-bd47-08d7dc781d1f
x-ms-traffictypediagnostic: SN4PR0401MB3581:
x-microsoft-antispam-prvs: <SN4PR0401MB358197F36C1C3951DDA4081E9BC10@SN4PR0401MB3581.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(33656002)(6506007)(9686003)(52536014)(186003)(7696005)(8936002)(478600001)(5660300002)(558084003)(53546011)(81156014)(81166007)(26005)(91956017)(316002)(2906002)(8676002)(76116006)(71200400001)(64756008)(66946007)(110136005)(55016002)(86362001)(54906003)(66476007)(4326008)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LzwAfZ8HKWzI82nIqhxIaW3NPVNkOGE14hpZgZGoFHFnKMvACqztHeJlUZTr3bFyltlJnzdSNl8OeAvoLX05mGVQQjt9uQKopCevAOJXKqlCDQTrlWajo8FyhLM+x/8ZKUWeGCHomc4/BRWgEVPIjT56hoO1QXYmwa94eQHm1wGLpK7LgUcnM227+/THi24gdqxEDM+8OgAOW4zYfeduouaSd0gZL+ZL3+rYXICNDmWKPGa7xhqVklqtxBWcAyvZcn16h5jtXp/OCFQBD3hmi9Reoz3eBRQh7/bW+90jehVAWTrUKO+T8axjEodCWfxfmVIvgr5b8etzB26o0TuTTaVBbFKVjxIOn27Yym+ww6pt6i4DcK62N6itnze/oAbiPOqYrU/AHtZO8NJ35n6ETsmsBHEz+rspKnDM1/mdgXqtREmN6FUP8AnxC3938pv
x-ms-exchange-antispam-messagedata: 1+LcYIr7p2BrR5VbAHL1i8QkIkzQYNMpcLi7XPCPTgT3yo2NbTP/o4aORooTk8uEj8WsZOBG4I+aCCOsf2FizqL9d1fOcOQM8p4XBNc2MpveLGaVHUIkzsQTC5PWEgVcreHjLf/DSfg4GsrmjZtsvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a793590-be20-49cf-bd47-08d7dc781d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 11:21:13.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cj27TVNnQSmatAxXqR0o0I5gPamuILLLj7cZ4Ur59cg9YEdO+7UlZ47/2Y1bzmOT9NgPtEe1VAR7Bp6FPE0fZN1EtJ55nhguCkjNe2ogmCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3581
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> +	case BLKPG_DEL_PARTITION:=0A=
> +		return bdev_resize_partition(bdev, p.pno, start, length);=0A=
=0A=
This needs to be BLKPG_RESIZE_PARTITION.=0A=
