Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156EC18E5A
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8966B21D56
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cBX9fKK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgCKM7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:59:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33433 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbgCKM7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 08:59:37 -0400
Received: by mail-io1-f65.google.com with SMTP id r15so1804424iog.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9l0335H7R/gtb+vxYfReRASjTU9/uz9886f0Ecj/gTU=;
        b=cBX9fKK9kCURF+tzK+q02uWe1wlkHdpQKBOKxTNGlv/iaPh3Fth1OCztTJOwGToc0n
         zYEBA1cwfskvgCni8Vrmrmddo8xXTbPC240dk5n7pIjTZszTfpMx1Uwg17w6g5OBPmVB
         /qDaqZKNETlMfoppxTw64IxVw14UntG6b0+mhzX2tGyMhdlyeSYxojBhu/9jARSCLyLI
         9cYak3H3lNcv8vzquw+GVUVEecWM6vmP3ZMSoqtbeDJTXz4YNMeYDa0ew4xwLMKVTmEb
         HW0qSDSeknuwPX37i0PvSYQKvWmi2gO98c2Ub2K1b0tDemLtXFQf2FIeb5W6rDdektqZ
         Zygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9l0335H7R/gtb+vxYfReRASjTU9/uz9886f0Ecj/gTU=;
        b=nIZvhc9+zz4V8KV+uGfG9VPSYBtyismV6k5MFDX975pH20uahI1bPF8+RgkzfNgFFp
         W4pF9ouDSmJkJypseZ/MZJ6TuyoSMo8413fUFqIA6WTJ0Z30dDlb242b4SxtdJ8QJ5Lh
         T0iUpNft3NU/ZKKecHhTTpOwAxcQPpW5afmeQipaGGwrgYGZVFmBB0IPQW3hZWL0pv3r
         ylKl9EadX39V6B19PdbKNKgfMIj5J+R3OL9fpfThjxHbkO/q89FAj42YwAbfk/9KD+dY
         zMmnxvSc+fJwXqFOB64nhB+HhdRZ/H9Pr24KJgNQoE533M5dcOsnegq1rgJYq4KRRMOC
         yPkQ==
X-Gm-Message-State: ANhLgQ0G9k4XeXVPOFvwVlNw81Gcou8Bph2Jdkz0NoHexuDeZdMdfQwO
        2eTXaJC7YeiL4WI5I3ymmnwHswJ9Jl6UcA==
X-Google-Smtp-Source: ADFU+vsl/lvX5mvSRhEyJTk5S80SJXyx1Jrs5RSf9T3HJPOEcp6tH3JPhhc4GlLr5Nf+N5EGQWAyeA==
X-Received: by 2002:a6b:ea0b:: with SMTP id m11mr2796586ioc.182.1583931576447;
        Wed, 11 Mar 2020 05:59:36 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm2138153ioc.15.2020.03.11.05.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:59:36 -0700 (PDT)
Subject: Re: [PATCH] block: Fix use-after-free issue accessing struct io_cq
To:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Pradeep P V K <ppvk@codeaurora.org>
References: <1583923070-22245-1-git-send-email-stummala@codeaurora.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da11e249-904f-6cec-03b6-ce4b8d7eb1e1@kernel.dk>
Date:   Wed, 11 Mar 2020 06:59:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583923070-22245-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/20 4:37 AM, Sahitya Tummala wrote:
> There is a potential race between ioc_release_fn() and
> ioc_clear_queue() as shown below, due to which below kernel
> crash is observed. It also can result into use-after-free
> issue.
> 
> context#1:				context#2:
> ioc_release_fn()			__ioc_clear_queue() gets the same icq
> ->spin_lock(&ioc->lock);		->spin_lock(&ioc->lock);
> ->ioc_destroy_icq(icq);
>   ->list_del_init(&icq->q_node);
>   ->call_rcu(&icq->__rcu_head,
>   	icq_free_icq_rcu);
> ->spin_unlock(&ioc->lock);
> 					->ioc_destroy_icq(icq);
> 					  ->hlist_del_init(&icq->ioc_node);
> 					  This results into below crash as this memory
> 					  is now used by icq->__rcu_head in context#1.
> 					  There is a chance that icq could be free'd
> 					  as well.
> 
> 22150.386550:   <6> Unable to handle kernel write to read-only memory
> at virtual address ffffffaa8d31ca50

Fix looks good to me, applied.

-- 
Jens Axboe

