Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185B2C433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiKPVsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiKPVrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:47:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00B15FD5
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqBOrG9rli2QJrkKNVbeBDdgpPeZ5Pcyt9IVG+ltwAM=;
        b=TNXqoFjIluxUYajWCGUpkuHLF1mBCRN20d+5XWfIfsgsuTjwRT2n+iuyGl97e0d5R+ns+V
        QYOFJDGN7PBC/u5/bYc/vbdZAnha1uWBEgSpRXz5bm2WsH873QcwZz+E7gOqjX50rEjcPp
        KBoFpxzyVlRtCyiMCEDM6VACsiqghwM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-E68ZxyZMMSGjoG0rkK56aA-1; Wed, 16 Nov 2022 16:46:37 -0500
X-MC-Unique: E68ZxyZMMSGjoG0rkK56aA-1
Received: by mail-qv1-f70.google.com with SMTP id mr7-20020a056214348700b004c6806b646dso207557qvb.14
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqBOrG9rli2QJrkKNVbeBDdgpPeZ5Pcyt9IVG+ltwAM=;
        b=7wFk+eQfP9fFtuw6zn8kz7rgXpj8dnVclOWXwTUhgP6xYgHkb5uBH+kwTOKePLQm2L
         ZP4rjSYveeWSUB/8tpuWWPSqQQEgTAjRMR7nJc23F/jpytBfYlNb5UDEO1WGdRE+YCBF
         U6j1JHIGlE/p3u/u2mp1DfeDw03MpJrI7FwOpEavjIoNxvFW7eepB1S+0SxXQPytOi5z
         HcSdxc/2y5a5YlRPGP5U5u2xVOd88Yow+48ve6lIQKDz+ytwEyxSnVG8g6CLrW8JqAYk
         ArS9DwoDMrF0QqkLBi6Y4O+BR9CQ/k6es0ee9i09/oCZXF4zljS5VHx3AxDx7bMoBzsV
         yNTw==
X-Gm-Message-State: ANoB5plIO47ylFR/6UU8PZNe0DBuP9GmFrosNxN83MacNRkV+2chTyJD
        8A9FhTd19o+EKojIUp9YXdG7eKLTX8MyOKpHjYQRhNx/9aLhUhmGxP8Qaxtnl02CNEhuS2L0tLa
        plCR41D4sibHaDIkalM61YA==
X-Received: by 2002:a05:620a:439c:b0:6f9:9833:1e21 with SMTP id a28-20020a05620a439c00b006f998331e21mr20998701qkp.715.1668635197044;
        Wed, 16 Nov 2022 13:46:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5CNustigt3HWzBTGO59Iu4TDYZJeRnveeOzDy21Xv1w6GMw4lyGw6Oe0HN/e1q0sFig+Vh+Q==
X-Received: by 2002:a05:620a:439c:b0:6f9:9833:1e21 with SMTP id a28-20020a05620a439c00b006f998331e21mr20998686qkp.715.1668635196850;
        Wed, 16 Nov 2022 13:46:36 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a409000b006bb78d095c5sm10888736qko.79.2022.11.16.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:46:36 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:46:35 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 04/10] dm: cleanup close_table_device
Message-ID: <Y3VaO4PQo4rRIRBR@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-5-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Take the list unlink and free into close_table_device so that no half
> torn down table_devices exist.  Also remove the check for a NULL bdev
> as that can't happen - open_table_device never adds a table_device to
> the list that does not have a valid block_device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

