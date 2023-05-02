Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EC5C77B73
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 04:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjEBEM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 May 2023 00:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBEMz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 00:12:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A343C3E
        for <linux-block@vger.kernel.org>; Mon,  1 May 2023 21:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683000774; x=1714536774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jb4ARJD36bi+v2lLW/+XT8r5OJlWCEt4viHfaTerQpU=;
  b=CQOt3NxCNF1LDhn2tRmLcValtXnrSYIjz7r+5A8whdRaXMWkUUEkVjvp
   /t6sZX1BxEeK11pHink3pvVgcAbMI9FGwLPtUromqZjOFf3OdW6kD7GEX
   vpHA6nLqJj9epe48/+J+r4mgOkAzXJ56Clj4LI/OL9lrpVNMSxajMfxq1
   ptYL/K90wa91vSO2mVPqwWE9sz6Fd1bF6XzGAZI+1ZR45ZI4/7pOAfEl1
   2mySfSedtaJ98kuR0wu8mTvZYG2o1EuHd2p83jijCLVP/B99x0bavszqV
   +QLBhUnHxsilxaKAWjR/3hPFQBoM1McbzDyE7u+xNtnYKYlO6AKKLSbcw
   A==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="229713346"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 12:12:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgMj5s/Dt9zHDcGVAuGPZhLVHtR3a0kYCtu05L0R9D9nY/9zGx+2qcM57itsBUY/rnMcur9owvdEfvcJSlDqd4TMDZ4i/BZPToGCNP94llQWMbm8f4GhoGI8IH7jtJNzqEH9rUW8rkMzDawtM6+8P2WPNOTToprWiiYwOzoRD5YeD/XtPEFxtzuHFn8BSfY9iCylT3fYanHzWBHLiK20eMUq9K9I6H0Jz/rWNoOpGiwc39KlLupHrHX3/HNskuHCg3JX7zizWeE3dnes4gsshGNZvZ2rTTCLJD4Z3ZOGE+vAMQCahBjtB+NhFJtQgMoQ2xKW7y8IcCePXAeZ3hHJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb4ARJD36bi+v2lLW/+XT8r5OJlWCEt4viHfaTerQpU=;
 b=jC06gkTZowYG/1XhkgEc9TEJdBpuzaA043EzAMFgedkw0K8/kvN0jm7ue0Ath432rlyBUjAVvavwVO0a3uKi9MKyyPkdBjNN9xlKUJK0RmttXIvVM7o2ZRhSNx3PDNVb+YgH/MDEwnLpBYuyYHfPqcph8VxpZ1H1CJJ9sXwvJaGc4KjiUi3qpf0Mlx46oyMC49Evo2mapiIxyvRlpvSbjv2DMsEEcNCwMLueR2Mz4zHn3IADVeiv30Y0W+xn7G7Q/Ihm9FVnsUsep4h9/pwMLVRGzeTN6ifn0TEwSEq5dMo1fN+TOsCFln51QtPczMwftDW/bk7Qr9TwNbXHTjLlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb4ARJD36bi+v2lLW/+XT8r5OJlWCEt4viHfaTerQpU=;
 b=uuB2EqtIMaG/cqImB9dsrfYBt9+YXdDb9m6RZeqIBGrGgJTgqT3ayScTHRMqiwdWeqwOIWylCd/rNl9bsfdVZ/LBiACzL+HoPNsBcxKhygNdoZRGhVlc6IbVwzY0THJXqIQF0MI2aJXdR8GZrNHfhoPQAJA+1XzyHiAJoLTINo8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7785.namprd04.prod.outlook.com (2603:10b6:510:e0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Tue, 2 May 2023 04:12:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 04:12:51 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/rc: fix kernel version parse failure
Thread-Topic: [PATCH blktests] common/rc: fix kernel version parse failure
Thread-Index: AQHZe+Nmsr7kHKEER0aX7gHCwBQoF69FntaAgADCGYA=
Date:   Tue, 2 May 2023 04:12:51 +0000
Message-ID: <jsihkmnolaev5kct25smhgfeegfwkmzpcba6mvcsriauuq2evh@rhiuuv5i45qv>
References: <20230501041415.49939-1-shinichiro.kawasaki@wdc.com>
 <a8064311-1e5a-936f-8517-e84a23a8876e@acm.org>
In-Reply-To: <a8064311-1e5a-936f-8517-e84a23a8876e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7785:EE_
x-ms-office365-filtering-correlation-id: 15cc8280-3e3c-4bf8-6473-08db4ac37ef0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z+mUWSoeWnIRY9OF4uw6DLjgJcfm9I76AsyvTvIJv5M5WhWLaumehcftfM25kdO7QYlGTu9JeSFmWFzg+6xXTrKjSobfOh3pe7x0D30HgbRpg7cl+TV+a1nrwBFaa7YbIseIehvHz8NL/NU7Qd4kTHU42mPC8QiTtoDMNw/y+CmSksYewv6Dc8YNfr/uh5ySqh+rwFm7CqKUor60SuMf98ixYMRi5z40CGHkzaM+vSO5nAqL3y/0EveujcXhL3iqkwXuzuy0r/yEzxFnwDAYKtoSs4HPaQP6ZYthYlQR8ecJ2wb4fr7DmLi2VtOyXlw/mLRdedxYC3f0+dKLXMNWj16yR7DfzUx8/ZGO6c4AOLiMwnFpHRjaQ+RAvAluFJGlfLbT5mPha1fOd3X3lCRT6p47z5MOF4rDrNbkygtPVcoZuoU/DkZQ6WMpc5tsr5klIX+FCcp908ua6NAYSCLpRn6aEba9nl2HNniR96fBkqkZ2SxQPHxfRVyYjONfXqjutM4x83uJZkyZ0vlQqlxq52E6DE4z49tNtuBJkn33mk/uXH0yOY8/jMGEAM9ggtsVhYrqJPe4s+y6wwKfX4Be1Df4V8UNHLUpeIxJ8Z2CcxFIMLw8+Mof7ZOvtDI0ua35
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(316002)(2906002)(82960400001)(41300700001)(8676002)(8936002)(44832011)(558084003)(71200400001)(6486002)(5660300002)(38100700002)(33716001)(122000001)(38070700005)(66946007)(4326008)(6916009)(86362001)(64756008)(66556008)(66446008)(66476007)(76116006)(6506007)(9686003)(26005)(6512007)(91956017)(478600001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2818/vszszAhP4yTf3J3mJJs/cpmlm+VgouQY4SLV0fsXfooSdm4Aktio2vq?=
 =?us-ascii?Q?m+p9BuDlTp6l1FSVKt3KK9W+ml51dAw/qGF6brXbDi9ARVbm6eINSLSlhzIN?=
 =?us-ascii?Q?Oxjv5MUbhbwOshdiDnj31iMQ/Tj7QTJYXnPbkufoETgyvga/RgnLCFz5o2To?=
 =?us-ascii?Q?97b5G+HPpYZih10OK0f3i/dmqXGrML0T4uIfeSzt/uFtTixIqYnJXyQQUm/s?=
 =?us-ascii?Q?CBFBVvz/cie9WSrwJxfcmhUm33SaguxLU2z2TVCwFrmwsXAOwhkwIukgBWRD?=
 =?us-ascii?Q?drk0rDY+b+VVbTmeMoo9jFlfk3I+TpjBinL4dZpYUbq9fMxvqxguvZAcwhL/?=
 =?us-ascii?Q?xd4hfq/UfCO+nbHVMAjYnQfoGCiwzjMfdnxfPa6+tdPnWPw9uq6lKzj2XYAZ?=
 =?us-ascii?Q?L5fPjGqyFcU9zvtK5UxTe1SAGPNuUt7ef0/q/fEsrc5VmJZF1232Mn1bXZi6?=
 =?us-ascii?Q?k3l4Osb94zH9tPoi9uXU5sx8OLui+/Z+6eNZrt8Jqn6EV2ekmLZRbhfK/ZRn?=
 =?us-ascii?Q?7VA4KQt+zuMCiMu5DJXbWLuInaA/WPGlMV4DpmSskpUT9SgBHs5BlqV5jm7k?=
 =?us-ascii?Q?bttg6JybrtsXZS0Iom601PlZ3XUCBIJvR1ghTQqzxVpOdmV7z1J66oQdO0xK?=
 =?us-ascii?Q?D2VZJmt6yUZ2TBbZyCUJxAFwujpfJ9MPpYrtBjEPczaDZpdY/YM/0m6P3naa?=
 =?us-ascii?Q?NuQcnx+1Y4E5EX9FsnngnaLclYBiWA45b3FJPX77V/CKbaF7Jl2AnStiliKy?=
 =?us-ascii?Q?zgXgVy+gsp+nUK2JGFqPW71xIA/aGrsQuYKKul3o9lPX06RtzP2n4DOV6aVK?=
 =?us-ascii?Q?t/Q+Ip4sRZa9TELHy6Gv2uoUhk1UmDjzbPkqQeQKuZFAgpTfe7gbSls6lmjn?=
 =?us-ascii?Q?jXMjr2ebOqOQboqPzO+YtKHz5SKaEjL0O/d7A+T9tL0VlIGcaQ4RSV/2Jsuy?=
 =?us-ascii?Q?VVSEP064MbUadEx+NEE/SrqU4z36EbWQ8y5Fp1XnyzdGnUcyi779whfULMQF?=
 =?us-ascii?Q?NBdMx5eDENlPWGEyn6r0mV0InfQFD7HtS1OdZ1xI++kwfeNBSiWJPcnWdsaV?=
 =?us-ascii?Q?7EkodiB2pk7Jwij+mVAyfovCGfUI4QZ6ecJKYSf+DKGV8494BDo6AZiQI639?=
 =?us-ascii?Q?xrjcauKnOR1iH8QnFK6FJQtmWKqDuhRQ7adFK13JimuVD+FbLQz0Q7C9Qups?=
 =?us-ascii?Q?a3PQtHxXKCXBMwWlmyZSE7KeOeWTjWWnxuNXp53Hn9a99XqvgSqiF5ilg/bZ?=
 =?us-ascii?Q?Kq06Zyxd5lI4fLu8tbxFtEX1lrOBK9U4t0MpsEeOC+SIR0ivvyrPj0wTfe8U?=
 =?us-ascii?Q?s7GeDvilIifpUBsJe5DPD3h4bb5SwLbzFaEs1xMaeihz6ho6wEshgMv+uAPS?=
 =?us-ascii?Q?/gIpBfVIDZDmstWTdoSrQG4INF+BEFBVPGMHI7twlGnkK75428CJqFylHg+Y?=
 =?us-ascii?Q?JgVQ1+zRGadBFQXlh5ES0AtPzVKSgv8Wpl38mZ2EmmwMATMP/5zK0psBEwRG?=
 =?us-ascii?Q?9Okl+B5qLQVVk/2AgJo4Hw+ruOhnZ3s9DjHKveVUH9X8RlkA6H8PLe1Ncanv?=
 =?us-ascii?Q?fQ3d50guAUbZBB3rqscNnySzrTcbIEf5f+Ct8n1r5WclaWh3ttXlKCAJ+CRM?=
 =?us-ascii?Q?meHm4qwea2z11agOvbdDq18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EC2BB3B61D81B4F8148794802943826@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LuwnMBqiuJqVc580P/C7/zIgFfT9gYu323zndKXHv3A2YD0vnDQWncZ6/2KhcnJfnwjZA6hQgjz1rSUDcQhaZNnKRzCF9cSZ17hpOKvSFFJMHutJsT7JV2Z1T7y9ndQjLkIs0xSZA3+6GZbvS7TNF4RTuuKivENazqupaDtnCEvqngArBS2KDgsBrBh4z53xvj8j4xPGbTqElL5+hD85jdEkwG3Xm8V/JCfOKtUzSHETUar57/d2h+B4G6bHiYxqdIeM0cJKIB8eVp5kYd8yE2+2aq4EEtDw8xvr/NeaPWJIcl0Vo6UuWO2rrdtdODgLWhz3mxilWfW8OWoeKa4PDtAUoWoO1/bTNP5Og/ceRttalDfhk5p96aTA4JP/IjdxU/sdGJRr/RphxSOLOFf8qmUUp06rwqcjdUQVV5z14sbZUFnC9Bpu1icM8HSez0194ucxJd5PIIKXZ/AapgOp8BoQSZaQgc35bPGStnBycHbcUG4xrhB9Ssp5t61J9nORHF77zK6ZWg69ZFt7vX3SPfUMC6LcfTEnYhInjx5pjjLQqH30ySgmi3DdVVWYoAMO8lr9qsmhSgBbbLY7YMPl6xVCHJ8ojYcp0L9QEx4zEFAWdswBJoJ38dZ12WufNAuiymnUIRlAdTKTroSSlvjUcSOyIUTcQBew7cXg68E/q4uRu5MZDMJttal9WUK+gGVOUCLQ+SMj74BQ5ZFWLghXcWG169BKihlhtr7dRWPuucXryJYtK4xm3ZJdef2sFo8qm0IkAVO/PD/DGyxPBam/pv1qKQSGwk07L30olgVkboI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cc8280-3e3c-4bf8-6473-08db4ac37ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 04:12:51.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ja3297gjAGvdamJd0UH8l7YJS1Ir3NJ14VW5RQwe28eaVkRJ8lp+nDGs7xQncUU9jwJstx2g0CcbyABvpTT8mgihwxYTEfGpPn2fYLiE8hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7785
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 01, 2023 / 09:38, Bart Van Assche wrote:
[...]
> Please combine the two sed statements into a single sed statement, e.g. a=
s
> follows:
>=20
> sed 's/-.*//;s/[^.0-9]//'

Thanks. I've applied the patch with the suggested change.=
