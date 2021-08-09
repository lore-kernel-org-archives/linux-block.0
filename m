Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E56C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 09:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD90E6023B
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhHIJuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 05:50:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58993 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhHIJup (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 05:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628502626; x=1660038626;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=cRZiFLZx1PVqbnZ3qemcibyUOEc9YnGR5cjnQO9ZEhU=;
  b=cBVY0oUN5McqJ/UG58qGc/zaiS+d1ocgTNr/fpXvx8ZL1Yz69fFaB2hf
   XQsfJnhjvT3oRL30olA8K9YPDVuMgEcw/iIA88jh1NpFHfUtmrFrFwPLi
   2mgxotBgRDO8gD4gdTYxntshJ2Jt4dqrz21wvsBMS2Vy+MZcYFMSNU4L8
   7j/TCq8MBQX+R9txNnIBLxJ6hrdgAHsmRfg2FgqcJxbWokfY5vdCxwiEN
   0YKUdRDetRuiacAJqBz7IF+0L0tPdd/paPdxt94ShRiygu8yu0qqjM+Ji
   rOkbR8VDsVY0gQrBFlN43Rj2VMimdmQqAo+ZOYoZ3ngOIHApo2G3wci8b
   w==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; 
   d="scan'208";a="177231216"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 17:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH/yaHRHIR48zZUPjHpRCytHf0s5ogkl9ZP0L/2CXAVNruTIJMW6yipbl3KQnnMf1QMcwaqFtQ59qXWHbgMhbSA9AKtlKDFm8vahbJb28dyJn1WMyfPmrNXXay4gSkyvautWf9XOpe15tKbzS8iWP+riYaZ7xwfjAnLKs+CxFCkBEZ3fgYxoLb69dPbEZ+oj2PUoYjJIiuf7Y0nAXSazNvp+Cdi9RUnerVNL68xDY5e+JIjITK+W4PoGHndLbQnnGhssPccllOZtW1mMHxiYe8he0IbCSdS/fNGrHXPzdTIEBLg00GNxX8ZW4v6151JWYNUopQIDW4UoyZIRVLpnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87duJSL4yRZ8gwwTlMynL0wNWrqGY/MxYqpDEezxKEo=;
 b=DnH4VtWtNn2CLDzMGED4eVgZzT3Qdhbj8Oxr3YcbD8fqYS2Ysa3RM28e22aU6Ons53fhvxfzX5cbtx3WD6HeUzL637p8VIlZrVgSXq0OUbJF5alr4l+ctmATdfuWuRcmxQyN7ZRvWeL5TkRVHZlHZer1G+me6AsIoAzapUyfQnfLxuaXiQ4jKGa/X/3K40KCgFFo9GiDoEFiPgt56qhwMWAUf6Xp7aD2ubj2NNU+not2gdXNVbCwXh7+6++htRoT3mHIwK8o+TUnEVTnoQjrlDHSMQtTi6DwAai+GH6AX+DaAPxGDDeGO1B8yiCMVzQEwzQui+8uzLIUJxdbxl28yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87duJSL4yRZ8gwwTlMynL0wNWrqGY/MxYqpDEezxKEo=;
 b=u8iKrtTBipkH1TXDkgKHtI3QbqbCaWRS045S6OCpJdcC4VF+tB4MeOYwDgUhsN7vqjpdI7NSgizGuyhQkEoOMWwfVZaHyO7Aqn5uoTR08wa6DV62VNoG9uxrnaRE3XDYOStdCbjhs1mg8ahEIDamWuBxGTECyOKzTgsdXPMnIjQ=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7558.namprd04.prod.outlook.com (2603:10b6:510:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 09:50:20 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 09:50:20 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Shaun Tancheff <shaun@tancheff.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH v4 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXjQP3EOneW4VBS0OAg3zFJ8KiRQ==
Date:   Mon, 9 Aug 2021 09:50:19 +0000
Message-ID: <20210809094855.6226-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be147cd5-309a-408f-2ca8-08d95b1b199e
x-ms-traffictypediagnostic: PH0PR04MB7558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB75582AF52BCF1884DAA3EE27F2F69@PH0PR04MB7558.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lj32WoAXETLNhYOmjxchFklpJuFnJWY7wbjvw+/df92ERciB4h8Wp+f1BibPd9fxxoLwxANj2pW4oof6c5SA5E7U5F7Rs7V7idgf+G4aMMRpPSOrPaK1L6Qy7n2XC4u10sokU+gGSWv3yMDhQuoQOfBGwxk0Sv6L27DB7YrTHWUUkopmQNuxJ8ynkeB+B7rJEypa/RKkEQj89aNWjJFRTMWV3i0zFLf2BrC9VS2y32wmFNfe6Bpeppgq7qgfGtGoK21esRZX76hC98hqHxGALcHlOMXcJ/Rwd9wOjv3SOqAH9piXRHH16yue99CRhMcCRW50l2u09EC5oiQn1JSl6ChEDxtzX1bww+82lrqJytXIfTXYqdfaq/dfO32LHGS9jDj5cZfQFIMXP0W6Acilxe/dQnE+e8NOv6e4LUY1ZK8xu72YqpMwLSZG41IVOQjFjxm3wajdIEoZ9pw0a3PHKTk3Ii3A+DHa0ZZglsJKv+AjqRX5fl1aHqP93SnRMwjYo3+wK3hpt3IMCgzIlldI6vDm3IuXeNHk3Bwh/XM3cwfecrh8pHJk7UAVoU0/uUNwIE4r09ShsSwR4vD6xTo2vUktrl5zaPK6QXEAszofM8frgVwRtuPhXwcROwJw4r7+oszOTDF+m4vq7SlDHY6Xev3fYF2pW9OXAYzlgNqBfqjYuMTs1Btcz1KAB9D5LyCrLxttstnVY6kdRKmSpGN9Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(2616005)(38070700005)(2906002)(6506007)(8676002)(1076003)(91956017)(76116006)(122000001)(186003)(26005)(38100700002)(8936002)(6512007)(4326008)(4744005)(71200400001)(83380400001)(86362001)(66446008)(66946007)(66556008)(66476007)(478600001)(64756008)(6486002)(5660300002)(110136005)(54906003)(36756003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J9ND+sEn0JLyy9VM4uAJY57I96ZO/mNgYmDN6Z8Oecc/MU/zWUVpu1Afgu?=
 =?iso-8859-1?Q?zAe5dEudccOoMWOn4ERgO3eWrzu0sfa8Tbeo8/R34yoxjPk4xhyIZhmSIr?=
 =?iso-8859-1?Q?GF1dpWI6lCwnGVWQ9LtShlecrOvIJ8hmm4uvPaogRyKTHOshmUIC22old7?=
 =?iso-8859-1?Q?JCbr7DzxdBR3tXwk+RmRRHajAZ/qt2ZuyGtzM8JyJ+eI+RGxOhFp4wEICH?=
 =?iso-8859-1?Q?7W0iaQXdKjndlfp82v9sUwdVF4H2fhX0tqQ/UYwMnpRBPf0RT3WjL5Pqxv?=
 =?iso-8859-1?Q?sX1rgDjqWV8FPvvMcgjqqYXoI+RjJ6+pMNDK+y+OvEhEEe7xtXf8DeLnL9?=
 =?iso-8859-1?Q?jtHLmZX0kqEoEuJMjNlPT5kAY5IsVoKL1Nhn6xSq3RxIe+sJUTdEyPBAun?=
 =?iso-8859-1?Q?ljzrhVj29TiamJSheTOcu5rDeD7fKl+cWQoDEoLuPCmdhvT7ZZ31n/tNAw?=
 =?iso-8859-1?Q?K7myNs+IkbXhzFeHZg9PnnoPwBv/8onGD0ZuqqvqBDAueE0tkgiBHZgh9P?=
 =?iso-8859-1?Q?ddY7qDHL0G5KBg3BpJmhrrjfk0NWgsyAwqRDLeuI4WuxEd0oDEj+2J8BVh?=
 =?iso-8859-1?Q?wrFuP2/djgDFpIqP3aZj2bivCnfGUs3pQDEugarVF3YChx796hDkkYnkcg?=
 =?iso-8859-1?Q?DvBM20DZBxQYnMYLMp/j++tzybCqslLSSaa6XzNZupc+z8bNMAc+TjRg9B?=
 =?iso-8859-1?Q?oU10FWARFL4m1R/Wmb+Xz6Xpw0r88p+WORYrzU9EWsbXDWkG/M6Y5m6Sfa?=
 =?iso-8859-1?Q?zX+jfsQ5/+qqF0CUldQl+WEACz1OoP39tH1GG1cqCQOaEtPEkLL3Na1hTl?=
 =?iso-8859-1?Q?Srpi1GY3OzltRMYSOsOikBflpvyozDjINqpscbGEIQeqkFu1vlYp9GUbTp?=
 =?iso-8859-1?Q?gVSz5Tnww3eMdOVkiuYLH+sSFimAWo7/X1Y0Vwn2Iv35z8JubKQYzC4iQm?=
 =?iso-8859-1?Q?1XC1HEN3nDsRNSPn4t0JF0gyM1EkxnY4EhQghU8T/XQqOKU6HQXaMMhPXo?=
 =?iso-8859-1?Q?hqStNsUaNc5b+i7soUylZCzxc3kJ9AWWgLGQ8TYAFWz4AaYOOzWvY4ZPhG?=
 =?iso-8859-1?Q?h5Ma+cFkxziXnfSIMU3eXFi9XT2pvDZe2XoI5n0OI3bamACGRFFoFCGb7K?=
 =?iso-8859-1?Q?VAo7YOXHUgT62Eft55isoMvNBGJ/D2cxDf67sm9Qa2ZvVr59LPp3GvpuJq?=
 =?iso-8859-1?Q?S4XJ8xJ69QtaOY+WjaVmflyMbxesowxysK6oC6c1U/8bQbQUhPgAPLlVWA?=
 =?iso-8859-1?Q?Qn89FP5R7ZtiJhGH3ZanHhLg/GfdwWYMDGq2wEfSHJkIUZXG47vhVS2GFr?=
 =?iso-8859-1?Q?ehNoypAiGa6AeoKbWdCzGWmTmhBEdzWjbkDoGUblxHHBv1hSZfXr+BHcPV?=
 =?iso-8859-1?Q?YuGGWh0BQn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be147cd5-309a-408f-2ca8-08d95b1b199e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 09:50:20.0083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TmXdsuf7ErSLAZ6MVuF/zclumspzK+9Fr1mBymUblmy20PerefJybAjPzZCbvKSYP7P7693OHRhND6747IU2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7558
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
CAP_SYS_ADMIN.

Neither read() nor write() requires CAP_SYS_ADMIN, and considering
the close relationship between read()/write() and these ioctls, there
is no reason to require CAP_SYS_ADMIN for these ioctls either.

Changes since v3:
-Picked up additional Reviewed-by tags.


Niklas Cassel (2):
  blk-zoned: allow zone management send operations without CAP_SYS_ADMIN
  blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN

 block/blk-zoned.c | 6 ------
 1 file changed, 6 deletions(-)

--=20
2.31.1
