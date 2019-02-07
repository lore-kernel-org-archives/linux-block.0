Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64EDC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCE121904
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JELjyQ3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfBGJXA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:23:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54056 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGJW7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 04:22:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so5305229wmb.3
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2scvD+tXKod9KY4Tp0JnlAlCLc3ovezukIRv7Om5mo=;
        b=JELjyQ3ygXn/s8SjbpyX81WJTZIUy5t3dcGV9R0KpjPOPebai1Kb3uXFm9M7J288Bi
         5myYBQghDsQxEWrX1QF5S9b+juRgxNitGU2pUeuh2QobDn74WeQVzK/CyBIs8uqg9QLK
         Y/w+0oijH36NecNTi9j34Vx2MPXp+pdIc429w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2scvD+tXKod9KY4Tp0JnlAlCLc3ovezukIRv7Om5mo=;
        b=ERRmKnLXzLF5Qxg5tIHRnXic/q5KTvcxy0Moz580ZbpDj2ZPvyw/LHOG5PueS4vw83
         bcqeCIrSaKu0X0MhqPvmtRIQHnkeNwxcsyGNvOz+5H9HTpXT55pVVlh91RY/8ZElZxeZ
         fkvI73tuoqGsieAtBFtcxv6h4jXfI2zDrcgqDSO3flJNGyXWxhoDVSeZxK6TUkOFI7WC
         kBZ/9C/xITKBbdT5rz2g+GFBggVJIfyR1pIQnCPeR3AKsBj8MoiB6ejxKUIIRWCuKzIe
         2LXUVVYvwWhG9IoIvxUJG8sskC9gjQDwztd5k0jCK2ZwabV9Kz7q0thxEm+wPWb5wD6b
         OMkA==
X-Gm-Message-State: AHQUAuYHRvn7r+HnQEiQcCnun8s5GWjZ7BxGo2YkofsPOppgydo6Gg2R
        82TI2GBM2hVJtqsSTnbQckAZ5Q==
X-Google-Smtp-Source: AHgI3IbWsyfI3AJsk0KyazzNfxdlM7gofVperoV7s0J+N8oRhKsQsk9nxXGTm6qn309z8ijDtkvNYA==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr6689370wmd.67.1549531377015;
        Thu, 07 Feb 2019 01:22:57 -0800 (PST)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id w14sm3731969wrt.95.2019.02.07.01.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 01:22:56 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:22:53 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190207092253.GD19821@veci.piliscsaba.redhat.com>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <20190206005638.GU2217@ZenIV.linux.org.uk>
 <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk>
 <20190207040058.GW2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207040058.GW2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 07, 2019 at 04:00:59AM +0000, Al Viro wrote:

> So in theory it would be possible to have
> 	* thread A: sendmsg() has SCM_RIGHTS created and populated,
> complete with file refcount and ->inflight increments implied,
> at which point it gets preempted and loses the timeslice.
> 	* thread B: gets to run and removes all references
> from descriptor table it shares with thread A.
> 	* on another CPU we have garbage collector triggered;
> it determines the set of potentially unreachable unix_sock and
> everything in our SCM_RIGHTS _is_ in that set, now that no
> other references remain.
> 	* on the first CPU, thread A regains the timeslice
> and inserts its SCM_RIGHTS into queue.  And it does contain
> references to sockets from the candidate set of running
> garbage collector, confusing the hell out of it.

Reminds me: long time ago there was a bug report, and based on that I found a
bug in MSG_PEEK handling (not confirmed to have fixed the reported bug).  This
fix, although pretty simple, got lost somehow.  While unix gc code is in your
head, can you please review and I'll resend through davem?

Thanks,
Miklos
---

From: Miklos Szeredi <mszeredi@redhat.com>
Subject: af_unix: fix garbage collect vs. MSG_PEEK

Gc assumes that in-flight sockets that don't have an external ref can't
gain one while unix_gc_lock is held.  That is true because
unix_notinflight() will be called before detaching fds, which takes
unix_gc_lock.

Only MSG_PEEK was somehow overlooked.  That one also clones the fds, also
keeping them in the skb.  But through MSG_PEEK an external reference can
definitely be gained without ever touching unix_gc_lock.

This patch adds unix_gc_barrier() that waits for a garbage collect run to
finish (if there is one), before actually installing the peeked in-flight
files to file descriptors.  This prevents problems from a pure in-flight
socket having its buffers modified while the garbage collect is taking
place.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org>
---
 include/net/af_unix.h |    1 +
 net/unix/af_unix.c    |   15 +++++++++++++--
 net/unix/garbage.c    |    6 ++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -12,6 +12,7 @@ void unix_inflight(struct user_struct *u
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_gc(void);
 void wait_for_unix_gc(void);
+void unix_gc_barrier(void);
 struct sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1547,6 +1547,17 @@ static int unix_attach_fds(struct scm_co
 	return 0;
 }
 
+static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+	/*
+	 * During garbage collection it is assumed that in-flight sockets don't
+	 * get a new external reference.  So we need to wait until current run
+	 * finishes.
+	 */
+	unix_gc_barrier();
+}
+
 static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool send_fds)
 {
 	int err = 0;
@@ -2171,7 +2182,7 @@ static int unix_dgram_recvmsg(struct soc
 		sk_peek_offset_fwd(sk, size);
 
 		if (UNIXCB(skb).fp)
-			scm.fp = scm_fp_dup(UNIXCB(skb).fp);
+			unix_peek_fds(&scm, skb);
 	}
 	err = (flags & MSG_TRUNC) ? skb->len - skip : size;
 
@@ -2412,7 +2423,7 @@ static int unix_stream_read_generic(stru
 			/* It is questionable, see note in unix_dgram_recvmsg.
 			 */
 			if (UNIXCB(skb).fp)
-				scm.fp = scm_fp_dup(UNIXCB(skb).fp);
+				unix_peek_fds(&scm, skb);
 
 			sk_peek_offset_fwd(sk, chunk);
 
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -267,6 +267,12 @@ void wait_for_unix_gc(void)
 	wait_event(unix_gc_wait, gc_in_progress == false);
 }
 
+void unix_gc_barrier(void)
+{
+	spin_lock(&unix_gc_lock);
+	spin_unlock(&unix_gc_lock);
+}
+
 /* The external entry point: unix_gc() */
 void unix_gc(void)
 {
