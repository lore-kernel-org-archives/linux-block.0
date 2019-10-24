Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F64CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BF120663
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="gXuqPX1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbfJXRoG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:44:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37408 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRoG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:44:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so15582381pfo.4
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yrK3s5G3MWUC345s8GzvosU3KUZb5PXbRShgELuB7zM=;
        b=gXuqPX1CXH+unrU9zJT/TumQL7K71WM7xdzcOg5ngmeYxJgL+oERvpb1NRhExHzclH
         S0pmfxP3PcFEZwwElhl+b9sgC0+wdQiVWjuO7tg9kCGpdPe/kTfEZAjvwJpsw2k43kaz
         mBeNkW3DZuqGTXnBdK4HoITXOrWk/KIECUanPiDglV4sQBpdqfbSkXhhbvmjtokKqWf1
         R5Yrb/q+WgzTKE7S7IO1Nd72doBONJhGAf+059JlGodrfwfSDa5RkaaD2ZvPnpJcE5Ai
         yczZNLx4u/ge72nf+ZM8py1lBHh9y+yjZ+b3yyXMekP+dm0yNN7zrYsrrDbCzTjDtb/J
         t4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrK3s5G3MWUC345s8GzvosU3KUZb5PXbRShgELuB7zM=;
        b=dfm6BIwYmyYadXW/kXsXt+5BowT2bKu2an+St8nUfGERpSIj1NKkjeLiCppfmN/IO/
         D7tgtprjcBIi247I8aqLQqaiVVr8kxXJnzu8OHAHeGuQcF5TzD1CRfkaGmMQ1fE5x7Jj
         QVcy4wz5XwNEvwh5GIVnL+DXC/hQhnxbvd6By76ix8UpWFYFUrKB9WyUOcYyGzuERcw8
         r52f2A3i4CbcgL1lws2TXzm8AEJrrd/LaTf7m4nAd88OGQSv8ftB6KuKebHdNJzLy1z0
         QbQRqEiWQ+3VB3cH0DnZGNKGAri1Gnpcm9FXkcvuWkinCzNkw5hQ8D8flCZ3u4Xde/M4
         f41A==
X-Gm-Message-State: APjAAAW2W+/fxyXFYjqcItF0BiusBinLHi5MmCNLwjOEMU0Dufi4kBAk
        jgEWLSbwG9LZtc0eoxQx1W8AEQ==
X-Google-Smtp-Source: APXvYqxGyFJLGulSrQ51GuDabU3jbeo3Y2FtnQCveovk1NeM4zBnlp6r6W6xhXbgwRzl6nBxTlgGOQ==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr8371607pjn.69.1571939044807;
        Thu, 24 Oct 2019 10:44:04 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id k124sm25405785pga.83.2019.10.24.10.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:44:04 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:44:03 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests 1/2] Move and rename uptime_s()
Message-ID: <20191024174403.GC137052@vader>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-2-bvanassche@acm.org>
 <20191024172741.GA137052@vader>
 <931f12af-d28f-0b32-9b09-42ad206827e8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931f12af-d28f-0b32-9b09-42ad206827e8@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 24, 2019 at 10:41:49AM -0700, Bart Van Assche wrote:
> On 10/24/19 10:27 AM, Omar Sandoval wrote:
> > On Mon, Oct 21, 2019 at 03:57:18PM -0700, Bart Van Assche wrote:
> > > +# System uptime in seconds.
> > > +_uptime_s() {
> > > +	local a b
> > > +
> > > +	echo "$(</proc/uptime)" | {
> > 
> > What's wrong with cat /proc/uptime? Or even better,
> > 
> >    { read ... } < /proc/uptime
> 
> Hi Omar,
> 
> As you probably know 'cat' triggers a fork() system call but echo $(<...)
> not. This is a performance optimization. Input redirection would also work.
> 
> > > +		read -r a b && echo "$b" >/dev/null && echo "${a%%.*}";
> > 
> > What's the point of the echo "$b" here?
> 
> That echo "$b" statement suppresses a shellcheck warning about $b not being
> used.
> 
> > Seems like this could all be condensed to:
> > 
> >    { read -r s && echo "${s%%.*}" } < /proc/uptime
> > 
> > But that's more cryptic than it needs to be. Can we just do:
> > 
> >    awk '{ print int($1) }' /proc/uptime
> 
> That's a valid alternative, but an alternative that triggers a fork() system
> call. I don't have a strong opinion about which alternative to choose. Do
> you perhaps have a preference?

The awk option is more readable, and we're not trying to win any
performance awards in blktests. Let's just go with that.
