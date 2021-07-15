Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06689C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA15E60BD3
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 07:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhGOIBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOIBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 04:01:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ABFC06175F;
        Thu, 15 Jul 2021 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=znEcrYV4hBFT7KlVlqDX/f+svZGCQ0mmfdzb0QtIQTw=; b=rNwF1DfFYNjDeCldspK2vP7f5Z
        Sssyr6zQ0vmm4GzvSfNJa90nN0upTEw0NDJ7dA4/yzNc2U2i0QJ8xN+eucrHmV+mMYBqsiQboqKYW
        Y0IJcnwLAkngZ/d6IIYS8mLKlFuyejkF4hK5ncQwDkddhudmjF52pvwaYbdLjrgBLEbsY3dgiKAHp
        gSA0kmG1m0cA6Z/6F1KUPVnEMy2aCuQBjJhrZT+WVyvNoEsPaM3kUPGv6ak+V6G1FsRzOQtrPvOxo
        vd9jer8d/KyKWzU5SNYUEu+sIWfiGqpesXIgHMA+6mdYeBPpGrRZgWZ50rJypUOH7k4p4wezSRa2C
        jr0+hf/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3wFA-0037YB-7B; Thu, 15 Jul 2021 07:57:31 +0000
Date:   Thu, 15 Jul 2021 08:57:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] block: add initial error handling for
 *add_disk()* and friends
Message-ID: <YO/qXND0KNfi98Fy@infradead.org>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715045531.420201-6-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -static inline void add_disk(struct gendisk *disk)
> +extern int device_add_disk(struct device *parent, struct gendisk *disk,
> +			   const struct attribute_group **groups);
> +static inline int add_disk(struct gendisk *disk)
>  {
> -	device_add_disk(NULL, disk, NULL);
> +	return device_add_disk(NULL, disk, NULL);
>  }
> -extern void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
> -static inline void add_disk_no_queue_reg(struct gendisk *disk)
> +extern int device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);

Nit: please drop the pointless externs and avoid > 80 character lines.
