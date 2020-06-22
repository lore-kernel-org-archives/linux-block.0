Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB704C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 07:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BE62145D
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 07:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GBDYdo0f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dDgmmJso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbgFVHvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:51:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49451 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731310AbgFVHvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 03:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592812277; x=1624348277;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GKvxkWJWOBbO6KmzIzA7eRj4JY9zchXIk+CpUFHXM/8=;
  b=GBDYdo0f23/st/DTEZVEyrDpSLY1B5cD+GEfVNPVllpjP1uKvn8s72ro
   CEWh69vcIy2Wh0JJXiVAjLKeJz0xtMkqMsTzPdGpBmC5oCWfpp43gFSQ6
   AkPtJsbgWMlgVJy+ZjOjbtGg3eBOWDgEgs3jqjAkg/BgvrWbKkdp/nceI
   BW0kwd3jkoFTu6Knle42uKDTOptzFNOH6fcC0Q7BqnU4kuDpz7+vnEtLo
   MgWASOg7PUuEWFXlqU69cTfWt8OqY+1bTIBLggDpMGVJILDIMjHwxnk48
   xJCFO49CxFp/m5yOY1/tqIhPzhrFeyKzGuOaIB28FNiGgJKgJMaAYSsLE
   w==;
IronPort-SDR: iMUoRFawO4OJ9KvwrrbonJrgkndVawzeDfnTS3b8/w5/bIfDSWwzmEZJwK/rsIJN+iOQeDn33y
 CGMW4ZUyJrFJQbVEc8Hf9i4FHmWhHkPSk8JCby+T5uysYbPxU8ZC5cnEEUMhiM+4HrkLsWfHBc
 iUcl0XVQMnMViG/oyyFgvMv/MCOx7Sa3tzynnZCqhLMILJIna1kdVQdKGwMaN4h+1Jy7Fuaaee
 KHw8loDmem8DQT6MjKQ+XETWRFJlcywcj1372FlnKGo61qjlYz5WtvzrkOmwaCyiFLYzOgh5lW
 kh4=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="144908554"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 15:51:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM50yS4mVTwdMDuzgKynegKJHyFaTJi/X0TWETfhQD1Shg7YkdIIJidi+iCjhLEIQtLFJuCZAFp7SCFb9x0c2LGevVQ5BienQUDvyLe6H5mHV216IYaYnWecVM0y/P3rYmlRO6ivRyUVHlM2adtXRkY7ggR7Nz/hDJvT+pmMQtH1BF2Scv9VWPsXQmauoEDCvO92w7mesIkV4MKSMtQhdyQX7/q/quI963E0/T8vfu6nlrZ93MvmHw3eevgAeq0kKnyPUsjB6ITFM+9T5yHWdtroNUBC+1j8TmBCmblvk4xfYPuVUdAE1tUWOX4Q9JdqUCyV+Q8EG9WubFZIlRMuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKvxkWJWOBbO6KmzIzA7eRj4JY9zchXIk+CpUFHXM/8=;
 b=JmHiehPLqY+SwNBDkR5n4fEgqp5kTUbXUz8+qG1IisN7f8GMk6z21hwdNjIOzX6mzt1TIIfx8sbR0krp0ezZY3SeG9udlewiOFUGJRMV91Q8MlgCJSzyepouSxrAO91f5XkWty68KSquz4dNIrdneSK/kjnZ9RiCoqTOsaSHEO6MYJMa2VKWmhAAyCd3VQe6WlgjzZPfk+I/7napv9vyul/1HU9yzgI9Z+2B5PcU4cK465Kj3kjp42eBdwvfgA0rvV7b3LgNlQkceeKms0U3cq+nJx3SQ6gQ6CvWi5CfUbQKkc5j8RWLbL92t79BnsCV1Pck5N5Kw56tZOV4zNRSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKvxkWJWOBbO6KmzIzA7eRj4JY9zchXIk+CpUFHXM/8=;
 b=dDgmmJso7/QvAdnkV2ti3yppsRKowvkhZ7NiAowITlnPUWGYZ0po1nZWjlNw8K4gEn39dSge6Ype3oTVqhYiKUHMpGvtSwZqzr2//JZP1na/G5O95cJCyMARKpkrP6rM3GQfOfJ10Nwg7DwECYSqCZbZ5V9i4CWO6UPmNh/YIrA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4397.namprd04.prod.outlook.com
 (2603:10b6:805:36::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.25; Mon, 22 Jun
 2020 07:51:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 07:51:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Thread-Topic: [RFC PATCH 2/2] dm: don't try to split REQ_OP_ZONE_APPEND bios
Thread-Index: AQHWRgczQDUEpvYNXEqUv7bKhjRaVA==
Date:   Mon, 22 Jun 2020 07:51:13 +0000
Message-ID: <SN4PR0401MB35985AA8FE160B3B0417DB3C9B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
 <20200619065905.22228-3-johannes.thumshirn@wdc.com>
 <CY4PR04MB37514CDC42E7F545244D66C6E7980@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200619162658.GB24642@redhat.com>
 <CY4PR04MB37514F8CCE7918A7C13FCA82E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48e5eef6-28da-4248-0cc1-08d81681098e
x-ms-traffictypediagnostic: SN6PR04MB4397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4397F41A39E70F9A719981779B970@SN6PR04MB4397.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mL/b+/4vEwk2py38ZvSQbCh2yUET2akqj8lfwU8rYWGbIPUBKAu2IptNs32TeDdgf25h7KFGgoeuP0abgjG31Kx1ySJgjpkD5iUrDt0sPScHB9kMOP89lF1elBmvRDDVptABA5+8NG+WTCHqAaC5Y14Cr2KYV8hqZ2UIhKg5wA8PV0vP7VHfKjtyulaqnc9BGQpG7GvXZdtDGfSJ/eIaDUIDtREdxiSw0CYRB5Y5J6piuqgke2CEGi8ysxb2lcNVx12o62OlBNDEdxXfavZ4Qb8XeK31DV9Z0R/rH31UGIWpL+1k88E2rAx5kSkBgIqALRJnc2rWxTNmKd4zn0HolQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(54906003)(316002)(4744005)(86362001)(5660300002)(110136005)(478600001)(6506007)(55016002)(53546011)(71200400001)(7696005)(9686003)(8676002)(2906002)(66446008)(33656002)(66476007)(66946007)(83380400001)(91956017)(76116006)(66556008)(64756008)(4326008)(8936002)(52536014)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: adB07SJ4VH+7T23a3kAX+6YLx7zE4iYUPjv5qlcm2OdhLLBwOa9P30CZcoQiOBy56bmmbjC9wX51yA6uv/jQMbP2NlrauD1/qkMMQ+OGP9RD7fW8XOG5g6/6J/NoaHKJQ5YPDxLU7SgwkhPmsEdHIogvsXxHXDOVPy1vBr1y3fYJk8h/Q8w6HNvu4dtJJRd4OWG0ztTrdIy6RACHY17a3t1HYku24E676veFTRID+qwJlEN3tp+Sgt1+ncoRSHK1auoVDG4y3Vb3B/vCCPRXXuBZI1zu5T/zoK+cGbtZor3p66p6+nFzdAyDr+jncgMgDF5mxJs12+mylrftg02ti28xcunMu25Kx404Bru89V4VJAAVWcy8cTLwPo2dPBOfpZsW6MobHq2rOQjYi1U7TdC1jx8Gxh/T1Z6g/wSjqeburCIocGBMU2N26w8/ZFmlBvsFO0pcfWdkR/dV81xAhcsO/AV8x07GAzy4CJIpBqeA89DlSfJ1wA5E21y1f9Qom5bsH7yGcxpDKYZw5qRg5iGoJFpCn6VLKZPrxzhgmsDGm91ZK6AsL1ecGTp8sMqX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e5eef6-28da-4248-0cc1-08d81681098e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 07:51:13.4491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omzyeFwjN+G6LkJr0xHQxIqwYVOfE7ShThCLFe6N2saf2hF1laxdlE4ki9Qamn722yDF8FdxLOe62Konv3n8u5PVGuKYfTg02WLonvPo9iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4397
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/06/2020 02:27, Damien Le Moal wrote:=0A=
[...]=0A=
> Just to be extra sure, I checked this again. Since for zoned block device=
s the=0A=
> mapping of a target must be zoned aligned and a zone append command is al=
ways=0A=
> fully contained within a zone, we do not need this check. The stacked lim=
its and=0A=
> submit_bio() code will fail a zone append command that is too large or th=
at=0A=
> spans zones before we get here.=0A=
> =0A=
> That is of course assuming that the target does not expose zones that are=
 mapped=0A=
> using multiple chunks from different devices. There is currently no targe=
t doing=0A=
> that, so this is OK. We can safely drop this patch.=0A=
=0A=
Yeah I think we can drop that one.=0A=
