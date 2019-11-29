Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CBC432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370AA216F4
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 15:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="X59K6+dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfK2PHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:07:20 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11162 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfK2PHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 10:07:20 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 10:07:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575040040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0rFRPWgFoCoXHpD5aUkY0O2cDWq39XaQXIVJvAvRnsg=;
  b=X59K6+dSrxt89CZYgmSHp15Mp/OzWzCrJlH/L4syHxXlOO4op+8WX4ba
   ZVYLCZJ3+tgJ5BxucF5ek8Uk2WPFVBxJghKRZUR+s5XgDNsNtQoBxF176
   CbS02i0FvCePKSGrK6CQzA4NdlWg0QQ3D9K71S8k1SHcDDi3w3mfVwc/U
   c=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: uBLaSy9gdKqd7c8q6oQXhHoNzphxqnX5FXZDO5cTbo3sg4/fdD6hKI6Tj6BkfSHBbu7gc5Dcv1
 puKQUAEc4OPm7xMTzT/NWdB+3T59tPXuxHwt2zsEdH6XyhS2qiLozezQ46Wx1CuBuKnpKPc63x
 +JPcrfykPSLELLL3ABg4NXdTQqipqNNyes/zN+RwP/LhV28Rh67mxAbUt21+H/LoAA9g1PufmV
 aHeVBsVbmiiEBG1BZe/2M7WJiygShEQclQaVlTOADHB4Z6HhQ9R+fHK4yH9R6OErJIKJH7mUPD
 lDs=
X-SBRS: 2.7
X-MesageID: 8983823
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,257,1571716800"; 
   d="scan'208";a="8983823"
Date:   Fri, 29 Nov 2019 16:00:06 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/2] block/xen-blkback: allow module to be cleanly
 unloaded
Message-ID: <20191129150006.GZ980@Air-de-Roger>
References: <20191129134306.2738-1-pdurrant@amazon.com>
 <20191129134306.2738-3-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191129134306.2738-3-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 29, 2019 at 01:43:06PM +0000, Paul Durrant wrote:
> Add a module_exit() to perform the necessary clean-up.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

LGTM:

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

AFAICT we should make sure this is not committed before patch 1, or
else you could unload a blkback module that's still in use?

Thanks, Roger.
