Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B1AC04A95
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 14:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiJYOIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiJYOHp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:07:45 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802C91911EB
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:04:10 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id b5so11544743pgb.6
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Te46Alpl4tynaaATY6iERpmfuiFBUQ+4oa5sHa3QaY=;
        b=jJzZwxfBqk1IE0sk3yZyPOKB3FhpLalRxMOxSjyrgKtM3u8idlfVm/YiToM8X1g0ze
         DYgHv7KeJYXvPdcY8u563crfVnzL9vjcyKNRsbUYh1TplXm9DYhfsW2iRvtcge/tTW3/
         LK4fNMWbYvoGDo1FSSG59eDzfYJS6K7a050ThJhASYKgJQWtEWcpMjHWfKiHq+GqEBhg
         CCp78uD6BOr/ymdruw/cgFyTk633NGhpId2/fDGJqYxIr02HCW/O/BDhLWfYHSmlIojB
         3CmIKIYgJVMcscb0AjQNKs/XXD5NCMyGUCRY4zLBBnJ/MfKXLK/DFJXLGOiYcYwgjswd
         4jjw==
X-Gm-Message-State: ACrzQf0dMjhXjyuv8ikeBG+hCa8Si1keBadzB7Ke8VpXSlohN89SrFA6
        qEBE9wcC/WIRrzsQ2wJ+VwI=
X-Google-Smtp-Source: AMsMyM7ShonRU+/ZarCJpF/LAJmrHf0u81CHO0oOSPS+LEOrBtV6JCu5S9xRZrl8cFUeZYdWnfx4Lg==
X-Received: by 2002:a63:2a81:0:b0:43c:5fa6:1546 with SMTP id q123-20020a632a81000000b0043c5fa61546mr32451709pgq.43.1666706649949;
        Tue, 25 Oct 2022 07:04:09 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b0017f61576dbesm1247772plh.304.2022.10.25.07.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:04:09 -0700 (PDT)
Message-ID: <12132794-b7ba-5b87-4dae-fad592a74ee9@acm.org>
Date:   Tue, 25 Oct 2022 07:04:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early
 timeout
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20221025005501.281460-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221025005501.281460-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/22 17:55, Ming Lei wrote:
> +struct blk_expired_data {
> +	unsigned long next;
> +	unsigned long now;
> +};

How about renaming 'now' into 'before_quiesce'? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
