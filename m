Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB233C2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4ED2168B
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581602292;
	bh=XnmOcvXBs7+P4hR2gFffatGsVimLcQPm8t+FbZHlakw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQNEPNiak2Io0cXdLDhzwD3MNKXFJasVqmwWne6DxVs8QOOoIAn3KmqYcNGd6r4tf
	 46l5fmMfsY/RnOT6fpCzodbQhEJtVCI36KS20yuBPXmMZYHzG+82KZzrEHL/QUjHQ2
	 YGpbrl4sb58eO5Dl8zr04cyuLP5mKDxMLsMcEc+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgBMN6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:58:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42694 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgBMN6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 08:58:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so4385758qtt.9
        for <linux-block@vger.kernel.org>; Thu, 13 Feb 2020 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SC0nsyrjx2XKfrv1CGhfKOeix8vEYOlvybsPllHLtRU=;
        b=Z+uK78blswzFN+KYUHE1lpfYBBmzW7UpIxkQzwb3y3qOxA1zaBCOuHLaCvd84hUoyY
         5iLqHOsEGrSFZZHZ7E5TY2lnDkRKtHHWAhLO/pGrHgZhEiGb65wu8Ol3voXyBRpQ/kHr
         0vc/KtkaNo08CLzONc9lLT+FWaE0NHTbE/6Q2v29l+3SUyp+w0aVMKneihAw1pQtWbhe
         rowXLft6kJN+SHbU0dSEY7ASwdbmAtzkzJBOAobtX7qX4OPbdECvG8Sxg+vHIFYaWhmp
         INXVYnm8YZ+lwylhNOxbg9UArKw5+oGEN5bcv6CycohEJ12k+XzVImdSf5Dex11uAbKi
         9cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SC0nsyrjx2XKfrv1CGhfKOeix8vEYOlvybsPllHLtRU=;
        b=g4UlRndu32RtyL+BW9V5eOeM5llundN3xIla3xVGMQPGfka1rl4Y5dNzFJR+brK6pm
         orKPLeYkY/lNHe+E5FhELQWZeoljvELSOy3DjNGSqw2OMoow20zbeL9m5bGAGBEqy2h6
         eWAwhRi+Uogcay1/r5M0xvq7nOigT8j7i+46tjpT4GF5/Ic4iuQppGDjGQ8gUcmrgSGV
         +/sYZowO5oUlsGptS29jiyKD+CGODNXQMlBN7jw1aq/tMOT2ioX4OuJZY/ycYDwpnZ88
         ZCsyjyWlrO3xjwGJRC31jC4bJgY2O9v9zRaK7Xmf5waGtX9TYq8L0thUcsFo5YuYIWGD
         peCg==
X-Gm-Message-State: APjAAAWLddlcCgLv3g6x3tTuLuhDLtzErhHGXUMC8b4TC8aQGsww0jXo
        afNMjSE0jY8AMFW981vgJcgHv7IMc8Q=
X-Google-Smtp-Source: APXvYqznmb7+P0zyDPzqtbpLWQaNUR4/Hjga6bj44ojBWMV2NgrH4Ddm8H6bF493r00DdWUd3DdaHw==
X-Received: by 2002:ac8:36f5:: with SMTP id b50mr24477701qtc.268.1581602290918;
        Thu, 13 Feb 2020 05:58:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:f3be])
        by smtp.gmail.com with ESMTPSA id f32sm1542331qtk.89.2020.02.13.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:58:10 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:58:09 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz,
        bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200213135809.GH88887@mtj.thefacebook.com>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Feb 13, 2020 at 03:51:40PM +0800, Yufen Yu wrote:
> If we destroy the device asynchronously by call_rcu(), we may need to
> add a new member 'rcu_head' into struct backing_dev_info. Right?

Yes.

> The code may be like:
> 
> bdi_unregister()
> {
> 	...
> 	if (bdi->dev) {
> 		...
> 		device_get(bdi->dev);
> 		device_unregister(bdi->dev);
> 		bdi->dev = NULL; //XXX
> 		bdi_get(bdi); //avoiding bdi to be freed before calling bdi_release_device
> 		call_rcu(&bdi->rcu_head, bdi_release_device);
> 	}
> 		...
> }
> 
> bdi_release_device()
> {
> 	...
> 	put_device(bdi->dev);//XXX
> 	bdi_put(bdi);
> }
> 
> But, the problem is how do we get 'bdi->dev' in bdi_release_device().
> If we do not set bdi->dev as 'NULL', re-registration bdi may cannot work well.

So, unregistering can leave ->dev along and re-registering can test
whether it's NULL and if not put the existing one and put a new one
there. Wouldn't that work?

Thanks.

-- 
tejun
