Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2FC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiKPVxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKPVxR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DD657FE
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6nojB89E1Mh3yFLSu2KzkNkZ/bHQfVswcYDYKdeZ2Q=;
        b=Z8cBuMZjEnnKhTZkm2L0tOxlZFmtzHOH4US0nddcSiobR0CFYeXyBs3HS2sJyHQf/ZGb11
        RQ4FIQkMY6C6m3hJvq6z24K5cnZr3UbPjQcvegw45skG98UjvvVZydCN1PTQuqrQGfFeNb
        tt1cVrgT87qp//dN4bm/GNLl/+wjkDE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-uMLf8opbOTGLue4mg20wmg-1; Wed, 16 Nov 2022 16:51:00 -0500
X-MC-Unique: uMLf8opbOTGLue4mg20wmg-1
Received: by mail-qt1-f197.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so14081728qtb.9
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6nojB89E1Mh3yFLSu2KzkNkZ/bHQfVswcYDYKdeZ2Q=;
        b=O8iWOXAXMpvwyAQCo5C1CzRs/8hLPXLde6hs+uYcorSsfw3QUtiRrbNVwQAlqtZYdB
         Oj7x4/qK/88V72n8FV4i/84LjmMJIY452RY1yfjNezltcWke2V+tNvmBy7ezc1u0lwLi
         9jl2QbAbBN3AUwLLDMpvqB6zhXI4rUzdwtvSRa6ppoMFD9rJjWzt/kKegrzzikVRAvfZ
         t4c0WoDt5M4uUdWJmhV1jvfuhkb67HXtkqQda9KYMZ+LirgsQ7nNWdGtVLvqU2z0vw4i
         KKw9d4RnxCxSUAKmMDis1gqu4R8Bu89qhGD5pbLyQP0VJcP8CUh/vW2q8UWs5Ve9e1fT
         FXZg==
X-Gm-Message-State: ANoB5pkLbHj60/YMimd1ZJySSjQC+jzpBM5q0Jq7zuSAJEM3Bkl6AXgR
        o4MtQC4CuAf+TL/3u4RxZEVzwOHnLOmBveoQNPa1/9dMDyUfF7dlhRIsUyvU0iXTWT4opSNzqhm
        6S9Jr1ky9xRYb60RHP8yY3A==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr14077837qki.324.1668635459744;
        Wed, 16 Nov 2022 13:50:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5o3UcPKD9RkRXo2oJUoXe+j1L0zcdnOEKW/X0guNcC/Xo8sAb4uEao0tfvbnLS9Ws1eXPm+Q==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr14077821qki.324.1668635459547;
        Wed, 16 Nov 2022 13:50:59 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006fba44843a5sm3063589qkn.52.2022.11.16.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:50:59 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:50:58 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 02/10] dm: remove free_table_devices
Message-ID: <Y3VbQsjmNW4GQHLs@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-3-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> free_table_devices just warns and frees all table_device structures when
> the target removal did not remove them.  This should never happen, but
> if it did, just freeing the structure without deleting them from the
> list or cleaning up the resources would not help at all.  So just WARN on
> a non-empty list instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

