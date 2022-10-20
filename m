Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45E7C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 11:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiJTLup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 07:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiJTLum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 07:50:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD91A50F7
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 04:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666266639; x=1697802639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QfHT72NoXdpKPqlcXITyeoiZNh2Jxma0LTA/YTL7QI8=;
  b=mQ3vJZJGLpbsX44kuEzICopQWAGvC09KocCiRT/AoejrNCxJ6bCyfeJC
   QASwkDQmWnDzmUx5s4JlKMZgoMwTvECJjkBgiZRc++7zUaqIP5ltbWiwd
   vqrnTIDEWxSYWxiR5NKn4szIaKWFVa+Ei3mMO2HRUJo0juv5i6TMqPHhe
   pur5pYAbcmpCLg4BydrCtXY9t+y/1KXiLYQLiUaoIlQ8rLkH06TDFbMBS
   E/FMegignzWL+LWJ8Xf80qIguXewjqvSXd+pJY9dex5V/qMrSny+R/WTQ
   DKglZPB9RfGCUiToE/ntYTmrC2jtLqCgZOYjj4jT8bsqNOEuAgAvUIXl4
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="318643991"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 19:50:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoqgTY+KtuzKHASQw28MoEG7VvsUEB4SSp44e9ev11P3NX678U+JL5a+vOvx3xsshZUUJmPEm+UNE6AuckInLiVyRk060tgGp6awpwTfgJG31DWkshYGz9+FadJLbsZ/bLzpEmjOW6jbp04KkFEi+uzcjW7DldMXUoKYjEe0QKnPxaMXu8R+5XZw2NiI4xB9+DICGP8/0oWTA4HtpOhrsNcEntJYNZcST6uQypR2I1WZf6Bpc6MqvglLXoGGWU07ChCyhj547GCcWsCqxvmMAzxQK7N4t3U37eyGqzquZFN4Jif0H3Jo9itPbxCGjCFmOv8BdyJnLNPEPyLd5UKt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfHT72NoXdpKPqlcXITyeoiZNh2Jxma0LTA/YTL7QI8=;
 b=WHHg3dTCQndS7J7jonx81Jr49CjDPKED9GKIt3Mtz1q8kILk0pycA3oeLXFd08t2U2mHro3QhRHjiwgwaZF94vPkaCc3FzTUt1EiIjDElXNg6ll+LSM8LzcdqMESsQ9hd9nXQlTXMh+pYNyAAD53VtUyskZddMmRBUS+PlD5dfrNa+uNLLZ9mxyVnaXQco7OtMixozmY7lZRNpO9Gw6N8EPDv7y7XrsWFPRDN4KBKi2/d6ClgAQ3nBFC79TbYRBfuJUd70PChTTSiTi4wYdqklC57P5tivO6ll0p1Wx03iqDBG2qB7Wr9/Xu6n81q4Ak/hY58aq6PTuwOowp9X3PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfHT72NoXdpKPqlcXITyeoiZNh2Jxma0LTA/YTL7QI8=;
 b=OjEgcT6gNUGSrg3wXGo8b+3Z20m7MEoIVPalae6uJtTLs9Ksqv+j4k4BxeUoo8l266QkdeufSGUOW+mkJfsEfz5kQLrVxdZmuHWtk1uDjFXNKTT9u7bDzNvELHg7JsRFTXF4N++3fxD77F93QFqSSct2+lMKtQOLfHf0TQHp9v0=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by PH0PR04MB7398.namprd04.prod.outlook.com (2603:10b6:510:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 11:50:34 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::6b00:5ef5:d216:6837]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::6b00:5ef5:d216:6837%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 11:50:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V2 blktests] tests/nvme: set hostnqn after hostid uuidgen
Thread-Topic: [PATCH V2 blktests] tests/nvme: set hostnqn after hostid uuidgen
Thread-Index: AQHY4vQhYXyyZCa5UUqaKlnowKLtIa4XLmgA
Date:   Thu, 20 Oct 2022 11:50:33 +0000
Message-ID: <20221020115032.fbi4bntw3d4nl4te@shindev>
References: <20221018131758.763311-1-yi.zhang@redhat.com>
In-Reply-To: <20221018131758.763311-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|PH0PR04MB7398:EE_
x-ms-office365-filtering-correlation-id: b0bb624c-cb8f-4fd3-448d-08dab2914c08
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wpA1igAXRdvq4jAITm8FQPltFgNUIBm8EQ9QS6jih70CXL76EFV6Etqibm/dhNeEZhUYc5XQvk63cTlvmeivVdjZb3VAJsVFWKI2S7zA8NkgGvI5QqB1hUFD6LEeuhMx1SOQgoxn6quFzhk5l2i5fMWNOJ57zepjcjOlbiDCbkuifcPZ+b7nEa0r79wJhAZbbfFmvOOarPi52gtGqpXTsLAWxnfBxaQPI8Wmo2UWWbY6RQkm7doUSHxODu4mFB1efHmILgkBY5zeIknB7Ai0pP4HTERUL3WWK5f5uvrd8JPsDb+dAnfztyM+6V75+E1vu7rXnGGsuOXGnWGq6z9t76szfiBcuJFZEe8J4vIQy/SmSbvZZLfNYyzoWJZI12CUKO2UYBAEpzh+b/AJePM/ymmL4fBYrbkIDp1R5gPsPVZrbd/R335icNsCHwLn6kHpJbXdtivQvyf9x/8ZSZWkmiBpHXkjFMWwpTAPTsYNFymzlgr9RXXzw+HIFt7hxBizJtiq+OQfdDpqWIdOyqpD5SRHRLJlKzlFZhnNx8QuQuYizo2+7pzJIqjHKcSLCG1+wNSOAJFjgFod4quCM7lOtIuAzTg30+3GbLSLwZTo4B7fvXHf+/x4NnnLXt9VSsXcvyonBrjpyGqBxdLGqQOfhVPw43TV9YoQjf4bfniA1mR95U5qS658i8D+ahYz2VGfel3iSEejot/j1FWunU+GlGFyFCGyXO05d/bOCwJckynzplHkBDXD2IKgtRcyvsNRUT3RnrNyRWi400WtChLVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(186003)(9686003)(6512007)(1076003)(2906002)(6506007)(5660300002)(26005)(44832011)(64756008)(54906003)(41300700001)(33716001)(316002)(478600001)(8936002)(8676002)(91956017)(66446008)(71200400001)(6916009)(66556008)(4326008)(66946007)(76116006)(66476007)(6486002)(558084003)(86362001)(122000001)(38070700005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZZh+c78kbsJ4MC/exh5nZBgW5L9cqSWMZLn+d7Elurufan7NAxlwDLwxsLqc?=
 =?us-ascii?Q?XmX3jWpS3I5wIjdnRA40NCSouWZQNoCnn5S+1PGkQ9CiFOZaaHhA/9XWEEFC?=
 =?us-ascii?Q?lLgNXRR2gDCb0b7OWBrgCVT1Jo88cdXgA1WlBDiQvWjzU/hgQYEktkhjFXEz?=
 =?us-ascii?Q?CuboB7ZNvINJf/AWkqPTZiD0HFUmWpvGsaatdZItkr3iORLr0b+2ulLnJfrR?=
 =?us-ascii?Q?gFLyO1kQ9DpE1xI2xsE87XkDqOobtiJ2LCm+/wY9hNA0zu/d563uGa1UHiHD?=
 =?us-ascii?Q?I9on7G2EWbHewV1Awb4DTzJJ6cbA9psnktQEShMkJk2IITGxZanpnF1DOQTp?=
 =?us-ascii?Q?XJv5mVkCBB0SFpkC6fSUJuo8YCKazXRnhw7/RzIo5NtiosSFOKuywkC59hBe?=
 =?us-ascii?Q?SvT3uJqnfudPKjeAh05nb6lvcTu8Arc5aFZL8d94nxiyhcyVypFnCToDlo/0?=
 =?us-ascii?Q?akADHr8NH0o5ORgQdVYdid9ex02ILe53bM7Awnp1/RESjsAA6PJVi5tZ99kG?=
 =?us-ascii?Q?OOOoNmA3DlRbZ84c22mPvDCII7gzkYN8u4u/1y5hEIQzD7cbg9WDXEF16fMd?=
 =?us-ascii?Q?W1Gvg+FpNy+RC+2CjIHjwv6DN5zVCcq7/waspi/ly4zxFlxHQaMPMRWj7c6R?=
 =?us-ascii?Q?4GMz7JndTeFuQecYJ7wENoI5ejAtWm60RAdTa5eB+62kTOpaRAN1ww1WyD/l?=
 =?us-ascii?Q?7AUHVSoT5OrmTRK3brgaKJ1jkTmppPrEeszEooL9ouansPr4cumEbrWGqc4S?=
 =?us-ascii?Q?0vO2pzuUmyBh+DsNiEqW0BW5R05HPNyZmugs0Y6J+4vpVHMxkEOWPzTN/GxK?=
 =?us-ascii?Q?pZbQbDAPNiUPU0Z1tDHsYX8mF60Zj9FxrHzskj75bd9bTeRglMCBF0ab99Nv?=
 =?us-ascii?Q?FkJA0j9Iy8k/96JZlBVKRXW5jZDhKwe34hu2N3KJDBVXDuSqVVDZbXFinxcL?=
 =?us-ascii?Q?tJQgQy2osLWjm9cmN4KPZtgW4YnUrILyiW5Cp+ZPLZlfuYyFg5ZQvNYFUirZ?=
 =?us-ascii?Q?a1n00NrP/R/cKwnR3TwS/w1E2ZAHByPC1aCwYhtopT4HCYNHiu9OmNw7Si0l?=
 =?us-ascii?Q?l3v0GxLHz7CGuIywk+tLAHYBW7AKoENgLIM8xZKf8iK/grmFXYRmMrFSYaZN?=
 =?us-ascii?Q?jERO0iXuJzNlclvfo8bCkkEpSZyT7nSIz02aU7LLGZPE4oYoJ9cZbRVxGGC+?=
 =?us-ascii?Q?07g47GypTsf72kC4WPFz6e127lUVyfG4F4ZwMpamyujPlZd3/zPptNlWoYKv?=
 =?us-ascii?Q?aI3dmXL5CgO0M074axjKJ34nWfYyreUYY19UwnHaR4b49iCw2K78Z1RqB7z+?=
 =?us-ascii?Q?kFiUjDbmw9DBlKd5FVlddPYrCCzoNRM5cNTfOFuCWjZAXeH1xmKTVWz3QoWy?=
 =?us-ascii?Q?ReAWOihhUPT6zrPddDaDV98KLjviM1IiRsQ1nZKWNn0t7s61EuBjxpylhELv?=
 =?us-ascii?Q?yTgdLvtIigL6nK9KbjwZEAt6Bge+K2UVrwgJ2cvflMPoxov5fi1a85eqhevp?=
 =?us-ascii?Q?9AHY9edwU5arQUJytGoebObZH9ZD2CZ1Q7PA/HRe0p0IenvJylQN6qEprPKK?=
 =?us-ascii?Q?c9MYsCnGjQTpdOc4nmG870LbI3PeGQRnNCYOD301bbqyPeq3avNxlWytodh/?=
 =?us-ascii?Q?au+1OaD8TmG08BDMR0p0MSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60CEAE3E3790E0419CC44851AC1A0EA1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bb624c-cb8f-4fd3-448d-08dab2914c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 11:50:34.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrVOKdp8i7ZdoVr0e8nRUbYlKxVFntssuf52HAaRGE/plr1PT0Ewkqy+HZpTcjuYB871dtvgKHmInNIVHbjDXMnNivXrrMX0YwUGk5iRaFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7398
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 18, 2022 / 21:17, Yi Zhang wrote:
> hostid will not be appended to hostnqn as it was generated after set
> hostnqn, so let's set hostnqn after hostid generated.
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks, applied.

--=20
Shin'ichiro Kawasaki=
