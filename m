Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA36C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F309207CB
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A7gdKlEx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lyDxS2ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389999AbgEYLBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 07:01:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32482 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYLBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 07:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590404492; x=1621940492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JdznBOcNxnGYXYqmw6o4javdXAHhcJze8cgKf3Pzt5U=;
  b=A7gdKlExJdoppO+3ZTirrrey6IOU4r5APrIQPDaieEaWs1xYqeD5gWij
   Mo/OCW8OSoXTD/85L4BAI1eci6kIpO5UBhXW5zBqKfHpjdTp1ej2Gcs1T
   hI/eiRHuIiPrr2gySBdIL3OQSHvSwsYmrNO1dhQwMXkHoqb9jYT/Sr2Ku
   vTjc0gWwMNshvbBDUFVsmq58h9gm2lbBZohPWo1WriiBHS4/MfQqmA0S6
   hn1qwrpPeE7Fbkkzs55UYgtkHp0HxNK7YuyLRGYs4Y89ZLEgEESSyMZ5V
   aU5x9UTEk1L2PuOe8IGVUq5+NeRH3Vsy99U7RhGgxBxgYSLow5pBE2oiY
   g==;
IronPort-SDR: Z5E9baFS2pHohd6PrKRb9AKBVcNwSz6F1dapp1ler39KYbWrd+eh91USu/Vx0HtuW+8pQTf6v4
 cbusEtbe0Y0wCU4TK8JlhFr1hWXMUb+gfa3r7LxNnxqyU4Y8azpXhb/pzt6VjC4k948JpkDav8
 /wKPtl3jNAYuD2p2GKu+qZRq5DEZDFDRsuwjtCMKOJB/z9pl2oM31hwWYE1/FJ3VjXlCtfM7Wz
 pSSBAqMMbvg2OC3O26XA6Jq0rdACe70VhARCDm/N/jEUKX+WoTGxTnZwsoYrmNolONLhmC0ZqG
 BrQ=
X-IronPort-AV: E=Sophos;i="5.73,433,1583164800"; 
   d="scan'208";a="138457742"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2020 19:01:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfNezPXGAWQfot6NpJHHrOPBE2W6iKqL34H5xRm9GamNHtLluZnYdqVAtGyKhlLIzTbqGfjQouuq+FPa1tPzmQYKsdseGDVSl1kIhFSng5Ra9y5KBNZRV8DRVYTc7QYOGir92frPXIv0HjWNsiOuxXRsu+hq20S57F/pPn3YQjWJXjDkWgrUrO9dm6WDWQl9oD6TMs3ENLbj4dvmbbT1U6G5xMI5qBX0LhvKTPeu0lqjen4JCBjIQ5+Le/FNy+KTIRTeurtWeiNlq1jXo5HVFUw47rf66E3TuOtlrPTZwcyCvrjrq/xcjbGMyaKrDchFSHf2t8JtayV3MOlyhesAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqaBUkP8bjWl2ydBdJODPF7mG/G0lTujZXdKmnUiJRs=;
 b=MfU0K3l7JhDBZU2xz8TF8y/AWYHQXXT5sRmS5GffhIVElaLh8fXq1eflmxHn4QaE8EyRNHZO6chgaW5DWfUAYJR+0QlFWCGP1gOb4yuoXfjJV5mde+kMxQQ7Md5gPCjskqzyyUNRkNwexfFhdaQ5W8rjlXDHdwxXNNrYL4tV62mRgRMWYKA5Vyd825F3LaCyNQgnPobLijXq58HA60J/FEUTJM7SmQtNmjOlTsuTec+yqwrV1tnzumVBHHb9uLJzTU7Rq9lr6mWVtNPzDN10crfPsKRNqcMLnsskI6X7EIwBn+TYtSiOS2PJRSn8viPQfaqn9hLu7ocL9DzXVRR62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqaBUkP8bjWl2ydBdJODPF7mG/G0lTujZXdKmnUiJRs=;
 b=lyDxS2ewlNmImpFktXala0yHpwUIBOld4zvJpJQqVM1mHH07P0YTcYVvJrOuP0ieNr3/aaeRugvvHAgnnhXbnc5+sEVUv9bCKaXOH3+dx2tD4BkU6fzbcKsDrKfPgGhebHhNJLZc1Qsr5N5p+vP9AK82be0weGIxncHA7iw+aGw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3534.namprd04.prod.outlook.com
 (2603:10b6:803:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 11:01:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 11:01:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V2 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Thread-Index: AQHWMnhT31E0DDF9T0iuK90q5B3Etw==
Date:   Mon, 25 May 2020 11:01:29 +0000
Message-ID: <SN4PR0401MB359822F483E45C998996D49B9BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200525093807.805155-1-ming.lei@redhat.com>
 <20200525093807.805155-6-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbba2088-1803-4936-3e2d-08d8009afa1a
x-ms-traffictypediagnostic: SN4PR0401MB3534:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0401MB35346C19507EF02ED59D49D69BB30@SN4PR0401MB3534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZfZ/6mNavFwM2AqtT+ey0MAJp0Hl48dwFOGc/SP7zOZpOGV4S0I27UUNdbfha1zN2XPOo/r3diIfRU9I+C8/3NOFcf/P4Fo07QctNM0NeFc8oVDrlX35nk5GSpRtNuGIpzd446RS5tkPj2hfjSO2K7D5paxHUcCgFUL2uW8RC79Ud4SA46fHibFyly/3I+vrng/naVzC0x4uYGagdAXaDxDYbchwtK9XELIWdJc5pgOPvJSLrwSvXiea6dyYzQrr2Nn5kPlgA6bBFtOQbacVOTtpNgR5pmxPtSFvmTkFCnrPxzjsW+TzNMHCeVk9yF4bLPmIIrVgVcr961UX4hCIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(86362001)(186003)(76116006)(6506007)(8676002)(53546011)(8936002)(33656002)(66446008)(66476007)(4326008)(64756008)(5660300002)(2906002)(66556008)(66946007)(91956017)(52536014)(26005)(316002)(558084003)(54906003)(110136005)(9686003)(478600001)(55016002)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PQQoTMkhVnGEUhvyzTA+3fY61dbXR/Rb1dz9Fpe6Dd+ebKfV/OyskdqhFRYDXFr8z5NujrwOiIQOZBszlx2wAbw9nzga52erMDOFsF1BP314ZfEAE0veSWkTjIljCmDK2lo4LZcCQFVnpEyCarCsCt5Jy1ysVDGMnXpcrPbWu3ydux/pAJx72Q/PISMUjsUe94LklPiy1kvsgH+B/2URsoTZFwBP4IQQfL3573OyXyJaX8RR+To67rB37HbifzwL7rC6so/GRfvpwc+pW2OH7G++PQcnGhE7jXbDBBbgGrTXz4FQsqqQv619gvdb9Kz5dGstTUh7Plp58AoV54Lyh//7M0xWWpQ9XVF0wQdZutEqfpnoHZvMNwBlL/8LXRmdbs2LY01NXLRyuBQLw007Xp4jCejqqK5nrbJKkVsEpDFseYBR/iNvklW/HyTBliwroARo/IWpLmVU8cvOEvHTP376LDbzktANAMGfrTyqt5VQli4qJt95MV8Qg3Hwwd5X
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbba2088-1803-4936-3e2d-08d8009afa1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 11:01:29.2333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NPJnw764gUFJ6lngMErKriL5Sgi2ik7+3doen/7rWgmdZ4yJuGKfC4iZAjGvfjlpNGFJCUZbUN+lRf0YPrm9d8WCfY4TCzIb3Ks1ppzeso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3534
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/05/2020 11:39, Ming Lei wrote:=0A=
>  bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_hea=
d *list,=0A=
> -			     bool got_budget)=0A=
> +			     unsigned int nr_budgets)=0A=
=0A=
I would probably just call it budget instead of nr_budgets.=0A=
