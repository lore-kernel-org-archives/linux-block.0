Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AF1C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 09:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2872C2087D
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 09:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAJKZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:10:25 -0400
Received: from verein.lst.de ([213.95.11.211]:52584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIAJKY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 05:10:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C240F68CEC; Tue,  1 Sep 2020 11:10:20 +0200 (CEST)
Date:   Tue, 1 Sep 2020 11:10:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block: release disk reference in hd_struct_free_work
Message-ID: <20200901091020.GA4639@lst.de>
References: <20200901090033.313997-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901090033.313997-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 01, 2020 at 05:00:33PM +0800, Ming Lei wrote:
>  	struct hd_struct *part =
>  		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
> +	struct gendisk *disk = part_to_disk(part);
> +
> +	/*
> +	 * Release disk reference grabbed in delete_partition, and it should
> +	 * have been done in hd_struct_free(), however device's release
> +	 * handler can't be run in percpu_ref's ->release() callback because
> +	 * it is run via call_rcu().
> +	 */
> +	put_device(disk_to_dev(disk));

The fix looks good, but the comment reads a little strange.  What about:

	/*
	 * Release the disk reference acquired in delete_partition here.
	 * We can't release it in hd_struct_free because the final put_device
	 * needs process context and thus can't be run directly from a
	 * percpu_ref ->release handler.
	 */
