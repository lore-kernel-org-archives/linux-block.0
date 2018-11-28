Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0468DC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18852081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 02:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18852081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeK1M7v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:59:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42255 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1M7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:59:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so16695087otk.9
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 17:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=j9fslvl3+H5T/UnPXDq/sPpKrWtKgVHFZY83OFQ5AQgqZxae3a9aNMcnewQ2Lps7FE
         I84jls6dDPnbm/Cc8a4xQceoUKPd3Kgj15N4U8boRE3puS/EOKBYEyT4aTf6PvdIyU8g
         v9dI9EuIGZRJaScsJD5tf8X2uNwNWYzeXeJ+/udBTJGJdxrE9DJwPjyNJueKNyd4BNp9
         8hpk1s3EndA5I0hhqYStMn/rAarQc83MnhrGY5kAUxLpNqnjXwc7JyNcDzy7CH1kG3ei
         2WNK2qPw0ldfB0Z5QmpUXNTAjkmBt2eb/Fs9nubOnNurh6vGhwNWuGoL0fGINenVdwia
         Rm2g==
X-Gm-Message-State: AA+aEWYQT7IyYtlylmA2WA51x7mnsf9SvBmHYS2NQApFH+9AVav/tku8
        fffu5gsJQ1TjhSZfXQdoqPl9Rdl2
X-Google-Smtp-Source: AFSGD/WH+U87ReMiVeJnDFX3de0jTMdPHHQCADmPywRWZU+b8/XprBlJHRsuIyA6uFbLY37M3spl9w==
X-Received: by 2002:a9d:724d:: with SMTP id a13mr20802153otk.193.1543370399221;
        Tue, 27 Nov 2018 17:59:59 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id t8sm5492957otp.69.2018.11.27.17.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 17:59:58 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: create slaves/holder entries for multipath
 devices
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20181116130805.16225-1-hch@lst.de>
 <20181116130805.16225-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2a2e2b22-5575-8bc4-7f8f-802baf41f059@grimberg.me>
Date:   Tue, 27 Nov 2018 17:59:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116130805.16225-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
