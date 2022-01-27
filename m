Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774F5C433FE
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiA0Jy5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiA0Jyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:54:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A24C06173B
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XgUA1YBYqVeHLkVdie4mVmzR3LLowVluiNzQT8RaxUo=; b=E1Rrp757Q4wUgGPlqY4i8t6zYl
        LUOS91sOV+SIBMrPqvoTaajApsxyb9VrtF6kxVvdp+Chm6LC2MPnYNCBZGRwt4lYQy6080GpVQBQr
        9KygReTEgiD7ov1a4BedzZCKTOjGcygMKlAN5xe8U7C3BN2G7U1WKu5KO8I2MpnlUt1oWrWH9eDe6
        UaSRiOu/hoFIvoTn4QGCm+LUYbQJ6B3rgffxN014p/qJWxozBqqkirZek2zeMHvki+XtAJxA+Wexu
        V3VyO577fnW9yfl1pOMxuL+t3cpfwPY9s5zxhAgY++bXlWquNHPfq2EdxXZXJeu9GZSN6ngVP8HhL
        eJIxg9gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1UV-00Ezpl-52; Thu, 27 Jan 2022 09:54:55 +0000
Date:   Thu, 27 Jan 2022 01:54:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [RFC] blk-mq: complete request locallly if not in interrupt
 context
Message-ID: <YfJr76LOsSWLUqk2@infradead.org>
References: <20220127092143.1808-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127092143.1808-1-xiaoguang.wang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 05:21:43PM +0800, Xiaoguang Wang wrote:
> For block devices that call blk_mq_complete_request() to end request
> in process context, it's pointless to redirect the completion to be
> done in block soft-irq, also blk_mq_raise_softirq() isnt't a very
> light operation, which contains preempt and hard irq disable, wake
> up ksoftirqd in non-interrupt context.
> 
> I found this issue while I use tcm_loop and tcmu(backstore is file)
> to evaluate performance, tcm_loop end request in workqueue.
> Without this patch: libaio engine, direct io, randwrite, io size 128k
> job0: (groupid=0, jobs=1): err= 0: pid=20876: Thu Jan 27 15:33:45 2022
>   write: IOPS=15.7k, BW=1966MiB/s (2062MB/s)(115GiB/60001msec); 0 zone resets
>     slat (nsec): min=5675, max=83552, avg=8689.69, stdev=996.96
>     clat (usec): min=231, max=99977, avg=498.89, stdev=501.69
>      lat (usec): min=291, max=99986, avg=507.70, stdev=501.69
> 
> With this patch:
> job0: (groupid=0, jobs=1): err= 0: pid=12813: Thu Jan 27 15:50:46 2022
>   write: IOPS=16.8k, BW=2101MiB/s (2203MB/s)(123GiB/60001msec); 0 zone resets
>     slat (usec): min=5, max=125, avg=14.12, stdev=10.31
>     clat (usec): min=306, max=65380, avg=460.78, stdev=506.24
>      lat (usec): min=341, max=65389, avg=475.04, stdev=505.27
> 
> Which improves throughput and reduces lat.

Just use blk_mq_complete_request_direct for callers that know they are
not in interrupt context.
