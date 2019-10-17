Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019CBECE58E
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F1621925
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571330198;
	bh=Z/KBP2YLrD5Y/wfplASDyaw24GCH9LYbK0NX0ij4yFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dizQeIUMYvkFaQnvz0fvYoMnDIZXMDhHX6J3KxNQvg81mFHehwc3ODC6NwC4yRn1H
	 q6IJNI5YvwajMbX9caUE7wOXZUb9w4D648NTXr9IviqaX5mh4k599AmKET0dyceQ8p
	 BLtrrTzJEPAygz6DVcaTWb0W3pFFbZj3XVQ/vla8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfJQQgi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfJQQgi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 12:36:38 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4047E21835;
        Thu, 17 Oct 2019 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571330196;
        bh=Z/KBP2YLrD5Y/wfplASDyaw24GCH9LYbK0NX0ij4yFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRWfl0CF/fNtfLzCK9xoNX50b7918dQxGKCBhXclmgNbfprtOyU5vAVCyEDdHCPPN
         1M/pOZ3Pb0zSTXB62LjUD/NfKWLBTOo9tKtHcNjObqoLiokmJ5AJ1R0I0MaSTBiomd
         PO7rHmnCrOP9TbWUHpUJKS+tzEKaW1cYXlqziFIo=
Date:   Thu, 17 Oct 2019 09:36:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        syzbot <syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in nbd_ioctl
Message-ID: <20191017163634.GD726@sol.localdomain>
Mail-Followup-To: "Richard W.M. Jones" <rjones@redhat.com>,
        Mike Christie <mchristi@redhat.com>,
        syzbot <syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000b1b1ee0593cce78f@google.com>
 <5D93C2DD.10103@redhat.com>
 <20191017140330.GB25667@redhat.com>
 <5DA88D2F.7080907@redhat.com>
 <20191017162829.GA3888@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017162829.GA3888@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 17, 2019 at 05:28:29PM +0100, Richard W.M. Jones wrote:
> On Thu, Oct 17, 2019 at 10:47:59AM -0500, Mike Christie wrote:
> > On 10/17/2019 09:03 AM, Richard W.M. Jones wrote:
> > > On Tue, Oct 01, 2019 at 04:19:25PM -0500, Mike Christie wrote:
> > >> Hey Josef and nbd list,
> > >>
> > >> I had a question about if there are any socket family restrictions for nbd?
> > > 
> > > In normal circumstances, in userspace, the NBD protocol would only be
> > > used over AF_UNIX or AF_INET/AF_INET6.
> > > 
> > > There's a bit of confusion because netlink is used by nbd-client to
> > > configure the NBD device, setting things like block size and timeouts
> > > (instead of ioctl which is deprecated).  I think you don't mean this
> > > use of netlink?
> > 
> > I didn't. It looks like it is just a bad test.
> > 
> > For the automated test in this thread the test created a AF_NETLINK
> > socket and passed it into the NBD_SET_SOCK ioctl. That is what got used
> > for the NBD_DO_IT ioctl.
> > 
> > I was not sure if the test creator picked any old socket and it just
> > happened to pick one nbd never supported, or it was trying to simulate
> > sockets that did not support the shutdown method.
> > 
> > I attached the automated test that got run (test.c).
> 
> I'd say it sounds like a bad test, but I'm not familiar with syzkaller
> nor how / from where it generates these tests.  Did someone report a
> bug and then syzkaller wrote this test?
> 
> Rich.
> 
> > > 
> > >> The bug here is that some socket familys do not support the
> > >> sock->ops->shutdown callout, and when nbd calls kernel_sock_shutdown
> > >> their callout returns -EOPNOTSUPP. That then leaves recv_work stuck in
> > >> nbd_read_stat -> sock_xmit -> sock_recvmsg. My patch added a
> > >> flush_workqueue call, so for socket familys like AF_NETLINK in this bug
> > >> we hang like we see below.
> > >>
> > >> I can just remove the flush_workqueue call in that code path since it's
> > >> not needed there, but it leaves the original bug my patch was hitting
> > >> where we leave the recv_work running which can then result in leaked
> > >> resources, or possible use after free crashes and you still get the hang
> > >> if you remove the module.
> > >>
> > >> It looks like we have used kernel_sock_shutdown for a while so I thought
> > >> we might never have supported sockets that did not support the callout.
> > >> Is that correct? If so then I can just add a check for this in
> > >> nbd_add_socket and fix that bug too.
> > > 
> > > Rich.
> > > 

It's an automatically generated fuzz test.

There's rarely any such thing as a "bad" fuzz test.  If userspace can do
something that causes the kernel to crash or hang, it's a kernel bug, with very
few exceptions (e.g. like writing to /dev/mem).

If there are cases that aren't supported, like sockets that don't support a
certain function or whatever, then the code needs to check for those cases and
return an error, not hang the kernel.

- Eric
