Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD08C4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 21:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiKPVUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPVUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EC60691
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668633566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCYGmyLDobaOWhMO5cqt6VIfl5tBZ1SXgoRZ3UG9G7A=;
        b=RG56Ca3ELSzcr9QR4D8vZmY2ESo2k3W4tnsuLgSPq+NSXZszUnLd+EfboUrgR7/KoHBUlX
        HpwEZhewhvGw1MvwlpXlYOmSzWvY0LjHDLzlJIlAtiRvfI92n0zzNeQ9EYgxhklkXX+VRS
        qWQYXMGkbmWccSeW19vpG/hVbIJoiIs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-A2Njg2vfM0yS0zXI6Cf2bA-1; Wed, 16 Nov 2022 16:19:25 -0500
X-MC-Unique: A2Njg2vfM0yS0zXI6Cf2bA-1
Received: by mail-qt1-f200.google.com with SMTP id cd6-20020a05622a418600b003a54cb17ad9so14083247qtb.0
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCYGmyLDobaOWhMO5cqt6VIfl5tBZ1SXgoRZ3UG9G7A=;
        b=Fz2zmOh1IaKS5GO2JfTZsr3gdJ9gaok9Zwqk2oxN/sDI8im2AdePvAQkCRYEADrmxM
         mHK5r0rq9YmEaeaxzLl50wN5s9timzV+GrKGHkNYEH85/L054o49+lDwj6HIjNhE37UO
         6lgj29xdvBZIjD/5QIPAh9H1RIcebyE9yqLxM48eRSXWE2+ryju3Kbyny3QI2oUpMc+3
         wnEcZbBWGfU4NVQxCkW819jXNUFdfYIBnsasIqzajiHjs4Mzn918/w9fyWE925tEOZry
         nvD6g/2J54dKgW71j4h5HFZuQ/CriXvrcYF2vEq44G0Um4jNlleSvAhdB3ofbFyhyrWI
         7FWw==
X-Gm-Message-State: ANoB5pn7vRPosYSQoQ4T/gVeb8B08C7cIdHMnaqaoWLSgPPmRQwvksYT
        lh2RFzMTXMi0ltclOfmJ1YWfio3DXu3YpLR956uCwyOnNJ9tg/FfQ/gBA1nYQPww/hYldmJpr0q
        xF1HtrNdQkzmQoHWWb1u4ng==
X-Received: by 2002:ae9:e00a:0:b0:6fa:dde:394b with SMTP id m10-20020ae9e00a000000b006fa0dde394bmr20880851qkk.265.1668633565301;
        Wed, 16 Nov 2022 13:19:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf79d3ufTC3euri2dfEG/6gEWLrTi+hGugOKpv+coUCcCq4MU9SJtMQwDTIFAPdLoCphODrNwg==
X-Received: by 2002:ae9:e00a:0:b0:6fa:dde:394b with SMTP id m10-20020ae9e00a000000b006fa0dde394bmr20880827qkk.265.1668633565092;
        Wed, 16 Nov 2022 13:19:25 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006cfc1d827cbsm10879419qkb.9.2022.11.16.13.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:19:24 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:19:23 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v3 03/10] dm: cleanup open_table_device
Message-ID: <Y3VT22zmwOlrxdsw@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-4-yukuai1@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Christoph Hellwig <hch@lst.de>
> 
> Move all the logic for allocation the table_device and linking it into
> the list into the open_table_device.  This keeps the code tidy and
> ensures that the table_devices only exist in fully initialized state.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

