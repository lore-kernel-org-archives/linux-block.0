Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC3BC433E4
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81ACA20729
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LsJEaa80";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PszzKECA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgGTMcv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:32:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11729 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgGTMcu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 08:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248370; x=1626784370;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tTtL6GuZC3YrzjmW/iJfv6XUwhzl5yK0x7gp9dUS67c=;
  b=LsJEaa80U/RyMVXPtSuRKzJ2UoF+yHv8yNC7boqZN6+tanjW9ax1EpiH
   8LziWbo1eaVxmcaiUXt2nh8yKViostFcDQoZHcpOamL5OF5i8hBrotM8r
   aUGF7MhBc/+WWr4LUeOTaLBH9jTtUEp3RxDqRUaB0D8FMUkAvT2G5GwTf
   qfhOuADgE9odte08AtH8SC775pGHJIMx0BaXyOpbLRif/3K/e952nIWBZ
   yKi66burXo3Sg5nmJmo4+DNx21YOBUUWliojqc3o6AED0kemwAag+MaJS
   IiKuRXQWUUCHBwuWmHXi/elSLEE7YL32aKDwL104ZdWcTvbvLmF+Wn2eJ
   A==;
IronPort-SDR: Ie0DSjf+P5XQQBxnFLI5z0w73dcA8TMXshUFMfG/xsYJcICHFXwR2Z6dJMinS+Q3+IgT8JPAsO
 5Fg9UAS1hTNzz0rT2LSrsHZZjME7ikXDI8Hnylg1kD6maz2PP7lMPnRhq6Eko2uJuuyWOJaxIF
 /aO/1OuofYj0ugjhoTe3oc7GfvYg09FrTrxkdaIL/9nRDewESU3p29NmS77BnpSSDUUVji1AcX
 mRSE8+tJC/TAqZqRwgjzn/wuRHYNOgWKOXw8NQ2dy+Uh0EStoNJ4gnSIFIk7OvJ598SIuShPoJ
 YTU=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="252186211"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:32:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTNukXIfIwmLdRtYOd9HQbVOt6G9o5buKV2hi+yLMUWUvFsWHkCkih4+zSbNm2V2wJv2MXXImEvSya4a715Vh28TMX/Tu9WSWt8xeX2XJ9VltmDPd4E3RLh/B0/olceSjtx93FW1SoUZXQl5WWXXNoFJ2fM/tpFqe1WIz9T/PcAMae7m6HR8Nd1R9G3m4Uj4HTPxA89ADOq0FWkgYOME9xFS9AADiGaTdzKZS2W8hkXatyP3GkZQWQBikjZ19EsD8yr6RQ1KNUPhBdJvuw/7S4jfnRrWqI9e1XD48tiYkP6ymO1iBCNOuMQcHAs5p2kN6Ch+9iFjOWxSxYO5V2vQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTtL6GuZC3YrzjmW/iJfv6XUwhzl5yK0x7gp9dUS67c=;
 b=YImMBezsaUwOJ2gkB/rU1i+jntrMtuWBPfj+6tVV8oI8zB7eNgS1jQEHWm6kohCXByVCedzPTYQZP5tfd8N8rXjq/3x/yED6u4SWuJO9o6vfCiqdnZMz3B4rW4Z3k7SfEExSPBfJQxDXbnwJYw6kB6ML9j4r0cI2gY+JOojMnJM9kV+C//enwTuCmsZWvvM1bplr+1f2Hsbg7v5NRwTLx+DQlaoRd+YIVEpnRGl1jRHYvQCY8G5iPhkYfcAp1rYKaUOvlE8j5bQJa3zDmm/Rr64PAt75d6KW3IMPOuInCXpnCR0R+cJPUdPpnN7zfYnJgzC2W9c0G46iIqJN0Mej7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTtL6GuZC3YrzjmW/iJfv6XUwhzl5yK0x7gp9dUS67c=;
 b=PszzKECAz/yrkrlQ/mRsDKLfBubgIH568atmuedj8k4KvsaR18bTYUlnjihJFdJB9LMTzwd3HYSYMh6njuZOnk0eTqwWGMPwQiycJo9MzdIwefRPZi5fWuTYZCDoRAFKx83shGhAuzmnCUWAtufzAPELcCJP7pTVgBlI4Uu967w=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 12:32:49 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 12:32:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Thread-Topic: [PATCH] block: align max append sectors to physical block size
Thread-Index: AQHWW1k90KwUXjQMWE23AxcUX8lDNA==
Date:   Mon, 20 Jul 2020 12:32:48 +0000
Message-ID: <CY4PR04MB3751CAF3D387E973AB6D9D29E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
 <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717100232.GD670561@T590>
 <CY4PR04MB3751B7720950B99A50CEF485E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720110831.GA28284@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 940cd188-8edb-4262-efb8-08d82ca90359
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0727339EB806D035CAFABC1FE77B0@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mi7Pt35T07+jfrBjT/I/j/ZGI8TqNENlVci987ZS3O7+7UJP0Lzn6Fk4xelb611dIaCd+v1BDdP8RNWZ4D9VJm7Rca8B2oy1zCcuSTTevdumx0KDw7skFCHJxhog49k4Miw/1rozDAZOyMkonzrr79kCMNnZEYIej4PIGbTbgs1T8AUZL47RqGh5XIB06zXka7hs2pkoaHQTA+2s/hAA2xN2j0oMW9P/OmxRoFIYRNZZ9ZTMzmp1OaCboTrccP3p8SpojwGoVQ9Fw+c1PkR8ZufLDKgY/xx8TNspcFAxFcJEfW66pKYFwum7O1MhayIVmbjGZ8ejG68Dndy6NP1Guw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(6506007)(53546011)(8936002)(8676002)(5660300002)(186003)(54906003)(71200400001)(26005)(478600001)(316002)(86362001)(83380400001)(4326008)(7696005)(6916009)(2906002)(76116006)(55016002)(33656002)(9686003)(66556008)(52536014)(91956017)(66446008)(66946007)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nYnT0uh4FdWjB3G42BcfX1tKKdELGDiQLyqFDhm1MupsSQD3P3vHeXcNBd6rBPC9kGdZLJxQfU5Wo2vXs4+XRpP0QkwdCRRBp1oAfHbYSkzEKL+U0yDfj4Jh++2OAG/IXvmZ61w2Mq+i+0VtosWIL1lDVaBp1aW85gW4FiF+h2uzLux0nh1CQJ+Px59we+e7Y0ZD1uaYXth3WxaVQfF46A0UpjIvIug6lxSt7iODutnbfPnloi12ba406XoxCuktKayhOMrsgA5a5OofOxcdOWk5VJefq/VMGBPOBqen7EQHwrzos/+1dvfA6G/i2iBQXbjAirMFDGq64sj5ifbRQne1w5ikL9IATWlLa8w9WKIPUqQafW8fy3lTeqtITDdPQiXjB9/ikahcMQgIYDBWsG6sQCYx4zyCOQqwJrZHlhnCjyFwgFmZOYHh14zgax8ON5w05BrW+4tTIJ7ve64Vw0GWg2CNGpGEveSitbyrXZ7B0m9jaCWoi5pRqtCc58QH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940cd188-8edb-4262-efb8-08d82ca90359
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 12:32:48.8706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K73ro7snGL6E4ZOQ7cjakKwM1XsIohxql9FUuIlgY2FDdMThHSBp3B7ElCk9dotfohKXUE/mEuQ75/mns7XECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 20:08, hch@infradead.org wrote:=0A=
> On Fri, Jul 17, 2020 at 10:55:49AM +0000, Damien Le Moal wrote:=0A=
>>>=0A=
>>> 2) add one new limit for write on seq zone, such as: zone_write_block_s=
ize=0A=
>>>=0A=
>>> Then the two cases can be dealt with in same way, and physical block=0A=
>>> size is usually a hint as Christoph mentioned, looks a bit weird to use=
=0A=
>>> it in this way, or at least the story should be documented.=0A=
>>=0A=
>> Yeah, but zone_write_block_size would end up always being equal to the p=
hysical=0A=
>> block size for SMR. For ZNS and nullblk, logical block size =3D=3D physi=
cal block=0A=
>> size, always, so it would not be useful. I do not think such change is n=
ecessary.=0A=
> =0A=
> I think we should add a write_block_size (or write_granularity) field.=0A=
> There have been some early stage NVMe proposal to add that even for=0A=
> conventional random/write namespaces.=0A=
=0A=
OK. We can add that easily enough. The default value will be the logical bl=
ock=0A=
size and only ZBC/ZAC SMR drives will need to set that to the physical bloc=
k size.=0A=
=0A=
But for regular 4Kn drives, including all logical drives like null_blk, I t=
hink=0A=
it would still be nice to have a max_hw_sectors and max_sectors aligned on =
4K.=0A=
We can enforce that generically in the block layer when setting these limit=
s, or=0A=
audit drivers and correct those setting weird values (like null_blk). Which=
=0A=
approach do you think is better ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
