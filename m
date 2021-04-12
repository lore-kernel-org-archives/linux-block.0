Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A23C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048E661368
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 17:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhDLR6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:58:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14587 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243463AbhDLR6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 13:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618250281; x=1649786281;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GZ0ySlWmwkZAdGhlOXKNLOC2QYQuR7dclrtQBPXWVo4=;
  b=FmrOzOjWB30uCggT7l9Q0B5wVG0xa+7d8HD0JwpW0qNdCiJh8sTTi6w+
   7THDaMLrf//Vmkyyyvj8ukU5v8ziMmkOkWqqNpXbVi1YtuhJxoAKV38Va
   7wpaELwJGwj7kaKsNWDp7RLfIB/5JuoFaWOxKF8G3YMlc0Y+3vf/4GNJR
   vtPV5WfM9UMIJqic+0T/TBPUaGqI8kDfI6N0b9Bp4IP1IhzVPMLA6ud7Y
   BhkmoB406IcVL1SLqhGOw2pn41ec5IEZfKWZ8Zw2XBsS6p+gcRJoTxa4g
   SJ366dsaIOVbD5swGSt/9paKtIdGkvhn1tHfKKTnMXsttfSaSe97uMNmW
   A==;
IronPort-SDR: y8qFimIrZhrfenoVrXL/yOGfNP3FTxbfM1BkUMmwGVfhnXIEh1Nw+4J9W6yXW6NuNc4RFvWp9y
 e8NIyRmtHpdr/PBIDVcRHOxlgw2kwoQn8od0WhKy4kiN1k7mHREArIFSqiqwMIbkQXR6iKWsun
 s/NQZGqRFyNd8HbIEGqrI1ILBUINNrxRq6j3szpSr8C4+scyYbaDqh+qebUitXipKqJRt5RcIV
 /d7qYbiGba64d7wH1h6SpuEghTOnEc/5cOEHfG0fXCLYSAxV3Lesctl0gDzU+tOqKk/G82hRTY
 yFE=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="164161299"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2021 01:57:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTXJG/EIIb3VdWn30ypxmQ/Ax1i4P7/3TQf0X+yvaL5/wjgX831cRj2WtFXwu2vN5/sO6jsXdp91utSBqdKz2WL/Cpvdbhd+oKZSRo9tAVxu1WOSJzyL3PstnxA0OGjejSIK+gJUWnku+tN/ctV5+54S7bKLfEQ0qs9FxmuB4FVkoYLvg1aj1KFXCjqwuCQbVHJuUB0GTUWAMuQt6wWPitI2LZ18fDvc2WlDlYmMxzzIrmXrcWf4hBzuzwGmmcI0rw7mWXgbqdjX0OrYNf430sJ5ZYy+5EwrvkBhZpsUGzTpDBLu3P6J+OjJVFKarJuCOig/AeImSMBOYsQmjzVrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ0ySlWmwkZAdGhlOXKNLOC2QYQuR7dclrtQBPXWVo4=;
 b=HzINKkAewx2Kcd5cRrDeAEx7bYV+jLUnmYaRsvOY8B+PfckluyRsecrJ7m+MtHaEOpPz3ZTtcDBAlmG5B7EhTHe1LhlOSB2nkbOclO8oVE5bYP5A8PjVJDYoHzKsDpJWYENWzbimg05rYQ/golYwdczeSTrskdP2gLs55HqeeJtu2Ray2e3S/Db47Irq9G40lO6/rQQa3Lr2tgULyuKdPC2fFr2M1ujTendjy4mNoMpntt++D5JoGws39bWTDlDWo40ciqAxWUW4yAifcB50yQEQ0QLNDVOD9Rv5Y1KlpQ5EGrpw+KEb6vNnfglt+803Fw70r4Lwp66U3O2yq6psXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ0ySlWmwkZAdGhlOXKNLOC2QYQuR7dclrtQBPXWVo4=;
 b=TCi34IFY3lVkURYURBRas5s1G7wwtCGQHcWYpjJPVKLwsOabcLdzd3YDnhPlW/Ng4mBEL+1bmqwz5rM++tynVSZYgEsrTrTSpxGkT8b0S7wimFRNiTSX0OZ5NebYyfEVvhT4DK7nOG0n7BpmB7OQ5V21hgX8N6p4YEJKmHouthw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7567.namprd04.prod.outlook.com (2603:10b6:a03:32d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 17:57:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 17:57:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "oren@nvidia.com" <oren@nvidia.com>,
        "idanb@nvidia.com" <idanb@nvidia.com>,
        "yossike@nvidia.com" <yossike@nvidia.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/1] null_blk: add option for managing virtual boundary
Thread-Topic: [PATCH v2 1/1] null_blk: add option for managing virtual
 boundary
Thread-Index: AQHXL4IH//8VvIQ5WEWHcDMIIkRegg==
Date:   Mon, 12 Apr 2021 17:57:48 +0000
Message-ID: <BYAPR04MB4965C17CF4AA51BE9C5C5F7486709@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210412095523.278632-1-mgurtovoy@nvidia.com>
 <af599b5f-0e1f-99c8-8d59-73fc48227d9c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2447290-2167-4407-0a64-08d8fddc7bc7
x-ms-traffictypediagnostic: SJ0PR04MB7567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7567E46E3EE20CA0EE7FA82386709@SJ0PR04MB7567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSCs+YhZZXA3Z9TVbFOdzjuwaoE1qFfjk5ZKFZ5Tog3ISnngI0izvzR1GjpF2s8IwodoSaP+hVVeJxBmTz8uyy81qn3sMK/eOJDB6a6B66kMKVRnGA5Bb9kC1W2NJtwDmYE/TWosdS4Qsg1O7l4maWts8gH5+Otsuc0VjB+9t1GAElZaGRgKnAorNfioEfJUfoUIY6dYyXPaZxEgX65cWBWxnFVRjzHMFIbd7UgZKWzjeC1/qRjURzQIXZJwn0iAn7cDBO63hk+TVdJsELx9b3Y4uJk6GHdp7jDx+O0CGEwWXSf1yMX9PwwAEyzk39dCTbOIVOLc3jYPHU3LvrVX1Tkw0R04Id6xPVSl5h5QvI8ntzAy6IKnyyAOQvoMFkCgdISoAFZUFdo9RqI9dsDQ+p7YJmXYh5V4NbQQtctR6I03F0cehtiXnVS3HZ2mT4LG/HqY93od7YUzFUXhqq962sLCIvPQn3pZYYphfiwGIKG2gRtilb3pNHrYVwV8idP2J26dDjyrmbn/XwSrcoAtfV9aH56Vlb2TUWgM3v2nYfJXVTMt3Oqw8uovjjeLGF+2zPl/YnQeKGzK+9a8WAu8/jLtPmHHt8P81/SReMv5YNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(8676002)(54906003)(55016002)(186003)(478600001)(8936002)(53546011)(71200400001)(66946007)(76116006)(26005)(86362001)(52536014)(4326008)(316002)(7696005)(66476007)(64756008)(83380400001)(66446008)(6506007)(66556008)(6916009)(38100700002)(2906002)(5660300002)(33656002)(4744005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yoiKdqYhEQo1FegwsQ14wZbAWX8So/F7w1G0orC9awKOe0rT9Bk6kZ7DhN6O?=
 =?us-ascii?Q?mb9qKbIx7d44+e2IF4Z887iD6dNR7+W/W/HtCAP2KyIqUiUdXWkDaU0i8og2?=
 =?us-ascii?Q?sJ/Tjpiap8soTmwcnOYeQ/o09ZU2b8YqCZ5LkRNm3zGeKXNzJ4Y2Qo1LXob9?=
 =?us-ascii?Q?s+CHRCdtXUyaugZ5qaa0yZXjZRgmEmDTpXdm3zUIzVZZW8Zx+Hh+S8I6zNb3?=
 =?us-ascii?Q?Xwdh6lgLMufIiFNVb06d/K8SNcg6alJRrwQ69h77QshV8jdpKM6D6xHZd/i2?=
 =?us-ascii?Q?SaPpIreQyrUBdW6Dougld8zway2dLywvlVdYRmt8HVfHCwMZAZ0mXGDtZ1Dd?=
 =?us-ascii?Q?TiTyiWtq2W3imc5v4Z7AzR2a0mttulubydakgsoGK3K5joAeAkbWMFwodGSR?=
 =?us-ascii?Q?1/kh5p/lxfj1wVW0Jwqm1IcwL3ctFaCN0dAjRTiMDPGDqbtySSQvoaX2iE4J?=
 =?us-ascii?Q?/hyvVKz2wrOGI8sv0dNpiGJzL71Ip/UB/N7s3nRTQY7uVd3+ByQ36inr8gpK?=
 =?us-ascii?Q?TslUjcGkaU3btqyjpFD8A34BkVQGnKFH/oHlHO/1F0m6QqVM95I1+bwCnbiP?=
 =?us-ascii?Q?oRLufbOJJMMQtoE/+aY9JTDzio7UeMMjYkgYahUv1UgcibWRgDV4ZgsB4prq?=
 =?us-ascii?Q?EFpXDnaaSt0Ju6pIt8zX6sJgNxutoO8oSZnHANZ/VWfvF2QcWJJ71s6hY58d?=
 =?us-ascii?Q?6AW8GE3QU3eiAxwmwoBSGjqyUiOGObulXwh8PgErG7cvqihg2oSg9kPz69my?=
 =?us-ascii?Q?HLccXM4zgjCIEOVfd4bcr4C72ByUyULLR4p821iLPSjv298/jYy74oZJ0r1z?=
 =?us-ascii?Q?+mEt6k6OvX3T7E3vMAOE+C1HDtCXHHgGe8HDZ7mynRG69NldeRs5GzYeAvX5?=
 =?us-ascii?Q?c4K7qfcxeBQyfB+hcjXkIWBCo3zLRX0qGDlNs+f8K/GW9SfborFrUcSSbp9M?=
 =?us-ascii?Q?h7djBJKM9O6f8JYFSMhHGFmhn6QXnryxWz8sIOhAEBBdxOIuJ0mxWyhj/lW5?=
 =?us-ascii?Q?rMIWkghqdBPtXvrEzf8o0OSp9nkQVh2t+tS7XYWlZX1NqEPVHPTj3XqhyOnr?=
 =?us-ascii?Q?p3iCMo0I2qEPb0DYKxLJMJFglRh3lc8bx5QQsHaU44kq7OIy2bkycjesO3EO?=
 =?us-ascii?Q?WamPRBPmEjCTCaTP2ngbwXT/r1Ed4/LXLctJGDMXZMDFrave2gOGgLuK+1sm?=
 =?us-ascii?Q?craE5WLBoT0AXcY9dsEhgY0T+80VOHb/Jw+YEX37YgcIgxeDgrPIXsDMq0a5?=
 =?us-ascii?Q?RNs4F6GehVFKUoBVRnLhiMTdZfzIf+ofHR0XqoGpDpB+ysR+wNJG+DneCBcC?=
 =?us-ascii?Q?cGJdA0uD6iZuct0SHzS+AGgs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2447290-2167-4407-0a64-08d8fddc7bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 17:57:48.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOyR759NhTqrk060/OoojrcaqFw9mVEDTyXbVI7V3bzdPk97GiyjG7PaOfHlUG76yrxmMFSldl/vKmdBP5DS47EfpjcHWsDEy7eZEiyNQPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7567
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
On 4/12/21 05:48, Jens Axboe wrote:=0A=
> On 4/12/21 3:55 AM, Max Gurtovoy wrote:=0A=
>> This will enable changing the virtual boundary of null blk devices. For=
=0A=
>> now, null blk devices didn't have any restriction on the scatter/gather=
=0A=
>> elements received from the block layer. Add a module parameter and a=0A=
>> configfs option that will control the virtual boundary. This will=0A=
>> enable testing the efficiency of the block layer bounce buffer in case=
=0A=
>> a suitable application will send discontiguous IO to the given device.=
=0A=
> Applied, thanks.=0A=
>=0A=
=0A=
If this is still on the top and can be done easily please add.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
