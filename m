Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04B8C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED9861131
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 13:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhJFNTq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 09:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhJFNTp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Oct 2021 09:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633526273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
        b=YMqDlv12XO2LnjUUBU7lDeQni7BKIxaMyHTQqVWPWXft4KFCfOMSqL12RVnRMouNTETfmf
        jrWOdwRjrRby3Jy0hPeDmK14VgYTF7la6A9qFIuKrtNXAXeMna7parq+IOeYWqalHw6Byz
        QcrNR6gRllLs4ajMGeE0CkPiRWDi6sI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-0o07qPvkOlqKkGRitzNroQ-1; Wed, 06 Oct 2021 09:17:52 -0400
X-MC-Unique: 0o07qPvkOlqKkGRitzNroQ-1
Received: by mail-qv1-f69.google.com with SMTP id o90-20020a0c85e3000000b0038310a20003so2710864qva.1
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
        b=gKgzICqqBgVRr3yyQ0LPa3KgclWH/2t4arakb//+f2NBv58NlvseS8tf42Sr97PHMT
         vbZB755L3HeOD8wrEbQ9ZPFK/JIaCG8CyNqCwAbooVI/iRwXFvHssVZOELDl+NAD0gxC
         xmpu2MN4qPL3qMymQHdT2MK66+NVGsLMncgDKuDSHmWthZQVZJBVLUVHETk/z4O39m7o
         IVF46x9o7wgSrsvdQn7atbcmpWhySaC2uJixC2DiLqT/wb7f1YoT1G0HB0I0htDTkuuG
         1zFjs8nZHwX63j3Pp8kn6keaSQOOzKVG6WKWrAb/oNiq5ACCZpuajqC3rPFFY9ymjzcs
         uYxA==
X-Gm-Message-State: AOAM533rmHns0nYUwGL0K+Qg5ppMiCloEc0AKyiOkreX4rlJcxNQFIw5
        BUIebHE8iVrDMrDFmLpVMiZRywx46bm7ae7K+8IuZakakHGXyc9kwqR+weyNiswUE8ENO/92dkx
        o/cVqN8SP8/8zw6BRU4/q8w==
X-Received: by 2002:a05:622a:180f:: with SMTP id t15mr25944894qtc.314.1633526271470;
        Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ/dfz8opFCb2v5qUfLE0aMcIttTRFyUR16Rj5nDfAcBalXCGeyEeOx/El3NjgM1QYp0hnaw==
X-Received: by 2002:a05:622a:180f:: with SMTP id t15mr25944862qtc.314.1633526271274;
        Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r17sm12574405qtx.17.2021.10.06.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:17:50 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:17:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
        ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
        agk@redhat.com, josef@toxicpanda.com
Cc:     hch@infradead.org, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
        dm-devel@redhat.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dm: add add_disk() error handling
Message-ID: <YV2h/iA79JhMJt07@redhat.com>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927215958.1062466-5-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 27 2021 at  5:59P -0400,
Luis Chamberlain <mcgrof@kernel.org> wrote:

> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> There are two calls to dm_setup_md_queue() which can fail then,
> one on dm_early_create() and we can easily see that the error path
> there calls dm_destroy in the error path. The other use case is on
> the ioctl table_load case. If that fails userspace needs to call
> the DM_DEV_REMOVE_CMD to cleanup the state - similar to any other
> failure.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

