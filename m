Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2104C169C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 00:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979AF217D9
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 00:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfBDALf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:11:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37311 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfBDALf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Feb 2019 19:11:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so5954084pfb.4
        for <linux-block@vger.kernel.org>; Sun, 03 Feb 2019 16:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bP3pzkeIjq75ybTl9BmuoLcex6J75FZcpHxtjNC2kUg=;
        b=EYUJoy1z/FIkqvvPPJxvQp/nePm9n7e3U60X9PJuxLulRYIWxqbjKhlwY1BQJAZqrq
         eRkIvi1qRd41IlvxugnAlAcl7H/EwgtPz7yyrqxew//6V3ANDwxJrqqLM45gpBiwG6ZO
         rGhA6BBCWHYoxy9jyWWUGg6WgIuNrwGDRmGFc8TWzaM2+wHB7aNuzqjH8V+/N9CpmI2o
         ilTTx770H5VopqUNiW4nnWcJXZThB7q4HQDvW0jZuoylqZXT2C9LKnezhVF1qfkeiDCI
         lhFfuQ2xGkgQQlykRhqn9AFdV0HX+tIR3UpNfmhbz9xPROpbzbJfKGU9jhWlxuklMhin
         cu5Q==
X-Gm-Message-State: AHQUAuawBWwIJ/3+vxr661AaHG2TnoIfkrcw2WLIMDpCx+K8860R6EAz
        FiUjAbUjv7RqQAf2ne8gDZk720+c
X-Google-Smtp-Source: AHgI3IakfdFeDTDsEUXxaJJFLMn6+a1BmOR6wsiP3C3dqrY7fk59V6Q+xZsd47Z+4z+jWLD6v+IeGw==
X-Received: by 2002:a63:da14:: with SMTP id c20mr10442934pgh.233.1549239094374;
        Sun, 03 Feb 2019 16:11:34 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id t3sm9523392pgp.5.2019.02.03.16.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 16:11:33 -0800 (PST)
Subject: Re: [PATCH] bsg: allocate response buffer if requested
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190130094424.94255-1-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c35fea50-12ed-5fb9-60c7-f588e4ebbe04@acm.org>
Date:   Sun, 3 Feb 2019 16:11:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130094424.94255-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 1:44 AM, Hannes Reinecke wrote:
> The 'response' buffer from bsg is mapped onto the SCSI sense buffer,
> however after commit 82ed4db499b8 we need to allocate them ourselves
> as the bsg queue is _not_ a SCSI queue, and hence the sense buffer
> won't be allocated from the scsi stack.
> 
> Fixes: 82ed4db499b8 ("block: split scsi_request out of struct request")

Since this patch fixes a bug introduced in kernel v4.11, should this 
patch have a "Cc: stable" tag? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
