Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF8C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 14:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0D320643
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589467888;
	bh=E0a+apJr31FkSRWpqsCDpRfntjbRBD8yeqKP6BnYfGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NQcT1aYgGw1cvHfrOGR0LgdakHJwZZ8qMnry2w7aLV4wRmIHfRVBn7Kz+awPyygXP
	 X7mOYdNAbXpcTpVaYgj8MLgzjEvolJcQB1zAKINSyFt+RMGydQwL0hVanU9sgu60tm
	 y7I/Wx8SMnb6hQeeyxt9og0M1rB2BG39he5WS1DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgENOvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgENOvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 10:51:19 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C78C061A0C;
        Thu, 14 May 2020 07:51:17 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id l3so1788038qvo.7;
        Thu, 14 May 2020 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNtTa2d+n4621gDfYTPbcUqqYbeIm8uB0/qear6cWpg=;
        b=QeELnO1WNJbZma6EEnHeMi9LPg6qMoJehC+wk+8XY7BwCHhBJHE3zUOcgdbrSSnsxE
         hszjO+n7oLZR3ozCX/Frm7E5wqFeNhikXHOg0kZDTUEUTjbcqvWlCOh/B6ncBE62iIjZ
         QfCSBa5O0hsIhlEHRBPV2+XpEaoZSKpM4XFSe8TU2dV2Sw4bY7I3SYMEYWG8kgpjbHjQ
         BwUWXlmwGLeuAgz1kvr3rZwFnblqwDY789h3F2COPvbxYxOeS0iwb2zXrKRFnqUpCYA8
         hGASsSrtmA0K9nRnOyT3+NrQIjXbvfAZyRW4PjnyM3hMyl0zypiqiYHiNPDqlCUCH1zK
         mG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aNtTa2d+n4621gDfYTPbcUqqYbeIm8uB0/qear6cWpg=;
        b=k5L7s3Z1Yge/Ezwv0xALbKehSy0EGxCnNk04ZX3+Af8EF2kjD1mIvzOxvc7oVtGLnj
         aQ1ARNEhGz++HQuzPUJ6HZFQnZmWMcjE7DGnRB5T2BaLiNr/0524ysLpuKPEJseVkSvX
         Q6A5ChlqwtaxuUpKGMVyzymgyJL0p52N4jmrVjlhhRrHoySLazFRZTZVmMWxNpgQ3b/C
         3KV6yoBfoaftDRNdcR9CAb28fX9Pl9CT9G+zL9LN65OrANJTrWRFEy3MvNt6zEUi94Vr
         btvhktMLssROj9jobSn952uiSEf/jUuY8VCDLLCFFWuTqXZrA02AVj8daG+tRoABZYsh
         /GDg==
X-Gm-Message-State: AOAM5337O9XV68aM83oo4ZJy5rrGFEGUwjY4W7X7+s/iYqfEiqo6dYqI
        K6ijOFWFLxSGPrr7frO6/q5mC/9EnD8=
X-Google-Smtp-Source: ABdhPJw7cclIwTgpzaD7MAC6RXRqYWlqzeZnNk0O3UghwCaxqW1QxUitfWlT15ZSc2SfonojOLuZXw==
X-Received: by 2002:a05:6214:1543:: with SMTP id t3mr3002030qvw.122.1589467876536;
        Thu, 14 May 2020 07:51:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:97a6])
        by smtp.gmail.com with ESMTPSA id n20sm2623277qtk.89.2020.05.14.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:51:15 -0700 (PDT)
Date:   Thu, 14 May 2020 10:51:14 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, newella@fb.com
Subject: Re: [PATCH block/for-linus] iocost: don't let vrate run wild while
 there's no saturation signal
Message-ID: <20200514145114.GG16815@mtj.duckdns.org>
References: <20191015001811.GI18794@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015001811.GI18794@devbig004.ftw2.facebook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 14, 2019 at 05:18:11PM -0700, Tejun Heo wrote:
> When the QoS targets are met and nothing is being throttled, there's
> no way to tell how saturated the underlying device is - it could be
> almost entirely idle, at the cusp of saturation or anywhere inbetween.
> Given that there's no information, it's best to keep vrate as-is in
> this state.  Before 7cd806a9a953 ("iocost: improve nr_lagging
> handling"), this was the case - if the device isn't missing QoS
> targets and nothing is being throttled, busy_level was reset to zero.
...
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Andy Newell <newella@fb.com>
> Fixes: 7cd806a9a953 ("iocost: improve nr_lagging handling")

Jens, this one fell through the cracks. It still applies with only a small
offset. Can you please apply?

Thanks.

-- 
tejun
