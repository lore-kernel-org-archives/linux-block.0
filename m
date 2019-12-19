Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC83C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 19:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9142D21D7D
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 19:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mQIYq+PV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfLSTZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:25:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:26344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfLSTZz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 14:25:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 11:25:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="218266184"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2019 11:25:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Dec 2019 11:25:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Dec 2019 11:25:53 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Dec 2019 11:25:53 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 19 Dec 2019 11:25:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLnq3eCyT46Bb0XZe03ysIbdLL1UTR5KFbSc1zZIj4gD6JkM9O+Hf1yYwXmOVd9Ev2cRZ5FMS9uuj1/GJ1h6dzkoLjyct/hZGK+SdLHVSce0xzh1aoF1/NOQvZv4pDc4QEAZBsYR48gBwyQTUufW2pQrcjQdoCN3NdDfI9g89LSITXz9fKg7E01rdH6EcQjfk+TDkSsCWgkMxZFJAgdqN0jWZscZEEkrYc44NTMjZWwyzkASauQd/usFWGKpfKbHh2TqAvQkyysqBWTqCz8YCMD4FzaMzced1dHNHVYtePaU9Mp2XsA8wRSGeEMCIkp95CnA5VQtibj+/WfgpfVXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9qoaflxNsz25EAXUaQMCQeYBmfyLyHsNV3wIBD5Ecc=;
 b=Q9iw88TezHVgffoGIuqKItqRoYJcklCbO/envzvAZnU6/wH4fTWBH61EYW7OFlgqrRNTQiqlR7H5Cdzu0ltP7WLdZ3Zv4DdLTjE8PqUYc+zsDJ4VwdHLClHf2aMQ9y1xUxq3Ps0j88A6PALAM6SQYY8877QCWpaO0ZLUFdq/oYe923LzlktrCUpeQ1kgHCBNu83DeO91g6Fj06CcUGbr5QA+9S3iARR6AdIMCZTmXEIxZ4rOBaKLWHzOthQqK+Xc1l8SwfKeDW3qj3J/KM1UmUGKRusXFtMqHPUyzXueE97Rpgai2hnVCdgwjIWOSAB4SqpAE5lvIlD5V9FYnGNv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9qoaflxNsz25EAXUaQMCQeYBmfyLyHsNV3wIBD5Ecc=;
 b=mQIYq+PVXpi68pPtMC6KM9aI4P+4UkPoGxCdfXDZfQ8ETMws9+TGTqMRVJzQOvGl7ngw4gLnFvP+10LEk8BOQDZstCXIjo5h+SGmt6w5CMiDk3Qs+chatieIJLH0kRCGIiH9JcYsrpkcxhwKjoBlDnAQ/1tZaDilqflzmZftVj0=
Received: from SN6PR11MB2669.namprd11.prod.outlook.com (52.135.90.153) by
 SN6PR11MB3134.namprd11.prod.outlook.com (52.135.127.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 19:25:51 +0000
Received: from SN6PR11MB2669.namprd11.prod.outlook.com
 ([fe80::5db8:ff89:9146:d508]) by SN6PR11MB2669.namprd11.prod.outlook.com
 ([fe80::5db8:ff89:9146:d508%7]) with mapi id 15.20.2559.016; Thu, 19 Dec 2019
 19:25:51 +0000
From:   "Ober, Frank" <frank.ober@intel.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "Rajendiran, Swetha" <swetha.rajendiran@intel.com>,
        "Liang, Mark" <mark.liang@intel.com>
Subject: Polled io for Linux kernel 5.x
Thread-Topic: Polled io for Linux kernel 5.x
Thread-Index: AdW2ohLJtbfHvfzMSqCNfckqZUjK2w==
Date:   Thu, 19 Dec 2019 19:25:51 +0000
Message-ID: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTQyNTllNzUtMTcyYi00OTQ4LWI3MWUtMWUzNzM2ZGE3ZTgxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoialwvbng2Z1ZZZVRvcVFLanNHNnBwSlZBZElicW9JQmhQWmNYRFlKNmhyNEtcL3BmUlpkdEJ1WDlzeEVJeUpmd3hZIn0=
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.ober@intel.com; 
x-originating-ip: [192.55.55.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ae56d15-d3a2-4056-16a2-08d784b9426b
x-ms-traffictypediagnostic: SN6PR11MB3134:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31349DE5CF95034820BEC3138B520@SN6PR11MB3134.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(66556008)(316002)(55016002)(966005)(107886003)(8676002)(71200400001)(66476007)(8936002)(66446008)(2906002)(33656002)(26005)(52536014)(6506007)(64756008)(66946007)(81166006)(54906003)(76116006)(81156014)(5660300002)(478600001)(86362001)(186003)(9686003)(110136005)(4326008)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB3134;H:SN6PR11MB2669.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eOIRikFGRd+vqx3WNL7wSw9ksRHGa6DOw0SCLINNRrRaA031rzevv5/iP5eOblq3YYZMj7/Y/urywPA4MAwulxpGJmFRYFQ96XGpMfSr00jTVEwVdTzHr5D5QXpwb1VjhPyozmAH/DcuRuPIf3psZqH4hmu5G/92ca/FnTCl5mvpEsRBDLDWBoJ70nlgcXlK99PpRuJ0m6n8A+O/HU1gMsu0mRNHlaqQLBybCGwFdSl9L1s8Kf35J4tlx3aNNnu29b6tlLk321gVjQgt3XRJQtoyXN/T981+1R/mkcaEDTisJIJXrbHIhXC4i6/RhbTLQgpJzND5uHHZPcOrJGDLPJyE44EnpaopkgnWD4m5u2ZPDCv7+tHLqqNDwFH3emNBEC+qzi+Akj8Br70TicxXI+dOI2Wk0w4/+mTocI6IDwo/ZeGV8ivMybKdZfhRzdiJrpUGjI6odqVp/n3frA5ko/5bUYrkhWlCwat9aIZkiT8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae56d15-d3a2-4056-16a2-08d784b9426b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 19:25:51.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3qQrTJPQFvN0fjFkapVwoJubGrQK+9l+C3TsJm6x7mNfuWSorYnQvCsknlDULTX54uwrJcUUQb9vUP/JO8NVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3134
X-OriginatorOrg: intel.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi block/nvme communities,=20
On 4.x kernels we used to be able to do:
# echo 1 > /sys/block/nvme0n1/queue/io_poll
And then run a polled_io job in fio with pvsync2 as our ioengine, with the =
hipri flag set. This is actually how we test the very best SSDs that depend=
 on 3D xpoint media.

On 5.x kernels we see the following error trying to write the device settin=
gs>>>
-bash: echo: write error: Invalid argument

We can reload the entire nvme module with nvme poll_queues but this is not =
well explained or written up anywhere? Or sorry "not found"?

This is verifiable on 5.3, 5.4 kernels with fio 3.16 builds.

What is the background on what has changed because Jens wrote this note bac=
k in 2015, which did work in the 4.x kernel era.
But now things have changed, and there is not a new lwn article that has re=
placed the one here:
https://lwn.net/Articles/663543/

More documentation can be found here on the confusion that exists today is =
here: https://stackoverflow.com/questions/55223883/echo-write-error-invalid=
-argument-while-setting-io-poll-for-nvme-ssd/=20

Can a new LWN article be written around design decisions, usage of these po=
ll_queues?

How come we cannot have a device/controller level setup of polled io today =
in 5.x kernels, all that exists is module based?
Thank you!
Frank Ober
