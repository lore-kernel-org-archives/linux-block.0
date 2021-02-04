Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14334C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D078364F4D
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhBDPxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:53:31 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:43826 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhBDPwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 10:52:37 -0500
Received: by mail-pl1-f182.google.com with SMTP id 8so1960274plc.10
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 07:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IPQw/vw6QrtWvNONNThd5V+63/fFKcr3xt91STQ/8CQ=;
        b=dSjlgfmqLjIOL+30AnPe5krYBc6PukxHAOvo7f3+zJAr+sQxtH7hX+QAR7QHw/WyNq
         cS1w6Xs79aTOuvadPI4yo94jKuFWTuVwWZOdE1E0Fq/RZvPh/yX9v6As9tL53FaN1c0f
         FMUeulXHwzGAeL2gbQyzn40VVXGk353l021G1Uw0h+WBGOu9aPElmwWcWjr01GNtyVBm
         URX9kuCi9aUarz7+BFhxlUaXDu+hHMX0uYNOscIp94kq2NzHUpP4y57TTXBcns7FhCxn
         t2XfJYACE/WgRRVvIjSo95etb9qFJ/eALokmomQZrGhQ0ZXczVFPnaulOA1LYNxyIEsJ
         aWPA==
X-Gm-Message-State: AOAM530kpQOxKXz/ZzDl6Pnr6tXPOV204iVi7bC6Tbv2eXTFd5GGpvZA
        agc8U+OXdC4kMPDTPmT/ulZ9T+VaPlQ=
X-Google-Smtp-Source: ABdhPJxDNe3ZlXWvMwcN5zzlNgSJTMW0C3EyXh520/E+DXTxD2/NaEeUVuGWVAAGuG2Wo7UUx3jahg==
X-Received: by 2002:a17:90b:4ac8:: with SMTP id mh8mr182224pjb.38.1612453914857;
        Thu, 04 Feb 2021 07:51:54 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:8322:e64a:7b80:3b82? ([2601:647:4000:d7:8322:e64a:7b80:3b82])
        by smtp.gmail.com with ESMTPSA id g19sm6415915pfk.113.2021.02.04.07.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 07:51:53 -0800 (PST)
Subject: Re: use-after-free access in bt_iter()
To:     pragalla@codeaurora.org, axboe@kernel.dk, evgreen@google.com,
        jianchao.w.wang@oracle.com
Cc:     linux-block@vger.kernel.org, stummala@codeaurora.org,
        John Garry <john.garry@huawei.com>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
Date:   Thu, 4 Feb 2021 07:51:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 3:46 AM, pragalla@codeaurora.org wrote:
> Is this issue got fixed on any latest kernel ? if so, can you please
> help point the patch ?
> If not got fixed, can we have a final solution ? i can even help in
> testing the solution.

Hi John,

Some time ago you replied the following to an email from me with a
suggestion for a fix: "Please let me consider it a bit more." Are you
still working on a fix?

See also
https://lore.kernel.org/linux-block/1bcc1d9e-6a32-1e00-0d32-f5b7325b2f8c@huawei.com/

Thanks,

Bart.
