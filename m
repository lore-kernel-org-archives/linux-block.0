Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56EEB64DC
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 01:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGGBub (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGGBua (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 21:50:30 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC9B1FC1
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 18:50:29 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-39eab4bcee8so1194157b6e.0
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 18:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688694629; x=1691286629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXGBOv42Jj7e1vmh4ItN49buwMFaHnA/gnyUkzyb2ws=;
        b=FcG7S2hCd+x/32m3NMDmpQqg+KkhMT1dDugApnoQSEvW7GM/DjeCUoDFspCrVudr7/
         aVv1C2Y/N+twoTS8XCi76a2i8rbOL4vutrE/BHbkj0vTMfnAonKa/dzwz/fUvlvCTAHn
         eg/PLtYGzqWnjUzKF1116LYkKCBbCw1AsIvSLdeX2RvrggzLYE7jNWknhRRtd/MBaSsZ
         M6ppdYz42SsBVB6MNe3M6hchrGLC8O+TVzI2plqAyUCGGfo/vZ4MeFiXPtUhacUPk+6U
         GNQ/AoH/a9Uc9e1+099UX8eIlhvGvZ+3P2cVnIejOMBheZ9wPlDRp5CKZcrClmybel4u
         qOCA==
X-Gm-Message-State: ABy/qLbxr2YkZjD9dPC+Cm7FQt4wFZRV+jAVwbDOw0EdLG+uiT1ECQxK
        J099EnJUxaxlgohR6rhHh5I=
X-Google-Smtp-Source: APBJJlEM2h29xhjscsjJKHRTem0F1f89zQjamRN5fVAPbVlUyl7U3HJSUbwPy/AjNFZDqFGF4YBJGw==
X-Received: by 2002:a05:6808:158:b0:3a1:bfda:c6d2 with SMTP id h24-20020a056808015800b003a1bfdac6d2mr3347591oie.11.1688694628634;
        Thu, 06 Jul 2023 18:50:28 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78691000000b0066a4e561beesm1889027pfo.173.2023.07.06.18.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 18:50:27 -0700 (PDT)
Message-ID: <06034722-621b-e06c-53e6-d2151cc07a64@acm.org>
Date:   Thu, 6 Jul 2023 18:50:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Do not merge if merging is disabled
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20230706201433.3987617-1-bvanassche@acm.org>
 <ZKdebT5VRdr0qxxv@ovpn-8-34.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZKdebT5VRdr0qxxv@ovpn-8-34.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/6/23 17:38, Ming Lei wrote:
> Given blk_mq_sched_try_insert_merge is only called from bfq and
> deadline, it may not matter to apply this optimization.

Without this patch, the documentation of the "nomerges" sysfs
attribute is incorrect. I need this patch because I want the
ability to disable merging even if an I/O scheduler has been
selected. As mentioned in the patch description, I discovered
this while I was writing a shell script that submits various
I/O workloads to a block device.

Bart.

