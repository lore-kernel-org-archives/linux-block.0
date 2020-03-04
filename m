Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B85C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7285421D56
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 17:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583341546;
	bh=1+DglH2uThysUvnGM8zZCA2dvGMU+M93V9n272VCqSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=No9lidRJBERBjJ5LPWIXBAiJXRNzE3ISj0T1IMilZzIJv7WXpvSj0d3HvkRSApiVs
	 hzISf3Px+zyrmAtUdImIbAO4GlqzTtVopETPayJpst3+BOmCvC6aPr/i36uVSAAhwH
	 5b+oieVUSCb+XODB0EU25klq4FEOcdsmJcRt1izg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDRFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:05:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39262 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDRFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 12:05:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id e13so1903841qts.6;
        Wed, 04 Mar 2020 09:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rm/wY9qTRCYlSnYi7ajYS41w3MJHXh7lvSvmNYrIYmY=;
        b=lf2V1wlJt8iXzR7OvwB4+2OOnWEpUGUjD33V+3a3QzABSqB2wUIYpXrNVNACOJ4Qdn
         1BhXqlhH7TJLGETDcDQ/jgsz97xoVEs80+CkKXxndvYQnIfoMWvDjnYCJsO8FaKAgQy+
         oR9V/M8IpiCK1U9MMsaGvhn/zsjweFjovgRBnVpDc6arygzLlm2PMkUVvKYNQSw6NieJ
         RBvLIqWXt+aD1rcpe6CuZjGG6SixxA3rH0FFtRxZrC+DR10cHn3T0KV4otNJ2qI8m6QD
         bw7y1rdA3mZAks9//JR4NxMZh5LdKXtu5jPWM7cEdBf6i83XDYextg4LrcJtTpYGrM5Z
         vlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rm/wY9qTRCYlSnYi7ajYS41w3MJHXh7lvSvmNYrIYmY=;
        b=aqp4lTFMRTv005sY3TOrjTmAAvD2fkeE+25GfpYBVPUIh/QgsZupEXx4r6gOCtqdDc
         MLtJtH6a/jMVEfrdGus9kby6ILJrWu3nX7zJ7fQ2UamE92ll3lmC4d6hnwXr7UHC/awE
         SVKRUDp7jxnP4CweCICkDh6tOR/pdzrbck7Vu3sRdgKdLjZ8Z1YQdo8On/ffcH4SaAXS
         CVfaHrnBMXDrTx5oCHUFo0k/aVdZE6mx+Hw4c66cYYplVNnV+2ZhGR7cCWS7VUAdPZ73
         zKM9yoZEbupOTFvbWQYPVSf6Q2nInEitVKsiu/3UcXXQXcWGFB7n0fPb7A/8AEZNTe/C
         Dv8Q==
X-Gm-Message-State: ANhLgQ2Hyv0lk3JZidOAXwpd00JrG8jFhkShMm2u5zsKks/WZ6+7zgx0
        ETS7wiw8HkHvSnu6NURpsZp0zTORqjc=
X-Google-Smtp-Source: ADFU+vvOynOG/87P2m7w78DeEu27ls/UoQfjeinD++wR/z+tOJMImGK0FlkzzMclryg4RqKHCh85xw==
X-Received: by 2002:ac8:8c6:: with SMTP id y6mr3322931qth.388.1583341545015;
        Wed, 04 Mar 2020 09:05:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id 65sm14206261qtc.4.2020.03.04.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:05:44 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:05:43 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, bvanassche@acm.org,
        tytso@mit.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/7] bdi: protect device lifetime with RCU
Message-ID: <20200304170543.GJ189690@mtj.thefacebook.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
 <20200226111851.55348-4-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226111851.55348-4-yuyufen@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

It might be better to put this patch at the end rather than in the
middle so that when this patch is applied things are actually fixed.

> +struct bdi_rcu_device {
> +	struct device dev;
> +	struct rcu_head rcu_head;
> +};

(cc'ing Greg)

Greg, block layer switches association between backing_device_info and
its struct device and needs to protect it with RCU. Yufen did so by
introducing a wrapping struct around struct device like above. Do you
think it'd make sense to just embed rcu_head into struct device and
let put_device() to RCU release by default?

Thanks.

-- 
tejun
