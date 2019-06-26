Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC7C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3235208CA
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 00:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rdabUBC4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ThPin5BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFZAmo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:42:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16562 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFZAmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 20:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561509764; x=1593045764;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TerptpOsnKzNbiPdKKm/mSwBbelgQmCue9kffTcmSZ0=;
  b=rdabUBC46u/WRGA6DhBSyLd3s7Tt8z07gNYnrijAcZ6npaDc4v8sCqb+
   bZvI+17P7Q8rJTgZNiEiGHP9p+g4pKXJaaLH4QvA1w3p0s7e+jw/SFc3G
   JCN3nf/oPnbymd/MhJmlnu3GUlGF00n8cqLKP/QgDsmzGyj+WanxWMBmB
   1QjYHvOsavGXJ220stZa1nLYuW32uFPp0js5d4iJgSlDBKSF+5cdQ37Dk
   jGoSUltkSQ+406/UhOwIvwM8sBq8+3cFRDajS1tYu63ErTs6uDwVCQF9W
   5g0O69B0HvOjkh6tEYzlwhUgLRNLCPEUGfdmn0C6g37aoBsNth3LqilYo
   g==;
X-IronPort-AV: E=Sophos;i="5.63,417,1557158400"; 
   d="scan'208";a="111534523"
Received: from mail-dm3nam03lp2052.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 08:42:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TerptpOsnKzNbiPdKKm/mSwBbelgQmCue9kffTcmSZ0=;
 b=ThPin5BAblTxqTWIgfdnmnYEnSwOLE8CtN7YAH+kaercuiyd2CW14p91PIf4lM++PFHmm4ug4wOwnl5UhqjO2yQ20TfiKjJ9Dm/Ty6trEntuCwVbN6oddQmYEFsKVKvvoq/oyxtk8wiuDzBVD36jYgyBVEGhXuPKyvgl/alUg74=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5367.namprd04.prod.outlook.com (20.178.50.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 00:42:40 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 00:42:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 1/4] block: add zone open, close and finish support
Thread-Topic: [PATCH 1/4] block: add zone open, close and finish support
Thread-Index: AQHVKDJPztuCEJ+OF0q7RsgYaqLWMQ==
Date:   Wed, 26 Jun 2019 00:42:40 +0000
Message-ID: <BYAPR04MB5816BCFFAF9648A7A55B144AE7E20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
 <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
 <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io>
 <79ca395d-8019-9ec8-0c0b-194ca6d9eda0@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c13c9e4f-5522-4ce3-d180-08d6f9cf31bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5367;
x-ms-traffictypediagnostic: BYAPR04MB5367:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5367BCE9913C94A69E6DFD45E7E20@BYAPR04MB5367.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(26005)(14444005)(4326008)(229853002)(6246003)(7736002)(33656002)(52536014)(72206003)(14454004)(256004)(6436002)(7696005)(53936002)(81156014)(2501003)(110136005)(81166006)(5660300002)(53546011)(66476007)(66446008)(64756008)(66556008)(76116006)(99286004)(74316002)(66946007)(73956011)(76176011)(91956017)(6506007)(186003)(478600001)(486006)(102836004)(66574012)(66066001)(305945005)(2906002)(476003)(55016002)(54906003)(8936002)(8676002)(316002)(9686003)(446003)(3846002)(71190400001)(71200400001)(7416002)(6116002)(2201001)(86362001)(68736007)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5367;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lRHTQDJ7Uk4HSzjOGfd8y6+C4tQy3ZjmtLrF3gWLqZUTEH2tDqOuy7rq8YlkbKgzwEDt8SzowetPm9Cmq92D94RufEZbLAhVD4TbxaNHyEinDrGvsfBRG/NELmkbO4cnyb5/ceslXdBdXKVOwH1T9V9pwhapE7lPR9G/fNE3a/xVMssex7b2p9es2u5pA2xB5NkP7g/n2G5fQ9CZAu/o93kFk0gcFg4pPhSlgpTMKlZd3in2MYgyYmiIvORus+r0gqkklw2C4ff/5vh3I0Fk7Zj0K2L+JVda1tTLCPy2O3eVUUHV2VPcUlZaYfWWTxknsrRFqu6B666JaKLFzuMyKF8OCN99uvMex62qguU/mzb2gVbqpVn0IvZwpPMiSCDaygdbzloS4KyMW0ipvtnzSh3ZVNzdBm1vZN/0KKviX6A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13c9e4f-5522-4ce3-d180-08d6f9cf31bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 00:42:40.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5367
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/26 0:56, Bart Van Assche wrote:=0A=
> On 6/25/19 3:35 AM, Matias Bj=F8rling wrote:=0A=
>> On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:=0A=
>>> On 6/24/19 12:43 PM, Bart Van Assche wrote:=0A=
>>>> static inline bool op_is_write(unsigned int op)=0A=
>>>> {=0A=
>>>> =A0=A0=A0=A0return (op & 1);=0A=
>>>> }=0A=
>>>>=0A=
>>>=0A=
>>=0A=
>> The zone mgmt commands are neither write nor reads commands. I guess, =
=0A=
>> one could characterize them as write commands, but they don't write any =
=0A=
>> data, they update a state of a zone on a drive. One should keep it as =
=0A=
>> is? and make sure the zone mgmt commands don't get categorized as either=
 =0A=
>> read/write.=0A=
> =0A=
> Since the open, close and finish operations support modifying zone data =
=0A=
> I propose to characterize these as write commands. How about the =0A=
> following additional changes:=0A=
> - Make bio_check_ro() refuse open/close/flush/reset zone operations for =
=0A=
> read-only partitions (see also commit a32e236eb93e ("Partially revert =0A=
> "block: fail op_is_write() requests to read-only partitions"") # v4.18).=
=0A=
> - In submit_bio(), change op_is_write(bio_op(bio)) ? "WRITE" : "READ" =0A=
> into something that uses blk_op_str().=0A=
> - Add open/close/flush zone support be added in blk_partition_remap().=0A=
=0A=
Sounds good to me. And indeed, all operations should be failed for RO=0A=
devices/partitions. Of note though is that only reset and finish operations=
 have=0A=
an effect on the zone data. Open and close have no effect at all on the zon=
e=0A=
data and only change the zone condition/state. But since they do change=0A=
something on the drive, we can still consider them as "write" operations.=
=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
