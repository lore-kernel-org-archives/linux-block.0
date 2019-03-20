Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB7C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE482184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aTvemJ75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfCTUUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:20:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40437 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTUUM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:20:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so2720215pfc.7
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lW3+qJbhPSclcs4l7lEoBF5p9xRCl/NsJflF9lAjmhI=;
        b=aTvemJ75lqJ/9QIWvY9LQrW4KGhkNE670E9Q1t3X+1TwRDteQGIeec2DsdHYiQFOSL
         wDQaYltCjJyHDUYGCcJmfZ7KJkx3pmfFtB2y0sr8OmH1ZZqQcrxquVAUnCB6+Ehzmcyj
         hlUPdfUXf7rid0sNKWrvaLGOXjTytS8DeroU2Z/+6kGgrHOx7t3dlGR0AXeI/z1MVtaP
         0BTZZGeZkSA3PBzHPeVxgYnodoAoWBuHDuKy/8+l3J6vyLKtt7AOXxcN32xSFR7Iun4T
         JT98eMbZyrz40ArCIrsQIencdio+GqNOqZuukreRMOECxtbm8hb4WTVS+RrjLIoIGBwb
         GJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lW3+qJbhPSclcs4l7lEoBF5p9xRCl/NsJflF9lAjmhI=;
        b=Iwm9gO4fJiXc/MCPsOfvqVo1Uhicb5GNqWR4s39VxfY/g9d9Q6QRRV2xAy0eqxxogc
         DEJynJEvIXvtLyJ7ecfTNsP322Hh6ksEgdMdbaZdFSRzGu7LXoeBeATDGoHFXoQTSaST
         rllgmAwd53jiryaGoqw4mU7PSmnfT1CCAx1oUNcV91iyu/TnKA1xCSI2NhhFXNWxwOq/
         mZ+49k4wVtjtOngr3u9lFDuoydLrqOUgPxNu6f5bHH6ZA3wX6lr6kcWQj+fl+W/71tKA
         mW1Xki4AqMJy7/aJDOta0h6qBnKDmKNeCHgmDM4iNusFFv16lEx+4ohgXJfhGIFn75CO
         X0dw==
X-Gm-Message-State: APjAAAWV/MsVCfYSaYzukbQTKC7J9UkxSUq8tOAmbc3Id3Nj0KISytI/
        Y+H9yieN2Sgb4/vl0ClpxfOv5w==
X-Google-Smtp-Source: APXvYqzmvvIjWx12gZ4GGUcCc3qunDKy4uVPYdVOlswS2GsqTjcfW5GJimqjBl6FcB1Z3Q5Cb8Hr/Q==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr10231079plg.116.1553113211537;
        Wed, 20 Mar 2019 13:20:11 -0700 (PDT)
Received: from [10.155.59.239] (96-86-215-89-static.hfc.comcastbusiness.net. [96.86.215.89])
        by smtp.gmail.com with ESMTPSA id f125sm6087068pfc.91.2019.03.20.13.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:20:10 -0700 (PDT)
Subject: Re: [PATCH] blk-iolatency: #include "blk.h"
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <jbacik@fb.com>
References: <20190320201501.36751-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2d85a58-5a6d-b7ab-a07c-ae7b8886007c@kernel.dk>
Date:   Wed, 20 Mar 2019 14:20:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320201501.36751-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/19 2:15 PM, Bart Van Assche wrote:
> This patch avoids that the following warning is reported when building
> with W=1:
> 
> block/blk-iolatency.c:734:5: warning: no previous prototype for 'blk_iolatency_init' [-Wmissing-prototypes]

Applied, thanks.

-- 
Jens Axboe

