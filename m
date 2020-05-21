Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AF0C433DF
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B5920748
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IubiXOXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgEUOVH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEUOVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 10:21:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E5C061A0E
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 07:21:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so3134012pjb.4
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqWT/aJMqjQS/LwwIzDw5vVtbTuX7+bbQKCciE383sc=;
        b=IubiXOXxF2nL7YfH5AF2oZumoIioFJkh2cyMRIZp0jsTtdJTU6sm5tTkN3HB9KSqpr
         BtfBrkxRHj9emgX0ItTzLqrFslEgmDV5pO1oagyiFOJUdNGqmgdWCpF92vGx8KmQIdr8
         FTDpUs3OaOO5TVWe6ABfw+7ANd0xGdrP5T9kYTlX81C50wZB5HxY+ZNlwgC4QnTvB4YM
         i1IqzwpR0hiihyC8n83UH2C42t418sA/KbyBT2urJw8cwaWySpd+n+xOxbR6Lzi9J9IL
         K8VxDTfFDp42DN/+XuQKeLell9ggOV648PoVukEpAqYDM5Peiu2huxXaw3PifSu6hRYg
         TaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqWT/aJMqjQS/LwwIzDw5vVtbTuX7+bbQKCciE383sc=;
        b=iqyAAkinSX5UNUwdkK8Mp7SDiQgGMfnn6QT5c5rCSxQGb5W+gc2vFvu1wyzR5lGAEH
         Cej6pIERsXwmA8EbEN7Du4Oi5x2WTSrLfM91H3d9/sAXgqCeyxtQGtN0c7D1X50c4mIc
         ROMHOOv6iyRSBu9ThdPk4xQJFszTW7kG5SRz6aQ1BhxawzmCQWMMUrAx0jsDk/CshuBL
         21Zys9ptOQgJAlF6yja8nDJTo6XqAlOyEQ3CBormB+06DiuU1kf1WQXoa4kXv1w2zG5X
         7MjDSbJFgDRqIvsMujgLHgauRPq5oQFwULPkETkFGdim7uNDXAP3cdQX/zduQcgHTxID
         HCdg==
X-Gm-Message-State: AOAM532I860qldVV3SpWIZye7QpOOmvzagW2V+SkleG3BRLmhoCYrqWp
        fSmbY4EFM68GmZ33Mxy/SV9lMA==
X-Google-Smtp-Source: ABdhPJwJWiF05G52IFW9R5Nmw5veE7Mlw/Rui0UPeykYh3HiKu3fnjOBS9uNDK1RBAVTK+i14VNZqg==
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr10219648plt.9.1590070864321;
        Thu, 21 May 2020 07:21:04 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:c00a:8fd2:4246:efbe? ([2605:e000:100e:8c61:c00a:8fd2:4246:efbe])
        by smtp.gmail.com with ESMTPSA id k65sm4703876pfd.156.2020.05.21.07.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:21:03 -0700 (PDT)
Subject: Re: [PATCH v5 00/11] Add a new LOOP_CONFIGURE ioctl
To:     Martijn Coenen <maco@android.com>, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200513133845.244903-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0b7bf9-07b1-9025-f9d6-7ace03c89a1f@kernel.dk>
Date:   Thu, 21 May 2020 08:21:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513133845.244903-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/20 7:38 AM, Martijn Coenen wrote:
> This series introduces a new ioctl that makes it possible to atomically
> configure a loop device. Previously, if you wanted to set parameters
> such as the offset on a loop device, this required calling LOOP_SET_FD
> to set the backing file, and then LOOP_SET_STATUS to set the offset.
> However, in between these two calls, the loop device is available and
> would accept requests, which is generally not desirable. Similar issues
> exist around setting the block size (LOOP_SET_BLOCK_SIZE) and requesting
> direct I/O mode (LOOP_SET_DIRECT_IO).
> 
> There are also performance benefits with combining these ioctls into
> one, which are described in more detail in the last change in the
> series.

Thanks, applied for 5.8.

-- 
Jens Axboe

