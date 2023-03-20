Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CEEC7619A
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjCTRXd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjCTRXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 13:23:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375818B12
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 10:19:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so13206737pjb.0
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 10:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/KpGKbY1AS43hBoRJjgU45ILt2wTbk9IkiWqkMjNdw=;
        b=R8/EtEycoPEVTygHRmKYpCrS6UfKsEB487UOVbzbPMZpt34+fLaMAODeJapBZEFRW0
         jZqwxbK3IfAs4o5eZxSPi37Svtluq9NW/A6E+52rSDTqTbFPbbRI0kyWCIvy7EpU7m4c
         1cdD1ZWi5KirmfgjvHXxkMYca+KPzflWFNh/IswQWNcODjcMSZCoXgakR5vsB+sDfJSD
         ulSs3R80Ja61DA4rtEsz6EF9/GFZoZm2ueieHVkWrOeU25VV/f7XvWmJW4hKSzaYsdt6
         MvBqvavIQhb7ENwwXB4X7PfebEWPpG9IErRPXsw2G4JBiaILt2LVtXd3fkqiKWpUeVuo
         Jkjw==
X-Gm-Message-State: AO0yUKW/XAG/VcpTdzlJVbOP2hz99+FKlBl3qmzdSCfTDwzOSCKL7ACR
        BkUv89H0zVNQHk5k5NXAop8=
X-Google-Smtp-Source: AK7set+q0tJgjkfG+G85E4Jf6Z5eI4Vy1tbmy+BSsCri1Oy4YG2Ky604HlqrzWKYc2PVVlObHqcj3w==
X-Received: by 2002:a17:902:d2d2:b0:1a1:db10:7ba3 with SMTP id n18-20020a170902d2d200b001a1db107ba3mr2127266plc.2.1679332677868;
        Mon, 20 Mar 2023 10:17:57 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ad26:bef0:6406:d659? ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903024100b0019f3cc3fc99sm7036845plh.16.2023.03.20.10.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:17:57 -0700 (PDT)
Message-ID: <3a422e18-bab8-5e36-3b72-ccf28fa84545@acm.org>
Date:   Mon, 20 Mar 2023 10:17:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] block: Support splitting REQ_OP_ZONE_APPEND bios
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
References: <20230317195036.1743712-1-bvanassche@acm.org>
 <9987139a-f423-3d2e-5abd-877b3d147134@opensource.wdc.com>
 <cc9e00f6-9106-e701-4e50-f87c5796b0e7@acm.org>
 <e470167d-f0c0-f6de-41b3-e4b05248ab70@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e470167d-f0c0-f6de-41b3-e4b05248ab70@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/23 19:21, Damien Le Moal wrote:
> On 3/18/23 09:09, Bart Van Assche wrote:
>> It is not clear to me how this would break zonefs? Is my understanding
>> correct that the size of bios built by zonefs is such that bio_split()
>> won't split these?
> 
> It does, but your patch removes the guarantee that the split actually never
> happens, and thus that we cannot see silent data corruptions due to append
> commands being fragmented and the fragments being reordered. I do not like that.

That's fair. Let's drop this patch.

Thanks,

Bart.
