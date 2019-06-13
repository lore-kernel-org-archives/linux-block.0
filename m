Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3EFC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E06820866
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NrDISbsz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sNyIkIKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbfFMQJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:09:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33968 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390126AbfFMQJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 12:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560442164; x=1591978164;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=su5n4xLNW58qzAoaAxPUoPfsSlPnCtTBp1pBol8VATY=;
  b=NrDISbszoDHyfIQqHPNpBiWrv+YS0uboJ9Yh2hZrClD6xoL1uAvhFfrb
   //VzqlJ6RllaUXshZ5TnP+dhQeW0xyJkhwvQV9OmdATuVN+11LhKo78G+
   hsHvR9lZNLURW5nOd5U76Y5vt3lc1eTqFQmLu4JbUBl/dZPOMxsEfad1i
   rBimsS0X92S6MsnCZn3l0jqgu8wn1PBZ/3AOLSKQhXATptrd11aotzZW3
   YTBFXJ3xWeLfUMauNuGj4zVQgCS0eoPpz3QZTiLcOw0GF3L4kxL9+k5Xa
   3I6SW7pztivyFHRpDaxq8tZxxcAZOxxUIcQd1+PUOkgn4ErWk5DiWN/BC
   g==;
X-IronPort-AV: E=Sophos;i="5.63,369,1557158400"; 
   d="scan'208";a="110486256"
Received: from mail-bn3nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.54])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2019 00:09:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6ow3VHiRZWtEE7tJ1cYT+dfsUUJYiqGdud5PjTAFlo=;
 b=sNyIkIKieg9RfLbnGWeuzxiFNsXQsizQ3aTjPfBkzR+YDA34C+BFZBuBy0G0/3Au5bQv2eOPAAWiUAIiX51klg32RP5GWqGWZVa67SBn/rbWxzoa7nYRJ0kUx4apB5Mdr4VmPuq3wnDq97NmB36XafAfIR/2Gf3ByslIemQe9eI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5031.namprd04.prod.outlook.com (52.135.235.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 16:09:21 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 16:09:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH V2 2/2] block: add more debug data to print_req_err
Thread-Topic: [PATCH V2 2/2] block: add more debug data to print_req_err
Thread-Index: AQHVIfKili8u687/I0u+DyvaCM/m5A==
Date:   Thu, 13 Jun 2019 16:09:21 +0000
Message-ID: <BYAPR04MB5749C95E04EE96A3B6CEE80A86EF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
 <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
 <d369fbbd-0d98-b804-619b-23049ee12398@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad6d38df-6f18-47f4-f9ed-08d6f0197f15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5031;
x-ms-traffictypediagnostic: BYAPR04MB5031:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5031AD8A0BD9EB43860BDC4C86EF0@BYAPR04MB5031.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(39860400002)(376002)(199004)(189003)(6116002)(71200400001)(25786009)(64756008)(476003)(26005)(53546011)(102836004)(54906003)(5660300002)(186003)(110136005)(7736002)(68736007)(6506007)(76176011)(7696005)(71190400001)(99286004)(229853002)(316002)(256004)(3846002)(76116006)(66066001)(52536014)(66446008)(72206003)(33656002)(6246003)(14454004)(66556008)(66946007)(81156014)(55016002)(2501003)(4326008)(66476007)(6436002)(73956011)(446003)(8936002)(74316002)(305945005)(53936002)(486006)(81166006)(2906002)(86362001)(8676002)(9686003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5031;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7rxA9AIFqVUa+ooykK401b6CvbLrdbsDPApuQZLZQnUy/EXWKmwK48uwJ7ZR0uRBfDeezMVB69BsMkc54+B7miEBjXWhRjV+IUgGrHWiLsvIJc0gRfqws7ktwQK7rg0nGtrUXnY6Xs2RaY6iGzpAXy9/+nkjRfRJZZ2agU6CqZAS/qcAal2tLLnUGw0rFGab9o6rna0P23Xi0L/N22dmseeXSn/Duak/Ufvvp1sQjmnw1aDzfzFvoMQKQjERUFhjhZy+pnvbXZoaho++7oS3qUCyK1LzYKRII0araDuDaRk+0WnV+WTbObEx2xveNx5b1wZ1gn2UIn+ZL5vI5vUtSv66VaCX614uG12s4EY1wqQXLLrmM0PKxb8WwNV0HIto5XzTDk79keBVKq51CHjbEL1r8Oh9z8yBcsGoe4CP1nk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6d38df-6f18-47f4-f9ed-08d6f0197f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 16:09:21.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5031
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/13/2019 08:17 AM, Bart Van Assche wrote:=0A=
> On 6/13/19 7:16 AM, Chaitanya Kulkarni wrote:=0A=
>> +#define REQ_OP_NAME(name) [REQ_OP_##name] =3D #name=0A=
>> +static const char *const op_name[] =3D {=0A=
>> +	REQ_OP_NAME(READ),=0A=
>> +	REQ_OP_NAME(WRITE),=0A=
>> +	REQ_OP_NAME(FLUSH),=0A=
>> +	REQ_OP_NAME(DISCARD),=0A=
>> +	REQ_OP_NAME(SECURE_ERASE),=0A=
>> +	REQ_OP_NAME(ZONE_RESET),=0A=
>> +	REQ_OP_NAME(WRITE_SAME),=0A=
>> +	REQ_OP_NAME(WRITE_ZEROES),=0A=
>> +	REQ_OP_NAME(SCSI_IN),=0A=
>> +	REQ_OP_NAME(SCSI_OUT),=0A=
>> +	REQ_OP_NAME(DRV_IN),=0A=
>> +	REQ_OP_NAME(DRV_OUT),=0A=
>> +};=0A=
>> +=0A=
>> +static inline const char *op_str(int op)=0A=
>> +{=0A=
>> +	const char *op_str =3D "REQ_OP_UNKNOWN";=0A=
>> +=0A=
>> +	if (op < ARRAY_SIZE(op_name) && op_name[op])=0A=
>> +		op_str =3D op_name[op];=0A=
>> +=0A=
>> +	return op_str;=0A=
>> +}=0A=
>=0A=
> If this patch gets applied there will be three copies in the upstream=0A=
> code that convert a REQ_OP_* constant into a string: one in blk-core.c,=
=0A=
> one in blk-mq-debugfs.c and one in include/trace/events/f2fs.h. Is it=0A=
> possible to avoid that duplication and have only one function that does=
=0A=
> the number-to-string conversion?=0A=
>=0A=
Okay let me work on this refactoring and send out V3.=0A=
> Bart.=0A=
>=0A=
=0A=
