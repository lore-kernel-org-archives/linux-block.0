Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B313C83003
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198812073E
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 07:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j88DNZVD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TB4lG5wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD2Hgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:36:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44652 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2Hgi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588145798; x=1619681798;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LAS6uuBorisgxYDYDSzzv4tQFvNcWiIaWAc800VmcyM=;
  b=j88DNZVDA33wsgRcQxirQICOnM69RpRu9HjUvOf42SBwBySvAIl9mWEK
   h/gjqr65VXGmXqQpyxqGXpAxEJgcX8sZKYroOukhWqUX9bBR9rLEvR6rz
   qVdq1ff2Ka1Fhk4ri0MF7r0VxYnHOBIXObzrfeCFlgWzrz3Tu47DoqA4f
   QInlD9VQOlwmKE/V4mQ7M0MWCIaL9ZLF2PCXjYThd4AqWrMajrjiXYRgy
   p91aNyhxSgp2gEZJ9p28ATLCadtEM1NbwXGBtTo6EyXmVBjn4aMiROMWK
   UXc/reEkrdi3jHE+fT3ruoKUuzJq3b4NiP8wz6Jby0+nwDxWJhMErOluP
   A==;
IronPort-SDR: QaMRmuRCPoETnFY9is54Hj2ZI1hEat+5rB+Aa8urVPkRYt0qJuQ+oVmUWPpe+5mVDvBiDtZMcU
 G8DezoBSNJhU6VN98IsGRCzDg6P39bvehot2HO/ppfT49yk5QkRvIRgzzqc2mS7rW+To54Xzya
 x7ssqj3/VrQEXwPu1yGToDtce6J+nMdCozEuO5PwgCVXPkyxivVEuSZx/+yqAPt4a/Qupcu8ZS
 93v0EJZHwhJzQ47fiivx1qFx8leEQ7z8dWcSsV3Md2aFvgAsCSnGlWlamzlgNyyAksIJl1o7sx
 L/Y=
X-IronPort-AV: E=Sophos;i="5.73,330,1583164800"; 
   d="scan'208";a="137884742"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 15:36:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PozxSzeXmWBi7jnWmTGv1p5qj9ImHNp40tnH9z2C2WEVv1qpWFBW0f4+KK58O4pVDkHBVXijfsUnPXrvewLnSjBPxTGbgO29FbP4imKp2InVlTTKzedjgByLcAc+0bGcPGz4NqXNy50VUMXg+BqF1ZmNxzFAwmtJsaC55vGhyE2UoO49FzxhJN52P3rEO6tFiCl4692BTYwTjakZCqD7slsf0ovQsEsh98mfB76oIa70BkQ79PvW7nqQypff1N9zVEuLZIKNFV+Lp1DEAuThxitk6/CqMVn+X1uuWSY5ipwqOnOmY1VwMS0UB3o48jInOeW0rboZbFVj7N0gmae7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAS6uuBorisgxYDYDSzzv4tQFvNcWiIaWAc800VmcyM=;
 b=XD62p/DpAHmqTKWhmtRennwPt40clnghd6oBMSzvu9duik96+0f8Nb4XqBamhbl8WvYoUUuAu90F3fJL5aTp4YsIzONHeF9cTZOPVg7OecFiiyg8wpYuqfjiMvQaodWYF4iJSbigj3x3Oi+1u6Xtm2FpT+xoKscq0bkO0xd0JT0nSXIQt7tWmZWC9uM9LWQ3L8Kb5ZAX4lRy47VeK0JoPuiDHlMyWsfiTIpRZ5A+acaUKGdtTnFiwCVgsQLIaZgBGAw+K0q8vqvE8qICsO00/NYbvY6BuSlxOhoT+cZRQ13MOXRacrX/yywxeCPsAchdDU7YLh4H8I8Rey3Mc8u/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAS6uuBorisgxYDYDSzzv4tQFvNcWiIaWAc800VmcyM=;
 b=TB4lG5wWgY04tPbOz39P0HiaBt9kX17dQDqTgGPGrlN7WFBX3E3FVyceBzdrtFRyVLCl62kXqPdCfvaUPkfa6LXorWSG0liLMArfKhuw+AE+R1R4Pll/KR3yy9YwlfnIrzGpGtBMb3BTykDFaGHOp3GAraEe1bPT4aEdnKeaWps=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3533.namprd04.prod.outlook.com
 (2603:10b6:803:45::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 07:36:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 07:36:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/3] block: move blkcg_bio_issue_check out of line
Thread-Topic: [PATCH 2/3] block: move blkcg_bio_issue_check out of line
Thread-Index: AQHWHXxRKT7Ntgf71kurctAEAUiQqg==
Date:   Wed, 29 Apr 2020 07:36:35 +0000
Message-ID: <SN4PR0401MB359865305C85EB6DA6C81D8C9BAD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
 <20200428164434.1517-3-johannes.thumshirn@wdc.com>
 <20200429072526.GB11410@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5b86d24-97a5-4aab-59aa-08d7ec100ba3
x-ms-traffictypediagnostic: SN4PR0401MB3533:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0401MB3533F1314579EB1A9878791B9BAD0@SN4PR0401MB3533.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(9686003)(91956017)(4326008)(66476007)(66556008)(64756008)(66446008)(76116006)(55016002)(52536014)(2906002)(66946007)(186003)(8936002)(478600001)(316002)(54906003)(71200400001)(5660300002)(86362001)(6506007)(8676002)(53546011)(558084003)(7696005)(6916009)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8zf/1YelORGf31kJ0RwP4HZPVyZiADQHg/b0G8l61tqCIMQs2y19ZdBxpNJWH7Xaje85G7hUsLlnbchCZNq6GeHbtvFpwUJg9V5RNgHc6u7YwAmRaTGuZqa/9zIKrbZx5ecEVYRoqLuOaTwuOyH3ONtG+8Q8+FbFgZAAWiJNbEveSWtFLNNyQBNUYYKlqmbT18SXuPSRvx5HZKtWQQ0wlbo1zGMoxY+XCaAbkUNWG1d81DAHAgmb6/s1Nar+llJKh8rFWm+/RX+cVn3mVyHBKntOoABeV04wX7ZDjwzBs1xfXFyr/VhUSL13XEuAL8e8pv3pjYijGpwmZ4OFMi4dyGPW4K5SPJ4zLt66sBJe4kct0aluZXrj3G7EAx9uDRCa2AD8i8613BOa42yoGxh42J2K+Cn7IFbIGkOky9CyReYv+4DfYdRD4UAoEfKV49m
x-ms-exchange-antispam-messagedata: fhMXyVj99j8GGh6X2EpnTKFj0jz5IDzR3sLeIZaHGcjPahIIsWBgzEKI6z34pXahmNCvgG4Z+FF/IBOF/yrwJCxQLbqLcZJHMSI+9w6XJYdkMmaYKShGJ/EYhVVHNgepCkoiuzeMob6FqWeENXxdqTqkfuVByiodShsElEITWmNEuqOoEAsHz4Ap5HcS9UcKLKE5DPToHmDjfXLkqJt4k2smAkbaNJzrq+H2sK99oM6Ry88WMSlqtkvbfkrjfb9Qr0T1HFS7eOY2jUUjm4NUnKHli2913yVLl0lag8hDRdphC+mLBW1vIT1iHeu41j8tpvdq/jz73xCB+jn5osGMbhD33lq4Skf2PgP1t033QFCsP3wTrzHzYAOscAZxHxD1ftxYCytmZNFsu7aTGssrNeXKBjstG2vIT+5KZz7Cjh/iH8YSg9yKvdOnf+bwHUM3hNEGlTgYtHwrWpOLNMxhdExCx+l05V8zcHbtdD67Fu/p784wd3Da43NDBdp3GTdxCITMZ5MHLymzn5loOId/xcUf6BJ3kiI63TNvoW9n27mjG6gfv28KzKgLdSohkKOZVptuhsSNjqsC0cR+MtXskyXKdJgfGOG20RmoKmEqOhIzfVgamzYESv41+B8quqAdEPhccaOfBlEpmbDM/qQYDa5QLwEJqCAoKK4HrntiEZj3TFG5+Ym4iOHpcpNOtVgeUdTn4wMhxxn6UxdU1Vqy8J0R6Tl0FI8bqLcCrjtgZkmqgXi7yCPZTEuYYP7wDU4ApwvuS2T8rHsMF4+Zzk6XvooaGCGQ84UKoejOQkpx0mI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b86d24-97a5-4aab-59aa-08d7ec100ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 07:36:35.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuKi4qf6pJhNiz1zERFN4JJDHjMQwKLxS2gkm4cTXdOlRV7txsX77IiMV6FqPTAyTru/vl2au9mm10bKoZDtUjeTeRPRKU1g5Aql3ENzupQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3533
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/04/2020 09:25, Christoph Hellwig wrote:=0A=
> As-is this will clash with my BIO_QUEUE_ENTERED cleanup.=0A=
=0A=
Bah right, I'll re-base once Jens has applied your series.=0A=
