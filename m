Return-Path: <SRS0=f2tN=46=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98731C10DCE
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 00:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBAF206EB
	for <linux-block@archiver.kernel.org>; Fri, 13 Mar 2020 00:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dBdEuzW4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgCMAzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:55:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36576 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMAzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 20:55:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so882420plo.3
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 17:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KukQCqFuQ52iEK7w5avP5xTjmDq5q5jmKUrg/HJnFFA=;
        b=dBdEuzW4dXmH1//0aac/JzhJiPT/Jv6GgevIgxkCudRIIbGZ+PrZ0mGhYKid2dLDs1
         5vD8jsk43pBEcmLDcYXADKomszFsjabrjmqo0Io6kP9tuP28QeU8d/tO5Y2iMDpCB5yG
         bIOghGnbhbFbfmq+yYy8jSa35I3EEsQJnLZ4BmOq6ex+LQY5GdbVIZjN56poUwFKuNjK
         q9mFBEdgKW+lFyv9eqLAGTkQHlItXCwKO8FgRJ8itTFFhat50M2SRQ05u3buz10uU0q5
         3RtgXV7V7MtA6oiJH8Vp9IibKjnCPM8uamzKoWQi7kQi0oc8Ha4QjNP66KveXpEkFO1h
         XAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KukQCqFuQ52iEK7w5avP5xTjmDq5q5jmKUrg/HJnFFA=;
        b=jiTIU4HmFWwiB1wDY0OkBcIKPlJZQNTxk7xoK6yDycNtTCZzLl5BcD0YjoUGXuqsc/
         X8gIm4/k+vAUE6Qv7rXi1FY3b0XDw2Y1FryBCUm6M0BbGwD8eAJcJMqa3a+eQap/9MG7
         HMTlCQCekd2Lcx0f4mj3roZRrEmc3Y1EbP7JlRIX3q0T+OWt+4/xerCV0fmeE2weLEC2
         1S45NjyrX9WDQsN/kItc1noapx9IHq1hXIVDGtAMO2+UttEacxv9iJXUxKDoupJ3E/cO
         y0WD/IWAYa7cffmqnBQiUAdgCHq14gCnLGQ0RP0+J7Qs54Xn5mK6uA3fO/k/lbfNtQs1
         20Xw==
X-Gm-Message-State: ANhLgQ0H60Vk+0uoOAHcGlvBFyN7nmUKMGzhErVPxnZFhbn81/UkjyPO
        +qOFk5/0bsV5phS6ObSsARgjoQyNw+CY0A==
X-Google-Smtp-Source: ADFU+vtriuTwZMI7JXVCGxL/TV/G9dsfdzB1UhBFu3cGl6VpfY3w8Pf1oXpu+vw4qJPCoAfm4Pt0Jg==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr7256074pji.23.1584060900474;
        Thu, 12 Mar 2020 17:55:00 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p7sm10138453pjp.1.2020.03.12.17.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 17:54:59 -0700 (PDT)
Subject: Re: [PATCH for-5.7/drivers v2 1/1] null_blk: describe the usage of
 fault injection param
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200312220140.12233-1-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3937ffef-5b24-6b11-fac7-172a7e654374@kernel.dk>
Date:   Thu, 12 Mar 2020 18:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312220140.12233-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/20 4:01 PM, Dongli Zhang wrote:
> As null_blk is a very good start point to test block layer, this patch
> adds description and comments to 'timeout', 'requeue' and 'init_hctx' to
> explain how to use fault injection with null_blk.
> 
> The nvme has similar with nvme_core.fail_request in the form of comment.

Applied, thanks.

-- 
Jens Axboe

