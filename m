Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E577BC28B2B
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 00:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbiHSAgc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Aug 2022 20:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiHSAga (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 20:36:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714AD743E
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660869389; x=1692405389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tQGdDNHk99DeoZGBuj1Zyca+VkrklsJXpHZ7kware70=;
  b=oUSC1WLfROG3rJSYr8Kc5YYZtLiZtnHKrIsc/OrFMmcQyPRDgOPSk2FZ
   w2yDc1dq7gQUravGRlEb2gZqNJsL0RrcP2VNabs7QvA/MBRVHIFu3SXLv
   Vqu0I/yv3N8E4TLIcfUVGAgeqsx6vgitw8H1DQNxwXDGeCMhi/uwrZGsw
   ahdi6UfDZUWev/rLX6yYoPEP2Ld6iH6aQAScXd3JgFQjbqD7OAkVy9APS
   /1fSPyh6lVQEVUmk092S121OnhvMA2nEuvWq228JIFpVtDxbkEEwlE4of
   U4gpN077Y8olv3+4EPlOcEXJeh5jNMr2hbYOKV9wcldF+NvPZFrnPBzk0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="207564421"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 08:36:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr1QdtxRSgAQLrolsTnSfOQy++uSO8obdeR3D5q9eMsNOuXqHVNG8q/zZ+/3qa3JhSAcMoFhFNJteAkR6MA1+GbaLRMuR8PMKZRMU/QIgqDon0N6hp7yac8Xm4i7oR5GpWoM0moAXGbLn6/JlMqftACEbNQgk5KRMZ9MGxRADUW851DONmiWebfEygrgXuTrAFR33KPXBG5U39ahJ9vuqK7B/BDreACPRFrNuchFojYJFhQY2etARvmzApdLZg3VTpRRLfFwjU3nuNgy/E+yF4axIQcQpA+ifjONfTVHbhdxR58+z49QPy5VGnrqWKIuqIdzlROr0avheAZGOvsqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYckMWcuBrWqhoV3/geD8h2frKTN8KwinK3sRICDXSM=;
 b=g6s7S+NFhepCSyMQ81kso7WFsZkMmQoV0Gaj1XipFU44oa8gz/WeW5DojCX2lhiMDKj8Bj7PkH9AgcV7ilLHWHumtFu2c1Pp8izNb4bCuLw0sViiP2aGE1IwTUcUYciBCy2zcr1Z1YP0b/6tmW3q4TVimoYsr8qsICB+CPHLRLPOAifoFhcraN287EvcrWC71pLbhxC19yifw5s5F3I45XYvFZyCItSJa6ULOrZ2BC0XvhTXtnKEyEWCqKeKoJCOM1JatYuDRHgYufmAU1K3lnrjkN91giLKVrNJs1tcCAz5tXfCs8Oy88lZkrjlWrjQySacfukYzUgBqjsTgL1GRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYckMWcuBrWqhoV3/geD8h2frKTN8KwinK3sRICDXSM=;
 b=NRi2tGXvwiaGXdBAgnFlBzOo5lLqngnoxCGbl1C+e///Ju5NMsz40WLOEiy6v0Z5I+AOOouwcgQZ/M1KV86SMRQIl2u102f8ZNXRNA+FhRBnv0hHspxYvrJwZGzfRpK/jhpttnylRxYVgi8wTzVzF8NhtZa4og7+VxpumjlQIQc=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by SJ0PR04MB8275.namprd04.prod.outlook.com (2603:10b6:a03:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 00:36:24 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::55c6:d630:64fd:5896]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::55c6:d630:64fd:5896%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 00:36:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests v2 6/6] srp/rc: allow test with built-in sd_mod
 and sg drivers
Thread-Topic: [PATCH blktests v2 6/6] srp/rc: allow test with built-in sd_mod
 and sg drivers
Thread-Index: AQHYsqGQvdKrz0hAlkmFr1A/8yB7Va21FxSAgABLE4A=
Date:   Fri, 19 Aug 2022 00:36:23 +0000
Message-ID: <20220819003623.l4avlxxv6yqn6g4t@shindev>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-7-shinichiro.kawasaki@wdc.com>
 <bbd13579-4279-8263-9d7d-684d7faa495f@acm.org>
In-Reply-To: <bbd13579-4279-8263-9d7d-684d7faa495f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb27d7e7-1dfd-432e-b1f1-08da817ad83a
x-ms-traffictypediagnostic: SJ0PR04MB8275:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gb68eF/jeXdjb0BAf4KkFzIK1YEsYijFiypqricFrmheEiCoECPNZjnekxvAzAnmTgfFp3fCgAmkqHP6CNZHYNrgvZeXfm7ay2o80ApF4vSGEY2M0EdeE75t6V+TL9nwgRA1B9kjtNLVWzwzq95N+L2rhX9y0g8a9cMHfGLogyvcwjPJh5YC5AqYLdEPkx+mBeEnN5nVZG8tmbLI7UA9rZ9GRFg42k9Ne3RFmz0CF7nr7tIkPqtGildFE+Mt8oNol3cttzH8pCjp6GYU49lEr2YguNHHlXDMMfQkk46GBhKX33YZVU0/IOLH4LriC3kOQfGNBRraFg5fGpoI0V6UDFDIJOQtoERlFbEtDSV9z3xyuTGgP+lnPTfvqtCwRz94JRUoTSu5hNKX2Vzr/PNXg3h25L9g/f5v36p3q8rvJhmcWjGQXSp0zKydpFKDOJ+nBe6329IfxBVQ78HPL+JmykFBZVcOVjHg+yHuPmjXENgoJWALo7++2dhztSXQH0D85p24ys5xY5Xq+VLn9WTWEhJeACBKmGdQau9L+i7XWri1qROmqHg9KqPkM8mfOkQePvcNnNGm16k+drEADfmrfZgxG7lDr820QKczcxpOSB5+X25rdwefoQaFS0oRXbYwvLysSk2RG8DjqR6KdsbpLiiH9E2uBHg5JuKifdWkt0IeRdBh0p2he0bSpqSWaF/ZyRw3Pv2wMkgDaswDpbQpnXujKfGDS4JfiU+wYXvQ7m4tbP/RyhFy5qDmNDca9XZJ57uMrkDWDJ5Z1yfMOhmV4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(6506007)(38100700002)(33716001)(53546011)(41300700001)(186003)(1076003)(122000001)(2906002)(44832011)(54906003)(38070700005)(4744005)(6916009)(5660300002)(66946007)(91956017)(4326008)(8676002)(64756008)(66476007)(6512007)(82960400001)(66556008)(76116006)(86362001)(26005)(8936002)(9686003)(316002)(71200400001)(66446008)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CSabQUBoCPisWueh48K2NC6ARePbmVVDQZlV0Z4xjb37S6Vr1act9bkhVtsr?=
 =?us-ascii?Q?CkSr47RtkNhiqbpNx8DtQ6844EJedlBWchYLNxWyliSd2EzV5H7RLYR59SoF?=
 =?us-ascii?Q?Yl/a/WP81kd7WtDvV5KG4TjekCOd2bQjUakHFiDvR7VM6UlajlUDBGQ6JtSX?=
 =?us-ascii?Q?8t9tt18dmDggDTiLNzsR+sRUG6wGGmI8ajxEJ5wgREjydShhA4S0Mepv5R0d?=
 =?us-ascii?Q?H6G6tVwIsTPO6vH8LifG20MLAJsPYb/sfRUw+vpOIA8dCM4wapwB5lKbB5Y8?=
 =?us-ascii?Q?Y3T8EsCg8qjgYCDWZdLInC2uNVcJeSPvg0XjQVBzaF0HAxs5/q72OjHV+y3I?=
 =?us-ascii?Q?zMMwq1cGPfzHtzGC9mbOYUyngLzIAkYIJDTDp8Ssxq0gdq5KZujrLhmmssY6?=
 =?us-ascii?Q?WLJeV3/9TIUMh4bVWhJRuIHD3R6FMBFFOqx4MDsEbLMRkl4h6Angqw+3Nlb1?=
 =?us-ascii?Q?Ru6os/kFzpiAW57+E22AOthOn/xBMWCPu9UkSjqCXFTQH5nabolVFAHUnW0f?=
 =?us-ascii?Q?D5WosN/2Zzf55g521sVib13Otgp4EgwvZdJsEOo1MFMNtaW1PvKPxiF+iY+N?=
 =?us-ascii?Q?GWrVVpHNf8USwG3VyQlfCIA1XAP23yvMrlgZt78rQAL7TWcPF+VYwlUIlyim?=
 =?us-ascii?Q?3HVgR6KvhHLaYpvfPKGfFhouORFf3F7m+EkEltkSj+yv1gpybI/KvjYESUfo?=
 =?us-ascii?Q?EnMXdiJJv7JstrfvbLG5BVLL1cKSlJ1K8lrHP7RkwbZY0ouM7G8KuuzsAveI?=
 =?us-ascii?Q?KrqkPPZldZJFEM9kL8SZG23dbP36Yx7xv1vZPjSeVo/df7GUPXfxzx0T7vEX?=
 =?us-ascii?Q?lszaIa8piOLT5UhIShL50pp/D/qZLkeaCPLZnGnlb1WcREvuGH/E2XvSRTXQ?=
 =?us-ascii?Q?yBEkwByG8YswlYvUvSJCI5vazvGSORBtUpsLOMaLXY10UEJOz0uGD44UapKy?=
 =?us-ascii?Q?Os0qnyV8LOv3YprXp8aL4Ed0pwZyMiZmBe88IYbtt1cv7mJyXiAfMJZMcZdI?=
 =?us-ascii?Q?sEISgMdqGRTMZ1CcyaMgb3KvWhNkgnHqe9zn4VOlOrKBw8XdyUMo9HOEoYFB?=
 =?us-ascii?Q?J3uxx73mNS+fR2FjwJjBJbLFrAgdowEiJDHUpVbqkM7k5OaB5x/1qwBoSlgb?=
 =?us-ascii?Q?/wqATEd6TMbI3OhSeFTUVRFpehCLwl8e5SFgzuRqfiKDNzuZKQ6YuVPOoYl/?=
 =?us-ascii?Q?rnjellRVGsE3tDW6Se1zlXHuHxCk3VO0qo7NzStOcWoOJnjNVlFuRD6nGIhm?=
 =?us-ascii?Q?4hytOEJVrzc+S6RmoTqYrJL+ypxkU72JJrB0FJ7NmAN4ztC8CsqjsgBKdwLw?=
 =?us-ascii?Q?HFUmtNQ9GKfXzIA1sNt9khy2uXwj9XpjxahpRvG78NzfxG/6rKyWayyV5eDa?=
 =?us-ascii?Q?YN7z9CTeMsg0UTv4oT+t+Pbqi+lkjKJ8fC+ti6kEruWiLLNt2/y9KaWw+01+?=
 =?us-ascii?Q?jEVjo2L4yq2rHbEmLPiT1uIX1faK2zlYNtpangQ9dX8uWDsnSqqiMVwq9jQM?=
 =?us-ascii?Q?6wajp68MpqOi7mwOJyIJe2/918MAvZv/dnJeGbdyIoRWg4jC4/kUx19adLxK?=
 =?us-ascii?Q?Ejk2ebbrdh0f4puZvLibxILRHSWBuADkeAKlito24/YOyv9v4QIxcGpNebla?=
 =?us-ascii?Q?vknJ2qlalDfcwP+vyEzaYfw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D37718664A47D14DB9D87DB9EFA1D298@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QWKcJqCr86pGXouUEg1Aq7pH8gd3KFgJXHjaYVE7aKiIwdJHK4pULUTjZtc1X3IOF9IStTgRIQKmrWc4ZdW0nfv9lFuBmWsEVOaVIigTlrpZoBfKYdDArQwxSnTiRXDzLhBTmxJgoRJ7v8rjxBRhAIQhrw1YDX+KT8Wu9GOIzU9eEJJbXG38IzeedQV/t4ecH7TFKU3gTNg/vgPmEzD5N5wo2Ua1JvDr9YU85fiq6Y5OYOPzI5ZnoUf29hm1je6pZG/GC4ey6udXvi+DYTtJkESGZ/+y2e6bBs5PLGP1AIxGsTYGPV7HPxs7AFlitWGxq/Q0rJ+3+WoFjLRbOseLY+JV198mqR679wKbrTLCGlWYC0mOpihEXkZ07lb7/JQtgLect5ZDuz/GWBBhMKU/KMlf0KP6mze1yV+V87OH6xwKwt7g6hzzTH/RTrT5LTPpk1AL2iubvO89laRLUj2kLvtSZxLYRGTPjpVISWBri/OQ1ldEhK/j1yGMU1nFXJ1yxsgByety8Yxf5UtnnDvD2qu9oRB6U4Uu0lWmKs+u84t4a8JuKc6s1IywLJIKH+GFGZhhN3aSahkwDoGsmkzauG8USDEkBb6xkYJzyUYHRCNHSTzTp7uZHu/0/KpbYgGkEb5vmu6k8BzhRvYvK9yAhX1cBAXvfegx4Wx9k6Q0O0vOGlw6LQXXCWKIunVuLH0do8GBUahBBPfiooasLUTdu9TNybHlkh5p+cq2JoC+89di0aYJ0B0g9fYu1mkRowY9U3Doc9aPdq2FJfflIFa5lnoaRrNWMhDQnzfRx3Vw/A7xwvigU7Da3xBykvZ8qz0+06wZkOjOh0rn8euOpDdntw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb27d7e7-1dfd-432e-b1f1-08da817ad83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 00:36:23.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6u0JqlVQhEIKHIvYekp9HQLYu0gJC9s8M6d0idroz+oiRHXga5JVICH8aodDfWR+UebA3xrT6jcLKT0tFLPblbPcg6pCaIPbbdm40XEY3bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8275
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 18, 2022 / 13:07, Bart Van Assche wrote:
> On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> > +	required_drivers=3D(
> > +		sd_mod
> > +		sg
> > +	)
> > +	_have_drivers "${required_drivers[@]}"
>=20
> Can the above be simplified into _have_drivers sd_mod sg?

Sure, will do so in v3.

--=20
Shin'ichiro Kawasaki=
