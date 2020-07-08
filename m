Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD0C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9286C206C3
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 12:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pUcEgQni";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XQf9vtK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGHMxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:53:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44005 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgGHMxa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 08:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594212809; x=1625748809;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
  b=pUcEgQnib5jO4UkzDWSp+c1eOBk+pNBlfYlaKCWzzpNIUlIb3vc7hVpn
   0l80v5V7C2RdEzJogkZ/ZhRVapBC0ok1rChG62FB9k2YKc13fcdQhHSsX
   O023/CYkARI1k3/wyLqEJb2OZ12VdMWziiQ84Qd1PsQUryjAmo/SBem2X
   nHVY/2VND91hMv8TzskxUc4PxaUrGS2pYsZKsaSHNTsFNIk0ezk60Vcrv
   MtKfrNHpj8sEdUD5hQIbtbs+5LzOyWZP13sY631ntwJtMdb3fpNgx60oI
   z8mX/Qy6g+DRZUvRJFgziKJwHR+bArr4bqCpyUphIsYYsWYEaDv6Wzhf2
   A==;
IronPort-SDR: 3roDovc7Dx+zOqfleh5krAIKwUXbyh8vnIvccWPITMvo+9ZVZ7WkDqNelr+6fhfUGZ7gV+GPKh
 UFGJFPKZaNUCHKU4Ws2c7k06KVW9KdABNDtO1bDZYI5j7xgi0eD4Jzpr7dYub8B0BpS4SsiLfc
 tx6Gcld5WrG5mVuED8Tfhr+Lmzw72lJnV1YAUndLbpG13yyv6TddHMAR4JGvx2/CRXr04+T4uG
 afZ15Gqf/lsY8AtWwvDU4sRD68QpxJU6JTlRfXLZp6QoRYy4iBTx6euputmBjy9pdS2TcGKODD
 Dgc=
X-IronPort-AV: E=Sophos;i="5.75,327,1589212800"; 
   d="scan'208";a="141918009"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 20:53:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk1rzDvdIj6KA9HJIFJ17+RL/5qVsmHI0AmYIUTQFi34zxVEvMrbLPSYHdDsNi0mobCiAUNN2TVOheciSk7+7b2718cOOpJb3lUw1FACRGJWemARsEUtv/J5W4g/AKwLS+S1oh1rMFycqGrURId/0+81VMH9kFvQaF2MABvrUG8KnzXMhBJ+ch425tJIoJSjv/Q+P8WCmXPKcn11moQHmD+8gi0LSGwlVwhVPtgqycGGjOoeaPghrsIWujVnkzalV4hOB9x4kQ1NRc2ft5IWO5MgrF+KJaFws/gYk3iEBINbxquJ1tcZtGAzNwriL/v6R5dIUFXMKnoyALKNpRIgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
 b=jiNb1QY2hCtbeeM9yT+OMbY0vGz7gBihDbtWDnrbZEVbV4aVKbyYGhfwCIHxwtiNr5kW/59HGkeGuuILr0OpWZIwy2EXN19q8aDvlKI5Bp/6iIAV6g/GPoDLnjbpVmQ60vctMMuL+92TDjs+zePHwT86Nu9znSPMp4d0DhaBXJRvjai2IOhykeBxAe5uYokxgj+4sjuPAjqua6N7SD0Ao27BkzHSHH5g50CxHdVFPxLHyICFFki79s85dXCt5lIteLKA+FGHyfyGyh3XB3yq5yuKucvCVIP+FrIXEQddiJGH8VK2DkGsHZdv6VMAGgxqMIpI1aUYnXIALtwWgVHB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
 b=XQf9vtK/36xNOYAhSuc9vUN+UhYYRFkmdUdEjfcSMi/lIWgnw/zNXtGMC3W9Jk6qgtUpzOckHvBPbSaEMp1nMMsL5Vq/vMh+j8SZ7Yhv5JZxyU7WRaESqgUnPJwyEf0Tlu6gm6vDvbcsKC6/pfO3cvcpekQbJZFPT+r/sv5nEHM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4784.namprd04.prod.outlook.com
 (2603:10b6:805:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 12:53:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.031; Wed, 8 Jul 2020
 12:53:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Thread-Topic: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Thread-Index: AQHWT6/PEqZpUhXEo0yHHoBVF2I1eQ==
Date:   Wed, 8 Jul 2020 12:53:26 +0000
Message-ID: <SN4PR0401MB3598E57128E7EE2E9ADF271D9B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200701135857.2445459-1-ming.lei@redhat.com>
 <20200708122749.GA3340386@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5994273-aec7-447d-060c-08d8233de813
x-ms-traffictypediagnostic: SN6PR04MB4784:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN6PR04MB4784FBE90B607AC6DC9009099B670@SN6PR04MB4784.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nnmd1sEriog008/ZoMH7HMklCbXBZuiGIHD3zqY4Tc/rIt6gFf+j3SHRvznUjasaxmSOXJER1Gk0ULjtjAGssfqdw2FDserBqvBJ1eT9zKZJx/BQr4pE2Ppb5tl7iCeYmN17jQXJKvH1a3MUnjBjleWT2NHbDC90slS0Q+vJuAB153m0AWuUcQJNYiKLcM+qr97aqBzKvbEMRzRyZ2Y3i9FQ7rsFCwaWd9Y2oNtTqYev24lSPLPnhcDGEJB8KGA5YS+1lbDxwSoBYoNmprPjeb6F+9eDSj1RqEpMNKXnNzS9biLybGHZOZdid9MJdy2UNNBrG3Y8expUvTd9Oj0Kkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(558084003)(4326008)(2906002)(8936002)(8676002)(9686003)(55016002)(7696005)(33656002)(4270600006)(86362001)(26005)(186003)(6506007)(110136005)(478600001)(64756008)(54906003)(66446008)(71200400001)(52536014)(66946007)(66476007)(66556008)(316002)(91956017)(5660300002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xDRUqc4LZQrPIZtwhJK7QfrJ+8EGtuz+qsAZ9+noFpwnhM8LvumtsQCh9sU0YlKa8vZuq5as+TgOVhrFNl7oPg7VLE9Lslyjvv2HsEFa2bgqk4Oiztykncr+lfy75IuL5n76l4c64piIM+xsuUSrfQHE0zOFurW+uStN0HcLFwzoMUqLjC3I16sovupsRebIizaB1fgKK2XBqM6+nFHcVmjoZR5GTeswFtF/mfGp6tX4KgAgWfZ2WRHmnNZKuhJZzZN8gUrlIGYpdBC80Xpa2BemOxs3VV3KCZVP5fA12Ck3lyBse0lbDEz9NRX1MmmC3wm1AET1mKUBD42CD1UlVsc+NmyHcqELn9cC6IT2ggTtCQ3cNl9QRb+5NHsNdVc4JHR4o8n3CX1O0FPzYQS6RBykAAJ1V8GN7ZcI9R6T3FoUM8O5db4MM2C+6yOCqHwdaacITz0tOIENc+gmWgedbwtJiaLyU9+Pzb2VPNvsOF4/18ebzQdmEN6fiDyLxiGI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5994273-aec7-447d-060c-08d8233de813
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 12:53:26.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EN5GW728oVMD8Gyi40YAyJDT++hjfUkTWDI18FCrVP1RYuufJMeaasCqwJ9vqPDzPKbBedz9Px9cic/Gho/GPBJoVN6bwhAjWJ+9HE6fF04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4784
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
