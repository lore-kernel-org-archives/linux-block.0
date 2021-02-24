Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D2C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CDC60200
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhBXEdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:33:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63112 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhBXEde (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 23:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614141213; x=1645677213;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+mLRFfPCnrea0pf5T+a2WHi9hblIkq3xzActFCB1PZ4=;
  b=rY3MoqC5mIy/lmGNemiwqfBPNRFlw3X4Cg4fWZ4nrayWqyoShp8vKd+p
   1iuL+A3ZYrus5VEkdQbhH+BQq16W+u0kc1KyX6U2LcIsYacCrGEh8ei4x
   dMJK7KYozyqCk3m6/+48NhIUmDUdZjmNXCYme2IBdtkooKLSHcNcTKS5b
   pOfk8Xvj1u22fw7UJLC9nI1iMKruOYSBDm7UiqzhDmKkQCQHQfrj/aDQJ
   iWdxEQ8vy6edtjp74IImueakr0oin2r+jzixF9bh2Gp9nP5bf0k0P1OrP
   aTVMtGssJk2WrkFtj3TQpPI67DyJpWnhGRh6AzqAipah3WX0grLXu7N7O
   A==;
IronPort-SDR: tAwm7fVLNT8l02zKIi0Rl6x+7vVWWxHIZi8rpdWrX5hzumdBpm7mb6cy/El1t8aq0fV/o7ZshY
 +B7Q5nUx44vKjwnuVycWe3WWMRj8UccuRAMrCrRYIgWipcJ+9NYv0NozQRgYprWNHqsuoywkvH
 kesNNiq/F4uCX6iQ7uPzGWp+psNh7WsCa/zLP7k5/T/SM3nL1OOmQiltiTsvij8jsuQ2OHI0EK
 sUCz/RLaVUswQA9kQwDoF4ys1xIo6g32fAUm4TrtV0YhrUN25vlv/LtetwbM7X4N2gAekZDFib
 bFw=
X-IronPort-AV: E=Sophos;i="5.81,201,1610380800"; 
   d="scan'208";a="165140303"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 12:32:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc2X9e8TN52HYZSELuh2rUTVpLCY7QHsjCwTXdJLpC+dnrQG6NGi0/WhjQEE9mvpX+WbmXug1Me/AUa/Ow7msf8B9lA0x/n6xYRjNYzvlKRZgRwSB8pC+RFwZdIffk3CUz6mxTsURCRql6HWB/ADGavbb9SbZrpocYGXsDevYQjoost0So9FFShgeormJ/eeeYHCefplThwa4Zb1k2/bgg6cor7nSlaZ2LsPn5ZAJx+RYpOKYfCqbW+2PkyRSheWCIf0/KiteN/EoyjNsol0G8Hzmhv5lyJStxqbyKX2V1V2kIt3Tdax1vFTFmv4AdytQDWTQqe35uCjklgPPM4IlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mLRFfPCnrea0pf5T+a2WHi9hblIkq3xzActFCB1PZ4=;
 b=BcIi9yoInjDSH8XPjumqKvP/h26gBH86gATU9HeIejWwNTkaKUPvSCEf7SSNYUFYgKn5cM0h54I1ShAliH+fJQaw433sFrutys2S3Au+iqKqnKf3LrtVpwe+h5sAskSNlK3YNjSzarL/STliluW2NfrtU4Lc4NCLQUue6VI8io29hP95DUrqQSkHkpg1o1R6e7k3DlGAFv+7+2Oix641sXUb6GqIpv4EiIxEFNUtjE9vg4USLI1Fd5L6t536Et3byh8t3YlOznZ6Fc5c8KISQsYkzccjIiAYBmEDeNi8sA9vwHCk2PNK3GqxO77IOMaMzAXhp97KNlT7JoRaBAGKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mLRFfPCnrea0pf5T+a2WHi9hblIkq3xzActFCB1PZ4=;
 b=pfX97soARcqzwIJf1FZb0h82SSSi39GdrG4dSKffZFzQr7WTa9g1NZ6UFJorbsL3ekTKwjOpwCEiHFBzn65g3htF5dIOqeJAWgN9credH6hfMMTThbJW/3zcJwnqOq/8W1U0TlmZQZIgZgvRy+rBhzfU9qE5fbH2vknT/cLW7rs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 04:32:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 04:32:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ewan Milne <emilne@redhat.com>
Subject: Re: [PATCH V2 1/4] block: define parsed_partitions.flags as 'unsigned
 char'
Thread-Topic: [PATCH V2 1/4] block: define parsed_partitions.flags as
 'unsigned char'
Thread-Index: AQHXCmHHjhyZsvcjvEeQ1ADIoyDWfQ==
Date:   Wed, 24 Feb 2021 04:32:26 +0000
Message-ID: <BYAPR04MB4965DF1EA8B6256CFDC2B3DC869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210224035830.990123-1-ming.lei@redhat.com>
 <20210224035830.990123-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52a44504-4c0d-4d68-22ce-08d8d87d3061
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB6549EF8A95CF8330F90D43B7869F9@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xmg8X54eYk5aqVx6PpHOiyV1kqnVoY9hpnBtx10rIgbLL7RNmu8apex87x4zzgnSnY6pmwgifWuxoRg20QGow6yqYytBDk3pBWIQNXGXkq9NutAWVaMNY7wHf+3S0TtWgaxGbWNGHLRi+b17+uDw6jg5x1Tju8cpXcO+XwPOnai5c8to/9QKwyFH0Gfj22rkILucGvyKEv0stgTpFl344mfsem9TxrG1WkQt3aoLUMRnmLvag+GYONmGi4lgOBcHHcWfz311QMTxB9TIkODdy7lKQcQwvgYiQo0YfMrtvGydGBJw9wVQHWjroC1FjOQIvnN2qD2a44YJLz4HUz0L8lsmuo32MpqVUeGV7Js2D3NLTm8NLEz0evU9GySVPqdk8IhOIQKgmjYcV5q2tDplhv6/fRFJ3llpqhlUNLkLhc8ObPVb0R+EOKfuwXmtYlr5jjGBsGb02PyeeXFhMRgOZU5sRx4I6IVAn7XyRki3437YdZhTWDoFlyuqgnVhOxsDZ/CsGFRt2z6hW64NyOHb5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(8676002)(86362001)(66556008)(52536014)(5660300002)(186003)(7696005)(66476007)(4326008)(2906002)(64756008)(316002)(54906003)(110136005)(76116006)(66946007)(66446008)(33656002)(558084003)(478600001)(8936002)(26005)(6506007)(9686003)(53546011)(55016002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ynTXHFUlNaDL8Tt+uK73gi5ogakXc1DhEWvr9oaj2nxdOHXhIgclrDZYGqNH?=
 =?us-ascii?Q?86h5RYbQlgetgjd7R9j2nnFnJ5Z8faKq8kVpVY7hwPhkKEShsIbEi7nrHRMW?=
 =?us-ascii?Q?jz9da0khvSf3nfeGYGXs/j07TpzUF8M56enn6VTgh5hdzrO2UpuOmQGTjzQ1?=
 =?us-ascii?Q?GIkHMDzH7vsbd20xhBDhn5YvqKWQmipVYqBs1vtjvaqhPAnzDv0rNSdLuRkz?=
 =?us-ascii?Q?lnBkRMA3CI+rFWd5GoAl8mSIal1O6ZfOcZGIcdXi1skgX+ly+dyQXPv9JX0D?=
 =?us-ascii?Q?HVknFOjuIU5vktkTfelDTO5WS2i6pSfEbcgdxqanwXto8bTdhxL2TC2yQzxJ?=
 =?us-ascii?Q?6rtjlOmt8ggPem7oyqaRhk5A9dOg6vu/xc66LQMJpQ3l4m/doJbFuG5+1zVF?=
 =?us-ascii?Q?9h0tylfac0NkLqicS5KVvS+rpgRownC7vV4l7KvVScJUIUGGp0Bsrmevy6ru?=
 =?us-ascii?Q?ptt8sS/1q76dDT4MyR7BX0KAps42KvjlUX63dxUhWeraHIjhSMkkqwjy4gWh?=
 =?us-ascii?Q?fHqzgmo9CYtvAHn/WDcaxTdC285V1cEkRXHqXIM0mOyjaViKTsX2Uc0K2k9p?=
 =?us-ascii?Q?XhErQQHbWrPtO+m/xVn/hmBaiCYdDniXUNbmT3we6FLPwmd85DjVF1ldklDH?=
 =?us-ascii?Q?3IwppdYsbIUzNmGFlBDms/cKMunN0Y48wFNnw7jyJnfSUF7CojCFhHWF5Cpf?=
 =?us-ascii?Q?lo/F0tCuJ75Mn4LTCfeg9p+OohmxxntyjLFMHyFSEgmdKrAHJazttbuG2O6Q?=
 =?us-ascii?Q?4YxckGNWhZMJZYiZXY7MvCgQCL56Ebn7ZhrVspr918iZ+7v0qjPG6Szne5jq?=
 =?us-ascii?Q?bpXdqq8vtMilmu8HK5PwVwrWt+5KQnDLV5Us3PEPCNMN2/yVKFuCpx2SrfWV?=
 =?us-ascii?Q?V6Fiu805r7710gKB1dIc6EMxkVVbUDsJwTPzbB8jVtRZEZJjPKiLzttBbXOB?=
 =?us-ascii?Q?NPkxqxjfErSM76cuQ7EcUXM/PYjeYGDX3AUn8FOUl9PKVBi26a+tWaenD9IT?=
 =?us-ascii?Q?foDojSO5IzVciLBHTtyz9+8KL9XnLIeug96WxLSb5VRB8EAUqwL9LpdtuVNk?=
 =?us-ascii?Q?ToUVfNIeJ4bGbNAAv9ZCNhnz7rWKUXH/gc7C1OzPR9S95IO9VitAP4pfjtOy?=
 =?us-ascii?Q?YZiUEL3wirfnDj8TOGqWdh1sj2lziAE7QgU/WkfhTLHJDD65HN4RAL+ojLD7?=
 =?us-ascii?Q?rk8f6TeRvujC6UydXYZkVXa9QR+EHRv9BFw22bBRfSefz4fx5ZjszDEzCrjU?=
 =?us-ascii?Q?B6vLZCWoJAyCnng+LVgOGvvvzlLhpeLiFZPQFdRIHncOfxUXF7u/NuFZjRzO?=
 =?us-ascii?Q?6EDVYlJHIgyB9saNQ7eumuXgT/5mCSKoUMQF2fb/ag93UQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a44504-4c0d-4d68-22ce-08d8d87d3061
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 04:32:26.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ExB2oO3+6ipAD/hPlw825EbZH/paSNxswcPF6bc3d55laLi013hF3IQ2UYUONNTONddUIbANxSgGH+MKtGz5mFwSg47qKHMtwZw42hSIYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 20:01, Ming Lei wrote:=0A=
> So far, only 3 partition flags are used, it is enough to hold it in=0A=
> 'unsigned char'.=0A=
>=0A=
> Cc: Ewan Milne <emilne@redhat.com>=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
