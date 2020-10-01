Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C02C4727E
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6B1207F7
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601567423;
	bh=EE0I/28ZKmfiuki+Gi+EC52gv25K+UWAlkcTzl3MKgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T4CFSYnG25Qmza+iPYlMt5+ADjUNPJmELn6fuALELoR3BkvEMX/mLdk00job8wNcN
	 Mq+VUyHgeWKnrUWoXUSLZvoi4/g1nedizzmb4v+Gq8q/ryGyxpD15Xq6aaqFqqSSqh
	 ByTE05SC3xhf3JPzHSYD5jtxChtvLQu05OfjU450=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgJAPuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbgJAPuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 11:50:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986DC0613D0;
        Thu,  1 Oct 2020 08:50:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so5817213qki.6;
        Thu, 01 Oct 2020 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4TKDLyOiOaTpRi0XFmbou9G+aDghP55pLdrmC2nfTZI=;
        b=sv3aii8Yzpq8Hy1TcDYaeEF2E0HITVeVv6UjEXvV99mdAzTai//eqmcZo5/S5aNLK7
         q0wI3p0Uy5r9dNxJfJilWphjX13ccZKuSMkJPfi4E0j16pMDvyBc+P2FJRVDeCwIUS/9
         8TSPTKG2RPSmi2ah7EwFi9ui8edKlYFXSoCizZtvzhIR46oPzgASvBAuWF5WQJn2A0oi
         lNfoKpK9Kj/xCg3b+1CXRkoQ6cDCeEuJqKyjVbowEnO4E88wfORS5S8m4ajZjYiTtoST
         mp5Bf/sUetiUCGxXI521SPTC3zoF/4KT0zm7gj7dA1CgyUARExiXHfwPjI4/9hCHFXMX
         mSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4TKDLyOiOaTpRi0XFmbou9G+aDghP55pLdrmC2nfTZI=;
        b=oRO/VE1kQCdKh49aq5P34W7bDywFnuj8wg6v0+hZ40AoFZwTNbK5FQt9BJXpFtKl1q
         e0o5Qmi863YtCOh4LbULycm9zo0zi0ge+c5X5b+bd0l0KSOY8Tbw6m+uCeu6iPDnyOeW
         tc8ze1NZv6Y4UA7BcRfg3ayhcHBjZEEVkmy22bEbfBe0hYoFa5NLizNk9NjBMLlCou/f
         Aliz1TyxBnYmbB2fq9OPwAt3W7XjPJNlji6CYkuJy440vRMztecfMyVzxNaHTIkw0ax9
         18pf7xJ9CSF9U1ezco6qCDeT+Bnot8hPpLuBwBSw8o3/cIkLHL7zKMKFd/el6eyf7fzK
         JR9A==
X-Gm-Message-State: AOAM530QAvnxbB0ZZ/dbOTTzCeuVzYHwaAQILqshs/zO8vLngYTYe+Sx
        v75yrhaxomn/znvhITcgsAE=
X-Google-Smtp-Source: ABdhPJyYT+y5QiAzK1NBkP4h7DJn3OT0F2IyibRjH47XYSYTyKM3PH+svp4CMVNKEkzagRPbkKlt6A==
X-Received: by 2002:a37:a83:: with SMTP id 125mr7837342qkk.360.1601567421004;
        Thu, 01 Oct 2020 08:50:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3475])
        by smtp.gmail.com with ESMTPSA id c40sm7280723qtb.72.2020.10.01.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 08:50:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Oct 2020 11:50:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V7 1/2] percpu_ref: reduce memory footprint of percpu_ref
 in fast path
Message-ID: <20201001155018.GI4441@mtj.duckdns.org>
References: <20201001154842.26896-1-ming.lei@redhat.com>
 <20201001154842.26896-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001154842.26896-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 01, 2020 at 11:48:41PM +0800, Ming Lei wrote:
> 'struct percpu_ref' is often embedded into one user structure, and the
> instance is usually referenced in fast path, however actually only
> 'percpu_count_ptr' is needed in fast path.
> 
> So move other fields into one new structure of 'percpu_ref_data', and
> allocate it dynamically via kzalloc(), then memory footprint of
> 'percpu_ref' in fast path is reduced a lot and becomes suitable to put
> into hot cacheline of user structure.
> 
> Tested-by: Veronika Kabatova <vkabatov@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
