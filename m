Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE28C433EF
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72D560F4A
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 13:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356121AbhIINry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 09:47:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356157AbhIINoB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Sep 2021 09:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631194966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n9yyglc648zrXRd4AVW4tP74FHofD3/df+6dNncY9Pg=;
        b=CO8vWqg4jxBXqdTdjSJ50KB/h3GlikvsbEYC3bpvdzdV/q9C01hnztEQNm4a5HkzY0w6KO
        nb3oFwG6BUOXu0WESlCH/XgL3989SBe2mtzct2ajLUmCTnJSIG/w5C2qLpJ1YOX8rHJ/yW
        H31BzQ29GN8WOEX69xIZbzsm8Ecbz/8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-8QHh8eRlMdmwbGJmgGvG0g-1; Thu, 09 Sep 2021 09:42:45 -0400
X-MC-Unique: 8QHh8eRlMdmwbGJmgGvG0g-1
Received: by mail-ej1-f72.google.com with SMTP id ne21-20020a1709077b95b029057eb61c6fdfso805067ejc.22
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 06:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9yyglc648zrXRd4AVW4tP74FHofD3/df+6dNncY9Pg=;
        b=r02T7GmM5VjMXF16wryxyIzkpdybQBh7H0o3qGlKTLQLeF/vgTdZzhwDJcZuLUIwTA
         6ZHMY0LWxYlfVA8ECxipZks7BZK7qlVd4KyD/rR0EyZw+qliU0riWHqNnUzzMKpZ7BrM
         CNlYcowXL9gdwjrDc6HCUQW+hx24FjnwHXBk0JG93s/d4by0ml2gOWotru2MLX8nltzM
         lRcwahI2gTaB3TMkUf6SBnA3xKI1ILKJuIIVeaARVeLlQwpBbPkDe+TI2HgktTLv9/Ou
         emUXl9WhtqqWo7v8ik3InuLY3eVnHWzjz2FBTF3iLPB9qh+JtXWKaHrQMS8EYymVCYPH
         PKyA==
X-Gm-Message-State: AOAM532bi9fdEzyUtVqg6S94v6OAjWbf3g283/SmC8e3JVxfNno3Pi4C
        m/B+wYemhN+x64ugjmQ+otf8mWGr5vwCPGQD+Gi4tHCkF8Gn82EZGT39sjD8G+xHw3nN9eujQef
        /BdR3+MioD9t3zN51hWH0weQ=
X-Received: by 2002:a17:907:8693:: with SMTP id qa19mr3393409ejc.497.1631194964155;
        Thu, 09 Sep 2021 06:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywg/VJhF4XMVecjE+sPO8g/1PS5O4JAqpPXl2kjl3hyVJTihD7bfJVln+dRryMMPsNiUjk1w==
X-Received: by 2002:a17:907:8693:: with SMTP id qa19mr3393389ejc.497.1631194963948;
        Thu, 09 Sep 2021 06:42:43 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
        by smtp.gmail.com with ESMTPSA id o21sm1078830edc.47.2021.09.09.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:42:43 -0700 (PDT)
Date:   Thu, 9 Sep 2021 09:42:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, hch@infradead.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        israelr@nvidia.com, nitzanc@nvidia.com, oren@nvidia.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210909094001-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
 <20210905120234-mutt-send-email-mst@kernel.org>
 <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
 <20210906071957-mutt-send-email-mst@kernel.org>
 <1cbbe6e2-1473-8696-565c-518fc1016a1a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cbbe6e2-1473-8696-565c-518fc1016a1a@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 02:59:40PM +0300, Max Gurtovoy wrote:
> 
> On 9/6/2021 2:20 PM, Michael S. Tsirkin wrote:
> > On Mon, Sep 06, 2021 at 01:31:32AM +0300, Max Gurtovoy wrote:
> > > On 9/5/2021 7:02 PM, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> > > > > On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > > > > > Sometimes a user would like to control the amount of IO queues to be
> > > > > > created for a block device. For example, for limiting the memory
> > > > > > footprint of virtio-blk devices.
> > > > > > 
> > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > ---
> > > > > > 
> > > > > > changes from v1:
> > > > > >    - use param_set_uint_minmax (from Christoph)
> > > > > >    - added "Should > 0" to module description
> > > > > > 
> > > > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > > > ---
> > > > > >    drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> > > > > >    1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > index 4b49df2dfd23..9332fc4e9b31 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -24,6 +24,22 @@
> > > > > >    /* The maximum number of sg elements that fit into a virtqueue */
> > > > > >    #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > > > +static int virtblk_queue_count_set(const char *val,
> > > > > > +		const struct kernel_param *kp)
> > > > > > +{
> > > > > > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > > > +}
> > 
> > Hmm which tree is this for?
> 
> I've mentioned in the note that it apply on branch for-5.15/drivers. But now
> you can apply it on linus/master as well.
> 
> 
> > 
> > > > > > +
> > > > > > +static const struct kernel_param_ops queue_count_ops = {
> > > > > > +	.set = virtblk_queue_count_set,
> > > > > > +	.get = param_get_uint,
> > > > > > +};
> > > > > > +
> > > > > > +static unsigned int num_io_queues;
> > > > > > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > > > > > +MODULE_PARM_DESC(num_io_queues,
> > > > > > +		 "Number of IO virt queues to use for blk device. Should > 0");
> > 
> > 
> > better:
> > 
> > +MODULE_PARM_DESC(num_io_request_queues,
> > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> 
> You proposed it and I replied on it bellow.


Can't say I understand 100% what you are saying. Want to send
a description that does make sense to you but
also reflects reality? 0 is the default so
"should > 0" besides being ungrammatical does not seem t"
reflect what it does ...

> 
> > 
> > 
> > > > > > +
> > > > > >    static int major;
> > > > > >    static DEFINE_IDA(vd_index_ida);
> > > > > > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > > > >    	if (err)
> > > > > >    		num_vqs = 1;
> > > > > > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > > > +	num_vqs = min_t(unsigned int,
> > > > > > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > > > > > +			num_vqs);
> > > > > If you respin, please consider calling them request queues. That's the
> > > > > terminology from the VIRTIO spec and it's nice to keep it consistent.
> > > > > But the purpose of num_io_queues is clear, so:
> > > > > 
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > I did this:
> > > > +static unsigned int num_io_request_queues;
> > > > +module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
> > > > +MODULE_PARM_DESC(num_io_request_queues,
> > > > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> > > The parameter is writable and can be changed and then new devices might be
> > > probed with new value.
> > > 
> > > It can't be zero in the code. we can change param_set_uint_minmax args and
> > > say that 0 says nr_cpus.
> > > 
> > > I'm ok with the renaming but I prefer to stick to the description we gave in
> > > V3 of this patch (and maybe enable value of 0 as mentioned above).

