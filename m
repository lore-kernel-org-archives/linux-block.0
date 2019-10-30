Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08A3CA9EAF
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7349A2083E
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 09:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJ3JBK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:01:10 -0400
Received: from latin.grep.be ([46.4.76.168]:37371 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JBK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 05:01:10 -0400
X-Greylist: delayed 1254 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2019 05:01:09 EDT
Received: from [105.12.0.33] (helo=gangtai.home.grep.be)
        by latin.grep.be with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <w@uter.be>)
        id 1iPjWW-0005Cf-Be; Wed, 30 Oct 2019 09:40:12 +0100
Received: from wouter by gangtai.home.grep.be with local (Exim 4.92.3)
        (envelope-from <w@uter.be>)
        id 1iPjWH-0006qB-RE; Wed, 30 Oct 2019 10:39:57 +0200
Date:   Wed, 30 Oct 2019 10:39:57 +0200
From:   Wouter Verhelst <w@uter.be>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        syzbot <syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in nbd_ioctl
Message-ID: <20191030083957.GD25097@grep.be>
References: <000000000000b1b1ee0593cce78f@google.com>
 <5D93C2DD.10103@redhat.com>
 <20191017140330.GB25667@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017140330.GB25667@redhat.com>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 17, 2019 at 03:03:30PM +0100, Richard W.M. Jones wrote:
> On Tue, Oct 01, 2019 at 04:19:25PM -0500, Mike Christie wrote:
> > Hey Josef and nbd list,
> > 
> > I had a question about if there are any socket family restrictions for nbd?
> 
> In normal circumstances, in userspace, the NBD protocol would only be
> used over AF_UNIX or AF_INET/AF_INET6.

Note that someone once also did work to make it work over SCTP. I
incorporated the patch into nbd-client and nbd-server, but never
actually tested it myself. I have no way of knowing if it even still
works anymore...

[...]
-- 
To the thief who stole my anti-depressants: I hope you're happy

  -- seen somewhere on the Internet on a photo of a billboard
