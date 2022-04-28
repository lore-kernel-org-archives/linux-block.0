Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70828C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 06:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiD1Gal (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Apr 2022 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiD1Gaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Apr 2022 02:30:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0A79A995
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651127224; x=1682663224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OlhXThudnCbETkQlzEMVfqGZBLFKuJzBa+QoO50T/bM=;
  b=pMWhdw+QMQhnsXxk6OPYrRbZRX/gkrSFke1qpTw8Y1w6mORhR533UfRf
   Q2Ld1aNZgt+Wz0zU/wVJ8wsnUMqeeX8HWGfZpJqv00lNEHs0jNIsmOIlK
   OSFax2oVTVUWnGQ6oooQNsQoGS5O/zO0A/Qw1NyKebpbqAq04NVKOiDIh
   iWkuA3T8D8fL6lbfSLLQfK/f8zYVPiRhnCLSBvUjzip3fbmg2u6P0XmWp
   IEzkLdSupE0Cu/D6Aa8AOV58Ixf2AXygh6oHVJNE6aEtwkuJ7hCwzuAU3
   u1OeVwZEyLlfXy6SruAIPG2XpMq5oItrHksv5OiInyfkUbTp0YWJL4v7l
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,295,1643644800"; 
   d="scan'208";a="197871924"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 14:27:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbecM2vS+hIBkqlvVfEoT39/eM6I8kh1Dry395eadMB2Qsi1jGY4APeuts8Hh/xSbu5W8d0nRRZtJtfaJ20wYD3sPAhMeFgcU+avvqT//vDgiKnY7V3miuj/E/NfuO4WryTAs9KOobHGJa+4Dr0iwwKvs92+r3BrxUMXGWjxxI8te5Qheh8oE7SttmKF4qKP1NsigIW7kioKPPu+5K7XGIsvHhOPyGDS2rlejA1U2G7Wk0aFxeq3b6IFetWL0ZXPmN6kmajNsoSZx/ZHYoUg3Z9su3X/cgGv5QgeeECqIBMcWkNxJM7JLh1QtjPK0UelHTKOrqd09BJmmZ26Be2DKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vr9VQnwXVfBHYdv5+f4b1OqtiaREWySdPB7G+AYqQk=;
 b=g4VsNlniBEIv1/dCmxOxcU4nn8UzFKdt0uXG+PI2XepVfQtrwHqoRndkvVVk0jYN4wsqCk5liwWz/I5UypZUp3nyD7GDbwi7xrgo2gCLryVxUtbcJ+az8eFJV6l7MU/7oz5Lci8vkCjDmppBRzTIInvqIv71pGA+LBzdRzGEz4fzXZkLc7DJL16rIcJriQIJ9qYRW1dNnad/t9bCpDm/DZiup1pZoz6y/I2veIX9Fd0w4cayzXsv61Adq7E7SpUa8dm+JcpFy/PdD+Qd5dMfPReWdSZL8UX+ODtHbAVPMrEZHs2Sw01jPkZa6mx6XV8YNEJ9mIvKe8eh9uIta0aCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vr9VQnwXVfBHYdv5+f4b1OqtiaREWySdPB7G+AYqQk=;
 b=NqmuHki4VZQSLflViQL07qXcXsK7j1VVYC6MIL6kUW0GLf6ZD161IBNZwYq7dkXkpiIVVS8CSu/1hjeHxodTUAN4r+HBfYl70UT7l02/AHuP0DccibfEyrmoXaaCfgdqzhp0wpSVfL9qbgCtpbF7ZcSSYhkjFuz9KsJwAiR9qKU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6066.namprd04.prod.outlook.com (2603:10b6:408:4e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 28 Apr 2022 06:27:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 06:27:00 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/3] Add I/O scheduler tests for queue depth 1
Thread-Topic: [PATCH blktests 2/3] Add I/O scheduler tests for queue depth 1
Thread-Index: AQHYWsj3Oy8natyW3k+71OYU0Tti/A==
Date:   Thu, 28 Apr 2022 06:27:00 +0000
Message-ID: <20220428062659.udpifr26qgsqfysh@fedora>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-3-bvanassche@acm.org>
In-Reply-To: <20220427213143.2490653-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e02fb073-33fb-4614-b857-08da28e01a19
x-ms-traffictypediagnostic: BN8PR04MB6066:EE_
x-microsoft-antispam-prvs: <BN8PR04MB6066FF0F5693A7B967260E29EDFD9@BN8PR04MB6066.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lekbqSgIkhl5jfbv0axFfzWZEG0jp4bH91m1fa0O8pEHSmpdD0CwMPU7X7gCbe0z7VP7LfKp8zmhheVa/bLFPXXQmL5l9l6evdDmEkIeAg2rlM155X02KftIEYLIfKSylJ9rzqBIWrvT89s/dqvTzIJvP+SrJWJlnsy95fREys49KRCjLjxnTA7j005jEXkgP2oB1d6nZ6vFw515+r9v6buHhpHpTvIMoxI48jLiV27IxiMBgdUE6RQ+Kh/xF+lbXfBkQDx9eb/nL+6O780Ig4kaUhhCD0IgeSNZnaSahmb/5b07twsOzyaH3vMGthNbHdTFiU1HKTRXDMN4IK147AvA7brX7c6JX7417Lfx9H44a+ZKDNJWCnuTOUd84OkYj2o3fLS0LzVJNc7g7G2bhtjfzV9ZhFDMd01bXJrOWPOpXGq6UdGHs78gJdN76EMM/AMzjEJlJuuZKKSSCV3HAcno5n3uKnZIz851qfX705jAFSLqpwYmllcSY6BsonO9bCvyY83eoaZnYJ2u0+FW9HUz2Vrt/lmhcMS2DM82kW8CFwKJWA2OY4vx/S2cPTCvUGqj7nTgwTDK493FSqA4C0XWgOCz4yCjbYqu+59xVaxKr1JV69mXDjMkvAiXSlCJASlgF9gHgUip4G9XvtOvzBA5rERz8Jctrm80WqMR7mw0xD8z/uTD7AgbV9dAfmlBWHgm0amYDwRDigpIEdZEyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66476007)(316002)(5660300002)(86362001)(38070700005)(122000001)(38100700002)(83380400001)(2906002)(82960400001)(9686003)(6512007)(1076003)(66556008)(76116006)(91956017)(66446008)(64756008)(66946007)(6506007)(26005)(186003)(8936002)(44832011)(4326008)(71200400001)(6916009)(54906003)(6486002)(508600001)(33716001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UVR84AJzxgYjNnxXP5XGgQy+NyHc45pJ9VnTqzCnKZZGkfNmSBPwrYiyrNPa?=
 =?us-ascii?Q?rncex/7nZK6/YezXW7xKxsZjAGtDUL/tOJMrwohKNn0LfSYp/JTX2++hxhxN?=
 =?us-ascii?Q?om8QjKJ9+3klusO1S8WK0o2hTsRessmYAhc597Yv+eB/vJfAgG6SLAJ1NyoO?=
 =?us-ascii?Q?IjVP6q+RJuaRRoajLysCVl3DFN+yleT+z7c9wK/WnNex11fIVcVeNBlha/As?=
 =?us-ascii?Q?32bJvVPd32RQZVx6m6RFQkxhz9SYfYxxvVkSLZhh4tTgiq83FWRQZX/ow+7N?=
 =?us-ascii?Q?tSJynny9bzPX2lxc/c8FtZYyW0FDSQeabhBZK+suSdf5ETam6uOwIdGUCtU5?=
 =?us-ascii?Q?nure8ip3h5+nbB4b4jWv8WVCmlaaierpZgGmUv5tzGeEL/vdCtAL4Bbm9iiN?=
 =?us-ascii?Q?PlrjUKSQ/ealXsoTF1RyW9NFd0PPpPl89QE2+y8OnRAMKTM3WkP7DRWOlWMH?=
 =?us-ascii?Q?RU0lJ1HWAKjP4TI1CyRbH93ElwreIgaI8LAbsMtw0sEym+Ol10x57VzbuxeQ?=
 =?us-ascii?Q?Ht9oVEGovQHSSkudWHoqYYufAFhLn6e4OYgp8zveaejuJVLA0YyQM4DC0Egg?=
 =?us-ascii?Q?e7rVJ0UrT+cX3gBNTaueAQzUIQI+1C09StgeQ3FPBnUxUfs+f5lNiQq2oGIT?=
 =?us-ascii?Q?kUvbabgA8AHyy62sxyVJZ0wlZj3tCfcRLXCVyV9ticllEXrRANxUMWnzJsWX?=
 =?us-ascii?Q?yo83YEK4Tf8Nz+jCpTiV6Srd1kZsG/bJpqAm3/bUPcjqYuO4GBJJrCPM2UlN?=
 =?us-ascii?Q?jxrpsIIERv9egYGy6Fqm9X4wncLslVKBkUjeUlUyOA+BsVdCoHFBi/T1/b8q?=
 =?us-ascii?Q?GazbJnNggXntMr2cLD8SnBeTvssRZ/QZWONNuNHQ5VkT+YpOQqvkQzcMGbE3?=
 =?us-ascii?Q?UdHrF19WL+keNqi4zvZPD0PTx5A22cL1OsCOiRgte9I1VRCqEO3vAfozFqL6?=
 =?us-ascii?Q?aAbTaijfYXPLWP5QqNKzmVS7k0bykIgR3ZpnCyr3ck6LC03lOMQcNwVNWes2?=
 =?us-ascii?Q?xZK6EklMtkDkjak4M7fwl9hIUoC9nHOzTYwQm+wleLuxKkvvuAJQ8qOQkLkX?=
 =?us-ascii?Q?jY+f8otbrnJNjQwlQ+uTTjUxjYY7BrHTDSN7icHUTvEblVC03mdFn3KCXwkR?=
 =?us-ascii?Q?E4hgf//yeROpR01PaVijtke7FKWi5WWNc+K2WrjoQtyFPUGwAIfBYdfJC638?=
 =?us-ascii?Q?GE00BdcI+XlyDhDOTPGkTWGpGZD102O1l/ucGN1lZ9kFF2irCNmMGAAbRUl3?=
 =?us-ascii?Q?XI7rPPWkMoy/aUvKXbjzgVYGGX8S0xiPliMmGS+An7rJpmoAqFIXWWN8ou5s?=
 =?us-ascii?Q?bmWVwHua7l+agE4pYu28qpjgRRn2GThd+ljgfn6s6crH4mmLMeiMZdi8YJuI?=
 =?us-ascii?Q?8BRyieEQpv+9IIFx3SkIM9d8GB6QL4hjAWfxaSuh8l38uwkJPNJu3v7guluL?=
 =?us-ascii?Q?pQ0zJK9A4fxkk9/LSKxfvjHqjvDGBYIXNEMeoljNYdXHJxZZPWZ/6YZPSXza?=
 =?us-ascii?Q?IhWVf0ameQQMVJwtUk8lpgHcsL09FEYsc3sI6Vy8DkyaDAIrYR9r6Wchvx7/?=
 =?us-ascii?Q?cz89oWB7B5kwjaamzRNWSvo8r61NOcxpvOwkUPtxuOTk65nhDzXTn4/F5iSK?=
 =?us-ascii?Q?VLfol6Wfg0/oukg2lL/uyjEJ2n+aOeSBua7q5EUIiZ0VyUAteaiMjfgRRq3O?=
 =?us-ascii?Q?7w17zXYkppbBt6SyEg4Ev5pvsl+QqOnU5r+WawCC8DS4BiEjLx9RjSftYGPU?=
 =?us-ascii?Q?axvpXOHgyjUL39j9lybjFCUHvkIvanbv4OHi3QCRTh9s/QsqjGam?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FDE676866EF6F84FB3AA703DB5CC99F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02fb073-33fb-4614-b857-08da28e01a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 06:27:00.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZEKvB1eW3LIWE9LQt+cKsitRpbR+77sG8GZwN6XYLHYGwW2AkeSqPPTxl0IWI8oajcqU/5JSkDYBDpFTBFlAGBz14QkESO8a4A3iwBzxAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6066
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
> Some block devices, e.g. USB sticks, only support queue depth 1. The
> QD=3D1 code paths do not get tested routinely. Hence add tests for the
> QD=3D1 use case.
>=20
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I tried this new test case on recent Fedora kernel 5.16.20-200.fc35.x86_64 =
and
Intel Core i9 machine, then observed failure:

$ sudo ./check block/032
block/032 (test I/O scheduler performance of null_blk with queue_depth 1) [=
failed]
    bfq          679 vs 243: fail  ...  679 vs 252: fail
    kyber        542 vs 243: fail  ...  551 vs 252: fail
    mq-deadline  577 vs 243: fail  ...  572 vs 252: fail
    runtime      20.514s           ...  20.660s
    --- tests/block/032.out     2022-04-27 22:02:46.602861565 -0700
    +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/block/0=
32.out.bad2022-04-27 23:18:48.470170788 -0700
    @@ -1,2 +1,2 @@
     Running block/032
    -Test complete
    +Test failed

I tried v5.18-rcX kernel versions and machines (QEMU or VMware) but the tes=
t
case failed on all of the trials. Do I miss anything to make the test case =
pass?

--=20
Best Regards,
Shin'ichiro Kawasaki=
