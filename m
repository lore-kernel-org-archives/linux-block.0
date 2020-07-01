Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB54C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03D520747
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lQBHSqsb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ah8238te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgGAEeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:34:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49451 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593578051; x=1625114051;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+jksiLmEkuQX88twwMifevc0nx9DKQb8IoGUZM0abWY=;
  b=lQBHSqsbw6u+6P2YVYI5086AX8ExUsG2Ry9sQFJSh4qAdpZz1unKxSZo
   ZfsO2jzCLcfVLJj6pE6niIUKC7537ieB97jhKuA2wIxayIjYmMoxhK5Q8
   YpbzvyKEaw6/tqLMUdSNJ0QAGRHqetCtY+5j1J3uaMTwcLJboXfWqxXia
   N6SL8bi9U5spG/xRncyWw2Lk4X0iuOoVMz0cgzU8xFxhfwGfkFE8xKSQ7
   9zngBp31VIbxyitDRNcvk1hM/3cuh13KuX0V/ol+WPGND/ahswhxMguT3
   n9LOyq4i126UrcZ+1ez6izeF3AD04lgS+TjVkIaoRKR8PK6m0JB60M9Et
   w==;
IronPort-SDR: NRlKOgBe/aX+ek/fcrxmg290STTtuXZYuA9WbFjz2j6AYjZlarr7EA3hfxJt5yQg+zwLmC2+0c
 fYqWML3kfW6Kqbep8Oic8nEiPF3XJS9vdvYddR0l9zB2WeFmxzqSi+k7bBIfn47WtMOOHy2unb
 YpgcTmFHhW3tk1H6qqmLogYNJYKB6P6Fo1Codg6J6KalUn/8Eq56Xb7bmVb5e/Fj8Hxyr4GT8j
 CBvTKdvFNPQInQiLpFPjYTxSu2bOXCGw9clErodrcrBIj2GqDUTadglG+O+VIZf0mVyDUs1Qjw
 LnI=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141545612"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:34:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFEYHZuecYJPbaqNDDzzhUcgoTFprLFPFwDcRXWQ51G74FJZNFQdjF11XWS8OhVE/bnhVzHV2GqNhqG7LQEweTVyfWSH6GrHE09FF5OT6+RMilOnNhzeMJpaHNzYmWJliOT+AMMQgOAfJtbh4V8OJvu0QDJnt+BgFW/A29wSxu7TB+tNehvsUcMLOo1tSJeGuYoMaugqSGokZV0iZ9j+Ei73u0BNg4LaAQg9CQ+8A+jkilVX1aVGuWGZREyvRQtlv60ufauT/E2JZP75fRFEskAHA3Uw96xdIHMPLnvAPdA1whRZAAX9PJtsnjllfvOy2lQd5joEbeKSUNDoGNn8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XdhWlPXJrbvTnnBcGsWu4JzETHUQ1vNlqzLM8yrzOE=;
 b=Duca/5x9ExMpe8GYnMHKg49f8UhewmVcRpCEC1z+BTJLx923ukdH+/fzLAcKyUGAQQVCHGzHNxcutgMMVXs3fdA8jmGQA/Kl9TppsUhpQ3vkMMbBTVs0xPXSmSN6lDcIjSXW6s3TNUYF/hosnr881jiUTVJyFw3GIzTjHgEx0FfRnYjVoS5GYvMxNPyfIR+k3PsQTXgKkZzfw/WlKFd6ZDpSUYthpIlsB4YQpAEnBsUqZ6aGjUYmOmF2MmR+28idb0UgSepmdkCCObbiaopiCvrKpXWHsl+GWEA7db7cD2BJRZd9Id8SE/K6l3UDl9dOR0cUYnbrqENq+H2XndyBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XdhWlPXJrbvTnnBcGsWu4JzETHUQ1vNlqzLM8yrzOE=;
 b=Ah8238tedDaOWf97jm7DObGZjhThxdOHkip5Z901rtRIn3OEGwfqdIDImw6e+TYRdf61gpx0nBMXS3Mo1xZNcrkwg8lyjLIv9IgdVXjQk4DlCr2Avjw6yiBhDZJbDiMpywNlYyboH2drNFd76TQ9Ra9PlMTF2NRfxDMM3GNzHCA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 04:34:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 04:34:08 +0000
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
Subject: Re: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Thread-Topic: [PATCH 05/11] block: get rid of the trace rq insert wrapper
Thread-Index: AQHWTm8vk3fl1wwNBEOkFWbWf3m+uA==
Date:   Wed, 1 Jul 2020 04:34:07 +0000
Message-ID: <BYAPR04MB496592F9BE389ED9E39DFE21866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-6-chaitanya.kulkarni@wdc.com>
 <20200630051116.GC27033@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee1f84ee-aed9-4928-237e-08d81d77fe81
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124DA95A47ED805B9C961BB866C0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OV/RcrHZgdUOavQcD+Na/zWNq09z+8ryPDQTGbnIRScSHlkztz8jnApoyFBcpj6WWL9Rndx3ypaPa0eRn423M0fEYq1IiAFreobllVsFJ8UlpdJrAzceFHFau8SCQQQpRk6XFkMj4jaqwoWk4SEdxowr2JQI+QYgNUtwBD0mg/8xqDciL0Y1mOhelxB60lw3sm2tiscXm+oKSCLO6PnckTe5nsw2JMwK6qjyt8y6Gw4Bu1h3J5XV62cLqDpBnF0NJOtDYfgmvty36LErgYx+kksTl+LhteGT5e25i4v2cghroGffzPQS9TXXQ/+LZBdQIkZiBoB0FmLUw4607F70AoxVqUe0PkeAaZgDKJuhtMYpjX9yikCIGTALLbggGb8B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(8676002)(316002)(53546011)(186003)(4326008)(26005)(6916009)(71200400001)(54906003)(52536014)(33656002)(4744005)(83380400001)(5660300002)(8936002)(76116006)(86362001)(64756008)(66446008)(66556008)(478600001)(66476007)(7416002)(55016002)(7696005)(66946007)(9686003)(2906002)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tb1pFtzoR4a3Y20JbuDZxs46Rno3lrVGBb6Taj4E4LLITdoroDrvdQRzQDVhAbT0zIrs1cU7TSdwB4uGdJZ1WfIr7QyIm7sWkv9EaeVo/yZhRev5TarJlVoBwRYLIK5T6AEsgqnKqTTibdYZdBQi0bd2Ri6wjVQjh9o3qlKcRGsmu6FEcg+PxoN5ZrnvjKfI3UzU+ajiF4kSHHzk6qgZKT0yVhlqydFGXhZCzwyQsckeplHiGDYh1DVIWlSujbnAMeUAKEwVGQI2uozo3Ug8bOSASGBICHLSFAXqdUaFfS3RSJ68Rhn3BOZbv8QwhV31VpwcgWyxb7dqmVDXyTMpYJwSadCYmuu6LeLIZMtuzzzoHBZ/o0nzqFic+DP5ADi9Lbr1X0iQW8VZbNsGHeA84l+wEDAbZAimByN/b1S2Q14MbS+flcWN5WHBf+0+SQ4/JxMXdB8/Wuoq74D55tbP3OIIhQr76Tmym1aMrntGYPs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1f84ee-aed9-4928-237e-08d81d77fe81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 04:34:07.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4Rwjo7ZlNR4sRJTg7NKNMlUsgJkh9tfjXOVZ5RHJKSlEpuaS59KPJCjXi1i/cOvACaA26x1wnP5eWz9dyhHs6y3JkPW0rndK9OmtPaECw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:11 PM, Christoph Hellwig wrote:=0A=
> On Mon, Jun 29, 2020 at 04:43:08PM -0700, Chaitanya Kulkarni wrote:=0A=
>> Get rid of the wrapper for trace_block_rq_insert() and call the function=
=0A=
>> directly.=0A=
> I'd mention blk_mq_sched_request_inserted instead of the tracepoint=0A=
> in the subject and commit message.  Otherwise this looks fine.=0A=
> =0A=
Okay, will change the message.=0A=
