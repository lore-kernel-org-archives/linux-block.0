Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC774C2D0DE
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 01:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8E12085B
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 01:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avKJYtaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgABBXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:23:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45782 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgABBXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jan 2020 20:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577928213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsepRmJjvT4cYPy6QHyiU0FOUdA3CmEcRr+bW/pGgyA=;
        b=avKJYtaXNu3YKSlvu439j2WUdjTe17umPJWuzOwoitPTanvbuH5JqNWUzaqqzZDXtyCiHo
        6aponk52d/NkhxO2nK6czTdPTpEZsq2w7v/5VZZvrox9Nv+W89IOKcy7m7ZjDSVmoLD3Hs
        CW8vgAizz16t1dK5W5S9B/YqvpURLpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-NjYHBSVINhyEOiJSU7-ydQ-1; Wed, 01 Jan 2020 20:23:31 -0500
X-MC-Unique: NjYHBSVINhyEOiJSU7-ydQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 846B4420DB;
        Thu,  2 Jan 2020 01:23:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2141078E9E;
        Thu,  2 Jan 2020 01:23:19 +0000 (UTC)
Date:   Thu, 2 Jan 2020 09:23:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, zhengchuan@huawei.com,
        yi.zhang@huawei.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20200102012314.GB16719@ming.t460p>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2019/12/31 19:09, Yufen Yu wrote:
> > When delete partition executes concurrently with IOs issue,
> > it may cause use-after-free on part in disk_map_sector_rcu()
> > as following:
> snip
> 
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index ff6268970ddc..39fa8999905f 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
> >  		part = rcu_dereference(ptbl->part[i]);
> >  
> >  		if (part && sector_in_part(part, sector)) {
> snip
> 
> >  			rcu_assign_pointer(ptbl->last_lookup, part);
> > +			part = rcu_dereference(ptbl->part[i]);
> > +			if (part == NULL) {
> > +				rcu_assign_pointer(ptbl->last_lookup, NULL);
> > +				break;
> > +			}
> >  			return part;
> >  		}
> >  	}
> 
> Not ensure whether the re-read can handle the following case or not:
> 
> process A                                 process B                          process C
> 
> disk_map_sector_rcu():                    delete_partition():               disk_map_sector_rcu():
> 
> rcu_read_lock
> 
>   // need to iterate partition table
>   part[i] != NULL   (1)                   part[i] = NULL (2)
>                                           smp_mb()
>                                           last_lookup = NULL (3)
>                                           call_rcu()  (4)
>     last_lookup = part[i] (5)
> 
> 
>                                                                              rcu_read_lock()
>                                                                              read last_lookup return part[i] (6)
>                                                                              sector_in_part() is OK (7)
>                                                                              return part[i] (8)
> 
>   part[i] == NULL (9)
>       last_lookup = NULL (10)
>   rcu_read_unlock() (11)
>                                            one RCU grace period completes
>                                            __delete_partition() (12)
>                                            free hd_partition (13)
>                                                                              // use-after-free
>                                                                              hd_struct_try_get(part[i])  (14)
> 
> * the number in the parenthesis is the sequence of events.
> 
> Maybe RCU experts can shed some light on this problem, so cc +paulmck@kernel.org, +joel@joelfernandes.org and +RCU maillist.
> 
> If the above case is possible, maybe we can fix the problem by pinning last_lookup through increasing its ref-count
> (the following patch is only compile tested):
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 6e8543ca6912..179e0056fae1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>  		part = rcu_dereference(ptbl->part[i]);
> 
>  		if (part && sector_in_part(part, sector)) {
> -			rcu_assign_pointer(ptbl->last_lookup, part);
> +			struct hd_struct *old;
> +
> +			if (!hd_struct_try_get(part))
> +				break;
> +
> +			old = xchg(&ptbl->last_lookup, part);
> +			if (old)
> +				hd_struct_put(old);
>  			return part;
>  		}
>  	}
> @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk *disk,
>  	rcu_assign_pointer(disk->part_tbl, new_ptbl);
> 
>  	if (old_ptbl) {
> -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> +		struct hd_struct *part;
> +
> +		part = xchg(&old_ptbl->last_lookup, NULL);
> +		if (part)
> +			hd_struct_put(part);
>  		kfree_rcu(old_ptbl, rcu_head);
>  	}
>  }
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 98d60a59b843..441c1c591c04 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int partno)
>  		return;
> 
>  	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +	if (cmpxchg(&ptbl->last_lookup, part, NULL) == part)
> +		hd_struct_put(part);
>  	kobject_put(part->holder_dir);
>  	device_del(part_to_dev(part));

IMO this approach looks good.

Given partition is actually protected by percpu-refcount now, I guess the
RCU annotation for referencing ->part[partno] and ->last_lookup may not
be necessary, together with the part->rcu_work.


Thanks,
Ming

