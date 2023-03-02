Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F66C6FA8E
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 19:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCBTp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 14:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBTp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 14:45:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3B34F64
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 11:45:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d30so1549487eda.4
        for <linux-block@vger.kernel.org>; Thu, 02 Mar 2023 11:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1677786303;
        h=mime-version:message-id:date:subject:cc:to:from:user-agent:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMPUGO9bDxR3ZV4lTc+t0jrVQ6Tcc5fKSmMJgPft4t4=;
        b=lva7OhAuhi+6ocqi+qiewCfZB/jftB2NGWBFplSOsbHsAg8/oH+GAtCdOz4ms4qxpv
         aBxjOigQyv4XgcZn5iP2fz4Qf9BsktG5FMsj/Vhev7oX6vN1JkJvKwKUBRhww1bZiBOY
         sqOFY48VTKFUTBOF8bvZaLiKrZxd9ARghaAcmmPikgJHp6R5RnPfbT9FjVpTPCXviUWU
         vF4ScarkGiNq9xKJr/10BO85Il952RxnmyX4WSdax6DL3FeaZO4UXXMhVFRO9/fem4/F
         HMinPH8Inx8jO8I8b8XIwszX63P9Z6LXj0YjoX0LFXswaXZS3d07RVnnZ0lTdLg8k/rN
         aANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677786303;
        h=mime-version:message-id:date:subject:cc:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMPUGO9bDxR3ZV4lTc+t0jrVQ6Tcc5fKSmMJgPft4t4=;
        b=D279c56PeubRhkFMZdQ81INWY4xQzlpGfH+lJdUN5DQa2gffGqbr6tNbi3xRJCPmD5
         Pf+99fqC9rnDADLBtaLxCHid/2VBla6Jz6HmlZP9Ao/z0mdhJr2UwGPgGRmsEAay7pJs
         Iod0tapMpQHtaMYXFUPw6chT7VO2CWLQDuh9CLUD4fnR8yhUfbC6SkwG0Ht+BgJMDqjZ
         PORxqO2xcRYTNTEF2kXMlwyTaH6Ig5/RsJt74HfbNAdoMLcd4TeVcoveZpqKQM3dj/e8
         dzQyAFjhHw1sjr382ntQybEgdzd3YgES8pFGpcuFfkLIqVfuVqoY3N7dzufOZ2KqRrIE
         75Fg==
X-Gm-Message-State: AO0yUKUm9OfN6cpG8V06Rn73tTiwPI2qwFfB9kZXRImVHjTo0QeorzT5
        PrwGUFiciLeoVx5JJJrHXk0b9g==
X-Google-Smtp-Source: AK7set/QhNM1zWmxOZXLJBtaeFefta7aoKQkKivNbhvxvSmloedS08PvjFKZNkbKSN8znFN8AdIDhw==
X-Received: by 2002:a17:907:9687:b0:8b1:75a0:57fa with SMTP id hd7-20020a170907968700b008b175a057famr15439048ejc.43.1677786303629;
        Thu, 02 Mar 2023 11:45:03 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id u9-20020a50d509000000b004af70dcce7esm267179edi.40.2023.03.02.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 11:45:03 -0800 (PST)
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [LSF/MM/BPF TOPIC] blk_mq rust bindings
Date:   Thu, 02 Mar 2023 20:37:04 +0100
Message-ID: <87y1ofj5tt.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I would like to suggest a session on the application of Rust in blk-mq drivers.

At LPC I presented work on an NVMe driver for Linux written in Rust. The purpose
of the driver is to help shape Rust abstractions of kernel APIs and to verify
feasibility of safe Rust for high performance drivers. One suggestion from the
audience was to look into null_blk, as this would eliminate hardware related
overhead in benchmark results.

I did an analysis of all the commits in the null_blk driver (currently 256
exluding merge commits). 27% (68) of these commits are bug fixes. Out of these
27%, 41% (28) are fixes for memory safety issues. These are issues that would be
avoided in a Rust based implementation.

I am working on an implementation of a null_blk in Rust. I plan to send a patch
set before LSF to serve as a base of discussion.

Suggested discussion points:
============================

 - Feasibility in terms of performance for Rust based Linux kernel drivers
 - Importance of memory safety in the Linux Kernel and how Rust can help
 - How to maintain Rust bindings for blk-mq

Best regards,
Andreas Hindborg
