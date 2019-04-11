Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359DBC10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0483020850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sJW7ncZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKPhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:37:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41848 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKPhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:37:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so3589188plj.8
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JMqohJALClyFjLSz39Tgapkrkhd/P2KdOrlaoSuV/Y=;
        b=sJW7ncZfs5C8C0YtqdlUB9/LsCCPbfG1qj471IKZgotwq8ojQgjFckwRbBk79UToaH
         b8JtdrcGM6s+VsuQoac56FGPkUvImp9yZsWAbgqPdlmHvjY5T/RdHQEaZMOoc6iAKX+p
         wKiwXxQJ7JMKLfcyuYrZN9o49nDvOj6xTezSembfUcxRwL3PEgByXP06hSEIV9IB8aLa
         yK+MwlHnxuBPWdq/jPXEsfQj/ETPqOSJApw3YiNhxieRvbopW1Z8VMwR5CvVyy6/CcCh
         4Huig2zPsm7AseJu0gzJ3C5KrHzfluz9fOs1++YsKazln5keI0PF5FWXbR7OmtE6cEQY
         v/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JMqohJALClyFjLSz39Tgapkrkhd/P2KdOrlaoSuV/Y=;
        b=GInorCiPpsZ9nb8ADXE58ZHgp3213n8cgqtORJFK0IUQdptedlwsdjr319REBRwuoJ
         OVqNHsY+Syzx+i+9rUcluXjJNqyy1ocordjxZkT3r5eCdzUQDeCFU/sMqrGd7ZmaYlP+
         azxUZpCU6m5WDGmhpR7OsIynGFeWo5Jn4fm3+Ge+JO3iSQ4nF7RDV9FCrLnYqzxtKbG8
         W1QH4S91dvUiUSyrHRYBlU8GInMe/YvWClVnxLlL1x0jmZS6EIzAR6NkvzIORxFQbn+D
         oOPCRyFsYoBF/IAqMgVnB1iS6KZYhC+cMmr2VSPFrABtZos6kicpDyPOs2Lkw0rL5NyN
         sFPg==
X-Gm-Message-State: APjAAAXa6z0LUA/FM29hcHgrqiSwBDvQHySEjCUfJghPnlvN24rRbGu1
        oAEyg3GT3nxfoMX8KXcgrBvEycm5r8Qe8Q==
X-Google-Smtp-Source: APXvYqwhJWHQqt51fnvecziClL9MpZoYMNaEcBPUB81JVJRLMZCnv46VXPeBcn+tvb0r7LB23s1ZOQ==
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr48883259plr.145.1554997040139;
        Thu, 11 Apr 2019 08:37:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p128sm93351596pfp.30.2019.04.11.08.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:37:19 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190411153134.GA16359@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <581989af-bc97-f578-d676-fecf7d0b906c@kernel.dk>
Date:   Thu, 11 Apr 2019 09:37:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411153134.GA16359@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/19 9:31 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> two nvme fixes for 5.1 - fixing the initial CSN for nvme-fc, and handle
> log page offsets properly in the target.
> 
> The following changes since commit a3761c3c91209b58b6f33bf69dd8bb8ec0c9d925:
> 
>   block: do not leak memory in bio_copy_user_iov() (2019-04-10 16:14:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.1
> 
> for you to fetch changes up to d808b7f759b50acf0784ce6230ffa63e12ef465d:
> 
>   nvmet: fix discover log page when offsets are used (2019-04-11 17:28:30 +0200)
> 
> ----------------------------------------------------------------
> James Smart (1):
>       nvme-fc: correct csn initialization and increments on error
> 
> Keith Busch (1):
>       nvmet: fix discover log page when offsets are used
> 
>  drivers/nvme/host/fc.c          | 20 +++++++++---
>  drivers/nvme/target/admin-cmd.c |  5 +++
>  drivers/nvme/target/discovery.c | 68 +++++++++++++++++++++++++++--------------
>  drivers/nvme/target/nvmet.h     |  1 +
>  include/linux/nvme.h            |  9 ++++--
>  5 files changed, 73 insertions(+), 30 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

