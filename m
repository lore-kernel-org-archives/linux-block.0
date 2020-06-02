Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E277C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 02:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DBC207D8
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 02:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591066287;
	bh=s0QOrRrxDBnQdeP8HKtsXG1hcpmrekuMSCdEx0gK8OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VntGr4l/SfDPs7on+lx7O1xacIPC+orU8XwuuTgBNA/UCZa0cJpeT/F5BHSEN7JaM
	 HGiA+sEUi4s3xkSODalapqaQyhi34jx/uWasHxIi5asFqPJsQA7qX73x2yOnUmBKsG
	 7g518csd9VMjRg+u/Ei0MnIGgPhRlkwCG/2wZhoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFBCv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFBCvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 22:51:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47466C061A0E;
        Mon,  1 Jun 2020 19:51:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v79so11176547qkb.10;
        Mon, 01 Jun 2020 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=leA9A2lWOCRo5ss9zbN0lzkpnk/eM2vdFVHyb+2f+v0=;
        b=pRjoaZeGVVDZdZ5GWQw4vFjByobFIF0+lPxKdVstS+U0OM3oIN6NyH//pOnbbZeMY1
         VCfdRrevrdEjqgQchsrpsmwMs2K+HIcp5g3INLlzoN0VW1S+AVFwG7ejkWwzix7oVl+u
         aWsTSQ3AOgviNQA1/S8wds2jVzteuoGb5Rw+UcLCqg6OWP7DTGRUenCfhvM6/H5l0ciW
         Asj6qqIOK9rOUMHLeem5gBDmOcLlFmb8LX/7VxcDUdFHmrbMsrYK+tL4T2c9nNgzsGAh
         HXXMQey81V2PtOMRWigYxG/N9qPYwjSUgDOrz2YLLu06lvcA51JhEebaIdhPD+3aF5ia
         alyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=leA9A2lWOCRo5ss9zbN0lzkpnk/eM2vdFVHyb+2f+v0=;
        b=aaEV6pYeSIGA0uGW4vU55X9RgarKaN0fV7aA88rXf3SE/yHq/2ZCx65IfRZo43RIgM
         YcgMYFB59JAxXn2hLZY3POzW0jbm4Z8jCbS2vB32PxWeDMhtzEEC459U4MKJd9Ahxrjl
         mQu1yYJL1i7JTerwBp0pXOTfrxTv93zKvtFVMz2juWMaThWfNFL0qjtTpHuUCZHqVqaZ
         f72UEwDhg6qRx2GrbZ6m9J0r5cHc2/tDqRirBRVzkSvVRfqZ1FF/wnJYHzCt3HU0y3d7
         SQqWUYUrS3bcl7Z3zgGg3ZTeIm5UK3EH9UwXLyHK6IGANXzDQQHspBnhRZDmwcObhREU
         iFxw==
X-Gm-Message-State: AOAM533n+QLKLnV6mb7c8pDJInKICPmveRaN8Zw1ecV7FVnieBBz6Vwy
        F5HRvwNriD8wgWE3l4KQkVY=
X-Google-Smtp-Source: ABdhPJyoyCkJmPida7PjZzzGMpFJ2QXHvg/CL+zYbFZBVcDTTgm0jiFZuXJ0qQ0fw6yh77O4oUWuRw==
X-Received: by 2002:a37:8187:: with SMTP id c129mr22705414qkd.211.1591066283190;
        Mon, 01 Jun 2020 19:51:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id s201sm1387764qka.8.2020.06.01.19.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 19:51:22 -0700 (PDT)
Date:   Mon, 1 Jun 2020 22:51:21 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] blk-cgroup: don't account iostat for root cgroup
Message-ID: <20200602025121.GG31548@mtj.thefacebook.com>
References: <20200601231141.2218370-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601231141.2218370-1-boris@bur.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 01, 2020 at 04:11:41PM -0700, Boris Burkov wrote:
> This data is never flushed by rstat, so it is never used. We shouldn't
> bother collecting it. We can access global disk stats to compute io
> statistics for the root cgroup.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
