Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D88C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D5A2084B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554227194;
	bh=WZOzWzhEzi6avNIJ7pQz8BqsN4+8jbHqtbuHBjnCngk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h460C7IwiouYmvTjyXDQBl2LhsFun/ks3e2PeWbZGBPPsMGYkZSrNajLKdp4zioSY
	 PCvRmcYfECI04s3Z5SUYJ9HBkD7mWY1j+elga0pWU+hJIRF/6FEt2SkscmVKAYI3lf
	 8aYW3LAfRBBctgy2CgdlzhqBh/HAo37/N5SB0K9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfDBRqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbfDBRqc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 13:46:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C502082C;
        Tue,  2 Apr 2019 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554227191;
        bh=WZOzWzhEzi6avNIJ7pQz8BqsN4+8jbHqtbuHBjnCngk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HblCLl9NhPdy+M0FQNLI9CPZ3s3PVmYcqU8K4jAbSXOUfDVRgvm9w2LIlFj0rFTQM
         zZIoGeu8IYiKeZmhExH296VyTAz2lxT5gL0LGBai65/UZkLpvXQaHeUr6AAi8mQny5
         RXeBXgMyVfjbYUAf8T6jzFdwVdcomXfc4l03ET5g=
Date:   Tue, 2 Apr 2019 19:46:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Kimberly Brown <kimbrownkd@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] block: Replace all ktype default_attrs with groups
Message-ID: <20190402174629.GA23882@kroah.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
 <e3b82e2105d1e2b4d6313d862172007e0f4477e2.1554151487.git.kimbrownkd@gmail.com>
 <1554220958.118779.145.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554220958.118779.145.camel@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 09:02:38AM -0700, Bart Van Assche wrote:
> On Mon, 2019-04-01 at 22:51 -0400, Kimberly Brown wrote:
> > The kobj_type default_attrs field is being replaced by the
> > default_groups field. Replace all of the ktype default_attrs fields in
> > the block subsystem with default_groups and use the ATTRIBUTE_GROUPS
> > macro to create the default groups.
> > 
> > Remove default_ctx_attrs[] because it doesn't contain any attributes.
> > 
> > This patch was tested by verifying that the sysfs files for the
> > attributes in the default groups were created.
> > 
> > Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> > ---
> >  block/blk-integrity.c | 3 ++-
> >  block/blk-mq-sysfs.c  | 8 ++------
> >  block/blk-sysfs.c     | 3 ++-
> >  3 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> > index d1ab089e0919..85864c71e858 100644
> > --- a/block/blk-integrity.c
> > +++ b/block/blk-integrity.c
> > @@ -365,6 +365,7 @@ static struct attribute *integrity_attrs[] = {
> >  	&integrity_device_entry.attr,
> >  	NULL,
> >  };
> > +ATTRIBUTE_GROUPS(integrity);
> >  
> >  static const struct sysfs_ops integrity_ops = {
> >  	.show	= &integrity_attr_show,
> > @@ -372,7 +373,7 @@ static const struct sysfs_ops integrity_ops = {
> >  };
> >  
> >  static struct kobj_type integrity_ktype = {
> > -	.default_attrs	= integrity_attrs,
> > +	.default_groups = integrity_groups,
> >  	.sysfs_ops	= &integrity_ops,
> >  };
> >  
> > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > index 3f9c3f4ac44c..5315e538b3b1 100644
> > --- a/block/blk-mq-sysfs.c
> > +++ b/block/blk-mq-sysfs.c
> > @@ -173,10 +173,6 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
> >  	return ret;
> >  }
> >  
> > -static struct attribute *default_ctx_attrs[] = {
> > -	NULL,
> > -};
> > -
> >  static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
> >  	.attr = {.name = "nr_tags", .mode = 0444 },
> >  	.show = blk_mq_hw_sysfs_nr_tags_show,
> > @@ -196,6 +192,7 @@ static struct attribute *default_hw_ctx_attrs[] = {
> >  	&blk_mq_hw_sysfs_cpus.attr,
> >  	NULL,
> >  };
> > +ATTRIBUTE_GROUPS(default_hw_ctx);
> >  
> >  static const struct sysfs_ops blk_mq_sysfs_ops = {
> >  	.show	= blk_mq_sysfs_show,
> > @@ -214,13 +211,12 @@ static struct kobj_type blk_mq_ktype = {
> >  
> >  static struct kobj_type blk_mq_ctx_ktype = {
> >  	.sysfs_ops	= &blk_mq_sysfs_ops,
> > -	.default_attrs	= default_ctx_attrs,
> >  	.release	= blk_mq_ctx_sysfs_release,
> >  };
> >  
> >  static struct kobj_type blk_mq_hw_ktype = {
> >  	.sysfs_ops	= &blk_mq_hw_sysfs_ops,
> > -	.default_attrs	= default_hw_ctx_attrs,
> > +	.default_groups = default_hw_ctx_groups,
> >  	.release	= blk_mq_hw_sysfs_release,
> >  };
> >  
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index 422327089e0f..7a95a1eb27e1 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -769,6 +769,7 @@ static struct attribute *default_attrs[] = {
> >  #endif
> >  	NULL,
> >  };
> > +ATTRIBUTE_GROUPS(default);
> >  
> >  #define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
> >  
> > @@ -890,7 +891,7 @@ static const struct sysfs_ops queue_sysfs_ops = {
> >  
> >  struct kobj_type blk_queue_ktype = {
> >  	.sysfs_ops	= &queue_sysfs_ops,
> > -	.default_attrs	= default_attrs,
> > +	.default_groups = default_groups,
> >  	.release	= blk_release_queue,
> >  };
> 
> I think this should have been four patches instead of one.

4?  I could maybe see 3, how would you make 4 patches out of this?

> Anyway:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks for the review, I'll queue this up in a few days.

greg k-h
