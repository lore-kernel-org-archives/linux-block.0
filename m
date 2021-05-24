Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB79C47082
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 02:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738BD610A2
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 02:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhEXCZu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 May 2021 22:25:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4333 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhEXCZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 May 2021 22:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621823061; x=1653359061;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5PPYZOazFMsO4X9XSFPpipzpqHjRRb2jEgZnz0JQMNI=;
  b=KU0ca25saOT3OtIjsuP7exu29rY8FIyO8aUJu0ytgNkg1CUJWYsoRH1/
   wMz3u2zGF3fsJZ6qt7BkZ3U0SNW1m3gvBT6M9A73vCROPDAL58QUQkkoB
   tFjh0SrVqlPlhx7YcKuj9PUQ4sgCwAFJEo5lItpXqmw09JNue8PsHrDNb
   WazplL1LsIWf5lfw6Oy+ICeR0rHVzY/zw2jVt1MV+7WEabQVuoWpoOb0e
   IWiJb8kQB8C/SL+c3BpCdSpY0h4wkcIPVok689RquyVl0qIdZCX/j1pj9
   LRSDSKOI3x87HESsxksM23VGlpyoh93UZps+GYtDXYomTEWw6yPel9Nvw
   A==;
IronPort-SDR: UFsgXD/dhLji9XFXa62/6iNJYjUcfd8VA4ncbSYFY5IhNAh3jcjkNJufPaOUnaK5fd/dBuWz+p
 3l9kahKrzqQDhgZOfVLMe3xVTGRA0B3Wepnd3iIiuct8pcExPNZIAF4YivQLFsPXu63xqH2kJa
 fJoRd46vzd/FKqva8uQRqG7w5sY6OsTu0Z/yXiJhC0xl7Wx+rB8zxra3GmegoUuWFDPRx4WLqU
 nVve7KpWGn8reLzZbvyElt6pZDLKMUgGy0c09JRj8puKNBqZocRNH/+6IcXik8zflWnJIDMT74
 5AE=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="169192655"
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2021 10:24:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMr3fCkmKA8CipC6i7OgE4O785LVxis4A0jGgTtkrG+E9S+zPgUjbqh/VZUD8nWZLDRtEM0lFvBKA2xKdE9qzJO4JDNwQaRFYv02lyf03EAJvQGfrfWTPkpPkP2OmZBYRkJDfgyAP8nSGhIVnBxpdXo4Y45XxUHSCC27I0jEj2PfsrWjvVskVZ8bl952WYT5GC5l9NquyqEDevvbSRUM4Cm0gYXnWvPdzfXND4kztc552qeRfI67sJM5WeoxToEvSrDYryaj8HGaFJoR7jLCyt1fzuDErsDot6L9JQL6ue/5zjXvw5G7WhmAn/g6V3ZYqftg8EBunV2f/+RYb6Uhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PPYZOazFMsO4X9XSFPpipzpqHjRRb2jEgZnz0JQMNI=;
 b=Tf5y1CZOd6Je7LmD/TjfQ4JeYgEDidcZtB4ICRv3ruQ9gXnh/iiIRkE4XBekUlh6q35iKk/PvHr72ZC1w6DS+JNDJ5M2mEghreUp9Tkrfoxn++Z9jkxHrWH6qzmgEoKyysoVZ4krOKaDwzsAiV6YRImfV1k+QHxzAnQUsLotXAy9mo6WLcNogSKFUHrKUsFxbuTrL/RQh/8ZvMhfh/I+TKcvIlB0HTg3VK96TMrGBvS8CY52DswAGkv7etFSgNHMxh0YiJmg1PiMHl/fhiTiWLab4i5bWvECCp+ONUwr0zAE+r867ZD9lNP9rQHJSfLZ6hiFcy12MfBZ6j90kQiD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PPYZOazFMsO4X9XSFPpipzpqHjRRb2jEgZnz0JQMNI=;
 b=vgNUEi9BcNXw03NclX3XzxF2KBOB4Rvecaop1x78WoW4AnFp4JrEzkgnEE+cXq8BKBDiq7el06G3+T9SHY1BvluIv5xNZH1INZmbVq0b9LuWWADOCZf11bL29oKjgyz5TAi1aWbuwcdE9rAg1KZNMkkEvQI+/LYzWf9aA25Efk8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4229.namprd04.prod.outlook.com (2603:10b6:a02:f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 02:24:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 02:24:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 02/11] block: introduce bio zone helpers
Thread-Topic: [PATCH v3 02/11] block: introduce bio zone helpers
Thread-Index: AQHXTe2ZdAaik0/e4kW8jP+09NcdqQ==
Date:   Mon, 24 May 2021 02:24:20 +0000
Message-ID: <BYAPR04MB496504DBE8E0F02036EF581A86269@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9ed4127-b97b-42ea-41c8-08d91e5b09a0
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB42297779B563B39D3248E42986269@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8ub8lq7nUXo2n15+0g2/utfmre9hNpgg2fZazsO4IIjp/TaQVz9/i7YnGQj5gCyqFg+oMaLojJ1ign8EdCcV5hJAbW1JO7hx4bzCP05s/cIgVNlANWWhevcp8+51ii+XR8pDgdReR416ltZxBTPeF5f6DjdvQDuTfJXqn+MxkuHaAzf0OrhskuOjnnWJHEVHB4fCJmWWeafyibsCZgJPxlEFI8ZrTRMWNdoQgL1adQcTKus05BEWJbhUtjR9dzaE9hPAShoKJ/E+mv+RhPiOYaJib0TMTADKoj578vKwnmXJMNWPe/l4KK0fn3j+egqVvSMBXfLX2mapmX5MqasWxkPt/xo3QGyON0/HF8Tgr7O/Jmwa5Tf6aRltiEnqlXQbJBA9+UfklX27sA3RzQig8EdL3I7cr8HN4sImgBSIgAnE4a+3tfCc62To8ZFaJN0iJrf6IXtlWLxIwTGdLqqlxMDQjKNQp1mCOCN4iOno+AdMW5OiiZoIkbTNtENvc1sCnuRi12xbabDfWXTktYsB7KMr+tqPADbnYqcEoPW/yA39zrJNLfV7S/LMhUrm3DgHDpf/uKhtHY2sv475Q+dTPe8SxZMvsYS38RogCyPoDM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6506007)(53546011)(83380400001)(55016002)(110136005)(186003)(8936002)(8676002)(478600001)(316002)(66556008)(52536014)(86362001)(26005)(7696005)(71200400001)(33656002)(76116006)(66946007)(66476007)(64756008)(66446008)(5660300002)(38100700002)(4744005)(9686003)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ca7fZ9is1J1BzuxOixi6YhnSB3immSzQXGLPLRkkXy0Xx+4s0mwN4FK5D8uf?=
 =?us-ascii?Q?XgMCSZ7Zu9D29lubnqmWdajAOJg9mJt1YmQCAHPABTL0KNHn9rrwzbg8E36a?=
 =?us-ascii?Q?Arvcu2uifPgai2PJqjxix+el7rmmj7/bjp4ahtG2yexOTV6vuCygw60Yg0ku?=
 =?us-ascii?Q?nIFqrko+gdOIy3xUr710Ubyu13QasrD1PLWXi6z4MrCLWqVMhSRQ5bSju2cg?=
 =?us-ascii?Q?ojrzNv+EA7WAs+KusLMTTCs/BNdBQI1e/17m8DWn9UPJTGMVCsvaqQ+66rgT?=
 =?us-ascii?Q?gVraahOAuvnQMXAw0Hz/Onick/AbCQGDZ65YQ6IrUv1/teWpGGBZ52ZQxaRc?=
 =?us-ascii?Q?Zq74BBTupMh85aDhxZlMpM0v+fNSYxQv00jpwOQ5dc4oFAI6z6J8xzvvlLJV?=
 =?us-ascii?Q?dS9vgMLSJxoHzqxsLe7NgBa+BQEH08M9yeK+2GuljgDdjUP1guEj4YFbXLWz?=
 =?us-ascii?Q?QGKIXEq5B91Llx7TiC+pMxc1j45R2jDRUWenqvYuWw0OGvLPkczZQahVUtIo?=
 =?us-ascii?Q?FDvbMx7+6tZvbMvqLD2e7+566nt8HTcqgmfOVPv0N82dAIzQ13Li15gBekno?=
 =?us-ascii?Q?otk44/nVHIx43u6VQB0ETAPwJyUj6xIJFf71KVoPUzv/XNWy62OUFqhTxGCB?=
 =?us-ascii?Q?SVrQebwOtQKglXlUBsJ4HQGgxV2ReOEmMePEC6MoyPEEU/qLjuYDhUNNXPSG?=
 =?us-ascii?Q?/y3Lhbg1AK22dGBQuAkqoqs1cCgo4vkFtLWDUZMIDy/HqgkYF+6hRRUQ6mFk?=
 =?us-ascii?Q?EoPYJJejKbTJ4xRUk28A++REXYQTO7b3vE4VDJMVBEzeQRLkDsLIXCmQ8mg0?=
 =?us-ascii?Q?l15/lVykns/M15MQZgc4eHUXr9NW56mTP6ucTqOycKox3pX5LRrMdgV7+AZz?=
 =?us-ascii?Q?fVjSBS+DefhVldZu8ew6lzpl5n1EIQk3jcUF+v/VRpW67A6bYh9z9ZBD69Q/?=
 =?us-ascii?Q?g1WCaEM1WeP4qSsWWhY6wPnW7wi9DRssrVTL3zV9QCXgKzXaQm/xWuQSrIUh?=
 =?us-ascii?Q?ZIXTjLdI8dpoHniIsqZzuzpKPJfLb8gIeaEuSKXzFXYWkPxhRVNTM/bFz/I2?=
 =?us-ascii?Q?5DQNIsRwCwVQcbqJB1Bd02cEaxVYepU4HdbTOAl3R2+ZOFcXMhXcnNDKMIUZ?=
 =?us-ascii?Q?iSG5JFWxlj9DEMwTV98YRy6gS+ljlu7KOdiYACGPDXc2U6Y9pAtJnoDOB6B6?=
 =?us-ascii?Q?uwqarW+mIlMdT4MfesVX1fBUXtdhXjofi408f6vtp6cyJMEjfXu2IH9zAMFG?=
 =?us-ascii?Q?X97hgs9ekqNeTJOncklHDx763IZdzgBjI19OqCnuAY4Tq7ZYRkdP9/euqTr6?=
 =?us-ascii?Q?4Puj+FfwiVrdGYx6evscJJXp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ed4127-b97b-42ea-41c8-08d91e5b09a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 02:24:20.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etwNGiW4nWB4+D2p6mTpNz36//zo1KOs+ITE2W7RKoOwzNaaFa5FNgf7/+87P7aUuuxq+IStAQVuyEb1zxqSijwR863oUWXDZ7gT8HVFQp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 20:01, Damien Le Moal wrote:=0A=
> Introduce the helper functions bio_zone_no() and bio_zone_is_seq().=0A=
> Both are the BIO counterparts of the request helpers blk_rq_zone_no()=0A=
> and blk_rq_zone_is_seq(), respectively returning the number of the=0A=
> target zone of a bio and true if the BIO target zone is sequential.=0A=
>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
