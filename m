Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21811C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4C22363
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="EEDZ6kzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfKSQRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:17:02 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:35513 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSQRC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 11:17:02 -0500
Received: by mail-qk1-f169.google.com with SMTP id i19so18317386qki.2
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2019 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZqRLNz3QoP7lC3GoX4dGbpM/0X+BMWIWcZVOVY7dcIU=;
        b=EEDZ6kzKJxHxR0jYrvurpFG7/VtWy3lmas2bKyDXg0ZIHpu7ZvgPRmxgNIdJ5Trl8o
         2i+mkawUu3GG/1fSr9nzBfLa1IwyzlN5vbaTmoKGke3iU9oK6RwfGr4wkUK2CcZ4XRS4
         T8m6NFVGWYmHUhSii2nMalguQ49rr8DmBIkT46n//mCXFsljMqZhQqpPqcvsVRXp5ZR8
         j3Yz/HgyL4AScR2b/nyEyR8AHVMVBqeRo3TLRgbr+kXQezQzjhiWi7JePw3i6rj+I7Kk
         fXVbFKoYoCJ9W+vXBQuspHHAYavKVmMHwyEXIdioL2V4cpezvpipuNysIJNNSxebF/rO
         m8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZqRLNz3QoP7lC3GoX4dGbpM/0X+BMWIWcZVOVY7dcIU=;
        b=p7YDZc/lXubiQcwMTGLPhUcy9apijtQOOnxzAo97RxGwZHxmoyKBkYlnEMXA5R/GE6
         fetjTFogwnerZerI6cx5OMA7cQjolLhRy8ukmRhemqE+iBJN6rhlYcPWSm18dBq7BeHi
         y3uP/eCaxL9eNicrSQM9EqVMo/+cZAr47ywLiQpq2SEXjDfIuiYl6OXjNqSOOHob072z
         forATtRliUKnxyiVIE+mZpG5RDkrw0v0MPbe1xZL/ufR6wiev/iamvbkjTmpTLnKcAqH
         maY8dm0zKDmZZoYMKknWK+imJjIF0FHVKoXrUk2Y7Pypi9mSM5j6u4aTF8h+UvUKzYd9
         yyqA==
X-Gm-Message-State: APjAAAVBxo/+AvOX5+/7gfyMhGtzt4vI6gnZM5yhNkviD9bAoJs5OH0I
        TfQ//jeeG6mrGGIaSgwWv5tHZBXab3tXqA==
X-Google-Smtp-Source: APXvYqw4sM1JFEaj5qBtyeVFL3GFBIz1nwvBoJWPMV830wZLNSSNqslB0uqWWe1hYNiEkrIrWvyc7Q==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr30591722qke.350.1574180221163;
        Tue, 19 Nov 2019 08:17:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::61cf])
        by smtp.gmail.com with ESMTPSA id b3sm9769407qkl.88.2019.11.19.08.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:17:00 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:16:58 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Mike Christie <mchristi@redhat.com>
Subject: Re: [v2] nbd:fix memory leak in nbd_get_socket()
Message-ID: <20191119161658.mmifoeplc5vsdt64@macbook-pro-91.dhcp.thefacebook.com>
References: <1574143751-138680-1-git-send-email-sunke32@huawei.com>
 <d68d17be-0c4e-1286-4327-0e3ba6600eca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68d17be-0c4e-1286-4327-0e3ba6600eca@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 19, 2019 at 09:13:34AM -0700, Jens Axboe wrote:
> On 11/18/19 11:09 PM, Sun Ke wrote:
> > Before return NULL,put the sock first.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> 
> Please always CC the author of the patch you're fixing.
> 
> Mike, Josef - we probably need to get this upstream ASAP.

Yup sorry got distracted,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
