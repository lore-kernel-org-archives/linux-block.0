Return-Path: <SRS0=FEuC=EL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E94C4741F
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 08:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8442206F4
	for <linux-block@archiver.kernel.org>; Thu,  5 Nov 2020 08:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ER/nOg5+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FLppJyXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgKEIZw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Nov 2020 03:25:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38354 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgKEIZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 03:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604564751; x=1636100751;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/fWJGIV0J+CSITM0dg9Y75lbonPOrGgovq8SJ2FrojE=;
  b=ER/nOg5+ZPqZ/ZTks7PY2pqqvWtAEeC1T7vz25tVU2cetKGRinsWVze7
   oxIcPpsd8GR1/eM9JPdHRSPzGo9f17roSOOzT8B7EwzJSHIxxl95F2muv
   FJ9Gcpu5jX4DBxOHnP7ItukNpB4qEVXLjQ9WlCYR0EOQM/JA7viSLdcbK
   lC52NXiMF2fJ3DD1vTU4AJA/o1C7fZFoPSfd3Ei0LFYfXt3xXeD6+1e49
   VP64jtz+Sfl5SKSXLYo1CC3PW8E87hPW29xERpA9xdqKueazmz/ALE8Pw
   IekV6UQ+d//C9qjsIE/+A59zmt+mggzX19wC3kOmaYk2GtfnXbFh/MQ9X
   g==;
IronPort-SDR: njGyckwW6begH7PCmB2w4QZOsmMHluHPZImss1gGaGyoCHymVaEx8N2Gulba1Z8XG2VFvUGPkO
 h/vJ+Apfa5eDBzmPx7grl2Fy1hIUccyoGCvMjGsKRmD1kATD/juT9cNAE293VrK5E/5WMpzhHg
 4uc/9nAK34+AK+rfVhyg6wO9V2AV1BACGIUjC+/ggfe8WbnznOaIy712Nsc45Er9JM6X6AzoSP
 /dvEVJegxXw1CiQW+BSG1n20GrEdCPOxGJz0gFQXK0QOZuAuH6vImQwgfkpceR9NbbgSeVynFy
 kc8=
X-IronPort-AV: E=Sophos;i="5.77,453,1596470400"; 
   d="scan'208";a="153092718"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 16:25:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkgNcb2UMGYR6a0Xf6k8OIai9UKjp6PuZdWU3q6awzFbjVfMBCluunMWxG1h/4C89QBbJkGAnU5XJQUPFgf831wMVF2+gzMb61y+GUOc2WAlLfSiNSFkNYliGEOOtun7xueVwIttU8dEC0EJ7tSuRrox/O3nQHuYQIQL2/xrS92t3kqc36L5X1pIt6f8kJpAlV6Ent+8J3mbH0tH0DqCJ56Eb8YYndwQ1yVsTabJoXjt5cPLAMikNQ5NddidaQpgPx8NVqcYsapTjAckJ6rVJJIrTHS3YB5BZdNyFyPONtqHYLAXnbNJcyBjYstudc88calWZWYY5r/CpHvwGusJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAq0R9RjzIT7/w99PLkIkSn0CEdwkWIImlniw/7PTWo=;
 b=PrL7VMObz2WYUcxfCJ1agF2puE4paqun/H80spnpz6elUgAHLOzXzAKxqaDwa4WoLsIt8pzc4PPIGCMRdeSOQXxqdpJzskUhDfYnmGPmvDcC1U0hdoYTRLfuhkWGX5t7RDiQNhJm+EwK6t5VHEItXpFe6ZZVG1xk6H215shx+tA0Rwem2Bf0VHu8a3iUvbDblm5GwZrUYOUn45Bq4pDvTTbQeSb+Xyh78qMRWiV5BvsRPqTUW7gaOA8UDSdcMp3H0Ra78NMHlxnKvZRAz/L8fge4gZTYkDXaZ8D7vd167h3HX2hcX2c0FVF3mBkAfJVTXCwIHE1rKd7t4PcUBpOsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAq0R9RjzIT7/w99PLkIkSn0CEdwkWIImlniw/7PTWo=;
 b=FLppJyXaKnyHMP1ME2oZZgE91p/nPoZghVv4MXtpOOLSmqMTR7WsFnWS6nDNsrxN3aYlOpO7L0HCzW8lDmSF6tg24PtEepvtDt4C+4QmymMbqEK5+695Fxx2PZkscLbvYj66iJhfy+AMcAr+ko9mXGHvIe9UMSgYqxwQqPtI25A=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4738.namprd04.prod.outlook.com (2603:10b6:208:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 08:25:48 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 08:25:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Set mq device as blocking with zoned mode
Thread-Topic: [PATCH] null_blk: Set mq device as blocking with zoned mode
Thread-Index: AQHWsz/r9sZHVc1mskeMtHsg66vYdA==
Date:   Thu, 5 Nov 2020 08:25:48 +0000
Message-ID: <BL0PR04MB6514647CE89A588DEE0B93E0E7EE0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201105065008.401112-1-damien.lemoal@wdc.com>
 <20201105075402.GA19304@infradead.org>
 <BL0PR04MB6514CBDAA1C72DE610351689E7EE0@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:830:5e48:69b5:9288]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 077c54de-035e-48e0-987e-08d8816465fe
x-ms-traffictypediagnostic: BL0PR04MB4738:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BL0PR04MB4738D56F8C3FE1A9B1B63F94E7EE0@BL0PR04MB4738.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dK5N6XvNi1a3NS3l8+slqWJi61lGNmtM5vQ4i8Q8fyWPW6iHmAr07wTPbW7wqfgsRcDgB4/LQC8dQGkyv/7etyKTSL0w5gaotFtOeakXT1JhZqF5HG8IN/ipqFcvHo7uU62iFH6RkGNPqOQmNUOnk/7xQEdb8dEWSuNY+yPM/maeaq6fuKF91JEnExBN3QcIboViYH/YfJ9iD8Lb20SQ/mf8WAndHwzPFORuim9C/KiGz+/U/3ENcHUL3l84mIRw3YFYkzx6JJe1SRIc5Bg8dPpqY7U0NvGo5SD5+7FQDCdeNfJlyso+2iuSvPh6d2DUofO+k+VQH3Z8JP6la5rbxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(55016002)(478600001)(8936002)(54906003)(86362001)(66556008)(66446008)(66476007)(66946007)(8676002)(5660300002)(316002)(4326008)(9686003)(76116006)(71200400001)(64756008)(52536014)(2906002)(7696005)(83380400001)(6916009)(186003)(6506007)(91956017)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Jpf1a9uEmIu9iuLOUblh+FnpDE7dLg572Dy+NraS4w2Axv1ZmzKuos6oqBjywj4bM/KD9L93e3tLuqGZ8FbLot520gGSYaXRZsUfLx5YFYzV5WlAzPxOVCf6FgqXgZnOkVyC/xbKifEcWpUF6W4dRk+9FHdd4Aeqf5DvRT8kiKSXixCHimcj+WQYPxvTzI1ZJPWmoZilnmhB1GKBkEImJwSM17TokMOzC4bhaSE69oG5RH9Bo4apnpuCHbzVcwysoAhjzf4HzwKvXIdDn/426cvhwfUQn1m4aD9RZ42MHqULxd7tKh4NSvuL4rb5bt0Ejk+1g5QBnDbcS7jiVWeJd8qnlSsGRr51Ov42Eq0a2b2vbw6K7l+vCf/D472tNjJE6AXE4ETJdnD5tK2MaUghUUJZqBdbGO+h2c5Na7biEFcUryQ8q/J+R8ROg4CJED0JqyEv752wnaKQBCO4V2JmP7zNXbJoWnsAxkma439l4ChMRoKsTzcZZapS7Gg45Sh/aVSErDAUpJ3X2nd/826U7mden1ha1vtfXvMwVazqp/hnCkvHBK3E7AcUN5FpGV1LcqxBEJ2YrNmCjQCdSmOufw9we9BEZBnMvHNC+KoDOC94FCHhC1eWmXW8sKjoTUtVjHsVjWT6/Jum+WGWuEv+FzNJi+X5y/plCxTyB8FPeStFAi9miy0c5Pi0wK5YGmxrCURrCo52leqjdlVL/AjSxA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077c54de-035e-48e0-987e-08d8816465fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 08:25:48.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuhyuKLxFiSGGJC0+LqX0zxlJALBqRKA/KFTXKue/mbkJrSBqc56X3ignJjsB4Jqxkp3lp9UY1oemdLbiBELKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4738
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/05 16:59, Damien Le Moal wrote:=0A=
> On 2020/11/05 16:54, Christoph Hellwig wrote:=0A=
>> On Thu, Nov 05, 2020 at 03:50:08PM +0900, Damien Le Moal wrote:=0A=
>>> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed zon=
e=0A=
>>> locking to using the potentially sleeping wait_on_bit_io() function. A=
=0A=
>>> zoned null_blk device must thus be marked as blocking to avoid calls to=
=0A=
>>> queue_rq() from invalid contexts triggering might_sleep() warnings.=0A=
>>=0A=
>> That's going to have a fair amount of overhead.  Can't you change the=0A=
>> locking to avoid blocking?=0A=
>>=0A=
> =0A=
> I know, but the GFP_NOIO allocation with memory backing prevents any sort=
 of=0A=
> spinlock. So unless we change that to GFP_NOWAIT I do not see a way out o=
f it.=0A=
> I am fine with GFP_NOWAIT, but not sure if that is not going to break som=
e test=0A=
> setups out there.=0A=
> =0A=
> The other solution would be to "do writes" (memory allocation and copy) f=
irst,=0A=
> regardless of zone state, wp etc, then do the zone checking under a spinl=
ock,=0A=
> with that eventually failing the IO despite the copy already done. But fo=
r a=0A=
> test device, I think that is acceptable.=0A=
=0A=
This idea is garbage. That obviously would break data if invalid IOs are=0A=
requested (e.g. a non aligned write).=0A=
=0A=
But doing the data copy (which may trigger allocation) *after* the locked z=
one=0A=
checks may actually work fine. Still scratching my head thinking potential =
problems.=0A=
=0A=
> =0A=
> Any other idea ?=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
