Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CDC48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B380261182
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 20:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhFIUIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:08:01 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:38516 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIUIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 16:08:00 -0400
Received: by mail-pj1-f54.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so2224688pjz.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 13:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BoksenSgpnEXamcDKniBQYmLkYCIbZxuXXBSGNDVLlw=;
        b=X8DjZ/CMxv4LhLuufNxXAB/Sh/M11AdJkhseNRK9hnFw2clsP/JNANVL0JAqvdm2TS
         lor0HjlanSjW42evvLNTciLNVo4TkvWVN0t1jWdn66PQL4GsBNhSVWlf4baj8MfywYui
         LXDnCil1vC1X+uBYFA8WDqyYuhz3i4uWNgxVoqy1cW+M04vyu8xoDuNH0M7iLDKpfn49
         uKS9rkHc0fDGTTHMmi2pgdRHhovzon+uzEWfNOEugcFaQzlA9ET+qYL70j8ktoFB+5kH
         QgO+WrtSibeA13M6MU/Tet4++i0k5iavHxEKzq5/9//77OMW19uWEThD+8H9UkBHne79
         ijhA==
X-Gm-Message-State: AOAM533+Rb2v3b7MONONSwEoBBFYb/eHq5b0cxU67VtfJ/YbYzVROxC7
        DAGC7uQPyYu+FUt79cCjeNI=
X-Google-Smtp-Source: ABdhPJy3BCVzRcAD5VV/pHo9H6wprpjfx3eN5Eo51cHSS4Yo4HvRSywxoE4u/WS+5v72kFwO+ppiww==
X-Received: by 2002:a17:90b:1b44:: with SMTP id nv4mr9007680pjb.223.1623269150214;
        Wed, 09 Jun 2021 13:05:50 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id pi8sm414534pjb.52.2021.06.09.13.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:05:49 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] block: fix race between adding/removing rq qos and
 normal IO
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20210609015822.103433-1-ming.lei@redhat.com>
 <20210609015822.103433-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f4f79e9c-e8cc-7961-55a6-99337e370ff3@acm.org>
Date:   Wed, 9 Jun 2021 13:05:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609015822.103433-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 6:58 PM, Ming Lei wrote:
> Yi reported several kernel panics on [ ... ]

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
