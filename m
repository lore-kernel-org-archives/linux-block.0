Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BDEC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 09:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B2164F72
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 09:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBCJBf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 04:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhBCJBe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 04:01:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAAB264DD9;
        Wed,  3 Feb 2021 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612342853;
        bh=21xtHIBFNzhYLKP8IdD9HOLqg6ALetobvONqOa604I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJJl7U2hPFK859P9pOcdrLDQbBVxEudVXRXpHndGALMFteU8IdHrUAI6tD2nKA7Z4
         epOgg/76vw8ugfJOxIMYZxpUfjsV0rrs+JS5F/8R16EkeBrUWGBY0aeYboHCcIQ185
         XWfLoJwcutkYMj+anykMr0mQJUcOZ/ToHE8JwXko=
Date:   Wed, 3 Feb 2021 10:00:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     hch@infradead.org, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, osandov@fb.com, patchwork-bot@kernel.org,
        tj@kernel.org, tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v4 2/2] bio: add limit_bio_size sysfs
Message-ID: <YBpmQhqx4pvUh//a@kroah.com>
References: <20210129034909.18785-1-nanich.lee@samsung.com>
 <CGME20210129040448epcas1p44da94c82ac4fb82d77c452bda56d6b09@epcas1p4.samsung.com>
 <20210129034909.18785-2-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129034909.18785-2-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 29, 2021 at 12:49:09PM +0900, Changheun Lee wrote:
> Add new sysfs node to limit bio size.

You forgot to also add a new Documentation/ABI/ entry that describes
what this new sysfs file does :(

thanks,

greg k-h
