Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFAFC88CB4
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 18:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjFLSPn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjFLSPm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 14:15:42 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCA196
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:15:42 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-65242634690so3557323b3a.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593742; x=1689185742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MK77dZIoejq4zbFlwLgiZJa5Ghce3Uf+JmDNi38uytM=;
        b=jo1BwIWNW+hIHE8sUVf5BLO3nVZctpYaUzRJi4SJgjOqDUyK9Y5JZnGEriSTDG7eNi
         DfZR3NbusXUvcv/5dHZGkSkfVO2GncStw/IZAkoBTBG9/HgOWdkq1GjRZhdGvmYqBKpl
         FPqjPGAEf5qgkceWYfOudroDE7046M/mMdOR86izIBBt6VvjNXq9i3fmHGXHR/nyKOz4
         w+/1GKjnPqc48auQOI9zarrZjZRG4QTEu9WeFr1Gaas12nOz3/ghPzDIozNYigOAU43T
         oqr9/775IGJIuhupCBGGwMmpbBNAAEQ5FOihb/mogBUTmJbTARkeCU4zLw1y5x16kXHx
         3eLg==
X-Gm-Message-State: AC+VfDxiNjwX/Iu/btua31Qzkep6RxbGJyWFCTBLAmt1ekgOs6ivFWfV
        vo9MeFBEmg4tnu4xIdcQTlw=
X-Google-Smtp-Source: ACHHUZ7guJaCiyzojqYAd5e42Whgi3mrgEdc3bI+8pPvtizV6DxS9Vy9knjQFFtmSaFNNs4bqq9Rew==
X-Received: by 2002:a05:6a20:d395:b0:10b:3b4d:8c16 with SMTP id iq21-20020a056a20d39500b0010b3b4d8c16mr9506671pzb.38.1686593741656;
        Mon, 12 Jun 2023 11:15:41 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id m25-20020aa79019000000b0064d1d8fd24asm2764717pfo.60.2023.06.12.11.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 11:15:41 -0700 (PDT)
Message-ID: <6240756d-718a-ccfa-e479-9a3f7a26244a@acm.org>
Date:   Mon, 12 Jun 2023 11:15:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 0/9] Support limits below the page size
Content-Language: en-US
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        mcgrof@kernel.org
References: <20230522222554.525229-1-bvanassche@acm.org>
 <CAB=BE-SGR8xc9JOF2g4vGVYp0MRmV1pG2WLjoWo3YwAGL1LKJg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAB=BE-SGR8xc9JOF2g4vGVYp0MRmV1pG2WLjoWo3YwAGL1LKJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/23 10:14, Sandeep Dhavale wrote:
> We have tested this series on Pixel 6 by applying to android common
> kernel at [0] successfully with 16K page size.
> 
> Feel free to add
> Tested-by: Sandeep Dhavale <dhavale@google.com>

Thanks Sandeep for the testing. I assume that the Tested-by tag applies
to patches 1, 2, 3 and 6 of this series?

Thanks,

Bart.
