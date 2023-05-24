Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6552C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjEXR4P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXR4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 13:56:15 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC6A4
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 10:56:12 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-64d1e96c082so930238b3a.1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 10:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684950972; x=1687542972;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5aZUr3FD2WPGXuV9sMQ63FcJuLNSq7ptuKy5ZXEeBk=;
        b=QxAwV3tLzVu0gX3BZjESotNF6GHNbvGZEaXZSxPtAWmKMhXqhfwK6H1Qvj+WCvkLZY
         h4r9PcQS4udifff2GRsXC1Vw48xXKMFMS/l2b8EQ7r8poiaX7Kgq5dbQUIlajW7zzh0R
         k7GZx511dUoVBIs1OEGZ4bxByg4+s9HL6Dg+rLy+u7XqdJP8S5tYTf1wNJ58DmatFOpM
         Thkww5yqflNPKdeRY8cppfZhLr//dx/at9llvekvD1jsaaYxIoRMOH+pg7km4lYgYysD
         MpydLkTcYZ/h6Z5g3SNRjUWbaMWxs7PMmoV2YcaVqDeGROYGYqh293Y/jPibgyHBKhyl
         WdCg==
X-Gm-Message-State: AC+VfDxesoQjLeozPx/gcjYQcLgbfP8uCbpddq/ViNTilqz8WG+pWike
        prvNubylrK1t7CnT6VwPLbs=
X-Google-Smtp-Source: ACHHUZ6qSNyeyGDCwEi42e5aJjmeMwTM6jBXQn4re+b561lD8InOIEXgYk1lYrFVYCIuUhjw75ZNaw==
X-Received: by 2002:a05:6a00:a1a:b0:62a:4503:53ba with SMTP id p26-20020a056a000a1a00b0062a450353bamr4956838pfh.26.1684950972005;
        Wed, 24 May 2023 10:56:12 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79104000000b00571cdbd0771sm7741614pfh.102.2023.05.24.10.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 10:56:11 -0700 (PDT)
Message-ID: <a40b10d9-4e30-438f-2509-28bb0df4a161@acm.org>
Date:   Wed, 24 May 2023 10:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
 <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
 <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/23 17:31, Ming Lei wrote:
> On Tue, May 23, 2023 at 10:19:34AM -0700, Bart Van Assche wrote:
>> The mq-deadline scheduler restricts the queue depth to one per zone for zoned
>> storage so at any time there is at most one write command (REQ_OP_WRITE) in
>> flight per zone.
> 
> But if the write queue depth is 1 per zone, the requeued request won't
> be re-ordered at all given no other write request can be issued from
> scheduler in this zone before this requeued request is completed.
> 
> So why bother to requeue the BLK_STS_RESOURCE request via scheduler?

Hi Ming,

It seems like my previous email was not clear enough. The mq-deadline 
scheduler restricts the queue depth per zone for commands passed to the 
SCSI core. It does not restrict how many requests a filesystem can 
submit per zone to the block layer. Without this patch there is a risk 
of reordering if a request is requeued, e.g. by the SCSI core, and other 
requests are pending for the same zone.

Thanks,

Bart.

