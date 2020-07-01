Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA6C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC1F20720
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CVP5lsQh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="esFf9sqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGAVGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:06:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34994 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgGAVGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 17:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593637606; x=1625173606;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SH3dpQ4UPJCkO2R/EtJBYYVnfFdcD38M+VbPmFqIe18=;
  b=CVP5lsQh0AHcK0cvzPRhVP3+qo7ul9K4BCumg2xxCXi5mpNpHRd6XjN0
   GPN5vXqcCn5ZiqsJZrnF+WdeKJteydcBIWYkr9Jg1hVqZl2uVMwhrtqJI
   w/Lq43HzCkW7tDP85QGrzTyI1g1NPMPaVXFlXcoq/D3cXl7dpqM1jt9WA
   wIz/AynXn9Lu5wM086DKixvCpk+jLSWvXUR2kH9Wf4j8Nv79A1kJkMg6R
   O0DZZ6a9AHII2HRgT5fL4cqOr9NA5wk5ANK/4pcPBFQCHatU6Wq9YVbgu
   g5FZFlGquoMizImuXRzfkQoivWMQsf7GFz3XITLBw78JHpsIKw3g05bxs
   g==;
IronPort-SDR: +A3CFPWwqZLCVhO46iPJFOvoIzwvgZygatKYHAui0oZkm73CbeIG5sjod00TnsCYKeKt9eNNgB
 2X8S22P6jQ+tPD78sK+EGM9sglBF6ImK3mC+lD1XypZByJuBveJROWys00yFJbFIxpBsNvyk1v
 OFa5PIAksESd5EIubAdSkfDWVVz1w7hGUMIdLMhydPxrcURU7ApYdw0L9QtdWEn+cAYQ8ngcHE
 h6GZX/qEfdIxpr0HBSTBNIMLtfhI7c6DgzL40sXHftlUd/eDhy0TDGpMRn7FFDDXw1mQQi72/w
 78w=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; 
   d="scan'208";a="250654139"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 05:06:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Yw4sEoXCLpzjQWkGF+VwJ7kIgynVAARdkEJ9DsKw3gp01JbWufdpwVmt7VdB+VN3ON7NQwSdSUj4ExarYZglVgpp7fCweOgUGl1yAWC7esY4TG+lr5CAgaxMWdLD7b0YCDhwEZolqqdLb+2Kz5cfeWe+PfjZr3pHvoNpL9kK1CC2CSfdXCbG1HUCNrNNr9oZnrfJEHpzNJjac89xxJLAPoptJzrTLwDsH/qLb1D4wbuJ0ORN3Xi1ZWJZY0ESrKqK7bbm9hE2Kj2vdsHd8DEHjXYSrGABvRNezgCuJCI5sZ9eSezXPBD/YnxuP4ZFscSM0wDSoJjPHQqnkHiNjkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUkv2XIbURvaPfH/VkKBG7aXLN8nIWFoYCe4mKSd8xY=;
 b=A1MbIKZJpON8IZ1XMR1xMaku/8/ckhXLJgGIQwuEBtLznkKKwCkCjrcFq4ifX4z+c+SeoTq5KaOKdz3KonjKVD/JtYYfh1RD/Bw1VJfYO9T6OVzJmpCI9xCOPxcKDAP991jUlAOxp4hV57kbsksxdwnTdDPsVbFkt+/6WBTcMhNgZaTTF+bBe7dTKFiSz+vQpEi82EVZKsUsT4NJgvz2uwkUZAilCYnA7cDGvOtctjsRh1kajOx5zjUfz1shbUyAEyE8RyM3JI8bovpOf3ab6japRcopfZAVAVxJ0PEs+D/G5Zjn8U1mzAsb/BxNX6wlC/EZ1LgLe9y/VOQRtXiBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUkv2XIbURvaPfH/VkKBG7aXLN8nIWFoYCe4mKSd8xY=;
 b=esFf9sqsoi/P9B0gULzBYlRnfQGGDmfBUUs2Yr4pYXdxxzn67vFBpWW26/I5fRkCq88OPjoTggWweZZKjgNKYOHhhJMAzsFWJNvaMOIjZrYRSzVZWQecRSmWa6FPYI7BjNXb3Ve9HtU8OK+1LLFMx0qLAfthGhv0tkaYELdh3is=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4328.namprd04.prod.outlook.com (2603:10b6:a02:ef::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 21:06:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 21:06:43 +0000
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
Subject: Re: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Thread-Topic: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Thread-Index: AQHWTm9LvGU76q0unUybnpt+xj1KpQ==
Date:   Wed, 1 Jul 2020 21:06:43 +0000
Message-ID: <BYAPR04MB496556D7288B9EE3180DA3B6866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-11-chaitanya.kulkarni@wdc.com>
 <20200630051332.GG27033@lst.de>
 <BYAPR04MB4965E849D99120B59011CEF5866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200701061858.GB28483@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8fad9ad-83fe-40b0-ae5b-08d81e02a81f
x-ms-traffictypediagnostic: BYAPR04MB4328:
x-microsoft-antispam-prvs: <BYAPR04MB4328C1320D08F1C6DF929A5A866C0@BYAPR04MB4328.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ErcZyZrDPnhlFnTmPVyzY2OXF4vo2Ux0Fjf+l6cShIlT+m3s6y/1Yr3PocHaoe/1sHZoJfvJ38fK3U7/5AOZuqe/myBHxI1yj/vuhaRJr4Ln9zI69M5xQwXrE1y+JEEmK07UiTU39zYiH9xOt4UUbv9yJmM8WhDQwfSrv8rdTI8DyEZmvqGd5O+9JrVxSvCapuy3keJoJ44bjzCzkYSdAyq8T0XYGZCOxLMrUX+WW6HJSK3edwGldVZB7B7e533dT6ZPl3m0CKy9CpncXg0GLbrj1dLDm8kP2kdWK5YDtpTqKpiK+3MLEa50f7salXzHeXO0yYilMaoLwxbH9KhCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(52536014)(26005)(55016002)(6916009)(7416002)(54906003)(8936002)(33656002)(7696005)(71200400001)(83380400001)(66556008)(8676002)(64756008)(66476007)(66446008)(498600001)(9686003)(2906002)(86362001)(76116006)(53546011)(5660300002)(66946007)(6506007)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: M6nHMoyVZeO4ymwF7x8YkzL/W19wKWdXoMwqcEo7W73csQmRttE+kYjzOAXh8LJuJMORWyQ2x6IrNMMQoUH/O1whdfFKaMyXYD62k33ozGzvOj0mUn/p1KUUPDdevddYipkFrqAVNuWsuHHv27zqEt8lvYzWtylBdRcZ2o04uCFDBk6IbKfcnu0iUOM/Ni/l57hpJuIPWuiwyHy8Puq/MPI7CGx0HsGovu61oykCB7LFnmDQimvB4ybGYKJIpWql58rbke3/DL0fSz5pikR9TXr8nr+HuFje6IPnZFQF6lkbZSMHKgkh1mWmx+MZ6gTT1UgmZMYKALhmCRrLbNIAgOAxU4INzqWXxAnmZZyiObs4G0dLuRr0q+OnSat7YXQAsXEMROnvvDyC80nkQXPK2HJT5K0HCPvhojlbA0muPeEk09Wawv5tYDeigkv9cornYATtG9fbbUSDl9+LMRN/8V+DfuKIsCSHl1DhQGE/Ac6ICWbmwD8/ZBhl+pLLj8pn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fad9ad-83fe-40b0-ae5b-08d81e02a81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 21:06:43.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4VjNlqiME1/ydCzQxnxuCuh0GpplpyUzQ5ZoEeXrii2ef0Nel/sjHNHIX/woYOfT0gz7VekZo04vdscU+IboGTUV3PYTimSRed6RZnhxO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4328
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 11:19 PM, Christoph Hellwig wrote:=0A=
> On Wed, Jul 01, 2020 at 04:45:03AM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 6/29/20 10:13 PM, Christoph Hellwig wrote:=0A=
>>> On Mon, Jun 29, 2020 at 04:43:13PM -0700, Chaitanya Kulkarni wrote:=0A=
>>>> The only difference in block_get_rq and block_bio was the last param=
=0A=
>>>> passed  __entry->nr_sector & bio->bi_iter.bi_size respectively. Since=
=0A=
>>>> that is not the case anymore replace block_get_rq class with block_bio=
=0A=
>>>> for block_getrq and block_sleeprq events, also adjust the code to hand=
le=0A=
>>>> null bio case in block_bio.=0A=
>>> To me it seems like keeping the NULL bio case separate actually is a=0A=
>>> little simpler..=0A=
>>>=0A=
>>>=0A=
>> Keeping it separate will have an extra event class and related=0A=
>> event(s) for only handling null bio case.=0A=
>>=0A=
>> Also the block_get_rq class uses 4 comparisons with ?:.=0A=
>> This patch reduces it to only one comparison in fast path.=0A=
>>=0A=
>> With above explanation does it make sense to get rid of the=0A=
>> blk_get_rq ?=0A=
> Without this we don't need the request_queue argument to the bio=0A=
> class, as we can derive it from the bio, and don't have any=0A=
> conditionals at all.  I'd rather keep the special case with a=0A=
> queue and an optional bio separate.=0A=
> =0A=
=0A=
Okay.=0A=
