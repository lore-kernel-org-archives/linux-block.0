Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33966 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbdCaUq5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2017 16:46:57 -0400
Received: by mail-pg0-f50.google.com with SMTP id 21so81357202pgg.1
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2017 13:46:57 -0700 (PDT)
Date: Fri, 31 Mar 2017 13:46:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com
Subject: Re: [PATCH v2] blk-mq: remap queues when adding/removing hardware
 queues
Message-ID: <20170331204603.GB11462@vader>
References: <20170331204428.GM20181@localhost.localdomain>
 <c14ba78ad1898eef31415e86383e3b5a8ad082b9.1490992756.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c14ba78ad1898eef31415e86383e3b5a8ad082b9.1490992756.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 31, 2017 at 01:43:41PM -0700, Omar Sandoval wrote:
> @@ -2634,6 +2640,7 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_unfreeze_queue(q);
> +

Stupid whitespace damage...
