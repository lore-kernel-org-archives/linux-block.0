Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A46C4646B
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 04:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206E420663
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 04:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HcDGLzrQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MecGs+zQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFZETa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:19:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2991 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFZETa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 00:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561522801; x=1593058801;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vZyOZQ1GGvYD+9tp6C7kJk/jXb+JHdFly0E7XpCCNys=;
  b=HcDGLzrQ0XNkWg27w+C65Ks9sZcPL8hDPO1fWDXWYVWaFPEuplG0gvXA
   rEuukGvWCi5y721fVjoMyEUCGzfW6nHfW7QdV1izZ85zlU52kR7SsWu51
   ICK93Vh15OUeLX2T8RME8MPhKYeYes9w4v/0BSPRGGKiQfO5ihE1JnUob
   5/aRcXX2X9l2bGPsUOklboOCv8/TX9U6L8p82gRFkIfR9I+3TVdhOfDuH
   ftuiY9GahukDDoZuoV25BFawcwNdcBKaX9ye4GNorggEaE901UMPOhTl4
   IVhxwkh5uWsGIpNI/jXrLFmmUooMW6ZabyyRGZFnuQzcPaByIVnw0c5tB
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="211350826"
Received: from mail-co1nam05lp2056.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.56])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 12:20:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=N0HfTpfYMU/hvYUXOpWxzSxTIYTuB9rySzFzKLJaYN0lKJ9XnxmKxhWA19+8VkxVh5HRPuGQ95G47y0OsNbetvRo0+ddbz+HLi2xnYJRjp6ypVeB0TZD/kdO0tGUWPYNTTWoSdKZFIIRLcg24isclyth9fhZ7SgQFk8vMm22wLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIlZ4qyPTkmq+E/f3VjLOXtPOUa4DcTGUwTuKv2apCs=;
 b=D4CnTJO3AZYFJhqROKcN+gXAIwkGSFHy5XemYXHoHpNHlXswc1qfReDTc6g5ULhgj7TtNXtv0hVketGM42iZAGdk1WcaYOuFa3CQbwX3DKwfWxIAcL6AACnG07FdAQ8e6NbKIdgYy+V/OafTwB0Shvq3hTu3g5q3YE3L6uPGtWM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIlZ4qyPTkmq+E/f3VjLOXtPOUa4DcTGUwTuKv2apCs=;
 b=MecGs+zQN8/uauh9TmMPd80cLh5Ey34gIE5rtopZvpXsedYRdWNuhRnrpjfg4pN+TKVmv2GlNgk98RVQGx3UDIZjuhwBYArqeSloNWGPk6cELQbx05ogu/EH+QAvyfCtgMXTx7sb72j94MoTub7jlMXpakKP9C7PjVMjPHEhN5I=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB5066.namprd04.prod.outlook.com (20.176.111.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 04:19:27 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::a07d:d226:c10f:7211]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::a07d:d226:c10f:7211%6]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 04:19:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVKwA0CgkpItjWVEOnwU70Lez80g==
Date:   Wed, 26 Jun 2019 04:19:27 +0000
Message-ID: <DM6PR04MB57541624801EC01B620455F086E20@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-2-damien.lemoal@wdc.com>
 <BYAPR04MB5749C9178CB54B4A488408A986E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <47ab2698-9767-b080-59b7-2c4b3afaa6d3@acm.org>
 <BYAPR04MB57498FD0AE458FE6196DD7BA86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <BYAPR04MB58160BAAFBDE4C399C412F1FE7E20@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebe58200-4f7e-43bc-f87f-08d6f9ed7a5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB5066;
x-ms-traffictypediagnostic: DM6PR04MB5066:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB5066C35352FB5869F118328386E20@DM6PR04MB5066.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(486006)(186003)(256004)(91956017)(9686003)(476003)(25786009)(4326008)(8936002)(4744005)(76176011)(74316002)(66066001)(6246003)(7736002)(81166006)(8676002)(446003)(6506007)(53546011)(33656002)(53936002)(99286004)(7696005)(110136005)(3846002)(6116002)(102836004)(305945005)(26005)(72206003)(14454004)(86362001)(81156014)(6436002)(73956011)(68736007)(71200400001)(478600001)(66946007)(316002)(55016002)(229853002)(66476007)(5660300002)(64756008)(66446008)(2501003)(2906002)(52536014)(71190400001)(76116006)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5066;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qwyPU5ng80NN9o4k0gCwf8UxLy6umhi0mBbFR+Da42D5TcOSC0X4Bo+HQ8EsWIbtqdNXkkNTEz0DJ2KvdwnscQ+I0ODwF17UVcqBMWDb1Q2Ig9IHnyUlqgFA92J4uvSQ4QiZ7aLANFkTgv7HCKi+qSqSQmVvjhS6YPPZSukXzp0qp3wNEMkvOujdcB/X0Ol52WqNjd+SGPsFmS2vvNTvk7YPcG85FHw8W663NGrChTky1fJxZYEIUsntc9rrmSfCgpAK9KEQGMnT0l+RkD9t9AWmYtW1gXNnMQJtssn2qbn/vGsxYkM6l9yo89AjJwv5rM3QG7LlKrkj0e0HWR9abGTyJJvFa4Dr4FKwq20Gb0mDHwFPv6DcQbzjHJWl3Xkgst9Uqa76GcfhgUejj70PUKldsaVQPF/IbnEleMfDLyE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe58200-4f7e-43bc-f87f-08d6f9ed7a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 04:19:27.3558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5066
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/19 6:38 PM, Damien Le Moal wrote:=0A=
> On 2019/06/26 1:06, Chaitanya Kulkarni wrote:=0A=
>> On 06/25/2019 08:59 AM, Bart Van Assche wrote:=0A=
>>> On 6/24/19 8:24 PM, Chaitanya Kulkarni wrote:=0A=
>>>> nit:- Can we use is_vmalloc_addr() call directly so that=0A=
>>>> "if (is_vmalloc)" ->  "if (is_vmalloc_addr(data))" and remove is_vmall=
oc=0A=
>>>> variable.=0A=
>>> That would change a single call of is_vmalloc_addr() into multiple?=0A=
>>=0A=
>> Well is_vmalloc_addr() it is an in-line helper with address comparison.=
=0A=
>>=0A=
>> is it too expensive to have such a comparison in the loop ?=0A=
> =0A=
> Probably not, but I do not see the point in calling it for every page eit=
her=0A=
> since the cost of the additional bool on the stack is likely also very lo=
w.=0A=
> =0A=
Okay.=0A=
