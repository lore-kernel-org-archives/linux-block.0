Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E5C433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA30207D8
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GzOTY6ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETNiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETNiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 09:38:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA95C061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 06:38:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so1445739pgn.5
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 06:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=taXT/B2bERSyBm9PdMFZldW+b+FCBblymyqhWyrJ6uA=;
        b=GzOTY6urapVr/j1Ezird4EY0X7sGDwLV2/CAsDFLJU9A7h/OFxUKrwWzmpaqzXndFV
         nfIUxL/9t5TfuYXwnMbQMhNYQIuZFgbeoPrDMQtFJzmR9xCDOXMfOn4tPd3SOBQ628IS
         fSKz/eqVDZT1hyopTnSBWsTLICpreKtG5ajJ7lgdwxAk5UKUJFcgPbjnHlrY+owT3Bk8
         ffChqXBZNrT+z/Sm6B9/xyR02M/PorYd+lZMGnDBlcGY4/jX9q8X08gOQslRuZzrK25/
         dFrTebJT+37jIPh9wKzYIl55V93vGpOPlE6TLxBi2xLOoCX3G/BXzBk5MltOxnXpbZ4X
         ZsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=taXT/B2bERSyBm9PdMFZldW+b+FCBblymyqhWyrJ6uA=;
        b=VffaBLsr8FiTdoS7DVVG61LODNUIEqSSsSA/IlOrL0hjCb1iJF2B2BUkQSgRV8aOjF
         aRjZE2xbEU4u683NkfofK33hryjPbfO0X0QbVIai/+drl0P1p+C9jOgNI4PHIliFZ7JE
         tMGYVM3qX+qwHgF1BbZmPjTsG9EQqOjNnam3BEwWrKUZOlgvczZD/pYwzDGFISNWeFVj
         ecC6cYTdFI6LlGX/C67TZwLX100qpSwjaLWdIc6dv/8vMIIZL+lfXXx7/g/+reSRBcrQ
         6aqjABIRn4t7hvHGtOOArUQ3BThdR6KEyUYBoFTVrIooWzkDOe3HagnOx233gGfBHA9Y
         w8qQ==
X-Gm-Message-State: AOAM532w6p/qRxxTrh9slV9Yg3HZ/33EU5nIleFHhcgp8++AW/aPDP/B
        qW18L8guH0wvhV+XI/gnXnZRXIKs3Dk=
X-Google-Smtp-Source: ABdhPJz7G9iiLJ/qVVAeu8Z9GPvuY2UT8Omr8f7hydhjjitvul8d48bG4yTfe2j4msf2jMhMogRT9g==
X-Received: by 2002:a63:5114:: with SMTP id f20mr4125009pgb.148.1589981889747;
        Wed, 20 May 2020 06:38:09 -0700 (PDT)
Received: from [192.168.86.156] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id y13sm2319707pfq.107.2020.05.20.06.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 06:38:08 -0700 (PDT)
Subject: Re: [PATCH 0/3] Fix blkparse and iowatcher for kernels >= 4.14
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20200506133933.4773-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed967826-033a-d1d5-6bc4-33e03dd7bea6@kernel.dk>
Date:   Wed, 20 May 2020 07:38:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506133933.4773-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/20 7:39 AM, Jan Kara wrote:
> I was investigating a performance issue with BFQ IO scheduler and I was
> pondering why I'm not seeing informational messages from BFQ. After quite
> some debugging I have found out that commit 35fe6d763229 "block: use
> standard blktrace API to output cgroup info for debug notes" broke standard
> blktrace API - namely the informational messages logged by bfq_log_bfqq()
> are no longer displayed by blkparse(8) tool. This is because these messages
> have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> blkparse(1) and iowatcher(1). This series fixes both tools to be able to
> cope with events with __BLK_TA_CGROUP flag set.

Applied, thanks.

-- 
Jens Axboe

