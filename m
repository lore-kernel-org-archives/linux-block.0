Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C674CC636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 07:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjBHHkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjBHHjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 02:39:43 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B68689
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 23:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675841962; x=1707377962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iWY+ZliZBZMOuPgAF5ULFPq16GQtfcXf7MBVycd/rpM=;
  b=MCdlf1rAkUArwhihILEJ6sCLr/sXkpsrNR5hbTqKTnKzZW9ynXHiJFGR
   45ukcHCF01SA2u15Ngk2Y9+oN2a8OVEJUYcwmqoHxXxc+B2xAg4j97oKD
   M3mk76mtZUBzWpn77FKxD2A0rFST4TPNkuJVy1opWME19HWDZDn18N6kM
   V1wmamr0bbpQRCuNvpV6mvUMqxi948CXp7jYFW0ddCHwSDkX6+CNapTef
   SdJBCiBmw5gKV4RcXnfxApG0SSHwIzbQodTT0F9mgl5FN3LeUPuVtaAuU
   yiA3pvRpyjncaWm6kAQohGtGgUtbuJ4eZ+LSXbQDy4KaeTe/qHyW7NEY7
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,280,1669046400"; 
   d="scan'208";a="222824557"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2023 15:39:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRi71DtbbRy9jefr4Mah4e2eVu8/R1SMkoawVV+Uy2ITU419pYc4ogCa2oDzqjn7s0lBhgiODMskrDm9fqJfdSTpqA7MtlyBUgohc+PMLJq/F6ltTGo4giuFSfJv/a3ZMWLtLxChV/M2dQCqrQgwskTOzGNW0LaeWRLNqTdkVCcsAbCgt0pghYufBDL/gMXsgtquUUHOZMXPcv0ucLfRDokfnEgISQWrEaOyKB8nRKROFCKPLZxbgz61ETvdvBsE1bZ5faF242LhvJqYLze4qm2K7gCW38hxfOa1i+6qLwmcZQgLHihX8SGHAQ6/JfObMAM9gIjG9shFWAuzrDWILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWY+ZliZBZMOuPgAF5ULFPq16GQtfcXf7MBVycd/rpM=;
 b=jos2sAGFdbSj2j/DG+F1H9JO302ZO1PxhoLCIizDojVc6ryvZEgQNHR0X7sx7hTtIrsnuAhUoOnGQSd6dMz3fAB1OmaOn4JKkbHgc2onadD3HONEVOgWxN0UMKXIvTqTr2zhPnfDS8ec7AS3RZJJ9Pb75FlH/RITb2VF8AX+7aFkQUEqbVToW5Swy+29y0UTNAE1gFbchHn8BVGgYvA2jeZh44VNGrlA2bPsUemnB16gTQv1/fEhU1m9xeSKYteyjjbC0LM9QLWf6Of4+ItbAckCXQ0rxCUprAp8l5a1TgWTm57zaAOnVdamj5Cno1UY+jB8xBzaYEgzVOIX26d9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWY+ZliZBZMOuPgAF5ULFPq16GQtfcXf7MBVycd/rpM=;
 b=NOeUfzzvFCGAtR4CuLwRm5chzfGcA4OBCvWPoCnGg4ht66dJvr8X1a80ZXGmL27/XT5Po/X2w8o2rxQfY+/FDFXk7+eQLoYoPk3XwQ2LJls1MSR+XPZxdetH9zHxcqUpVaHapYfUr98GLibUC1ORlzTlVhdRgq954mWUJIu0M6I=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR0401MB3656.namprd04.prod.outlook.com (2603:10b6:4:7a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Wed, 8 Feb 2023 07:39:12 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 07:39:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Topic: [PATCH V2] blktests: add test to cover umount one deleted disk
Thread-Index: AQHZO1kRlvP9hv38mkyk7oBm1VzUhK7EqiyA
Date:   Wed, 8 Feb 2023 07:39:11 +0000
Message-ID: <20230208073911.x4iwd4iq5i34xnrr@shindev>
References: <20230208010235.553252-1-ming.lei@redhat.com>
In-Reply-To: <20230208010235.553252-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM5PR0401MB3656:EE_
x-ms-office365-filtering-correlation-id: a1625747-b8b3-4471-f32e-08db09a7922c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXSdBZsv3ykLzi2E3vyt7dM8ao7ykhgOtHSvRCeUa2yN+k6zx6tkyjZ+m9J1X8bVM3fP5BszQMzG780y3Niuz77bwWPeVzHgCH2NvVCwzdG2F07hPDzgNCHz44JZQtx9IJsY+Am+3g3kSO2jVcWR0gz9LgihVrkRmifXRR7Kb2L/IgXHat0cKf+MfzHMkf7iyM7yf/wj3DrhTpCyw7Cylr9NBrY2HgFEjOmw9iRZNRrpfJBr8AYumzVLaWgGHMmL/qBnaeBbL2qWdhdQm/2rkx6HJMDlvH9DobaXp3Ju5qQc0SteXVoWL9jpnnQzgNJAboc4Q6WcrHszy/kGK0f4BpKjCDJtM/DeiS2PsZp3k8DcPA9NVuKErDSXiYmJxq8Iwc6VVrje/gQBhZnz1089KltkrHQFnmSf7Lb2gIOzPaowEQf/TnEydtoy2+l9EupVKHnZ7eY+MhLlGFb3BLkcJ2S5FqDp4LbWnZ8K81Ub80q0zEwWAII7uCmInPWcZjP28Ah0UUlhoQ4nR1dHdcXKxJLL2pPkUwrwSMYy1w9ds9dknlFXP1ZBitrNiwIXXKvvOR/qGlbI8zOBFIimKeG6n+bCYW3HJpCOlZjM7VViAXZKg//Y1yOwRUMyiEi9FKA/4UWsW3u5IwzzRxYylr8eoOZ+/323PLm2lqnFtsiWEvVsvcMDXw7LLYU7QTNTHPrOaKK0GxLOnELtyMlLqisi0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(83380400001)(2906002)(4744005)(82960400001)(44832011)(8936002)(4326008)(5660300002)(41300700001)(76116006)(66476007)(66446008)(66556008)(66946007)(6916009)(8676002)(86362001)(316002)(64756008)(91956017)(38070700005)(6512007)(6486002)(26005)(186003)(9686003)(71200400001)(38100700002)(478600001)(1076003)(6506007)(122000001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CAJU6qnuUjcruVeeTJEiXBw+snQTgNG/hm9QwvbfYbyOre3l8sdVnfRtf+Ou?=
 =?us-ascii?Q?2/vTkgR/Npb36ZUsenYJqRqcwt/GM6VHwDVkmiYgCOYfL5GNJZ7jMfRZ9zry?=
 =?us-ascii?Q?Rj8sG1fLi199l8MtqlXycrPsa4BFLUCbDE0wjs7S6DcHqN4YQxY8m8WTJrCI?=
 =?us-ascii?Q?tcdELLCPMoKGV62zDpJWCw0uFFiKMZR9qD+rmiSFBoWtIBJmqdmJtFPXqaUT?=
 =?us-ascii?Q?uPSDSO0v3PKoeCcF1jEeiokLKOY6dxXp9xsrx7hBCDfpM3cxajCBx7SqEYGL?=
 =?us-ascii?Q?+a6uYcEFvpuco2GNN1HQTACRvxtqjP0GsBgDKeuwELak/45CRnwUKUcE4F7h?=
 =?us-ascii?Q?J4SrD+a+4LUxTwgjoKi5+7SI1IS2zXklGJOwn+Xy0Jmb6ZNEsGrHR+yDtrfH?=
 =?us-ascii?Q?31Th5P13fKMPpVXajZIc1bQvsVrQuOuK2PEQm01z7lDMO2kF/J/sRYN2tfXs?=
 =?us-ascii?Q?bprYSvPk4gVnQ+q7t/ag5FK9Mh86iNJ98Y3j+3yHdKD6IShHaTJnD2iDj3pI?=
 =?us-ascii?Q?LSPjIpa0PuA5jsgyuRBtIt8JaI4/r7COjWNQSOLMFbUknXQqYjtCen9IixoY?=
 =?us-ascii?Q?gtMBAfJXKm21pTq6WbgO4uj6YD0vOXeoZTIrKk3FJzOww1Gu5FWRhjxdqgLn?=
 =?us-ascii?Q?jpxKJ+BJHHgqDi7yTo3ZSkUdIaTBG9xuXCTgu151/HFUhe2X/QdW+MtpgOpr?=
 =?us-ascii?Q?0NuGoEy2QkLLGtCaDHl08Cp/s/AdmF0k6sJifDEm26O+Xbl+SwLzEwEk3GPr?=
 =?us-ascii?Q?IaFwonRIgEWMkCjDwTARJurIx0jCzjFNo4Y/WpqPrH/TqCJ61dyqeO5fb2S5?=
 =?us-ascii?Q?Cik+BN45HWX6Q/41qCuLzJ0NWy4MiTzOSMjNTF3hOnO7h2qU08fXIv9VnWDR?=
 =?us-ascii?Q?9OXFOGgE7mSI3u4I9mYjc9UJO7DNrZF2Sb7C0LLBrwskVPMc+A0piJ47noMy?=
 =?us-ascii?Q?vcRYWMTfPEX9aCJeakfXJFfXsCznBvatyl5PXM2QanC/GW7/t6PisT8nT8hf?=
 =?us-ascii?Q?2nZ6zkBovj/vvOrg4np0q73uw/GW1JTo+J6oPH734kq3MeLNT1rXWSuewUKD?=
 =?us-ascii?Q?443M4C6i/HA1AGY0UrswM0qO0nbWiuJXax7+E3TC4dmn/JF158Q0VTg5zUQr?=
 =?us-ascii?Q?EJL9JY5YgrSpFz7CXXOErpWAUBvb/yHEop3e7ksR97gyaVJKHHgw8TEQYXmL?=
 =?us-ascii?Q?HssuAyvJofGZ7VsJ9pX17I312ck8N46cVCXGQ/wuSNEwjf4gTy0KB+UAV9k3?=
 =?us-ascii?Q?4yv12eZbunUbFrSoJLIs7sHUUnZLz9j4Xz/xdfrtQ1PTgqC/YfoI1yQ7WBKu?=
 =?us-ascii?Q?MtgdIb1KfS/a86Ttiea7gkwgrdffYvNt38/WK+wzsEThPSV8bC6tvIHUBVj7?=
 =?us-ascii?Q?8q9+E7TNyHfxrprQ6zFJKPxb/D1vk9HRG/L92q/Lzi0H32QOY305P2WrsAFg?=
 =?us-ascii?Q?3BrGjoUW3tys12tRnofgXRaTFQIvo77cYIYlf/DDNep3yuKeukvw8TLkfUM2?=
 =?us-ascii?Q?DQ4a7pitq2bOAJwSY+oKO6TqR5Bnd82Y3S5iPFvlcC6rcVBbzwjH409e2Jhq?=
 =?us-ascii?Q?7FFmhPqyuL5OdEum+QIE/O2lrVgn5Q/MHO7gVH82/S+JiyTbtCaznefeHDeb?=
 =?us-ascii?Q?xOg3SCpzaSvh+ATmICWZs5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7A835D6EE97E349A0843102A3DE8C70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Aiqncn3eisvvysIDhnwd1NtvU6Wp+WJ4Xdx40mwnngJ6R8y5Godpm9LZzfe8i5XfjxeBqSbbFUjw6L8wki/qZt8bjq2HEJmwky4TdveeOUzvKCjyOJ8+f0EiEVkQJdQGDKpae3JOpXJpv95z5ahlBhLltkNmo06TDwmEM26alnIXm7pyyIgOw9hGtloAz5r+fCT9kDklZdIhmtv9khce7vbhEBA/e1kofScxuV+ZhVxXdOYKCWwa+4O4Grc2b0ofb+LlsvR9CwIDJvzqCBU7lwBe2buCDYjhFdjYsurpkdqTj2DGaWngvNpa4SaMHqsEGVJN48NiZrK76Jov7o6USdlqAbwnqWTJZQAxhfoBVI/pzn6aOfp24LMV2xFl19SHKnXbHgdFvRSAPMXqgBbljr9Z0dV37x6lFO25B9vB2BcliNKqPzyzKAcORRNTtX/yShxHg+7G4jAROLVoBIOnsDl9C1Q17QoRqEA1fvGqh5l7a4O6LBiVxQtINhLJhmMXO18uH2c+NPgOrehDZGGNbSr3+Mcz27N5QxCCtevu0dgOBgU/7zX0FZfTJIDelqfDl3jonKYmCDxyVGEN9LVhVeQKJWly4zEbeAxiDE72vBGKTZGWWcwXwmUJ5MHA1FGnPyFiLV8UilL+5+4BWw7TRiLoAGAdBhTkTuaxOcJMOuLQIzROy17ftdbmyFLV3ZNK0orBLlQpTvZ8vhIy/BeWy7/CANKpxFGtXVKLhh7ay9MQvgxkfJnzm2dUarAm7pG8dF1MiOU/rT/x5LGCRju1oJzToDKyfM7f7Ho3ph7PQ1jFBLLZQHnAEBGkStmzLqL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1625747-b8b3-4471-f32e-08db09a7922c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 07:39:11.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wrx+Mtn6ZzhoMwk0xZZz6lwJeTJdY32wOOFQlYBnuC3Cx4EaIew9rkbODVNsGVHA1FEvjwgR1dsbOP3h0jZZ9gysVp9hKn864y9uWdhrZ7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3656
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 08, 2023 / 09:02, Ming Lei wrote:
> disk can be disappear any time because of error handling, when
> it is usually being mounted. Make sure umount can be done successfully
> after disk deleting is done from error handling.

Thanks, this patch looks good to me. The commit title needs some edit to ha=
ve
the prefix "block/032: ". I will do the edit when I apply the patch. I will
wait a few more days in case anyone has comments.

Just from my curiosity, did we have any failure that this test case catches=
?

--=20
Shin'ichiro Kawasaki=
