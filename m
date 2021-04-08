Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5772C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95211610A2
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHQwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhDHQwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 12:52:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3EC061760
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q29oYU7+PgQv3ImQdZEytRCH3GU1GnkRUKQuVZW+bJQ=; b=B5D+DmP9E0SNV1OcJ3g5AD9/6X
        atRPiTH8PjYJjtWbnYbT1VQsmGYvd62WWatBFl7n0iuEoQijEGpz6PR7yyLFJcfIMMbyFUGXxFJqm
        WROt1IMYokuXgRTzxiSYQo+o2keQgJ3YSo2wleBrgsynwdlhidlZLuwATsz+ssaBoPl8mkti+gBDh
        6tqJbsOIxrGsqce4AD+yrsIXFv7gAFREfHO7AmFmajn9lINKM5PXqMaNKXzlig85O7lTmSm5ZTAbU
        YzSjEiezYMBAmkDNyWYu4s5s1pMI1NFNG/riaupYuZ23iGcAxIJ/kdqDLqQ8X1YkzdHHODHI9HJG6
        Fqrj52vQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXt2-00GY4z-4c; Thu, 08 Apr 2021 16:52:10 +0000
Date:   Thu, 8 Apr 2021 17:52:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com, Guoqing Jiang <guoqing.jiang@ionos.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Guoqing Jiang <jgq516@gmail.com>
Subject: Re: [PATCH V5 2/3] block: add a statistic table for io latency
Message-ID: <20210408165208.GA3944028@infradead.org>
References: <20210408135840.386076-1-haris.iqbal@ionos.com>
 <20210408135840.386076-3-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408135840.386076-3-haris.iqbal@ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static ssize_t io_latency_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct block_device *bdev = dev_to_bdev(dev);
> +	size_t count = 0;
> +	int i, sgrp;
> +
> +	for (i = 0; i < ADD_STAT_NUM; i++) {
> +		unsigned int from, to;
> +
> +		if (i == ADD_STAT_NUM - 1) {
> +			count += scnprintf(buf + count, PAGE_SIZE - count, "      >= %5d  ms: ",

Please fix your overly long lines all over this code.

