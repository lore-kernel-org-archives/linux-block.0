Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6EC433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJTNYT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiJTNYC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:24:02 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CFB18E286
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:23:50 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id bk15so34388699wrb.13
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ppFaMCa0DVNH2GYphuMxTip88ysu3Z+mblAfTEbbBlRtnHFOq/01iiiG0rZI3vRGB1
         xf48KS3NVYQxv77pwFlUcPxSliKW0VCGZJmeACvCi5O9jGMgoZfYYjCRzA9rWgwCZW6j
         6QL8LmMzQap+j60DpfE2EF8As3vGcXu2eVWk2zLNc4+8z0Lpz2AnGi8+Nc6ZKizSO/qp
         7b7G6Q10zBqcu00hTMOJ+WqlG7OOSo1owFm1vHqxo5XcTqxKbh2GPiagt/TmOc2vOIi0
         PPltFVFykHXDc3l1SqsbbNf3ePjL6Z6Q48E+rqRoyOhS3fHkNQClboRSrLqxac0TYT08
         L+ag==
X-Gm-Message-State: ACrzQf24ELWvCspf+6Gv+vzZv0mxe+CTGFDLa5dWJRv8Td38Ilu0TwKM
        YJlxxx4SuSHa/SvDuoDhRRGHMIa5Amk=
X-Google-Smtp-Source: AMsMyM5FdqFqk2BFYdqRNYgpAYJFxNQAyDuUFMezEhoRv0VIpRtNWWc4DDjTtq5WsyTltEjP5zkVRw==
X-Received: by 2002:a5d:6c62:0:b0:230:5aa7:6771 with SMTP id r2-20020a5d6c62000000b002305aa76771mr8333890wrz.158.1666272217931;
        Thu, 20 Oct 2022 06:23:37 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0022abcc1e3cesm16358140wrw.116.2022.10.20.06.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:23:37 -0700 (PDT)
Message-ID: <dcc13b0c-ecf7-d7a2-c7ab-43334ff4da6b@grimberg.me>
Date:   Thu, 20 Oct 2022 16:23:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
