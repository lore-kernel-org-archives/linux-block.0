Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C46C433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6514619C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhC3Xup (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:50:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32261 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhC3Xui (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617148237; x=1648684237;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eeEWrUE10/vg3pNrDVaa78Rcm6wgFzWOWkH43o0x/pk=;
  b=JooVloD1uSDV0jUfGWL9zn858MYM1EAK4EZktNcEfUhPpCIRb5Kqplka
   A/LaGS2S/wLIcZ6l5QAT6quYtzybxq7DuVDpMrjRc5LbKS9xkc5PP56zb
   Fw/Ys3/COQjXIbJfbRWTgQvSiVw25kJXW26q4nHTY7hQQH+NIOW+k85yg
   /e/3FhDeVIQ/EBZqK1f3wgo+xrLVtw3mOexnMUqf7eKLIguPG7mw0U4hR
   PhMOgfFAl3PxqzMW+33agM6iomItHDIrw2UrMx16EFuSYsK2Pp2Knye5w
   Wx1Ow60DKQAdemjWpKVFtB9f85da8ZFJCDp2YKR6X/Ty8a9oAJS+fViD7
   g==;
IronPort-SDR: xNbUsUYg19sTLKoR6g+1WZJ3mAyWIgpw7Mc0AnvAComDvJ9dLgWIyNl2LptFldanSJdbxqxBW2
 s8zcNZJl6wBalUMCvy6YJ3Suuk55BRoC457JLxO1tDAjpVgUYi3QGQDzErE41x43GzetrML8yy
 SKP+3m6RtaKQuwDOaHmtT/c96m5+Mgt4Puyf0xNERAAZB5gb+MRMufL3UwXsiJOWZnfsbYY5fI
 /3qQsiqcW/c5ZpK5mwd7XkpAaQR1wafMnhqwamBiJwLPMEJlSSy47XTv9OblQZP8yg6VExopER
 rg0=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="163387551"
Received: from mail-mw2nam08lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:50:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG5yr0o7TqbXoS+wRrOQt27+ZpXrbQ/4KGnYzYsglYaRKUtxy1LZXL0m4BBxthhUOduqyCrtwmPPrttlHN2csDW99ErJCyV46Tpp+jHx8QK2QjjiSkXqL0WlXamRvJ64gDl4HZAJnNfyok9ODtnHR0gKqqE72o/07Vi1zejMTtcRXvKUzDBq8LlyayMsdw3YWxx+/AvIqWCxKxeTDPyVxwfRTcJBWjNoekTXc71nxgemr+GmGiw1y5bc/z8YWbv66d+ZkPY2ba9Mtj0t5GtV/6xWogrM9UzW1Ps3+PW+uRlzNBnU02wyMHuzFS05eiByB62hKOmXOFx6LApPiwiKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeEWrUE10/vg3pNrDVaa78Rcm6wgFzWOWkH43o0x/pk=;
 b=e7e9qeF5oq2MCbk+yK+2BF5cR2n4ZDO4wcwII85RwlAoEfrbWV2K2F5ulA3SRLp26mAEeJJ1b8TIjQFtQg1qTHoTOKzs8Bb4kAHTHY6xS8T6Y6ugGRYLamspM1j1tjyvNjpGHkKYZ8I1SznXFHksJSZ5v63sFqymGp2N6oNV+RshkYB6Kl8A8wa+DqKaNnvBnr3UzpiDBESxmcZpbye2+DfSqGvsZqteHUGJU9md7NmnKS+SgxKXM6vJqYA/lm/mmNrYfezRedHTEQYVvrIkHL2SnB2EyrSohAlkQhk45Gg6EHgAdfX9AAuMjYcWalXSpyLYAdZiDfRyPMMMpL8NwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeEWrUE10/vg3pNrDVaa78Rcm6wgFzWOWkH43o0x/pk=;
 b=I483vSqz3rviUUPdFaY0tmtFUCxpYUSN3py44uEbgokN+FNG035013DoTZEoKLzYQMiG+Y0N8PAIsQoD8SgC6Un/jse4bNa35wD5sve6nf4YW7Sd1OAeagxmHc+QD5nj/JAaDNb5jpAlknoZ+Or4CaxJZjO4c7z4QQyOh8VAeXo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB5029.namprd04.prod.outlook.com (52.135.234.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Tue, 30 Mar 2021 23:50:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:50:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCHv2 for-next 08/24] block/rnbd-clt: Remove some arguments
 from insert_dev_if_not_exists_devpath
Thread-Topic: [PATCHv2 for-next 08/24] block/rnbd-clt: Remove some arguments
 from insert_dev_if_not_exists_devpath
Thread-Index: AQHXJTfUSCAnWpcASUORzplM5yfOLQ==
Date:   Tue, 30 Mar 2021 23:50:36 +0000
Message-ID: <BYAPR04MB4965E5FFE83684A5B0FBC7DF867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-9-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f74baeaf-af27-4efd-0119-08d8f3d69d63
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB50295DCF5B3B8890C95C342A867D9@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkds2HBEWaT399y02QT50fMoLEmNsQCLFEY2xhkcXMNWbd7diyz8HndVGkHu6Lt+V0GmAGH/xbCMJIxtv8H9fthNhrS0aacvfX5w9dH7PppzJlElrQR35rG+w01hOBfvvVPSO3EfrISX/IITE21AXSdVtGWpMmxhopE/5AExVydjVJQuxhU8EARAALdnUF86dwQ/C5gx163xyRBC1C3n1DBMmLNLgl1hxTlsgvJ5YDUzh2nUVE8muScE0/IswtUsedZp2Ug+MT8g1zGrZUCO+4rLhX6Uewcv5crsnCyu1WjAUffm2kIeFHhoPownJ0ZZZKWbbtI7Hxkflky4WaX7My/aj9UToaM+uq+BpRNVrLVKirmDFyToR4DWoMYzVfKOpkBW6/ejcYhwn9Swe8wt1AlRgWuOPB++2MIn5xI4KtkaPqjXJV3PdX7i1zhjpmqAY+1RKYXUQo3xQrqJRFKFQNBzOTFCRi9u19YCbaB9taQUVCeLDMCl+r0Jxg6csS4c9lUp/UzMqMuSwAAr1edcuoefQso7fBAsG5hPR3GQCgfp4N5Dzlkb4F0sN9RiYD2aBpnp2D+76LoQpEowQHuaELySX7cPsIbBDM6fa2QVmkIZcvStDUmaP2T0iPjNFZKxhM93B84LJi7TR8GgHML9+++rw71rR0oC1Q+Bwn0HPp4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(316002)(55016002)(64756008)(71200400001)(8676002)(54906003)(9686003)(110136005)(478600001)(91956017)(7416002)(76116006)(86362001)(8936002)(38100700001)(66556008)(26005)(5660300002)(6506007)(53546011)(33656002)(7696005)(52536014)(186003)(2906002)(4326008)(66446008)(558084003)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OaAiOLBmUgjjGwGMkrEPF8CBHKj4C9mcQtg8qtSrQPhn+XPJL+PVA2t+D7W7?=
 =?us-ascii?Q?4d9PjqyH9heeK1HnU+D0Gaoqi/1pzHv6l5JKFuE74332cd3irUR7D1+gEU7T?=
 =?us-ascii?Q?yC0Qf+oa1LVe5HapqBIUMX7CrK9LUwukpzVuqN/KST0A2cCqBvfag436E55B?=
 =?us-ascii?Q?dPzyvimcOwCJe3V7CJcEMDJWDwoaf3wLQK7VicitJhTgIqFx/dF53euc/NLE?=
 =?us-ascii?Q?S0FItTRzPYKONf3QJCAi0I5qKSlJlxzmmU2SnQlPUrz1rnswkMFB36EBitKS?=
 =?us-ascii?Q?J/0HhmP3P08ys8NJVV6VH7VE4fBgxru/7IUgT+TUu0UQmOhPymjXnYA46fOw?=
 =?us-ascii?Q?1PATdvPfgZ5rGoF/sqKEqTlU7yoIK9DzEKIcXZWWuOBzUy+K8SO6dGOkALz+?=
 =?us-ascii?Q?fBj0cm+CMjYJB3Xp9zY15n+XzZSP785GZp4U1AsiOvOJPgpKMrzA/yIx5PP3?=
 =?us-ascii?Q?SXCzm/atvfmBaWI0bTIykaC8OFSRJYcxgbtvCA34s2jbN+MWYR5EeB3SBUrm?=
 =?us-ascii?Q?aKUttvSwLz84SFUL5qUcNNgM+jS77Ng6P1pbYf3GdWn/MXz4c3L6hLB+j1rJ?=
 =?us-ascii?Q?QpKNoSWxpESuChdQEm+yFGFO+H3VmO8RHfid7lyT1ZEpQD9fLxKLMrL+Z62Q?=
 =?us-ascii?Q?rZVeIJtbJ9gG5vdxZtsp+p1g4Qcv/hO21DSjMtSJffrRK7BU7YnkGLxAb9R8?=
 =?us-ascii?Q?DsTpjZ50tiMTIjqoPiO3LY/6QmkvzWugXeXDo2nFoJqhgD9EPLmf8BNT0b/k?=
 =?us-ascii?Q?HknTCIrAzZZtk7Wck33PBAUYhh+fKCbowcdianAMS3s6+WMuiZQg2j+S/vXX?=
 =?us-ascii?Q?3F1IUXuM6pKQncM0h2M1HfaMxQ1PKITqnoEMt7p0TUI+MN3sZhIsf3xBc3WM?=
 =?us-ascii?Q?rowip6KgBjHCU/r8Gxw5Fzngt4o1eNQrNfEE/OGCF+YU1rkvUAAUNl1p+LO3?=
 =?us-ascii?Q?G5/8+aXE4slABrijhGPNsncR8mg3qBtYjOm12bwH/aHPfmn+Hjdhbmr3qxbf?=
 =?us-ascii?Q?xwuPZuPvdjwprOOU6+oLjxvelxieCepQ1Q1wunY1MqNMQcvZ1dvuL1WU9qa9?=
 =?us-ascii?Q?nMttC/QII44eWG33fch7kDmv4X93yfwal0wTJKSGI05vPSCpoCz/3fcdKgiR?=
 =?us-ascii?Q?xWi8vbvpLyGQfvfmVTZgRMXtY4DtYZky837uTN80f45RK+Kr9VB9PbqnG5/c?=
 =?us-ascii?Q?CZ+KgwJhMxxXjs++SbcJ8XBeutW93N8qSwET6ElxbvxXMAuTKvxImD67zuQ9?=
 =?us-ascii?Q?q6D2YWQOIEhzfn5t0AlmdYnP39qSITws9VsLyGd5jYH61pboT4MuhXYz41au?=
 =?us-ascii?Q?0mzuXJxpmxICQt+f4mUZJrfe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74baeaf-af27-4efd-0119-08d8f3d69d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:50:36.1017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hz66HVtgDOd9LA6liqfVaAbCGhHeXuubFAMYHJMwGy3csSolI1HG0jGELZcXesOMfoBzXBps11RzitM9uaKJtKmybjlY6rhqKu2L+jkL/zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:39, Gioh Kim wrote:=0A=
> From: Guoqing Jiang <guoqing.jiang@gmx.com>=0A=
>=0A=
> Remove 'pathname' and 'sess' since we can dereference it from 'dev'.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>=0A=
> Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
