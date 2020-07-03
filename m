Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6056BC433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 23:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3020724
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 23:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RUckAKiK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qh5/dJ8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGCX3d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:29:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28524 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgGCX3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 19:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593818970; x=1625354970;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ane6eyGwETloVsshK6khtFpWzeBqqRcBLotjOwEsTdE=;
  b=RUckAKiKpSAiueJqySe89VQJzUQ+s9ObLzkTm9mwqZadPn2HG/5LX7RU
   riB6w9qOMfirtuUvDT2lETBsN8pBZk+lIOi5OEEynPr+Rkgqbqn9ypq6x
   xfwL/or1R6sJtHULfmF2X/Atv4njTsQoXSFKpaPtPQCwsm7WgmgDz6Knr
   XFQfcCB9lHI+7b5b+hMrKeVJ/XNcByiH/PzGbF/u+urUTYvEmt5HlxMbq
   duPjmJjPGUYSqFfEse2U3B7wK/PZ3W/hCYrcPZipIOrOgg2/HLr6s5tfg
   KFBSW4nYcKusN9WWtsC1Oao3TSC07H3mGBH8qe8sMYK1iSOeYWmzLegYM
   Q==;
IronPort-SDR: yWDJBC0i2wNVh45QPpFNAQTd+YftwoiPkKY0jIMFRNJvMLwhYw7Qgj6CdySMP30QrnfkhNyYk1
 6I3RI9TU6pAgiORdKPwopEyo3NzeIi9QzOi7v1S0ShD7Kaxd/h++Nj4DexJVadvqyt/fkbyjeg
 tOLb1p+5Fw8SGiLiwuHQjY00sQBbSoAulNCUXSdB/bjsCmcSMnhnKz2jK8shkE8eHNW03UbAkV
 HDrmL4GqG9uQLzTvJRs0l4iMwtaRx1krghCSukrPiKcsB2xz5PzdO9o0Y1jTfujdjP1n+Kl7ih
 +2k=
X-IronPort-AV: E=Sophos;i="5.75,309,1589212800"; 
   d="scan'208";a="141610806"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2020 07:29:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKysCtSzdxflxHNHDAuo9i5Eanve0eHG1LHLXS+S/ZH+WyMng1GDyQ3MZxO4jQcSag5lyYWL5VYLKD20w2xWCTgnk0WVNuFn0wt7xAYW9mogf0nM62fQDqVmOswUzVfvJUHe6rfscT53rMr5nPlSCjjC0ShbGkUfDTzta1JIdCSuAbW571/tEjtoYsoG+0zEoeaukE8ttmtLGkFwSWKkB/E3cZTjqeg7h01MYLJ9ZkaHkzsP/3H6UByTWO1nZ36jhD9tkcllO9FEvS/Z3LoK3LXhEqqVj1sBk8cdyJSgdio+TxuxT/5cXPel6gVQt76ud5VX8c3B4FyjUkjUEZfx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV5XgdRySRTCRzV9u1P1RO0Ew24Zo3NrSpRMoZYVs+A=;
 b=dqDq99uUQKB4/tP5IpXE5hZFBjqUOLRAYebZkpnYtaBaayt5AcM7l44UvPNjx68LotvUJz3zKN2UdvVLNFDmba3KYRkTpM7ywhs94vV3fsMq8zb4viWA0P4aKX4+2kqJjUSuqIP/3OXXuQhmQo8u9qID+zhVkeb6+IJ5F4s69JIZ4MNjQ7UlfmDXqPxNpYWNl5pG+5XcTS01h+hm/dlRaUpkf4C8qViOI2TtVKD6N9k8YnNvIsu5oEFuAi9XLy8touK83QGAMjhzUsRSXB8aCK3USFtsITGWHgxd0CXzUTMFtjVZ060uPuYuxeIgw5VrfwMBnhtm7MPBKHU2T7FO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV5XgdRySRTCRzV9u1P1RO0Ew24Zo3NrSpRMoZYVs+A=;
 b=qh5/dJ8U1XZVT/KdoH3W5KSLPixxnqPi4p22WR0MM3qpgrFAd83wJpvRyhIjX7gLXuZWNb6UemKL55FOPEdPGLoX2wFWDt666B2zIk0XNLsBjSivtMQzRHUpvSQdVhPoDMNDtzBBUhWdews7vXMJyJHz6IxXnueIsSU+vYSATQc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6961.namprd04.prod.outlook.com (2603:10b6:a03:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 23:29:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.027; Fri, 3 Jul 2020
 23:29:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
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
Subject: Re: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Thread-Topic: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Thread-Index: AQHWTm8vk3fl1wwNBEOkFWbWf3m+uA==
Date:   Fri, 3 Jul 2020 23:29:25 +0000
Message-ID: <BYAPR04MB4965DFE805071F971DC8C71C866A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebbe502e-6e23-44fc-bd8b-08d81fa8ec6a
x-ms-traffictypediagnostic: BY5PR04MB6961:
x-microsoft-antispam-prvs: <BY5PR04MB69610F46129A7CBE896A2C25866A0@BY5PR04MB6961.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHbK1d8ZEFddcJNCB4YXgzcAMrjzHQLfUlyudRbLpRUVapJC0ReE66OcA69kdCCZ4qj7jZmfekPHH+h5BQ+xHwI18ibzZjEzzQAhk68UK3FyjZb8iRA5a4hb4pujak5uuy1DPuM4BHA3mDkMDeyxzkq7jwdGCL021Ybc7b/j5TKbZNLlldIRXEVQMyVpJGt9Xl+IY9/nUB25v79VJc5zEJb91ETBZmDJoH+JoI02W7BUKeMBz+iGwiKq0eOuDtkP2A6onH1flWkUZxzce7CTKMkhEo38ErRIAz3GfbtJpWmtS6fVyAu2bt9klYhQQEMVP1HyM8nezE5B+VUpdlcfYTSB1SR96eLsKQbzIBddp6zXIyoWadJmlbzukGj4/puU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(55016002)(26005)(71200400001)(186003)(66946007)(7696005)(76116006)(478600001)(54906003)(52536014)(5660300002)(316002)(7416002)(9686003)(2906002)(86362001)(8936002)(8676002)(4326008)(66476007)(66556008)(66446008)(64756008)(6916009)(83380400001)(33656002)(6506007)(53546011)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GRpAjlEJSwXkVjDM84apE2wekkuAJ08L7k/ec3+IylKR/TDc28J16ZKqkLRu8g7VE6SwPbl8IQyPHvhtB6K3jntYJK+zWMbOfxDVDUmpzQfHNLk60FYg10RhhPdSWw2ROLJe2vuGFXOedRZBLoiGbuQf5Veif8mAEE3aKFxo1yhlTAiQswThR8eg7sxItcsnwVKQS032Rqjn981xO7UC+CZBdGOPJqNnqjmWCuDzkKue3XGaW0jVFRe6X5DoZEihOunhFDEHY/AEbOmiXH79zWWy/8S+ExtKuoHZ9E7BsFqLVM0aFaLJ2QUC3TK30EXB2ohvv4qPi3xIt5B7Tx4i91psi3HUlqKHMwecNMuGKoQTkkDeou4g72VIdWj4eXYYA8ujyKeu6zrHfv57spLpCNbne+kFfE+mfcBTZSy7lwkivj3aN79wTAi+j9+fSuvKX1I7Bumm0ebiMVAfPn9yREARw/TAQIr7KfNRnY2Chmo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbe502e-6e23-44fc-bd8b-08d81fa8ec6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 23:29:25.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVmDLlrXTKpFqjWvC0CpvOvuffAmq2aNlUM9S6bdtbCPxOGQkUDPDNRRGUm78Bvis3/V8zVYetr+Rh8swMrJ8bfwKO1hvYZakaYiCmYpU80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6961
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph,=0A=
=0A=
On 6/29/20 4:44 PM, Chaitanya Kulkarni wrote:=0A=
> Get rid of the wrapper for trace_block_rq_insert() and call the function=
=0A=
> directly.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
=0A=
Can we re-consider adding this patch ? here are couple of reasons:-=0A=
=0A=
1. Increase in the size of the text region of the object file:-=0A=
=0A=
    By adding the trace header #include <trace/events/block.h>=0A=
    in io-scheduler where it is calling trace_block_rq_insert()=0A=
    increases the size of the text region of the object file=0A=
    kyber(+215) & bfq (+317) [1].=0A=
=0A=
2. Mandatory io-sched built-in kernel compilation:-=0A=
=0A=
    When testing with a different io-sched KConfig options ("*" vs "M"),=0A=
    when kyber and bfq compilation option set to "M" having this patch=0A=
    reports error[2].=0A=
=0A=
If I've not missed something here then can we drop this patch ?=0A=
=0A=
In case we really want to do this change it will need to have KConfig=0A=
separate patch such that if tracing is selected it will force * =0A=
selection (built-in KConfig) for schedulers in question and etc.=0A=
=0A=
Do we want to do this ?=0A=
=0A=
Regards,=0A=
Chaitanya=0A=
=0A=
=0A=
[1] Scheduler IO object size comparison :-=0A=
=0A=
    Without this patch :-=0A=
    ---------------------=0A=
    # size block/bfq-iosched.o=0A=
     text	   data	    bss	    dec	    hex	filename=0A=
    62204	   1011	     32	  63247	   f70f	block/bfq-iosched.o=0A=
    # size block/kyber-iosched.o=0A=
     text	   data	    bss	    dec	    hex	filename=0A=
    14808	   2699	     48	  17555	   4493	block/kyber-iosched.o=0A=
    With this patch :-=0A=
    ------------------=0A=
    # size block/bfq-iosched.o=0A=
     text	   data	    bss	    dec	    hex	filename=0A=
    62521	   1028	     32	  63581	   f85d	block/bfq-iosched.o=0A=
    # size block/kyber-iosched.o=0A=
     text	   data	    bss	    dec	    hex	filename=0A=
    15023	   2716	     48	  17787	   457b	block/kyber-iosched.o=0A=
=0A=
[2] Error with selecting M for io-sched kyber & bfq :-=0A=
=0A=
ERROR: modpost: "__tracepoint_block_rq_insert" [block/bfq.ko] undefined!=0A=
ERROR: modpost: "__tracepoint_block_rq_insert" [block/kyber-iosched.ko] =0A=
undefined!=0A=
make[2]: *** [Module.symvers] Error 1=0A=
make[2]: *** Deleting file `Module.symvers'=0A=
make[1]: *** [modules] Error 2=0A=
make[1]: *** Waiting for unfinished jobs....=0A=
arch/x86/tools/insn_decoder_test: success: Decoded and checked 4932572 =0A=
instructions=0A=
   TEST    posttest=0A=
   arch/x86/tools/insn_sanity: Success: decoded and checked 1000000 =0A=
random instructions with 0 errors (seed:0x4c6e1a40)=0A=
	CC      arch/x86/boot/version.o=0A=
	VOFFSET arch/x86/boot/compressed/../voffset.h=0A=
	OBJCOPY arch/x86/boot/compressed/vmlinux.bin=0A=
	RELOCS  arch/x86/boot/compressed/vmlinux.relocs=0A=
	CC      arch/x86/boot/compressed/kaslr.o=0A=
	CC      arch/x86/boot/compressed/misc.o=0A=
	GZIP    arch/x86/boot/compressed/vmlinux.bin.gz=0A=
	MKPIGGY arch/x86/boot/compressed/piggy.S=0A=
	AS      arch/x86/boot/compressed/piggy.o=0A=
	LD      arch/x86/boot/compressed/vmlinux=0A=
	ZOFFSET arch/x86/boot/zoffset.h=0A=
	OBJCOPY arch/x86/boot/vmlinux.bin=0A=
	AS      arch/x86/boot/header.o=0A=
	LD      arch/x86/boot/setup.elf=0A=
	OBJCOPY arch/x86/boot/setup.bin=0A=
	BUILD   arch/x86/boot/bzImage=0A=
	Setup is 15132 bytes (padded to 15360 bytes).=0A=
	System is 8951 kB=0A=
	CRC ff6eac72=0A=
Kernel: arch/x86/boot/bzImage is ready  (#59)=0A=
	make: *** [__sub-make] Error 2=0A=
