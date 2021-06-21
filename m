Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA56C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722816115A
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 14:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFUO0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhFUO0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 10:26:23 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ADDC061756
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 07:24:09 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 22so9866024qkv.8
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K/6ilqLw8gyHJVHyq7970J0pHnoZaqQ14pfaNLWMCPo=;
        b=OZmQBcJApKtWmiwkHx1/M99IboHZ9wh683Y84Ib2jwg4q93eOXbDK1anYSj+oZmulf
         Nxjo3ItdnXnweqo3vezBV55huc3+QyetP0w7hILwz5TzWogJY8wrBo4Mcck2JcRbJuww
         tqbnvKYLG2gwzp+nrbAbZdF6Kc78qHa6kIjwz5MAavITETovKcM+t53ojgNGgINoFfRL
         oWdbKFjMdY5tqQstx4dNjpWHGEJNkD4GZ45+i3eQnz9kh6v8cvvyRGROY+fRrCKKd3p/
         rloAhYMQZ+1IYJz8yRmaZphunYpINrH+qaGEzPQPVuo/9y7BQblfN8+s+l7vh9hoyXFk
         qZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K/6ilqLw8gyHJVHyq7970J0pHnoZaqQ14pfaNLWMCPo=;
        b=VAInHeaZeA2bI1ccasTvDpmsu3f+8Uy0o476EL+wM1BLMgwOc0uhpWxL0iGstChfGX
         UrwQ3K9198nELHij3rFijZPEl5bvH9OWnAgUmD0KSQb86CHEindHCiGYFd7Cowwgd9Qj
         HSojCBXzCHcT0wL7YDF5tFvGHYJzW5MmpvfUwHAyPOuXKsXUM6dGWHLA2VhYecfvn8vG
         OEeE5gvD73LOIph1tb8ybVQHG45tg2eDKk8aRGoU+R73weRjdu8greXageSNbIXrTs8m
         cgRxB+0vdy6Ui9Av0PSqIZe+uqsUR4PgcaRVFWjbBhSoq/TMirD9oq8JNpmHDFw+8LvE
         cXlQ==
X-Gm-Message-State: AOAM531g6jvs8qypKsxbcF4hRGOwSQPBkvdiV3x8PTxZ58DOy7lc0cZF
        OjhigK7Lr6bh3Xc51wZA7T4=
X-Google-Smtp-Source: ABdhPJz/P5fnevyZ+ND+8M07gWG10oeqbuogmBS2ppfeC4uX7IYiAi1pHvDdxvE1Ym/j7plvizjBfA==
X-Received: by 2002:a05:620a:3da:: with SMTP id r26mr23625388qkm.424.1624285448188;
        Mon, 21 Jun 2021 07:24:08 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id d22sm6780383qkk.19.2021.06.21.07.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:24:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Jun 2021 10:24:06 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 02/16] block/blk-cgroup: Swap the blk_throtl_init()
 and blk_iolatency_init() calls
Message-ID: <YNChBkV6WoUhxG/b@slm.duckdns.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618004456.7280-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 17, 2021 at 05:44:42PM -0700, Bart Van Assche wrote:
> Before adding more calls in this function, simplify the error path.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
