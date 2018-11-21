Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E495C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D360E20878
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iCv+iRpq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c1pLeTHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D360E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeKUNJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:09:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51634 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeKUNJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 08:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542767885; x=1574303885;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gJfpkdm9/U5DpRpu/uQDvtwHYxX+rJNegpSocIj45d8=;
  b=iCv+iRpq8tvcrzLBPB87/wUfQ6luL07oOLSjYPbuEI/1ZjpYMEiQ3H23
   BtcbA0eC73RwwEQ/4E1aOwgM4Ukl88f3vXa5Frbl84DZYWbMiHbisW+cu
   754LEON2MYzPMoWFsOGzy2zdQHt1ih9OvSIR3MmvxlW7qVCwqr1hV8ger
   Imsw8Mf6daxls8Qg1uch5UXhWtScuPdTirBNBsJuwn+e0pBGgQYa+O64o
   QiVbgKQxJpeJ5MBYGOBUb6nPJquiOPb3qnob1jGoELzsOnNrJSyDD1wc0
   Y/RMzBFS/qWUoP8sj8cgtsEEmoXzR4BPhfxdD8xKeTFNg4aGaY89HF5s6
   w==;
X-IronPort-AV: E=Sophos;i="5.56,259,1539619200"; 
   d="scan'208";a="192555874"
Received: from mail-bl2nam02lp0082.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.82])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 10:38:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPNi9N0eEXpnaWmmLjYHvPpphIBvcGuKaX29GIrqWJU=;
 b=c1pLeTHlgygaJq9PQ9/QkZu57CYr5JbBCO6SygEzLx1bwEbvwVMdu9umwJ4B5gHNbYglih9VbidC1eaer1ouNOOJN8t9Q0punagaOjv2BsDhNbcB+lpPc2vWgzompVlEYdy1/zX1mC7BYZDP4agHkZwKcaI0NDw6iIXXc1DS9Lc=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1512.namprd04.prod.outlook.com (10.163.38.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Wed, 21 Nov 2018 02:37:29 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 02:37:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: RFC: REQ_PRIO use
Thread-Topic: RFC: REQ_PRIO use
Thread-Index: AQHUgJdc+B28J8KGhUuvN21lz39tNA==
Date:   Wed, 21 Nov 2018 02:37:28 +0000
Message-ID: <BN3PR0401MB16403A8178DCF6FD0E45BBCBE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <BN3PR0401MB1640F33FA8F3FFF251DF8266E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181120093907.GA32682@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1512;6:tPXb1JIshyblFmd7IDPMUUvLAwRvYixWsCptlLf2WtJrjph8jW3B/rnEYKJdhZhQRQ/wGWYmL2N+7RiL//BNL2zkMz+eJmh8/tJWUAsh/xEFs0NJmmCWFgG985WoMb762U9JTOvS0K/DdH53ysQjmtXP2IJaRxCr7dROFiTTwDSqISKNx/zNMqgKpWgBxZYLfmZ9aELDzfEZHHWPcZGn1vwCfI5LW5mf+6rg/laMqo+0lxs7pIBNxMnkEg8EtPrXZkBMUYkqALQaXRed6ta0NVYOLvH/sOxA9+MWkvnMn0N4wgYxgMaVAgQcuX7xaJ2E9fW7fxD/VPrKqJZla3s/qN/3CJjfx/oghx/6ZjYy9nSkM2m4aBJK13ZPYxARGezmT78B4D9wyQljK597XZpXieHBVaQ85GHkb/fjfaqgjl1/TP+OlujLDeqFd5rlhWNGYjs2FTUBpxX1zWGwovBz6g==;5:laXSHkXY8KjmTNwhv4WPbtNqkrsScQXSXmQa0e0cQoWhvf458Wgs+nZbbyCDveNcyFUKNAlLKRfSXuAFu51Hg+KJK84PSnf6x89z6pg8dXkM1BQz6w35lLiXU7Q6JZjoBr93FIBVSTpudluuVm8oFXWg6fsKNLLohBfW0dJnxAY=;7:QLcrb6n22KwMsO+mRWMQn2boQq0Sva/l7zKD8yxSEDBqXPCIUuKIQY36uhUzUbKwgfRj8hnHtAKmyyHx6hwJcHKxbiymmfM2kmD0wU7YGkFrC9m8+YeIlYTyHOwhmeIDAqDP2b5RVW6I70DRenVb8Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 61295379-500e-4626-e128-08d64f5a47c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1512;
x-ms-traffictypediagnostic: BN3PR0401MB1512:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1512FAF077A0D7528056C3E1E7DA0@BN3PR0401MB1512.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1512;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1512;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(7736002)(55016002)(8936002)(5660300001)(8676002)(71200400001)(4326008)(71190400001)(97736004)(53936002)(14454004)(54906003)(9686003)(81156014)(81166006)(6916009)(6116002)(316002)(3846002)(68736007)(6246003)(2900100001)(2906002)(14444005)(256004)(102836004)(186003)(99286004)(446003)(6436002)(66066001)(26005)(486006)(72206003)(25786009)(229853002)(476003)(86362001)(74316002)(33656002)(7696005)(305945005)(76176011)(106356001)(478600001)(6506007)(105586002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1512;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5WY9jK5c+sHyWCw/iiUu86apq3qPl3iMBGM4eZn6g4pH9sPBvd7RA7Jx9c8mMVdgIMOdLQ6EexRRgnOLm5i5HQKnii3pcqBnDfZXFDjXUHCmmB/c2ncVz1Eo4w1J2ZQfbAmDYiEzvSV0OzC2rWhQhoHx2TiPFIJzZkhL6JMJxhyJd1TwOk3mYBYHrZePImDxINmQ4OFcEVkdCdtpKJuv5VFEfptIP3QKCqWtOqf9iiZDrxdNDQnjOl1sj81Q0zHYHzsswvzqC6WdbPznsEQn8yCoyj5M3a/Gqh+xZ/lAP48kOb91ihsKJP5tghuGFW1BThoJ60Kqnv03ZnGi9q5JEhTP0Li3eSe7QG885D/JA3A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61295379-500e-4626-e128-08d64f5a47c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 02:37:28.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1512
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/20 18:39, Christoph Hellwig wrote:=0A=
> We have two places that check the flag, the writeback tracking=0A=
> code:=0A=
> =0A=
> block/blk-wbt.c:#define REQ_HIPRIO      (REQ_SYNC | REQ_META | REQ_PRIO)=
=0A=
> block/blk-wbt.c:        if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || c=
urrent_is_kswapd())=0A=
> =0A=
> and bcache:=0A=
> =0A=
> drivers/md/bcache/request.c:        !(bio->bi_opf & REQ_PRIO))=0A=
> drivers/md/bcache/request.c:        !(bio->bi_opf & REQ_PRIO) &&=0A=
> =0A=
> the original idea was that not all I/O is a priority we should not=0A=
> blindly boost priority for metadata.  Of course wbt actually ignores=0A=
> and it and we may just give in and just check REQ_META, except for=0A=
> the fact that f2fs now actually submits REQ_PRIO requests without=0A=
> REQ_META..=0A=
=0A=
OK. I will dig further.=0A=
=0A=
But the fact remains that with 4.21, the actual priority boost is gone with=
 cfq=0A=
removal. bfq, mq-deadline or kyber should add support. Or should the priori=
ty=0A=
boosting be done with generic code before the BIO is passed to the schedule=
r ?=0A=
That would also cover for the no scheduler case ("none") and allow propagat=
ing=0A=
an effective ioprio down to the device if the device driver has that featur=
e=0A=
enabled.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
