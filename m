Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E84CC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0273E20855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 19:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="UEhExwlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0273E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeK0GcR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:32:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35283 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0GcR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 01:32:17 -0500
Received: by mail-io1-f65.google.com with SMTP id u19so14950380ioc.2
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 11:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Z7/J3/XsHVbNKck4ATblMNLdXF25k68A8MLeEe5iJE=;
        b=UEhExwlvmQGEj8mStrA+2Jja3bFGdGkDozUimCD938z1eSMCmwP2E85H00vzoax5QG
         zsoS4ncy6M8MYm0tFBAGnbDFOGwlIE/DLdHoZYVLVPB8+Jl3PyXpai2SWUkRFHmP0Mq2
         GXvNjC0geBZrcfIePRzG+axeFNvq7N2mh0cUKGg6/Uk15TlFYRWyc/1XeN41nPN6zULA
         Lplub+4s+qF60vJUWAWBiEXvC/RzuUGC3aNsRwAZ1HL0RKxpiwG+joWzos78MgjoQGPP
         maUxKmQcOY93OSC77Av/z+Xis5w0knGXYCGKrq/xgNwl3zImDQOehjH07ARPZP8CBr/C
         mmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Z7/J3/XsHVbNKck4ATblMNLdXF25k68A8MLeEe5iJE=;
        b=BSZWWJLt5Ceu7OdmS1NW2khveHaTEhXlODjahcj8cEHID91HquaxTIpuaI9FpXZH8t
         VYt5LZ7s3u+RkOvWN5DMUCWtp57oT3XTNC7s29ny+jYl3Bx2YdLAUBiZsX9lyMi9X2Es
         AwgCQwz12vKGSlw+OMmplYVH1iLXFH/bZXpISTBFezik6OWnjSd0X77YnKcs1pNc1xaB
         nEVuQ7qmQleZEsYa/EnBWi3/TxE6d5pbCwZHF5N9Jn17TjaOq6kix82sVdrgh9aexoG9
         m5gjWZzigqrOwEPbuuYxE/qQN9g6P+PcqlT39TjXwUNI3bUxsh3ZSRqSu4IZ5oUWRBEw
         fGjA==
X-Gm-Message-State: AA+aEWbuRvu5Np9eNlKcOTDNTZ9WmAqnt9u8OG7XCdNs4W4zLOkS8OQF
        871a1/yp7ywXcCETKWNBStMmKIDi2xU=
X-Google-Smtp-Source: AFSGD/Uga4KUckvTU83rmsDAcnB0E9dD3IWf1IzKmKEddUpWfKgN+J7G+4PDdNSEFzmi0AvddqK0mA==
X-Received: by 2002:a5e:c914:: with SMTP id z20mr21588143iol.72.1543261028066;
        Mon, 26 Nov 2018 11:37:08 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:fd28])
        by smtp.gmail.com with ESMTPSA id w16sm1000581ita.38.2018.11.26.11.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:37:07 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:37:04 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add use of logger so that syslog files show
 when each test starts
Message-ID: <20181126193704.GC30411@vader>
References: <20181029161557.7652-1-tytso@mit.edu>
 <20181123010221.GA6311@thunk.org>
 <20181126175057.GA30411@vader>
 <20181126183211.GA31885@thunk.org>
 <20181126183723.GB30411@vader>
 <20181126193129.GB31885@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126193129.GB31885@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 02:31:29PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Nov 26, 2018 at 10:37:23AM -0800, Omar Sandoval wrote:
> > 
> > Hm, what if we output it as KERN_INFO?
> > 
> > diff --git a/check b/check
> > index f6c3537..9b4765f 100755
> > --- a/check
> > +++ b/check
> > @@ -314,7 +314,7 @@ _call_test() {
> >  
> >  	if [[ -w /dev/kmsg ]]; then
> >  		local dmesg_marker="run blktests $TEST_NAME at ${TEST_RUN["date"]}"
> > -		echo "$dmesg_marker" >> /dev/kmsg
> > +		echo "<6>$dmesg_marker" >> /dev/kmsg
> >  	else
> >  		local dmesg_marker=""
> >  		CHECK_DMESG=0
> 
> Still not working, alas.   I tested it via:
> 
> root@xfstests-ltm:~# echo "<6>testing 123" >> /dev/kmsg 
> 
> It still didn't appear in /var/log/kern.log
> 
> 				- Ted

Ok, well that's my due diligence, so applied. Thanks!
