Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30A0C34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E1320801
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 12:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBSMzK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:55:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:37320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgBSMzJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 07:55:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C37E2B488;
        Wed, 19 Feb 2020 12:55:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD4BF1E0EB5; Wed, 19 Feb 2020 13:55:05 +0100 (CET)
Date:   Wed, 19 Feb 2020 13:55:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org, jack@suse.cz, bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200219125505.GP16121@quack2.suse.cz>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
 <20200213135809.GH88887@mtj.thefacebook.com>
 <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
 <20200214140514.GL88887@mtj.thefacebook.com>
 <32a14db2-65e0-5d5c-6c53-45b3474d841d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32a14db2-65e0-5d5c-6c53-45b3474d841d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

On Sat 15-02-20 21:54:08, Yufen Yu wrote:
> On 2020/2/14 22:05, Tejun Heo wrote:
> > Hello,
> > 
> > On Fri, Feb 14, 2020 at 10:50:01AM +0800, Yufen Yu wrote:
> > > > So, unregistering can leave ->dev along and re-registering can test
> > > > whether it's NULL and if not put the existing one and put a new one
> > > > there. Wouldn't that work?
> > > 
> > > Do you mean set bdi->dev as 'NULL' in call_rcu() callback function
> > > (i.e. bdi_release_device()) and test 'bdi->dev' in bdi_register_va()?
> > > 
> > > I think that may do not work.
> > > We cannot make sure the order of rcu callback function and re-registering.
> > > Then bdi_release_device() may put the new allocated device by re-registering.
> > 
> > No, I meant not freeing bdi->dev on deregistration and only doing so
> > when it actually needs to - on re-registration or release. So, sth
> > like the following.
> > 
> > * Unregister: Unregister bdi->dev but don't free it. Leave the pointer
> >    alone.
> > 
> > * Re-register: If bdi->dev is not null, initiate RCU-free and update
> >    bdi->dev to the new dev.
> >
> > * Release: If bdi->dev is not NULL, initiate RCU-free of it.
> 
> Okay, I think we can do that.
> 
> When do re-register, we need to update bdi->dev as 'NULL' or the new dev
> before invoking call_rcu() to free '->dev'. So readers started after call_rcu()
> cannot read the old dev, like:
> 
> bdi_register_va()
> {
> 	...
> 	if (bdi->dev) {
> 		//rcu_assgin_pointer(bdi->dev, new_dev);
> 		rcu_assgin_pointer(bdi->dev, NULL);
> 		call_rcu();//rcu callback function will free the old dev
> 	}
> 	...
> }
> 
> After assigning new value for bdi->dev, rcu callback function cannot get
> the old device. So I think we may need to replace the '->dev' with a new
> struct pointer, in which includes '->dev' and 'rcu_head'. We pass the
> struct.rcu_head pointer to call_rcu() and then it can get old dev address.
> 
> IMO, maybe we can maintain the original code logic, fix the problem like:

I've now noticed there's commit 68f23b8906 "memcg: fix a crash in wb_workfn
when a device disappears" from end of January which tries to address the
issue you're looking into. Now AFAIU the code is till somewhat racy after
that commit so I wanted to mention this mostly so that you fixup also the
new bdi_dev_name() while you're fixing blkg_dev_name().

Also I was wondering about one thing: If we really care about bdi->dev only
for the name, won't we be much better off with just copying the name to
bdi->name on registration? Sure it would consume a bit of memory for the
name copy but I don't think we really care and things would be IMO *much*
simpler that way... Yufen, Tejun, what do you think?

								Honza

> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 4fc87dee005a..e2de4a4e5392 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -185,6 +185,11 @@ struct bdi_writeback {
>  #endif
>  };
> 
> +struct bdi_rcu_device {
> +	struct device *dev;
> +	struct rcu_head rcu_head;
> +};
> +
>  struct backing_dev_info {
>  	u64 id;
>  	struct rb_node rb_node; /* keyed by ->id */
> @@ -219,7 +224,7 @@ struct backing_dev_info {
>  #endif
>  	wait_queue_head_t wb_waitq;
> 
> -	struct device *dev;
> +	struct bdi_rcu_device *rcu_dev;
>  	struct device *owner;
> 
>  	struct timer_list laptop_mode_wb_timer;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 62f05f605fb5..05f07ce19091 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -850,7 +850,7 @@ static int bdi_init(struct backing_dev_info *bdi)
>  {
>  	int ret;
> 
> -	bdi->dev = NULL;
> +	bdi->rcu_dev = NULL;
> 
>  	kref_init(&bdi->refcnt);
>  	bdi->min_ratio = 0;
> @@ -932,20 +932,28 @@ struct backing_dev_info *bdi_get_by_id(u64 id)
> 
>  int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  {
> -	struct device *dev;
>  	struct rb_node *parent, **p;
> +	struct bdi_rcu_device *rcu_dev;
> 
> -	if (bdi->dev)	/* The driver needs to use separate queues per device */
> +	/* The driver needs to use separate queues per device */
> +	if (bdi->rcu_dev)
>  		return 0;
> 
> -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
> -	if (IS_ERR(dev))
> -		return PTR_ERR(dev);
> +	rcu_dev = kzalloc(sizeof(struct bdi_rcu_device), GFP_KERNEL);
> +	if (!rcu_dev)
> +		return -ENOMEM;
> +
> +	rcu_dev->dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0),
> +						bdi, fmt, args);
> +	if (IS_ERR(rcu_dev->dev)) {
> +		kfree(rcu_dev);
> +		return PTR_ERR(rcu_dev->dev);
> +	}
> 
>  	cgwb_bdi_register(bdi);
> -	bdi->dev = dev;
> +	bdi->rcu_dev = rcu_dev;
> 
> -	bdi_debug_register(bdi, dev_name(dev));
> +	bdi_debug_register(bdi, dev_name(rcu_dev->dev));
>  	set_bit(WB_registered, &bdi->wb.state);
> 
>  	spin_lock_bh(&bdi_lock);
> @@ -1005,17 +1013,28 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
>  	synchronize_rcu_expedited();
>  }
> 
> +static void bdi_put_device_rcu(struct rcu_head *rcu)
> +{
> +	struct bdi_rcu_device *rcu_dev = container_of(rcu,
> +			struct bdi_rcu_device, rcu_head);
> +	put_device(rcu_dev->dev);
> +	kfree(rcu_dev);
> +}
> +
>  void bdi_unregister(struct backing_dev_info *bdi)
>  {
> +	struct bdi_rcu_device *rcu_dev = bdi->rcu_dev;
>  	/* make sure nobody finds us on the bdi_list anymore */
>  	bdi_remove_from_list(bdi);
>  	wb_shutdown(&bdi->wb);
>  	cgwb_bdi_unregister(bdi);
> 
> -	if (bdi->dev) {
> +	if (rcu_dev) {
>  		bdi_debug_unregister(bdi);
> -		device_unregister(bdi->dev);
> -		bdi->dev = NULL;
> +		get_device(rcu_dev->dev);
> +		device_unregister(rcu_dev->dev);
> +		rcu_assign_pointer(bdi->rcu_dev, NULL);
> +		call_rcu(&rcu_dev->rcu_head, bdi_put_device_rcu);
>  	}
> 
>  	if (bdi->owner) {
> @@ -1031,7 +1050,7 @@ static void release_bdi(struct kref *ref)
> 
>  	if (test_bit(WB_registered, &bdi->wb.state))
>  		bdi_unregister(bdi);
> -	WARN_ON_ONCE(bdi->dev);
> +	WARN_ON_ONCE(bdi->rcu_dev);
>  	wb_exit(&bdi->wb);
>  	cgwb_bdi_exit(bdi);
>  	kfree(bdi);
> 
> 
> 
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
