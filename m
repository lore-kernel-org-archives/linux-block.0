Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BEDC432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 21:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277B32071E
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 21:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Zetzduy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYVKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:10:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44237 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKYVKy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 16:10:54 -0500
Received: by mail-pj1-f66.google.com with SMTP id w8so7160752pjh.11
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2019 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V3TXfa4R2lAGZG8zTp7WHPyH6wQ9YdNGVO+89vNfKhU=;
        b=Zetzduy59Sao+VRj1mRqbNMmKH3qWrLsyybX8LtjCynFJwJThXA4MVPwnTyqehn0hn
         //k+8iQmWauulgLUnPiu4l7CnUrcNsLjTUpq8H1uIiR++DUUoZymIUiWu4AY6Bu/VTzU
         M1Stn0v5+sbmu/H80NnUsVcIGYFope4ORXXTL7T1jfxJeClH+rqfv0M1s6oMVrmGdcrD
         ch3lWsTGG6sCDKRLBym2kJDGzi2tD7jF25Vuk73pZguxFl71fYiO6m9g8VXazeVRiQBn
         LvYmN0hQtn0e3/WAfsXHdpDKUHyX3b3DAXZIvN9Z3Q/AHXnraIKgx2zwlIBpvHZrEmrd
         7UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V3TXfa4R2lAGZG8zTp7WHPyH6wQ9YdNGVO+89vNfKhU=;
        b=Yourhp+Qo4Z6WH+wDt4/lRl0c0M9FLG3AQ1A20DiXpGDYAZM0h7lW3n2aR8mfpfj1b
         hKnUEe+xVdjNmURQBohVcZ4XDzC0bceGWolU2ODyHeby9AtOJa/Y6Rj9u6kpl1Y4pINk
         p5CM5Z2OgUklOfZqV/OYg6/xwfA1JHXrE3TWJw9e2S3EGghXBVltBXVP3twgrV+G/3GR
         wssx9P2mm6sk+EfoG1KCIoRkjqXQadiZmRVGMuqw6hRItRrHaPd9yAcygXWUQI7GmP7n
         8g5QxOC6EaHyE6vtov6I5+wew/doF5zYipO08aT9xvcPvU+cBt6ufkp2rLSYgpTetgUZ
         CHlQ==
X-Gm-Message-State: APjAAAUhc53RA9GMyvBElkWg41PRFLv8q08/aNq3Y9SX8yc2D5G3oE5P
        15U4fPCw6BWGthN7mIhOCGPzyg==
X-Google-Smtp-Source: APXvYqyMqeUzvLTGMFDqzWaWDGzjZBmLVGgcYoK9Cd+i862dcVP/22fMYImSn4LXO+sNTdea/2oxhA==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr31216623plt.58.1574716251970;
        Mon, 25 Nov 2019 13:10:51 -0800 (PST)
Received: from vader ([2620:10d:c090:200::2:16e0])
        by smtp.gmail.com with ESMTPSA id fh11sm299502pjb.2.2019.11.25.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 13:10:51 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:10:50 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 4/4] tests/srp/015: Add a test that uses the
 SoftiWARP (siw) driver
Message-ID: <20191125211050.GB639675@vader>
References: <20191115170711.232741-1-bvanassche@acm.org>
 <20191115170711.232741-5-bvanassche@acm.org>
 <20191125201334.GA639675@vader>
 <4dc03225-e495-6687-161b-e8b82a80f5c1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dc03225-e495-6687-161b-e8b82a80f5c1@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 25, 2019 at 12:49:51PM -0800, Bart Van Assche wrote:
> On 11/25/19 12:13 PM, Omar Sandoval wrote:
> > On Fri, Nov 15, 2019 at 09:07:11AM -0800, Bart Van Assche wrote:
> > > Recently support has been added in the SRP initiator and target drivers
> > > for the SoftiWARP driver. Add a test for SRP over SoftiWARP.
> > > 
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >   tests/srp/015     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >   tests/srp/015.out |  2 ++
> > >   2 files changed, 44 insertions(+)
> > >   create mode 100755 tests/srp/015
> > >   create mode 100644 tests/srp/015.out
> > 
> > Hi, Bart,
> > 
> > I'm getting:
> > 
> > srp/015 (File I/O on top of multipath concurrently with logout and login (mq) using the SoftiWARP (siw) driver) [failed]
> >      runtime  1.076s  ...  1.026s
> >      --- tests/srp/015.out       2019-11-25 12:07:06.749425714 -0800
> >      +++ /home/vmuser/repos/blktests/results/nodev/srp/015.out.bad       2019-11-25 12:12:07.634062201 -0800
> >      @@ -1,2 +1 @@
> >      -Configured SRP target driver
> >      -Passed
> >      +mkdir: cannot create directory ‘0x52540012345600000000000000000000’: Invalid argument
> > 
> > This is on v5.4-rc8 with CONFIG_RDMA_SIW=m. Do you know what is wrong
> > here?
> 
> Hi Omar,
> 
> I should have mentioned that the SRP iWARP support patches have been
> accepted in the RDMA tree but that these are not yet in Linus' tree. The SRP
> iWARP patches should be merged in Linus' tree during the current merge
> window. If you would like to test these patches before Linus merges the RDMA
> pull request, please have a look at https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next&ofs=1000

Okay, I figured I was missing something. Can we detect this in
requires() so that it doesn't fail on old kernels?
