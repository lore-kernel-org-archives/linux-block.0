Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1378C64E8A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6992076C
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="hKnZYq2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgK3BYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 20:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgK3BYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 20:24:12 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A8C0613D2
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:23:31 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id v3so9781249ilo.5
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZmTZBqdpz8QAbNwD292cR5AKXCzTrvi1V4QZo4ASiQ=;
        b=hKnZYq2zYwBXSBj9NeRqd6+7PYTZURDvcmLIwor4SOQougjRYVBJjKQib8Bw+L+jyj
         hK29uuv0S3/5uH5/Y9KJob1/oXpFwwBro0asfQc1NQg3uLi60wqboim7OnzakiprgxjY
         vJ6Y2TDWIlzHPhC/HWJUs0MGAoR5NIq4xHju0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZmTZBqdpz8QAbNwD292cR5AKXCzTrvi1V4QZo4ASiQ=;
        b=a9N1rpbSOKot6DpQE2Ux44cJIYVYdEsqtvHotZFTGLy3ZJN6cdt3rxpvB4qWWifW3H
         osxxfklljBVLalCbe5vyASP1mb9wWlw4Lki9xeuqRCMJi6LdMHd0qEEKMVqQgVJr/0Jv
         PJ0+4ejz5S6MKOay4CPefaI9tAna92su2KzXDJUIn+ZMkHvxF56A6Vbt1Cu+PlBugRH2
         4CixnphvwfMx+PGa5QEgP8QOFV4uoeo5+LogQUiaGjEbqdLFH/4GgU8anEMFElxr3KLQ
         RXDL5n/fr4KrPmzt4c5lEl0IP3JAc9G1zbDAnhJznVFP3eK8ae9l87VXcaJFD0SBG0TL
         A6LQ==
X-Gm-Message-State: AOAM532lF9dhNJQVY6oy882DfzIENxgMpARU97v62FmR9S2ZYWEhZN3X
        +rAkCUMs9twKaVpjPMzsILuJPg==
X-Google-Smtp-Source: ABdhPJx6pfJfEezIuUrTQnLZt8wZNJbVHV799bmuRFAi7zQbwNigfx6jMUois48aZKI1igPQUl300Q==
X-Received: by 2002:a92:84c1:: with SMTP id y62mr16165882ilk.191.1606699411252;
        Sun, 29 Nov 2020 17:23:31 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id n10sm7216731iom.36.2020.11.29.17.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 17:23:30 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add a hard-readonly flag to struct gendisk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20201129181926.897775-1-hch@lst.de>
 <20201129181926.897775-2-hch@lst.de>
From:   Alex Elder <elder@ieee.org>
Message-ID: <44c60506-059f-f272-208f-a39d94a8617d@ieee.org>
Date:   Sun, 29 Nov 2020 19:23:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201129181926.897775-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/20 12:19 PM, Christoph Hellwig wrote:
> Commit 20bd1d026aac ("scsi: sd: Keep disk read-only when re-reading
> partition") addressed a long-standing problem with user read-only

Little nit I noticed below.	-Alex

. . .

> diff --git a/block/genhd.c b/block/genhd.c
> index 565cf36a5f1864..5e746223b6fa0f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1625,31 +1625,35 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
>  	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
>  }
>  
> -void set_disk_ro(struct gendisk *disk, int flag)
> +/**
> + * set_disk_ro - set a gendisk read-only
> + * @disk:	The disk device
> + * @state:	true or false

s/state/read_only/

> + *
> + * This function is used to indicate whether a given disk device should have its
> + * read-only flag set. set_disk_ro() is typically used by device drivers to
> + * indicate whether the underlying physical device is write-protected.
> + */
> +void set_disk_ro(struct gendisk *disk, bool read_only)

. . .


