Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 06:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiGUGm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUGm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 02:42:58 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D714A830
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658385777; x=1689921777;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=A42X+vEmEUbzhWYufZ2mPCak2hUR7mxoqqpeP4OADQk=;
  b=bdrXANXV5zpuxqy+ueclJjuUmlvzSQGJSvr0MrlHU/wx69cj9ihuY9cz
   GBl/byebE8figHh+hDMGyCaRf9Wbw0HMUAiwVklL4MxnuSqmRex1zfvVM
   o5F4PoMYz03uOYiEznFo69iTfMqT1lMWM7QMNm2RYrMCEdXiAdULmo6Kv
   081CnWw/71MF+la3S8IPDDPQHxJiF+Pgl5FVCNeHvihM89iLPhPLC7nPq
   4c+9qKXoCuHTHtAkLiNio8C5Sjt0nPd23ydy1qp3KvFaZ2lTCJGjHTdMx
   n+CMan6L67gA0I1ktX9vPnutjUxKFW8tlclTPSx4775pEAuJEqnOvMfG6
   A==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650902400"; 
   d="scan'208";a="207166150"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2022 14:42:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7EHNQPxPWNrT5MGDhUuLzIK0iYO++V4Rf3scD9ngR5IKNTI39tN1OKusEVC7FNDcncUlmD1Z8nddL/lQarBoAZMKds7vLKc1rMuDbaR32ui0gpQoDkJj/+SnhHFgI5lcNrG2NpY6Buhi4gjuGaLc8vaKqCOh+atPA0+XgciYWN38yzT8JZhh+vrNOb44yqzxhwIYprLvk6O+7aSiJfO3wdFSfarFIQ0QYluMZUhs7+HN93KyfBOvDUPcbiuqbTdkGXyH5nEAy1TSuAF7rMfDDEA7V8eO7aU57pHNSIl3jXV2jEmpcjGjNVOkIAT94xIqIi87Ho6idg+OYz5+e4wWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A42X+vEmEUbzhWYufZ2mPCak2hUR7mxoqqpeP4OADQk=;
 b=Laer/rrshkDHUYBg/pDisymSu7XQtZ93WHuFVDvxCbECjIDZAbIkruNEXvoFIWnbnsv2oT7aXosPjOB7XPkFPU0EZTXUCFG3oYZRogkbmjASQg8sq9b28r7MaWn8WYtENh59N9xaOERQOcm4L7/EePvGNJ2ohk2p62b/7B5oHKzep1TamSKXbWImvPQdFFzkgvQGYXdNGiEwlJNEbz3ZUHU87C49Ig+c6HUAXHRBKM5uSWs2HXAUOqRCevhAedpo5LS0zlI6o9q9oDDYlQiKUWSGtMrVQ2K1Pt82htoEZN5CLV5CmpgAHtg/cQM+hB/Q64b2hlrTlrgXSvmIHjhyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A42X+vEmEUbzhWYufZ2mPCak2hUR7mxoqqpeP4OADQk=;
 b=bAgAjcKDi8SffkC9+iEit01ddj9/Q3cxzSiMBLy/UROuiVaSg5UpZ8d7up28UBYaYVfbUpDI4o7yQBApm/oQX11QzzUiN2k0tUcLE2lb7ucqR2jy8hcrZac0OkP0wxfI1cJhzNDFSq/hw8BYg/oQOyfgMWYGZTU1O04LukyMOms=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6324.namprd04.prod.outlook.com (2603:10b6:408:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 06:42:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 06:42:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Thread-Topic: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Thread-Index: AQHYnESK/HOQlDXdYEqfV80l+o7Iew==
Date:   Thu, 21 Jul 2022 06:42:54 +0000
Message-ID: <PH0PR04MB74169630E61C04671EC5009B9B919@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-5-hch@lst.de>
 <PH0PR04MB741657AA4C6612601C75C60A9B919@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220721064204.GA21117@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b07180-55bf-4865-ec24-08da6ae43dd1
x-ms-traffictypediagnostic: BN8PR04MB6324:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXi4VGaGdj+2oTTGrthZP6nGw9lN6r3S/UOTiZcK9ovCIJY4tu+sMqmUT646/N0WD0SEOkFDAQ040vL1co1mNYtCge7uR9FnAvnwX8XWmEStjUw5Dwk4q0twNSNkIq/aacSCObhcSY6ZHLvz2gbFSSrf3Kett6xqH2ChX9LdePu5B0bQuhCdIHA+iyyQwtfYbmSNr/37vP02iv9BqyDO97kMIaEVoeMD+NSxr8kzmXpBMN02pBpSXfLAVdoyqvRJi7Z0uQAZGqcvHfAkJbhWShaUyakUWq/SjPhzSH6HYsDkNfl4qS2A02mOlELoF3qyTLaOLY7KDjSjHFxCklq6QMG+YnzL9H8F0OZ6vIDTuw3UIl9rXxvWuwkk7fO6zHf9IzN9mK5EiyY+vBzho1F6l7ZjYJSgJbTDhxVFt9wF2kYMSwEHE54LNu9Xi96A/yulYXjzZVry5NTu9q304SVnSHbREKJOIZPatS9dKY1g9IvuWyncH4j+jwd34T3Oc60Cg3WO6DxSUKRHFNbwarCGTZbRNcNcrNxLhBykMybVdJ0iXyiKR/brA9xuyID4YQuxPGXPcFVT8hUDZQqKtxuOhhPEZOZcYDWv4pL81fioUHmAUfannSJ3ECSaRJcaQH1YR5/Ay4WXRY6rb+43xLQiNFqu9xnTGBST9aJju9eqWmCv4MuZQl8w+eZ5W18NtC4kkyvKNejcnaVG2+/mrgWmgjMTvPOL3Aij5B3h5u2h64K47/oMP5uxbQvBlLl/Kihczo5+oqL9yOgYZwrmpLH89ZddNKAH7gNiiGajL2Cq3NoPRrTSLQK/hCN3dwSVZtnI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(4326008)(86362001)(52536014)(478600001)(186003)(6506007)(8936002)(53546011)(7696005)(38100700002)(33656002)(122000001)(41300700001)(2906002)(5660300002)(9686003)(4744005)(83380400001)(38070700005)(71200400001)(54906003)(6916009)(82960400001)(8676002)(316002)(66556008)(66446008)(64756008)(66476007)(66946007)(91956017)(55016003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W0xoodsxlKzL+IZZAPm3fzew2nL8J+gW+9FtEuexaArl4GDlZGsqD/zYe1q1?=
 =?us-ascii?Q?FeVs+eG8/GonOpoN9xxJ86gNQDTMM4PIrkj0MjUS3t8LT1js1ynFxkQFkitM?=
 =?us-ascii?Q?XKxmxKxtO5ojVGGdAih4jG3Msz58zreJpJ28ATe93yIHgh27pLgbCgm9dl+B?=
 =?us-ascii?Q?nYgN+Zc4qwRya7sW9AfI4knOM+nRI1R9ekVCMcOU8J13YUIDw9jz9SU9pX3f?=
 =?us-ascii?Q?CQYWGkYwNsJoEJpOfZMTLTqRtWTV3jK9vlMJKf9B8FUFOcxiYa+B6uawGI4S?=
 =?us-ascii?Q?xV+fHz+PCnUuMvzujeyHFQaCjxcbt+0UQSWCS0fwc3Z/fNn31+roELAhdU+d?=
 =?us-ascii?Q?at6RKwjdqA0Xn43RmM8hAq3/djvHSk9MCN5ap1sX5vrpU3jk9LA1s4gYPw5Q?=
 =?us-ascii?Q?6iTaNCIGSjH862GNOaZ7LW66k9IBDSTA2fReJw3+rBNAci7M5m0QjPHESkgB?=
 =?us-ascii?Q?lBLCKoPGkGkSqI8ev1QbPRU9QUoEgDGIA97FCr5hnxlY/MKTzJLazLoyT6Cg?=
 =?us-ascii?Q?DdwruoyK0P5+P0ze8O3FLi1r74i1qToZx+7xGI81wL2RAIT5tIYWFXl/JdRM?=
 =?us-ascii?Q?EogRy9XSDErqmR5NxqjEH4+4Ng16R0tzdcHKQ0PQNQh6G4lyOQbEc7PyMH7I?=
 =?us-ascii?Q?LoAXZ/mYItYh8y3jKrOp7IhQt24I0Og00wCeRc8sEeM3pdpfTlr3/q06eg3+?=
 =?us-ascii?Q?ZvrRtriklF7iZEjUCrCaFJW36WVzAtjLuSk3O363gphUVVzqNuJDtdCBb7Tj?=
 =?us-ascii?Q?q2ziQYenbQAlzOiFMIyeSPorQmyO0g7DU/c96U2eq5HJn9nRUfltmyXXT3EA?=
 =?us-ascii?Q?sifrX5A3iPAsU2OJypcTsx47CCNq/k4dCC9ZaswyWgZRNlc0CY3glh8CjkFn?=
 =?us-ascii?Q?ViXE4rrHNiya1lKcmzN+CGwbifHjA/Ybe6J72mLDBfph7KvtGE9raKjl6zwE?=
 =?us-ascii?Q?LS1yLvzEl44F+zNChv4NmCiSthGK96ajOoi5zhhjPRt6FmZLCMtLAuB4g2Zq?=
 =?us-ascii?Q?y+8rdW6fP7gbNpy9rQbMIdGidlVGkLba3JFqR9Emvp2wkZ7aFnzkC62MAZgP?=
 =?us-ascii?Q?u/FzgeTuIunbi1E0ErApXtB1L7Fm3O9plGTCJAgbkmDHUEQ3wwUL0KFLjzwp?=
 =?us-ascii?Q?Ht94vGykT8fKKvb2o6ZHLmtj1i2EHGn3OJhdwUCzIuSzoi5+9rotbnJh1D39?=
 =?us-ascii?Q?z6pgGaYe4Dzwz7228ceqgPE9lAUgexz5h7kSGdyd949UorC5ZJdGs4QGqzSs?=
 =?us-ascii?Q?LVzCb20Ke29Q44+PxcPwHEEoy+iQ8EpmjrqA8ftHTCIcC4TKYBO37y2Y2Nah?=
 =?us-ascii?Q?JiIydO4A/lP1tvCv/KbhMBLWy5pScbaWtBuzj7E11VGAza0y3euSBfsswlR9?=
 =?us-ascii?Q?EYDtkkDTPuvFwmQeDJXRv+W1bThMiVjZlxphF3JGgG+BSn9H/y4+GmdpONP4?=
 =?us-ascii?Q?GivXOBvURBUa09ybgch0wUgDDZ/Sj9kSizGcbuQBzBvqV4PnA3kZksu0ZBEr?=
 =?us-ascii?Q?CKqKwRRylQiDS4LZP+C7MUctdmTDfCeMCZf1D1OFwMWcfBsjdoOaPgn0jvUg?=
 =?us-ascii?Q?EqEnpG3eVal6qINSzd1FEUIyotN5QpFKNmk2ZR4XaQd+82J2Pr3ahpfdmO4B?=
 =?us-ascii?Q?aiIq3PvtWBOpo5qf8/2QrS4AM/xYAoWUms545r3vTZh2iPDnunPYHqL5xEHI?=
 =?us-ascii?Q?eCF9G8mN/FZ5++qsOzQsXKampZc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b07180-55bf-4865-ec24-08da6ae43dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:42:54.8445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9CQ0iXMfLohG//kxCdOVEjuUU8/5H0gS+CFHbGp/FJtYzkQd+ImRfNM5Pwup7+aQoZEKlbnOp+yxWBGThdp8/H5H923IrYsP85DIGIM2d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6324
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21.07.22 08:42, Christoph Hellwig wrote:=0A=
> On Thu, Jul 21, 2022 at 06:31:24AM +0000, Johannes Thumshirn wrote:=0A=
>> On 20.07.22 16:25, Christoph Hellwig wrote:=0A=
>>> +/*=0A=
>>> + * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_si=
ze=0A=
>>> + * is defined as 'unsigned int', meantime it has to aligned to with lo=
gical=0A=
>>> + * block size which is the minimum accepted unit by hardware.=0A=
>>> + */=0A=
>>=0A=
>> Not your call, as your only moving the comment but 'to be aligned to'=0A=
> =0A=
> I'm perfectly fine with fixing it, but a little to lazy to resend just=0A=
> for that :)=0A=
> =0A=
=0A=
Sure. I think Jens can fix it up when applying.=0A=
