Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B63C4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D0F2399A
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZL3ZwePx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVOqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:46:15 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:49512 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIVOqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600785975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EmRqnwZkNjgmrTlp2NTYJohV1w/jVZEYxakF+X9OdtA=;
  b=ZL3ZwePxjLovCuXSRSRQbmY8Zzgi5DvAI9drEXyM+SLFzMBGfOMiRX9n
   z1M93P/kigU+OWvuuwZt1lUD2WHjF6sfP8FrixhafOACTcVw1J9q8WomW
   JEZackzI8ZOoTFk2QQuQhfBG36i0KebNN6jf+atpSMir6VosSPm1v4YY/
   M=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: hIkNa/LVZnMu/m3flefxEOm5p2LEvNpZm9vQF2cgCY3qmLAaucY99PGGuxjucQnDOnzrYcqjf9
 UrUGpN7u83iK25IeZcn/TPhDA2cLJuL70GJKzwGIxnR892Ix45R3jErAUD/tIFYx9KZWf5vEpE
 2WQt6QRyF+zZGnJlC8cjn1+D+6c/NgT2c8oxstwNWnEjkxFZq9pEBK8fiu5kf2cU/zS8kCbkn+
 Q3UIyDTdb9Axkw6l3DMqeZ4NhofBEBCJ/AkQdeJJPyGPm+7XO7PHusiFkaWlzluOySeRwM4vn1
 m8I=
X-SBRS: 2.7
X-MesageID: 27271531
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,291,1596513600"; 
   d="scan'208";a="27271531"
Date:   Tue, 22 Sep 2020 16:45:56 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <konrad.wilk@oracle.com>, <jgross@suse.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] xen-blk(back|front): Let users disable persistent
 grants
Message-ID: <20200922144556.GM19254@Air-de-Roger>
References: <20200922141549.26154-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922141549.26154-1-sjpark@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 22, 2020 at 04:15:46PM +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Persistent grants feature provides high scalability.  On some small
> systems, however, it could incur data copy overheads[1] and thus it is
> required to be disabled.  But, there is no option to disable it.  For
> the reason, this commit adds module parameters for disabling of the
> feature.

With the changes requested by Jürgen you can add my:

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
