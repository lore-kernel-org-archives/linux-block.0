Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B75BC3A5A8
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C34208E4
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="nP0bHBFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfIDRzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:55:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34697 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfIDRzR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 13:55:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so11649791pgc.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g7CszcADRTQ9cCGbaPVlHbXEYlpkom0K7dAOfrESqok=;
        b=nP0bHBFvxSiQdBG2JGICltaQk2rJOPVY5PkIOPgFEWO0/NsaMaF10MgGthPpjXkNkS
         El/bR/z6zKajX2lm7O4wTrII7bpmYSBAWdWmvV6KSqPuWG+Dj5ddywauYYiPFcAtsnom
         5on0p4mBhKF1MZIGt5oWA2o4xN0webFaGsStiAKhh3B8iTWEp4quMudysf4N/uz+8L+u
         qaojpPn3zb5NYajOvEuopYA2rIwPmNMCW7H/DTX3y6MezK9AwV+4hZiqijo92ezOF2jL
         NhQhJWM56KF8NVT9YdpeAMylB7XjhC3bw3p0oQhpTAyBDYY0vO8Ez8EXcs9reOsvR1Tc
         uD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g7CszcADRTQ9cCGbaPVlHbXEYlpkom0K7dAOfrESqok=;
        b=IEexkHlKqHn5+3jzj/A1Bmty4ItsR0c/r4I43Vz1HDtFdYOlhDi0gmdhJdk24YqaJD
         J4PScAqlSmnUDzMce1iI5neGSLKGFJKCVC+Dg4cRynzbi7UFKQJylOTyQ3I95bBeaaXq
         8iScMJw8lY6sqHCy7SxoDuAy2+FHJBahGN3H8aE+NrvSeJK/KOcDqENe15EfGYAJ471h
         3CeijwO6tSX4zHEUi8+BHV+oEMB199IwNp3IRxZXnTE1xyRUA7OsrqXVZIwlBgumZw7D
         08m+l40yhrtCOgHJJ3kbIUqgape+Ul8XGfHQsJQxjDMrwmhFdTBuREwJ7WuwV1FOGC8V
         Bb2A==
X-Gm-Message-State: APjAAAWDeW3Mub3Bb2PVr2AMh8NFwgOFbkzHKws+uWqDTF4t1hJiwcTV
        OSHzpBImMVheJAVLWSrF1tX4uQ==
X-Google-Smtp-Source: APXvYqxf++d4gH8vsrbu+3UoyOmSwQqnXE9ThkZ0x7rKZuo/nL1TwQZlAyrhSLRfupNMuoI4g62NKg==
X-Received: by 2002:a63:7205:: with SMTP id n5mr35847137pgc.443.1567619716718;
        Wed, 04 Sep 2019 10:55:16 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b19sm19479111pgs.10.2019.09.04.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 10:55:16 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:55:15 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH blktests 0/4] Four blktests patches
Message-ID: <20190904175515.GD7452@vader>
References: <20190808200506.186137-1-bvanassche@acm.org>
 <2e2e3abb-1420-7743-eb7f-cd9744d36686@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2e3abb-1420-7743-eb7f-cd9744d36686@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 04, 2019 at 10:49:13AM -0700, Bart Van Assche wrote:
> On 8/8/19 1:05 PM, Bart Van Assche wrote:
> > Hi Omar,
> > 
> > This series includes one improvement for the NVMe tests, two improvements for
> > the NVMeOF-multipath tests and version two of the SRP test that triggers a SCSI
> > reset while I/O is ongoing. Please consider these for the official blktests
> > git repository.
> 
> (replying to my own e-mail)
> 
> Hi Omar,
> 
> This patch series was posted about one month ago. Feedback about how to
> proceed with this patch series is still welcome.

I was actually just in the middle of merging it. Pushed now, thanks and
sorry for the delay.
