Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1491C05027
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 11:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBHLoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 06:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBHLoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 06:44:24 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F3748A00
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 03:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675856647; x=1707392647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wTDnfbrFZN5d1mNgtmwYjBnbWxwedg7ygumSStsZ6is=;
  b=g/RsN7oFhYgDb4lcH3zOZe8G44ZpzwDjDcxdz9MwYxeKVntCXxT4/0AB
   POm2QKvMAZi3MXQuEHZK9214PNEXsbPreuWtH4xt9u92Kpp6gaf3f7s2s
   1OUH0/1mV/bADdFMuey5CGv6U5d4Gus8a73ZcqhP+/UH46SvVCqTNpf1p
   Aft09Ds/nZZcIT8v07GG6otqFH9lzBNDB2mcRdD42o6u+RND3Q0Zn/NUg
   SLDRW4WktPSZ1oqRn6kFOopnCjr3rnZHITYfKwCucvnMGxc7FIg80PAO5
   EpIjj0JSdxNVb+Zy3w8eijrXaXKk5Nfzk8yQEpCagSUQ5fLYy45lLZtgX
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="227775186"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 19:44:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlfS+RZD65aaXAZo1il9ZnERjmupr+UuAajICPyyxWfzrKSrbLLAM82OIDr1wLZxKTqCnwn04mCNDWoTafn0m+73BnO552X5PUoRoHAXRCXFa7HaHITu7/OATL67ebcw/XWBNWhGn6YliMXbAK73Pa1nbas+AuMfdT/67kAE7gOI7YcuTXZof6QDnZAahNA+k7vSaqZgv1RBBnDnol+3k3WlXf/qnJHVvTJwY+4mLUJsb12K45AgNQUvyrI9rxPHMo7ljsed9VFYpweA/GGaciEP7R9rn3OjJ0hVPjbb6rkFVDz4cr+/Ywto9zrciHvvYvFS0S9H3qHHyRIOmnCOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTDnfbrFZN5d1mNgtmwYjBnbWxwedg7ygumSStsZ6is=;
 b=D/jbQ77dHfXvXWCBJjYkHe8EK6NShD4Pj9bGTrKnKL7Y8Cvf9hyu1XX5P7BOaGSzkErttzvS/OAcOw66V2Ba0wr9WDC+Qo6+9X1xpfnivK0hibVcuObX3UWxEcskO5kG2hi7ZmzuS2uu1FRHtILnJ3NZ6WXRmitZQVQPCeEvOni4RVahGrVJnfWpzINWIBQccZEpHrNcoTfMeOp+5N6iD/QawvJK+mmHvQDyrdABiUstkMJSu6qqIHGqC9rtUtRR0RKVZVmwBwx4BEWlvDsgwFOcwhJ2mwVAGmjfYQDMcDSXdBk/30aYq6PaFyKnTfUM2D2BQm/39tK8uz0JCiLeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTDnfbrFZN5d1mNgtmwYjBnbWxwedg7ygumSStsZ6is=;
 b=sdPw0oNgTbUvHxWdxOGrYv7nihScNaZW2Omo6MZjnAhIS+0HCZy2j+hPspSbnN6kuJcNnP+1oPvBTtVzQiI1XVlbEiM1t6GDwDdxhzAJCr00gBZrX7DZ7jTBLY5qDXHZ9NierJ7fdo5MPNdjr88e8CahlWxjSk6V8ETfNt8r/IQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0658.namprd04.prod.outlook.com (2603:10b6:404:d2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.35; Wed, 8 Feb 2023 11:43:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 11:43:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Topic: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Index: AQHZO1kRlvP9hv38mkyk7oBm1VzUhK7EqiyAgAAA5gCAAEN9gA==
Date:   Wed, 8 Feb 2023 11:43:58 +0000
Message-ID: <20230208114357.nzoocdy4uzolcfij@shindev>
References: <20230208010235.553252-1-ming.lei@redhat.com>
 <20230208073911.x4iwd4iq5i34xnrr@shindev> <Y+NSYGJBoM8Oixa5@T590>
In-Reply-To: <Y+NSYGJBoM8Oixa5@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN6PR04MB0658:EE_
x-ms-office365-filtering-correlation-id: 4abf568d-8315-4785-7c7b-08db09c9c403
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSFnp93Pm5fIo9AbD8PVBrza++LCk8sX7T5/IsQ63MBM22vTvqlbYG47ltfpsC0o1riXyu+OQjv9RfJ9P7iQuvyKKN/WWjwRBRw3EK8WkkUQcn6JSxDIoEhIgKJcmqbiZoc5IOEAcv5zMyF1qpNORFI8CtzpyyW6UFxnsEWyeTQCuYBXKNmE0jm/kE01vnuehDVRRJ+8UzrpAtIq7slWOhPXfcjtf2hnJT6x3uR5AMZKHv9VthSoQXrcW+I0SZABNbKaLNLru9veXcAeTqiphHQaWxTpFYyn1NfknOQqunhTF2C/fQOVhN08omRQiwzXG3T7sr95QSbTdlXjkdobNHbxEwlu1yXr7XuRGoxdfzMGzWaMlOPHZnKRL1mPZAgP0Zp8JFHFJi+WgLWjepauJhuMCKSSS5+PTbFyDSNHzeqF4qGFzVS9ymLEjT13nmT8eQchgRC+Cl7s9mMweAVrsWkdrEPTG8i8+HnvCblJehMpBO5BjjXXiKVHth4w8LzGNKjP+tHSHUYV71l25SuJi5T65BADndAAgw46A4cg0fHfNS69A42dFIrwPF3yZLRIL5dc9sdE01bDDK8ZC2q65OQQ7cuBcOZQe6w+Vk87GJT6mlo0v2FySKdYZht7tFbXsEKjP7369U+pUKjTw38QZ9mtbr4tFeD05qCwGWnQ76+nFXPl4wUxXl/T5T47aNAfd7lkvowLEzTJVeuSFENCnhzN8NMVQM+9KKoMtpLjy6s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199018)(83380400001)(44832011)(4744005)(5660300002)(2906002)(1076003)(186003)(71200400001)(9686003)(6512007)(26005)(6506007)(64756008)(8936002)(66556008)(41300700001)(66446008)(478600001)(6486002)(86362001)(966005)(316002)(82960400001)(38100700002)(76116006)(38070700005)(66946007)(91956017)(4326008)(66476007)(6916009)(8676002)(33716001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KuAyaJdoBBSGd2KqfqO9YKJwSps3mtw9xRfAkSGREqtXjVWqfiuKC0gAIVSs?=
 =?us-ascii?Q?3YGPg7R88v11s5+4JWjHfzTwVeyjkr/oz9usWjG5lMWtVGp7xwG7WiHIY+n6?=
 =?us-ascii?Q?8whDyfaMDtu+gCkcErBc3zUGavaRZtHLaYFsGvAKPxBJWvKfqZTMMcfBFlb0?=
 =?us-ascii?Q?cT2Gn1v2gRPtVKBKvK1VJN2MG4EUuDbTaB0z0LLxYbwOEL4BbzjZ8LumvkQK?=
 =?us-ascii?Q?ZIA8pWIwtMFUOKV9y5py36t/sGwy1xiQ6SKHFAMXx/M+I2OBHi/GpSWE2OCo?=
 =?us-ascii?Q?hgHXZQCszSUwU487kK2S+02alr5CVSUOxWDTDLNRMJXDA+tMGAC9/tuOpRTp?=
 =?us-ascii?Q?691qszIuJuu8VN6kxpy8LTB0aCydz8xhL0B+yQnbs9hzHgyS11U+SnDshuVL?=
 =?us-ascii?Q?2r7RcZE2ezcYnzht2+sU4cnKnGaiRskcLOLT7eh0ASfm/sANTWWU38pV9ikj?=
 =?us-ascii?Q?msd8C9g3odoNcjrUMIxgpC+MNcyaWFeOY50d7tPaSndTpt5/caHpC9lhlq49?=
 =?us-ascii?Q?BdXw/S0eEwlfvDNbCHCcPtyb1uqzdekzTiNB0ySFezEDPijx6QwTk9uyOmqm?=
 =?us-ascii?Q?Nkbje1q99rJ7bso6QnrxoDY1j/BckRBifhKP9FiwpoZGS9/4ZUNDkRo8MZD4?=
 =?us-ascii?Q?g1JONqd2ITfSbTjM20Yi1ZyBttGlNHXT0rV+RVIP0sw2SROR1m8NKxEA68fp?=
 =?us-ascii?Q?payjTgCv7xDS/jkudRmbUkn21O/FstSRm3F3MQqI/gZBzewMh/+tXtosI0Eh?=
 =?us-ascii?Q?LsOl8VAfeGXyA1ZacOFq23xNYqDWJf9qrT5cWeil+DEk22P/9HNVX9LkKpiY?=
 =?us-ascii?Q?zHIaw/Y7nZo4B1AukqEn6OpYfA88gsmFEcZrRbaqFjHoF7LgHSqX8oW94WHt?=
 =?us-ascii?Q?6hqPXZF8Mpni3CMt1DTLk6js7mV5DucXMMG6CFxFew8dnc2ovvw6ijD/0mrS?=
 =?us-ascii?Q?w2WQDTvQzJadjNE0Xmqh13itLfZs1GxMS5Fyymwq55cTaQnu6Grn6m7hvLH9?=
 =?us-ascii?Q?bUGi4z8ihzwRIe+OurhOHr+90aNntAKh7Z8QDdbIjKxF5tJbL+0wnkwKYYM/?=
 =?us-ascii?Q?AUo7MYkHBmNBE3c1etW6Pxv083jjAQkSo6Mjh14poo1Sl+137tthklBHS+9s?=
 =?us-ascii?Q?H/li62dN4Y9p0cgr0pDJRvbmbOYCrAxY7gOspehnjuWkf9lifhWOTfNBblOO?=
 =?us-ascii?Q?h8s6sDYxMhg1qJwBy6t3YySF/P1yd/KRWno8h6QlcF+PediqhhopLOjNSCVL?=
 =?us-ascii?Q?4phxVJ/tHr6GofiHzLfPHXq3rLQVVhsVP9EckM5D6fTJsEi4P5sRbuqNWR6m?=
 =?us-ascii?Q?ap9IHOwUWqHI/65a6qkTb/6/gG1cigrmvNa8o6TTYAAp1YDdCpbMO/twynJD?=
 =?us-ascii?Q?afBQApqej91ZBOQ6C2JRvrTNESUpuJ94NVZ49ZNr+34kPPga4pX9u+duxEFc?=
 =?us-ascii?Q?Am/gx7CAxBexb+riAJnn81d/YkprZd4ArtaTNXvotGFsgad+hTsFl4wH+Uf3?=
 =?us-ascii?Q?+jQpg8TOfRrbHflrPKddhjF4BfkRdjxqO7AN9gCgsGAtLfRS/k7P96VhNm8S?=
 =?us-ascii?Q?xDwYtTBcky9+kozV8byrOHI8jQe/YUm88GUcXSLChHnw6dEOUuzlhcDrtVM7?=
 =?us-ascii?Q?1KY5ojo7T3fO3vW0rHSq+N8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BDFFAEDD9EFCB4A9CE7A1B804F24F5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vHrpFov84Q+wC9Uumqlrk7dg59yP68cyfnxtUbYkpjKInRLos618INNakj01zDchXcAveiGeIE2MgqimtonRffcpaAifAIGbgG1KFn3vPSapu6ZYSaikTvuhXCw+miQ/X9WI3EB4zXuWNXI/gg2oFSayCCBkoaMXPb478uHgbWOdCItHiGnkDMqpJ+k3Q6tp1ELJe7sKlOen6FyJOSGnh34EHPPxtzFU0ShCHuVyvt/pJyReGuWzYsMWiM1XFXmF1UD/f5Y+43nvudfIAFLNn+YXav2MgptAm7oECPJTpSmqrIYIsGrVmezeFvCJoSIBFuHhEbVR2D8ctwlGNpHZ6v7fsO7QGIi9h5YjByBxNk90BKs+hMIM0zLTI1Q2O4i3WdIzWtlO22pseBt1qXndM9cj1UBLEpvVcOhPlEhJqdE4i5EMMHcRfP3R7KidP65nwXhIQLUfnSILfHDQcrAnecuKJjb8JqtiAsEpr0f3xfG4jJFANk6yjDJOYkvdoO2kxjxKnIYZBnONtjPYjWDioE7nsjfO2tikPdKM0xg/DGZ++y2CvTC6dhkRCH+EYm0AB8h7vQm8v+o6BptQWAWueZX5JgOb1QLbXJk8uOeaMRBIKYKLJQvRLeNoQuLAkHLnNaFozpd8nT9ttEI11p489b3HlvOdGDQPYo866XPyWPdaargRHRKmOA+t2hCLnbeAhZ9fejbSkm1X0oz7hoX7Qbw+59DNm6LY+owiv1u3PpORM4lu17o+NxoHFapSvoI31id89owOqBY1RPPTpG9z5QvMruQQK69zw563lyurc4BaQIzbIxTjnaAvXoDCI5td
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abf568d-8315-4785-7c7b-08db09c9c403
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 11:43:58.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwl74AMBV7Y4J2JF3Q12lK2MuYeShnGPBOSVlkWinOoVwxkEnmXziS5hiORqvdLXtulpNk0am6dJMAqhDml7ipQpTWzPJfnrtxtgsRCI/io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0658
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 08, 2023 / 15:42, Ming Lei wrote:
> On Wed, Feb 08, 2023 at 07:39:11AM +0000, Shinichiro Kawasaki wrote:
[...]
> > Just from my curiosity, did we have any failure that this test case cat=
ches?
>=20
> https://lore.kernel.org/linux-block/20230208063552.GA15030@lst.de/T/#u

Thanks, I will add this URL as a Link tag.

--=20
Shin'ichiro Kawasaki=
