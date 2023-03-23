Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689BC6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 13:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCWNDg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 09:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjCWNDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 09:03:35 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67DB24CB1
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 06:03:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t9so26346129qtx.8
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679576607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=;
        b=fsnlSj1wYC+oyegO1q1yDBhN8AGGfS4B+/UJULqMDG1jdL9i5Fbq8O1r0UzJVbgZ5N
         CurbRDFSblDK9jc415qglfplweQjxGgBmqJhkAyt51A78hYTvBHd5fNCjBUuHTPn12EM
         Y1zKMRG6J4vTDaSNZyUJtcdDE+Bc4WCdEGj2SxETTQC9dX65jzYjndPxJagfadtzcHCH
         KucPqK8M85ho9lf87J55E+JMepmXIqa3pD+e1u9JzACYKTlMkED7tsKMjIDWBNd1fGTF
         U3Y7TJ6KcgnjkwfOD17f24lPxk4X4kA8SUtwmE3gF+qqh2vrzBTq+F7nq338bAMfL5EK
         qakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT5kxqVOLNs1cddye30QvhqujBIE6P8vkXfghBDUxrs=;
        b=DOadJPBadGVDuJ/I5Djzma/2B+bQJ/IZz6tTHjMQQD7eQ3mBV/nBTdLE3keu6UoR71
         FjsA2NQ6AASo2ZsyJOMRv4tw26BslqlSCy8d/i8Qylon3BsbWQ/NQ3UsvtbpaHf9FAv1
         2yuntMVNqAA+ifTAE4qQz6BeJCQesyCPawNWSxJ0I5XqboR5jET9MEsqgvCR5PdB1Jk+
         t/+d0V9H+Y4IYli9ycUwKt+lANXSIvjk4HZn3c/ytkVVDJyCWeYgWm8MsJYnRXNEqK0U
         F77UozcHwUN2m++BXIicRUFlnC6/qdJjqpU5WZSi/2pNQ/TQJwtKaGsW9pBBL5ckRWPm
         3thA==
X-Gm-Message-State: AO0yUKXYl0Rjl72mj6Soj87ZqA47vCRYUa8WhqF146nP3MEJklCSTuWz
        awssQZtAL2nUkNpPS/AkKqnciA==
X-Google-Smtp-Source: AK7set9Nd0IROYibAsNWzp2/wBVMkNxgJf3eiBJQdDWBUctTuOee3WY/j00WoSi5pcTukOCIoBjA4w==
X-Received: by 2002:ac8:7dd1:0:b0:3e2:7a9e:a04e with SMTP id c17-20020ac87dd1000000b003e27a9ea04emr9731248qte.18.1679576606971;
        Thu, 23 Mar 2023 06:03:26 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c9-20020ac80549000000b003d8d1ec2672sm11612362qth.89.2023.03.23.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:03:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfKbF-001D0h-LK;
        Thu, 23 Mar 2023 10:03:25 -0300
Date:   Thu, 23 Mar 2023 10:03:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBxOHZwre3x8DkWN@ziepe.ca>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
 <20230323120515.GE36557@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323120515.GE36557@unreal>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 23, 2023 at 02:05:15PM +0200, Leon Romanovsky wrote:
> On Wed, Mar 22, 2023 at 10:50:22AM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> > > 
> > > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > > (nvme-rdma).
> > > > 
> > > > This was the only caller of ib_get_vector_affinity() so please delete
> > > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > > 
> > > Yep, no problem.
> > > 
> > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > the nvme tree?
> > 
> > Sure, it is probably fine
> 
> I tried to do it two+ years ago:
> https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org

Christoph's points make sense, but I think we should still purge this
code.

If we want to do proper managed affinity the right RDMA API is to
directly ask for the desired CPU binding when creating the CQ, and
optionally a way to change the CPU binding of the CQ at runtime.

This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
creating a CQ on a random CPU then trying to backwards figure out what
CPU it was created on is silly.

Jason
