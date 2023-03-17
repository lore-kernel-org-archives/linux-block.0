Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15684C6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 23:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCQXpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 19:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQXpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 19:45:49 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3B5260
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 16:45:49 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so10838260pjv.5
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 16:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylQLkXEzOSvtjG+FRoUHJv6HwcwNidxHFVJqyHYsh9U=;
        b=CuT1CewIEsUylRzuj+QBd882C5ICy9bI9J1P3KCHzmEwrC0YGTlTo12oukraqqwT2M
         FasfTlBkikejkEDhytgSlYpUm3/yhItsyzZmofVToz1v0W7D64ZC9RZmJJvKv4A5DZE1
         LznMCLqu/3RwYfvd0sHJXt793VvhUEgPIWsns76F98w4XKOcMwQjvVh0znG3yOXQjdm+
         aqEXNxYxscgINbM1MOX5MQtUWycFl09l73u+zEE8xDA98rPgsJ3Uq20zj1UKBJvQ3L0R
         I3rgWSUxWknk7ga8/mXFV5fqsEcxEfnmUeyH4YAluVplpNAbK+drSdk9hKu+LN/Ho9Yd
         o8CQ==
X-Gm-Message-State: AO0yUKWcn6XpENOYsqXvrFfXRUKuhiy+UVfdIZdSWRbOT3XIpk0ruibo
        Eec9nWps2w5zHJTY+Ltm56s=
X-Google-Smtp-Source: AK7set+RxeHPVmalEv13vXUN02+kVwVB1FxwAgzsXLtQWshOATUYkvE/AILeouaUha7uzCl8ZT65PQ==
X-Received: by 2002:a17:90b:4a07:b0:234:1d1d:6ae6 with SMTP id kk7-20020a17090b4a0700b002341d1d6ae6mr10079461pjb.1.1679096748296;
        Fri, 17 Mar 2023 16:45:48 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090abf8200b00234899c65e7sm1935909pjs.28.2023.03.17.16.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 16:45:47 -0700 (PDT)
Message-ID: <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
Date:   Fri, 17 Mar 2023 16:45:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/23 16:38, Ming Lei wrote:
> On Fri, Mar 17, 2023 at 12:59:38PM -0700, Bart Van Assche wrote:
>> Instead of submitting the bio fragment with the highest LBA first,
>> submit the bio fragment with the lowest LBA first. If plugging is
>> active, append requests at the end of the list with plugged requests
>> instead of at the start. This approach prevents write errors when
>> submitting large bios to host-managed zoned block devices.
> 
> zoned pages are added via bio_add_zone_append_page(), which is supposed
> to not call into split code path, do you have such error log?

Hi Ming,

Thanks for having taken a look. This patch series is intended for 
REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.

Bart.

