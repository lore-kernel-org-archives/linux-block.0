Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF84C35671
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8220732
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lr2fGzkj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JUUtWGCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgBXL2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:28:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30003 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXL2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 06:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582543716; x=1614079716;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AFfIc6uHGhPMT38XvbGmlOQXXO2gtEFy3Io5/gC+11U=;
  b=Lr2fGzkjj/Vy0cIAvhUNG/dxG/tuQ19sOkTaT5iz0oYS10rjpcQDEDwV
   mYsLc3oUvBk/njClVVljE4IhjQi3NKRgufrvdnRyKAnAvgCmudsj6UeXz
   YTFsFaeFEy60vt2hGfqmG6l5PVBFnLAZgvuOfymKD0U5L3nG5nSchZ2U7
   gWL0Esi8LAXQt2Uf7a0ZOnC9R4AXGpbVQ3psrhQ9eXGF4Fie2/5Y/eEEM
   u0xMLy33v/LC+EDkSwmFmgWoN2Cre8nGG7cX4WI0eXLYEm9rm7hedANhz
   Imj0gYD171ayquzpbp7fEF/2YMPsKGBom+Aj9w9Kxg9yRk5PUVsxqviwR
   w==;
IronPort-SDR: AmQjkee4wQq0O4eNvaBqOlf8Kg4YgPgz9pexvofg4nyWwowP+YnEqhQdmkC6qMDSScIylAbGE4
 uKzGPh6RowVkyb9oItK+Oe0h4bu0xh/vLmq7Sve84YsDzHZFzSFgce/JUGZ5Q+SfOrsHv3PXbW
 cadPQK/AuljMqRqshv5HmgIoKKyhtG2ZK2B4fJVxEysNte0D+PnLEnZStWc3+8YvrfMn7xTj9f
 5lKiE7lh0xNf4EA6bhxuiKgIZSV104gVvMPaBzamCkucF9TE5yDtcdcSjCPxV/gLBVvBwiJCI2
 OrU=
X-IronPort-AV: E=Sophos;i="5.70,480,1574092800"; 
   d="scan'208";a="238710726"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 19:28:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHZ6n7f1mGO2UhT7tXP7UgBtPfLp85DOJjdzE4nDp5VXQCCWsVUeZVmk+9o/AUaZq//a6xuTrFuWA08UgHwBAw96X3mPm20cjC577IH8bcEeXu14X3AFqqEenOjW7q+VWJp72iE729ViRAyd//gtOhN9oHrHZLllE2VsFNzuxcB7cn7kSKNGfmHht88oYqb/OkBsIBMc+ZhrQDNHNdjPd6pFrUnEZrmJVoZNcucwg6YvLINt+/LsjDoVj6oLRZ+E8EkE7LzaQxHmWCD7tkfE2ct2UXICfZQcpd7bbAsa231h4li+ZqKLP2CZEriV7x62BPsrNH+YecTXnRco3uGeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFfIc6uHGhPMT38XvbGmlOQXXO2gtEFy3Io5/gC+11U=;
 b=n7PVB9ZplrkKkfNNszXa6r05JxLlmv3RpCw1WQf2oQbbEXaXshguXMeCLh3NjGYgffeBokNEuyFhae4s10hpAZ4Lz8zIWaWVB6ftnu1RnFAUh6n5XxR4d5qTUFO7hM7Pce8CC3CrbxtZ4HEBEXRG+niSmN8m6JKsF58wTMLbFkRMnwGeREC8O0Bf742fktmkAn/j5Xp7FYekxzG7NJH0vQmzWT/mu+TzCh41wtNGVwjX5vXYCk8QJyVKp2KqWN/pXKFyGYMmGuLHrBTvHtlQyXYgNKN0XA2n91ZT3cO3In3jjaJ8jSN2LKB1yRr4GCnyiypyg6YSQiPG9vkyW1bkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFfIc6uHGhPMT38XvbGmlOQXXO2gtEFy3Io5/gC+11U=;
 b=JUUtWGCjPFIwKOdkd/WnZYaj3BXgRhj8xiC74iwWEFqe4oG9m+smgAIElxPr7ZiBeMGYTNwCrPnfJU8zC1Yk+XS+V7r7IGgOOw6gSy8sbdIjenjRigt73xdfmEiNYC8O5oOp9osFTcvuyfabm5xWY9Bcx8fEb7R3QlcJgSIW3bo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4632.namprd04.prod.outlook.com (2603:10b6:a03:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:28:35 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:28:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v3 4/8] null_blk: Suppress an UBSAN complaint triggered
 when setting 'memory_backed'
Thread-Topic: [PATCH v3 4/8] null_blk: Suppress an UBSAN complaint triggered
 when setting 'memory_backed'
Thread-Index: AQHV6GY6yAbZ6YH2UEy8eXYkREj5vw==
Date:   Mon, 24 Feb 2020 11:28:35 +0000
Message-ID: <BYAPR04MB5749D28FD6A0B9A3EB58652C86EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12c44100-d1ea-4b6b-895c-08d7b91caf8f
x-ms-traffictypediagnostic: BYAPR04MB4632:
x-microsoft-antispam-prvs: <BYAPR04MB46325033BBBED7088360273986EC0@BYAPR04MB4632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(81166006)(478600001)(33656002)(81156014)(8676002)(186003)(26005)(7696005)(71200400001)(8936002)(53546011)(6506007)(5660300002)(54906003)(4744005)(110136005)(4326008)(66556008)(66446008)(66946007)(55016002)(86362001)(64756008)(9686003)(76116006)(52536014)(66476007)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4632;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zPLoLBSROeGfvWO4G4vst9DwxwAV0qPXMziUQZlmSwBMIXdmIcSIareMLt1nnRoSz3ozWs93uiMXH8SiIQVrs+Mg7PUHf3HrIdO9BGZr+DdpOajHuLs1b3wk8YB/qi+HMne4OEA9nypa1at6n7omgLOs5aSWjqCcqLyRzNF1gr6t3p2Ns3tdwkT3CyoVyrM3dmu5Wa8DuyoAK2b0MA8johoS/mzJrP5aL3i3FLqfABtkXAAYjam/8GdsUpqIfydeMa055V1JprpTlWr+zSj2SYdEJWBWd91k3nmRKCm09rQA4YIVbVQ+/PPgZ9P3FlJD9oJjW1QCPkv9QFcTFV/ZI4B9/sZP56Bfb21cqh4nS8lKb3KwU40giJIzYftFGqJ0xXdzNz8L/ofsV/ESPq9/1Z15pQ3Du+hRsFwBLUZrVn2GSgpcEQRqfN/mBpHlZlKW
x-ms-exchange-antispam-messagedata: 6JRQSzjk7wgTDXkuYx53Sd6zstWjX5by81a5UupcVRKansOwuYg0g0zj+UDi+J/CNWlU+MyU96ZqXN9vKkImpHuzhnc+B/FYF5VdG4zSHOU0dHm4qEiHwnaRS/9yshtpkFQA8Qw5DaCGhLHyBlMl5Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c44100-d1ea-4b6b-895c-08d7b91caf8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:28:35.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ot9VjZi3IKRrOgGeuamkdQfy9yj1qPPhnYjTSlI4B0p/DnKUaZpPSQt22Jm4ISmih4bUiRfxl6UJYB7yuqYGwoist7QpEX+0gmSj8KjYD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4632
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/20 7:23 PM, Bart Van Assche wrote:=0A=
> Although it is not clear to me why UBSAN complains when 'memory_backed'=
=0A=
> is set, this patch suppresses the UBSAN complaint that is triggered when=
=0A=
> setting that configfs attribute.=0A=
Is it due to "An uninitialized bool will have indeterminate value and using=
=0A=
=0A=
an indeterminate value is undefined behavior." ?=0A=
=0A=
In any case, this patch looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
