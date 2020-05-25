Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5512EC433E1
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340352078B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bdyIgO8H";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HpNgiOA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbgEYJrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 05:47:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8219 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389333AbgEYJrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 05:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590400025; x=1621936025;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=bdyIgO8HyyXI99n9Q6/RBo4VynPdGoYGARDKWD7jp5uLvjItX6apNqm9
   FJOtsPXXKsmW7fS2f0RXMWnshgZq2wNGO2muWUtLBTttXCP1TIPNy1vfs
   60Mp97YayhW8S4Ya1NXQsEhUYqy9G8TTbmqNNIm0Ol3xl3WMB+UTxLZtZ
   B/2QacvCussZ8tG4Km6i3BFkrym1AxebnoAze4Jred/cyQvKOe4ytHg2I
   Ms00NP6YVxylQ53YkQOkxYtbzUtdKv92reG+C98aD+RhD7nEW73Ka/WmI
   IBD04Vp9C3rnF+nze3WHswITHVPtmEMGz0hzjvYnl0NnV3qS7frLXLFmy
   g==;
IronPort-SDR: 2qlRFb1Z2qyJSD3lH/mTR3S934NZgNvqlEQJfRFnoUpmbQlPkRe5XgsrChW46ROystLRZ0mqF3
 R1xDtmSh/gmc1rlntDK6U8ylOurO8bcEXEwBmFsBzEH7rb+qK7hKvAS3dcrjiqLn2dxzANrJl7
 vGQ329rmJqWjvFT/ZHE3POQUbrcTIhuU0DUg/Mlgb+nkMaNxN/ljE1IVVysCVxvZQmN8YEMaO1
 /LN9LC7vlMXCDZgri5nyHZebhxoqCYlaFuOFRPkSBu13c6cVwQEDHPCVo0pgfqDHamVyJI9sEr
 KX4=
X-IronPort-AV: E=Sophos;i="5.73,433,1583164800"; 
   d="scan'208";a="142782517"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2020 17:47:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwhjerKjpjp8OdsZWR5gg4+fXopqTQfoPMJz0FgJ1D3fsg3O5LwDPIlE0EM2u1GudiwqhEkIAqDZ/oL04vcycthJriG1BR7wVj4zH+3AOkp7GXiGyF/kwjuBwYJncQTBgoXwhF2GGq/mjp4FSswxwVI4S3FMLTqApdDDSC9tfyPk+ypP76Q6LzizImL2e510PX+JpLPjP+EWy51RpMcBBQagLhFVoFfuEfPoZ4rRvVjY0CM6GD96sQ5pUHkpsrYfC69sk1eabiYzdUvflHB1eJA92qYMaYaJeFfHUIuWRneV0FQ08DAb1bynpQRsUBxeEYOjus6cND68nKC8FHQypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hZdsIAgomWj0zfNf0nH63Q+DLIIg5OUIlQxbLjYjchbDjUhvrsEBJijA2Wx4cZLfcBMp95TQ+goNHrR8zAAH8pkK2fhsAD+hCJ4XRRq2Qrlj7FRq8Nhs6wV7f2GhibefMxXrdDQph32raM/1dZe17e/EBxrPel5+AdoLsLzCREdGLPW+g8Ejj6Hj3ldi/E05/+9bUie80MSpN/c8LoJeNbrVNWUGthGHkd0RrLZhT/QFWJQGAZ5udOvBqLvvscez3w3Rkj604a6K6THsZTVDUprUq8mBOmQsi7v0KSZZESmUbE7kYJ/iHKiT/gH+pQ3E874qDBWEbqm/oTvOS8BnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HpNgiOA2HfFXDcgxcQ0Lqqj5CL66TtM35aaV+b4WZ/IcjloGpuuvUGe0J4TRI98CP/uE3o19Kj0naJ5yH+d/oW6n016oJi1YBVGEnrRoi5v6AHy+KFQ5o5XMTJYzbkIrNMXmFsVPicS30jz42zJ5gOpNTQhBFU9gYYkAIuiObqc=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3653.namprd04.prod.outlook.com (2603:10b6:4:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 09:47:02 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67%3]) with mapi id 15.20.3021.026; Mon, 25 May 2020
 09:47:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V2 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Thread-Index: AQHWMnhHXgUdwEvoAEKqcwlefxVZJg==
Date:   Mon, 25 May 2020 09:47:02 +0000
Message-ID: <DM5PR0401MB3591E5C8D570ED5E80FD15AA9BB30@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200525093807.805155-1-ming.lei@redhat.com>
 <20200525093807.805155-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4dbb952f-ba2c-4275-a57d-08d800909380
x-ms-traffictypediagnostic: DM5PR0401MB3653:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM5PR0401MB365342CEAB2E08D3176D11469BB30@DM5PR0401MB3653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YazG+Uh8AQA4syWFN/vNzMhYPREvUrxBRAhh4jXAGXHsrtx09wsm67zyo++OD1S+xU3nDTnhNpLUbkexcIXodTafe91sq8I44mr6MudyslKEl/vSTbdKt4Bnr8QgvaGOC2mt0LWem4k0PSRZNmlGhQe+PZPl2glyiAisT6C7Asb+xarSzcxiMr9BQdECszcuJsab795wIhqmwfQXDUoWI6mbYoFL6dRKyLl3xjA2HFy1M3mDSlwX/lHZR5K6u9SRfgnAKMTrELhZ4LlDrXrqmrUuEU3IQ2cY4C3ckXXboxOUpo2PKwTuZi9ecAmSiySQicg5jEZl7j7uHZ+kwU7dTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(110136005)(5660300002)(2906002)(66446008)(54906003)(6506007)(4270600006)(9686003)(26005)(558084003)(8936002)(186003)(52536014)(478600001)(8676002)(7696005)(4326008)(33656002)(66476007)(76116006)(91956017)(66946007)(66556008)(64756008)(55016002)(19618925003)(316002)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cin+eEpTb7gnH2S0VaDldHxXKPd+5p1TuomjyPgu27HAXpNaeQN4MJorp3Nh1WvqDjyayHHWfmRfZNmjRjQqNTph8f5sXQ6ACGfWvvj93R8isZSaLuNGmsWJ38p+I5IMY12WtE3+psZBEQ9JXE8RjwsTuBJ8TC+SGqfzPvKQ6m/Ar6/bB6iloJqna9uMu6LU205kKqYMET6Oeq3WfXjq+B4VLlysP902XAnTJ1+DtMoZtyNXIRD6SxZh9aKeq+T7rIq5DUkRGrgMyWUmLyPK1Qvc5o5uiyB4mm6zMoK3g43bBYh0PgShsnexkL3LZwgZ3GP+bexr7fxh00WfcInrmujXeLsdNQPB1tU4AxThDX7lc1UWpaMHIlL+YVI/dDuTLgVhN4xkBK4M1Bj2dZL6CMoX70sPgnnz+CVwOzMfOribtt18Fdufj79dgNffYeST5zz8oFtrC12TEhPtz5nyG6B/QlN5Q972sUT0UhWUezZUhjwf7iJDmAsbzE/SkaCK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb952f-ba2c-4275-a57d-08d800909380
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 09:47:02.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLSW5Up7L1OQBeSojcvc+72aOHoXxyf8k8Yw4wSeizJ5FvV4jK+BtZVyEPvH681AJjUb62miY207dCNFG2t3by4Oj036QCSJcTP/gUGuSj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3653
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
