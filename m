Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA59C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 22:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698732146E
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552515136;
	bh=ydH/zf9ssBZtMkDR7HDT1bipp6FYU7iB7LX0U3m5AUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qg2BQEpwYnOXPr1uv3aLlN4HjkI3LdnMQ08La8Tup942ALzVPEgHi6T+QaUn7YPsw
	 h7cLQxSIOcBeSXmzDUC1nb4B7zv5JRU9knH2/t0hXrUdEdPHhlYshXXJMZVlFhS0DM
	 4p83iFLNuRSJG5rkwXGEwk+ur1dlSScWLHF7ygEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCMWMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:12:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:52044 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCMWMP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 18:12:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 15:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,475,1544515200"; 
   d="scan'208";a="140547387"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2019 15:12:14 -0700
Date:   Wed, 13 Mar 2019 16:12:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] floppy: fix harmless clang build warning
Message-ID: <20190313221257.GA15153@localhost.localdomain>
References: <20190313211433.4178148-1-arnd@arndb.de>
 <AT5PR8401MB116964D0C90783A164834C2CAB4A0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB116964D0C90783A164834C2CAB4A0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 13, 2019 at 10:01:43PM +0000, Elliott, Robert (Persistent Memory) wrote:
> > @@ -3899,7 +3899,7 @@ static void __init config_types(void)
> >  	if (!UDP->cmos)
> >  		UDP->cmos = FLOPPY0_TYPE;
> >  	drive = 1;
> > -	if (!UDP->cmos && FLOPPY1_TYPE)
> > +	if (!UDP->cmos)
> >  		UDP->cmos = FLOPPY1_TYPE;
> > 
> >  	/* FIXME: additional physical CMOS drive detection should go here */
> > --
> > 2.20.0
> 
> On x86 it expands to a hardware read, so this would change the control flow.
> 
> #define FLOPPY1_TYPE                                    \
> ({                                                      \
>         unsigned long flags;                            \
>         unsigned char val;                              \
>         spin_lock_irqsave(&rtc_lock, flags);            \
>         val = CMOS_READ(0x10) & 15;                     \
>         spin_unlock_irqrestore(&rtc_lock, flags);       \
>         val;                                            \
> })

The end result is still the same, though. It just doesn't read the
hardware twice when FLOPPY1_TYPE is non-zero.
