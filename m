Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B8CC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E352080C
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFYQK1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:10:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41609 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfFYQK1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:10:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id y72so9186961pgd.8;
        Tue, 25 Jun 2019 09:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogV+7OJQpqFA+mtJQXUVCZhNlXCEN17cNlUnhwCtrsc=;
        b=ic92xI5Hn1O7khoka/UakOC7b2CiZaAtNPLqOy0TLn8q9sTnwuqoYfsfJioSs/GSF9
         qpADzaSlUreM/hHmByW/yEUSmQCXKffrLELUlcy3B8lCU1poo8/Uo0s03squpMJuJiZT
         t13MXIYt4Td7+/yvQwm9iMwfebSn5TDGyqaTVuB1nzO2YEYR5nc17L+yR8+8gegYk7OK
         zwm/QXI3Ei7ny1yxpLQlYMWf936+ZKFFU//3dby5WgCbPhwFndjel7xD+UIsrRZz/Mq4
         mGz9rCuDhxP/8YKWMKWDmRoga2vVoDaoPHPyRmE8KcVEYOxQlCpb+kNjDYOYmgUyfmfC
         PA0g==
X-Gm-Message-State: APjAAAViTsiSHrP7o97TXyKmdzQeA/IBX9/LP5TyfTmYo3QfChsIuwV4
        3HXMWxHBOsQp6lvCO7+76nU=
X-Google-Smtp-Source: APXvYqxedTaX2gGjCPjXkSpbNiU86yebGCstfAFkNDehy0K3dqCRglDQF3J+A8YTgCpUsIs7qbdK2g==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr15682141pjv.86.1561479026822;
        Tue, 25 Jun 2019 09:10:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm2258909pfm.66.2019.06.25.09.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:10:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] block: Limit zone array allocation size
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-4-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <754262db-c8a1-095f-9b59-96e0c584e2c2@acm.org>
Date:   Tue, 25 Jun 2019 09:10:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625024625.23976-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 7:46 PM, Damien Le Moal wrote:
> Limit the size of the struct blk_zone array used in
> blk_revalidate_disk_zones() to avoid memory allocation failures leading
> to disk revalidation failure. Further reduce the likelyhood of these
> failures by using kvmalloc() instead of directly allocating contiguous
> pages.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
