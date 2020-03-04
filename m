Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF2C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BBB24654
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583342628;
	bh=rkJm25+mf9cP68As5o1jSutcjizqAXVXEqn5oBoW1hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eyq7r3nOrZRhKW7rVeoyV4R8G4uL0B9mKb2l3FNGSRgFDCDM8pb9dpteqdSfCnvIH
	 4nF0XP43AQaLUcsojq/FnztDfTuZv8AWSY1nmj0pMErM/Z9/LxaXhxal2s4DMMosR4
	 hd+DrI6KYHpV3DbidWwv0lSrWZ1xiQR42CDMkZ9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgCDRXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:23:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDRXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Mar 2020 12:23:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D071217F4;
        Wed,  4 Mar 2020 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583342626;
        bh=rkJm25+mf9cP68As5o1jSutcjizqAXVXEqn5oBoW1hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPizrAI4uFJryNUt3YMHJNm6lZ2lb7wmq1lVU7Fts5py9F/BPALh3jGTExSbSIF/h
         FNnkQkAy30iPbVD/ENqVAVbzLyj0jHXzsE2XvOYir217E45ZACYOSvcGOlddQICbV2
         uZYnQosS+jO+784/YSILNUG0Yffoc+ZkHovYvKjA=
Date:   Wed, 4 Mar 2020 18:23:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, bvanassche@acm.org, tytso@mit.edu
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304172344.GA1864778@kroah.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
 <20200304170543.GJ189690@mtj.thefacebook.com>
 <20200304172221.GA1864270@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304172221.GA1864270@kroah.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 04, 2020 at 06:22:21PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 04, 2020 at 12:05:43PM -0500, Tejun Heo wrote:
> > Hello,
> > 
> > It might be better to put this patch at the end rather than in the
> > middle so that when this patch is applied things are actually fixed.
> > 
> > > +struct bdi_rcu_device {
> > > +	struct device dev;
> > > +	struct rcu_head rcu_head;
> > > +};
> > 
> > (cc'ing Greg)
> > 
> > Greg, block layer switches association between backing_device_info and
> > its struct device and needs to protect it with RCU. Yufen did so by
> > introducing a wrapping struct around struct device like above. Do you
> > think it'd make sense to just embed rcu_head into struct device and
> > let put_device() to RCU release by default?
> 
> Ugh, I was dreading the fact that this day might sometime come...
> 
> In theory, the reference counting for struct device shouldn't need to
> use rcu at all, right?  what is driving the need to use rcu for
> backing_device_info?  Are these being destroyed/used so often that rcu
> really is the best solution and the existing reference counting doesn't
> work properly?
> 
> Some context is needed here.

Ah, would help if I just read the whole patch series, that helps...

Something is odd if kobj->name is the problem here, let me look at the
patches in full.

thanks,

greg k-h
