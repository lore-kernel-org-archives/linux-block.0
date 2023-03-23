Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07267C74A5B
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCWQ17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWQ16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 12:27:58 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C961702
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:27:55 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id n20so9002738pfa.3
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 09:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+1ibTVsDSFKipf8XY5Mo50yKdNF+Xl7RBmXD0Gu8g8=;
        b=BzoHUx+Lgo4Z3PPjAIV6YgTfNT67cHwyG/oKI2pBmng0dACKaMM0Z4ooXatIKZJ1hk
         QaJxKutkD+MXtif4MTZW1d1fE9tG4btkdrGNUPDoruFpNv1orx91UpET4x3+VuqYq44X
         4NsMqCa3/W8JDS2TQ9uwQ/tZ/tzLTEBw7I3M+eAPafedsnFnCpQ+9W2fBfy1pc5T4JFW
         tkKsxSXl/c8qgdMIqb4uyGSI5pEbHDWwtLOzcBP33F6p3pV+mAErnbKoQkgRMcCeq1xf
         UmBnKSldygQZ4iEmdPlcXhtNqYCfzot5gI7nm8pDwelyc09vsEjVzLuOEFdBWsmb0pgP
         Kfmw==
X-Gm-Message-State: AO0yUKUzHZ7vD0NI9tEyh7j3phJE1nS/FBdYbdjlbXrhas3aAFE6yy3n
        +9Ip64pOwAhrr4pMKv9mjFQ=
X-Google-Smtp-Source: AK7set/MuGxB3zSWpqnkDcPFgEdRJKcp+xuy84OOhis6mylZoEggcffZDjB/S0wef0SjcnuhTYDUTw==
X-Received: by 2002:aa7:95bd:0:b0:62a:1267:2036 with SMTP id a29-20020aa795bd000000b0062a12672036mr4710408pfk.34.1679588875078;
        Thu, 23 Mar 2023 09:27:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ad4e:d902:f46f:5b50? ([2620:15c:211:201:ad4e:d902:f46f:5b50])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b00593e4e6516csm10654914pfh.124.2023.03.23.09.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:27:54 -0700 (PDT)
Message-ID: <122cdca2-b0ae-ce74-664d-e268fe0699a8@acm.org>
Date:   Thu, 23 Mar 2023 09:27:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
 <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
 <50dfa89c-19fa-b655-f6b8-b8853b066c75@acm.org>
 <20230321055537.GA18035@lst.de>
 <100dfc73-d8f3-f08f-e091-3c08707e95f5@acm.org>
 <20230323082604.GC21977@lst.de>
 <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <acd13f8c-6cbe-a14d-e3b4-645d62811cec@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/23 03:28, Damien Le Moal wrote:
> For the zone append emulation, the write locking is done by sd.c and the upper
> layer does not restrict to one append per zone. So we actually could envision a
> UFS version of the sd write locking calls that is optimized for the device
> capabilities and we can keep a common upper layer (which is preferable in my
> opinion).

I see a blk_req_zone_write_trylock() call in 
sd_zbc_prepare_zone_append() and a blk_req_zone_write_unlock() call in 
sd_zbc_complete() for REQ_OP_ZONE_APPEND operations. Does this mean that 
the sd_zbc.c code restricts the queue depth to one per zone for 
REQ_OP_ZONE_APPEND operations?

Thanks,

Bart.
