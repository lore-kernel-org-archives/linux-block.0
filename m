Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D0C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CCE208B3
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V3BctJHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgFPQdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbgFPQdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 12:33:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234B1C06174E
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 09:33:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so1846732pjv.2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Io+HLKJE9NB7XwosYPDCPFqAitW8S6bjSbQvzbvRF3E=;
        b=V3BctJHi9M2xuS3mTLXnVk5xXbhZhzvT+SOd5QhkGksLfUj0WBaXzfL7Ir6RWTWOHN
         FmqSHxGkjaq+4/SMi/brDPctLyZwlN0uk1p6bCKvZVSO3h5vBfbrIZILxmrt64XWEHNP
         iY6NcCBS3kuee/xRvyzxVBWKZQT5qMo43N8Qsgtj15DS4l4UT6CLCghZfoxfTsG7LhUt
         jP2K5/yNhZ2TrHfLKp0a6b6W/q+rnVzAo6Oq91Ph02v4huhqvROZghlDKA7YdONCvJEP
         7DHkVk6GbCkCx4WkrLFy31FBc56GS87ULVhRxO8O3PBXbQNsbbb0bA7pxirWv0AytqTD
         lrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Io+HLKJE9NB7XwosYPDCPFqAitW8S6bjSbQvzbvRF3E=;
        b=Pb4DA3Vjwl737tDohvKSidBMJ5Dstdrj7Osaxc17KL7seIazvdQslJ84BEI8Glt0Qz
         aJAl85vvkW49SbOsqYXlvZVj/MuFy0yO8BIEPkGHURArk0ofRC8B0NznJAufJWwp5E8x
         j1uiazJ3ljv1gsrQBqnL+BAd29IctMk736OG+QQ2151o383du6KF/2GktlErVWrqfyWz
         H7Bhqi1fQmQQiCFg3Huafh2xsPMbF6jbte8HaeEx0E0X5el44IjZB/yJnvZKzcnf3xKJ
         /zNtyO6gix2MsX2TP8R2UI1uRaXl5vSSUbXS9ImCdV5IVZjKci+7YfXmcmLmZMfiLlmQ
         5/BQ==
X-Gm-Message-State: AOAM531l7u7PUEAKv+TqxQrN4OtzAMRXaQMx9TjZWJlWuqjpZ1O74INA
        4KdizrZJb3S1AWHFFEFgCMeV0w==
X-Google-Smtp-Source: ABdhPJz9u6ytOfc/pV10HgdH6feC24RNn3hrC1KQRcKigjfQwtzQKkyv8p98C9MAgyQhjQGSAS53nQ==
X-Received: by 2002:a17:90a:8d11:: with SMTP id c17mr3645846pjo.201.1592325218546;
        Tue, 16 Jun 2020 09:33:38 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x11sm18099556pfq.169.2020.06.16.09.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 09:33:37 -0700 (PDT)
Subject: Re: [PATCH v7] block: Fix use-after-free in blkdev_get()
To:     Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hulk Robot <hulkci@huawei.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20200616121655.3516305-1-yanaijie@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4fbfbf0b-8587-0376-a869-817157e8bfd7@kernel.dk>
Date:   Tue, 16 Jun 2020 10:33:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616121655.3516305-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/20 6:16 AM, Jason Yan wrote:
> In blkdev_get() we call __blkdev_get() to do some internal jobs and if
> there is some errors in __blkdev_get(), the bdput() is called which
> means we have released the refcount of the bdev (actually the refcount of
> the bdev inode). This means we cannot access bdev after that point. But
> acctually bdev is still accessed in blkdev_get() after calling
> __blkdev_get(). This results in use-after-free if the refcount is the
> last one we released in __blkdev_get(). Let's take a look at the
> following scenerio:
> 
>   CPU0            CPU1                    CPU2
> blkdev_open     blkdev_open           Remove disk
>                   bd_acquire
> 		  blkdev_get
> 		    __blkdev_get      del_gendisk
> 					bdev_unhash_inode
>   bd_acquire          bdev_get_gendisk
>     bd_forget           failed because of unhashed
> 	  bdput
> 	              bdput (the last one)
> 		        bdev_evict_inode
> 
> 	  	    access bdev => use after free

I've queued this up for 5.8, thanks.

-- 
Jens Axboe

