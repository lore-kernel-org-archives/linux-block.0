Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820AFC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 18:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJQSX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQSX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:23:28 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA874CD3
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:23:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id a5so7179601qkl.6
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lq1ryJcl968Ik5HB0Yb2jD+Gw/+EidzY3ld4yzCYtK0=;
        b=f+VWY5jsCcdoOqgQcMcNiyPnoQ62YcwD9UWqprttX5m8USSofE9ikd46EItFEN6AOB
         sGj9EF9Zjar0N27Oj9JDUqU9xXAzIMLeMILtXdr4JQGbYCqeNjU008EMbUykXbMhem94
         foLhAEEt5i6FYyQ38Tu/rf7gVsuQoharx7sMB/650Tv7KJKe79HQenR9dClgWECShpDe
         StTmLSf3iQNSBb7jzViCrwnIyNdsD1BErmT/Q+0bWUeAW5TMOLc50OuFyvJUZTKstB5v
         GpKFZKWXhX4T3OchBhUUFFo3WR+IAEDZ7cuRE+5+lYMRNBnEIAOhkccA47cvSsqjRSDG
         4Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq1ryJcl968Ik5HB0Yb2jD+Gw/+EidzY3ld4yzCYtK0=;
        b=NYICkt5e6UlQr262OomUxbUF54/NLs72TisRQSKYeOGB/QJEfaK+45FonKM/B8T+b7
         QgGISyfkjr86dgcviLQcCHKST/JZekh+WHR4ykECIun7Jyn8pTVIBZg0Y0JMwGucj03r
         sDviDVq2QfYUdET946VnLwa72nuDdTOdzhkfdAZLN+y8mXS2+nhgHovCEuY8j5xmNqsT
         LAnrP14LGjglqN53QT6xaobh3HRHjaQa9yky1RyHbVDRcSCoCJ6Oaqqkr/DxFSBxFvWG
         NzcsBQyXNmHEQdvW3dtx4Kv+zXfnF9eKuzl1GLK5ftSV+pRO1Jvmn5FdWTHhq5y+rwpA
         p9bw==
X-Gm-Message-State: ACrzQf11ERmFBGa0oSe/pIcnAuFlXrwTADc3tT6VQ9aK9SOxzuQ8i9FB
        fp/6WhaGxk2l4Vd2udihOjRLcg==
X-Google-Smtp-Source: AMsMyM78NtbMsBIPaTAwKfhXE7R4TV4+wQCDq22TXOO8RmEijWEJGtgBMqhS/OHErcdMTiMwuRcSdQ==
X-Received: by 2002:a05:620a:2057:b0:6e6:f4d:980b with SMTP id d23-20020a05620a205700b006e60f4d980bmr8451222qka.544.1666031006222;
        Mon, 17 Oct 2022 11:23:26 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05620a319a00b006ce7bb8518bsm419785qkb.5.2022.10.17.11.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:23:25 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:23:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Remove redundant parent blkcg_gp check in
 check_scale_change
Message-ID: <Y02dnHeLS+XFO1VH@localhost.localdomain>
References: <20220929074055.30080-1-shikemeng@huawei.com>
 <20220929074055.30080-2-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929074055.30080-2-shikemeng@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 03:40:53PM +0800, Kemeng Shi wrote:
> Function blkcg_iolatency_throttle will make sure blkg->parent is not
> NULL before calls check_scale_change. And function check_scale_change
> is only called in blkcg_iolatency_throttle.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
