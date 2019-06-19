Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F8C31E5B
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92130214AF
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFSRta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:49:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47101 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSRta (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:49:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so54941pgr.13
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2019 10:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5TvCUG+vCXh4vQSyVQiwbNhbTnHdIEA2FlgGagZq73Q=;
        b=Yn0WRGiesB0ro12K1nwHLNNxCyiSgHfIK55E6/BTIj86sE9Uzv/y9c+dUpShYRhjMv
         aKB7mQVcJNo4/DsKPOe2yKXrs+Dg6oC/uGGd/FoLkAJddIHR2W/tt/aM1WBvD+mq2fTm
         L+Y8N8zE+uPwyMOVplyNkAAASJYg+nf6WEnvGGdTesEULdT/ZskXFBRmPpN55YDe07Zm
         clsT2KcUsHx8VmDJNKRh/skWreWNuTEqKamKnyrcaIlhNO/WAhFlmU7c2D12iY/qntY9
         Vd2r4erlyK7MhpZgccO7UkeSpdX2HHqis1KCGUZN4fetr2S7bRneWcYIJKY0NR+zzwUf
         IBFA==
X-Gm-Message-State: APjAAAVdZWt4KrrKNXKRg4z2LISYlFknWPWR8v8f3H2wFgPnxTxJVwf/
        UkUL4Bc1x2zqafwgW5E/XNU=
X-Google-Smtp-Source: APXvYqwjs8TR8HOF3YppP3BwTYCMEbVafseyE1FzHEEWPTST/WIc7+AolgoEFcd/+Dvpecd5Q1sQYQ==
X-Received: by 2002:a17:90a:360c:: with SMTP id s12mr4294462pjb.30.1560966569700;
        Wed, 19 Jun 2019 10:49:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y22sm30889884pfo.39.2019.06.19.10.49.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:49:28 -0700 (PDT)
Subject: Re: [PATCH V4 2/5] block: add centralize REQ_OP_XXX to string helper
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
 <20190619171302.10146-3-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9a37c872-33fd-2780-1fa1-731d764b8a0f@acm.org>
Date:   Wed, 19 Jun 2019 10:49:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619171302.10146-3-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 10:12 AM, Chaitanya Kulkarni wrote:
> In order to centralize the REQ_OP_XXX to string conversion which can be
> used in the block layer and different places in the kernel like f2fs,
> this patch adds a new helper function along with an array similar to the
> one present in the blk-mq-debugfs.c.
> 
> We keep this helper functionality centralize under blk-core.c instead of
> blk-mq-debugfs.c since blk-core.c is configured using CONFIG_BLOCK and
> it will not be dependent on blk-mq-debugfs.c which is configured using
> CONFIG_BLK_DEBUG_FS.
> 
> Next patch adjusts the code in the blk-mq-debugfs.c with newly
> introduced helper.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
