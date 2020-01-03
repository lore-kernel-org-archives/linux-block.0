Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F2AC00523
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 23:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EB322B48
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 23:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ThgpKfwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgACXpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:45:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36280 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgACXpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 18:45:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so24068120pgc.3
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 15:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZwtqDM+h15MW8Y/5G7f6TCYMLF2PzMAcob8NuUMNRg=;
        b=ThgpKfwVBG9yixr167Xbo/T0rPRjZS+p2JpENibBChiM/4hqjmVTjU8Oav7LoQ3o19
         0lnf/VqnOFtFQD25uVxulfIJyQ7d3aSZ9DI8kfAQ9h6IMsgJ4MDZWVey1y1g363X39Cf
         yImo+K4/g+y6zo87aulxyHFXmuyhhr50epNnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZwtqDM+h15MW8Y/5G7f6TCYMLF2PzMAcob8NuUMNRg=;
        b=ks1uyqawduY8LlXjuJWxiBnHYqNIBmPMlbGTCs9Hw5XsSDaf7fmd5t+m7+IgY6n/fe
         6mJmGZF5W05C0pIpZ6pCpD4qZsuCko/m2TXb2eBzwS0kUxFpUn+tHDGses9ZkUqnH6IK
         8LWIcTn2Vi2V530hu3RSI06IdTLOzOPUc0JEOyiDXxz9CeX2Gc8JkH0ltbpb47ah7i6f
         AYsrIuRmRkkI59M6TbC6wFwaRi1sWGiARyM61SgebaELUDMF+PP+pqjfCqpt2gBzaKxY
         tAvjDxFcd2Ua8izB5P3Wido+szacHG87BvnBxqkaY7cV0XVoPfrKIL15zGAFFhR6FRFb
         4M0g==
X-Gm-Message-State: APjAAAWV0y1+SQ81rUoKI4En8ka4ZRgmSVBknClV9/UqDdkInl6WM27m
        a+dQCEh4pg5lqsoSLVip72kGeQ==
X-Google-Smtp-Source: APXvYqz2jHJbQvzLdVfQqi940Z0sTlmk3klvawzH7dC9T8hRspVlytJTW5tnGFHRFifOgZo15rwQXw==
X-Received: by 2002:aa7:8f33:: with SMTP id y19mr94366977pfr.47.1578095122512;
        Fri, 03 Jan 2020 15:45:22 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x132sm67521960pfc.148.2020.01.03.15.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:45:21 -0800 (PST)
Date:   Fri, 3 Jan 2020 18:45:21 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Hou Tao <houtao1@huawei.com>, Yufen Yu <yuyufen@huawei.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com,
        hch@lst.de, zhengchuan@huawei.com, yi.zhang@huawei.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20200103234521.GG189259@google.com>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20191231231158.GW13449@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231231158.GW13449@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 03:11:58PM -0800, Paul E. McKenney wrote:
> On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
> > Hi,
> > 
> > On 2019/12/31 19:09, Yufen Yu wrote:
> > > When delete partition executes concurrently with IOs issue,
> > > it may cause use-after-free on part in disk_map_sector_rcu()
> > > as following:
> > snip
> > 
> > > 
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index ff6268970ddc..39fa8999905f 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
> > >  		part = rcu_dereference(ptbl->part[i]);
> > >  
> > >  		if (part && sector_in_part(part, sector)) {
> > snip
> > 
> > >  			rcu_assign_pointer(ptbl->last_lookup, part);
> > > +			part = rcu_dereference(ptbl->part[i]);
> > > +			if (part == NULL) {
> > > +				rcu_assign_pointer(ptbl->last_lookup, NULL);
> > > +				break;
> > > +			}
> > >  			return part;
> > >  		}
> > >  	}
> > 
> > Not ensure whether the re-read can handle the following case or not:
> > 
> > process A                                 process B                          process C
> > 
> > disk_map_sector_rcu():                    delete_partition():               disk_map_sector_rcu():
> > 
> > rcu_read_lock
> > 
> >   // need to iterate partition table
> >   part[i] != NULL   (1)                   part[i] = NULL (2)
> >                                           smp_mb()
> >                                           last_lookup = NULL (3)
> >                                           call_rcu()  (4)
> >     last_lookup = part[i] (5)
> > 
> > 
> >                                                                              rcu_read_lock()
> >                                                                              read last_lookup return part[i] (6)
> >                                                                              sector_in_part() is OK (7)
> >                                                                              return part[i] (8)
> 
> Just for the record...
> 
> Use of RCU needs to ensure that readers cannot access the to-be-freed
> structure -before- invoking call_rcu().  Which does look to happen here
> with the "last_lookup = NULL".  But in addition, the callback needs to
> get access to the to-be-freed structure via some sideband (usually the
> structure passed to call_rcu()), not from the reader-accessible structure.
> 
> Or am I misinterpreting this sequence of events?

If I understand correctly, the issue described above is there are 2 threads
setting last_lookup pointer simultaneously, one of them is NULLing it and
waiting for a GP before freeing it (process B above), while the other is
assigning to it concurrently after it was just NULLed (process A). Meanwhile
process C starts a reader section *after* the GP by process B already started
and accesses the reassigned pointer causing use-after-free.

Did I miss something?

I believe the fix is what Tao already posted which is to use refcounts so
that the destructor does not free it while references are already held. Is
that what the final fix is going to be? That other thread is pretty long so I
lost track a bit..

thanks,

 - Joel



> 							Thanx, Paul
> 
> >   part[i] == NULL (9)
> >       last_lookup = NULL (10)
> >   rcu_read_unlock() (11)
> >                                            one RCU grace period completes
> >                                            __delete_partition() (12)
> >                                            free hd_partition (13)
> >                                                                              // use-after-free
> >                                                                              hd_struct_try_get(part[i])  (14)
> > 
> > * the number in the parenthesis is the sequence of events.
> > 
> > Maybe RCU experts can shed some light on this problem, so cc +paulmck@kernel.org, +joel@joelfernandes.org and +RCU maillist.
> > 
> > If the above case is possible, maybe we can fix the problem by pinning last_lookup through increasing its ref-count
> > (the following patch is only compile tested):
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 6e8543ca6912..179e0056fae1 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
> >  		part = rcu_dereference(ptbl->part[i]);
> > 
> >  		if (part && sector_in_part(part, sector)) {
> > -			rcu_assign_pointer(ptbl->last_lookup, part);
> > +			struct hd_struct *old;
> > +
> > +			if (!hd_struct_try_get(part))
> > +				break;
> > +
> > +			old = xchg(&ptbl->last_lookup, part);
> > +			if (old)
> > +				hd_struct_put(old);
> >  			return part;
> >  		}
> >  	}
> > @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk *disk,
> >  	rcu_assign_pointer(disk->part_tbl, new_ptbl);
> > 
> >  	if (old_ptbl) {
> > -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> > +		struct hd_struct *part;
> > +
> > +		part = xchg(&old_ptbl->last_lookup, NULL);
> > +		if (part)
> > +			hd_struct_put(part);
> >  		kfree_rcu(old_ptbl, rcu_head);
> >  	}
> >  }
> > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > index 98d60a59b843..441c1c591c04 100644
> > --- a/block/partition-generic.c
> > +++ b/block/partition-generic.c
> > @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int partno)
> >  		return;
> > 
> >  	rcu_assign_pointer(ptbl->part[partno], NULL);
> > -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> > +	if (cmpxchg(&ptbl->last_lookup, part, NULL) == part)
> > +		hd_struct_put(part);
> >  	kobject_put(part->holder_dir);
> >  	device_del(part_to_dev(part));
> > 
> > -- 
> > 2.22.0
> > 
> > Regards,
> > Tao
> > 
> > 
> > > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > > index 1d20c9cf213f..1e0065ed6f02 100644
> > > --- a/block/partition-generic.c
> > > +++ b/block/partition-generic.c
> > > @@ -284,6 +284,13 @@ void delete_partition(struct gendisk *disk, int partno)
> > >  		return;
> > >  
> > >  	rcu_assign_pointer(ptbl->part[partno], NULL);
> > > +	/*
> > > +	 * Without the memory barrier, disk_map_sector_rcu()
> > > +	 * may read the old value after overwriting the
> > > +	 * last_lookup. Then it can not clear last_lookup,
> > > +	 * which may cause use-after-free.
> > > +	 */
> > > +	smp_mb();
> > >  	rcu_assign_pointer(ptbl->last_lookup, NULL);
> > >  	kobject_put(part->holder_dir);
> > >  	device_del(part_to_dev(part));
> > > 
> > 
