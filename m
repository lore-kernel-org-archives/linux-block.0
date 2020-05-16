Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A1C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836AF206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WEGj/zLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgEPUaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726803AbgEPUaE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 16:30:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2FC061A0C
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:30:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q24so2725730pjd.1
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Er5dBwlInT6MWrK0ZEK7+b/MKqa/cnSWtsupyCyxpas=;
        b=WEGj/zLPzOmJWCTX9Zki1BwLdieUcpU3BIHc0fchh2Qiggio8QjSjDcelyHy53vTdD
         RqDNQggmQsSq1Sfq4HQS2axWjfEBTtZ4cKAj5VR0OyxuVxFDvrmVl2WRuuplfaAY1cVe
         WFGWDREe3RRFyrS3569xAs/zqtbtSykNCMGnCBpLIPXXYRCbgaDX84hiTiZ4XNGHm5VT
         sTIZeP2yYoK0ldJXHQUME3csLhZ0pDeZOQ8wI7Gr3ovuTwz86uyT09Dy56xyj0lVSa/+
         PLsqeoO4GzrGeW1LsSmt8HY/BzamyA5ZyLv90//BLLFeT6553u8yJpH0FQ02I0UiMb/Y
         eD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Er5dBwlInT6MWrK0ZEK7+b/MKqa/cnSWtsupyCyxpas=;
        b=nxmrw34gfErkSm7jYE5lLq+5PKiW7NFwsn2bZOhGtqt7g7iu4W+96DRGepswLKghRw
         ZU2cmEIwqhJndC7iQrsL7WwD31wnr0HZn0aW8NZI1yTWzzmfOQUFrGHK0pMLypNCMAWU
         dSAoftBlD1kbXP7Qisa38KedPfP+T4MARhQbDlK06Z6QHwOcw6EgTGKxdyrfDEPsK5uD
         DgzjlPOqDBJJHdDU1ak5WryMviZlo+6uGyE+IzmedF/qo7rG6qxoZcxVZEraIJ3O1ovl
         6jdLjyphJ9XQXYJN3cQM3ZGKAXdItrfTqwJyn0SiDZybX4Mb4x97jpXkpW9N1c6+Qn7f
         dcPQ==
X-Gm-Message-State: AOAM530ftPa9ehouWiLKhnmebvzsvtTCQsKTMo/uhhI5OD1E+e5Vt2Ca
        gf4+Ni5aj2DnGeSSQaUCUgsUdwk/GGU=
X-Google-Smtp-Source: ABdhPJygwLUWbaIn5xagSeDj0HnLdX6VH8/3vxCCz/UU3JYJrcAsNqRnjH17Gat5ujr2sJhRlqJZqw==
X-Received: by 2002:a17:90a:7486:: with SMTP id p6mr10426198pjk.62.1589661002985;
        Sat, 16 May 2020 13:30:02 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:41fd:9201:9a30:5f75? ([2605:e000:100e:8c61:41fd:9201:9a30:5f75])
        by smtp.gmail.com with ESMTPSA id m14sm4295837pgk.56.2020.05.16.13.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 13:30:02 -0700 (PDT)
Subject: Re: [PATCH] blktrace: Report pid with note messages
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20200513160223.7855-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ffb07506-ffeb-111d-1969-bea3103c4953@kernel.dk>
Date:   Sat, 16 May 2020 14:30:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513160223.7855-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/20 10:02 AM, Jan Kara wrote:
> Currently informational messages within block trace do not have PID
> information of the process reporting the message included. With BFQ it
> is sometimes useful to have the information and there's no good reason
> to omit the information from the trace. So just fill in pid information
> when generating note message.

Applied, thanks.

-- 
Jens Axboe

