Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D82AC2D0C6
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274D20828
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 10:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="EebQ1jgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLJKV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:21:57 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:24439 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJKV5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 05:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575973317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4PhE0mOGPD1zWZASbQ5CWdp3IZVaRYiYD5CdAezDIzg=;
  b=EebQ1jgiepeEgkAhPB1OXJjmDCAqe5oarwxgCPAkX9gFRup0fr9bUy5v
   XGfZFw1i+P7ME171ocHatDwqpFLUmP4w+1x9u5HeLmCQxFv/7EhAYTdUN
   WY7mGAJGqI4n90gxG5FrCg1mtAlav782SckEslFwTJVJTJ7s8BW6eB1Zq
   g=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: J/Qwc1MLS8uzoplHZItR93vbDIMgnz3emkOpUjrWj9JL23ADQcoIho4tYn5tjdu3JFCBTJ+W8O
 plARZAwoIRJqT0bZ0j1l8NTrKDrhwiDWjQocq8hGJMx6uguvE+U2nXB0bJDEFxebBkMyT/IHKy
 vW2udoFw/dOZ73cpw1J3BTTq1J0jnFgFkBlE4Ml+e85k/r5MyvH8pHxgNzxGIy9dDsek/H23Ax
 TdqTP9EV1nylxtyI3d5TOYZiKYwVR5shwFf9FQxGQE2H79Dppbs5/4u8cj676sEe2NXZwNFvyV
 2vs=
X-SBRS: 2.7
X-MesageID: 9447992
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,299,1571716800"; 
   d="scan'208";a="9447992"
Date:   Tue, 10 Dec 2019 11:21:49 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <axboe@kernel.dk>, <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        <pdurrant@amazon.com>, SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [Xen-devel] [PATCH v5 1/2] xenbus/backend: Add memory pressure
 handler callback
Message-ID: <20191210102023.GF980@Air-de-Roger>
References: <20191210080628.5264-1-sjpark@amazon.de>
 <20191210080628.5264-2-sjpark@amazon.de>
 <20191210101635.GD980@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210101635.GD980@Air-de-Roger>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 11:16:35AM +0100, Roger Pau Monné wrote:
> On Tue, Dec 10, 2019 at 08:06:27AM +0000, SeongJae Park wrote:
> > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > index 869c816d5f8c..cdb075e4182f 100644
> > --- a/include/xen/xenbus.h
> > +++ b/include/xen/xenbus.h
> > @@ -104,6 +104,7 @@ struct xenbus_driver {
> >  	struct device_driver driver;
> >  	int (*read_otherend_details)(struct xenbus_device *dev);
> >  	int (*is_ready)(struct xenbus_device *dev);
> > +	unsigned (*reclaim)(struct xenbus_device *dev);
> 
> ... hence I wonder why it's returning an unsigned when it's just
> ignored.
> 
> IMO it should return an int to signal errors, and the return should be
> ignored.

Meant to write 'shouldn't be ignored' sorry.

Roger.
