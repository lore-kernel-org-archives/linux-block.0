Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE6FC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 22:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0331D205F4
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 22:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SSm5agFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfEBWHt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 18:07:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37611 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWHt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 18:07:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id z8so1669617pln.4
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gVceAqe64TkwgNQl4+fYtl0hmuzSrNYgku2ffGkIlWs=;
        b=SSm5agFn6nzgCwE0OvXoDAvBdsea/emnbG7AYN6Jf0YcorCJWZbQRMFjTR8POkdx7/
         pZ7eSr78jJAKjLNaxJcQbUkCBEZlL288J7cQcyVDj+R9DXjnWr2Rqs7ijm0oTL6JyhKf
         3716ylLHeNG1aNS37HZyjI2dNQ1hXlK2aNGYg2+rcMQhSVG+zV2B8arVpB/x3CzfZhzQ
         7oqAD0Xahmrk6XpZX/ox7lJbooT+Gi0UUEjK3KKnAvnrk7aFfy1FslGMyNyZY2HGzsql
         YPrdTCwC8z72QHKS+Z6FVPHkQ2ffnKx9ZoAOQYJaEaSAe+EpUIDwsNIzEHU5TJBod532
         hrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVceAqe64TkwgNQl4+fYtl0hmuzSrNYgku2ffGkIlWs=;
        b=sE/rrSsr3QQ/ClP8dNPGDu2P+nOCyy8a/E/dCqO4LiNuyY1F8lgJs/mL7O7bj0tZzz
         uB7kHXPo+8EWQ/PRbHT5vZ3vH8NUH0WW4iWvnaT/8sWYHHivv1vu0499lxWbg14Kb405
         eY3gaTWCnGShfxzseHgonVohPDQfjSoWzePSV6EJlLQw4y3cZN29hD4nryOK0o9unno/
         ZwmDyx8tsWOcjdsyFP5OLjzWs33tJAkcj4hG1rJLQUMOftQzB8KRExybxsh9PNzMrJcS
         EIgFFu8tuGYSw6yB0eftbommJDWN1bj/bBmwfsjkT6prEL61WExLvqZ+NqOlbgK/eb1M
         EHHA==
X-Gm-Message-State: APjAAAVqbMXKwqtqCKzWQtxl6mVcsx0782Izg+zlWr8/ZEUvPHyhSJ3L
        JY4b4FLJtRn/C6uDJ9Ocm82mpA==
X-Google-Smtp-Source: APXvYqwS7wJ6a7jTbsWWPGGypzo5fdb7XwrFAaa7i5GG59CXgCJUL+OHUqo+FOkKWu+xYc2VLQZ8DQ==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr6355171plk.129.1556834867279;
        Thu, 02 May 2019 15:07:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o2sm331597pgq.1.2019.05.02.15.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 15:07:46 -0700 (PDT)
Subject: Re: [GIT PULL] last round of nvme updates for 5.2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190502215825.GA27894@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c7c2e8b-bdb4-3814-31ed-300a04ec2285@kernel.dk>
Date:   Thu, 2 May 2019 16:07:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502215825.GA27894@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/19 3:58 PM, Christoph Hellwig wrote:
> A couple more fixes and small cleanups for this merge window.
> 
> The following changes since commit 2d5abb9a1e8e92b25e781f0c3537a5b3b4b2f033:
> 
>   bcache: make is_discard_enabled() static (2019-05-01 06:34:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.2
> 
> for you to fetch changes up to 6f53e73b9ec5b3cd097077c5ffcb76df708ce3f8:
> 
>   nvmet: protect discovery change log event list iteration (2019-05-01 09:18:47 -0400)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (2):
>       nvme: move command size checks to the core
>       nvme: mark nvme_core_init and nvme_core_exit static
> 
> Hannes Reinecke (2):
>       nvme-multipath: split bios with the ns_head bio_set before submitting
>       nvme-multipath: don't print ANA group state by default
> 
> Keith Busch (2):
>       nvme-pci: shutdown on timeout during deletion
>       nvme-pci: unquiesce admin queue on shutdown
> 
> Klaus Birkelund Jensen (1):
>       nvme-pci: fix psdt field for single segment sgls
> 
> Minwoo Im (3):
>       nvme-pci: remove an unneeded variable initialization
>       nvme-pci: check more command sizes
>       nvme-fabrics: check more command sizes
> 
> Sagi Grimberg (2):
>       nvme-tcp: fix possible null deref on a timed out io queue connect
>       nvmet: protect discovery change log event list iteration
> 
>  drivers/nvme/host/core.c        | 31 +++++++++++++++++++++++++++++--
>  drivers/nvme/host/fabrics.c     |  1 +
>  drivers/nvme/host/multipath.c   | 10 +++++++++-
>  drivers/nvme/host/nvme.h        |  3 ---
>  drivers/nvme/host/pci.c         | 37 +++++++++++++------------------------
>  drivers/nvme/host/tcp.c         |  3 ++-
>  drivers/nvme/target/discovery.c |  5 +++++
>  7 files changed, 59 insertions(+), 31 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

