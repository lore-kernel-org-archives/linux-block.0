Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FCFC43217
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiKHHp3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiKHHpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:45:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B72E3B;
        Mon,  7 Nov 2022 23:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ewPgwNxHVRc6WKIxHPyiXBqFyHds+o1ahLHZvZE1xg=; b=ifVK8+CAykZj3L4fdfuhXMDk2i
        v1DlvRxgQKCMYF8PWsCgD5n9arpFiI+a8YIMXBTWvS8iqgGICv8s7OcKsxleKbDs4JstwO5GMHhTy
        pfFncrihrqM5/qQduqLlG1SIgE/iRS8cTi4DJ66bKOMPOYEx2xuVwzrC0KxUZBKbx2O1p8SXuEQ35
        VdTHpeUF4y3TBoT0j/s+phPUoQDpvCKqg8iuVU1brcw55tqq1GgxBZ0OYDe038SODTVfvGnCGLsAn
        WbRFFUtdAPutJIfEioEVNh7bgueMnNVKKfJNkLaGCPrzp6fMyVENpT7LMUcEKp/HZ4Fl15/Us5pcX
        t1avbwjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osJIA-003TRU-CB; Tue, 08 Nov 2022 07:45:06 +0000
Date:   Mon, 7 Nov 2022 23:45:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [RFC PATCH 3/4] io_uring/splice: support splice from
 ->splice_read to ->splice_read
Message-ID: <Y2oJAlV3xwqmJK0o@infradead.org>
References: <20221103085004.1029763-1-ming.lei@redhat.com>
 <20221103085004.1029763-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103085004.1029763-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 03, 2022 at 04:50:03PM +0800, Ming Lei wrote:
> The 1st ->splice_read produces buffer to the pipe of
> current->splice_pipe, and the 2nd ->splice_read consumes the buffer
> in this pipe.

This looks really ugly.  I think you want Linus and Al to look over
it at very least.

Also, what is going to happen if your ->splice_read instance does not
support the flag to magically do something entirely different?
