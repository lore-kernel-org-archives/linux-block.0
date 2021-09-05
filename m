Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F54EC433F5
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7745160F56
	for <linux-block@archiver.kernel.org>; Sun,  5 Sep 2021 15:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhIEPQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 11:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236426AbhIEPQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 5 Sep 2021 11:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630854924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZzmZ3cm/kvau4n2g5RTLrehaLVkdjZ73wl5vRun3Qc=;
        b=jSK9066dndq/16yyZBjVD5G0DhGL841NBQX95/08sI4ETdDbUXTWGI8788lkGLXBurmWa3
        eic/dwJ7/bEGq9U6YkgPzMlp+mwLEhKpXO2rDPnAPevhFIrHvcAbJrIw6SUHOfZDNZw2Hu
        Id2QV8oeQD0UGizoVFqZbUWG6vS3P6Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-udpEOYg8Oeexgt1hBDNd-A-1; Sun, 05 Sep 2021 11:15:23 -0400
X-MC-Unique: udpEOYg8Oeexgt1hBDNd-A-1
Received: by mail-ej1-f71.google.com with SMTP id yz13-20020a170906dc4d00b005c61ad936f0so1205159ejb.12
        for <linux-block@vger.kernel.org>; Sun, 05 Sep 2021 08:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ZzmZ3cm/kvau4n2g5RTLrehaLVkdjZ73wl5vRun3Qc=;
        b=XRWq07E4O0LFYbakpxsZ+jgGboERC/41h5dui0G4Pam5YDDTmLdEE2eJPdlY9Db2SA
         7QILOWqcCAEtT1sbyorCm9zhhAGI2sDkItqD3CucspUOT9fJDqc5dwgV5TJg3QZkn3wJ
         Z/gemnmC7S0XnyCwh2P5kQsMp03nO9z5E3h09UPt4JjmZj/NRk4e37JcmcKiBWNIjxSr
         s54teYu13fy70FgxKqczftrbeRXkanYPYJ79J47N9XqRoQUt5cfUe4YcPv8UJrSzWt7s
         /YZnSbEh4R8f5P1PPdBt1RYw7558kgJ4vJI5Qv4JZ6t88GKPyozzs+YTD+E6CQtIhCUG
         NIjA==
X-Gm-Message-State: AOAM5305Vw3u6w0jAOKiGMIj/enKqdAGQTGiiF0HZrw55dKArCsZBiEc
        CZPafX8zn2BHdSAAmDc/oZAPkZ67H57FVJ9x7V+CfEHQ+GzzdWAl+8Q+QNsh4kxHjds+mgPjzsE
        WeRVBIZLS38mwIyQKZOjhZQk=
X-Received: by 2002:a17:906:1f54:: with SMTP id d20mr9200357ejk.48.1630854922178;
        Sun, 05 Sep 2021 08:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWbCojxNISr+mKnf+beM5xR3SEos+shGuS9gvYwwtR/FWexU0zALsrFPLXDAs6YgRpFnkV0Q==
X-Received: by 2002:a17:906:1f54:: with SMTP id d20mr9200330ejk.48.1630854921973;
        Sun, 05 Sep 2021 08:15:21 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
        by smtp.gmail.com with ESMTPSA id cf11sm2997982edb.65.2021.09.05.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 08:15:20 -0700 (PDT)
Date:   Sun, 5 Sep 2021 11:15:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>, hch@infradead.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        stefanha@redhat.com, israelr@nvidia.com, nitzanc@nvidia.com,
        oren@nvidia.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module
 parameter
Message-ID: <20210905111415-mutt-send-email-mst@kernel.org>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
 <YTR12AHOGs1nhfz1@unreal>
 <b2e60035-2e63-3162-6222-d8c862526a28@gmail.com>
 <YTSZ6CYM6BCsbVmk@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTSZ6CYM6BCsbVmk@unreal>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 05, 2021 at 01:20:24PM +0300, Leon Romanovsky wrote:
> On Sun, Sep 05, 2021 at 01:49:46AM -0700, Chaitanya Kulkarni wrote:
> > 
> > On 9/5/2021 12:46 AM, Leon Romanovsky wrote:
> > > > +static unsigned int num_request_queues;
> > > > +module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> > > > +		0644);
> > > > +MODULE_PARM_DESC(num_request_queues,
> > > > +		 "Number of request queues to use for blk device. Should > 0");
> > > > +
> > > Won't it limit all virtio block devices to the same limit?
> > > 
> > > It is very common to see multiple virtio-blk devices on the same system
> > > and they probably need different limits.
> > > 
> > > Thanks
> > 
> > 
> > Without looking into the code, that can be done adding a configfs
> > 
> > interface and overriding a global value (module param) when it is set from
> > 
> > configfs.
> 
> So why should we do double work instead of providing one working
> interface from the beginning?
> 
> Thanks
> 
> > 
> > 

The main way to do it is really from the hypervisor. This one
is a pretty blunt instrument, Max here says it's useful to reduce
memory usage of the driver. If that's the usecase then a global limit
seems sufficient.

-- 
MST

