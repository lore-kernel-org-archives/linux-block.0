Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8AC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D846206D7
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LJVNvpz7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Zu3/T2Wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgD1O0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:26:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52182 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgD1O0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588084034; x=1619620034;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PTz2zdztB9U7ZgamPBp5fa/Pperhas6cZq7IyMBAuO4=;
  b=LJVNvpz7yPP9+WKEg4Ptec742112AfuWaWo6ERY47pr6j8dbsLyyGg/4
   ROERLhikbgkGdkYtz0vUqU3ywG9GJnxF+3img7bpPwUiq6ZgW6TVQCykk
   t5HECCw55GR7X9epbqYwah0zz3ophbiuy26w3dvdzCCbtW9hoAFIUobO4
   zQepv35VMpWMhsj9lgKo+WmviH0OHGr6dia78aCmkpbvJTn60YItji7+W
   RiGRijZO+LerxPOX8bO4jGAgsoVNLAtRFpXC9Sgme48HTU/iftKvNh1o5
   +qW+revsGaIg4iKBEa9DOQFOJtRJ0m3Qofa4iALheqjaJBwJaPu2mB8FH
   g==;
IronPort-SDR: pWVPRFn2SjGVWCmO66aby25/Mh9F1lTTzb5dgh4JFYTXUDsM8rZ+ioxXTxToJIRVsuvCi0NUsV
 ZbjyMfZOnkwLgSS1lf400RUmfNOk829P2S1jwJ+3/iYT0DReVYBceXoSgCvGxY3kdG9K7x2qcC
 wBJZJXfjNIcQp4Ueno+f6/piVlBKts5HusTbP+GpxmxNReQ0OjLw+OrFHUmzjdh3svf6F97+uC
 cO1U+NtoHQYGrvpEzW7qls5WgelxqsA0sFkS5noxocqijuunkCOYJgqz0AcLxFejg/4UfNG1yp
 Ens=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="238910333"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 22:27:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9CtpKezyOjH2v9DFwxNKFQ/Mp1cwW8qRoxTLaSJU7Ngun9C4ZqvpwlK9zUqkOVY+4XovWXXPzpQp07Q2PxFZETxqJqMxGDHRriucQUdvDn4AxYFIxDuvGuw0KycalAQ6oetzlWcxIP73VbdYVDsnrCHK+mY+WkoDGG6nLpzaFUn0GgnqG0Iby/w0fTty1uEE2jstThqYTrtL/AzzTKE9YNcHVxvRLCjiWiqvBDTPXZhfJh+njIdupPzCx7z3oUKNgBO/IhHTP23joM9A8qihyb0U2qV1mFPq/XFC9SfxLFU1M2De7yKmqVU2YqaL3zgN0yIkAEGzvNug7e9rAuYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYkwMqiIhcuhsG3xb+qC8cfFqxk8AyXJXptUamHa8fU=;
 b=FfTaWUm0fl+jSDtIUQTu8YATrCUkWeFTVKlpBKD6GZqrDqg+IlNysgUJS/QPd9wcIuBZvAU4vA8jOLZixnP+uF/627zKjrEWi4fyX8g2cQ54c//Xu4MKyk8VihLYy7kVczWcZZwm2rbpRLWbaJTzhDdvFU80sSM8ZgOVUnxsArKZHevnYLbrCyd+P2Tc/837rNiCUhV3PmtEBEhtdicL+lmVbJMC7tBmgkk32OUQJBg9ogJd4pydRIPWQ6aB6BItYL9uhalhgqHGCMlXuLl6h1Cyg3sTTNInZiIVXGjKf8CkVb4785lIKfzjfOqRYf5KdlF+/38MjNf56UBQKoKB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYkwMqiIhcuhsG3xb+qC8cfFqxk8AyXJXptUamHa8fU=;
 b=Zu3/T2Wlu2bmE9d0PfPvJyb2PPpf9l/R0Serkan4g3L34OguZ+1y5AY6APEriEryYPMrMZCdA8E+Z/gNYzqEwx4jjLbgdXNJw1tKzJ7LPDCbJVZtEtav9psDDTYbJrUxzKLkhH1xyN7Pmes/5ne1e4vTU5MjY890/41P3trtjog=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 14:26:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:26:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: replace BIO_QUEUE_ENTERED with BIO_CGROUP_ACCT
Thread-Topic: [PATCH 3/4] block: replace BIO_QUEUE_ENTERED with
 BIO_CGROUP_ACCT
Thread-Index: AQHWHVAY3CgTxU7Ag0e6wj1uAt5W9A==
Date:   Tue, 28 Apr 2020 14:26:41 +0000
Message-ID: <SN4PR0401MB3598289559502598C35961889BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-4-hch@lst.de>
 <SN4PR0401MB35988020B036B6E1A2D974129BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200428142456.GB5646@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a278131f-87e3-4744-295f-08d7eb802b67
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB3551D59F1B7A140CD57F8D119BAC0@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(4326008)(6506007)(26005)(55016002)(71200400001)(8936002)(81156014)(52536014)(33656002)(8676002)(186003)(86362001)(9686003)(53546011)(66446008)(4744005)(5660300002)(91956017)(478600001)(6916009)(76116006)(66946007)(66556008)(316002)(64756008)(2906002)(54906003)(7696005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zwqHumXxGzG3ThRz7gv82KXpa+6tP/Dn0CL7pOAcMinUrpwlxPxB648a2WL7xfLjfuZ30nH5MZPi9X854d9bMvijn9Fhzx8uamS3nGXpIcjnO36+5BuTIknt/kL43P3aYzJJFKeaB4T8rDXBRAqX8kt5oo/nE95xHmcG4XorcJynjywAuHYf7TLXsC3GpNwhwqI4gx387V9GkFB9gQAzWRBL1kX1VC5n0yq9oFeHt5CL8r/8X+1Y7O55KMbDho3um3mM2sbP8p6u1MrMidLzcbrZNrs3pK4JsqmsKuq0H2IsU7Po8VX/E+1dDB55hTY/mQQ+ZquQSqVH/ebbMjRtpKAZ0I4r+b+pXDIAHBRJvhKBwnDhAnZWHCF0q/CA18vr5/0TDhZmEfHcGx0lJgSoA1ELZxyGAiQrhR7FIaf/l/81h6K86zjBlZpbnXypJQY
x-ms-exchange-antispam-messagedata: 6dqi3xBGVg8ZIPsHR4l5FQUJ8YwdBuN24zKuYpBNZ5FMRcqK73e1UPOrp/F7Nh2o5ltOAT3/Ls+APnTZTpK0gI47vWWPe3Pxz+scFCSATWNdoTBhnevSsjZLVVOoQ/VHKv4B/ArkDGpuEf+fH9adozqr3rghustXVjKTDPHB8tUjViJ/Bq7Nv09LOvaB2S3/KhOvAx27eeNsjX9Ohh2DvVYsv4LISQmqabCl/RsQq/qxtJc1YiDOLlLYPySr0GgVf5ZLdKk2V0c4lvRLKPmEM25bHcHZo+zNgso3XC0LOcnKfeaibNuS5wkUmfNiVah6iH6cJsmb7TQzQUVXkTAh3WjrMWF3LL1Vxv62jhhn/kt+oImUSyHx6aXMfA8r7ZirbVJIbgMUyIMWKym7BsPhccdunytpE3PrllwcPzGKF1NLQLMbqaMAhQNuov+11iPARdm7r780T+mVBLB6C7BjypkVjjG6wZnLbEA9pyLL91FIDSVKrusBRBWc9AZO0b0rQ3lHDOPe3e7CAxiIcFQrrGQy06AP565C7Vs47Di+M/9G0kO/UWHmwnP98DjBEa9/03dgaVf6QXkUYjPJEps6cRBMRLDJWm5JmpYWyN3MvONp4wpAgwoWSoyZ9hTnSQWxBvf/ULh/AmDh9i3wn0XcI6Z7v0tJTKRk4vW6XC41Ctfamh+DjNlWa7ZdrA7wDwKC3GmdD4F0F1LR97nVl2mjMy6C0Vx3qtnFbxuU0mRQeUgsz1EVD2daCm2jgKoxEYG/zTkJ0phGTb92vwqNjKeyTkNOJ/I9o9uKpuag0FgXvG0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a278131f-87e3-4744-295f-08d7eb802b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 14:26:41.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Le1QhY0px8k7mbUkrpW/qJNtjMSdndKl0PqoBvcnc/H3LqKdXUAlKz0XdDzd3Mm+SQoHafcAKXfBneuniqX7fwP1J4hb018EaPenVd39qik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/04/2020 16:25, Christoph Hellwig wrote:=0A=
> On Tue, Apr 28, 2020 at 02:23:52PM +0000, Johannes Thumshirn wrote:=0A=
>> This is completely unrelated to the patch, but why is=0A=
>> blkcg_bio_issue_check() static inline? It's only called in=0A=
>> generic_make_request_checks().=0A=
> =0A=
> The whole blk-cgroup group is just crazy :(  This isn't even the worst=0A=
> part of it.=0A=
> =0A=
=0A=
Uff, sounds like the next cleanup desperately needed.=0A=
