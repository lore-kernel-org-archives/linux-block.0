Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0617C32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4BE20844
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="GPd3YX9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfHMQPF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:15:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42855 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfHMQPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 12:15:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so18312253qtp.9
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ssZ9IUDrE9RcU5Ju4v9zBMeqcYUlHixO9unn3Uaa58k=;
        b=GPd3YX9QRy/ItkwGQMt0A3XCKRFJ5778SuNUPsTaDiCUIRSUiY/cbUk2GpULFaiH+s
         kzZM//M7TDAfj875TcSJJPIChRGH0WmL9W5FU0Z+/rvaUzEU9M5t9w442u4C0qE8QMtZ
         WYnTgJERB2W2BwzFB+3pzYzrc57Hi0J3hja0x0IsHzfeM+iy7PIuR0+lp2vKS1PDtblm
         nj6Kvzm3iXbzZQ0T9cTw9Sb25xQldsap4Q8H8H+uAc6GRu6u8PIPOILoFh+EM1pD3QDw
         mDtz8TAkJ7Ix9TNJ6/XYeaZgVaFfOtd0fASUQ8UKQijXAcsXlhWir9UcWfFTHaQmIgVu
         b90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ssZ9IUDrE9RcU5Ju4v9zBMeqcYUlHixO9unn3Uaa58k=;
        b=US2OaLIEBAHrFCIYxDoult7ipJVkvwVhcjP1UoWVCSSshDgp3f1qka9oCdpsmw7y9h
         mEWK3a1KvlKkqyNz1T+c7h+BZl6Ed1fzetXYP3J4h1uHCXn9uI0JLHNNZCkelGsJAvxy
         CGHyKPS/+k6S+WlH0QZrWh5ACP/Kc61TxQiIrEmTtz5jyIzgUgwlXYC1drJx+FC7OW4R
         SqLeKL8GojVDFb65iPSm9DkHaSc5eBHRyzAMTHPweEDGSJhel8cAtTdDKTW0U1i2pk6i
         1mVjdv1iWLD12+InpvpTO2J+F2qV6Nh3LgwXj9BzqeCQpp6+3jbKV0kqhdafLkqQ+mW5
         1pdQ==
X-Gm-Message-State: APjAAAX+YkeH90pueZo3jvh8Am5MNYBzrCWFVOPucAlP5jx/0iyVuu5p
        wtWRBkW7q6/erTaOnsQhsMJA7Q==
X-Google-Smtp-Source: APXvYqxdrEykWLizxPHnLQvHN8gudnolGMM3m740DDuozTEgpDXUcss1VSeROOYC2MWs0DkaR1i0AA==
X-Received: by 2002:ad4:5570:: with SMTP id w16mr18271546qvy.212.1565712903934;
        Tue, 13 Aug 2019 09:15:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u13sm27619657qkm.97.2019.08.13.09.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 09:15:03 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:15:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] nbd: fix zero cmd timeout handling
Message-ID: <20190813161501.lkly7iqzvzzro3i3@MacBook-Pro-91.local>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-5-mchristi@redhat.com>
 <20190813131357.dpyd5mqbfubqhiaa@MacBook-Pro-91.local>
 <5D52DB33.8070307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D52DB33.8070307@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 13, 2019 at 10:45:55AM -0500, Mike Christie wrote:
> On 08/13/2019 08:13 AM, Josef Bacik wrote:
> > On Fri, Aug 09, 2019 at 04:26:10PM -0500, Mike Christie wrote:
> >> This fixes a regression added in 4.9 with commit:
> >>
> >> commit 0eadf37afc2500e1162c9040ec26a705b9af8d47
> >> Author: Josef Bacik <jbacik@fb.com>
> >> Date:   Thu Sep 8 12:33:40 2016 -0700
> >>
> >>     nbd: allow block mq to deal with timeouts
> >>
> >> where before the patch userspace would set the timeout to 0 to disable
> >> it. With the above patch, a zero timeout tells the block layer to use
> >> the default value of 30 seconds. For setups where commands can take a
> >> long time or experience transient issues like network disruptions this
> >> then results in IO errors being sent to the application.
> >>
> >> To fix this, the patch still uses the common block layer timeout
> >> framework, but if zero is set, nbd just logs a message and then resets
> >> the timer when it expires.
> >>
> >> Josef,
> >>
> >> I did not cc stable, but I think we want to port the patches to some
> >> releases. We originally hit this with users using the longterm kernels
> >> with ceph. The patch does not apply anywhere cleanly with older ones
> >> like 4.9, so I was not sure how we wanted to handle it.
> >>
> > 
> > I assume you tested this?  IIRC there was a problem where 0 really meant 0 and
> 
> Yes.
> 
> > commands would insta-timeout.  But my memory is foggy here, so I'm not sure if
> > it was setting the tag_set timeout to 0 that made things go wrong, or what.  Or
> > I could be making it all up, who knows.
> 
> Yes, if you call blk_queue_rq_timeout with 0, then the command will
> timeout almost immediately. I added a check for this in the first patch.
> 

Ahhh that's what it was, thank you.  I'm cool then, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
