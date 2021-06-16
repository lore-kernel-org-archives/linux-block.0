Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CA5C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B17261159
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 12:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhFPNBn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhFPNBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:01:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E9C061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 05:59:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso2351769oti.8
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jLSVmuLw4Nb055fI6F5c4n6Y22HkMR7OQfqkvuCNLI=;
        b=fUjGVI1wI44GueP/8qBEGqyVV7NLUmOaIAeyp6CWQXjf7vZ7tnDvIJgVm6qIzUZk3t
         8JWqWR2V4MG5tM4WpAU1MejqCWif82xUXXy/0FMAcKRMCHYnTZNLbIaLrqv5kOQIOkjp
         sApMoUC+CA2QoEQfSDKsfQF1oai8iMC663Uo9AYqcUx5pGrRG3YsfWa+ERQrJLvTG1tq
         xLV2Lohb2GjBvNa5VIzi2beGU3UuVLkRnSSTN5wdWeWTkgS7dmp0z+DuKbDoTX7UGksI
         aW7tvP8LiEZIgEwq7PEGyHJRy82VqVLeQL2h/X4HrhjIha4cZxaMLq+NOfIJFaqey22V
         SwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jLSVmuLw4Nb055fI6F5c4n6Y22HkMR7OQfqkvuCNLI=;
        b=m9Orlh860u5CqKWbfTZGjmdWKv4OhaXDBU7ea4VdIlIi88p/PFBGg4u+JTugjxCqS5
         v6LOhKwQA0AjDc0j3W/Pn2ICZO3jB6JnmAWfi6cS0ir9NOjIn4wLt9NHAVb1XkrCkbFw
         3hpMswT9+GADYdr337NYLyoOGyf9rZ+rIBSr7S+33/gHN9ePbuectdLjqRT5H+oG2Uwg
         PXZIUbw2Ek/yBgutTxt4dan3w0TN11hrpJZXoFtB2RATajbKygBKBNu5U2WSrhtW8Q/1
         GpiO6UP6tBrSU0QGirz6mc0uPHAgF0INmJY4WUOaLtQtxXUMI3zyqNDzwUalYFakzcDD
         svMQ==
X-Gm-Message-State: AOAM533DcCJzb1nv8utjqUSI/xomsrVxP7V70hepjmkb/1mt1KDxhDBn
        +PEvOUk516mdSqkUbtlsAtaeTQ==
X-Google-Smtp-Source: ABdhPJzozClctq3P3F+vS6zEvZVzcUDa+vFBQHDKbeDCU+xqxPVCz54/ZsosyzWg+6MY9eTPiiqwrA==
X-Received: by 2002:a9d:4d8d:: with SMTP id u13mr3755526otk.367.1623848375674;
        Wed, 16 Jun 2021 05:59:35 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 26sm460938ooy.46.2021.06.16.05.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:59:35 -0700 (PDT)
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
To:     Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, idryomov@redhat.com, xiubli@redhat.com
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3035a3f-4494-929f-5c21-ba921a77ea6c@kernel.dk>
Date:   Wed, 16 Jun 2021 06:59:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210429102828.31248-1-prasanna.kalever@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/21 4:28 AM, Prasanna Kumar Kalever wrote:
> Problem:
> On reconfigure of device, there is no way to defend if the backend
> storage is matching with the initial backend storage.
> 
> Say, if an initial connect request for backend "pool1/image1" got
> mapped to /dev/nbd0 and the userspace process is terminated. A next
> reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> use /dev/nbd0 for a different backend "pool1/image2"
> 
> For example, an operation like below could be dangerous:
> 
> $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
> $ sudo pkill -9 rbd-nbd
> $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"
> 
> Solution:
> Provide a way for userspace processes to keep some metadata to identify
> between the device and the backend, so that when a reconfigure request is
> made, we can compare and avoid such dangerous operations.
> 
> With this solution, as part of the initial connect request, backend
> path can be stored in the sysfs per device config, so that on a reconfigure
> request it's easy to check if the backend path matches with the initial
> connect backend path.
> 
> Please note, ioctl interface to nbd will not have these changes, as there
> won't be any reconfigure.

Applied, thanks.

-- 
Jens Axboe

