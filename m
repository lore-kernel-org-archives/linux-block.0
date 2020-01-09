Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5DBC33C9E
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 01:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042F0205F4
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 01:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk6ZJSBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAIBgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:36:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23787 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgAIBgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 20:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578533767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YhyWrWDGvcl94uzmvSKGpPrbMTLcTs6IkrsCj7b5ty0=;
        b=Mk6ZJSBj+49Qp6a8Qk7+b87KB6dyj5tdolXfWE/E1/+hOD3WlkRC15kZvohxGr6FxBq24i
        MfDPg/ypfO8Svjd04mI0SiZUZj1EJqgaNkYwURs2U76cxq+XaQtkSBSUZMPjV04BZ+NKM2
        UDMwLKWDVnycv7KlXRH/gp4EMhzaiZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-CX9vaYQMOhG1QaRRuC85zQ-1; Wed, 08 Jan 2020 20:36:03 -0500
X-MC-Unique: CX9vaYQMOhG1QaRRuC85zQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8948024D2;
        Thu,  9 Jan 2020 01:36:01 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA79210842A9;
        Thu,  9 Jan 2020 01:35:55 +0000 (UTC)
Date:   Thu, 9 Jan 2020 09:35:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, houtao1@huawei.com,
        hch@lst.de, yi.zhang@huawei.com, zhengchuan@huawei.com
Subject: Re: [PATCH] block: cache index instead of part self to avoid
 use-after-free
Message-ID: <20200109013551.GB9655@ming.t460p>
References: <20200106073510.10825-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106073510.10825-1-yuyufen@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 06, 2020 at 03:35:10PM +0800, Yufen Yu wrote:
> When delete partition executes concurrently with IOs issue,
> it may cause use-after-free on part in disk_map_sector_rcu()
> as following:
> 
> blk_account_io_start(req1)  delete_partition  blk_account_io_start(req2)
> 
> rcu_read_lock()
> disk_map_sector_rcu
> part = rcu_dereference(ptbl->part[4])
>                            rcu_assign_pointer(ptbl->part[4], NULL);
>                            rcu_assign_pointer(ptbl->last_lookup, NULL);
> rcu_assign_pointer(ptbl->last_lookup, part);
> 
>                            hd_struct_kill(part)
> !hd_struct_try_get
>   part = &rq->rq_disk->part0;
> rcu_read_unlock()
>                            __delete_partition
>                            call_rcu
>                                             rcu_read_lock
>                                             disk_map_sector_rcu
>                                             part = rcu_dereference(ptbl->last_lookup);
> 
>                            delete_partition_work_fn
>                            free(part)
>                                             hd_struct_try_get(part)
>                                             BUG_ON use-after-free
> 
> req1 try to get 'ptbl->part[4]', while the part is beening
> deleted. Although the delete_partition() will set last_lookup
> as NULL, req1 can overwrite it as 'part[4]' again.
> 
> After calling call_rcu() and free() for the part, req2 can
> access the part by last_lookup, resulting in use after free.
> 
> In fact, this bug has been reported by syzbot:
>     https://lkml.org/lkml/2019/1/4/357
> 
> To fix the bug, we try to cache index of part[] instead of
> part[i] itself in last_lookup. Even if the index may been
> re-assign, others can either get part[i] as value of NULL,
> or get the new allocated part[i] after call_rcu. Both of
> them is okay.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/genhd.c             | 15 +++++++++------
>  block/partition-generic.c |  2 +-
>  include/linux/genhd.h     |  3 ++-
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..97447281a4f5 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -282,18 +282,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>  	struct disk_part_tbl *ptbl;
>  	struct hd_struct *part;
>  	int i;
> +	int last_lookup;
>  
>  	ptbl = rcu_dereference(disk->part_tbl);
> -
> -	part = rcu_dereference(ptbl->last_lookup);
> -	if (part && sector_in_part(part, sector))
> -		return part;
> +	last_lookup = READ_ONCE(ptbl->last_lookup);
> +	if (last_lookup > 0 && last_lookup < ptbl->len) {
> +		part = rcu_dereference(ptbl->part[last_lookup]);
> +		if (part && sector_in_part(part, sector))
> +			return part;
> +	}
>  
>  	for (i = 1; i < ptbl->len; i++) {
>  		part = rcu_dereference(ptbl->part[i]);
>  
>  		if (part && sector_in_part(part, sector)) {
> -			rcu_assign_pointer(ptbl->last_lookup, part);
> +			WRITE_ONCE(ptbl->last_lookup, i);
>  			return part;
>  		}
>  	}
> @@ -1263,7 +1266,7 @@ static void disk_replace_part_tbl(struct gendisk *disk,
>  	rcu_assign_pointer(disk->part_tbl, new_ptbl);
>  
>  	if (old_ptbl) {
> -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> +		WRITE_ONCE(old_ptbl->last_lookup, 0);
>  		kfree_rcu(old_ptbl, rcu_head);
>  	}
>  }
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 1d20c9cf213f..a9fd24ae3acb 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -284,7 +284,7 @@ void delete_partition(struct gendisk *disk, int partno)
>  		return;
>  
>  	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +	WRITE_ONCE(ptbl->last_lookup, 0);
>  	kobject_put(part->holder_dir);
>  	device_del(part_to_dev(part));
>  
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 8bb63027e4d6..9be4fb8f8b8b 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -160,7 +160,8 @@ enum {
>  struct disk_part_tbl {
>  	struct rcu_head rcu_head;
>  	int len;
> -	struct hd_struct __rcu *last_lookup;
> +	/* Cache last lookup part[] index */
> +	int last_lookup;
>  	struct hd_struct __rcu *part[];
>  };

As we discussed in the following link:

https://lore.kernel.org/linux-block/5cc465cc-d68c-088e-0729-2695279c7853@huawei.com/T/#m9a959cc91ff8c6387f83aa5c505581159b5b6571

This way works, but adding a little overhead to the fast path, one indirect
memory reference, especially ->part[->last_lookup] may take one extra cacheline.

I will post one patch to fix the issue without adding the extra overhead.


Thanks,
Ming

