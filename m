Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DC6C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273132078D
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 12:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iEq/j7RP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nPvS1WIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgINMsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 08:48:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56364 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgINMra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 08:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600087649; x=1631623649;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ivaq7BJKAEKJVo2vhkObHCZAIhDESrz6dChJLXbGQW4=;
  b=iEq/j7RPYoFdauzEJoxcaUevt7oRqnFGU/KjCt634RVc3vy7QIygRsTn
   1PQyPKfTOt5kr/Vhrtx0fwNxflxkydeT/LCoKuxse7WS/915cuNzWUp7b
   T0vQZ3/NrTn9B0iNW3n2BDYUvGP5xgHo+12bNN293SgEHzKhYp1BX0AjY
   d1EN18It9PSJVVVTSdqAtxlxSbDpNCb55xXH93NQxCKaujp1dXNZPxWtq
   b8lDuiMvScnY36StF6/VFUPHnJxoTg8iEO3Vhl1FBnis3rjyJ9wcpQ6/D
   /lRNpwFvHByuzvu+npizbeiZeAZg+X7p/lR3h3kmVG7VThVR6hti3tZ1q
   g==;
IronPort-SDR: dAv9M8AEsxdrtppcSDrO0MmTjJK1j+ev1hA+AonyAU+DQrntFYmKxbPULJo1TuVRrE03kWri3F
 vHCLNJb103t3EvFX3RSBb5oIkazCu9qKt2bbZ3qiLkCDHKViOM00Af1jAC2Ea0uRGYBgF0U1dG
 QSYb+45TlvIAH14eMCA7dE9rttbfVgBvjn91M5Oy0Q+vyMng2wDDYBsxFMXEr217d0pQasTkAv
 k2ervsbWsvjrzfijB32o6CcQkURhzyg5MzRROovgeymEDxWvt6ICgsnLi+s7vf9Kb1r8lHvTP/
 lL0=
X-IronPort-AV: E=Sophos;i="5.76,426,1592841600"; 
   d="scan'208";a="147310764"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 20:47:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE3wSNZEiPSuJPBZ1+al+yl3tR+kllcshqbMvot080BqNf/NJ42CABUcmmK77CLEUV55Ly2F13ge+FiXrW0AaJVOIzjj6YBDpLdaQnplXuCoLYnTPyBUsk/laiJW/sLuZ7vWfeFn//CoqVcO2+QoELoazr14/morgufOfLKSjGVJVynNEMRJEHJwjjj2RaW88oEBeZsmshe/V9i8hINGNGNhGpZVEjTSuWHETjTYjyyFJ0cezJyJ7xgV+lh32tRwezoERgl56cn8SpSnGv+gvcJy50oTE2omdWRAVR+7Nex/pbAdmHXzqNaX2RQUJ6DjOuwMM8Xq7BVLja/9cOUD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDJLgW3Vrxya2D2B0Hcdgs5mVBHqmQX/5iBnkcUejoc=;
 b=PJE+5VwxyPKmu8lv73jIAv1vkpTI6OpSmYrxDab3PJXKvq6fSNPkmq13fImM40sPRpp31QDYIfb/Rb5XAlz824d3Zi45Jp/4GTn0b/1KbucbC7H48kbkDyWGmkur1SWY9opPdR9FY7Yi5/ix5GFrOS5Vhgo0KdnP2triSTWJ1Ne8JAAD7upVP8f28/qeJRny6CbaMN+ZuKdH4nFxyedxBvY8bSpsu0tybPXLeEihoXv7yAQTSNpQA/gmM4uniffeFtGbUXWqb0KrfMUsDq8fvD3oRWPD0RRvhxpmpo8xM1BHDTDj2+FUpUvrRZ6bcQ6kAmvrg57plpWoNwhvhJAKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDJLgW3Vrxya2D2B0Hcdgs5mVBHqmQX/5iBnkcUejoc=;
 b=nPvS1WIPPE2X2O8D3CwMkJPIP0Ps4XoBFc3guQ0rdtFjAI6VqQEVUzIcKX2/94IzkHqOsXFI47/l/jZHeV/sDH9c6JZHkidnpwz/EJ4By1Dj3rzvqEQclsJiAOiG60oBCrH/MmEwAtNz1BE92wco3I9fe3XU6Jzvyp2sbdIRmcA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4320.namprd04.prod.outlook.com
 (2603:10b6:805:3c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 12:47:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 12:47:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 2/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Thread-Topic: [PATCH V6 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Thread-Index: AQHWijwEJUckeADzkUGX8PRnU8hvvA==
Date:   Mon, 14 Sep 2020 12:47:20 +0000
Message-ID: <SN4PR0401MB3598FF471CCFE9E6841E2F909B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200914020827.337615-1-ming.lei@redhat.com>
 <20200914020827.337615-3-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1af3f61-528c-464c-804d-08d858ac51b9
x-ms-traffictypediagnostic: SN6PR04MB4320:
x-microsoft-antispam-prvs: <SN6PR04MB4320CD3DD3CB06A2481CB5FF9B230@SN6PR04MB4320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9IPE3qpjIVQrHDXFk0BXYg0+VMo6Fr4oT9vuJ/oHPU3UNgUVSFAySIkgj7woc5F+N4a9XSn8ryn/CY4A8omCITBlYl8ykJG0LdJXGX3lDyUxtsTHPbeeXpa62eqMoEnegV+MDgCEi+36XdEwFw0CpRFfGZxEs/2NMTTvFTcTkQ0K4mjNNpzQ/5hGC5k85FFQZY/+O1nzUIBP98c8Gf2nsBt0wrHKQGzhrFEaH/0xr7lK51gg4x35LAsb4VQiGb5kYynkPTUASPAqb9R7thOiCnLsgiml+rMRAqaPGSIJpe3KwXYjLOyXOpXhtUPq4S4+oQtzPdUyG/KYWVVzL4OqVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(71200400001)(4744005)(52536014)(508600001)(83380400001)(8676002)(8936002)(5660300002)(33656002)(9686003)(55016002)(66476007)(66556008)(64756008)(66446008)(6506007)(186003)(2906002)(54906003)(53546011)(91956017)(76116006)(7696005)(4326008)(66946007)(110136005)(316002)(7416002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AyYufiAr8xny0uy9wQpCsS7ri9RhkdsDxCppm0ywp3txP3agGLt1MdNR4W2KS0Dybkj0hJ2gldnknbR/PRxPj/LSpU34YMjNWsl4hUTRVtWA1x1K6AYRKcXYfTFmzl0Njd3nlU+SUIFlITuvzHe1I3CmJRfjMLYXb71VC/JEHhF5CY1xk5JgqSdld/JgIv76IGRmgjrxNUEx48JfUFRLHzsPeJ6KWHokWsXKdxkqUmkNqrydSOnzztl2/UMvuDToyHE/ribr5KfQLNJQh4D2EWhf7k+bt0tL77W9RmAwFq5qK42YAh2jGWuUSStOe1lgZ22ENZyg272NRbsYLja3fgJJTN8zJhSWcFR4xU+wSvjRFEr1w27OQaGXxxlo0ukDHiP6Za6yK52jxotql4Ds69WF50nfwBkX3vvo8vWJngVHksX2DeJNLtCTb2TA2T+BtxDQoeoeMv/HTepkpviU8VGGy2n/bgReNVD5r17oJwnJeITA1x8CWO+BbQ/wmC4RIfaePmcjNrb8EkwX9cRFMAY8k2XFNcOlqdSJ51htBlW+soaHBbjmwqoNiSuWLBVS7FNZFlHvBCuLld5exyhSEdBiEPRb7fZjTK+aPWVIrNbZv2MGMtYAuAme78r4/IGcjkXkAPLzS2xDGSieDPCPp5hJuM+opAlbhZ/SBfhFlO3HBUb2s7vLlp/UUcVuU3eGcKPcMPvuJxg19GOi3C47WQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af3f61-528c-464c-804d-08d858ac51b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 12:47:20.0266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+61lmcckpVw7JhZBWEAsE/7XT9+HMi9XqQT72JyFeTusk0ZYjHtC7Aj8nCCTNlJwA4V3OAXDmVnjMA5Jt7LZGO2a7vdEQoDeWohd0u2KWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4320
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/09/2020 04:09, Ming Lei wrote:=0A=
>  void blk_mq_unquiesce_queue(struct request_queue *q)=0A=
>  {=0A=
> -	blk_queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q);=0A=
> +	if (blk_queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q)) {=0A=
> +		if (q->tag_set->flags & BLK_MQ_F_BLOCKING)=0A=
> +			percpu_ref_resurrect(&q->dispatch_counter);=0A=
> +	}=0A=
=0A=
Ah ok, here we do.=0A=
