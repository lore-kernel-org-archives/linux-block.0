Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B380AC432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A412070B
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gl28a1+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2PCm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:02:42 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:26456 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2PCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 10:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575039761; x=1606575761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FBmcn7qg/GoPD9g1g6BUkkjLeolf0VTqzn6bihHReQU=;
  b=Gl28a1+EPMjJAmJ67a7w5DikIKR8TSBzJGvAGncv/YjSr47s34+auMhm
   is9iYWk7l3TO2L3URfx2ID2KO55qOwKeI9cvKzdLMxo9VjzIZhBHP1WjQ
   wbRuI+lFTJmk359HbRiOyLzi4DH100wp5a+hc5fQEO8ePAkDOBJRyzsD/
   c=;
IronPort-SDR: Rf2O4UJ4AzwTF7t1/MajgDmbDCYYpaYTzE3dDwNd4Aw4Xf4LrbC4jyRFXCA52lqF6qCA9tdalw
 8WNtgjzbiKlQ==
X-IronPort-AV: E=Sophos;i="5.69,257,1571702400"; 
   d="scan'208";a="5434371"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 29 Nov 2019 15:02:40 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 461FAA1F12;
        Fri, 29 Nov 2019 15:02:39 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 15:02:38 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 15:02:38 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Fri, 29 Nov 2019 15:02:37 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
 unloaded
Thread-Topic: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
 unloaded
Thread-Index: AQHVprr1wqXBoNh5XEupYuifQUpCwqeiPekAgAAAkLA=
Date:   Fri, 29 Nov 2019 15:02:37 +0000
Message-ID: <f06bf1967bdf43ca9b218f9b5c5202a6@EX13D32EUC003.ant.amazon.com>
References: <20191129134306.2738-1-pdurrant@amazon.com>
 <20191129134306.2738-3-pdurrant@amazon.com>
 <20191129150006.GZ980@Air-de-Roger>
In-Reply-To: <20191129150006.GZ980@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.244]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Sent: 29 November 2019 15:00
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; xen-
> devel@lists.xenproject.org; Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com>; Jens Axboe <axboe@kernel.dk>
> Subject: Re: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
> unloaded
>=20
> On Fri, Nov 29, 2019 at 01:43:06PM +0000, Paul Durrant wrote:
> > Add a module_exit() to perform the necessary clean-up.
> >
> > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>=20
> LGTM:
>=20
> Reviewed-by: Roger Pau Monn=E9 <roger.pau@citrix.com>
>=20

Thanks.

> AFAICT we should make sure this is not committed before patch 1, or
> else you could unload a blkback module that's still in use?
>=20

Yes, that's correct.

  Paul
