Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D152C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381992077D
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 19:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="e3ekDGls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgDCTjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:39:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:55796 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgDCTjb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Apr 2020 15:39:31 -0400
IronPort-SDR: jR2/t3WhIqwCkIpFkX7wYs00s9gUyejMNR+mmoJaLrQRUc0XyIkpxqfnYrmIAtLX46EmpbaSkn
 5IUJSZwwK/rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 12:39:29 -0700
IronPort-SDR: UPiNqnYBg2u5JHl8JKpp3gApGyEqYSj5sj4DDBxJkTXrxMRR//eqXyeP9tS0uETuhHO4O+ygFJ
 HBNERuqcP5cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="329261701"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2020 12:39:29 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 12:39:29 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 12:39:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 3 Apr 2020 12:39:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0EEepPRM5+nRbeYStX5RmXJdEp6sP6OdzMdejRtZyFSqGAXN9YO1hXrB//qjYy8VzqkHcnj/64RRFZZoAct/EwdQAXwfH+CFbaK/PD8ovPboAOLU3sY2dpC/JKYcDL3lSsdcyqWfZjQbVM9YU1MoYzOng+/Pj7YUg7hiFWMRiqIF61FYxDTQisjttvsJBe/yJoUTIyp6GSwtgK2EWbzl73igFFNXDIlnfobjkqU9W8teoP3bDOoSbK1xmK9+mYUq618/WVugGf3Wrf4Z8OZF8w8bmdTEsVD4VbEdK8KGk/yJnPlhhDZjHrDH1FYjVDMAZwFcMh94yj2K/7/Q3rW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKWV7UICN8ubWqp0nQUHuxM2G4/A0o9kx+xh1nuO++4=;
 b=GD0zq7iiNXNV/1n/sFMYOW0Fnz1yypG1hCbW5khu95NDGVvmMUWSlQpI600iuh6cSVh9feDdT4r0ao/G1TgAgLcmrN5WsHNdezc8Il2Pe/q3bf3/RLNCmau5geXj0fW7MHKOCs9VTyjM6CEnyb5A5eAG1RcfLYCpgCQlMZXXRERYU5d8m6izy8h+IjcnqRGWr8xx9NANlKJS9A7/v6jFGk77KujdaGdu/6/OaMETDG8f8aAoKJRESdWIl53oOYU7ekuVYFGeX/ZZqWQouh5jyzcTBo/IqH65xGVW7e/x+VnbYr48368RTkB9ZM997UP3yITjlRqPYMkcvG9TV0Zm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKWV7UICN8ubWqp0nQUHuxM2G4/A0o9kx+xh1nuO++4=;
 b=e3ekDGlsKWCx9zUAf3wfmd1lIp26pnyW9z68LABW1CjmXsO28bnoRooKITPL0SI/n/erPJMrHfJFsv83dx/HmqoFLjJBNkeiaoCf0fLeT3ZycRvr1f0KHUZKKYvZKVGMLVvXYizN0+JH9hzT8hv4NywiPvFEJrj0Okt0w9LQSWI=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 19:39:27 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 19:39:27 +0000
From:   "Wunderlich, Mark" <mark.wunderlich@intel.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Sighting:  io_uring requests on unexpected core
Thread-Topic: Sighting:  io_uring requests on unexpected core
Thread-Index: AdYJ26yPcAavQfI1TES8GpSMxMGYSw==
Date:   Fri, 3 Apr 2020 19:39:27 +0000
Message-ID: <MW3PR11MB46843ADF1AEED8FCEA66BB8FE5C70@MW3PR11MB4684.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e044e2d-aa50-4728-d83b-08d7d806b8a6
x-ms-traffictypediagnostic: MW3PR11MB4620:
x-microsoft-antispam-prvs: <MW3PR11MB46205CF52968762E76FA434DE5C70@MW3PR11MB4620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4684.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(6506007)(7696005)(6916009)(86362001)(8936002)(81166006)(316002)(54906003)(8676002)(52536014)(2906002)(5660300002)(71200400001)(4326008)(33656002)(66556008)(186003)(66946007)(66446008)(64756008)(66476007)(55016002)(81156014)(9686003)(478600001)(76116006)(66574012)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLT5uNPL/N+ObpeBEuNNF530aEUB0r5Z1RfxZ6MXtxhqF8J83Qso33g0ix40U7tcHrQe8Ba5ZCs7LEmYEhwo+ISkH5fB7KRMls6PDOiZOWPsc2W8uLiGeHcaZc1xmFomUeqt8KhoDKxFM9CjzdwdPU3spFiSQUqaoNAb3qpjfZ9jwjkeb37m66st7c4BF2TSRHvsjw0JXahWSX1ZyNX+a7hr3RwthW9cXaqyCNANzkzIXcCTBhiqZMtqA7C4EpvV6zqy9l3h618FBO20jwJEUP/LFN6je3rC/0JtR3z+/EdeMzAFr/zUVxTtfqYmV4Z5CZWAUI7C3QNlIZb6d+UP37nQ1fqMz+ecNoqXgU0EfQEPJuyM81/IYVQ3x2wI9JFHJ3ptDvsu5JUHByHPjmCwY9GJsrcQP2Y2kI7lMX4qH/3loY1CQerTSTg/I1mzLeKv
x-ms-exchange-antispam-messagedata: 4Gt7JQ0eYc7Sm2iZPGbrMlGT1Vqm/KKfXkSoTcO1YY3wSCniLnO9LyrCjQo7LN9/neu/Noa4hMfuJQwcVWFanWyDtmSp0NKn2D82Gf0Pz8O+8wvd2HUzGuzAQQv/upttTN6A/z59aCSvG3Ix/KwGFw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e044e2d-aa50-4728-d83b-08d7d806b8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 19:39:27.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9geB2fBKpGoXZhYcUtRqX5O5m4Q0AIGfAdfZ5Mo5WdPeG77CsaR/oe3fLf3JOkNv3kESxjUAsY+AHUb16Pzvo2mrrP6eH0WwELirEpUGcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey all, Mark here again with another sighting.  If you're all WFH like mys=
elf during this virus period maybe this will provide you with a new puzzle =
to solve and pass the time, while helping to educate.  Our family big into =
puzzles during this period.

Here is the issue:
While performing an FIO test, for a single job thread pinned to a specific =
CPU, I can trap requests to the nvmf layer from a core and queue not aligne=
d to the FIO specified CPU.
I can replicate this on the baseline of nvme-5.5-rc or nvme-5.7-rc1 branche=
s of the infradead repository, with no other patches applied.
For a typical 30 second 4k 100% read test there will be over 2 million pack=
ets processed, with under 100 sent by this other CPU to a different queue. =
 When this occurs it causes a drop in performance of 1-3%.
My nvmf queue configuration is 1 nr_io_queue and 104 nr_poll_queues that eq=
ual the number of active cores in the system.  As indicated this is while r=
unning an FIO test using io_uring for 100% random read.  And have seen this=
 with a queue depth of 1 batch 1, as well as queue depth 32 batch 8.

 The basic command line being:
/fio --filename=3D/dev/nvme0n1 --time_based --runtime=3D30 --ramp_time=3D10=
 --thread --rw=3Drandrw --rwmixread=3D100 --refill_buffers --direct=3D1 --i=
oengine=3Dio_uring --hipri --fixedbufs --bs=3D4k --iodepth=3D32 --iodepth_b=
atch_complete_min=3D1 --iodepth_batch_complete_max=3D32 --iodepth_batch=3D8=
 --numjobs=3D1 --group_reporting --gtod_reduce=3D0 --disable_lat=3D0 --name=
=3Dcpu3 --cpus_allowed=3D3

Adding monitoring within the code functions nvme_tcp_queue_request() and nv=
me_tcp_poll() I will see the following.  Polling from the expected CPU for =
different queues with different assigned CPU [queue->io_cpu].  And new queu=
e request coming in on an unexpected CPU [not as directed on FIO invocation=
] indicating a queue context assigned with the same CPU value.  Note: even =
when requests come in on different CPU cores, all polling is from the same =
expected CPU core.
[  524.867622] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
[  524.867686] nvme_tcp:        nvme_tcp_poll: [Queue CPU 75], [CPU 3]
[  524.867693] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
[  524.867755] nvme_tcp: nvme_tcp_queue_request: IO-Q [Queue CPU 75], [CPU =
75]
[  524.867758] nvme_tcp:        nvme_tcp_poll: [Queue CPU 75], [CPU 3]
[  524.867777] nvme_tcp: nvme_tcp_queue_request: IO-Q [Queue CPU 3], [CPU 3=
]
[  524.867781] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]
[  524.867853] nvme_tcp:        nvme_tcp_poll: [Queue CPU 75], [CPU 3]
[  524.867864] nvme_tcp:        nvme_tcp_poll: [Queue CPU 3], [CPU 3]

So, if someone can help solve this puzzle and help me understand what is ca=
using this behavior that would be great.  Hard for me to think this is an e=
xpected, or beneficial behavior, to have a need to use some other core/queu=
e for less than 100 requests out of over 2 million.

Good hunting --- Cheers , Mark
