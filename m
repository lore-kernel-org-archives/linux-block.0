Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41994C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 15:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjCBPxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCBPxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 10:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC65024CAF
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677772335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cmCzTmxHV2uZj5pqTfuzTfxAnXBSwmjg8GrPIqmTNhY=;
        b=Bi5UOrX/nnKRRxAORlaqnhClwPzP9zz+JrPrOM8l3JOLbK1zDloEygD9udVb7+Zv1cnY9k
        tiyjFJgeFoLFzN4hVXT2df+6wPaFFqpNR7yBZsEJQ7Y2ur6Zj7Z4nkg0M5SQhz5LuhB1VP
        Hw2FHaBxzar5uE35zBBUEFNydV595W0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-IE8Hx97QPSGJv6wijYu-Og-1; Thu, 02 Mar 2023 10:52:11 -0500
X-MC-Unique: IE8Hx97QPSGJv6wijYu-Og-1
Received: by mail-pj1-f71.google.com with SMTP id d3-20020a17090acd0300b00237659aae8dso1663258pju.1
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 07:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmCzTmxHV2uZj5pqTfuzTfxAnXBSwmjg8GrPIqmTNhY=;
        b=TdzC1bq+hg7nHsvm2f8bV2G00+0qMtXi2APhyttIUMiFmWWlHD11LLU/fhS31jsdgi
         P5TVs8Nx1PkHdMGPkWrpTvqNkuN69/0l5s4MHpeRdiIRg9ihi0k/77CgMXHb1MnQh8O+
         gam3jf4kRBPY8UO8HD9dO+xHFRb/fqc5vp18zJkuj7YBFbAA+aUA3XCdiT+L0WKy9Q0E
         Kgjg7Hx9ZcDMf9y7j2p2fIefxQ+Mn5VmQkbs8kPWvOg3Lv7zumyTfUHL1bRTwn7SHwH+
         BcqHkIkSCGedqxJcj6Mdo2F3bS5BePsWh4y/+iQeCC3ali5RgAGijyfuuIQkhkSBGdYG
         H6HQ==
X-Gm-Message-State: AO0yUKWbOWgLO/fqGO00axl6BGDjZtSFc2Ec/BajiTT+d6XMTMwse2Ct
        WRxZbUm6khTUqhGjwMunCqv2yLJz63Lyzo4DWfwTbKY32zN3vpcgsZFKDoQ1mgI4ccAvp/kQHwV
        kvZeEXmpR3owbo8odPZ1hcQE5GYPXZJ6O0obRWFD1DpCsPzA5Rw==
X-Received: by 2002:a17:902:7fc2:b0:19a:e96a:aff5 with SMTP id t2-20020a1709027fc200b0019ae96aaff5mr3990172plb.1.1677772330680;
        Thu, 02 Mar 2023 07:52:10 -0800 (PST)
X-Google-Smtp-Source: AK7set84bdlQzWmK+wk9IEBpzXcwddHUsETeO+nhg6uYIAugfoA5oA5scCMbTueParzRbW6+lSNz+U9/lTZeJMgMwDI=
X-Received: by 2002:a17:902:7fc2:b0:19a:e96a:aff5 with SMTP id
 t2-20020a1709027fc200b0019ae96aaff5mr3990160plb.1.1677772330386; Thu, 02 Mar
 2023 07:52:10 -0800 (PST)
MIME-Version: 1.0
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 2 Mar 2023 23:51:59 +0800
Message-ID: <CALTww28pEdW+f1SaXrG7Umf8uA6fAc9io-WKb_W8mVxEzW8EzA@mail.gmail.com>
Subject: The gendisk of raid can't be released
To:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph

There is a regression problem which is introduced by 84d7d462b16d
(blk-cgroup: pin the gendisk in struct blkcg_gq).

The test commands below can reproduce this:
mdadm -CR /dev/md0 -l10 -n4 /dev/nvme[0-3]n1 --assume-clean
mdadm --stop /dev/md0
mdadm -CR /dev/md0 -l10 -n4 /dev/nvme[0-3]n1 --assume-clean
mdadm: Fail to create md0 when using
/sys/module/md_mod/parameters/new_array, fallback to creation via node
mdadm: unexpected failure opening /dev/md0

The reason is that the gendisk kobj can't be released, so md_free_disk
can't be called. It looks like the patch mentioned above doesn't have
problem. Before this patch, it didn't add the reference to the kobj of
the gendisk. So all things work well. Now it adds the reference to
the kobj of the gendisk in blkg_alloc, but it can't be decremented in
blkg_release. After adding some debug logs, it only adds the reference
of blkg->refcnt, but it doesn't call blkcg_rstat_flush which calls
percpu_ref_put.

So the patch 84d7d462b16d only exposes the reference problem in
block cgroup.

Best Regards
Xiao

