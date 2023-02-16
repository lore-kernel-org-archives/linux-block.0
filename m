Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FAEC636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 08:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBPIf1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 03:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPIfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 03:35:25 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB034C01
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 00:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676536524; x=1708072524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nUgAFL+VlD3S5NmOg+K4d2cMNx+QZylUr1K1yRqv0Vg=;
  b=qiqV1eP2BfdG/MniEtaAjkGh6w9P3t2uHXP4wTimeHztwatpYS2Mskst
   O5IyzVnQt4ejgiuDQbKaDLIP7ZYhwB/031vUzR9k630D1C8IUZ+aVlngG
   Khfhek0CTDkrDUhYfya2te7kk+WNmgPPjrf9Tam1Y4zPxIBt5cF+YU9f0
   3Tqf2qxMiMnUjVX650OviKYboaW+xVi84DPQ4bKeVpiIGFhKmO/n/g1qc
   8cCxkLmU7TUbwXkz9V0dBIHZtUlZNoMgqlmO6ZkZpyRk1piOg3p6j8qZ8
   qNINuuZuqcqD6nz+3jkkeQdZIPepdc32HEEKh1Lj0G0kq0HLTqyyC5Igf
   g==;
X-IronPort-AV: E=Sophos;i="5.97,301,1669046400"; 
   d="scan'208";a="221739029"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 16:35:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8c5qe0epzsSKv4N0PpV9/zvtG4sVMiZQaZ430dTKQzLb7fpzSCHU5ZlOJc+xH57jrJHM4MUkFlK+p5eYCIxIvm/lZOB3RFBsTuk0i4FrBFx9zprsTSZ4gmDbepgpGxhxHfrYoYDTFNh/ZGhO70wZTSH22iFaZlnqpd1GZ+Sv55UQynL2D4+azjOPTkaEEbzkz/nKajouhF81Gk8ovecDEwxRTQBjyAmaVra0S4pxSKeEiGKee3CUG6zkImSn+WOCv3Lg8VPRIVIZyBf/DO+JVp5M/w2tBmOnZDjrhd4sqKl2RvPs8EUHi9VPGUhUAh6fqEH7rfNlGmlO0RoXGG17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/Hpvib/ZMaBtaVRGfjBSoIdQaO8jQYyCbLgCLAleJM=;
 b=Hm+ZT5PKdMdOukSQMNHVSMhFKNFX4iC8VjTKd/r8GgMGPdVgEUiTqETSz5iOuIrhF8B8mqzmPyN2GACIe2EmW/wXAkvJwwHi3AXIpfUzWKHTpaOCjPTNxpXR6E5k7DNZRXWUe3Yk2gkkRCLbtp/bJEomcnDan7JepPGoIiSMe9oRzFFlqAoTIfiHrKlAmxnuU0h72NcoA1duSdamE3aYqD+Snr/g5h8UY6vIkJtVR2cTzoc3pOasMuw0QALQ2XOYAydx0hAUUGVdqtbDvxAxJpUnWn3r7MOGSqS9jbfkJ4zPeEIbqiMU6DFrGzbNqeATNlxIMPYedsA97O7dTGBqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Hpvib/ZMaBtaVRGfjBSoIdQaO8jQYyCbLgCLAleJM=;
 b=I58mEwuYnMLXUU3t+N9UTrHWjJva7FLdLMvaJXZnslcjYuVzoE830XP5tO/qIY/nf2qU7snApwe7PrTpJmfnIzRHXvDkIrG8+YTk/gaXMViVERO30JeZMZ595EhNHcZcY11tWfJMMXcejK/Ig6XbtgZFCE32qZBdcQ8bMMhoDjU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB8761.namprd04.prod.outlook.com (2603:10b6:8:127::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Thu, 16 Feb 2023 08:35:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 08:35:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/2] blktests: add mini ublk source and blktests/033
Thread-Topic: [PATCH 0/2] blktests: add mini ublk source and blktests/033
Thread-Index: AQHZQbMs1PpE0aKL80CsCpPjuVYIqK7RP82A
Date:   Thu, 16 Feb 2023 08:35:20 +0000
Message-ID: <20230216083519.w362iawzqweilzes@shindev>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
In-Reply-To: <20230216030134.1368607-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB8761:EE_
x-ms-office365-filtering-correlation-id: 6084c0c1-0512-45fc-262e-08db0ff8bd67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WiM9OcoYUD5phTTPmHNGVFR0rnUtbQzAwhv92BiWFCUz//q+QBVVjaMqxEDcavd+1CeVQtuSSQrm+mW0SK/cryYoJoqnLdJAmG0KOfdEno94TaDnJoLyLxcOHbYY5bkBRaAOxtjZtWMvDPbz3X0KjmDLTuN7EXEqkjhTwVfhEcqO/pwtXNXXzeSf0286qWTQNdYPZxl+mF/ykGsmZO+1tGgeonJVGxT2GVvEuPLAw0IqtguEMSa6zfi2x+QeZxWGnnf2BAPEn0rA0ltgx1d1u+vGwF8x4ODZDj3Xpj5isQJmqT0ozifbOhyraf92U8ns0iQeJ14IU697Qqb7c59razEKV/gje0xA3osQrbb2OFV40gWUYxMMVfCzA5qIe3kAsObKKLvFXAVCYmq8yZX1xX7N2+Fn3ZYoKqQiQ4lF0E/Qlt8XikCN9lMaZ3mmaDQXqRiTbG3xKCmEic9AWfQWJF1lvZiSescWnhV0RnNnc4Bz8RhalCrKlXndd0ZMeMLzFfKADcxpxYq4Xc6s3dmTSwj3ckEdY3MXl3xtL9hN/8a558A+q4rsHCH5KN0oyLsR7I9IP2Xd6z5yWS3spl2BuUDmhkVwZi/64esVJJenHNoV3bCwXxf59XBOtVrGq74x1YCujobHGYlbRBkxE1VeKea/fCWFdtD6wURRLH4/FEbwVNyzUUTZNFPAsXVUw7auZMFVUqzkTD3KYgzO7giVwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(26005)(186003)(71200400001)(2906002)(83380400001)(91956017)(38070700005)(9686003)(6512007)(316002)(6486002)(8936002)(86362001)(38100700002)(33716001)(6916009)(122000001)(5660300002)(8676002)(76116006)(82960400001)(44832011)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(41300700001)(4744005)(478600001)(1076003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vbNuzXE/IINpjnQpv3wu/pUieEUfUaPhsESePd7vuLOXs3NfIlXvPnpyq6yq?=
 =?us-ascii?Q?drvOejKNYt6g3B+caT9k5Qy35zxRr+mhh9SCkqRjZHVtADKH0mkqz75tn4mk?=
 =?us-ascii?Q?eFNkr8XGQMBFTIQJnYOKP1EYi1j4bE/n6ASlS0ozW/M60HfAuB6xCrE54DaL?=
 =?us-ascii?Q?CciO291wJ5nNURZ46kmqpbpH92YhupOv7QufDVZjAAgJwDeBrLWHfcHHMkYO?=
 =?us-ascii?Q?DrHTUvRt0hoZklB0HKFJhKY996Wtusli0CvqH61/ib4cbnl5Y/E9WsmnmsJd?=
 =?us-ascii?Q?xwOP1jttMF5LVFduaxQ9NBZigcEXue2rCHaYK+IHiYn/DF12Xe27DM5XwFXa?=
 =?us-ascii?Q?g+9gE94zjELaRQWpDyuXqshyTiOvJh7m5pGfbogDCBnHCw2cTTrW6Yp20QAK?=
 =?us-ascii?Q?COsQaNaspjpN6G8ZDrtSCQ4jcBkHRB97FK5ZV4dv3cWtAlGYjYhP7VyH6Drk?=
 =?us-ascii?Q?ExiMXWIPzi1qyJEFYq9mqVyqUvObgTRgWxj3VLLjhda+IdVwfhGSzmZ3MsUd?=
 =?us-ascii?Q?FKhHgVtHbMa8t9qLDP3EZkDDO36Pn4jrQXjiKZwZ3qc3M6ALJYVdM7VqzjHY?=
 =?us-ascii?Q?VawW4426OrDQBqO5Jc5l/q0MGSlmWV6PVYraePNgOf8DVVM7Y70lQi8A46yn?=
 =?us-ascii?Q?dMaTpaGQOfZuwSD3rnIQ2sTQYeRph/Fj9KsIRXj0R7rHN26ucp8KJE+8t5qT?=
 =?us-ascii?Q?9HZIyXoWe79dEjxXE06aH5OdlrGp81oiLDHrcVUufmI2GEIRqnXeFhKScKWi?=
 =?us-ascii?Q?A1dYgFg4TfRl8CQk0fs/VSkymYjePeqUukdjqQiJaYoCL/NJhY94o4GxTYbZ?=
 =?us-ascii?Q?LlebyiQZ1t3K3A5iXPCuJQ09rwxhrTluxGltBKVkyW4GNNPV40OPjGNaTYw7?=
 =?us-ascii?Q?tg6erv1t/xDGZf2kADvPasEhKlZ/aH6ApWbGO55X0oD17xR/x8zF5NDHe70O?=
 =?us-ascii?Q?CC/zj/zRkR3XNmfqtZMQcbwLRqxnxPY0wBoQ7vdJ65A8yQ2mjKFb0tl5hzka?=
 =?us-ascii?Q?sEL4ZCPdh0HLF3/RF0MpTPg/CC0mhz9xkB9+5O/cTF8SLsF7RLgVGtpY1KTB?=
 =?us-ascii?Q?RY51LZfAPsYtS/WBTFWEaCepnCY/He1dX3vVRB8EJxDQdMahGnSiwRcfLB8R?=
 =?us-ascii?Q?lpB4nOpFRgj9ktN1rTTCtYuWxZtLkiMb242iOMznhcXdz01wJCElTi2UWEVC?=
 =?us-ascii?Q?ECy/n1aEIVBdG5K/hqG1OUWu4e5VYD/h0L8So5UquvkeVZVKf5Roq8SChO9a?=
 =?us-ascii?Q?TkcngwipqwC2/oHB3dRF4ntA7jgcjBFViRzXE6gntd9va7jrnmAR31CkwNYR?=
 =?us-ascii?Q?KF/R2dr/dIiAQmPB5LAU1H0YGBxj6JHVZ5+tUtNRcHxiFwIwLlbVUiribtZq?=
 =?us-ascii?Q?dWmEk2ke97+CeG1uGz9yi4TxgjYWNkVTDSUCmoiy05XXHicE40uhp+UKFHNW?=
 =?us-ascii?Q?sXaBRVg59CXobj3U2SW8jHaXdRZr2Xu8sVaaShQd4fmKVLAxsj13cTuJWzh0?=
 =?us-ascii?Q?Zmv22t2Fzenm9oJ+VhPEAjzpGNZH4SE1GYoJbjMcd24w9GrXxM0a+shmC1Dw?=
 =?us-ascii?Q?WJ2kGsx2liOs8Lnk/zxJ7iCT8G9PHBWWuSHQOTFNXAv76FDq+eMeBWTJUpQo?=
 =?us-ascii?Q?eEZVaedG+RPyGiNtwrLh9do=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C97DDB724F7274289A9355C32DBF180@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FsUFVnRiAgD31/cWg1Ut50JctTMxsMr3KSD71PpKaNzukzIK5pE63YgIEZs+kHZmEcS6uOnJZBchi1+unLzDTWIPtSyZ3YtoNppTMBMP+Pd1zSKNhuAqs6/zhic8TXdTD+vremvg/VbiiphsBfOOc8Q6wIRpw4QuxVLq1myMf/Op0ECtmsXYp8K/bM7VdiLCc9OEXrpJcn7DILtPjS+8PNqN1vRIPYTzEDFBO+GX9/s+8H1ooIZMvQD8fHwxdvuPVGd7SmDWVZJLTp2LcvgI6hIV8kGWG2BzbKf636l1qpXSW+ObNJZAvG+oHOX7u8/l9aTOECNmXaO74ziGO+SVN3WcvjRfpeobJe3wpRU1zoykVFIrRdnqccnyvX9AzqEhwuQlP6vNB+25eUzGZifvlB0Z5ZoclfLb6bwt57+FXTyIrman08w7Rab+pulMQ3BU6Ue1fBXcNNvPrqDKop/y7QrDInGnyXtOsHJVBrxXwHywqKLQNe6bC23PctHpq7lDq+ndMEvu3JEXujnJoOW5UX3HsfT+vBSeqByvpdITNkAb/hvqFo3ImuTp2pn1gSkn9XSjR8FYFTQ+Yc8gwySXHVFbKBI2gvOwmS8pSYCNa7tCoHmKAy+9gB+vEpmxzZ1eUFoyHGJVC33kubEov90/apMzC1FOfrI4uPEldjs8EaF0HnAqzZ6IWyjW0Fk1RApd6HmVU6cvmyzTXXHkYcozlftTNyewzgd9KRAnCX6h7xlQdJ35fUaWmF1IL8KrMsSN/BWSstX/FEL5Dv8ZxDBObiSwSXyE+DOewadVbWf/xSS6cZV1TBgM3+QmZmtAJgdU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6084c0c1-0512-45fc-262e-08db0ff8bd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 08:35:20.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Q0FAfx0gQant+HKUonE2xGHGQUMf8gtbs+ty2DlvBoPAK4DUUgJb3b5i/mMKtCvW+QSOj81Cvrqn4k9RD/lESvKfdLVaavVs/0KYJ2mpNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8761
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 16, 2023 / 11:01, Ming Lei wrote:
> Hello,
>=20
> The 1st patch adds one mini ublk program, which only supports null &
> loop targets.
>=20
> The 2nd patch add blktests/033 for covering gendisk leak issue.
>=20
> Ming Lei (2):
>   blktests/src: add mini ublk source code
>   blktests/033: add test to cover gendisk leak

Hi Ming, thanks for the patches. Please find my comments on them.
Also, could you run "make check" for the blktests patches? Shellcheck repor=
ted
some warnings in the changes.

$ make check
shellcheck -x -e "" -f gcc check new common/* \
        tests/*/rc tests/*/[0-9]*[0-9]
common/ublk:19:52: warning: args is referenced but not assigned. [SC2154]
tests/block/033:27:8: warning: Declare and assign separately to avoid maski=
ng return values. [SC2155]
tests/block/033:27:17: note: Use $(...) notation instead of legacy backtick=
s `...`. [SC2006]
tests/block/033:28:24: note: Double quote to prevent globbing and word spli=
tting. [SC2086]

--=20
Shin'ichiro Kawasaki=
