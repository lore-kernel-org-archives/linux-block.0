Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B432C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 22:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C68206CD
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qMwRnaLd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="v2buWjlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCLWT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:19:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20278 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLWT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 18:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584051612; x=1615587612;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IJc4nJ3tk6nnHYbOjuiLkBjbfbsX6rJC+xc7hSycifk=;
  b=qMwRnaLdvQ8ZroQ8QJmOv0r8fljmTm82tJLVB9RescMnFUiA9qGxRtnx
   1gQa73P1MeLqeRfdR0fw45ZQc8Smws/XrXX4GA/VmYWGx7BAO6svvDes8
   5ofGIW+glptZARU+/eRfv13N2azL2eCZqlOxDLAKfjelyedgkhp7jmiaE
   hNj14E1yjR9LXLmChEP4rTLI2UqctWgN2Xzqkq+Cv6mLAvh83nWgBlwCH
   /cTVhW9AyNMt+4X97H6xtyiE3RkU5uTprdbNztqYd1RoRdmZt/4DH05Gw
   +uUGacm5Lbt1vrSoFUT5HRk749m/SXwu7gAXfxkkHIH8otpT5DVORv5+Y
   w==;
IronPort-SDR: n7gYmNfD0at/5glFrQ+5YeLiGt5yjXpfafJF2/u7pC+WdBYA8swcJUhMFhDifsA6htqt0AIZCh
 9H3hCXMi2BVwt8L5B4PtDQTnLYhHES7v21tTwoklx54Asbw5ISzjQt/6aJgMfAU2EfJ6Fr2UKK
 pu7hYQ8hUk+Ai/ZmRSBuIb/RykbJkZLICXoK/BfhhFaS/LSV3C27sAAj/oeiC5/n/mI2V4ipQx
 rBBWVkszx9npRYAhApQ0zJ7b0wDdVpF+pgmJEbH4oZWj9eQrFHr+VF2eBDf0JIS+i8qqL7HUJZ
 Zsc=
X-IronPort-AV: E=Sophos;i="5.70,546,1574092800"; 
   d="scan'208";a="234384866"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2020 06:20:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL4qbPaQ20XAaCIxQ9EBbVfB3z+rKfKgUCIxwpLbL2ZoApr4TukuPDkEnydKY6d6ufiKGdCB03pApXYnYXhYg3RWdZwskU7k1MDYqTPPTiJxO8KuSaAKUHyU0YEMXqPOERlxMZeyZRAe/PPf/mXjmoYxuwweE6KjO4H4pAWtz11Q9C4aaVS8uUO4dG3GkzsedF494+B8cYTdSDpESaumpbgRU6b9RdzHVYrqZMTbMablfo9iCb8+Y9mPYny8p9cok8+Z8E8icxLsoTeYhwR3xArdBGdCTlZgCMEMvSTraeGZKnSYe23GLreGnQvMX6w40JPUK76g6yuDg+gLvF8rjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifJWRY9wGuZE68Dq7kCUkJ+VPw0YpNEDQQvM77ribqw=;
 b=IaYyMBiygESTNZmAjtCu20oxwPsB0DWGAmKxlsNiv/A1Hj1ZnxnNNBe5LEykg4dYTVID36LVUUbbYVQKtG1S56qrEqN2C+U1pm70Uti7GogsggvZHDm1pscdE3teCZa58sgRsdO1u15QsGVD2UWqYwLGZyqyiS913X7e+nT44myHk5cGy3w4LoZMAAVer6684i4Y6AItwsnjObaCn8C/ErCVgDbw0m4nBF3IB5CkzSwLbyIPehoW3nL7JsC3mZsvkmkoBcAeazFW4JPc8x+F3sZqXwAKqg9AiR0pOOW/bNjyalcbgut6F0lRZ6AqBj4yDjXL76xQgvoSNwpOK8BRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifJWRY9wGuZE68Dq7kCUkJ+VPw0YpNEDQQvM77ribqw=;
 b=v2buWjlRk9vGDzd0OS+MGSvbqI9CCzrv+9aPUskt2ZanqhS9qCXFwNf/RwaKrFU9anYV9U3TTEYGYD6/pVGD4Ck6vhwkzRaZEfSUIwiI6N5n0sezKbsu8OVnalTLgwGcMy3uAcDuBSx6aLjAYkPBCRu0iISwguDszPuSTeeAUyM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5639.namprd04.prod.outlook.com (2603:10b6:a03:107::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 22:19:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 22:19:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-5.7/drivers v2 1/1] null_blk: describe the usage of
 fault injection param
Thread-Topic: [PATCH for-5.7/drivers v2 1/1] null_blk: describe the usage of
 fault injection param
Thread-Index: AQHV+Lm+xkqnqrA25kGEwM3DXf6UIg==
Date:   Thu, 12 Mar 2020 22:19:55 +0000
Message-ID: <BYAPR04MB574995F3D16CABE85CF6182E86FD0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200312220140.12233-1-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bae6383-ec4a-4ee8-162e-08d7c6d37e42
x-ms-traffictypediagnostic: BYAPR04MB5639:
x-microsoft-antispam-prvs: <BYAPR04MB563917CEFBB7F221919A983D86FD0@BYAPR04MB5639.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(54906003)(316002)(2906002)(71200400001)(186003)(26005)(33656002)(4744005)(86362001)(66556008)(9686003)(4326008)(55016002)(7696005)(110136005)(64756008)(66476007)(8676002)(52536014)(8936002)(5660300002)(6506007)(66446008)(53546011)(81156014)(478600001)(76116006)(81166006)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5639;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19oZkeqsfJW4vyTMHMLYvVxt3SEP4iNQdeAsn8hJV2OzQpOmxd4xUJ65VAx9lMzTIiuZwt8UhZewlsXBRNJyA538yAaZM8duV3XHeEKVJYOrw3M05K7cu2unrFzvSNgX5zzrqi7mr00SmArd/yj5Yo43tikUKZY+w1EcpxQkAFUjUNm5Okl5u0fRkqUqeVCHgBAX7f/sW5qhJ9YUZgksgvbM5Ekdl3vJtMvZvx1VHYv9RZZa11AD15Qn3CQht/IdCZZGQ9BPoli08EJmT/fsJqW95E9tKNuI/fEMqvc2MbRoLQSJm9upV/+MwVorwrsihtazNX5nrNdspkQOf1r3iatbBaQhhzwwXCbyKR8ZYQvt2erqt+/jwg9uOpbVr3esEqEtbaNNAnD6qFi3ex2VqgROr8TCWW1VClY/xqsADRONadjP9gr/4okcRkI/36YS
x-ms-exchange-antispam-messagedata: bK/Juy2i3gt7ocPM9OsVIggqH0lTcfO9vw0yauYBe1eVvHUxQCfoFnC1SpkJG8p4o+m4FGwp4t05xoKGA+AZDj/dRBFdN/Pk0M/oJLzEQ7OWmBU/3YrWkkm9rRDeLf+YSKXG7myECq700V+Uq4amcg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bae6383-ec4a-4ee8-162e-08d7c6d37e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 22:19:55.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZ/60CT/XXOd//jDLNH+MfpC4UouuuKIdFV00V/7mJZQSOJDhRXs+38rXWGfv+nVaepvRvkkbFOhFdLmd/s7J8Bomfr8WqvxtRy5lic9xuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5639
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe does have the same format in host/fault_inject.c.=0A=
=0A=
This description matches what we have in :-=0A=
=0A=
null_setup_fault=0A=
	__null_setup_fault()=0A=
		setup_fault_attr()=0A=
=0A=
looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 03/12/2020 03:01 PM, Dongli Zhang wrote:=0A=
> As null_blk is a very good start point to test block layer, this patch=0A=
> adds description and comments to 'timeout', 'requeue' and 'init_hctx' to=
=0A=
> explain how to use fault injection with null_blk.=0A=
>=0A=
> The nvme has similar with nvme_core.fail_request in the form of comment.=
=0A=
>=0A=
> Signed-off-by: Dongli Zhang<dongli.zhang@oracle.com>=0A=
=0A=
