Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B53C282CE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 09:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8D720870
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 09:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9QOcqQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDHJCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:02:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHJCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 05:02:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so15379129wro.5;
        Mon, 08 Apr 2019 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CG7VK1KiQuqH1IebpQWWnQz2mb+OQNTKTBGWnJsK2TM=;
        b=W9QOcqQzced6wFWygWMu8myrsV++jq7y+1oKsQLgxJ4a1vLnOE8MnHIQbByWvP5d+L
         ATdHTHxa4wq0SA6i2s318W8OBqrmP2Z5wUSJc2wF9EFJEvRq5ZxOj1kU3flQv4NGjQbp
         ZqoCuiUZ8rNbCb4kxbKLpcJmqacoPM6sq3kGrL/fFfbqRLeaVHVEWr18AdlHKK9Rt8er
         /GFW6zEE+lwU/mviijwQPTirn5tHTtIIKqMRU+ViJM1Q5H7yaZ8E101CyGb6FBiDyzRl
         3cUNIZrz5Y2z8ny0f6vfMmGrHKHHkQJ268Oq22EELTqyIU8URUrg7QFYocPh4e9EXuXb
         S43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CG7VK1KiQuqH1IebpQWWnQz2mb+OQNTKTBGWnJsK2TM=;
        b=T+EfA2L8Y55HVhyusoyAr7al1Qa035WPivQ+CvUDtIgcjLwrL/yXvcLREBd/K5XBST
         C+SSdcZGk4a2n4+yPhqxy/kNa4Dhcb2dUjZ6k5Q9vbiYH6isxRodVlK4CYbPHufRQqIk
         knNqizLnsjV2wMg3WNpfHK4hqrxGCptDLsx6KIXSPnGxcylQJgsa/JlpLCBQ3Irhze9A
         0cBn/BOHrfNw5QSsSSyYu3VdgPX8puhVvU1C7iNU74XtEE3kLMbBPrKgNUljW6fOpFSB
         /+epMLYpIPJTR88VHmtpQsj0pbSlj4euLeZzt/rgkNN9letGaePMyygQ/1H+PbTA9gDL
         74vg==
X-Gm-Message-State: APjAAAW5rIU1flsZDfQ03fEzGkb16Lxlv/KWI5faDxL30Wq3jWKc3jrK
        tqSA4Kqe7JlpK4xoxDcEim4ucnBVXhX4Hco8jaA=
X-Google-Smtp-Source: APXvYqxJcGELgPBQYCypQAxGZ1PKE2uc5rQNI2vs6WoXxXYKde48hbYnGxiRlI+C1aUsTtKgOImZMQz4e6CcxGG3v2k=
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr18293185wro.274.1554714122228;
 Mon, 08 Apr 2019 02:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084320.24681-1-ming.lei@redhat.com> <20190404084320.24681-4-ming.lei@redhat.com>
 <402dd676-ce8b-6691-03ff-cb80aab38ecf@oracle.com>
In-Reply-To: <402dd676-ce8b-6691-03ff-cb80aab38ecf@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 8 Apr 2019 17:01:50 +0800
Message-ID: <CACVXFVOBPyT+NBO-NQsoUKzOmhY8EuMPP5B_ApCHNfc1+6mkcw@mail.gmail.com>
Subject: Re: [PATCH V4 3/7] blk-mq: quiesce queue before updating nr_hw_queues
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 8, 2019 at 11:17 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Ming
>
> Why not add percpu_ref_tryget/put pair into run queue and requeue work,
> or before queue the work ?

If following this direction, most of block layer API might need the pair.

Also Jens has complained in another thread, the pair may introduce
1.2% performance
loss, then we should avoid it in the fast path, such as blk_mq_run_hw_queue().

Given it is required that request queue is alive from kobject view
before calling almost
every block layer API, this lifetime issue should be addressed easily
by moving the hctx
free into queue's release handler.

>
> Then freezing queue could really implement to freeze the queue and there will be
> no any queue activity after freeze, including run queue and requeue work.

The queue activity is just block layer internal thing, not related
with driver, so not a big
deal by dealing with freeing hctx resources in release handler.

Thanks,
Ming Lei
