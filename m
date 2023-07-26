Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08706C00528
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 23:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGZXqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGZXqj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 19:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C93212A
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 16:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139F761CE1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 23:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8CAC433C8;
        Wed, 26 Jul 2023 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690415197;
        bh=PYwiCwXBBOvdYhQa7kEYaqNk2AIANaeAlInx5Uo5EMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AIK4I3LCoTXAIiZ6J8x5MtaPQfmwPWyXo3zHXSS2gen998XOjy6EdsF7JvUYhkHwc
         cyH2L5gAUL8larMUcfH37rgtZzdhS+YYfwDg8pnqrnWSp7tQ2RGVqEsS52z5nLfOFS
         xidCu/c9oFVLlCC5c5JdyUVV0bjfyYOpx0rURalPs8qB2h3Y+q4nT1g7b3I5/xfbb6
         fIraI1tpOJDZZoC2JwGfupv072K/nuty5MqJseW8+MI4VqQl6MQ+w1mq/ETBwCOTFN
         lWG5w10YmyRuG/VORr29NC/av9xHtPPVp5Cf9+zjp0yuLwt7xyZHXKJgr8jcktIc9O
         rKslu5YI1Ys3g==
Message-ID: <918d430b-184f-9bf4-c76f-e8a479d80ecd@kernel.org>
Date:   Thu, 27 Jul 2023 08:46:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-5-bvanassche@acm.org>
 <e9cfd243-4b2d-a2f5-2d34-b0012470117a@kernel.org>
 <15c27150-a4fb-9c93-377a-6a462f3565c1@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <15c27150-a4fb-9c93-377a-6a462f3565c1@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/23 00:02, Bart Van Assche wrote:
> On 7/26/23 01:47, Damien Le Moal wrote:
>> On 7/26/23 09:57, Bart Van Assche wrote:
>>> +/*
>>> + * Returns a negative value if @_a has a lower LBA than @_b, zero if
>>> + * both have the same LBA and a positive value otherwise.
>>> + */
>>> +static int scsi_cmp_lba(void *priv, const struct list_head *_a,
>>> +            const struct list_head *_b)
>>
>> The argument priv is unused.
> 
> I cannot remove the 'priv' argument. From include/linux/list_sort.h:
> 
> typedef int __attribute__((nonnull(2,3))) (*list_cmp_func_t)(void *,
>         const struct list_head *, const struct list_head *);
> 
> __attribute__((nonnull(2,3)))
> void list_sort(void *priv, struct list_head *head, list_cmp_func_t cmp);

Yes. I missed that this is a callbalck. Sorry for the noise.

> 
>>>   /**
>>>    * scsi_unjam_host - Attempt to fix a host which has a cmd that failed.
>>>    * @shost:    Host to unjam.
>>> @@ -2258,6 +2289,12 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
>>>         SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(shost, &eh_work_q));
>>>   +    /*
>>> +     * Sort pending SCSI commands in LBA order. This is important if zone
>>> +     * write locking is disabled for a zoned SCSI device.
>>> +     */
>>> +    list_sort(NULL, &eh_work_q, scsi_cmp_lba);
>>
>> Should we do this only for zoned devices ?
> 
> I'm not sure this is possible. Error handling happens per SCSI host. Some of
> the logical units associated with a host may be zoned while others may
> represent conventional storage or have no storage associated with them (WLUN).
> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

