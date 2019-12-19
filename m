Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537E1C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A73218AC
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 12:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AVVsH4ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLSMfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:35:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39668 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 07:35:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id z3so2492443plk.6
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+enTLPaxJhC1TwqAq4+1F2qGOQKD/UrJ0jEU9e+3gRs=;
        b=AVVsH4ZQJTG7PUhNZ+zAB3TrhrGWSyTSr61KlucnS3IksTaWlHRnzVi8pgdHgeg+1w
         /uZ5etKAgSYzCHehz5PhQssEh8n/UrzhuGik1x/ZuVb3rJazdXXxnzLUu69r0Cas+cQs
         SFjxhzqwfK1jrPKa048n7wh2Qt8gS2W+YAErnwBJbeh48orHTn38Pp5Igf5xcfVpYBmx
         MKeZ9rn+ApvIwaeJ7BZIqX+0mH75IyOY46wrL30GKbjeoZf5tHHlKeegGi/qeNNOT1fz
         5+kY4m7njdz2QPgniZcPK3h9DqZ8sbZjntfBVsu00swMx/ITnZKsO7+7Ebn30/vx0lDn
         ONew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+enTLPaxJhC1TwqAq4+1F2qGOQKD/UrJ0jEU9e+3gRs=;
        b=B5lQU+qBUyuSbcrMDFqDT5HvzG3k0aj5TqRFTrlwHVaetrFUvlq9McUueEQtzl3tWo
         1vJsWs0NUfVkZJw2ym/qZONKpG4qUrEt1JLMaUCU9PV+/vhymMcdPWCRH4mEFOjW2Cpk
         zoB8sjwSonqaG384MezySoF5v4urTMUD4sFAo1moIy3jkt+KCy06g2PKD2iiNNJukFUG
         Rv55aZgSeF/m0KaxAq8jq/k88ABDWj4fosI495v2PXHcqM1MqSPbPdr/DQQYB+hxNM0+
         N70FqEFvSnzv3TWo2v/Po/4pdPdVkfaUMnqUFhnsRLbEiBC9JkP9HZPQ1JxcflO/t/JD
         bEbA==
X-Gm-Message-State: APjAAAXfFN/QxJpcSzEoxuhgArlxkrDi7LBBA32punBJynAS99Qm85Vy
        gaMQpYuNhHkJVq8mnyy5cVUWEw==
X-Google-Smtp-Source: APXvYqxwpK4qbhD/LMFfaxH+fRVezUHLOcOMQQEUJAWogK8KhDdXF0sZnsAkld/uIRu+uB7d3DLIEA==
X-Received: by 2002:a17:902:6802:: with SMTP id h2mr8746717plk.233.1576758902414;
        Thu, 19 Dec 2019 04:35:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z14sm8487146pfg.57.2019.12.19.04.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:35:01 -0800 (PST)
Subject: Re: [PATCH 0/3] s390/dasd patches
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20191219084352.75114-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <911ec978-791d-aac3-072b-dab9f3d1bf54@kernel.dk>
Date:   Thu, 19 Dec 2019 05:35:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219084352.75114-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/19 1:43 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following three patches that
> 
>  - fix a dead code path for DASD
>  - fix a memleak in DASD error case
>  - fix typo in copyright statement

Applied for 5.5, thanks

-- 
Jens Axboe

