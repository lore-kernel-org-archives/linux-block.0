Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE0DC433E1
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A9D207DA
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 00:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPbJ/b73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgFEA7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:59:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgFEA7c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 20:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591318770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLur4R5lDOwzTT5z+aMuteVhHnMPYzf9M5Uj5aswgfA=;
        b=cPbJ/b73z3lF5FDz4dNqnPG8+1PZ+g/wnC6VmH82hqZ/mgWwnEo5lZu/r2RcIrS/dDWket
        APkkM+x8A9YHeuBQA9UmNhmrXT+uM6oxJco6oYz+gVo5LHnbyuaBGButI36lBvja1czZ+9
        tQp78Tk8nBZwKF1FtVoU/CSoS1noDUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-a9qgIhK2Nd2v5vfnrAxveQ-1; Thu, 04 Jun 2020 20:59:27 -0400
X-MC-Unique: a9qgIhK2Nd2v5vfnrAxveQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BE11005512;
        Fri,  5 Jun 2020 00:59:26 +0000 (UTC)
Received: from T590 (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C379B75294;
        Fri,  5 Jun 2020 00:59:19 +0000 (UTC)
Date:   Fri, 5 Jun 2020 08:59:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200605005915.GA2368173@T590>
References: <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
 <20200604130058.GC2336493@T590>
 <83c37a8f-abfa-c1d1-e9d6-ccfdd344edb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c37a8f-abfa-c1d1-e9d6-ccfdd344edb3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 03:11:39PM +0100, John Garry wrote:
> > 
> > It isn't related with request->tag, what I meant is that you use
> > out-of-tree patch to enable multiple hw queue on hisi_sas, you have
> > to make the queue mapping correct, that said the exact queue mapping
> > from blk-mq's mapping has to be used, which is built from managed
> > interrupt affinity.
> > 
> > Please collect the following log:
> > 
> > 1) ./dump-io-irq-affinity $PCI_ID_OF_HBA
> > http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity
> > 
> 
> I had to hack this a bit for SAS HBA:
> 
> kernel version:
> Linux ubuntu 5.7.0-next-20200603-16498-gbfbfcda762d5 #405 SMP PREEMPT Thu
> Jun 4 14:19:49 BST 2020 aarch64 aarch64 aarch64 GNU/Linux
> -e 	irq 137, cpu list 16-19, effective list 16
> -e 	irq 138, cpu list 20-23, effective list 20
> -e 	irq 139, cpu list 24-27, effective list 24
> -e 	irq 140, cpu list 28-31, effective list 28
> -e 	irq 141, cpu list 32-35, effective list 32
> -e 	irq 142, cpu list 36-39, effective list 36
> -e 	irq 143, cpu list 40-43, effective list 40
> -e 	irq 144, cpu list 44-47, effective list 44
> -e 	irq 145, cpu list 48-51, effective list 48
> -e 	irq 146, cpu list 52-55, effective list 52
> -e 	irq 147, cpu list 56-59, effective list 56
> -e 	irq 148, cpu list 60-63, effective list 60
> -e 	irq 149, cpu list 0-3, effective list 0
> -e 	irq 150, cpu list 4-7, effective list 4
> -e 	irq 151, cpu list 8-11, effective list 8
> -e 	irq 152, cpu list 12-15, effective list 12
> 
> > 2) ./dump-qmap /dev/sdN
> > http://people.redhat.com/minlei/tests/tools/dump-qmap
> 
> 
> queue mapping for /dev/sda
> 	hctx0: default 16 17 18 19
> 	hctx1: default 20 21 22 23
> 	hctx2: default 24 25 26 27
> 	hctx3: default 28 29 30 31
> 	hctx4: default 32 33 34 35
> 	hctx5: default 36 37 38 39
> 	hctx6: default 40 41 42 43
> 	hctx7: default 44 45 46 47
> 	hctx8: default 48 49 50 51
> 	hctx9: default 52 53 54 55
> 	hctx10: default 56 57 58 59
> 	hctx11: default 60 61 62 63
> 	hctx12: default 0 1 2 3
> 	hctx13: default 4 5 6 7
> 	hctx14: default 8 9 10 11
> 	hctx15: default 12 13 14 15

OK, the queue mapping is correct.

As I mentioned in another thread, the real hw tag may be set as wrong.

You have to double check your cooked tag allocation algorithm and see if it
can work well when more requests than real hw queue depth are queued to hisi_sas,
and the correct way is to return SCSI_MLQUEUE_HOST_BUSY from .queuecommand().

Thanks,
Ming

