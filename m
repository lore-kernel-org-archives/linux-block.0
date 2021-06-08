Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786ABC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FB3613AD
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhFHVKE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhFHVKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 17:10:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BD9C061574
        for <linux-block@vger.kernel.org>; Tue,  8 Jun 2021 14:08:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q25so16704026pfh.7
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 14:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fn9tSwp351BH8PaPylSyaXw+NfJeG11f8tg42j+kf80=;
        b=Fz754dnVUlrgutAauhQn0AHo2+SNkcu+PR+B6pS4L4wtR8dMdNihWE5nbhkBpapVj3
         FPtlmTnMVU3Jh7I9vU8rScsH1e+l+VpEnvu9VAlcoqGrphxHHK5rjT2jU2NmJqCWCRQG
         GMkHeTI+m+MIcTjgIJ+zhMiGNxbYJz0Wa/KATNx7rjwaxqlHhO0BPYyuUKMjVB7H+srf
         3fvaEORweHl2hv8IVOvbbMdsUOs7MkFL3WbOGYrJdiDF6WdnD8OH2BQmiAAsc7Wf0Vlz
         QYm0IeSzk5QZg3aoqhsjT15a16X4lMGXTgx2ck3FCHO1rFzZmbKeshpTUOlHqhjRDwjy
         MPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fn9tSwp351BH8PaPylSyaXw+NfJeG11f8tg42j+kf80=;
        b=BsfJ8weWhaq95ksUzODlpT6IqHqCfhKV2NQn33k5PptWrmyOdrp+XtD8wAgoXQBB1M
         ew7fRdpo5ECJWtNtp+qGrrLe2ISC6phdmzbjPEbL6//SYa76jRRUuMmXssnrvO7AFD1o
         T0nmXvWduh0tNi13WPtwYobuYmlVeRCygOodqY8d3OvJzOU+XhhlzgQV6Re2TtwoIgpA
         FAjFtjZmevPmcKjn2UKaxilabCHJmcWmvfRYobdzQz0tJ9433RJxF4PMPXpMO/D+fQpd
         K8q3mUtnUXzRofriGS35qG027B65VuokIRQghTMrm/yD8lmg8f4t2yDzgappl1k8pGqT
         CNVg==
X-Gm-Message-State: AOAM532Lrbr91ds9CyTpRhm5XhaONajZgI67kWrmyJdE3QNzuk7H8O5u
        W9H/ySubbcZkOkPnhJjsrbTePA==
X-Google-Smtp-Source: ABdhPJwlK9AU2Y9v9iZeogXKf+QfrH4fJ/bhIEBIKAz0T6N/SXw0jRZ83aFXYfIXTSuCdiH2xIQqdg==
X-Received: by 2002:a62:6491:0:b029:28e:8c90:6b16 with SMTP id y139-20020a6264910000b029028e8c906b16mr1698633pfb.24.1623186490389;
        Tue, 08 Jun 2021 14:08:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id p14sm12306797pgk.6.2021.06.08.14.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:08:09 -0700 (PDT)
Subject: Re: [PATCH] block: check disk exist before trying to add partition
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, jack@suse.cz, hare@suse.de,
        ming.lei@redhat.com, damien.lemoal@wdc.com
References: <20210608092707.1062259-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e7e4b2a-b0e2-9830-e2bc-cbc6e9fd7b41@kernel.dk>
Date:   Tue, 8 Jun 2021 15:08:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210608092707.1062259-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 3:27 AM, Yufen Yu wrote:
> If disk have been deleted, we should return fail for ioctl
> BLKPG_DEL_PARTITION. Otherwise, the directory /sys/class/block
> may remain invalid symlinks file. The race as following:
> 
> blkdev_open
> 				del_gendisk
> 				    disk->flags &= ~GENHD_FL_UP;
> 				    blk_drop_partitions
> blkpg_ioctl
>     bdev_add_partition
>     add_partition
>         device_add
> 	    device_add_class_symlinks
> 
> ioctl may add_partition after del_gendisk() have tried to delete
> partitions. Then, symlinks file will be created.

Let's do this for 5.14, which means send it against for-5.14/block
please. Thanks.

-- 
Jens Axboe

