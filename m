Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11AC47404
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 13:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF9B2084D
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 13:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IkOmuc8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfILNN4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:13:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36655 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfILNNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 09:13:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so16025815pfr.3
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2019 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Q1W0kNNUr5cIkEJ99a/uCvT7A7Ngx5Y71tVQcQVETA=;
        b=IkOmuc8tdiJhGS1NMxy+Idj96CRlUBl9Mo+odPgaT0msmISZ1V51UhpGui+1ygllrV
         dn3u6n45xsE30kQBn/lt/Q5q9p3hLHIYWLCd6NshvdRQ14aDhWl3LJyflx7Hsr5bUB3p
         X7x9E5XH3T7rBhjPOBKDefGJHOfMQh/GeCAvxyb2uEqpQC/RVH6IsivdJrgnfKcnRCkg
         sRFRYdwMJwQTO/6spOTYgTUa6IMUXrt4NUKyLnhCA0uNtdDT17aJYVatb9GbOtrjgvR9
         53fSiiziIiwm8FFPAfz9x4+1rkgDatjDT0TyrYOAy21RDOvMbmGzkiRipPYBRorb8suE
         406g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Q1W0kNNUr5cIkEJ99a/uCvT7A7Ngx5Y71tVQcQVETA=;
        b=rEBElUGxR2tXrK/smIpR1KJ61IjHviViVN7b7rEhjcFHXYZUj6cSFctyr2N+dH39b0
         VxA+tf3tIccAt0M2f9nAJ+YEZURygu0Ie1rII0Gt/MjCS61h/pQroG6O6FkXgOtIWaRB
         RfwJe63Sxw6HUjJkyr21fwZUWRqziTCGpjrjUiQHFE2UiAIEM4g1YT0E2Ey/wGeqPp+S
         2cz6IJCJf+LbXiQx2zDI2bLrDKEHl+WnlMNlnVRqpedcBe3V55+rvofrHNPtGZ8Benis
         egJ+RkSh2jZu0kIByOLbm2e/boiMJRUbERPIQEZHWk5CiqnovQ8z0MTQJNg0WxWfyv0I
         ipZQ==
X-Gm-Message-State: APjAAAX86/YHQlJNjRaow4Bsd/lIxhWVJZ3aLEfQqCA7XSqOJfnoNCOc
        8NAw0pzttNaknuF3WooFRYSqhx7BNCiv7g==
X-Google-Smtp-Source: APXvYqy0UZBE/+dRwqZxY6Zz3y78Ej/WoGg0v+49e9/oqIqvn5m7wBIi80Rp3LhBsoLMIIDdqz8wEw==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr37950896pgr.206.1568294031658;
        Thu, 12 Sep 2019 06:13:51 -0700 (PDT)
Received: from ?IPv6:2600:380:4b2e:3b64:29ff:2f14:b019:100? ([2600:380:4b2e:3b64:29ff:2f14:b019:100])
        by smtp.gmail.com with ESMTPSA id l72sm6425648pjb.7.2019.09.12.06.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:13:50 -0700 (PDT)
Subject: Re: [PATCH] block: fix race between switching elevator and removing
 queues
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190912040224.7554-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e27cc85-d6ec-b77b-3584-648fb1a88c58@kernel.dk>
Date:   Thu, 12 Sep 2019 07:13:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912040224.7554-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/19 10:02 PM, Ming Lei wrote:
> cecf5d87ff20 ("block: split .sysfs_lock into two locks") starts to
> release & actuire sysfs_lock again during switching elevator. So it
> isn't enough to prevent switching elevator from happening by simply
> clearing QUEUE_FLAG_REGISTERED with holding sysfs_lock, because
> in-progress switch still can move on after re-acquiring the lock,
> meantime the flag of QUEUE_FLAG_REGISTERED won't get checked.
> 
> Fixes this issue by checking 'q->elevator' directly & locklessly after
> q->kobj is removed in blk_unregister_queue(), this way is safe because
> q->elevator can't be changed at that time.

Thanks Ming, looks good to me and cleaner than before too.

-- 
Jens Axboe

