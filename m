Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:50660 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeFLKRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 06:17:20 -0400
Received: by mail-wm0-f47.google.com with SMTP id e16-v6so19569301wmd.0
        for <linux-block@vger.kernel.org>; Tue, 12 Jun 2018 03:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <88c22c6d-8482-8854-6e9b-88605eab3735@oracle.com>
References: <88c22c6d-8482-8854-6e9b-88605eab3735@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 12 Jun 2018 18:17:17 +0800
Message-ID: <CACVXFVN8r6LNxayK-Kp0H_aq=pjMxK0Q1a8Q4fj2BaQeh1-Yhw@mail.gmail.com>
Subject: Re: Regarding the recent new blk-mq timeout handling
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 12, 2018 at 6:04 PM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi Jens and Christoph
>
> In the recent commit of new blk-mq timeout handling, we don't have any protection
> on timed out request against the completion path. We just hold a request->ref count,
> it just could avoid the request tag to be released and life-recycle, but not completion.
>
> For the scsi mid-layer, what if a request is in error handler and normal completion come
> at the moment ?

Per my understanding, now the protection needs to be done completely by driver.


Thanks,
Ming Lei
