Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20DC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 00:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE3C208CA
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 00:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cbsUkMCj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lnWJPtZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFZAoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:44:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16713 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfFZAoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 20:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561509878; x=1593045878;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3mtjwFGMvMi3gjfXOptop0WzP9MdRFMpDO7yTqymLeQ=;
  b=cbsUkMCjLFS7QIG+yOf1XPjz9BPAev/XlHdZXSiYzMDNzQ2uwi9D2yNy
   +jto+7XVrFZNF4kmvywpEeWbGBAqsaxz4FvDZedKb/bnqq83CeEpCJ4yL
   7BpRzlFEE68MnyWz3uS9v0A1YXp5RJ/KHAbHyLmwcbMPQAlxwzx5q5ujE
   ngefieVOUdzmwAEau4Ts7hxu7k4qyWw10WEV5I4ca1xhQ27xxAjPacuj0
   kD/E5XRiwYLofAyyxNAygM0mCpNo9uQgBTYwlIshgAfsbP3GDCaUtCdaf
   Rnw4fGmS0fSMjgN7lNnC7nH80qQPPyfYgmR2pwepwJ0kUxEgpiUOa5O+Z
   A==;
X-IronPort-AV: E=Sophos;i="5.63,417,1557158400"; 
   d="scan'208";a="111534674"
Received: from mail-dm3nam03lp2059.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.59])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 08:44:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFNC57xpoAo/y5YNnN9KiVrI/Vo9DKSj3ThklbUX9BE=;
 b=lnWJPtZBq2ogCRk/u1Cv9hENu4KKhFN5Vceok4Ia+WFPzIlRwIcWSsDS84vBmepEE3IIgULG/tR5k4vKL1X3aNKHRGojeJG8LsDDUOnsSDqX8Okzw7Duk1tdHv6Z8PzUWhDcG8Z/Pn4SI39ysv+vYqePyVujOFVT9Olbq0cuf0o=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5367.namprd04.prod.outlook.com (20.178.50.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 00:44:34 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 00:44:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
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
Date:   Wed, 26 Jun 2019 00:44:34 +0000
Message-ID: <BYAPR04MB5816362745998E8A096F241EE7E20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-2-mb@lightnvm.io>
 <ee5764fb-473a-f118-eaac-95478d885f6f@acm.org>
 <BYAPR04MB5749CEFBB45EA34BD3345CD686E00@BYAPR04MB5749.namprd04.prod.outlook.com>
 <cce08df0-0b4d-833d-64ce-f9b81f7ad7ca@lightnvm.io>
 <79ca395d-8019-9ec8-0c0b-194ca6d9eda0@acm.org>
 <BYAPR04MB5749977B2FFB5CDC8A254F5A86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4862b38b-6433-44fe-4b80-08d6f9cf75aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5367;
x-ms-traffictypediagnostic: BYAPR04MB5367:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB53670B58122220FAC2D8C136E7E20@BYAPR04MB5367.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(316002)(8936002)(54906003)(8676002)(446003)(9686003)(102836004)(486006)(66574012)(476003)(55016002)(305945005)(66066001)(2906002)(68736007)(6116002)(2201001)(86362001)(478600001)(25786009)(71200400001)(71190400001)(3846002)(7416002)(33656002)(52536014)(6246003)(7736002)(256004)(53936002)(7696005)(6436002)(72206003)(14454004)(14444005)(26005)(229853002)(4326008)(99286004)(74316002)(76116006)(186003)(6506007)(73956011)(66946007)(91956017)(76176011)(66446008)(66476007)(53546011)(66556008)(64756008)(81166006)(110136005)(2501003)(81156014)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5367;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f32hnMtgNYo8yagYjtB3FxKOouKFmjBnxaN9nMrS7hpB+hwg4j2I8ShgcBcL0HkDtXsc2p6ls/TWA1t2G/YPh8q7GCEIu5SuBim1CO1LG05r1aFSL9nAT9/QZiZo7fef30YRS2temPAv36zrR9whtesxQjbUnWiN2kJt9W7/jhfWValZdRXohJUXc7781BFc2MwqxpyKWU3pnyA4oEbIB59pJN9pXj5kBFUGd7iOelHGTEid/lDgBOs01yCUMqy4ykAgpdIujjBEJqYccTL+9bY8M1g3iNl+cV1qZpmXwoTMz7YDBvL6dtmpx3I2QxAv2tq2sgBTxLaRyBn2oZiB1ebJPuG8mOwxXmBkk5K3HlTDFvBldSZwBQCootGIAa1T+/jyJSMQ4lJruAyRdE9ZDaQkvLVv7Y3v4rCT40cGDNM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4862b38b-6433-44fe-4b80-08d6f9cf75aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 00:44:34.5915
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

On 2019/06/26 1:51, Chaitanya Kulkarni wrote:=0A=
> On 06/25/2019 08:56 AM, Bart Van Assche wrote:=0A=
>> On 6/25/19 3:35 AM, Matias Bj=F8rling wrote:=0A=
>>> On 6/25/19 12:27 AM, Chaitanya Kulkarni wrote:=0A=
>>>> On 6/24/19 12:43 PM, Bart Van Assche wrote:=0A=
>>>>> static inline bool op_is_write(unsigned int op)=0A=
>>>>> {=0A=
>>>>>      return (op & 1);=0A=
>>>>> }=0A=
>>>>>=0A=
>>>>=0A=
>>>=0A=
>>> The zone mgmt commands are neither write nor reads commands. I guess,=
=0A=
>>> one could characterize them as write commands, but they don't write any=
=0A=
>>> data, they update a state of a zone on a drive. One should keep it as=
=0A=
>>> is? and make sure the zone mgmt commands don't get categorized as eithe=
r=0A=
>>> read/write.=0A=
>>=0A=
>> Since the open, close and finish operations support modifying zone data=
=0A=
>> I propose to characterize these as write commands. How about the=0A=
>> following additional changes:=0A=
>> - Make bio_check_ro() refuse open/close/flush/reset zone operations for=
=0A=
>                                           ^=0A=
> Since finish also listed above which supports modifying data do we need =
=0A=
> to add finish here with flush in above line ?=0A=
=0A=
There is no "zone flush" operation. I guess Bart made a typo here and meant=
=0A=
"finish". "flush" on a zoned disk is not different from regular disks.=0A=
=0A=
> =0A=
>> read-only partitions (see also commit a32e236eb93e ("Partially revert=0A=
>> "block: fail op_is_write() requests to read-only partitions"") # v4.18).=
=0A=
>> - In submit_bio(), change op_is_write(bio_op(bio)) ? "WRITE" : "READ"=0A=
>> into something that uses blk_op_str().=0A=
> Good idea, I've a patch for blk_op_str() and debugfs just waiting for =0A=
> this to merge. Does it make sense to add that patch in this series ?=0A=
>> - Add open/close/flush zone support be added in blk_partition_remap().=
=0A=
> same here for finish ?=0A=
>>=0A=
>> Thanks,=0A=
>>=0A=
>> Bart.=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
