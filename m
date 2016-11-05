Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34400 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbcKESOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2016 14:14:18 -0400
Received: by mail-wm0-f41.google.com with SMTP id u144so18598338wmu.1
        for <linux-block@vger.kernel.org>; Sat, 05 Nov 2016 11:14:17 -0700 (PDT)
Subject: Re: [PATCH 4/5] iomap: implement direct I/O
To: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org
References: <1478276479-10749-1-git-send-email-hch@lst.de>
 <1478276479-10749-5-git-send-email-hch@lst.de>
Cc: axboe@fb.com, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
From: Avi Kivity <avi@scylladb.com>
Message-ID: <2dabe3ec-193b-3ecf-af5c-a5ba976de6eb@scylladb.com>
Date: Sat, 5 Nov 2016 20:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <1478276479-10749-5-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,


On 11/04/2016 06:21 PM, Christoph Hellwig wrote:
> This adds a full fledget direct I/O implementation using the iomap
> interface. Full fledged in this case means all features are supported:
> AIO, vectored I/O, any iov_iter type including kernel pointers, bvecs
> and pipes, support for hole filling and async apending writes.

Does this include support for more than one concurrent appending write 
for the same file?

If so, that's great, but please make this feature discoverable. Right 
now applications have to benchmark or guess how fully asynchronous the 
aio implementation is.

