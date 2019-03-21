Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E18C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 22:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9184521916
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 22:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="aqAnWfHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfCUWg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:36:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33814 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfCUWg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 18:36:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so62171pgq.1
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2019 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ICe7QMcaU3x8QIEN3l7pLRCE7ir/8kndfymx86Vu2Dg=;
        b=aqAnWfHPYVTv1UlPzqmU9OWej62b88Yaxb4pNzleWL48mm7ImV2ZxM5IzHk2kmw7Xt
         CUsXeCnIj7WHqLfa1zDfOCTJDdRvVhnStFlcK9Ag1ZpdkjLcCZa+j4rJHpdmDZVpI4mC
         RKEYhUduwihoJg7YeIH+am6SIyu8CcjdE3GA94UHfB0mGjwu+HosHLio1IkUz2Jp1T8O
         Q8xmmdpbdnYEnUISR5IOtK07Vwvn5mkD4lXhA2awOeIqbJBIbsIwC9P8tKMjYlbSbp06
         qUk3C31YGPWi7Kmv9dLfrIm/RmPTVhO07328dzrBbvfcmco8UMFQaPP8zT/8SDjGtlxv
         ro5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ICe7QMcaU3x8QIEN3l7pLRCE7ir/8kndfymx86Vu2Dg=;
        b=uAPwYUKGRhTaHFNPkdf173ecmoyEHt2kpKINhzfK+jTwsCdvPD8Bf8qS9A2gV3DdyO
         +N2taE0x68BQdFBtfy++wiysZGpl4gINmeU41CpPFcXdp/xFnlTbwvtvohsEmIGv5vSy
         Us9wuA9RC88ZgaZt26id3UiUiNS9PrNYrTDqb6QcG4/fGHVnoWhy2d8/ifupyTybrYyL
         CdXgYvFc7NlmKwx22O+yGuy7sD7ks430Q1eKHGyjWN1oA2Vz4jXP2ZzLG8OSoGg7icAV
         sBvyqqSHOdgUDUg7XGBCGndTlDTKl0A6sNURY2KFwOWasW72hnipqTQvPnk2nloJ641S
         IhkA==
X-Gm-Message-State: APjAAAWLbwbouCvVKO/GUN6HqJ3KpNHgwPm+w4CVlBOEdScHUkUfuZRP
        8RTrSydfGc3c7vhSwQ49gDPZkQ==
X-Google-Smtp-Source: APXvYqyu/aJDHU7saTs9Yb1HKXNN/tPsGL0m3wilKZAxghu4VqneGSaoR+vVRF9xZKwGSMw3WXaePw==
X-Received: by 2002:a17:902:20e3:: with SMTP id v32mr6035250plg.213.1553207787447;
        Thu, 21 Mar 2019 15:36:27 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:1643])
        by smtp.gmail.com with ESMTPSA id z124sm13757898pfb.150.2019.03.21.15.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 15:36:26 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:36:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH V2] blktests: add userspace IO test
Message-ID: <20190321223626.GD20838@vader>
References: <20190305015026.10751-1-ming.lei@redhat.com>
 <20190311205505.GC1315@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311205505.GC1315@vader>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 01:55:05PM -0700, Omar Sandoval wrote:
> On Tue, Mar 05, 2019 at 09:50:26AM +0800, Ming Lei wrote:
> > Add one test to cover changes on block passthrough IO interface,
> > such as blk_rq_map_user(), blk_rq_map_user_iov(), blk_rq_unmap_user()
> > and blk_rq_map_kern().
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  tests/block/029     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/block/029.out |   4 ++
> >  2 files changed, 115 insertions(+)
> >  create mode 100755 tests/block/029
> >  create mode 100644 tests/block/029.out
> > 
> > diff --git a/tests/block/029 b/tests/block/029
> > new file mode 100755
> > index 000000000000..c7c674464285
> > --- /dev/null
> > +++ b/tests/block/029
> > @@ -0,0 +1,111 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (c) 2019 Ming Lei <ming.lei@redhat.com>
> > +#
> > +# Test userspace IO on NVMe loop device
> 
> This is still missing a reference to the patch it's testing.
> 
> > +. tests/nvme/rc
> 
> Shouldn't this be in the nvme group?
> 
> > +DESCRIPTION="test userspace IO via nvme-cli read/write interface"
> > +QUICK=1
> > +
> > +requires() {
> > +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> > +		_have_configfs
> > +}
> > +
> > +__test_user_io()
> > +{
> > +	local disk="$1"
> > +	local start=$2
> > +	local cnt=$3
> > +
> > +	local bs=$(blockdev --getss $disk)
> 
> This still has a ton of missing quoting and shellcheck errors.
> 
> I fixed all of this and pushed to
> https://github.com/osandov/blktests/tree/user-io. Let me know if this
> looks fine and I'll push it to master.

Ping.
