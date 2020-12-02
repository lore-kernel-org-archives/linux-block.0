Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD5C6369E
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0F422265
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 20:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbgLBUA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 15:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgLBUA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 15:00:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC51C0613D4;
        Wed,  2 Dec 2020 12:00:16 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 1so2517602qka.0;
        Wed, 02 Dec 2020 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mKAaMM+B5od5wmuixkzwDoB1AIuR4Yb+HRkjzwX9RyA=;
        b=YghrIr0haVEolmKypHz8A1CJmx/ECXsTDRbI8gaXYTFF0uwfpWGLNSixvcNrKLztk8
         uq3a83SHdZataVuKTM5dB27LvEyYzQ79E5VDTZpnhb5Thy3Ms5AzYIUU4Czu5MZdjjhr
         PtNmDZQIHWWgiYMq6bg+LY4CIucdPs/E1v6l2KnSXaQ0fnEQu/3sF6b0T/RAyajRnGwe
         7GAFJsJ5G9EcfffvdF5/KsSMlt9dg8sNzFve0s5UP7hLWs9raQbOycgCtG2oFum8qaNK
         3//HMeXJ/N99Vt3Glyd6yy+aGvUfnguPW5AgZw62XTpIDOT+SX7ScfqVovTdtzO1pQB6
         dD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mKAaMM+B5od5wmuixkzwDoB1AIuR4Yb+HRkjzwX9RyA=;
        b=FOL5Cr1VDRtiGlcKLJ8iqWdFZv26HYF92k2z7NQquqiFJHgucJe++mYsnRfv1PX5Rb
         2L6z4PePcFA+fUyjLaNXKrheVU7YNzzgDt+mMdQePFFQb3vC3tw18mKHI+QoL9u/wrgU
         pcsAsvYORkSsBYYZbGK65MXJH8vgqC5iAssoK5K/CD/Pnw158zwdmlYq28cVkuoNdAqr
         0A57pUynvwoAZ3vnfYWzZf3C7L6iWL5FOVod1DkACtbc24hlqRYMrTs1aBvLpJrlbYRU
         p/t/JXJihrlCMvE+YNIbttNMcyIR6JaexnVPDIkS4UZF41GTRdg6THnOw0fErDg0i/Qz
         fkCQ==
X-Gm-Message-State: AOAM5332i7UHbjQ+Ao/vG9mNmGe8ZE38/gH6cIG5iRHrZEkVi0wA4jDg
        +Y7iZGJQ3QMN22I+K6W36uI=
X-Google-Smtp-Source: ABdhPJxFSrSywoaFKL73wMD7FXuD2U/PBZdXhUQm+SGmectjXDArbTK88In2MGOMQmh7XkH+Bq2lTA==
X-Received: by 2002:ae9:dc06:: with SMTP id q6mr4302667qkf.310.1606939215451;
        Wed, 02 Dec 2020 12:00:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id c10sm2755357qkm.71.2020.12.02.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:00:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 14:59:47 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] blk-iocost: Factor out the base vrate change into
 a separate function
Message-ID: <X8fyMz4HuXhczdtE@mtj.duckdns.org>
References: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
 <6d14f8c88beee6561cf0ab091e3bbf0a60fb8e34.1606378475.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d14f8c88beee6561cf0ab091e3bbf0a60fb8e34.1606378475.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 04:16:15PM +0800, Baolin Wang wrote:
> Factor out the base vrate change code into a separate function
> to fimplify the ioc_timer_fn().
> 
> No functional change.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
