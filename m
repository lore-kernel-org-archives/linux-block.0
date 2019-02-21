Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB7C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287F020836
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XyDm90qR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfBUR71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:59:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38986 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfBUR71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 12:59:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so14534293pld.6
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zqWQEFJNCsXtclZrJg3LloRf2CzHo8XUIGfVxIcRegw=;
        b=XyDm90qRGCd84L8GwARXe/4Mqlvlwtsy8ktG4INq6ux9In+qUtOyTZ5G3CpDp3FGwn
         A8Kn58sx6Jq1Pijuflx8PY1jC1qIqZvnUDv4sg5SLlkZnG90MbNpmdYOHnqWjTIUAqyu
         DY/FyzDae1NTe4PY48KHDOAY3K/KYn0K5pqr86rtLl4J7ghpLlQZeMvNwR6m8sjOJ9SX
         ds9X+cviYjy1JSVyeHiWhilIPzuVx/Ggdh6n2YxERsDgc2ethKCRCx6FbsdKrQWtDkdM
         WEm9fvonE3no35qoecXfniTn2LsSHlw22MjCji93aZWDT6iP6qVshFqFEhrphDOOUYai
         N6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zqWQEFJNCsXtclZrJg3LloRf2CzHo8XUIGfVxIcRegw=;
        b=PEoixxAYYEb86MRpVRAzOzXL9SIKWVkz8YgVlkbN+gzWlC3pdZyao7oUOkKUYrnuAm
         89DjXGcW+R804ufDmwvPVw6i5xKvsnD4o6QlnJQGPI0t5HUIFUE0/x44r4A0yCtHtQoL
         AIlLiza88pCj3bZ2lIOpw6/p609MaOkDlQtJXDa86IyvyE6ikcyR0DP4Sx/KU8JrN7A4
         L/aDH4VxPBAsw6Ck1ZpCZ69AuRx/k1SwhPYySGHDHiDxBmXOPo0g3gFaP7s2iVk0v8QL
         ByVy7AzUhaJmpGsZU1tBiEUvLUxHiGGWMKyobfY6fMbP5b9kBHn9XLXLkYXlAbgsueev
         /UAA==
X-Gm-Message-State: AHQUAubqHfv3TM8DYA2U0Z6d4ETy11Hffm5Ysr50Ld7djtd7kMedGBm5
        SOgEGRz95OszNCwMFaXR/wjHIA==
X-Google-Smtp-Source: AHgI3IYKe5dtQOFm8tD1/dtMtVcABV+9445PjWF7c32m6V7/Op5VBhUoEfodTEBVEX/04ylZiMaj7w==
X-Received: by 2002:a17:902:368:: with SMTP id 95mr43833688pld.139.1550771966595;
        Thu, 21 Feb 2019 09:59:26 -0800 (PST)
Received: from [172.20.1.194] (71-95-160-189.static.mtpk.ca.charter.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id f67sm31061634pff.29.2019.02.21.09.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:59:25 -0800 (PST)
Subject: Re: [PATCH] block: bounce: make sure that bvec table is updated
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
References: <20190221154336.25037-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ce489e4c-0ed3-e56c-90aa-8c77bb4d5932@kernel.dk>
Date:   Thu, 21 Feb 2019 10:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221154336.25037-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/19 8:43 AM, Ming Lei wrote:
> Block bounce needs to allocate new page for doing IO, and the
> new page has to be updated to bvec table.
> 
> Commit 6dc4f100c switches __blk_queue_bounce() to use the new
> bio_for_each_segment_all() interface. Unfortunately the new
> bio_for_each_segment_all() can't be used to update bvec table.
> 
> This patch fixes this issue by retrieving bvec from the table
> directly, then the new allocated page can be updated to the bio.
> This way is safe because the cloned bio is single page bvec.

Applied, thanks.

-- 
Jens Axboe

