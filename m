Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91946C38142
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 17:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjASRsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjASRsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 12:48:37 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE498F7F1
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 09:48:17 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso1340844pju.0
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 09:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=np+u5IGdpKuKpTU8M8i727iF++yXsOYD0B4G91djy+Q=;
        b=zIDnw5Caaa0bww8LsIylwIXnghBan12RML3QgLj/LOMKpOTirGc9qQK0XZr/xl+t1e
         nHc6cYHXbynQRb7caoUXc9y05zCwF40s6U23DJhEr2J0ljD+buZ+2eZjNDsu+UNwEfeI
         NumBtecX+C914pXqph45VwQlwkvbAEKOG6qFRWMOWkOWl2JmR38Y6PSMLJ/cIY6WRpF9
         7jGjfQOZRVCE7eMqC9KtOuHHghFM4cvltJoYdulmdAn8lMzpa7ATOWzmPD3AvdIlEPOq
         JzmXrqzgimUGlQZTYu3oyQmK1iLQA5drxVQHA0hbA3f5H8Opg5rVif4PTxbeR8H5bRtv
         xKzA==
X-Gm-Message-State: AFqh2krZ4rWccBRQC5MsfK+n12JpAroL6CY6CH6iDbSpDHQ5RCZpyUuZ
        IaZlFnc+1kidZ/jwoKPvN5o=
X-Google-Smtp-Source: AMrXdXt87CGjT4lH6382w/DFQulUL/0Jtx1jKG9tDl3abR9RDCeV3xEe4gVyFXFqRZfR71iyW1r8Tw==
X-Received: by 2002:a17:903:31c9:b0:193:2d53:3fc9 with SMTP id v9-20020a17090331c900b001932d533fc9mr11448513ple.6.1674150496496;
        Thu, 19 Jan 2023 09:48:16 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:ff60:f896:307d:56f7? ([2620:15c:211:201:ff60:f896:307d:56f7])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001811a197797sm10772594plg.194.2023.01.19.09.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:48:15 -0800 (PST)
Message-ID: <f530442e-4010-2829-8c73-fe5138b17531@acm.org>
Date:   Thu, 19 Jan 2023 09:48:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] block: Improve shared tag set performance
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20230103195337.158625-1-bvanassche@acm.org>
 <Y8hvNmyR3U1ge3H3@kbusch-mbp> <4be69fc0-af32-b552-6a36-f75eb798ca95@acm.org>
In-Reply-To: <4be69fc0-af32-b552-6a36-f75eb798ca95@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/23 14:46, Bart Van Assche wrote:
> On 1/18/23 14:14, Keith Busch wrote:
>> On Tue, Jan 03, 2023 at 11:53:37AM -0800, Bart Van Assche wrote:
>>> This algorithm hurts performance for UFS devices because UFS devices
>>> have multiple logical units. One of these logical units (WLUN) is used
>>> to submit control commands, e.g. START STOP UNIT. If any request is
>>> submitted to the WLUN, the queue depth is reduced from 31 to 15 or
>>> lower for data LUNs.
>>
>> Can you give the WLUN it's own tagset instead?
> 
> Hi Keith,
> 
> Does that mean creating an additional tagset for the WLUN and statically 
> allocating all tags from the WLUN tagset that are used by other LUNs? 
> That approach would have the following disadvantages:
> - The maximum queue depth for other LUNs would be reduced from 31 to 30.
>    This would have a small but noticeable negative performance impact.
> - The code removed by this patch negatively impacts performance of all
>    SCSI hosts with two or more data LUNs and also of all NVMe controllers
>    that export two or more namespaces if there are significant
>    differences in the number of I/O operations per second for different
>    LUNs/namespaces. This is why I think that this should be solved in the
>    block layer instead of modifying each block driver individually.

(replying to my own e-mail)

Hi Keith,

An additional concern about the approach of using multiple tag sets per 
SCSI host: this approach is not compatible with any code that iterates 
over tag sets. Examples of functions that iterate over tag sets are 
blk_mq_tagset_busy_iter(), scsi_host_busy(), 
scsi_host_complete_all_commands() and scsi_host_busy_iter(). 
scsi_host_busy() is used by e.g. scsi_host_queue_ready() and 
scsi_eh_wakeup(). So I think this approach would break the SCSI core in 
a subtle way.

Bart.

