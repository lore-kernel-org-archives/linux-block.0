Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3DEC352A4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0192465D
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581543227;
	bh=bdAJPEhxl47e9iOFyNJ51/ihXyQQQV5GPU9kaQBPvBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0bO0w3DPIpPgg8Vx1j2A+cpAwVbLkQDbFI+iQs9LBcUgUSErWTH3/DmLolfYJkU5Y
	 sGU68o8wfGdp4jNB10tZST0iMFpYM2G6I4FBWHhGaXWZoM32eApsusAnGUzTOC26QN
	 RNbK91fWYZPfpnXor9WMCb7vfqKdYWJnswb388UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLVdr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:33:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41287 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLVdq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 16:33:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so2789047qtr.8
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CB1ulDKxwf2tqP+HI+yYRfi4ISHZYVmjSyJfHnJrRmQ=;
        b=XYBgb2D/QSiYyLKz+WU5/HJUkBSXlNqM5+J4mVNuY8V59H/+qg31E2bYLEPHvqvkyq
         CdVdB03l1WMdiCG6Stup6FaShbB+Gu09yi6DFdQ+FfY8kCvhfMQr0ysGM6a5R/ryIPCU
         cIZ9XSH8AjizxhdmW+dFH4rP8dLHbsl+GobHWU5AuQoK4PxFSAvvT9M70CnF4TwhBLeH
         Cg6B5tz1ibbSXtZ6mJRMksWMgp/pAsYVxg4JQ2M3lZMWQeLXglddhOZqnQrQlrTyBC3e
         RieL+zmOtsfz14/UWbwx7mI6kdSXgj4fE3ccN01eIl2eJtR2SyGCzdZ3dK8KltcRAszD
         PHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CB1ulDKxwf2tqP+HI+yYRfi4ISHZYVmjSyJfHnJrRmQ=;
        b=D1S3dzO8ZFHnndeanKPWF9SUGtUl/S/VsQtxOWLRMBSdDQFiRGnscJb0ULXGOaPHHF
         Dz1usB4xvvUo13z9fraEikKyrR1hsFwLZlQdZPiTfS5KtEcFrqYX44AMEoN/7uuPKOOl
         b5sHNOsu2IUIvq8yvscvITMC/XC9HaBpqO1Z4oqkRux9I10hhxDVnkRzHmxlyd2W2IpR
         QXS3Df4+5oQi2zl8Eygj7GJJHLlpFWxX1KVuWAr8xFazgzIV+NhQAzaDFxKBUWadQMgT
         dlpWKti4g4p0NOJM9a5+OH53Iq/Ex+yEvh0+q3c0T8z+85tSCgdW08IlIXBOtGkgZdWI
         czEA==
X-Gm-Message-State: APjAAAUWenJUCfFPx9pVW8p2u5f5l9PQeHXW6A1NOZ8KeZMreTCu3qnf
        kr5lWjy8ebEr1ttf7rGxbfc=
X-Google-Smtp-Source: APXvYqzOJycJV34qt3zPAx8k3/WHi+CbQXH8RYVh9RE2N0I0Y4MJ33HQkoi9MRKE9iTxErIV5C0fEg==
X-Received: by 2002:aed:3e53:: with SMTP id m19mr9088468qtf.387.1581543225561;
        Wed, 12 Feb 2020 13:33:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id p135sm109084qke.2.2020.02.12.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:33:44 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:33:44 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz,
        bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200212213344.GE80993@mtj.thefacebook.com>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Yufen.

On Tue, Feb 11, 2020 at 09:57:44PM +0800, Yufen Yu wrote:
> There is another simple way to fix the problem.
> 
> Since blkg_dev_name() have been coverd by rcu_read_lock/unlock(),
> we can wait all rcu reader to finish before free 'bdi->dev' to avoid use-after-free.
> 
> But I am not sure if this solution will introduce new problems.

So, I don't see why bdi->dev should be freed before bdi itself does.
Would something like the following work?

bdi_unregister()
{
        ...
        if (bdi->dev) {
                ...
                device_get(bdi->dev);   // to be put on release
                device_unregister(bdi->dev);
        }
        ...
}

release_bdi()
{
        ...
        if (bdi->dev) {
                // warn if dev is still registered
                device_put(bdi->dev);
        }
        ...
}

Thanks.

-- 
tejun
