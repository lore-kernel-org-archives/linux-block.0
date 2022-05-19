Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC57C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 14:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiESOuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbiESOuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 10:50:17 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC85E64C1
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:50:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a10so5996304ioe.9
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=20w6k18SJj0RfVgFiS/8NKa42+kOVNPQ/C83hP/ofr0=;
        b=DNXn0jr7JyBHedOeZzOpW3zP5sxW3jVOE60w8B9II1WMREIbloApEJm7dlBKAkz8sp
         AGSR+Ad+V+3bOfDsCvL3Cnkr8q8wk6RpJLGhUyKM7pFOlrLEyYl/XoomtDImAvyouU1L
         RzjG3LO3TA1tsgoCpMMiZVy5fukzKmjBdXlB/qKaMYPTkFoJk2C1wsXe1BWwBGNIWrul
         nV3uavNLciy39xhGBI85IWtUhBx0bceQqY4whWKsdmWbjUTQhc8+S5idXlXnwaolpfyx
         ItWCOtl1dgloks1wOclOY0M1kjLqFCdw/caC+ctHTfvRPr5J3K/PQ+MZWzQEPJHxwAgW
         A/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=20w6k18SJj0RfVgFiS/8NKa42+kOVNPQ/C83hP/ofr0=;
        b=bd1mNLpN9zZtv2EiihTVeQh+ZiWZwgR5APZvADgyKX6uw2aBpN6TFpNeFvv+npoWL4
         J/Bn7HmFC+h2wV9VX+nRX83tCdEBpMtKXBeUCNyksS0EmxERqUm1CoFbEee878jWMQ6k
         0u662M8PK7+3rp37d41dQl7XSY5Kr5oMpprDzp/it760KSEWeSzcw3YrwogoEMczgYjw
         RudvJbk7ZsZQvHWHypgE25qLWHMkpYKP02L/3dbqOol0y857eRX4SFFOxLDYV7ojBp8r
         ii1UsI4svYl2FnBvORE5h815lAhICbpiEI/WFwx2qt8oW51hKgFNJkLOdDOMa2XL0Gf1
         jjfg==
X-Gm-Message-State: AOAM530AYHr/iX9vkjrOGnEmSTnY9SSCIwa6Qr+8myQcBv3c4shScKF0
        AQfC1/+W++Ul0R2wbQoduA9FQA==
X-Google-Smtp-Source: ABdhPJwgvAg8CW+EYtdlvP4ZzsxnZMMqO3E1Bf/M6lmNcnR0kXrxXR7WCla9APGIq+9FJNXr/I+4tA==
X-Received: by 2002:a05:6638:3802:b0:32e:3d9a:9817 with SMTP id i2-20020a056638380200b0032e3d9a9817mr2982578jav.206.1652971814259;
        Thu, 19 May 2022 07:50:14 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s14-20020a02cf2e000000b0032e0dab7ff4sm714099jar.18.2022.05.19.07.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 07:50:13 -0700 (PDT)
Message-ID: <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
Date:   Thu, 19 May 2022 08:50:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Muneendra <muneendra.kumar@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519144555.22197-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 8:45 AM, Hannes Reinecke wrote:
> If BLK_CGROUP_FC_APPID is not configured the symbol blkcg_get_fc_appid()
> is undefined, so it needs to be masked out.
> 
> This patch is just a diff to the v2 patchset, as the original version has
> already been merged.
> 
> Fixes: 980a0e068d14 ("scsi: nvme-fc: Add new routine nvme_fc_io_getuuid()")

Either this sha is wrong too, or it's not in my tree yet the breakage is.

-- 
Jens Axboe

