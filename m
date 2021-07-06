Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA444C07E9C
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 06:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB7F61469
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 06:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhGFGbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 02:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhGFGbP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 02:31:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57156C061574;
        Mon,  5 Jul 2021 23:28:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 62so12365473pgf.1;
        Mon, 05 Jul 2021 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TR1u3sRWI99pfiHxerbHetS8AvWmZAq6Zxi2S+X7xBM=;
        b=BQSTFgo8lk6p20yznXf61GjDalo7+DJT77UfsbMMDIVKg+ZeuSARuEpiNW+FopzG0M
         fMHX0VUVQEKOkm1sMk4dYQgU92097mXX5LCZvJHsvqScg0+4CSLwbqeie33KmahF2Hqm
         mtQwpCrLhvlRBqZ1iQbtct0GVl/VR3SWOti2J4pIfNonVAGIHFNZd6/C8HmGaWhj+Qhu
         sAOkSXAGsmGw/ui3jghF5kRpM4B/e47EpSGmjQDDre4QiFcxNYBPjUXN+5QzcREuL7hY
         Z324CvpI76ydg1mPXq3k9vh9nxTZJaTsy8f8HpWfdhV6JhFeByVjkipSKlgqlU1vVgeS
         7pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TR1u3sRWI99pfiHxerbHetS8AvWmZAq6Zxi2S+X7xBM=;
        b=cb/z71QdoQM6H88kZgU/m2fjR1EqGcE0UaPVgTho2OvbsdCttrSsOZHjjc/owLDfJL
         bBL4m0YqF5l9fccRjgENyDgaZpbITQhUfLb2sNcjrFUPEeejFofjF2aJVWyqbh79qCqQ
         tFVmYu3TwwoQ1YUZGS4cTCMJYF3Mak5ByAI9TPjW7//q+OZLwtvOBJz9L8bybxfisHSO
         Tbh9A2VNNsYFzPhjLRUUWwe1R6YPsAaTCoYhXrvJx4tSPzZQzsmsNRTcf3t5Z1SSJOq3
         WxCVD8PqaDOnPehw6wnjhYB8O9Q5nxa+pL9vYDE+fAM81wDG9YPyBedsmnaC4hA6Zfhe
         zsuw==
X-Gm-Message-State: AOAM533fFAT2+FsmBqm6vbO12aEDnSYR7s06F6th2BMxJMoTqYrIVEiZ
        5wXbKx5PzcOhtl8AdUUAkJE=
X-Google-Smtp-Source: ABdhPJxCDmVS+t99ctOzw46/3vLLmdX3xjcfGpkIDs27q6CAVrMSuEbFcDMQjaEeDoAnGDHcX6V5uA==
X-Received: by 2002:a63:284:: with SMTP id 126mr19484412pgc.347.1625552916756;
        Mon, 05 Jul 2021 23:28:36 -0700 (PDT)
Received: from [192.168.1.18] ([122.163.155.135])
        by smtp.gmail.com with ESMTPSA id v21sm1524566pju.47.2021.07.05.23.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 23:28:35 -0700 (PDT)
Subject: Re: [PATCH] block: Avoid accessing an already freed kobject in
 delete_partition
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rajat Asthana <rajatasthana4@gmail.com>, axboe@kernel.dk,
        damien.lemoal@wdc.com, jack@suse.cz, rafael@kernel.org,
        syzbot+7d6c5587ec9cff5be65c@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, hare@suse.de,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210702231228.261460-1-rajatasthana4@gmail.com>
 <YN/1DOeSA5ODf1AV@infradead.org>
 <0c623d71-6d99-2e0d-4d8b-63a1ff814dc1@gmail.com>
 <YOPmMZdMQgXAyEMO@infradead.org>
From:   Rajat Asthana <thisisrast7@gmail.com>
Message-ID: <067affa2-827e-06b2-dbc4-c4ae897e1a1a@gmail.com>
Date:   Tue, 6 Jul 2021 11:58:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOPmMZdMQgXAyEMO@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> No.  There should be no need to check anything, but the code needs
> to ensure that the block device is alive.  I think the above mentioned
> patch (now in Jens' tree) does that, so please try it.

Ah! yes, found the patch. I should have checked earlier.

thanks
-- Rajat



