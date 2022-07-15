Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE21C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 08:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiGOInr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGOInq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 04:43:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CC22EC
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657874625; x=1689410625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uVJA2UW55CKszStiYq3XhY2pTJtM4crXxWeoGzal2yw=;
  b=XYn2wh/uz32/+wCVgVzJ182XZAWds3UoWcqH35EvzIgJmcf0C6/YIhTT
   RL5FU54L4sSgMAFx+V13viuu/zx+bsYTosmqITFTYxz5xeW7N8Y71ipG5
   /MQTOYFThPLFn5emFpoageqMHHrthKWL4knZCopwnMx9BA1mGqKO99S5U
   zdTor4l2PSDofJ1cqFB5SKaeAr9fBEWvxnl8kDAbqSAAdWRQuddxoB091
   53+Uy1Xs+CStSQ7LP2ws9YFNRQtWhJl5HFNqDwoNz04LDz1JxuAlbxxSJ
   fe4I+1y5+6EP/L64Td5oaFg/G9x6DjJn/RGdR3K3ao264VN44XH/Dq2OL
   A==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650902400"; 
   d="scan'208";a="310158276"
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2022 16:43:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if7ap1HVnutagNREj3AvomGMCQaySzXl9ixV3IB8VOfEggjOcSg0O2ezKPdQtdw8FQOZhl9Y+JjIAGyx6aO4Aub3H3BBoEuzTkMzzmAPSbw3TtGhl9dlhPOw7tKqaaSY/QN5GW/aegC1SIg3iLnO3k+bo0H0scw14/tgQ2YW03r/vAq7h8tLT00N2WtPBRy/Ll1XI8VKUekLo1TaKC9+70NtVJqanL2x1QQtFBCNX/wXa3FIeLV3mHYYHX50GblkNQR9QmsklmXo9g7YtKYIhr5EJu2Xnc9xfNjEGuDVeQb26RA15GoxTW5WGMoj82Ie9wUcsmtDxg693bhnTU3kvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVJA2UW55CKszStiYq3XhY2pTJtM4crXxWeoGzal2yw=;
 b=QR9NIwxWlLUlcdezAQzMKLErZLUcra43AETlIi3Y9pJwDjnwPHkQSKo9D8hTpA1zY+Hl75Q7JfXhE1LxoXP3KdornpuOMzVlY+ISWd1rwJ9K5CMhyFw7VeZnrN7y2lmPY4xtMmPVtmR9l+pv9nPoIg64ZNtCEG4q50Nbh1sGH1/KkisawnXoqrQ+GPcuY6yC6R0qqDH2B5SK2Cf4e23odi8CeXDLl/TkE2bgI/lhPurYnnBDQL9mMpCgMiDuQNqmT67c88B1S1E2Y/PaK/LPa+iBcXbuYfCqRSVgslo+lHlds6kD3vzgZyZqNhv9PY5tcK/o2LGKCw8CXXILxmsAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVJA2UW55CKszStiYq3XhY2pTJtM4crXxWeoGzal2yw=;
 b=QZ45GN29oxyzjuK9lDAKprrpWXGoU2nBmPeYcBOyQg/7/jHaL39N9pjwLbNOvMDqZOG6DiuVsHBEBWExJbiAn5BW/XPJD1aILD5ZnhSrK4/cUCjwlNLODhsDkLLzwiK9QI5+/VIWyQKQfXyKh92G0AWseM40H4VG/XgGQckk3xA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5480.namprd04.prod.outlook.com (2603:10b6:a03:ec::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 15 Jul 2022 08:43:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 08:43:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3] common, tests: Print multiple skip reasons
Thread-Topic: [PATCH blktests v3] common, tests: Print multiple skip reasons
Thread-Index: AQHYlrHE4M0ifCB8cE+e71qTsr2iS61/IJSA
Date:   Fri, 15 Jul 2022 08:43:41 +0000
Message-ID: <20220715084341.7x4edpwbu36srg7r@shindev>
References: <20220713121914.1878481-1-lizhijian@fujitsu.com>
In-Reply-To: <20220713121914.1878481-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8aeb5b2-58c9-4dad-56ed-08da663e1ef9
x-ms-traffictypediagnostic: BYAPR04MB5480:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLT898TRzhrXi6QSvwkFySe4nV4LwISIxYbbP+kDX5qfGPQ67XJUxT5CCWV2OAodz33K+fgmlJgac1toXqjzDtEaFaXMKN5huaEoEvCuQvdRlT+1kZMmbynSzKAQ7SkDN4RL0ZYiQphhPP0ym23qZ1/zcgRvgnWzFFG93rWuTFddtvFE6EHWpvRW/GPZscxaiSVhtkKjkzQE3peSXZTkbw/OvfYztVGBmKELfkGsWHREEEhWR2xqmrqUzpgrEAtLjqAnLA6WNgbPDjcXJvqx2yfyGXvhsKEV8Z77Ecalp0q0zmPs4YF8hDMQrDDNMRim7Q9+Ofqkxt4KWSQiK01Ec2eCKdRihicyaOKX2Px069xNblqeDRDJrKuzLSjk7gdg1r9o9S/jffu1YylsyfrSEAdQTA6AbYg9X5RBs3islCdMDkghOSihw/qgtYQjl/mJLe0LD573SKftxbTihh2iMCBHPt7VgfU4/NXiKR1XVgYznje4jyWeNOFcAoDrROStQ769hxLXkiptTqWiFLGhivKd/ZICxzoFWJSxMEa0PrcMUY3qcUIrVXbHFVg561ecopKhmT2x6MU+88BbGW5cIBvRtDz2et2grY5mhgTKijRcZq40olt3jH8tkouPe/fArBvb0F5pz+mKd9L+7+rkNt2VYio7wbramh/UDxP23J3DHWBZ7Aiv9eEzcZcDYbgpUWL5P5sk/y0BOW/1blZFv27xS5jOgu3/i2fQWgo68WpxaY4BkBICKGGx2Wsl3iEbbgLkeMyy+MeCUXBTYwyzlouhSnmUzU8sA3PxqmWsQTYsOaB0bORIWPNIfEI/sw0h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(9686003)(6512007)(26005)(6506007)(2906002)(186003)(41300700001)(44832011)(4744005)(71200400001)(5660300002)(478600001)(1076003)(6486002)(86362001)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(38100700002)(8936002)(82960400001)(122000001)(6916009)(54906003)(38070700005)(33716001)(316002)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tNlitwbQHX7v0mQXGaYuVLyOV5Mz40d6I1YhXenWFVJLf09eZ9LzPoMt3J+y?=
 =?us-ascii?Q?jK7lZecyUxtsRBQI2yKK2HRtu5IN55zF5Ul6Q/WCuxiGM3ZPfW2ENrJCFZ8K?=
 =?us-ascii?Q?q8lN38DtP8uk/OrnuVQkUYW2IsSO/tMCuDECkUscEG6CDP5LndWAtBjEDsiw?=
 =?us-ascii?Q?2XkTKMy+7MPKMeT8UaHzmO51FT5+jlH3oMGZTNDrOFzUDjBSjqmlUrnIiRTA?=
 =?us-ascii?Q?ndmfm+I4j7NrlM6x6aWwkZbKPdmfEwkwjey9aNL0xKAJd3bLxkaTD9w2fvJz?=
 =?us-ascii?Q?xIMgq/etCJo+tmtaDVBLMsvyBZeMnWegxkcKDPmg+nZkdhYiN4ObVTVvzvX1?=
 =?us-ascii?Q?gKzrjTz5rcCWsFLKbgwiURYtLjXuOw9VZHY46egWtmpvZgtxmWQEqF9CmWDM?=
 =?us-ascii?Q?QIRaMDuKWDBJZBULq+Zuokr6NfA4q4SGwNBd/36HrPGYZUVkoYo+1FE1+vUY?=
 =?us-ascii?Q?ZrVpWU4oL9MNjozCGOidekVYD3kYzeSkcZe/Pkkft3DysD6GeD1vHOX983O0?=
 =?us-ascii?Q?iGewoNVQ4TwGBll5rwXfUHL/mQ5f8AFitU89NC1OX1Aw3OL88tu1E6UYg37+?=
 =?us-ascii?Q?m3DHAs4cdokDv6qzlbTtTFe5RZcRxzvtvhhdu/Hrqla7354SMqqI4Fm7s/YP?=
 =?us-ascii?Q?rL5PzMiMPrcyq54ei6a1v/Mpxym2ixijJ1xxs5Y1yL8+C1ZUfjvm/V6iG0ub?=
 =?us-ascii?Q?pyCSxZmFp8opFKnpM8s2DIDFvwlEc5ZJL48R86QJBFZ7zmR67CE/pUtsmeie?=
 =?us-ascii?Q?NbfD9CFw8/9AbZf9ZGvfqrIuiQTN4F/BSBw5uic+MIhtmfO8sIgnwWB9SSW3?=
 =?us-ascii?Q?FG1fdUgARuvEpt1i0ex/pfkb1NqSX+B5q/EI3MkpyJDd65uMB0KCR2qyQ3qg?=
 =?us-ascii?Q?1PDuS1ApjZ4UP+ljjVhv5Gw8ovcBDoZWPKAP6njiz/CUBYH6Vscucaf8RqlS?=
 =?us-ascii?Q?eWFqK1yvHzVzb+asD3M0S6SCy1SIp3pPhMhd+VBnp2exUGE4PFJqEZ406LIp?=
 =?us-ascii?Q?r5Xj+DNqX79iTyDlrOzpLyRN+eWWacSbZJ2yylf6zKryl8PHfZMayev8TfYR?=
 =?us-ascii?Q?z4VY9bilX8HWMhOQA98CIu924jeHidwDozTd4e/XFTw63mldM5Pj5pbxRZsE?=
 =?us-ascii?Q?SDdeV6xoILF4ClHr3WpWSNR0B/Fe+oOTuG4iVWGMNvgnoN/oYHZ3N4ou7SOt?=
 =?us-ascii?Q?lOnZZWCPr4wzuCJPc2moU7edfnRd795TFM3oZweXXpo7eSE/i3cwglanK13G?=
 =?us-ascii?Q?L9iBPcF6/609BUGsGAXAPZjiVuSLNHb18f2PH5kkTTyIqg3mq8COl3ru9NVX?=
 =?us-ascii?Q?FKdFsktIWg7NF4sL4/PTdrwx5aJX6Vwko2NUg32X+Ky2NTQNgay69gG6WAcN?=
 =?us-ascii?Q?vPjEh5fRDubRyS2zJGU0nFdGaJ+opnIP+BSnBQ0T5cilUc99HrQreyRRrC3c?=
 =?us-ascii?Q?5rt+9CBLB43VMggtTxaz5X6SAGKoXQwGEnPEB5xZ7cdmHtJ2BF/Wtj1/9JHQ?=
 =?us-ascii?Q?v/t8MwynZNmsJ+/VR7FUcrkzHBWIu/zzJ4MitN2M8sGiPFlx3imEZAD7TiSJ?=
 =?us-ascii?Q?NdCOH9Ku3v1QeQEw9mFW2JzvmsvLFF9D2SPGers1OeWMrOEhVjvl4ytdz6AY?=
 =?us-ascii?Q?f0CRh/wEgAUaMjLCIRs0kOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6106DDC9B9DE34AA46C90B29335C63B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aeb5b2-58c9-4dad-56ed-08da663e1ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:43:41.9696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4nag8+uNMe2LdWHewXIwGjce8V0xVqkP1EvjpVVBtdZFxLYJVkrykEVkXgFLOxs3KrAhA/ZeBDJ2poA3RR5BYd3xbMOgo0P2xgyS0BJqVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5480
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 13, 2022 / 12:12, lizhijian@fujitsu.com wrote:
> Some test cases or test groups have rather large number of test
> run requirements and then they may have multiple skip reasons. However,
> blktests can report only single skip reason. To know all of the skip
> reasons, we need to repeat skip reason resolution and blktests run.
> This is a troublesome work.
>=20
> In this patch, we add skip reasons to SKIP_REASONS array, then all of
> the skip reasons will be printed by iterating SKIP_REASONS at one shot
> run.

[...]

> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied. Thanks!

--=20
Shin'ichiro Kawasaki=
