Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FE5C3F2C6
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68C220409
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AJUMZTTJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yTefwBF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgB2X6J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:58:09 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62574 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgB2X6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 18:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583020688; x=1614556688;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9oMKnhUiaKnyozulnveVthmgVf9HhGa0sAYbaBAUyWM=;
  b=AJUMZTTJGZ2fLptv2LQjN1h/J6zHxEy42WNekECiwLMtmrxwWRk4J+kj
   8ThpKCfTHghhdbeO7ByKEW1BMCOE5dnhanbRyU2x5rwzUbwTDc72dtiMw
   mqtUUsyjZLoQrBtaG3Ye9hYI04KDlpkpHqa3bESw3SvDA/ZHmJoNTsLem
   8B2gZX5YMJutW2FMzT0S8DqpnCIlXUGGb7LA8Za4mQnLsysdB9FEKqSO1
   kvXNLXBRhq7gTy/Gj1jvW+gHyQYPHguk2IOPX1AAB+l/lYrrVryFO/M/s
   JRIAX2FTn/pNudArRg92iM0CgX5WyQ/DGOBpebG+lzCkf14KQzqLLdbTo
   w==;
IronPort-SDR: eqcSDbAczXi/VrLwEX00vKbEUFxJRh5RItO2ALC3vAn7eMH1HRCi7WII6Sbm66ByQHYEhiPxSR
 /2YRxpKbBriONJ5SXxhbLkOMCuoPuqIpaupqmkNNugwOTzIxl+Zz5o5BUHnkOOujPeGduuV5gc
 uCr0gk+VkvXEY3BJc26bpNfQcYGI7ygxuEi/NJPfWb+zoa+5kzOf96eKVIGwhgTD3iOP/RPrK0
 1Tejk8VIf4MLadyzuh3O92fGrNJoWkmexP86yJdWbg2uonfrXutX2JI0fFDlgiEesQT6w4VmbQ
 9RQ=
X-IronPort-AV: E=Sophos;i="5.70,501,1574092800"; 
   d="scan'208";a="131072173"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 07:58:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CetABcGl6qBkYU5sHO8uYFaSxlN8eKPxPqEyFrzVsD+EwXhFhD+NGy9H2h3ezf6db57epqkdRY3K7jvkgo948gjNq7L4mQgWOcS0DhFuc5NU3hPQJNbQ5uL43oxPqGsv59vILhuVI98yWIzkAkrMuTKDURed4y2jQumg2DFALOKybdVsArZxcb+PdrtXJzDJKfI08wwDjz1D8b16EAd5ImkR9e3BAjTfd/A1YY7+qTiMCKVvuHHPUvn6pE+GbhKwh+i72+rDZwBncIxkzR79Wo/pxqXyNGuJ2D8JePLi9A46MFJsF15/SSCiD7WtUoZ4Od0RoAV9sehraF5BGeiyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oMKnhUiaKnyozulnveVthmgVf9HhGa0sAYbaBAUyWM=;
 b=amVHEbKIFal5zHVXL/KTRRIGcYSJ9lG2Mv8iIy+j8S549ebdet/3SjdclEikjyztz9k4KpwCZzkWmD31Rwgp91RTBYFQdnJOjtDepuDfGdFcZl8IFnmGdAXS17PddPjsmcZci1jdzH620AdQuGfHT6Zkk/BBh2XE4IKBFgMGzgxgR56CW1htS6ax1S7EQlxCxebz5k3z9T31uyhAWH2LfeVz1GQTgtowLHcJ4WQTcDfDzTLuXp36gs1jePXd7SAhI+/Kg/mb8IykBeNqwUJa42bykvjlpD6UZrbdJrLDrGYvhN+eKNY6ELeFyRniTFL0RZe2NYJvhLWbGgfe+zqwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oMKnhUiaKnyozulnveVthmgVf9HhGa0sAYbaBAUyWM=;
 b=yTefwBF0qTDby8aS/wVVBeR2oWStnNrLnsivDNH1UWurWNVS9NemkT+sffsnGaitaEmfds9A9+o6r36shR/IN2ChI+SoLMvDClXIaXysois6ZIWBIdy3G/c0WS7rZWGpmjVLBxuSMHYd0vNU84RaC5rIymLEoSAFts4TuEtrZFQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4471.namprd04.prod.outlook.com (2603:10b6:a03:13::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sat, 29 Feb
 2020 23:58:05 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Sat, 29 Feb 2020
 23:58:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 6/6] block: cleanup comment for blk_flush_complete_seq
Thread-Topic: [PATCH 6/6] block: cleanup comment for blk_flush_complete_seq
Thread-Index: AQHV7ki44mVnOsEs8k+wT9nN3Wnv6A==
Date:   Sat, 29 Feb 2020 23:58:05 +0000
Message-ID: <BYAPR04MB57494018A35D0A3693E4C2BC86E90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-7-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e653b04d-a589-4ed3-7553-08d7bd733820
x-ms-traffictypediagnostic: BYAPR04MB4471:
x-microsoft-antispam-prvs: <BYAPR04MB447160DC61A46C0ECE45610586E90@BYAPR04MB4471.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:67;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(55016002)(110136005)(33656002)(316002)(7696005)(6506007)(53546011)(9686003)(86362001)(558084003)(8936002)(71200400001)(81166006)(81156014)(8676002)(5660300002)(4326008)(52536014)(2906002)(186003)(76116006)(478600001)(64756008)(66946007)(66446008)(66476007)(26005)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4471;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKxsHyUZ+zWHbRSeYCssPKBD7mjW+1QIo9wLWMc9tX7lwAadzZf+rZuSFb/AtA1jRUppFf4tat2e5lwBB4lMbz3HQBGwQZHNksQf6ohZpXEakn+5PvlWnl/A0iHZOjk9Ei+Dv1U5H4xtjXWoflvKBM3CMwAKx6cII4LQoRb4Y+ZNMo1zqBCIa7YUrJqxlpoo1OUNtTlu7dtpczbCZBAewJaQ+gsuOTmNY56FRI8XoU3P/PiBCnNjOeOrEB4W5fMH7jK8d5JjRJLKEzhKuacJbJGxYHKdUMYzp5E635QZfcDLsVqT7FKPZT8qCobHRZqhemWeD/e2zN3AnpuClOysnnL3MSJI2pazxEeHXouB94jt0MQC9c2CvwS3z2lPNgzgPJFf02YYgRO/BOTMLHu4zOwKi848XjA2Uzd29Gw44EB6Qs/lhjRTlrdJnXFhoDYw
x-ms-exchange-antispam-messagedata: wY2H9iFG4ofAv0vRlCPhP2uZcaaw6Ie++BAzaA3zBT0eTW/if9k55Se00HaC8j8FNqi2iSLkKZQmGSDhpcDu3UJk5vYc/ju9tfe55KGWF/WCa8WdtG5vd0vGmDggS/H1cMUQNhO9pmpT/CFQ4LZQfQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e653b04d-a589-4ed3-7553-08d7bd733820
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 23:58:05.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pY4cZrUNwaUi716Hc0oA5iBysIgQ5Yq9QKRzaooCLw6BNClQjNOpiIjIUl6EjdKSe3W+Ai/f1rbkSQT/rXDRzGmJuDXi1OxSqm4jvtBO2vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4471
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 02/28/2020 07:06 AM, Guoqing Jiang wrote:=0A=
> Remove the comment about return value, since it is not valid after=0A=
> commit 404b8f5a03d84 ("block: cleanup kick/queued handling").=0A=
>=0A=
> Signed-off-by: Guoqing Jiang<guoqing.jiang@cloud.ionos.com>=0A=
=0A=
