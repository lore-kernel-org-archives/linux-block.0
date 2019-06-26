Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A74EC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63B8208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2Ym4gh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZUok (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:44:40 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:37974 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUok (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:44:40 -0400
Received: by mail-pl1-f177.google.com with SMTP id g4so2063495plb.5
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQhpZ5m2TAfpymIa9INYQdstPu0umbaEZF/uTq2krwA=;
        b=b2Ym4gh2kShglURw36p+H8bt6GadL33KwGBpi7XYrlvZxeata2jrVxYJ2c5qNZrayi
         IHBFX/cSxlvTTQ3XIQ4x61xnnKk9E8DS5lN975PxDfVvVePA7Qg/GqLznKDv5eolUEQh
         pcvGgNeM7VFKgBFELWRU3X8KTdb/WYyCDJunD+AvWAAqBOy09Y0m0nujcG10JZU8n1yd
         FcLsxVHZP8anZR20ttvdIodtNOfHU0RPQsTSId3KevBDNLiWXpbTYbU8etAX5xYX1yXA
         g7kALOIOPOdE4UnO0T9ixrHlAB+W1qGd0SbljahXLLoQXLVJJUlbdVt/Wu8BOWeeMzP7
         OX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQhpZ5m2TAfpymIa9INYQdstPu0umbaEZF/uTq2krwA=;
        b=a2If+TsxtH7z7aUwHx2F+ZG5NSp1ZI+NYizarQTqB2ilL3UhuTR3UHe0xII5ZI7T36
         bBu1irfrPUYNfQw9IcDUouyo5bi94j8ydWey2mB+XBmTnmTBymmk7126ZsQ1sGcXLMod
         uryUS8PW/jHqD7CzVdW2LdlEavOSXhxyLW9e7TgzbLiIOq/1zB52rqV/r23GA2loyHO4
         2AHYGRUdWb+WEqjwgOgZ3Avhw/Z0wWsYGg6ZL45j38R09sHsd9YBnGBbvopjxqCv9Tem
         1ZJ6VnPOxPkeFgy7WGqskdhjtC6SIB1shVfJYuljKzTdqCALn5juXyculsURwQGTCk4c
         ksqQ==
X-Gm-Message-State: APjAAAUA8asU4RzefqqoKS7+LPyCdz8qqAqv2+Ki6uWUltJhyJ6EwO+g
        ZvMW7aHa6m/TgM1IEY75MGvFUhDspqk=
X-Google-Smtp-Source: APXvYqznfVwYOZWxjV3h6aK3cLISzL8TrG23CiqcpAm01kRPjnkqHd3agWj9z6mVJloN7sGvE0TZWg==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr79105plb.108.1561581879387;
        Wed, 26 Jun 2019 13:44:39 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id w7sm114096pfb.117.2019.06.26.13.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:44:38 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:44:36 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 6/9] block_dev: use bio_release_pages in blkdev_bio_end_io
Message-ID: <20190626204436.GG4934@minwooim-desktop>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626134928.7988-7-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
