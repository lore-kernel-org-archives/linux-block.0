Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8967C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 18:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705622075D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 18:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="d1JbzIqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfCYSwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:52:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYSwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 14:52:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so372313plb.5
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SsHA2IOvSpVr+MRNMrZY5/E/IP/dMBfFBr8h8E+SRlE=;
        b=d1JbzIqvKSGi617tl44QoCCwUqIqCX4Ff1CesTc4sYBEx+zkP5/ytp7VnfZKHRIlZk
         pM29kGj6MgqxTZUdRTsYVIwxG9DoLRYinpamuPZZQQbSyoxkEbczfQGw0a6GNdbN9KwF
         tHPufvWuAAv/L+vyzlbbecahYG55mcV5cQRP0UypI/JpX/Jyn+uQgGgBAUcb1IclTE8C
         Zbri/NKttp5BA4n98Ho8KYQerNGeDQ9wPOu13Yng5Zs1m7i3BkQCVBKq2yVsGvGvpaSP
         Mf26XAyUR/TxnF2EBoRvOoYrAhtAB7bpGUOX/F66897vEs5J1WWpWals91n3SQizlPG1
         43Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SsHA2IOvSpVr+MRNMrZY5/E/IP/dMBfFBr8h8E+SRlE=;
        b=Pxd7Ta3DAClrrH/rHrpFNu2xZ7xmypiwUArzkTQxZf5a3R1zUhNaGhXOWUU62x+UUF
         6KfCnypAXRx5o4rnP+VipDWLqw9V4T0c/my/fuwHdHqSjq/QhbB2I1hQAdd747Ay9qDY
         h8COI7P1LKFfl+fYCFgLWBAMQU2nSCN9Alm+FpauNmJ1w+vHGRD8aoRKa2kxZTYpYZXo
         Dfrf971B3jQFxKEtXhbQJsBEWet53VpgHysAVypm8PwECg1T8kJMCIM9QG42Aa4aSnyn
         getzBqWGOCf2O8s7ArO79fmzf/q5eDnw5Vh83MB2/Vl6F8avanVWWOM7WMRa+byrq/H+
         8EaA==
X-Gm-Message-State: APjAAAV5wRro1TaduNliew9s+nv3teFgoiKTYjzA22l1uasp8th5nB9i
        YydC9EC1CCXlycxBOQDTihKR5Q==
X-Google-Smtp-Source: APXvYqx3Eg5deRlxxgU5m0RHFs/8HXnzWQgqWGWNYdyW2/1SpLgiTQMRsLFHKUnZINcJeip2EDc0mA==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20mr24989210pll.263.1553539939578;
        Mon, 25 Mar 2019 11:52:19 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:b619])
        by smtp.gmail.com with ESMTPSA id d75sm34370659pga.66.2019.03.25.11.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:52:18 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:52:17 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Yi Zhang <yi.zhang@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3] sbitmap: order READ/WRITE freed instance and setting
 clear bit
Message-ID: <20190325185217.GE5826@vader>
References: <20190322011351.4082-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322011351.4082-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 09:13:51AM +0800, Ming Lei wrote:
> Inside sbitmap_queue_clear(), once the clear bit is set, it will be
> visiable to allocation path immediately. Meantime READ/WRITE on old
> associated instance(such as request in case of blk-mq) may be
> out-of-order with the setting clear bit, so race with re-allocation
> may be triggered.
> 
> Adds one memory barrier for ordering READ/WRITE of the freed associated
> instance with setting clear bit for avoiding race with re-allocation.

Just to make sure I understand, the race is something like this?

Thread 1			Thread 2
sbitmap_queue_get()
...
write to request _____
sbitmap_queue_clear() \
		       \	sbitmap_queue_get()
		        \______ observes write

If so, you can add

Reviewed-by: Omar Sandoval <osandov@fb.com>
