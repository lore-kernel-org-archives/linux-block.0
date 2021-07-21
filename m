Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6FFC6377B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C5D60FEA
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 20:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhGUULf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGUULe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 16:11:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F16EC061757
        for <linux-block@vger.kernel.org>; Wed, 21 Jul 2021 13:52:10 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bm6so3438725qkb.1
        for <linux-block@vger.kernel.org>; Wed, 21 Jul 2021 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h1JktM+0qQemW/QVrwzQ2IbM7ztSrTgIEbp8sqOhDuo=;
        b=W7svM9KlNEamb7YOyXAwTH7NiGYj5ebgfHIW9RXx4ovi1GlHrI5BTQUmr2sRuE67ic
         R2NGVzlvf9fFhicFWVlH1U/K0nd63EpSsBxgOXbHJCmjC/FMch17bxPNhd63lyoWvUIm
         +4MABSjMLChLKaEEnToxnUTs9WzI7v10x1EeYR32DtsYuuD9m/6mnkJriDp8jsrXsARL
         sTNdVxtuF4B9ONAfPpl5cuUSrWSOj/BiYAZ/C0qTh+eLaStJww9wHCu8oo0RcPLORYlp
         0v+jVgDro5eIfSrIxpfuUhzFhUZHfNgG2E4ztSJ/nkoMZrVwuz5Yq44KJuMrCnQeYjAj
         /P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1JktM+0qQemW/QVrwzQ2IbM7ztSrTgIEbp8sqOhDuo=;
        b=QszTZ5x7JCdGQmpsxOrtiuZqTAsgY0hq5Kr/Uq76Bu3uYWqVpBpqush2U/oVrDbUsb
         ITDMVUeExwsFkT4L0RhkdbZk2xqxMEHWyz4yY1rUXxjdLXA3HuKiaCBBG16S5PX69olq
         +qqoSbxB6C0QCY8OtpsnhSNYU7sw4WLabFLzC2kIdya66ZtHV8icENVtgz+U6SMF/QbQ
         5IkpJ6SeEfptPc9ghSLhN5h6R2IZtyGG11z0UHA0EvK+JZ9JiaZ7v2oEM6X54OEfK9zS
         9NjuwQc/13i9GzQ5zv0eOynChdMhai6LRN1PRDCvORVFVtwSmwvGY6OizT9ekbtWEmh9
         sqiQ==
X-Gm-Message-State: AOAM531e5FnIMWyE2gfmMqsxddxaTFOYCDr6gEVwm5ogA//gATr3bdy9
        rWz9TEvxX4YgciqseL1jCmPObQ==
X-Google-Smtp-Source: ABdhPJx+PdR7DGOsrw2e2T6Z86K50XpZpfs2A9SI2kBB6zC+GH7Q+282GznVjIAy03Lq1RzWxTi7zA==
X-Received: by 2002:a37:858:: with SMTP id 85mr36853514qki.70.1626900729345;
        Wed, 21 Jul 2021 13:52:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1223? ([2620:10d:c091:480::1:9441])
        by smtp.gmail.com with ESMTPSA id 143sm8670111qkf.3.2021.07.21.13.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:52:08 -0700 (PDT)
Subject: Re: fixes and cleanups for block_device refcounting
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210721153523.103818-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <17147cf6-dbb2-39ac-c8ff-e95f87c1173e@toxicpanda.com>
Date:   Wed, 21 Jul 2021 16:52:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/21 11:35 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes up a possible race with the block_device lookup
> changes, and the finishes off the conversion to stop using the inode
> refcount for block devices.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef
