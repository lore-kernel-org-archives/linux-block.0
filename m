Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA5C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 06:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3618620851
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 06:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hk8DUxYM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="THexjzUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfAQGSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:18:24 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26666 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfAQGSY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 01:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547705904; x=1579241904;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RKQ2lp8bC7ZRmlVaGzwKb9ZiBHtHKJo6mXRCCR5HUVI=;
  b=Hk8DUxYMLro7YwIcuH2nhmeFCWCk4wZWE5jrk94kn9uMhBn7IiWWQGnP
   G5ZYR+7QRePl82dTe7aGH2P5FJLd8byyMXQHW0qlYvCXpWuld2GSZKTGr
   fPAhT3kkdmqhDzaLH8qF2OS+oZQXbWH7IV4reQsW3/+20uDUMY+p9spO8
   AQKfVZKsvGKZRz+tUiEV1dW+Oj+RK58/WSoqp//NI1UmJNxXS1F8ehJVO
   ELVSG70aeo7ZWRao9RCnjZgM3BWTtm2sH9zalMKfoHpypsqu5e86PwoWw
   SP6YH2AMJVF/SsS1oIO7P621q3w2bOLb7zDz126t0+LfjXfkmUikGp6Kv
   g==;
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="103955341"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2019 14:18:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKQ2lp8bC7ZRmlVaGzwKb9ZiBHtHKJo6mXRCCR5HUVI=;
 b=THexjzUzLV8+BL0vjnt4re992qE6TqVswhmSnvA6mlg6oJR7r7y4txYDQvfsY0teouof4v4N4jCIfF7w/ajhqRKNRxs2M4kNXoxyKUXLS9m42mxvNa7ifPw5yvo1SwHVchvbIHhCl7thpd5QstS/kqYi6teJXi2qNyIlDzJ+xNE=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2042.namprd04.prod.outlook.com (10.166.191.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 06:18:22 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 06:18:22 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 03/16] common: Move set_scheduler() function
 definition
Thread-Topic: [PATCH blktests v2 03/16] common: Move set_scheduler() function
 definition
Thread-Index: AQHUqMgl2Aet2kYBMUeS9geMqb0dGw==
Date:   Thu, 17 Jan 2019 06:18:22 +0000
Message-ID: <CY1PR04MB2268CE31060A326C6E4B4BA5ED830@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190110093725.32675-1-shinichiro.kawasaki@wdc.com>
 <20190110093725.32675-4-shinichiro.kawasaki@wdc.com>
 <20190117021845.GC25494@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2042;6:02M6zrvMsZR+/CtDsKjA7JEi+FhweORqfc5UwVAES+BxT/9fOWmJK+nZ9suYhISqY0OEs5SEVh/HkxVe+6NHnDpQWLQDCO1+SFPYFfoGI0CHEzELg6dezI31zfEUDi9F92lXio16R7zaeXLGZh8DGbaNylCHCAdDCK7e0/tEHEEQZRChtDHU3ujQ7UD4fJ7glSKxJYWXRr/Nz7Q0ysEJAjDKpyJikRsijinu4N6FX4wCVXhohqaUBvNWAhAvrujqrAV6ZfbyifeAhfA3WyKRuIBNO4J0KFHspBvMGXKaHZSrKpQ1uJLjUOlvVVjw9lTmnmlgAsdNQbOv759VeXynSuprnrJP/To8Spe52ydlMCcmlnWU9h7KFd6fmKHky0nkHol7SrwHn7I9DNlIYIJ4J9foHZTLZ0+Fhg+G31fTxkHJOpzM2aovtuarRHkF9S2i4miTUlczz0/bXtmVGZ0b3g==;5:IVNJx8gmFNRkKW4tPPsHBksW5E991ntXr+j+0URxIk69sYT07AM9rm6EbffCPM4VK7Ap30Fsw1wxlwdFKBXFR36FgMKJdZZsuwZj9ikAMCpu5wKWzvDg67jpH2qkRtk+PW7UZJrSESorUGMMBzdUhgyrBZ9I7IcfSuHD0LgPOPHOToLioQ7cUz9HRpbxHsP6tifOZATSvMlXTqTKCVp2ew==;7:/wAxOkyC3cuXtMkdLGNnqmMlSi4UbxMDM+gj8HqA6ek0J78d5QDJhL56SScM3d4kSO7x5sSHHOoPNzn5sL8o5Y2uX4VJ2CaYHUWhup9EBOWDNVjdFaMHMH+bRsukrH+Si24+j+qg/LKcfDLN1D1HXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1f792bae-6520-4436-1de7-08d67c4394ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2042;
x-ms-traffictypediagnostic: CY1PR04MB2042:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB20423DCD60CC314F8A95A4FCED830@CY1PR04MB2042.namprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(305945005)(7736002)(8676002)(8936002)(55016002)(81156014)(81166006)(53936002)(9686003)(5660300001)(14454004)(44832011)(97736004)(86362001)(2906002)(68736007)(478600001)(6436002)(3846002)(6116002)(26005)(71200400001)(6246003)(25786009)(71190400001)(186003)(4744005)(74316002)(7696005)(76176011)(6506007)(53546011)(33656002)(256004)(102836004)(316002)(54906003)(4326008)(99286004)(229853002)(446003)(105586002)(106356001)(6916009)(66066001)(486006)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2042;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0WX1XWlOArE+FHOcQQSCMB6inzz0FYYbS8we4DQqQhS2V92HyovngGSIUbESGjxSD0g1g7PEtF9ULbGmX7O0u6CAzDk/3pcvtZYczGzTBlcGkLGMjwl7Db1gVadG2K1rM/YKZdfWRTegYtVVEamn+Pe3XvO0K+6D4Jgu4zUDsCVikUTEHt06p9gXBfvJyTAGzhZPQ7EBkODDxo/QzpBIzUZlQPn57MxODysu7T56B3K5OmOZB0+m4n+LUnwK07mJtPXTm4dTW6bNHKjGK+SPl0W57DoBLZLnWuZF1M89Q6RKEushNuhux+T3PG6E1chtRzUe1ISLfa/SlDF4KihIi3xI3dqXhCz+sO7rPtDqULyHml1kTILaTQb+CTvRm5Ah4QnPq9INBnwW1UzIUPW6y4bUwuRCtbnMPvMV8klw/7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f792bae-6520-4436-1de7-08d67c4394ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:18:22.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2042
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 11:18 AM, Omar Sandoval wrote:=0A=
> On Thu, Jan 10, 2019 at 06:37:12PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> set_scheduler() function defined in common/multipath-over-rdma is useful=
=0A=
>> to set up a specific IO scheduler not only for multipath tests but also=
=0A=
>> for zoned block device tests. Move this function to common/rc to allow=
=0A=
>> its use in test groups other than multipath.=0A=
> =0A=
> The preferred way to set the scheduler is:=0A=
> =0A=
> _test_dev_queue_set scheduler "$scheduler"=0A=
> =0A=
> This function is in the multipath tests because it was a preexisting=0A=
> test suite which was merged into blktests.=0A=
=0A=
OK. Will use _test_dev_queue_set instead.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
