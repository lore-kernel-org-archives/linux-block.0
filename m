Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEEDC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068D12077B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCvd1Ydw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAHPHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:07:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgAHPHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 10:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yt5/k1DHhajT31FzlPb4kx21sxVNXs5EgZwMTBE+z4M=; b=aCvd1YdwglxV2IR+2qj0hsxxi
        2Zvx/+ieQpto9CKAh40nnEmd5j+6vQSMNpoDYyszYYxx/HL+pCazlIoyNbp4pLH4tnLRyCWt2u6+H
        smmXymG2Bmhp3TcjoUSthbaOw8oWkQFz3g7YQGeky8DP6R6QFCs8EPDTQBLoacfw8kqfEEf0OXlko
        4D9V3QuZdIHXLfTiiEfm39STC876rbbDa52Ho19LlNw/FXno7EnDlQmzUcp2YxucUus7qnIYctFUf
        zzDaMZmsK5v6Fw19zZx6tF5Z6SHAUIm1MHqq9tpNEJzwoK7Sf+B5Ghzvx1UNs6BtUoxhVd7CotYqm
        /9QKUwnKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipCvq-0000RH-7F; Wed, 08 Jan 2020 15:07:38 +0000
Date:   Wed, 8 Jan 2020 07:07:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     renxudong <renxudong1@huawei.com>
Cc:     Bob Liu <bob.liu@oracle.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        jens.axboe@oracle.com, namhyung@gmail.com, bharrosh@panasas.com,
        Mingfangsen <mingfangsen@huawei.com>, zhengbin13@huawei.com,
        Guiyao <guiyao@huawei.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-map: add kernel address validation in
 blk_rq_map_kern func
Message-ID: <20200108150738.GB18991@infradead.org>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
 <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
 <91b13d6f-04b5-28b0-ea1b-d99564ecc898@oracle.com>
 <bc469dc8-19b6-d979-c061-075e52a355b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc469dc8-19b6-d979-c061-075e52a355b0@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 02:51:04PM +0800, renxudong wrote:
> When we issued scsi cmd, oops occurred. The call stack was as follows.
> Call trace:
>  __memcpy+0x110/0x180
>  bio_endio+0x118/0x190
>  blk_update_request+0x94/0x378
>  scsi_end_request+0x48/0x2a8
>  scsi_io_completion+0xa4/0x6d0
>  scsi_finish_command+0xd4/0x138
>  scsi_softirq_done+0x13c/0x198
>  blk_done_softirq+0xc4/0x108
>  __do_softirq+0x120/0x324
>  run_ksoftirqd+0x44/0x60
>  smpboot_thread_fn+0x1ac/0x1e8
>  kthread+0x134/0x138
>  ret_from_fork+0x10/0x18
>  Since oops is in the process of scsi cmd done, we have not added oops info
> to the commit log.

What workload is this?  If the address is freed while the I/O is
in progress we have much deeper problem than what a virt_addr_valid
could paper over.
