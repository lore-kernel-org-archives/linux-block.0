Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FFC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 21:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63C62467B
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="y1A3XHIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLSVlp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:41:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40408 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVlp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 16:41:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so421593plr.7
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 13:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ccmypzi610bNn8gUCX6PdXyefZbddQRdF+7O2WvubcM=;
        b=y1A3XHIZyKKZoqaf8SriJVGe2DJ37d2zGdpi7y/cgVpnRgjniFMe3DaK/wPKLWD1lR
         bzVq8h5aZ+dqSoc0CeHRSy2u+UQHZtzdSNl+a4lPVVad1GExxbLWPRegnWt0w/dUs6A5
         JFgtgr5gJ94a5AxUMfRmNTFRTBu1tOrpmSdAgTl7beFQoOqxXYnyHzcgLJmneePBvkg6
         50xotvTrDr2EJ4YyLpUcV6FzQ4f+enqYbIH+Xg1pTGJ/SyveOAWR6rJrmjKuEjUeenI6
         HjlfKh6PO5o08CPS9UcESbJ82udgiHSceAZjbNis8TBC5mk7g7pPzhw3DhUS5jNgRxkb
         lhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ccmypzi610bNn8gUCX6PdXyefZbddQRdF+7O2WvubcM=;
        b=E/GAjlFLDRe4ah3GwRz1dWkPEFRiFUnvqOlUlywN2CGFq3We/4KeRXmmMBUY3tsUbd
         lf9m7ZoRDcIxmL0Q3IRtyKbts3+O3OwakGh6GTmtJ6TUJ5oF6oppw4/L4MWFdQ+PEMIo
         xl4c9J/3Ge/ml0NA0d9ZGRmdD7NA+Rkeq3PYv3aAOJbgr7OeHeoWkg9dY3BdY3XJ1QbK
         QOfZFg8Pxgd4LCL3+xQbyl2Qa/AtdLlL5Bx2SeM7yoZkoqy71mwBoAl18AvzYcFvts/l
         ZYiEhHDHXUFUQPjSHF4vM52k9wPcg8bHeqvEgC6ptSOtggJwjBhnX19H9Q+rGDo34634
         vfag==
X-Gm-Message-State: APjAAAW1l0FGVo7JgbF9AB0ablBAz3E5xdw/nHdvH3g1A87EjPNCbUbx
        SLz6Kuuyzq8LTx3HQoWXjXM9mYb1YOUJJQ==
X-Google-Smtp-Source: APXvYqyGa+FIlMGTR/DKGxY9KMpxg0gsIaaf+Rn4wP/9JvBb0YHR5FQbLVTf/8WKp5wBTroLAUjDOA==
X-Received: by 2002:a17:90a:178f:: with SMTP id q15mr12192559pja.132.1576791704344;
        Thu, 19 Dec 2019 13:41:44 -0800 (PST)
Received: from vader ([2620:10d:c090:180::fc68])
        by smtp.gmail.com with ESMTPSA id h3sm9842093pfr.15.2019.12.19.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:41:43 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:41:42 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-block@vger.kernel.org, John Pittman <jpittman@redhat.com>
Subject: Re: [PATCH] sbitmap: only queue kyber's wait callback if not already
 active
Message-ID: <20191219214142.GB826140@vader>
References: <20191217160024.GA23066@redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217160024.GA23066@redhat>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 17, 2019 at 11:00:24AM -0500, David Jeffery wrote:
> Under heavy loads where the kyber I/O scheduler hits the token limits for
> its scheduling domains, kyber can become stuck.  When active requests
> complete, kyber may not be woken up leaving the I/O requests in kyber
> stuck.
> 
> This stuck state is due to a race condition with kyber and the sbitmap
> functions it uses to run a callback when enough requests have completed.
> The running of a sbt_wait callback can race with the attempt to insert the
> sbt_wait.  Since sbitmap_del_wait_queue removes the sbt_wait from the list
> first then sets the sbq field to NULL, kyber can see the item as not on a
> list but the call to sbitmap_add_wait_queue will see sbq as non-NULL. This
> results in the sbt_wait being inserted onto the wait list but ws_active
> doesn't get incremented.  So the sbitmap queue does not know there is a
> waiter on a wait list.
> 
> Since sbitmap doesn't think there is a waiter, kyber may never be
> informed that there are domain tokens available and the I/O never advances.
> With the sbt_wait on a wait list, kyber believes it has an active waiter
> so cannot insert a new waiter when reaching the domain's full state.
> 
> This race can be fixed by only adding the sbt_wait to the queue if the
> sbq field is NULL.  If sbq is not NULL, there is already an action active
> which will trigger the re-running of kyber.  Let it run and add the
> sbt_wait to the wait list if still needing to wait.

So the race here is:

Thread 1                        Thread 2
kyber_domain_wake
  sbitmap_del_wait_queue
    list_del_init
    atomic_dec sbq->ws_active
                                kyber_get_domain_token
                                  list_empty_careful
                                  sbitmap_add_wait_queue
                                    if (!sqb_wait->sb) // false
                                    add_wait_queue
    sbq_wait->sbq = NULL

Now sbq_wait->sbq == NULL, sbq->ws_active = 0, and
!list_empty(domain_wait), so sbq_wake_ptr returns NULL and
sbitmap_queue_wake_up does nothing.

I get the feeling that sbitmap_{add,del}_wait_queue need some memory
barriers... But ignoring that, this fix seems right.

Reviewed-by: Omar Sandoval <osandov@fb.com>

P.S. s/sbt_wait/sbq_wait/g in the commit message.
