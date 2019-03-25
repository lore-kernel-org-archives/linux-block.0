Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8ABC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03893205C9
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ZFOY5/mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfCYR3r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:29:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45220 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYR3r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 13:29:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so270163plb.12
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JSx+go3dmB5j+S4St6U17hPWLt7L0+31zL6nKl2cjws=;
        b=ZFOY5/mDF/n5umqhGdDaZMCwkwDuMlS4DdhXYLr47BIg9KAv6DkOVmajG0apir4ZL2
         AzyGJPjaqgeVgS5Zg0QM9gg4aPsasOiOHGCPMeqeUhjoPDTg0ZfN8srUID0tC/FQSART
         rgvIXl1aAFR4wJ7O58K0UOsnyvDv//yUX+c0Zdqz9BmXDsEpVv3m+xcbH8GasCR8pedT
         QGKJ0Rby1uWjYLOuXSK1SHgdriNBgWTRqLYN/8sVIyQ/84NIqaZAuxaV+MLD32fctcIk
         D4VPO7Z08VjByaKo7IqsW3ME+AbdB+OYbgTMSsON4u9V60slhhRFuwHhOoM0wU8l/ZVc
         e0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JSx+go3dmB5j+S4St6U17hPWLt7L0+31zL6nKl2cjws=;
        b=c/f/xNE2lDaDG3kh4My+KtdF7b09Ozm630OA+YF25nNoZJjIWBBRdESZGTL7Y3HuDy
         JAOHXP7XT9/+GCrEMxVp86t49vx6QuHOyqUk9XTM+SvFZbbndXnd4PvbmetvwYugBPGH
         9JNiaE38In/LRfm06t+kyCZziBoEk90I/MJRRcs87OPJPGx98QWbAwLwPt9oIMsuhlYw
         ePEi9BeMUGLhzvuR/nFIjpsr9FTBSUkMyaEbN/+3quL3qiCa+EdkKXCD61WilbMGUfop
         VcxvqOtrjyRTSoP+xBHuYCsCI4Ug7eqMYcKSCTUP+9lR7uW4e0QNHhzmCGXmQyzlHX2i
         BZXA==
X-Gm-Message-State: APjAAAVvypkGpC0/eJRPvoMUOEQ16MDb3xcJY0NtvySfkARKwzsf7Bw7
        0uPx766sBWjGTkNA8eBVyzRNOQ==
X-Google-Smtp-Source: APXvYqw0p1kJehe1hvAqvdX94ts/kI/jvdJoEBsv+Ov3sousUyyqK0XMT9lfTCQLe7CnVOX2OYCZ0A==
X-Received: by 2002:a17:902:1347:: with SMTP id r7mr26328473ple.82.1553534986201;
        Mon, 25 Mar 2019 10:29:46 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:b619])
        by smtp.gmail.com with ESMTPSA id d3sm4740351pfn.113.2019.03.25.10.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 10:29:45 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:29:44 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH V2] blktests: add userspace IO test
Message-ID: <20190325172944.GA5826@vader>
References: <20190305015026.10751-1-ming.lei@redhat.com>
 <20190311205505.GC1315@vader>
 <20190321223626.GD20838@vader>
 <20190322010453.GA2913@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322010453.GA2913@ming.t460p>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 09:04:54AM +0800, Ming Lei wrote:
> On Thu, Mar 21, 2019 at 03:36:26PM -0700, Omar Sandoval wrote:
> > On Mon, Mar 11, 2019 at 01:55:05PM -0700, Omar Sandoval wrote:
> > > On Tue, Mar 05, 2019 at 09:50:26AM +0800, Ming Lei wrote:
> > > > Add one test to cover changes on block passthrough IO interface,
> > > > such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
> > > > and blk_rq_map_kern().
> > > > 
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >  tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/block/029.out |   4 ++
> > > >  2 files changed, 115 insertions(+)
> > > >  create mode 100755 tests/block/029
> > > >  create mode 100644 tests/block/029.out
> > > > 
> > > > diff --git a/tests/block/029 b/tests/block/029
> > > > new file mode 100755
> > > > index 000000000000..c7c674464285
> > > > --- /dev/null
> > > > +++ b/tests/block/029
> > > > @@ -0,0 +1,111 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
> > > > +#
> > > > +# Test userspace IO on NVMe loop device
> > > 
> > > This is still missing a reference to the patch it's testing.
> > > 
> > > > +. tests/nvme/rc
> > > 
> > > Shouldn't this be in the nvme group?
> > > 
> > > > +DESCRIPTION="test userspace IO via nvme-cli read/write interface"
> > > > +QUICK=1
> > > > +
> > > > +requires() {
> > > > +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> > > > +		_have_configfs
> > > > +}
> > > > +
> > > > +__test_user_io()
> > > > +{
> > > > +	local disk="$1"
> > > > +	local start=$2
> > > > +	local cnt=$3
> > > > +
> > > > +	local bs=$(blockdev --getss $disk)
> > > 
> > > This still has a ton of missing quoting and shellcheck errors.
> > > 
> > > I fixed all of this and pushed to
> > > https://github.com/osandov/blktests/tree/user-io. Let me know if this
> > > looks fine and I'll push it to master.
> 
> Yeah, it is fine for me.
> 

Thanks, applied.
