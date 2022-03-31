Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DEC433FE
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 05:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiCaFyK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 01:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCaFyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 01:54:04 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831A92DAB9
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 22:52:17 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id w8so22463176pll.10
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 22:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zTaM71SVPE6S3OdGd9sJCQOVirmJSKeBEVVvpHLP9M=;
        b=AGNRcFSXwdrKLTwN3QJtYqX34qhPbPTM7N8BE6TK/6pEh4BavF1OQALps9r5n3Y5xV
         9163kf+O+yggeMP+XAtId51saT7R6lSjwanwv07yzmngq/C0Ww7Kq3hzed672ufk5Z9b
         z44JCfPK5CEk1Ol/9CGZ+qEFEU1++JDEGjCWOqYeZbcDPg9ex9cMD5tLBGwGJMmxDj2u
         7SmEnuUx7EM73WUdluHFPVxHZxc/RMUowJ8HAEDZU1cX6R3qgpxo0HNJdGPwE6IV6rk7
         T/5Np4A4eNWtafeSOb8JaTyLBkxaK3CfRsLHSoMJyT0m3yJow2SOiCAsB6XA+lqteiCb
         uUTw==
X-Gm-Message-State: AOAM5309POk4eNCo6H1p+wctJA39xwAb1MlSqaOyzzVOnnPSovONVae4
        jR6bGtA6DOmeLL7DMpICuyJQB7+SEGc=
X-Google-Smtp-Source: ABdhPJwOVwiZOY/QFsDtfI9b4cYAc4VtjeuKnSwxfInHXclMB0xLovIV+ITp1QjLG9anTmxDT1jafQ==
X-Received: by 2002:a17:903:1249:b0:154:c472:de76 with SMTP id u9-20020a170903124900b00154c472de76mr38213570plh.81.1648705936249;
        Wed, 30 Mar 2022 22:52:16 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id pc13-20020a17090b3b8d00b001c775679f58sm8649714pjb.37.2022.03.30.22.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 22:52:15 -0700 (PDT)
Date:   Wed, 30 Mar 2022 22:52:13 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, tj@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YkVBjUy9GeSMbh5Q@fedora>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
 <YkUwmyrIqnRGIOHm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkUwmyrIqnRGIOHm@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed, Mar 30, 2022 at 09:39:55PM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 08:28:28AM -0400, Dennis Zhou wrote:
> > I think cloning is a special case that I might have gotten wrong. If
> > there is a bio_set_dev() call after each clone(), then the
> > bio_clone_blkg_association() is excess work. We'd need to audit how
> > bio_alloc_clone() is being used to be safe. Alternatively, we could opt
> > for a bio_alloc_clone_noblkg(), but that's a little bit uglier.
> 
> As of Linux 5.18, the cloning interfaces have changed and take
> a block devie that the clone is intended to be used for, and bio_set_dev
> is mostly (there is a few more sports to be cleaned up in
> dm/md/bcache/btrfs) only used for remapping to a new device.
> 

I took a quick look. It seems with the new interface,
bio_clone_blkg_association() is unnecessary given the correct
association should be derived from the bio_alloc*() calls with the
passed in bdev. Also, blkcg_bio_issue_init() in clone seems wrong.

Maybe the right thing to do here for md-linear and btrfs (what I've
looked at) is to delay cloning until the map occurs and the right device
is already in hand?

> That being said I've eyed the code in bio_associate_blkg a bit and
> I've been wondering about some of how it is implemented as well.
> 

I'm sure stuff has evolved since I've last been involved, but here is a
brief explanation of the initial story. I suspect most of it holds true.
Apologies if this isn't helpful.

For others, a blkcg is a block cgroup. A blkcg_gq, blkg for short, is
the marrying of a blkcg and a request_queue. It takes a reference on
both so IO associated with the cgroup is tracked to the appropriate
cgroup and prevents the request_queue from going away. Punted IOs go
here and writeback is managed here as well. On the hot path, this is the
tagging that blk-rq-qos stuff might depend on.

The lookup itself is handled by blkg_lookup() which is a radix tree
lookup of the request_queue. There is also a last hint which helps.
blkg's are percpu-refcounted.

In terms of lifetimes and pinning. child_blkcg pins parent_blkcgs in a
tree hierarchy up to the root_blkcg. blkgs pin the blkcg it's associated
to, the request_queue, and the blkg_parent (parent_blkcg and
request_queue). They die in hierarchical order, alive until all children
have passed.

If there's anything else I can try to help answer please let me know.

> Is recursive throttling really a thing?  i.e. we can have cgroup
> policies on the upper (e.g. dm) device and then again on the lower
> (e.g. nvme device)?  I think the code currently supports that, and
> if we want to keep that I don't really see much of a way to avoid
> the lookup, but maybe we cn make it faster.

I'm not sure. I've primarily dealt with physical devices. However, I'm
sure there are more complex setups that use it. Is it a good idea is
probably debatable.

Backing up though, I feel like the abstraction naturally alludes to this
multiple association because you don't necessarily know when you hit
physical devices until you finally submit through.

Thanks,
Dennis
