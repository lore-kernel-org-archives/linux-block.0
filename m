Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED90C433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7338A20776
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 07:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dFXrOSpH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dpjiLj94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgH1Hgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:36:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62585 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgH1Hgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 03:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598600259; x=1630136259;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=88h3JIEyrUOwqtcLjvWwatRQ2gUTAqf4eNTR+KxWccs=;
  b=dFXrOSpHeKlBuSITqbpDUiSD32aZnm7i8weao0h+d0/kzPD/yqzvZ7Ow
   wWTKMs/5Y+JhiBYBkXZ+7xNkmV760XkHiNgRypDMQC6kS96T5O9bT/az+
   FjCdUnjcaGahAjRaVfSd/0vFooZHI8+/2nUWWqv0oN32Z99h7vJj2zSG9
   ilxp2J34oHa5TAIgbZAEBxwfFmSSlptgDhpLa1U68DgTFrmeVw8qmOnWB
   v2scI5q7yxh6tcCToaS5PiHbD2fT9UPtMrah4fBxCEuMmyhCQnMMeNF1Z
   yFninNG47iiTecEzfVC30L4L6dZGNV10GHlo0NYJ9TmTOoxV+dIbMUNhF
   g==;
IronPort-SDR: /JPk4w9q+uD326Eg5MAxXB151YeucMdTuitM7xijoGbG40sl7zzlSvVySTgra45duQuAy/nzeU
 0CdSFH5GDY/DNn6brLg80/nK4HHXoBeWywU+ca8prufZiL0BJpk84YbfKnhJ8ERRdsA0tPQ71U
 3clI/yNkGFFjbtU3+eLh8/dv/ZYpvLRzQLahxX99yl19xMtwFE6iMritKvqGpIAkPpasB4+wt2
 QCKNLKEyQ7rZDb7xFgtINL/SuAjRJG0bOgz2+RthjxGVHCK8UytbVOM2xtDJKSLPoSw9cbeOBA
 Doo=
X-IronPort-AV: E=Sophos;i="5.76,362,1592841600"; 
   d="scan'208";a="249283961"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 15:37:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWiRdn3kKHfUZ+t4uT5DvoxwUJV0hULu6Mt95OYy4BTycYh/vz8humSmuHPEHlon+hBwSZR5VCU1b1K/Tm3KMSpLta/AZDSjrrISK8jsAaXHitat9rRZ+o1SZ+8AutMxapG5mTe8rRopqsREgBwyvuKlGUsQE26v6lKyP2xvucTNFsCCAfaTIVpZB7bqgwYCnZn3how206fokZOFLDMzPTDi8eqBdwdWg6YPT+Hj9RyraPzcgYgsIdP/5EnT1Sj5YAytbIChYJ4ezLz6pqwdVKmoxs71+OQTCMll5A5pNCV3B5IQruvftkf0VhbTydP6KKlygvg/OmEkMAyR+G8lTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HumT/1p+GVTz+HBMHn8WbEtP7ajXDGml8jXb09ODJ9Q=;
 b=CWfUewQBULY4KfkQrOGDkpTDz6JrxvQGUhiM5QRDfVnzkHwrpYw+M/VqZ0kJxrhMs4rYnaB5C9QiGiAherzk1Lw6/jZNURiS0fucjg+oME0ayFNq2RlXi7ScyuMhviD+3xmOgH90lUC5+Ik34mhyOE27TdXqKYDeVFkYQnS1JlLakVxHuy8Qpx4neUPEwxijvgQfP76N3UendlM4y92aHXrOBEmmrB+HUxYZUJ3tQcLwXfHvBXPZs68fw07z37v0pqrHVLKK0x5ujhoFgXcnmhUQoHo82mSHrjfoLXicVoRCrQFpaylRHJTdykNLXYUURKeR/NPW6dncKDAtcvW6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HumT/1p+GVTz+HBMHn8WbEtP7ajXDGml8jXb09ODJ9Q=;
 b=dpjiLj94Jo6Xd2EujKfgKBiTHLG1meQxM14Bwa+vNNtMIOlfo3feHHgkezC7dNWwnvOah6R6PansAGlOuO8+grPMTqqxZYT/FY1lwgUjLviAHUgkATV1eGD6L4qKciv/TgZBt5WyCJgW93ppdTGrkQ4HenRsqjzfaCMmg5o/hBo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1225.namprd04.prod.outlook.com (2603:10b6:903:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 07:36:32 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 07:36:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Klaus Jensen <its@irrelevant.dk>
CC:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfHkH+20N/yg19E+BQ9ptEBewKg==
Date:   Fri, 28 Aug 2020 07:36:32 +0000
Message-ID: <CY4PR04MB37514386D6A94A04F66EFF1DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828072253.GA1331347@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14376990-ff66-4e79-8b20-08d84b2515a7
x-ms-traffictypediagnostic: CY4PR04MB1225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB12256D00D98068084607CA45E7520@CY4PR04MB1225.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1keBlVmDH6WrNY0jYpb07SEK7bqQg0FhQoqTUSZZagOSvo649uz3/9sR/V4nMDG+IqP9xSDbo8ipQrWOOzoZSL3R+akTZ2hw1P78on5UPGbldmqUYOltSmI55ClS4C9QWPRzbXaeCkTZQym67lmD+w+UkC2X3J36QremwIvk7EfKdSDTeHvUS8VOemf4pGIY+GM34Sau/omFRidWXFPqd8idWU6ZC5FbyQTNaV/zrj7D9zlveO5BeRwB9KnTjcdf3NMmRhHEs+t+Sg4dJMhf1X8s+eEUrGQDVysGV0KtNAONCyBvzqEaU8bTbF+V9PmLh1nN9xpx4ys7qmg3kMdnsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(2906002)(33656002)(4326008)(478600001)(54906003)(55016002)(71200400001)(186003)(8676002)(86362001)(6916009)(83380400001)(316002)(52536014)(53546011)(6506007)(5660300002)(9686003)(8936002)(91956017)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bqIZQvXaVvk+zHRFhrJdzNvwJf8/Fnul22+XvUY05qkLRtrmi2MUIB4sKveFuVCFubQT2a7tfEnGqTlE+tf8KZbecPztir3Va7BGsNdvYeczvNoEG6rXwvR+HYLMRBTy6+qhpgAE491jZxPg+uYJ98ZjVjm2CGxHnGeT4+EN+djyaO8OVPsChcdkI2r2wQbjF90a+tel0742XHM3rYoffI6ZpsMcrmzRDdOP61aq/Njk2L6x83APdcu/eZOnxOO4vGWCntMav61iMf7JjSu/+CcUG3NcyGSYS3y+mIhdGlkIuSDhut62+Rjoz6UwML0OuACx9uhD4zaqwGGSOFqHUbLjrM97kEXkMF0fofAdmJvNPtF1Bd+im9Yv/S8KHMBOXe2L9I23jZ0wP8CFectL6nOnACUzjKHYq3PK8j6Zx7pVSgAh7wnbPzT/4x0AM07lygxiVCBXG0HCcYK4NBMl8V+fBtDcNmMFkKQaCnJtNY2ClEQTbQddY7YIv/ktqcbvH/nhhEMYHJxkLpLOWR/AmgthPdc6zFrLI1eRSYOpADfhIZdgsm8nAL7Fr2nM5Qnhvr6vR6S0NcxE5QyCicF/FWUgdl28srKPwC3An7LqRLAonvA8nlSXmXspMnnvasOxDWD434Q4+xdU6mztpQo7wUHWLm/7OAa4gn7T3OKAVUc4OMPo8mR/+2rHAO/jOt0VY+nU6kYEsLfgLZKOwKkQpw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14376990-ff66-4e79-8b20-08d84b2515a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 07:36:32.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 86n7rzOX0fjs1vp4jNEfAk08v1vzhyc5kClQfN00LzoIbbL9M+ZaBreuQ9UAEqiOL+FOTPaLRbx5KU0uQ4/4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1225
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/28 16:23, Klaus Jensen wrote:=0A=
> On Aug 28 07:06, Damien Le Moal wrote:=0A=
>> On 2020/08/27 22:50, Niklas Cassel wrote:=0A=
>>> +static blk_status_t null_finish_zone(struct nullb_device *dev, struct =
blk_zone *zone)=0A=
>>> +{=0A=
>>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>>> +		return BLK_STS_IOERR;=0A=
>>> +=0A=
>>> +	switch (zone->cond) {=0A=
>>> +	case BLK_ZONE_COND_FULL:=0A=
>>> +		/* finish operation on full is not an error */=0A=
>>> +		return BLK_STS_OK;=0A=
>>> +	case BLK_ZONE_COND_EMPTY:=0A=
>>> +		if (!null_manage_zone_resources(dev, zone))=0A=
>>=0A=
>> OK. So you are hitting a fuzzy case here that is not actually well descr=
ibed in=0A=
>> the standards. That is, does finishing an empty zone necessarilly imply =
a=0A=
>> temporary transition through imp open ? Which you are assuming is a yes =
here.=0A=
>> Personally, I would say that is not necessary, but no strong feeling eit=
her way.=0A=
>>=0A=
> =0A=
> For ZNS, the spec is pretty clear that ZSE to ZSF is a legal direct=0A=
> transition. So I don't think the transition should be allowed to fail=0A=
> due to a lack of resources.=0A=
=0A=
I had a doubt and checked again ZBC & ZAC. I section 4.4.3.2.4 it says:=0A=
=0A=
The Zone Condition state machine (see 4.4.3.5) requires the specified zone =
to=0A=
have a Zone Condition of EXPLICITLY OPENED or IMPLICITLY OPENED before a fi=
nish=0A=
zone operation is performed. If a zone with a Zone Condition of EMPTY or CL=
OSED=0A=
is specified for a finish zone operation, prior to processing the finish zo=
ne=0A=
operation, then the Zone Condition state machine requires that:=0A=
a) a manage open zone resources operation (see 4.4.3.2.6) be performed; and=
=0A=
b) the Zone Condition becomes IMPLICITLY OPENED.=0A=
=0A=
And section 5.3 describing the zone finish command points to this section.=
=0A=
So this is not the same as ZNS.=0A=
=0A=
As Niklas mentioned, nullblk tends to follow more ZBC than ZNS, so the code=
 is=0A=
correct in this respect. We could also lean toward ZNS on this one. I perso=
nally=0A=
 have no strong opinion either way since there is not real good reasons for=
=0A=
finishing an empty zone that I can think of.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
