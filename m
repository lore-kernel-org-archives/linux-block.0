Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ECAC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E06204FD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AIrSl7Vp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jd5PVhwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFYQvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:51:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51920 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFYQvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561481516; x=1593017516;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mAEKh2f2qxE37FX9Gt8rNXvP4TmZRL0/AtUPeup3d/I=;
  b=AIrSl7VpZBI/a46L5MzTUJLCuso6wQhjF9qtl++C2AkW9omSEz8jHRLW
   xSH+iaV5JXzo4NYwIm4b/Gtcoqwq8W2a7lEMIP+R4xf7O55uu+Rsh3Ugt
   vOzNF5TuYACTH2es7NRm5eAEhOkJ77S7gt7rASNQ/Rreekllbykm5rRam
   wkuKFJV3w/4cfOMPVnBc4q7O1U272ZDtAbjCMaNqw2YjlqeYdrd/WwWFj
   bnFvl+oug9QxdaK3MiDfWG3v834UCpxMdHhpm5KvDWY3TmFKp2hOSPsWg
   ZLnFZ2PPJ7zgdzw811b61+9a9ZQBc2S1aOIU3tUWU15VVzmtw5KzDEC9O
   g==;
X-IronPort-AV: E=Sophos;i="5.63,416,1557158400"; 
   d="scan'208";a="211303532"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 00:51:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWJyh29B5Jw5+cX9ZFoS66XzsPnPmF5Wu4e4Vv9kLVM=;
 b=jd5PVhwqdu0rsrw4PWxZNXN0/cBeqsLP722av0jhE37rx96dA6sc1xphU41V8VaU0jLA1jurt4b1MjHWpHTxQ9RVEcrJIltHZfS0YvmnZj22KPcpGZ13oiWkn4r6CGWNNAp93i5tUQ8F/bK8ZaTp6eITtbL/+qY3TRGbNd2aG/A=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB3845.namprd04.prod.outlook.com (52.135.214.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 16:51:51 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 16:51:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Thread-Index: AQHVKDJQD2Z4QYw9b06emkXLk9EL8A==
Date:   Tue, 25 Jun 2019 16:51:50 +0000
Message-ID: <BYAPR04MB5749977B2FFB5CDC8A254F5A86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
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
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f10a9017-9136-4c32-a138-08d6f98d6b98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB3845;
x-ms-traffictypediagnostic: BYAPR04MB3845:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3845EBE429AAED055E5376F986E30@BYAPR04MB3845.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(52536014)(66066001)(2906002)(26005)(99286004)(86362001)(72206003)(8676002)(14454004)(81166006)(81156014)(53936002)(2201001)(6246003)(6506007)(3846002)(68736007)(74316002)(53546011)(229853002)(6436002)(102836004)(9686003)(7416002)(71200400001)(71190400001)(7696005)(76176011)(305945005)(7736002)(186003)(33656002)(66574012)(2501003)(14444005)(316002)(54906003)(6116002)(5660300002)(55016002)(8936002)(76116006)(478600001)(25786009)(256004)(66476007)(73956011)(486006)(446003)(4326008)(64756008)(476003)(66446008)(66946007)(66556008)(110136005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3845;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R0mk295SwJYhzDNQrxGPzdvnic4BYrLHH1x3sBmKIM+OHVLkO9Uc/2nB2ISOyjMI0juGM3gu3Y2J/A/RDLQqRsutRzjYcdJCSHo4shfyvLQExub1hOnWqCG4WYZxlC9iSx/ZgZ/m2bYggpiMer/trE1E0rxxuCnwvw6QBWk44p5ztgm1nNRaLtpK+vtLk+gaaor62YJ2C1dbVYcPAZvwalYX1xmhTjYTOr1vDCpCasiMCMV2CcaKR3T6bqMrsgRJ+Id1sx0PWdNjSYu63zKijkwnWlcy6VA24o569BBzMCkfgyQSJQOHcXF3LAg7sW7AT137mIfhH+EnXZ+gtvoQ3C77zNFT9tvnPvN9Qz1xmEEovdiZiIuEgzmoG1BDrPGeg4P1Mby/Jxg+JFjnq3QwoDYordxFBLZGeXfFnlVMDVw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10a9017-9136-4c32-a138-08d6f98d6b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 16:51:50.9344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3845
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/25/2019 08:56 AM, Bart Van Assche wrote:=0A=
> On 6/25/19 3:35 AM, Matias Bj=F8rling wrote:=0A=
>> On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:=0A=
>>> On 6/24/19 12:43 PM, Bart Van Assche wrote:=0A=
>>>> static inline bool op_is_write(unsigned int op)=0A=
>>>> {=0A=
>>>>      return (op & 1);=0A=
>>>> }=0A=
>>>>=0A=
>>>=0A=
>>=0A=
>> The zone mgmt commands are neither write nor reads commands. I guess,=0A=
>> one could characterize them as write commands, but they don't write any=
=0A=
>> data, they update a state of a zone on a drive. One should keep it as=0A=
>> is? and make sure the zone mgmt commands don't get categorized as either=
=0A=
>> read/write.=0A=
>=0A=
> Since the open, close and finish operations support modifying zone data=
=0A=
> I propose to characterize these as write commands. How about the=0A=
> following additional changes:=0A=
> - Make bio_check_ro() refuse open/close/flush/reset zone operations for=
=0A=
                                          ^=0A=
Since finish also listed above which supports modifying data do we need =0A=
to add finish here with flush in above line ?=0A=
=0A=
> read-only partitions (see also commit a32e236eb93e ("Partially revert=0A=
> "block: fail op_is_write() requests to read-only partitions"") # v4.18).=
=0A=
> - In submit_bio(), change op_is_write(bio_op(bio)) ? "WRITE" : "READ"=0A=
> into something that uses blk_op_str().=0A=
Good idea, I've a patch for blk_op_str() and debugfs just waiting for =0A=
this to merge. Does it make sense to add that patch in this series ?=0A=
> - Add open/close/flush zone support be added in blk_partition_remap().=0A=
same here for finish ?=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Bart.=0A=
>=0A=
=0A=
