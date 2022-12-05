Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25EBC4321E
	for <linux-block@archiver.kernel.org>; Mon,  5 Dec 2022 18:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiLESZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiLESZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Dec 2022 13:25:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B2B20BC1
        for <linux-block@vger.kernel.org>; Mon,  5 Dec 2022 10:25:06 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h33so11195785pgm.9
        for <linux-block@vger.kernel.org>; Mon, 05 Dec 2022 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=;
        b=8GuqePATHeBdjIjB00TbgRxhjgSPMawtU2wrtMW9YV2SFZq8p01ldTEAEDJdXmVdMQ
         aKPQa9ow3SZfxPLVddZSdd1Vmiivd8Xsns2MQXSSv+HZEwMB1AkPzU6/prRYqgG7kBx1
         pFwb6vkT/NsseKhCFBT2+xNiqVxZUMuF074XfMTL9Gx4DluIfSQ7QPpppgw373tGuZ5f
         xVs1yKe34IQP9m0MTefim8eR8AQhvmWGrY892kFb9Pe9xk1DbtOZd1fthb/96tnSraR5
         hLHHIQR60waW9xkALD7Ke5rkzmfw0e/dorvR7w9+noJkFwmrrhy7A1sDDF8SwAYzoYsH
         S2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImidpIQm24xC230ns//vzB+kQ7xYkel7WPj+tXR6tek=;
        b=JMbtB2yTFOe6WywgVNOIhrl1jWPLK2nxMJR6ceSUgiIKpl8hyi+BSV2Xv9jJVUVidN
         o/BikkGYMMfeILkG1plC6PvzpdnBNJ15ri24PIL1/u9UkIc14OUj9FjjkzASrIIHQnDW
         FisKeHH93opP/W+5kZe9VPv4oJsCteTaavT0snNUADS1tKInvLSiLrXH21a3DFX+ENSS
         SEfVj45ZYoPRhvEdg0IWm7WEfgIkpnXlweFUJz02rHJumWeyMiN2uoi4tIHjECyxyuap
         um3EM8bVvArAWb/2FBl3Tql6+J4Am35LAHM8RDm0CMecjwN4poYKbqumCtaBbE5ElO32
         x8FA==
X-Gm-Message-State: ANoB5pkJtvxiBPTxzsFgQgZZOPZvKAf8/w9VE4b54mzrUCj43tlQcIca
        SIygI0PVGMTxS06L6iT0aiaD7g==
X-Google-Smtp-Source: AA0mqf6LXB3TBL6QfztXAdNGDz+SFYGDjGPt38SvDGSzimZxm0Mc+GjiJQds8/JFTJ/UbjqS/ZkzWQ==
X-Received: by 2002:a63:ce43:0:b0:476:fdde:9ac8 with SMTP id r3-20020a63ce43000000b00476fdde9ac8mr57775329pgi.164.1670264704207;
        Mon, 05 Dec 2022 10:25:04 -0800 (PST)
Received: from ?IPV6:2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a? ([2600:380:4a37:5fe7:dac6:a7fe:6a6b:c11a])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b00189529ed580sm10917190plb.60.2022.12.05.10.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 10:25:03 -0800 (PST)
Message-ID: <759f50d0-75c4-7970-b145-469e87f6acc5@kernel.dk>
Date:   Mon, 5 Dec 2022 11:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Content-Language: en-US
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/22 9:20 AM, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for VirtIO block devices.
> 
> This commit introduces a new ioctl command, VBLK_LIFETIME.
> 
> VBLK_LIFETIME ioctl asks for the block device to provide lifetime
> information by sending a VIRTIO_BLK_T_GET_LIFETIME command to the device.

s/VBLK_LIFETIME/VBLK_GET_LIFETIME

for the above.

-- 
Jens Axboe


