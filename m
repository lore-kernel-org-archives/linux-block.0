Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C4C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA5208C3
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="WONYUb6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfHFNkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:40:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41561 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFNky (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 09:40:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so41547647pff.8
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ttnWYmtILeIFBSloUihyimwkxfbn41ns5PZ1secKuwU=;
        b=WONYUb6gGmZuRDgIPilqIWjEIu/72wJiK5y8He1TEtDGmtkLcU7BQkn1ZZligaKl/r
         GrfVZo2YK7W+/wvq1HCHM6tJhZoAkUfbLjUyD3gjFszXnceapNh/lDKbvsunuhrxcUQ/
         M6DaMGbqyJbKrAKpQaoaqCPVt4yNxYKpty2FLoad83jlAFp3O1zHhYtc/WfEgU5W4fUd
         /F/1yCkmQUQRk9zN/XHHUlInumsW4BjNfgPQ1E2nb+VeUDAPGgcop4DJvfgQpj4PBuuk
         C+PfmGHm3rqWGNEnEGyey69CJNUh9vIiDJSivqIqyn9v4jqUGkROal7SL414Eejpjqdd
         oLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttnWYmtILeIFBSloUihyimwkxfbn41ns5PZ1secKuwU=;
        b=jnkCOB5MgDA39Kw3duER+9AY+LWVgFR2LXF0uQN/RDsWgOdB1C6mT7qHf7xfCTnSOS
         fdlGPZ3qSZLyj8oANP/mUiQqmNopsm3TiUdJYKC9RwsNVgwP5Q7pn+28mmKQJWMVz9RA
         Bx9JrTejfzl65QCWLppv7mWm1BV/0FGxx+U9UCpy2B/ii8L1J8O/zvlOnfn7xIQ5kEF+
         zmIp1IOQFvT07ZKd0E1oNz/HDnB8K3811CpLsTMsi/PblKt7XnYhsdNubDqsMa+sOWnM
         i1atW2oKuJF4KTFrxPwcq4vDWhbdTRFPqQBCKZp2TeAzp4m20EF7wniVTiqFaUVc2BHp
         6F7A==
X-Gm-Message-State: APjAAAUWmgvLG6nWTiYNC810Z5yYYBrtlk5qs8HMrxgrDDdlJDhi4M+U
        NZY9rzuN2irMrp8EpIqvxgjTjQ==
X-Google-Smtp-Source: APXvYqxPQe0s0dZt3kvk8VxtmiiaVRUL+8RtauB3T+qIJlvvn/GjVTJ69KfiVCmvpynQ0IDLXtF+pg==
X-Received: by 2002:a17:90a:9386:: with SMTP id q6mr3256277pjo.81.1565098853970;
        Tue, 06 Aug 2019 06:40:53 -0700 (PDT)
Received: from [10.71.15.156] ([8.25.222.2])
        by smtp.gmail.com with ESMTPSA id v185sm99080537pfb.14.2019.08.06.06.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:40:52 -0700 (PDT)
Subject: Re: [PATCH 0/4] lnvm/pblk mapping cleanups
To:     Jens Axboe <axboe@fb.com>
Cc:     Hans Holmberg <hans@owltronix.com>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5e99586b-c78c-2e70-efb0-aceef56fd19d@lightnvm.io>
Date:   Tue, 6 Aug 2019 06:40:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/31/19 11:41 AM, Hans Holmberg wrote:
> This series cleans up the metadata allocation/mapping in lnvm/pblk
> by moving over to kvmalloc for metadata and moving metadata mapping
> down to the lower lever driver where blk_rq_map_kern can be used.
> 
> Hans Holmberg (4):
>    lightnvm: remove nvm_submit_io_sync_fn
>    lightnvm: move metadata mapping to lower level driver
>    lightnvm: pblk: use kvmalloc for metadata
>    block: stop exporting bio_map_kern
> 
>   block/bio.c                      |   1 -
>   drivers/lightnvm/core.c          |  43 ++++++++++++---
>   drivers/lightnvm/pblk-core.c     | 116 +++++----------------------------------
>   drivers/lightnvm/pblk-gc.c       |  19 +++----
>   drivers/lightnvm/pblk-init.c     |  38 ++++---------
>   drivers/lightnvm/pblk-read.c     |  22 +-------
>   drivers/lightnvm/pblk-recovery.c |  39 ++-----------
>   drivers/lightnvm/pblk-write.c    |  20 +------
>   drivers/lightnvm/pblk.h          |  31 +----------
>   drivers/nvme/host/lightnvm.c     |  45 +++++----------
>   include/linux/lightnvm.h         |   8 +--
>   11 files changed, 96 insertions(+), 286 deletions(-)
> 

Hi Jens,

Would you like me to pick up this serie, and send it through the 
lightnvm pull request, or would you like to pick it up?

Thank you!
Matias
