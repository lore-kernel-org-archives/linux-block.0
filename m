Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD96C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 20:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiI2UGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiI2UGI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 16:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C321FCCBB
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664481959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AnEeGlxMZS/QnPu6xkGVWCkH9yWvSrJTWFuxGLOSy4=;
        b=LX8y8pI9sl7Bnchrdt81SxB/CTgzhjgMEVWVFF3U0mig6MTnxUD/EP8xD3sqDnt9+rCVvk
        ZQnACbvrc+cFAjhXuLZsT+fh4CddSW6hPOdlvaTgg1aG/yQzeOVOCGP00KVd9pKZaPhFco
        emo2o2e9hpksaeRoM1610GNQnADleoI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-bmVeCiMSNG-sLnlG-l0mPQ-1; Thu, 29 Sep 2022 16:05:55 -0400
X-MC-Unique: bmVeCiMSNG-sLnlG-l0mPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD45329324A7;
        Thu, 29 Sep 2022 20:05:53 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3FD77AE5;
        Thu, 29 Sep 2022 20:05:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28TK5hCb011567;
        Thu, 29 Sep 2022 16:05:43 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28TK5hub011563;
        Thu, 29 Sep 2022 16:05:43 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 29 Sep 2022 16:05:43 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 0/4] brd: implement discard
In-Reply-To: <YzOdau9e5HYcjQKf@B-P7TQMD6M-0146.local>
Message-ID: <alpine.LRH.2.02.2209291600540.7875@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com> <YyqfHfadJvxbB/JC@B-P7TQMD6M-0146.local> <alpine.LRH.2.02.2209271006590.28431@file01.intranet.prod.int.rdu2.redhat.com> <YzOdau9e5HYcjQKf@B-P7TQMD6M-0146.local>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Wed, 28 Sep 2022, Gao Xiang wrote:

> > Hi
> > 
> > Ramdisk DAX was there in the past, but it was removed in the kernel 4.15.
> 
> Hi Mikulas!
> 
> Thanks for pointing out! I didn't realize that, although I think if we really
> use brd driver in production, enabling DAX support for brd is much better to
> remove double caching so that ramdisk can become a real ramdisk for most
> regular files.
> 
> I have no idea how other people think about ramdisk DAX, or brd is just a
> stuff for testing only now.  If it behaves like this, sorry about the
> noise.
> 
> Thanks,
> Gao Xiang

Hi

See the message for the commit 7a862fbbdec665190c5ef298c0c6ec9f3915cf45 
for the reason why it was removed.

Mikulas

