Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78917C48BD4
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8152080C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfFYQHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:07:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41444 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfFYQHv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:07:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so9061883pls.8;
        Tue, 25 Jun 2019 09:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKtH9HzdmH5cBJfejfHlKAKRHrV4AN5VjJzCvWpcL7w=;
        b=D7sTFuKgb02p54HZVq/C61h80uZ8uBWNlTjvjD0NcWHZfuQ5/2Sr+mRAsEFGQr5MSW
         bgnkSI1AvKL2VDWyQDiDDRtXB4snwZjEHueGL2I0QPyiBgCFkwngZAsFwPybzTzwmMdm
         1usPHBXv7gmyDSG3e1AijfNNHHWeR2M8W6YBXCkWUsvwz47tHFGUc5y5GfAdOvFRhE2T
         LF6SpcFCiwfvDaux7MfpGQV8PgO5m0SDzVdV70h+pPQiJaJc+xDgKTAcjo/ILwvJWlYT
         Ovd1i0goyWyY0KAy8eXt9JkoL0T37en/JwGQ1/3pBrcCLpoo0UDgq1BXxKWW49L2N6mI
         gd2g==
X-Gm-Message-State: APjAAAVbF8Dh0TU/ZO+xRNbqeILeuT5lOcBIcfAlsD5gH5LaHq7TMr0s
        ldxdDna2pBoM3PFpzQEJkYU=
X-Google-Smtp-Source: APXvYqwUFBtt/U641DHE2fPUc4LjGUngKtnvs+wtDcwY5DYd+StlS/rdY2MeeYRQBdU2sw/QSoa5Kg==
X-Received: by 2002:a17:902:70c3:: with SMTP id l3mr35180661plt.248.1561478870746;
        Tue, 25 Jun 2019 09:07:50 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n1sm13107406pgv.15.2019.06.25.09.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:07:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] sd_zbc: Fix report zones buffer allocation
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-3-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d4737ee2-3e2b-7da6-0919-ea4a62ab463e@acm.org>
Date:   Tue, 25 Jun 2019 09:07:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625024625.23976-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 7:46 PM, Damien Le Moal wrote:
> During disk scan and revalidation done with sd_revalidate(), the zones
> of a zoned disk are checked using the helper function
> blk_revalidate_disk_zones() if a configuration change is detected
> (change in the number of zones or zone size). The function
> blk_revalidate_disk_zones() issues report_zones calls that are very
> large, that is, to obtain zone information for all zones of the disk
> with a single command. The size of the report zones command buffer
> necessary for such large request generally is lower than the disk
> max_hw_sectors and KMALLOC_MAX_SIZE (4MB) and succeeds on boot (no
> memory fragmentation), but often fail at run time (e.g. hot-plug
> event). This causes the disk revalidation to fail and the disk
> capacity to be changed to 0.
> 
> This problem can be avoided by using vmalloc() instead of kmalloc() for
> the buffer allocation. To limit the amount of memory to be allocated,
> this patch also introduces the arbitrary SD_ZBC_REPORT_MAX_ZONES
> maximum number of zones to report with a single report zones command.
> This limit may be lowered further to satisfy the disk max_hw_sectors
> limit. Finally, to ensure that the vmalloc-ed buffer can always be
> mapped in a request, the buffer size is further limited to at most
> queue_max_segments() pages, allowing successful mapping of the buffer
> even in the worst case scenario where none of the buffer pages are
> contiguous.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
