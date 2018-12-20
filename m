Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EABC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 23:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EF3206BB
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 23:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="VJfN267A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbeLTXzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:55:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:32880 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLTXzY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 18:55:24 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so14369325itk.0
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 15:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FL6kecKLxUt5/yFLbZQoySH493nMofYTBkONpf8aXlU=;
        b=VJfN267AioxcN9sp0EXMj3fjBJZbVdLRgcZenix4HAmxjgw9tXnYBPyVjLzheWAfgm
         6a9PSAvZYMzq3X7XjEsqnoI7WzQ2WIr7DSJuo/tnQbT2bkV2plmAvt7hZSLbU7d9bG79
         rBL4S7Rn+ZEtigjnigWvr9b6KmNcBtD7nZhm5rQmDLZb4jPZTlyFQp804TEB3QuUr8K/
         5hGhzKnVDUUqUawG/DwZ+gu0/jp41Ir+KCqwQ3oQTPBTlumJPQAYj2TtKvSC9AVVIawc
         EW15rTgYPzpLtHKYS5qr/QOs6pD9BTn0yfxsy4x77YNUGBrWXVPgWrfre0CZqg/6R2pT
         rcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FL6kecKLxUt5/yFLbZQoySH493nMofYTBkONpf8aXlU=;
        b=jtlHmvHfJKwwqx+SboBh1Om0sdKz8ovs6NTMxY3sxxd44pIJcWABNt5mj+5kelKvHK
         QY9Y9EYpcXqaBU0l5E8sOwLjLpNOJ/p8RQ+hjBBGZHMS5HxPFRozp7jrEC2XZmQErzM5
         cYNngG+/vtfTOEv9O0Bu/bnkXjtIT0UhgXtpAsnvhUvavjaTkHfzT7DrpZYwFOMQFPPA
         ZXwxepisV2x8XaCRrNVnT7Wz+BkHJRY7sIQwYRGZC3gK2NTNUIzdKZd5CbYPiUptH+fI
         LSl68q80ZDU0UDGlf1N9pSCMLBPxGuROQSmyxg4fsSQ+e9NCrz+bMr1FmwZkGGgErvI1
         mMlg==
X-Gm-Message-State: AA+aEWYLbT0rSHkW3IA1NQw45boYb3q7bIEaCzOiZsVmak2YXomZf6GU
        iDR41jydeYOFyirB0m8JTCer4A==
X-Google-Smtp-Source: ALg8bN6jR+9ebEo/OJGzbYXx/fssI+7k1o/nVhJLsGCO933VNJDrhGibxnoaLB1/H9GOJGVLcx0kew==
X-Received: by 2002:a24:9144:: with SMTP id i65mr622017ite.115.1545350123167;
        Thu, 20 Dec 2018 15:55:23 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:ec3d])
        by smtp.gmail.com with ESMTPSA id n20sm982963ioh.64.2018.12.20.15.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 15:55:22 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:55:21 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: Re: [PATCH 1/2] blktests: add cgroup2 infrastructure
Message-ID: <20181220235521.GE11852@vader>
References: <20181205153404.26634-1-josef@toxicpanda.com>
 <20181205153404.26634-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205153404.26634-2-josef@toxicpanda.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05, 2018 at 10:34:03AM -0500, Josef Bacik wrote:
> In order to test io.latency and other cgroup related things we need some
> supporting helpers to setup and tear down cgroup2.  This adds support
> for checking that we can even configure cgroup2 things, set them up if
> need be, and then add the cleanup stuff to the main cleanup function so
> everything is always in a clean state.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Since Dennis' test needed this, I merged this patch with the fixup for
check folded in.
