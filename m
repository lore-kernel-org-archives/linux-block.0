Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD1C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895CB2089E
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHFPLG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:11:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34956 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFPLF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 11:11:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so41686452pfn.2
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 08:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=27Zs/HIHL70nXnyOASMoN8N0p3nRwLJCN/GapiRTCS4=;
        b=bf/M3q2vz9eKeeHaXBI2sBKo5SnxVa5tRGlavgtGa6mBVYT05jEhrw/L/VaAOWpAs/
         L5W52gPqUNwMSIe/TCLj+F8/WlMvoIWTEBj1nFZyzNlZJMHhwOcxTqTavyDOyOhhdj8K
         fm8lXQsHtdi0rjTIIdQcdtkMoFg/G82pjPRu4GDrFLGoK49sgbyYN7v0V+mlEFNUaow9
         r2I2Rf/Z/ylmMJudhyfnQr3hbMgAfKCcYAULyhei4hrBc2UbmLfcdD8taVKdIKIygQmf
         pxOyvqdiemftLQD2aZ+ej3A0UblW4CZfWl2jMshsPWiBu3zjEflMqOzjUJTokRNfiw4t
         4TEg==
X-Gm-Message-State: APjAAAVT1ziAuqrrV9/My9jasHWPVkEa7EaZl/7JKN7x9DF8U89YKroL
        eU7LHDMpOu8bHrN5DniDnIg=
X-Google-Smtp-Source: APXvYqxjrqxoR6Xo36BPfzyqhJjW/uie97jdZRtViFi3j0GgZFeSjU3qCJU3+hgU9bJL73mfAzbHDA==
X-Received: by 2002:a17:90a:c68c:: with SMTP id n12mr3760967pjt.29.1565104264950;
        Tue, 06 Aug 2019 08:11:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e11sm103946503pfm.35.2019.08.06.08.11.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:11:03 -0700 (PDT)
Subject: Re: [PATCH blktests] Make the NVMe tests more reliable
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190805232512.50992-1-bvanassche@acm.org>
 <9f8a82f6-5a7b-89ff-4a3a-fa4e9853fc35@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fe2fbdc2-8585-74fd-a222-b946fdab8909@acm.org>
Date:   Tue, 6 Aug 2019 08:11:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9f8a82f6-5a7b-89ff-4a3a-fa4e9853fc35@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/19 1:11 AM, Johannes Thumshirn wrote:
> On 06/08/2019 01:25, Bart Van Assche wrote:
> [...]
> 
>> +			for ((i=0;i<10;i++)); do
>> +				[ -e /sys/block/$dev/uuid ] &&
>> +					[ -e /sys/block/$dev/wwid ] &&
>> +					return 0
>> +				sleep .1
>> +			done
>> +			return 1
>>   		fi
>>   	done
>> +	return 1
> 
> Hmmm, I don't really understand why you're adding the return {0,1} here.
> None of the callers of _find_nvme_loop_dev() does anything with the
> return value of the function.
> 
> They expect either a nvme-device or an empty string and fail if the
> string is empty due to a non-empty diff in the golden output.

Hi Johannes,

The "return 0" statement has been added to break out of the two 
for-loops. The first "return 1" statement has been added to make sure 
that the echo "$dev" statement is executed at most once. The final 
"return 1" statement has been added to make the return value consistent.

Do you perhaps want me to leave out {0,1} from the return statements?

Bart.
