Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32956 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756076AbcKKIjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2016 03:39:05 -0500
Received: by mail-vk0-f48.google.com with SMTP id 137so8302844vkl.0
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2016 00:39:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161110193523.GA11452@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-5-git-send-email-tom.leiming@gmail.com> <20161110193523.GA11452@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 11 Nov 2016 16:39:03 +0800
Message-ID: <CACVXFVPey6N60rKH5vgh7F7zQ778=RpcUbHCw_C1VCLRbOpYyA@mail.gmail.com>
Subject: Re: [PATCH 04/60] block: floppy: use bio_add_page()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 11, 2016 at 3:35 AM, Christoph Hellwig <hch@infradead.org> wrote:
> Hi Ming,
>
> any chance you could send out a series with the various bio_add_page
> soon-ish?  I'd really like to get all the good prep work in for

No problem, will post out v1 later

thanks,
Ming Lei
