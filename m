Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0653DC433E1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FBF2073E
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KSlktR3W";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BO1bb54x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGAEiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:38:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18544 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593578290; x=1625114290;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pEztHDNZ7IfrnL8HMTWcnHqJbzRRClvWFT+TGDrS15M=;
  b=KSlktR3WfwL3+1u7qWYE7qO93jzx2SS/v11X+tuck/6w0XaIY3R8SEeJ
   c7LbMSmnjByg2PZP7YSGmtY4syq8PWhEzLZ1VVbkRqIHgkMIl+HLL1kMf
   G+3q9amwTneP2/7EYb9OCvRHhjqUjYs2IvTLPsEUtYey0aaCA4SHdodEF
   Dfq4p5uF7OTs4q6ISVXYildtG2qBZIg5zknBJrvDEX5mYyrKyHuRLk/rh
   JVULBb2DTHQQ+TBsMVmhOr5vmRVWpuGYaDBXEP4yRFq/0twfYkCR9LwRd
   lKiGkcNcLo6gbojlPo3/mLKH2mwx9n8Q9ozo67YyAC7moRiSvSgMsMEwn
   w==;
IronPort-SDR: axc3RkBYRAg3TJB/tMWWDX8O4E4+lMZp5qYDKOIf4HkyXO/JyoOSf/uKY0bJqZQ0Sm7sewJ1Id
 u+N1i4Lcsley+zYyQROiYxRtRKwqEEBIa3bdgQ5Dp6kG0kIxL/h0Vy9Ic6O6log128NCAtsrZ6
 ctbhIIzosFtc2+rmiijsXEZNba8ykEAIoiRmN6/BOLCgaYBPOunel5Es8cdWvTSK63H1ZkV2/X
 F9YWlcg9VtSsev3oLvQmuSb/gucKDbrZbsEjOgIpUHCOSLSxyr/UosIjwO6kQUvNnzHgZyXyMf
 owI=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141341370"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:38:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRBQfzVHZh6SWXwTI4nnhRcXxLSaWiMuw8N4b+l/AKQHZ0p+vrMf5cyF5Lb6ODi6LnqKKspz0JHMKDc0iBV5aXXzQl6b2HROp++LMpEjEJgL8rM3y0KU+J2nQcPqach5nNUsacBZNqxRom2SaGyTpqTIblh1wEoQNJJbjlFHSfO7fILcV32T6ubn+EmEvVlKl2OlCLVCzJgvDl8ceVKQO2fRS/TcoHv+abskOw7MajOgdXG+8XPk0PDihX0sQdM2NCofrdNQI7algZ+wLonobSYBJ6YIgjd6WtvAFZNMbsM0RJqafPm2oQZ6USNvQftBOf/C6nk0dBM7mgDcY9bQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEztHDNZ7IfrnL8HMTWcnHqJbzRRClvWFT+TGDrS15M=;
 b=QHDgikDSlI0JbGKyWqzj439veNjdcOpPPrN7vR4AQHfjugIIobjiJHvwA5g18v9iAdOhBpGYRdcnV7gne7QXpbzPakrCk6bXAxBCo1ypY000bDI/8YyGKgGJfAl4vKAlb3RwVG/ZjKXloJRhnnCUMkgFPC5LpWU2uqC6rF3AnGcD+Yzx0HBHD3ntfm9X+qvjYrtpjis96o8a/L2FbL9op5+9DuObJTQVJNToM1dnwzQ5/onfqEYWHdzFvsPUWBUC1lPifKeLyRqPD8/QCWGH561Mry+1to6cdfpmQDv72lFlw4/o884iWe3WqVPObyTiklgsVDPk1+XOL2aqhzdgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEztHDNZ7IfrnL8HMTWcnHqJbzRRClvWFT+TGDrS15M=;
 b=BO1bb54xi7kKADPwqqtdEDTvz+AYejAjQDrtWymqR6ZFxw6HVEUqda1P09mgInu2/5Z5hgouwleXujmmoLn75tn6m1li5ph/7iOX9TP0Gf9t16Y9yOsoN8mLUzzN+wmXfvxrSUkYo8P8DA1Es2nDCnK6YP5aqTM06oF6mfnOrxM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 04:38:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 04:38:06 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "jack@suse.czi" <jack@suse.czi>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "fangguoju@gmail.com" <fangguoju@gmail.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCH 07/11] block: get rid of blk_trace_request_get_cgid()
Thread-Topic: [PATCH 07/11] block: get rid of blk_trace_request_get_cgid()
Thread-Index: AQHWTm84FlMKKV+6yUGdr+czU/8ecQ==
Date:   Wed, 1 Jul 2020 04:38:06 +0000
Message-ID: <BYAPR04MB49653ABB3E50A7D034BE8C68866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-8-chaitanya.kulkarni@wdc.com>
 <20200630051202.GD27033@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb0e34fc-76a2-407e-8989-08d81d788cb0
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124ECA0F5D878AE7F8D14CF866C0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DyuroORz/6UFiqWUMbVDWCBGHMIluHUZeOCIp6HXGuPIZxAYmbTQltUBUhLLl0JOLlSOc3yjjxlcpRxiFvCfuV57iRplDvBV2QyOe+89rNbyQ4z15IHbrR19tND3sKgYyO3b1wpU7w9YWBTwkdCJcOHtMMw1Y+8UdLLuDY/TtzZQ7CngJCziqOdTNkCAgJ/M/UuPkc9+WQWS7ccVZBuAPnHdn8qh57T3XEsjoQRzYv5nMb0/svqsAK4svZ+1TQEolD1ZtOyggNwmVCZMMGT4vbwHqwgPXzdMxC3zsCxTsUwrW+mI/yjyz0vcM/WYSKs2pISKUdSG/rnQ8SgMKO8mKbdtXtelu+llfkZh9+hfKEChlemNde3t35XiPN0w+p7d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(8676002)(316002)(53546011)(186003)(4326008)(26005)(6916009)(71200400001)(54906003)(52536014)(33656002)(4744005)(83380400001)(5660300002)(8936002)(76116006)(86362001)(64756008)(66446008)(66556008)(478600001)(66476007)(7416002)(55016002)(7696005)(66946007)(9686003)(2906002)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: c/d2wqIC+ahUcniLnB7gLJRZ2vvBqzCVbFfN6/aKswZJJwLvhQjC3bRHKTVdxqj1Y17ysOZqW1asgSg+kbB0fqC628GOw0xbZ9GmYS7QkYhjuwJJBSCNZm5kJj49uiWO0xXUWxCWSr8zfJz/pwC9h7JVzNuLE/OJtyjERChHlmaIT+qhlHmrgwKK/CcYlvV9p/EcgwfPQxhfNs2Z0ScVMoWDvJ3QWr3JdI/m2gt7uXkqEwNY98LiGUOPTQMDq5zI3sxXUGt5J5J0qetijJVMVXQEiwQRLqu/mBf6RXoEaYtb+7OAEHETjd1SKrmMFlR9IKxpiApAPqYvU7d6L8Res/e1/ZJ8CDZgY3QG1wicWPJHXFNZVrQ4oXpdjFvkNtCU4IFfFCMUCZMRUqwIq2gZrqYaC6LujxGqcBK3JnlwybzZfKe6O/sEut2seY5qv8OwajQuKDEsgp1B+5Qk3YKt9CjbL7yaqAkzM90CJKydrzM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e34fc-76a2-407e-8989-08d81d788cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 04:38:06.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjyUwGRBhv2hyeLFnhp7KBoRVZes+OAc69JvVduHnV0L9kRgOUHl2nZMTjYiyFgIOvfl7Q7ID6id3GSPgD+kZ7CUsEV+fsz4zcT75OZOueo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:12 PM, Christoph Hellwig wrote:=0A=
> On Mon, Jun 29, 2020 at 04:43:10PM -0700, Chaitanya Kulkarni wrote:=0A=
>> Now that we have done cleanup we can safely get rid of the=0A=
>> blk_trace_request_get_cgid() and replace it with=0A=
>> blk_trace_bio_get_cgid().=0A=
> To me the helper actually looks useful compared to open coding the=0A=
> check in a bunch of callers.=0A=
> =0A=
=0A=
The helper adds an additional function call which can be avoided easily=0A=
since blk_trace_bio_get_cgid() is written nicely, that also maintains=0A=
the readability of the code.=0A=
=0A=
Unless the cost of the function call doesn't matter and readability is=0A=
not lost can we please not use helper ?=0A=
