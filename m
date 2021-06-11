Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D29C48BD1
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 17:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B60613D9
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFKRx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFKRxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 13:53:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F43DC061574
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 10:51:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x19so3210030pln.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rxRAiPtIPFYcoD9aLWTaw2AHjyQyQp4ZMkTG0TPS7E=;
        b=ifTbSpnQJUBSZvLYFwYcfJtqZOUc2F+tqqkx585oVr1NX3yD+zW5vI1uu+m1MY+3XZ
         RnW7Xf6XlwyGupoo+F0irbqLyd51juu87lwaNAFh8sX8G0VK9AY/uMX6ak5Yc9Lvefd1
         gQw8Q86a6EqHDSci1uu0dAmeNkg84vi8Vja2hGim3dMSI4E880mqywQIb7UtsJRKlwGy
         JjkK9f8nswJgVBObHusdQ9LGMJDNubWkPkxmV+ePzlW4QZMofnO5/unPhO0dG+fhb/w+
         S932GbgOkxqEggV2Q9M6MMaClq7q70oYlUgub4umV46DRE2H2EQTBfoAOKGon5c3dCDY
         Fisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rxRAiPtIPFYcoD9aLWTaw2AHjyQyQp4ZMkTG0TPS7E=;
        b=n5xlq/D7AihPIEgXQ3eCih4lH829vgC3MsM4gIfR1CiHxzFc7ZMT4Sat+x45RgN3gU
         YbxabqXwxaqoT3uebFAb3Nu0My/x+lv6TVSMVJlR3qNm/02MC1/CbS8so996Y+ztkJK3
         kMrDSm2Xovho9Nb97FCUTo9+HG/Gg1urjrfnAJfgx98xvtr0qpRylgjFKLRdhZgdyv6N
         sF+7xVz0oIMadQDEeW+9xHqZQlLsJpgEZR76bH0aIr7q/KZ2YTpGJhQQnIJPfBD4QPRK
         1vhfjDMDiwiDwGVD37m2BK0q+0bTK2RdWBbzrjCAVSLn6+4XU9d+3xzDDnctIoync8eb
         g7sA==
X-Gm-Message-State: AOAM531I6WMIRdRr9ziipXx5ILi8J/WlTmI0hsxjCDgyzHrEUlasMSE5
        XjMYlsjH502HpOCF7GWkePbmXg==
X-Google-Smtp-Source: ABdhPJwaRIfbEQgveMAxoYPgSHlRY9WSJZS0MiMwPMBoczZx23xnZcXY/lu7YkNPDJOJI1JH3i4Evg==
X-Received: by 2002:a17:90a:5504:: with SMTP id b4mr5605740pji.208.1623433871462;
        Fri, 11 Jun 2021 10:51:11 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c184sm2751867pfa.38.2021.06.11.10.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:51:10 -0700 (PDT)
Subject: Re: [PATCH] block: loop: fix deadlock between open and remove
To:     Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, pasha.tatashin@soleen.com,
        linux-block@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
References: <20210605140950.5800-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b186cfd8-5000-c712-67ca-9919451ba501@kernel.dk>
Date:   Fri, 11 Jun 2021 11:51:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210605140950.5800-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/5/21 8:09 AM, Christoph Hellwig wrote:
> Commit c76f48eb5c08 ("block: take bd_mutex around delete_partitions in
> del_gendisk") adds disk->part0->bd_mutex in del_gendisk(), this way
> causes the following AB/BA deadlock between removing loop and opening
> loop:
> 
>  1) loop_control_ioctl(LOOP_CTL_REMOVE)
>      -> mutex_lock(&loop_ctl_mutex)
>      -> del_gendisk
>          -> mutex_lock(&disk->part0->bd_mutex)
> 
>  2) blkdev_get_by_dev
>      -> mutex_lock(&disk->part0->bd_mutex)
>      -> lo_open
>          -> mutex_lock(&loop_ctl_mutex)
> 
> Add a new Lo_deleting state to remove the need for clearing
> ->private_data and thus holding loop_ctl_mutex in the ioctl
> LOOP_CTL_REMOVE path.
> 
> Based on an analysis and earlier patch from
> Ming Lei <ming.lei@redhat.com>.

Applied, thanks.

-- 
Jens Axboe

