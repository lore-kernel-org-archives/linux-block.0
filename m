Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F2C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17AE20747
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HyWcT15T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QVarCkr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgGAEcP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:32:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3013 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593577934; x=1625113934;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GcEYHD1NoRNSfCTySVnazmPsDMGr0PAOzz9UIXGsUhU=;
  b=HyWcT15TC8Wr7iv6xdTqljcYrBCIT1kpAhf6AeeKgOvcvOgUqjGqXSgO
   H6V3ika/BRxVfzvP6skuvuzTF53P/4ve3DEXfBZIOZJEEb9/jypzON0dY
   4tO7MSBheqsLloI+Fy4vkPBNPHvFLLUI/QOUhVdNCoNryadPT2LiuDnGp
   t9u78FHd9tryfskxzKFP3Nsnmwt9IknbpdHirJ2+3+Raka9Ykt/1hQuXo
   MVO8jv0p87uVlHk8x5l6tAJEPVmaGGOtypWlBhj3JZdBbHmf4zqmi5Z3d
   Ww6hMv4nQNaqfk2e8w12NrMgywlLCxdcGK9V5c/TEk/r+BqIWIBJxO80l
   w==;
IronPort-SDR: zXOV38qYZMOD6YznMj/3049KGfrlf8+RSEx4DBDm0T+S1RvjK8xKp5bceSwwf1cOAYPmfoy3KE
 Bpe92rQ+VZq/W0JcIyb/RrCf+Dalm2lSQETwCvjDL0hBoDAFDxsBuAmbjHNkZ9FAeNvGHoSyQl
 J/NRqf7sDG9tSb0BcrrFpNc5klptEaYJnp/LdAX202D4LP+VlgDKYVRacHf8pa696I4dvjD4XQ
 qofL+nGFfuwqKTjmITwkGdxrcL3K9F+xz24D+FqolvWTEy2VT7OhNJ3rSmqOjFGUmhCadCsMNW
 5AE=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141341098"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:32:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCsxcBi/QV0yxGkbzhkSirWPnFT4/H9VCeSdCkQTPl1ivtsxvnL45RaMfv/OjkAQP/9VXt+cjBdBkWyyia+jNLsjSrxTjSupwqyF4cFJjUf6Fe+b9urwV1LhG8Cvw+uXxwt8ZftP0rGj6EAztLi+nDg+6L6x9Wz/8VOaGjgWnDQgCwJtZhi/oARYfuZaGikzGXLoLII8/rKc6qyiEfoCv3DLQLfmyh5oTddnxs4/nlhyEcM2n/nc4mhJVyYFAUzEepaB+Z5qEX8coXHOvbQZi/wqj5nDbXynq+EWib6v2TMst9DOT/y4WM6aYKlH6p9S4NKIFNF8iec/E1E+dUwSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mrk+aOvz5OGV7NVnLDVf6vmctwNp9lp5lQ/mZoyp5c=;
 b=k/3I8PvGOA3/rh5zcdL2ZOhC9VHmiTiGnRRblG4UmRlhZs+4U9Hb4Y+7T3qLUz1bB1WgfqvQB7QO04OZH8IK267/0jc1voPm5rrnzTs3XfcGbc/yAVVopXKNV3WPBXPrySuIOaMWa5BhhrRKYX/j2EkDcZZxJlZdSw8iVlhOOi0E/d9ZV3Vx/2uo2nf/juZmHk6sXESvH6hdRmPlVVEMdFCJTsQQlmBB9WkPKiTqZ0Kcm3d5q2BkhZ/gUNHuCn+PQ053Az4Lh7/ab/L19fWI1ozvBWUiEE+yrtDYcnmNcFNYs+/khjmej8IwBe9pAjHxiaoJSjEAabA+v5OMF3hewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Mrk+aOvz5OGV7NVnLDVf6vmctwNp9lp5lQ/mZoyp5c=;
 b=QVarCkr91JYA7zE3mH6+LoWO7P0j6RQ6+/e2LTh5aAlgIarcDG6AnxJIL7Wly+KkvN6Ruv8QV7VVL6e/c9Rhdd5HNbmWtAyAY5NrlfDNzMObnfBv81mDLT3HllzFKZZN4Htp0DQiVNWKbhKpkx/wanwjna36WgxuMqipxENNPyk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 04:32:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 04:32:11 +0000
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
Subject: Re: [PATCH 01/11] block: blktrace framework cleanup
Thread-Topic: [PATCH 01/11] block: blktrace framework cleanup
Thread-Index: AQHWTm8WcXOM6eH0gUCsI/M36HXU0g==
Date:   Wed, 1 Jul 2020 04:32:11 +0000
Message-ID: <BYAPR04MB496556D53F75E6E2751799BE866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-2-chaitanya.kulkarni@wdc.com>
 <20200630051001.GA27033@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ee17b7f-36c7-4208-724c-08d81d77b918
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124BE914CB3F5BF56C546DD866C0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BT/480n7XyHrddx6suidMX6MKzKRg1hCP0eggFBy1tcE2sthXEIgAT6pjcxY4EF4ztmfrAaZaLa1yFjua1QyXjYhS8JM1TfmxeFXmycrRDMkLt86TWZWWPsa8p8ptUKqRMPkESrjt7mRvdF3LjdnEMFBCfqHNoheqnS8ZYZJToB63fo+TBBnAObgpTrxkh7Y7twVLcm+TwUHuIQAysBfPetRYJ1PBntcLgDZcFZskwB2oOBfDTK8Cdk9rfldCYPBiPguZKN0dvhu1iJ6KdrrDir1tIfviE+lwEeZNUBA3XNLfeSB+c0fOskKKTXVZjoAAXsoWE63W/Z1e32BdXKwBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(8676002)(316002)(53546011)(186003)(4326008)(26005)(6916009)(71200400001)(54906003)(52536014)(33656002)(83380400001)(5660300002)(8936002)(76116006)(86362001)(64756008)(66446008)(66556008)(478600001)(66476007)(7416002)(55016002)(7696005)(66946007)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0NALILbIOsP3E9Srr3dqfLDrMN0cAgXI54PMV2Uewn69eWxv4HRQbZaIRG/IXKBwe7CBYmvrlyivFyLn3njKkjrNGOKvfl+B19E5arekUGhM0G76uMP/KP7TiKzy1iRmNYz5PZYsuVEfeHYAbl9oXGoyjsFqBCDdsoNNCIW/tvmUbhYwHF8hjXmsqDHdc0kdHTk1IdISNRGFNa1yCqy8kad6PPeDfy1+5uTC5bhcwVMgsJ3x211kYS2HwufGWCOld7utgJrzjIvjuI1R01ALn0FXUYaLHXJtfF0EiNjrHwNlCxlMOxsmwF7ElSbKdbke4FxUfPcE/IL2I39M+XxFymgx2FAbWzCViW1pEipcWHCfWH9PN82Jo5cRyh7GjyYSK9qaJAt1NXonmnyAcGOYiP/iV9HFlIRSQfxK/rUSuqbWyPqPTplNqmqLzMBe8LYeB5a4VgNNbPTw8PFDCuY0IfF7dX49JNe5vXCYv0/18GM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee17b7f-36c7-4208-724c-08d81d77b918
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 04:32:11.4936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jhk9F+nyN+dlZWvLopVn9/klJAAhf2XP2q/hvK4wGzDfcKEujI5RfovsnA8JT20FSKKQ6wXV6spM7jShRFMKugqrO76UjY+kkJfUFY7jNjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:10 PM, Christoph Hellwig wrote:=0A=
> On Mon, Jun 29, 2020 at 04:43:04PM -0700, Chaitanya Kulkarni wrote:=0A=
>> This patch removes the extra variables from the trace events and=0A=
>> overall kernel blktrace framework. The removed members can easily be=0A=
>> extracted from the remaining argument which reduces the code=0A=
>> significantly and allows us to optimize the several tracepoints like=0A=
>> the next patch in the series.=0A=
> The subject sounds a litle strange, I'd rather say:=0A=
> =0A=
> "block: remove superflous arguments from tracepoints"=0A=
> =0A=
> The actual changes look good to me.=0A=
Okay, will change that.=0A=
> =0A=
>> +		trace_block_rq_insert(rq);=0A=
>>   	}=0A=
>>   =0A=
>>   	spin_lock(&ctx->lock);=0A=
>> @@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue =
*q, struct bio *bio)=0A=
>>   		goto queue_exit;=0A=
>>   	}=0A=
>>   =0A=
>> -	trace_block_getrq(q, bio, bio->bi_opf);=0A=
>> +	trace_block_getrq(bio, bio->bi_opf);=0A=
> But now that you remove more than the q argument in some spots you=0A=
> might remove the op one here as well.  Or limit the first patch to=0A=
> just the queue argument..=0A=
> =0A=
> =0A=
=0A=
Yeah thats is where I had difficulty, and when I tried to do it in one=0A=
patch it got complicated to review. I'll keep the first patch for the=0A=
q only and patch(s) for rest arguments as needed it easy to review that=0A=
way.=0A=
=0A=
