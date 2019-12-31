Return-Path: <SRS0=i4wP=2V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31832C2D0C2
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88B5206E0
	for <linux-block@archiver.kernel.org>; Tue, 31 Dec 2019 19:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hnChKHCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaTGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:06:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:1963 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfLaTGG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Dec 2019 14:06:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 11:06:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,380,1571727600"; 
   d="scan'208";a="251781637"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 31 Dec 2019 11:06:04 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 11:06:02 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX160.amr.corp.intel.com (10.22.226.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 11:06:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Dec 2019 11:06:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuHZS4Ut6Mapz0LFsNq2ohACqR8FJ6C2UBk55hnlv6PLYCRcZm32JxKFxAU9IV/Q8BDJmaTPr70vjeOMF2x8lgOXjqa27y3KjhUAXQ80XorV8BuRXNMAx3n4lOjOEBUSdnKmYwL6jsthSn7HDgBYl0CQpH+WXV0o+QjCLoLSCxsKKlOvy2/LzFUiSwFa5hURXsRHWAXMcfxI4yizXHge2l7HVmJEUMnz9m3Hefw8qlCyonbB64z34RZohN4jUGNUhCi3kD0fA8/GU/UXoMI3SaYVPoo0al7FwLG4aAJ5RUihlUYHJI4DX+oM9VMz2vIEg7gnjA3qCtlzKBnSg5NcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+3W7THmqbXU9PUy0AYyAakFQQgzRES72CxmyODZsj8=;
 b=OvFMQ7dn6UCNIwPIDVyfBwDtNJhwLiVRW3wYbVVhOj+HjYwbQ7TqOkNNbjYbjULMRwGpW0IBziC5tgBVqXdu0S/h7eJHbU10vMd/gz8RXiWufPQQ/+mR4F4ygj5SPfdrgAtwB0iKP4PBsbLF1Oya8PA6kqrh+Smxpsp5VOvjeseJ9i9Zklf7Vx/Xy4aKU7exuhioxw3+4Rlg86J8jU1vLCLHQ9OL88ehhhdK+Ib2GRACmxupYKUNOiLJVdTcYbBwnDoCZ65/SAvYydBqomammLBu8D1i9HCwUL35XnezsUf5LlR4V9P8yY9BFJJyN1KwLuxNiaVEesbThZJtxwCiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+3W7THmqbXU9PUy0AYyAakFQQgzRES72CxmyODZsj8=;
 b=hnChKHCdP3UcedK/S5+P4hEY2QNveLc6pHjbAETRqSgtouKcXUrOsaJjAXflv+CBoZDpaSpNsQsTwSD3kljZawxpQU1Hx2LA132/+Eq1E01K3yC8+VaCDi0S09lvVC1BgPM/VmR+etmIqIKmUszSNZ/R4/hP7ipvzN5nUqWLl1A=
Received: from SN6PR11MB2669.namprd11.prod.outlook.com (52.135.90.153) by
 SN6PR11MB2944.namprd11.prod.outlook.com (52.135.124.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Tue, 31 Dec 2019 19:06:01 +0000
Received: from SN6PR11MB2669.namprd11.prod.outlook.com
 ([fe80::5db8:ff89:9146:d508]) by SN6PR11MB2669.namprd11.prod.outlook.com
 ([fe80::5db8:ff89:9146:d508%7]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 19:06:01 +0000
From:   "Ober, Frank" <frank.ober@intel.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "Rajendiran, Swetha" <swetha.rajendiran@intel.com>,
        "Liang, Mark" <mark.liang@intel.com>
Subject: RE: Polled io for Linux kernel 5.x
Thread-Topic: Polled io for Linux kernel 5.x
Thread-Index: AdW2ohLJtbfHvfzMSqCNfckqZUjK2wADBvUAAAGTGCAAMbepgAIjiEog
Date:   Tue, 31 Dec 2019 19:06:01 +0000
Message-ID: <SN6PR11MB26691B36D7AEF22393CC04F38B260@SN6PR11MB2669.namprd11.prod.outlook.com>
References: <SN6PR11MB2669E7A65DD0AD9DC65A67C58B520@SN6PR11MB2669.namprd11.prod.outlook.com>
 <20191219205210.GA26490@redsun51.ssa.fujisawa.hgst.com>
 <SN6PR11MB2669F3546ADCCAEF1D8E50308B520@SN6PR11MB2669.namprd11.prod.outlook.com>
 <20191220212049.GA5582@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191220212049.GA5582@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGYxZjYwMzUtNjhkNy00MGFlLThjYTgtNjk2YmJkNTVmNjA0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUk8zV1ZDcFdwZEFyWHdJN09IK1BPdFVJV2I4UWJBaThzYmxDZGM1ZlwvTElGMmU2TWsydVpOMlg1NVNac3phRzgifQ==
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=frank.ober@intel.com; 
x-originating-ip: [192.55.52.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5abf5fb1-592f-4fbe-4c44-08d78e247a29
x-ms-traffictypediagnostic: SN6PR11MB2944:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB29443DB03F9CCBA0BD1B7B718B260@SN6PR11MB2944.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(13464003)(189003)(199004)(107886003)(9686003)(478600001)(4326008)(7696005)(26005)(53546011)(52536014)(6506007)(33656002)(8936002)(66476007)(54906003)(66946007)(186003)(55016002)(316002)(86362001)(66446008)(66556008)(64756008)(76116006)(6916009)(5660300002)(71200400001)(81166006)(81156014)(2906002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2944;H:SN6PR11MB2669.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: juO6mXtRGbc8SjOY1VJP1vR0nkhW1ty7kElWKpdY9I4FKk8lIHYiRFIgnVADo9XgPJSnmVRLqqaDC3SK3y/v+aSzxX2jt/bc32UP7b0uVfYrV4pm1FuTSLftKRdCrUd3xrjbGk6les2oTdcoQj4h0G5P2liMurU1IqTtPS9WYYqKVcXatMQ8L8uz1dUYbGmZGioeOSH/OX7PmrKLqKSfa3qUSaXuHA6cafFGdJSH7BtJ8YIj20woX4ZaG4tVFx0kwqR55ukUMUG47qL3SoENVoX2uAbwU5hQt7vjXp3Z1XLefYD+lhrG51vpp7aKPQhH0q+F+fw2hhUM5lDYw8mbQLUd8cGfWlCI5eLsTA2qhCO/iLYXXecbRhb8CsePlgwOAjAgIMLKdxjgJypNphhvqgVy/6grihIDr57+TWNb4Azs8NdYD8ekFUSsVih5KwGooUUKNYX+VXL9E2q7+vsFNs0AIAAL92IgeH4/42AYmJ2rEhrSNuKIgNLQVpudlH9u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abf5fb1-592f-4fbe-4c44-08d78e247a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 19:06:01.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2nFyA3UCBlkhYN4GAzypB4umxAuM9LUw/rM3l3J6apjWi7oR8CqYXqBdq2X9TzO3K9BFMktxe1iF1ezgNne1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2944
X-OriginatorOrg: intel.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith, so the performance results I see are very close between poll_queu=
es and io_uring. I posted them below. Because I think this topic is pretty =
new to people.

Is there anything we need to tell the reader/user about poll_queues. What i=
s important to usage?=20

And can it be dynamic or do we have only at (module) startup the ability to=
 define poll_queues?

My goal is to update the blog we built around testing Optane SSDs. Is there=
 a possibility of creating an LWN article that will go deeper (into this ch=
ange) to poll_queues?

What's interesting in the below data is that the clat time for io_uring is =
(lower) better but the performance in IOPS is not. Pvsync2 is the most effi=
cient, by a small margin against the newer 3D XPoint device.
Thanks
Frank

Results:=20
(kernel (el repo) - 5.4.1-1.el8.elrepo.x86_64
cpu - Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz  - pinned to run at 3.1
fio - fio-3.16-64-gfd988
Results of Gen2 Optane SSD with poll_queues(pvsync2) v io_uring/hipri
pvsync2 (poll queues)
fio-3.16-64-gfd988
Starting 1 process
Jobs: 1 (f=3D1): [r(1)][100.0%][r=3D552MiB/s][r=3D141k IOPS][eta 00m:00s]
rand-read-4k-qd1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10309: Tue Dec 3=
1 10:49:33 2019
  read: IOPS=3D141k, BW=3D552MiB/s (579MB/s)(64.7GiB/120001msec)
    clat (nsec): min=3D6548, max=3D186309, avg=3D6809.48, stdev=3D497.58
     lat (nsec): min=3D6572, max=3D186333, avg=3D6834.24, stdev=3D499.28
    clat percentiles (usec):
     |  1.0000th=3D[    7],  5.0000th=3D[    7], 10.0000th=3D[    7],
     | 20.0000th=3D[    7], 30.0000th=3D[    7], 40.0000th=3D[    7],
     | 50.0000th=3D[    7], 60.0000th=3D[    7], 70.0000th=3D[    7],
     | 80.0000th=3D[    7], 90.0000th=3D[    7], 95.0000th=3D[    8],
     | 99.0000th=3D[    8], 99.5000th=3D[    8], 99.9000th=3D[    9],
     | 99.9500th=3D[   10], 99.9900th=3D[   18], 99.9990th=3D[  117],
     | 99.9999th=3D[  163]
   bw (  KiB/s): min=3D563512, max=3D567392, per=3D100.00%, avg=3D565635.38=
, stdev=3D846.99, samples=3D239
   iops        : min=3D140878, max=3D141848, avg=3D141408.82, stdev=3D211.7=
6, samples=3D239
  lat (usec)   : 10=3D99.97%, 20=3D0.03%, 50=3D0.01%, 100=3D0.01%, 250=3D0.=
01%
  cpu          : usr=3D6.28%, sys=3D93.55%, ctx=3D408, majf=3D0, minf=3D96
  IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D16969949,0,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1

Run status group 0 (all jobs):
   READ: bw=3D552MiB/s (579MB/s), 552MiB/s-552MiB/s (579MB/s-579MB/s), io=
=3D64.7GiB (69.5GB), run=3D120001-120001msec

Disk stats (read/write):
  nvme3n1: ios=3D16955008/0, merge=3D0/0, ticks=3D101477/0, in_queue=3D0, u=
til=3D99.95%

io_uring:
fio-3.16-64-gfd988
Starting 1 process
Jobs: 1 (f=3D1): [r(1)][100.0%][r=3D538MiB/s][r=3D138k IOPS][eta 00m:00s]
rand-read-4k-qd1: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10797: Tue Dec 3=
1 10:53:29 2019
  read: IOPS=3D138k, BW=3D539MiB/s (565MB/s)(63.1GiB/120001msec)
    slat (nsec): min=3D1029, max=3D161248, avg=3D1204.69, stdev=3D219.02
    clat (nsec): min=3D262, max=3D208952, avg=3D5735.42, stdev=3D469.73
     lat (nsec): min=3D6691, max=3D210136, avg=3D7008.54, stdev=3D516.99
    clat percentiles (usec):
     |  1.0000th=3D[    6],  5.0000th=3D[    6], 10.0000th=3D[    6],
     | 20.0000th=3D[    6], 30.0000th=3D[    6], 40.0000th=3D[    6],
     | 50.0000th=3D[    6], 60.0000th=3D[    6], 70.0000th=3D[    6],
     | 80.0000th=3D[    6], 90.0000th=3D[    6], 95.0000th=3D[    6],
     | 99.0000th=3D[    7], 99.5000th=3D[    7], 99.9000th=3D[    8],
     | 99.9500th=3D[    9], 99.9900th=3D[   10], 99.9990th=3D[   52],
     | 99.9999th=3D[  161]
   bw (  KiB/s): min=3D548208, max=3D554504, per=3D100.00%, avg=3D551620.30=
, stdev=3D984.77, samples=3D239
   iops        : min=3D137052, max=3D138626, avg=3D137905.07, stdev=3D246.1=
7, samples=3D239
  lat (nsec)   : 500=3D0.01%, 750=3D0.01%, 1000=3D0.01%
  lat (usec)   : 2=3D0.01%, 4=3D0.01%, 10=3D99.98%, 20=3D0.01%, 50=3D0.01%
  lat (usec)   : 100=3D0.01%, 250=3D0.01%
  cpu          : usr=3D7.39%, sys=3D92.44%, ctx=3D408, majf=3D0, minf=3D93
  IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D16548899,0,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1

Run status group 0 (all jobs):
   READ: bw=3D539MiB/s (565MB/s), 539MiB/s-539MiB/s (565MB/s-565MB/s), io=
=3D63.1GiB (67.8GB), run=3D120001-120001msec

Disk stats (read/write):
  nvme3n1: ios=3D16534429/0, merge=3D0/0, ticks=3D100320/0, in_queue=3D0, u=
til=3D99.95%

Happy New Year Keith!

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Friday, December 20, 2019 1:21 PM
To: Ober, Frank <frank.ober@intel.com>
Cc: linux-block@vger.kernel.org; linux-nvme@lists.infradead.org; Derrick, J=
onathan <jonathan.derrick@intel.com>; Rajendiran, Swetha <swetha.rajendiran=
@intel.com>; Liang, Mark <mark.liang@intel.com>
Subject: Re: Polled io for Linux kernel 5.x

On Thu, Dec 19, 2019 at 09:59:14PM +0000, Ober, Frank wrote:
> Thanks Keith, it makes sense to reserve and set it up uniquely if you=20
> can save hw interrupts. But why would io_uring then not need these=20
> queues, because a stack trace I ran shows without the special queues I=20
> am still entering bio_poll. With pvsync2 I can only do polled io with=20
> the poll_queues?

Polling can happen only if you have polled queues, so io_uring is not accom=
plishing anything by calling iopoll. I don't see an immediately good way to=
 pass that information up to io_uring, though.
