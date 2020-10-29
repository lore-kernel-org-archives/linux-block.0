Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5EEC4363A
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 162D2206D4
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 14:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fVghpPKW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gyQlTXfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgJ2Oyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:54:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32857 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJ2Oyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 10:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603983275; x=1635519275;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=fVghpPKW4KVNELWH2sGD8VfDa7/z/p8Y59RLGxth7aI6ewBuUZVvow5a
   EtdHCtt4Y7LE3bofBuTHyNvlVcbTFquRE2f9GocJyG6DEAY0Bl2HIuctN
   Vm9tI6LmivCAPZm0p4ZEdRsZGgsCqZJX4cWwmzrhtREkZo/l69Mr27Hr5
   Wfe1WF32yqg6ibU6F/SUvoLGG2do5O0bUuxy6HoMQrGWnfDTogD3uBrM0
   rD+eBcQhhYjoVYkxoKrwVJTBkTobU6j58/A04NmxuwghIcwf4v0pboccv
   uigNtZJH+TgJzi/p9fxr2mrpbwzX1gSUnTHOrAcTBYR1iI6j6iLdsWfC7
   A==;
IronPort-SDR: 4608z83Rrtcs9VfKoYI4lmcUy2+agbntYIVh79Nfl1Bimg4JjRFXcIK4ev7VUCKBJYjb+J853r
 l6E3BQ3rtmRNi8NnPLJmGFXu5mIkChiQF/gUSV1/w5N+qOI7KE9SFgANlt6VEUrId0Ks4r46xZ
 YwcRzL0Q+r2IgJjJAXjy7vJ9JrtqwadkyEJjkKe4AfCCoLxmTnKr+atreLwSOdBzeAY8l7CBpY
 srhpTCd5Dcp3KgBBA4jMHFQQMSH6O3U+PBtKWwLxdQsVJ7KBI3Im0nKk8kqB4eBPOMNHiAepgL
 wHw=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; 
   d="scan'208";a="155681138"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:54:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuo0m7/fMCeigZLryeR5jp7UrXwchj9IGBpkhuX3kJU+M59XWp3hY8IMDI6C2TDRGB8WQsTkvyKXy+erNiCD1RxbI2Du9x7EQ9eohR9fBTukF75Y23zr8IITVKGvLvcFX5fVybpbd8f0AtT4reUqin/2/O0hNThc7Gkv3ICMnFIVb3NuJrpZAxnIi9ZJ23GIPg1Q+4Ov9oDD7kNLEzdmPN7sx0tyKgugQ7t7rtQQIirilz/rPUz9PCMCmafXLlXwAt8A2Ivz5qUa8RP21MtPo8WjE086sLJ/H1r+BocSWrorKOPGfDVtVB2qTliKax3Hl4zJsimEMO4BVEsWGfBkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=efNZ/f6Nb9XVP4uZDGi2H9dkXOKb3W4b6r9HkJCqus/TZ0BgYcBh+aYTDkCbKc9GdoJ9FDEr0Rw6FVGmIlmylKSFY/coongiCJ3p6JcClQ1eVBW1OC+0TIghL8KjxV6OOkVTMsEcu6/LoUMsP3qsm9CIBKhumhbvR7xzHdLLeX/xMjY4HCYK9LIUb4VuQ++yNXxfh3UhhqyugFvpBIeL9Uz04rgsYsDl188U59Q4YdlAjIA5ujbIp9bHJjVvR9iLw5BD1RkQLwmvRRo5Ck0kJOcdlthzURqDZOkngxcg73gOWDXC44vbi8ATW4I/YxeIpDUICgVOq9S/u30kDsobaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gyQlTXfpXEVGlf6cN6aUisYqs61DV0QE8sbPklfAOWvHutKDbPczhszyvpAbBjyuzRg2J/A0t5eqbCuVY/iGRvsuleu77XJgO6dBy2kAIqJrESc146VURyAU2pQDP/qO8GJOSjJinn05y3a5gIFEmOYRoPEPK5IRFFoqOhs9XtI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7212.namprd04.prod.outlook.com
 (2603:10b6:806:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Thu, 29 Oct
 2020 14:54:34 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 14:54:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Disseldorp <ddiss@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH] lib/scatterlist: use consistent sg_copy_buffer() return
 type
Thread-Topic: [PATCH] lib/scatterlist: use consistent sg_copy_buffer() return
 type
Thread-Index: AQHWq9uAhTJm3cj+F0KkRV/VuhEpNw==
Date:   Thu, 29 Oct 2020 14:54:34 +0000
Message-ID: <SN4PR0401MB3598DB71DB42116885140B059B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201026210310.30169-1-ddiss@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60fcbc05-9e47-4176-1815-08d87c1a8c92
x-ms-traffictypediagnostic: SA0PR04MB7212:
x-microsoft-antispam-prvs: <SA0PR04MB7212AEE54101D91BAEC0F7AB9B140@SA0PR04MB7212.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezEh6X7oXtgIzxBd5F4qbG2icXv1baIQDPcqklZIGkehn8nTSKwRE/LDCadGdlE4AtJaBa11tfMxmzTU632jZfb5bmCFIf98ESJ934MzoBTiHVXXd4wuTV+UTsaHBM9Ku7uZFJNOZQ1VS8D/cLQ6bA6086Swdz6yY++7IkV5Lh8z9mdF4qeX82MWKyVHIa+Yus3/L2+uKuvo9zs/wbUKZJ0Ihu05sq9GWSGJj/g+7kEY008Ho2KrJxNq9wrpio+M9k4KhR+IJQ4HpVlmnAfaDDeFTKSpJIDW3Iretua72XsAxKACjBsJDW/+lm00duUFdlcOj5B60HFdeiv5on7vlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(478600001)(55016002)(9686003)(86362001)(8936002)(4326008)(316002)(110136005)(54906003)(8676002)(4270600006)(71200400001)(2906002)(26005)(6506007)(186003)(558084003)(19618925003)(66946007)(66476007)(64756008)(76116006)(66556008)(66446008)(91956017)(33656002)(52536014)(5660300002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kNutu3apmqhH2vFN66VCon2s+XODpgBjppjSeNl+J+wpxLxFftrmzOWVLAgPEHtoGkF/y0X8WdlUZvVqwXfvcVnhyU/uSsx54jjxhq8bptQ436CmoWL18cn9e49T/WkptbhHHrQIiYxx/k8CA0fkciFtKUXVTjx8fIrOTPSo0b1edSNEhFUb4IvAUu/dKEq4HIJ081OfGvW73zEgVfyq+a3rHm+NUi+jWymkRHbAeDIEMSrz82dDgIIq5ifANFfcnlM501zJiycXId8WP5sqKz3lNugyLycpSgyZtlezAf1hJCfrg0lMJiGgndVTJFYx/Ck/2FHAmN/gkiisQJkYAjaCzE42nw9KcVjq+wL5QxBUgW89zafnDDLF739O2Xq83LA+ZggGa6ga3fd+2w3jiXyBjzf96r2BBzWqjs4AJumDQVQ7sxjezMuzXHmR+D1qNw40PoRnfE11uDAy54F+IZPu5ko05z2LU9xE+Ac3t02Df3X9CFvHPXU9rWG0rMT9uQjbIwCGTrpugUiToxE779mgBgPL7j1V/nkC55VFR0dTwLKaHQAW0oECnn7mUPmP6AXC9XP2IsCcdMIK2r+3aURtv2JJQHEXshQBFcETYrJNDZY0gdfGDMI9KiPrJVW4OpkMzkvJOmxg0mDMb6GngQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fcbc05-9e47-4176-1815-08d87c1a8c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 14:54:34.1324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rr6PwH5tI/VtI5BNik/HIuWnzdgiXYHQYm/EyEHJi5cy5dHRNEoWPfIKyYuVa3jdJVbqI10m1Q2sMSAzPDQdZIptjCx81GAhXj/2gbxIi40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7212
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
