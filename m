Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1822CC433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0407A61179
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 15:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhIIPmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231918AbhIIPmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 11:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631202053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBYiYhsVVzfTpEKTlWDA25Qp/Q4qm4nDo+fBNglD38I=;
        b=IqGsoPAsEq8DNaw/wMLktEVbjlZR+XdVR1srMIGPvPcqhOqG4VH6wrb9bM7wemVEEXyj+g
        m6VrKQu4VEb/8sf1fGpH8ZOP4bmRnplysvInHZEQkdNwTiwLazEpEuF5I5nRT1OIHYcoSn
        lGOtYa3KtHsJt/+uX0Op6W4ordjmYlc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-d1YRYv9OMHyDwNX3_rytBg-1; Thu, 09 Sep 2021 11:40:52 -0400
X-MC-Unique: d1YRYv9OMHyDwNX3_rytBg-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so932081wmj.8
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 08:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBYiYhsVVzfTpEKTlWDA25Qp/Q4qm4nDo+fBNglD38I=;
        b=tIqf0dkLsq8gzkpkbXOasjhoez3nEQydDmqm1orJ4h/IwNFZuIVaMmj2AtkRWLk8No
         WRxCyyHntEfBKuwryMGIAv19iTTNr+38rxG2cV21VZzSrSAHIUZR9N/BgUdolKsJB/Oy
         KpjEicLPbGeRW0/rPSmTcjJ32Z049TfT/SoCsBOh5IZcUwvWVSBHD8GUxhQnxF/f6rSv
         PA7BlRyraYo6gr+zoEPSvNZxtSJcgxQyemQQFtWiEu4g2zOamgMCtYwJcoUcz+4nMltB
         fef3gd/H/sbtVJf0lyfZ7z1HC5JeGJyudYxrMSMpNpPGv0h9sgxGheWVv94sjJeojjnJ
         NTsg==
X-Gm-Message-State: AOAM531D1fE6ZUZtG4+zO6U5V3IvXa+l377ZmBr3mlHmgsOPF5DvVaBu
        HemaEWyK7PWObm0bnOzE2RTHhO4kc3+c37JhMqQpuzV6drEJvHC4y3/D66ZhpEsie0ia9oMfae1
        bclw3rGyhRGned7RUw1LKLPM=
X-Received: by 2002:adf:e384:: with SMTP id e4mr4349336wrm.163.1631202050612;
        Thu, 09 Sep 2021 08:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Am4d/lKBmohH9Lzy/1jzcAVTjXLDkspGZBDFHm4AcucevN0az97m19jUsDd6QfUM7rXXsg==
X-Received: by 2002:adf:e384:: with SMTP id e4mr4349308wrm.163.1631202050439;
        Thu, 09 Sep 2021 08:40:50 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
        by smtp.gmail.com with ESMTPSA id 129sm1885672wmz.26.2021.09.09.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:40:49 -0700 (PDT)
Date:   Thu, 9 Sep 2021 11:40:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, hch@infradead.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        israelr@nvidia.com, nitzanc@nvidia.com, oren@nvidia.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210909114029-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
 <20210905120234-mutt-send-email-mst@kernel.org>
 <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
 <20210906071957-mutt-send-email-mst@kernel.org>
 <1cbbe6e2-1473-8696-565c-518fc1016a1a@nvidia.com>
 <20210909094001-mutt-send-email-mst@kernel.org>
 <456e1704-67e9-aac9-a82a-44fed65dd153@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456e1704-67e9-aac9-a82a-44fed65dd153@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 06:37:37PM +0300, Max Gurtovoy wrote:
> 
> On 9/9/2021 4:42 PM, Michael S. Tsirkin wrote:
> > On Mon, Sep 06, 2021 at 02:59:40PM +0300, Max Gurtovoy wrote:
> > > On 9/6/2021 2:20 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Sep 06, 2021 at 01:31:32AM +0300, Max Gurtovoy wrote:
> > > > > On 9/5/2021 7:02 PM, Michael S. Tsirkin wrote:
> > > > > > On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> > > > > > > On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > > > > > > > Sometimes a user would like to control the amount of IO queues to be
> > > > > > > > created for a block device. For example, for limiting the memory
> > > > > > > > footprint of virtio-blk devices.
> > > > > > > > 
> > > > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > changes from v1:
> > > > > > > >     - use param_set_uint_minmax (from Christoph)
> > > > > > > >     - added "Should > 0" to module description
> > > > > > > > 
> > > > > > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > > > > > ---
> > > > > > > >     drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> > > > > > > >     1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > > > index 4b49df2dfd23..9332fc4e9b31 100644
> > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > @@ -24,6 +24,22 @@
> > > > > > > >     /* The maximum number of sg elements that fit into a virtqueue */
> > > > > > > >     #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > > > > > +static int virtblk_queue_count_set(const char *val,
> > > > > > > > +		const struct kernel_param *kp)
> > > > > > > > +{
> > > > > > > > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > > > > > +}
> > > > Hmm which tree is this for?
> > > I've mentioned in the note that it apply on branch for-5.15/drivers. But now
> > > you can apply it on linus/master as well.
> > > 
> > > 
> > > > > > > > +
> > > > > > > > +static const struct kernel_param_ops queue_count_ops = {
> > > > > > > > +	.set = virtblk_queue_count_set,
> > > > > > > > +	.get = param_get_uint,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static unsigned int num_io_queues;
> > > > > > > > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > > > > > > > +MODULE_PARM_DESC(num_io_queues,
> > > > > > > > +		 "Number of IO virt queues to use for blk device. Should > 0");
> > > > 
> > > > better:
> > > > 
> > > > +MODULE_PARM_DESC(num_io_request_queues,
> > > > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> > > You proposed it and I replied on it bellow.
> > 
> > Can't say I understand 100% what you are saying. Want to send
> > a description that does make sense to you but
> > also reflects reality? 0 is the default so
> > "should > 0" besides being ungrammatical does not seem t"
> > reflect what it does ...
> 
> if you "modprobe virtio_blk" the previous behavior will happen.
> 
> You can't "modprobe virtio_blk num_io_request_queues=0" since the minimal
> value is 1.
> 
> So your description is not reflecting the code.
> 
> We can do:
> 
> MODULE_PARM_DESC(num_io_request_queues, "Number of request virt queues to use for blk device. Minimum value is 1 queue");

What's the default value? We should document that.

> > 
> > > > 
> > > > > > > > +
> > > > > > > >     static int major;
> > > > > > > >     static DEFINE_IDA(vd_index_ida);
> > > > > > > > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > > > > > >     	if (err)
> > > > > > > >     		num_vqs = 1;
> > > > > > > > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > > > > > +	num_vqs = min_t(unsigned int,
> > > > > > > > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > > > > > > > +			num_vqs);
> > > > > > > If you respin, please consider calling them request queues. That's the
> > > > > > > terminology from the VIRTIO spec and it's nice to keep it consistent.
> > > > > > > But the purpose of num_io_queues is clear, so:
> > > > > > > 
> > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > I did this:
> > > > > > +static unsigned int num_io_request_queues;
> > > > > > +module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
> > > > > > +MODULE_PARM_DESC(num_io_request_queues,
> > > > > > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> > > > > The parameter is writable and can be changed and then new devices might be
> > > > > probed with new value.
> > > > > 
> > > > > It can't be zero in the code. we can change param_set_uint_minmax args and
> > > > > say that 0 says nr_cpus.
> > > > > 
> > > > > I'm ok with the renaming but I prefer to stick to the description we gave in
> > > > > V3 of this patch (and maybe enable value of 0 as mentioned above).

