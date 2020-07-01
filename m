Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF2C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474B820720
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JtxRXDSn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a/E2Cq7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGAVGI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:06:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34928 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGAVGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 17:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593637567; x=1625173567;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HvUzlVZPzwOaT90Sm2WZ/oQTgMUwic1tk7oesUHjyic=;
  b=JtxRXDSn4s24GLvgn0OvHRmi2BFzyDkUfeh5TNYvwfqCWeE7383dhJW1
   hTWHmucpR2hcnFe1331hWpmAi8INxMn57mZonbEozBp+WqEn7P1h4Rwi3
   PTAKDIAWLqth0Ps8S1MF+Uosd6KuK9z4XdB4sK2w5rhxLYSkXzUI01Kc4
   G0XIbrN1NurDY+ItSGll7rbh3op2M7ugZn9RyuG9JNpQagPk+xaQdF4pz
   O7KLZVzdE7l54pcVE+hTeqXwITxNk6W+9MQyBUZU///BAxNKdjJBkDNPw
   L5P96T/EYPY1bISezLK/kZTS+ZnzZaZ61j3S4da4dEi/cG6JPTsEQtibS
   g==;
IronPort-SDR: /oN31sv6dVaYKNFpktROyLxtt3BzE4N1dx/GyOoxOGo2E65rwWfOlrEZXOrJhnT5qDg3iG0bh8
 osusS6ggOQW6ZMzKM/jeNLm0UVp7fOnV79U2weoxUhompuUg69Ir643B9eD9eIBfK/McJBJ1JO
 Qc+81APduKWvxOBVgvXTItDOprmRZa4jEgmgH8KZYqu1UDiFsErSarD/EtPk5X7qayurQYmKcg
 JDr7gKKSB5VmvCsEKwdfkIM0khxtQEzcqSo5Q6TFWpk0b9LuZwlKQ1BUqeeUW03GU+X07mCzd+
 W2U=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; 
   d="scan'208";a="250654112"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 05:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnNoAnECp4R/3EFCueWjIwnlYwymLOZU0D4lln9X63OoRhwWmv8WTy4E7/bxMYVzZc9u788m70l3U9muKCNWJDsgVs7VIV2FneEG+XOzsuTxo66w8BTFnj5GxeYZZfgdq+l+7jQfk9NIPsmQmKLjx0XfnnvjlgXGHcx/nDg4Bfh2dn9PW8q/wseRDu7kgVYdIOLC0EtAW9rF7EGW3ubezs1SVZPfd8UGorjH76ZkH1OZ1X21dmukNng2I7OvEoS9985SEM2EXvbVvOfwIXyvH+7ktES/viaW7cGMH4n8wha8kjfDric4FcssmIUQ+CMFMiIr/e1huz2p9lDJfSSuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsaKuc/GXMketi/kL4gu8h86+ekOGnm9xmxtKuGyRZo=;
 b=aekV5CXlsk2/KEWFvR8uAweAvtJP9TIhgUtJSJaAosEuIdVLpfvOHcCDZuE4cCNQ1fJVcrKfOLargZNWzmmrdR88wcafn3I4raGuL1WR3tEXQfULMLBJzkBOEcS49RBll9bVOibtIMmZkVWFFnvHrRf2vxba0KIbBp+PDLYR70G5oBFbe6dTYBj/8prfZsnRrg6hgTz+laNrvOK5BRLQVAh0ov9r7H4VkeibKfZPFdyuhQX95oSadlod9rD4vtefvn+v4TWH+5xv7SrujHB7kJ/WEzJhmvSF8hgdZOt3K/ENKyQCPeTGiu33Je7f7xs0TWxiKqxPj08e+ZKni6oLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsaKuc/GXMketi/kL4gu8h86+ekOGnm9xmxtKuGyRZo=;
 b=a/E2Cq7Je34P/Q8rjbFbe2+a1Fy9SWKWdMSZMbfFUZ3EGrBIBOY9zgUC8NoRDGlgX03k7t4Pk6Y7MfZl/t0+StOaRsttqEApgGrhxeJT776H0lhdcyM1vvpOGyJpI2pqic2Jjn0N1+UGu7laxWJDoEwyrHj7bC95uGvf73ZVp+g=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4328.namprd04.prod.outlook.com (2603:10b6:a02:ef::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 21:06:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 21:06:04 +0000
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
Date:   Wed, 1 Jul 2020 21:06:03 +0000
Message-ID: <BYAPR04MB4965A856D067354A9CCF4861866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-8-chaitanya.kulkarni@wdc.com>
 <20200630051202.GD27033@lst.de>
 <BYAPR04MB49653ABB3E50A7D034BE8C68866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200701061640.GA28483@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1809be7e-8bc2-48c6-1ef1-08d81e0290c3
x-ms-traffictypediagnostic: BYAPR04MB4328:
x-microsoft-antispam-prvs: <BYAPR04MB432835F788BABE543AEE6872866C0@BYAPR04MB4328.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LUVMOeXABcuwhRQR46O8IrNrXcB0QJM8KfMvvYmlIOBtR4wuTM2ARtLW1OthOP7fSAdZ/7boAROSoQP+KW+n8iv5ek3e+3nvucTMhgjvwZRNadDWoYIathD/FrN2rUYMNx/zepfTLZtJ5rjdVxLaP5VIE5MLnIKVAHde1olnTCxV+wlqmNxLOlPDmrJ8at9E6tEjM0BKfiLEXnIL6bK3kK3ls6TikiJr1HXgtWSSkHM7SqGWXlDq3X1eLKbpSi/OPj6pcXXCBl+N8fYcsu+s9q6PB9tYvmcOKoHs69L9It7pDOLGLq6WExjJ+r7KvutINbLDKnKHif9deYRMf8sa3la8s+Wr+GBJeonpE9xlItrV//YrRhs7R9X4FY264u1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(52536014)(26005)(55016002)(6916009)(7416002)(54906003)(8936002)(33656002)(7696005)(71200400001)(83380400001)(66556008)(8676002)(64756008)(66476007)(66446008)(498600001)(9686003)(2906002)(86362001)(76116006)(53546011)(5660300002)(66946007)(4744005)(6506007)(4326008)(186003)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V/8t/9mTn1PWz1lgd9TG8N/cWbPZhMWq5ZtoDgt+OjxZBa3oCX4c5hiwI98NzyfVltPVIFGWge40q+rkiQeyTp/4U2x/Yy+GN5/VPc0vJB4B7OgLobOpQAVxqc0s8FDsMsEZ++FAqx2tizhnid6iEob3tkL0E9YnnZ53JYXJy2pkOr3/sqpfLdhcknbUw0Scruy8CPorIBrpSPZDBjX3M+lZ4kxANDV2WbXfpEOJyiIT+vWQ8AD0lFiwJg3Qb93i4Z6Jp1Ub0rs/XveVWLMhdiuy9Xy8oAWQsjBZ79F3/YZm/cZwraTKrv03w3H6k6x5nUgLeCxMdISHxAQAYtJ6sLESgYvaJRzPntuYU1VeOfYTkHkdulub2/xqXVOZ17XpK1DFxWsL08NIPXVtsOMvv0s9p/IwjH/PXHRxNgAUn4FaVSgCpFj2FTMiK91UT2QMWoqwEt8vJk3/P6UnTmLz/PRiqvpw5RpmPqtZzaBlknJSB5c9VKvVnkdAac12fGxm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1809be7e-8bc2-48c6-1ef1-08d81e0290c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 21:06:03.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TRhvaw6YKjEc6oN22jOT7QZ/vcZwp7aszPITQJaKFKI25UXAvOPWvHErDYtxKc7xHjTsQrHvwhNCIU9p5FPLMkbALutjjrJXGoHLjZQH6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4328
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 11:16 PM, Christoph Hellwig wrote:=0A=
> On Wed, Jul 01, 2020 at 04:38:06AM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 6/29/20 10:12 PM, Christoph Hellwig wrote:=0A=
>>> On Mon, Jun 29, 2020 at 04:43:10PM -0700, Chaitanya Kulkarni wrote:=0A=
>>>> Now that we have done cleanup we can safely get rid of the=0A=
>>>> blk_trace_request_get_cgid() and replace it with=0A=
>>>> blk_trace_bio_get_cgid().=0A=
>>> To me the helper actually looks useful compared to open coding the=0A=
>>> check in a bunch of callers.=0A=
>>>=0A=
>> The helper adds an additional function call which can be avoided easily=
=0A=
>> since blk_trace_bio_get_cgid() is written nicely, that also maintains=0A=
>> the readability of the code.=0A=
>>=0A=
>> Unless the cost of the function call doesn't matter and readability is=
=0A=
>> not lost can we please not use helper ?=0A=
> I think readability is lost.  I'd much rather drop the q argument=0A=
> from blk_trace_request_get_cgid and keep the helper, as it pretty=0A=
> clearly documents what is done.=0A=
> =0A=
Okay I'll add to V2.=0A=
