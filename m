Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3FC77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjDSVMc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 17:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjDSVMb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 17:12:31 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D295FF7
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 14:12:30 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso93920pjr.3
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 14:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938750; x=1684530750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBfXEyxo+c7TL7efr888vEYya55EofHm2NhjNozNcRM=;
        b=HdRVjPZX/3ZDCI2KyzVIcIqWSxFdwwo4qadZCNkScH0cXBX6A7yUMNY0KrrwU5SyBw
         m40KvaCbAxg7G3DXPXkucy+3BhfX0zM8QggcBolzJ0V7rBo2+ivZX2Ab5OsyiyHqzuOi
         iFAdiyDs3Act3Unnn9kdR5XUzuZvWWn3ljtodqj1u4A4+mgR1xVyyRzmK/cttWMGknNm
         kSpEgzsyztanFYgtr8beosVsjpRQ7xuIsfSS7dpxTl1tnUI/36XZgiarX4QN1BshM3rQ
         AKOkJNuiSyZ0pkHA2onbTAf3wgsFufV8f+AMvl/VQgZTzafs1lg3jFIPBWGf1Ho2h0dm
         mC4w==
X-Gm-Message-State: AAQBX9cn01V8IKzr2BUE7mj2LZgMlkB/1mdnwVTX0yGtQNdotAo5ZDHo
        lWaNOzS2iXCH+Nr6oKQjIT6jjrq/iYU=
X-Google-Smtp-Source: AKy350a0N7ZoqNI9XYH7m7jH8uE0QZsF2UlWEFJNx1ymY+5s0ptpAayc1yb2IbCeHz6aw7+qdvQW0Q==
X-Received: by 2002:a05:6a21:3604:b0:ef:ba1a:e7b9 with SMTP id yg4-20020a056a21360400b000efba1ae7b9mr4336706pzb.28.1681938749886;
        Wed, 19 Apr 2023 14:12:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:216b:53b9:f55c:cf92? ([2620:15c:211:201:216b:53b9:f55c:cf92])
        by smtp.gmail.com with ESMTPSA id j23-20020aa783d7000000b00638c9a2ba5csm11375152pfn.62.2023.04.19.14.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 14:12:29 -0700 (PDT)
Message-ID: <80cf216a-dc41-0673-6d55-adb32ff42e46@acm.org>
Date:   Wed, 19 Apr 2023 14:12:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 03/11] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-4-bvanassche@acm.org> <20230419045000.GA25898@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230419045000.GA25898@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/23 21:50, Christoph Hellwig wrote:
> On Tue, Apr 18, 2023 at 03:39:54PM -0700, Bart Van Assche wrote:
>> +/**
>> + * blk_rq_is_seq_zoned_write() - Whether @rq is a zoned write for which the order matters.
> 
> Maybe:
> 
>   * blk_rq_is_seq_zoned_write() - check if @rq needs zoned write serialization

That looks better to me :-)

>> +bool blk_rq_is_seq_zoned_write(struct request *rq)
>> +{
>> +	switch (req_op(rq)) {
>> +	case REQ_OP_WRITE:
>> +	case REQ_OP_WRITE_ZEROES:
>> +		return blk_rq_zone_is_seq(rq);
>> +	case REQ_OP_ZONE_APPEND:
>> +	default:
> 
> The REQ_OP_ZONE_APPEND case here is superflous.

Agreed, but I'd like to keep it since last time I posted this patch I 
was asked whether I had perhaps overlooked the REQ_OP_ZONE_APPEND case. 
I added "case REQ_OP_ZONE_APPEND:" to prevent such questions. Are you OK 
with keeping "case REQ_OP_ZONE_APPEND:" or do you perhaps prefer that I 
remove it?

Bart.

