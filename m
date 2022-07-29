Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D8C00140
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 00:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiG2ANA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2AM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 20:12:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E2A564F6
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659053578; x=1690589578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nVk0Z4QlqWY230a+iV83feDvHWPlGTU5VL0+9LcPuQQ=;
  b=Q2uDoYYdJ/im/DJC/GGWz3a+zZGirgEBDDOPpGGgW6YsoH7jFvSSubMe
   SvGbgF1AXw63z8Bhtl4LcXNdwv+qkFRyzO0PTFGQ6G42A32Y/sMhA5kOw
   fz5LPkmOtCtRlmKWnEBLmkNEWDDE1jM4/67E5bRHs06la7rlPAYutxhfu
   zcqRMqR20twv6Y8NB6/2Bxln+SHAGywjGBrAD4rIL1fWn1ltDK0vCvecx
   nI0REDzJkKLBLWLOobWEA1o563RzfMFseKY58lkzjpHAYtZd5LrfFZYEE
   042UEtqNRDFYjq6R74ByObL6wc0K4lkXc2IJpBzCiyTG+qJwoeHP+C9wN
   g==;
X-IronPort-AV: E=Sophos;i="5.93,199,1654531200"; 
   d="scan'208";a="319303186"
Received: from mail-bn1nam07lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2022 08:12:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByfCGB85SPn1HsvnXP/brnhyRoy79xWzl+kQ5+gUDXeA4kIqUIcJDWgm/vyK/0zYLJ+fLY8MNwRG1DuSl5T6J3NgahNkyV2ZUKuLKdoK41utiZfwxdb2zv6Wbn/0O1qB+FxqsPxMfoNRpqZxVDT+nHpn1dhlzu5pQNGOGsS1vpvohY8k4CPGADoNjoEEJxnbA8f5dU5PjuV0MhTc+oSjqqMn32KRlQbEE3DcboANBjn2asUObqQ5/6zGtl4BqwgwNjYJvazYZ1GgHCQv0bmifgpXRie3JePHFJNIuaPj497WCNEL6gyUj3LP/kiZFpzMGvsm4m9cZTJgX01dadiGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVk0Z4QlqWY230a+iV83feDvHWPlGTU5VL0+9LcPuQQ=;
 b=jUxkKQIzObp6b7NCvSnXlyZxp0EwQIJN1WpQKhac2hp/iSH9K6jCI2RvIy2QZMwJENP9yVWd4a2iJCnmhkztUBlsQ1+9HXsg1Xe4LDtBA+v3pSbsUz7MuJGSDnRgjDa7Lnf8boJw/S2B4oH0KNMiEsDAaCWMJlMzwSVS0sSMhb9jEoFCjhlUJX7gtIZdHQWiabFzGFGSjKsdoKQu5vOtigRQrhLFdnsUUbOd5zhrXkXwc29xk+RxO2x7tgDewTKmiAvXB2UQf/thk9U73uNGQEl7HxP9usiKFskNlUR3sb5IqKDEhwwx8nKxKyPb6QO3kFkdzD9DH09KWOVWbynoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVk0Z4QlqWY230a+iV83feDvHWPlGTU5VL0+9LcPuQQ=;
 b=t/2LzQuiq5cVBc5apBrdzQG7ymcf/WAeVUHhX+UgsXhemdDAEePE+faht6Q6p9t/5lsnz/HxdQg8TZk4IgyDZe7oNgwGLSpF/rxwtpaohbz/hI8KrSNmZ3r0J879fJAsypyTvCLo/ScOyXZ5F1XhyOOOpel3poI9hrJg51Kk/p4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4590.namprd04.prod.outlook.com (2603:10b6:805:a7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.20; Fri, 29 Jul 2022 00:12:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 00:12:56 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests 2/6] nbd/rc: load nbd module explicitly
Thread-Topic: [PATCH blktests 2/6] nbd/rc: load nbd module explicitly
Thread-Index: AQHYoZZGdcWyjZhIOUu9KfaVI4j7qK2T3nKAgACeR4A=
Date:   Fri, 29 Jul 2022 00:12:55 +0000
Message-ID: <20220729001148.aw4mj4wstpmepdb4@shindev>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
 <20220727085251.1474340-3-shinichiro.kawasaki@wdc.com>
 <20220728144625.GC18285@lst.de>
In-Reply-To: <20220728144625.GC18285@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a1f45f9-ad83-4f12-5e10-08da70f7164f
x-ms-traffictypediagnostic: SN6PR04MB4590:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkwiDi+SgNlrCku5PG8ChnAPYICKtAY1ZlzImZcw3+3bVm+Z3vWrAVWM8Ma4VJ/PJChCOxiJ77nZzO1MQ3iIszA+rATgFm5XXRFOfXxGjthVdGGcnEdeQrRxOAg0jLJXtYQopQKT2PXurgkApw3TDTRFIEOslogg3BmRePJAxsLT0sViPiX8y5OuxbEUP3WcMzqGtd2St4inF+UAtvVlthsAtOJEJJora8g4HrOgqYfSRyo11kIU/jCg2PQGyiGg75EHErdaOZzJShq9Q8R8KHlz4Ik5z44pWtN6JI0yeiq/W8QNmzngXXxxSxJuZQU5fsuTaZsOSmkokgdmzcqFvOUVIrGJcuAU8EfY3zU4fbmPd38Idzka8QSsslzMFMAqtr2+RXCDdaUVx3Ljf2NQBeV6xZT7Pxr5vhNgK9+W04x8ytwSttP4+IFbH9eKb3cqSGemXggGxAZ0Z61KnWmBFOA71DymNVc+Z0MDhF0u9eplQ/0XFldZl0NEavuyujjgaCYAAGKKxlgDZXWXrzf3JWB0PRP0GIb2nvBqluG7lj8+KXsacBOAU4IHn7sVM8/8Pg68fS6Z8KlNKDdIa0N4KzAE36jqNQ0pkIsEcOFxMfTWsyGI3kPpgfDIymT7AJ5XrKd75ldU9b1ifMpjlmpVBXD9zI4vx5DYP5QPpWDVfY3A+hEtsXeidBJNE7VGlEaFs+nhV75LYTRtU2HjcmIt68wG3TyHSghDN4AacENrRlNJRRpFF5h5bL7zROJyUvj1arZtSABKzNvOcp4aGeENTehsudr6Y4DtGYM/JzKUF76mtkiJo9cGeAmFGn5+Qafa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(1076003)(316002)(478600001)(41300700001)(8936002)(5660300002)(44832011)(6506007)(9686003)(6486002)(186003)(6512007)(4326008)(71200400001)(4744005)(54906003)(38100700002)(2906002)(122000001)(83380400001)(86362001)(66556008)(66476007)(38070700005)(33716001)(76116006)(82960400001)(91956017)(66946007)(64756008)(6916009)(66446008)(26005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YuMCqCJgrpAxSD5rQ9WPmonKF6MUcDr+aKcrXLONp69FiQ3T93bVzv96kmf2?=
 =?us-ascii?Q?Mf8cFU149D5uUipVAiS1UuQPNrj6e1mvNfTtv3vY0UcE/ye5Jd1xFIQ7otiu?=
 =?us-ascii?Q?fL/AM956mtOzprwODQKba7XxXwIE1f9heqQ8o1DzkrGGNRg13wQN1io3BEso?=
 =?us-ascii?Q?yNE35+2XCwhsXFBKV6lOJ6jgRljq7zdY5A+tpseWsPK6b1IVEbggy0a/ltJX?=
 =?us-ascii?Q?N8mFjjdvMgM1WPdNEqIE8kI5jAg7Ze1tTHILR7WMxhqNeI9uhpEncgYExgXa?=
 =?us-ascii?Q?J7DJK8Jz7BQ4Z355aPjO0k1i3AOgaMx+j7mIsmtwS1SbCaCum6uti+xilM82?=
 =?us-ascii?Q?/2Id9/WkTPl+cNY9e8XQHeDkDlY+z8PKmAGBQFh+6eUY7z43q04HjaKlRpWH?=
 =?us-ascii?Q?/BA8FCd2/Xkr8U6T8hBsDa9kNhlaNcqclSAznsO8qhOQosr7gJz01xiZZDIn?=
 =?us-ascii?Q?PBSWP7fJbof67EhLHTNBDxWcYdgddrspLXvl65YyjdJKUBXQQU6FOiFiKbgy?=
 =?us-ascii?Q?j+TTaNC8Hl3M35XEgAsxhx+Agkt7HtiYthtkEBEOmj/4jAoUIRqhP31jqwz7?=
 =?us-ascii?Q?xZ6RgQ+XT5DgDve7Nzdlsx7mXUfonl0SCUPKywFpokXcyTU82Dq8TE52B082?=
 =?us-ascii?Q?M8IlbeBBqzf2FzvMgq7vzsVIPsguvS7W3/B6yuR1virHA7jI6UZVwVJ0xI0i?=
 =?us-ascii?Q?E9vpNrF3ZcqA5q8ijek93/c0ZAkCO/RDdmOBlL/gdAjFnpUFnWGv32WLvpUQ?=
 =?us-ascii?Q?lU5ULeXOcPnm3/6gQ/2trmGtBbK7llhF21kxPzTAgHc7cgeGYpeMUPGeNPKS?=
 =?us-ascii?Q?DQVpw5ERdr7zGe+dQW/TSCZgll5VMKoxXWMRMJk0L50c+65WZ5odiOMKapv0?=
 =?us-ascii?Q?OG3TIYHMm0C8qC/AFiSRUaEerY16Kj1tSlOrYT4GROEX5KqcMngdLNKhKLkX?=
 =?us-ascii?Q?qmg9vekL6O1ZeVWHweXEeUMAmy0XUgUM47YTJYL3KOSs5tVUmSP65u7xO36z?=
 =?us-ascii?Q?ACMcbvnwdepMHdeYervj5PJ4rqhk26qw0DpuK0iwTPZOcrXFAmIlWzfBz/xT?=
 =?us-ascii?Q?kc/nwUrPnUFqzd9cvOhOddyUq1APdpkdKICmst/7dlW5eXu3nusZMtL2fd0C?=
 =?us-ascii?Q?O3HWDzBfU5bC497CJAeRTg0+moz9yO50w7GPI+rlKHsDvYGv9wpPMHG9DvNE?=
 =?us-ascii?Q?B/LbPlIYLfTQCkuM+jTjVgdAB/XL1Ky8eNPq77KsmlV22pp1zO+4kFnpnAgC?=
 =?us-ascii?Q?IYr6BY+SBmaxpGV+JXkvWS0LHWiaNtq6KoL0TElhCHzi1pQrDz5IZ/VfS8m2?=
 =?us-ascii?Q?EsP4c2n+AKlJJgMNsjRxuNfJhG3B4ZH3DqR5MYYVj7kTufCM7uJIHHH1cegn?=
 =?us-ascii?Q?ByUYsZrfpipmmjFAcnnxsKdGBEWIkmQUydSQQ1zyQSYKuz6NRdCGzoWdvw2h?=
 =?us-ascii?Q?MoOccJT3V9zqHiyL4xmOYWDw3kKRE/7MrOVqibP8AblHIMV9O2lVjKJvsC/O?=
 =?us-ascii?Q?JFn2fPSeMK6A/vXcfdXKv3c7Q2NcYT8wOrgRb7Y2cbJDdmEBgLIYJ6RSREkW?=
 =?us-ascii?Q?zpzRvdAzfDM8P7n2pVm8Cc9xoTbRkp19Y5ZDnm5sBi/fQKH5z3xx8goisvIC?=
 =?us-ascii?Q?3mklRZzBKM2QtzAYg24uBGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93739C7E3EEDD84B838C31F67CEC5DD4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1f45f9-ad83-4f12-5e10-08da70f7164f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 00:12:55.8987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qanEAd5509Y5E6ZLSFeuWX7fjfPaBGXEFwvUFIwxbDSwDPAj0yxdrjSXMvaNPwULUbn5QBcC2TBOktEVRFw3oq2Mpp8BRdLrNNx5Q23qdAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4590
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28, 2022 / 16:46, Christoph Hellwig wrote:
> On Wed, Jul 27, 2022 at 05:52:47PM +0900, Shin'ichiro Kawasaki wrote:
> > After the commit "common/rc: avoid module load in _have_driver()",
> > _have_driver() no longer loads specified module. However, nbd test case=
s
> > and _have_nbd_netlink() function assume that the module is loaded by
> > calling _have_driver(). This causes test case failures and unexpected
> > skips. To fix them, load and unload modules explicitly in functions
> > _start_nbd_server*(), _stop_nbd_server*() and _have_nbd_netlink().
>=20
> Did you test this with built-in nbd?=20

Yes. I confirmed all test cases in nbd test group pass with built-in nbd.
The modprobe command with -q option does nothing for built-in drivers.

When I confirmed that, I found even nbd/004 passes, which should be skipped=
.
Next patch addresses this issue.

--=20
Shin'ichiro Kawasaki=
