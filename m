Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 23:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242801AbiCaXLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiCaXLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 19:11:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA32665162
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 16:09:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f3so1005680pfe.2
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cz3GyvYVzV3EdDN6sB+1FTc+c9hwF2tdZTNimFcZLNE=;
        b=H+ydDUAE3ArEgOwqdy5OxWseMKcHyBBJkrf6rlBsJ08wAxF9Cfxer5aaRBdgBo+lBD
         7Tr10y0n0emtB4xE73WkxCkt40MOlRQBb6a3WGikOLrM+Cho5mM51lIxbW4CLargfshe
         B45zfCaSVIKHhhRW/+TdaeCB+we/UQZMTIC4MfIpodgd2jcW2O3V3rBOy7DMLx8/7FQQ
         cUoJWnYDQtTkx8IxrPIcqLPUg1uRBPf8v8PH+tKE0CM80Il166tAXfLdoV9Plju11dCo
         WAwF170/GBBWVDX2RmCp+IAFgBIG06mIP9pmIznSuBaxb/RkhFvHvz5v3Dk/8zXfggW2
         R4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cz3GyvYVzV3EdDN6sB+1FTc+c9hwF2tdZTNimFcZLNE=;
        b=GAYSrSrmhxav/Vb4Jiq/qMRJ7zY24Ye/wTbRhXDHLuacMI41RcLKRLZhV+fU6qjGxK
         uWZ/FuYXjZRCsKmsZd4QUPVYQn63pyqsdwoYkg56sOgvF8oq+Icw01YIyV3BKpI87auo
         2Qf1NUQOUAFeIjnLHwKZ2dsWIKC71pWhLdbZVQzgxVO1QsGnzxaL5ht8GLHpgSIlhXxv
         Hs/ZwE+TXvHMTgRKZjxrB18g32ttiWT+fHZ5uEZF2H0wfQAcpLnrB5F1Z07qUluGn7Zj
         lna1j4lYyhvI9FFCA+TQOZ2sNUXcE/hQbh9YlnCFsJxlOTmcTOXR6WUkVxDe98uERjpV
         mZSg==
X-Gm-Message-State: AOAM531xCj3kTgR8Y7kDDS5tGD/OsuePeRiVJMMTscQW4iBR7L4b1NfR
        QmJmapwlnYXMtoPki6Om2EuEiw==
X-Google-Smtp-Source: ABdhPJytWJ8U0yLRH8Kl35OBWcKwI3vz+SnWKsJfk0otE+SEsTGPONodJMMiXqpN14jZTP8fDBsXYw==
X-Received: by 2002:a63:d149:0:b0:384:b288:8704 with SMTP id c9-20020a63d149000000b00384b2888704mr12390321pgj.112.1648768193276;
        Thu, 31 Mar 2022 16:09:53 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm516225pfm.207.2022.03.31.16.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:09:52 -0700 (PDT)
Message-ID: <078e8084-8fea-5b69-89a6-9488a28163cf@kernel.dk>
Date:   Thu, 31 Mar 2022 17:09:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 2/2] drbd: remove check of list iterator
 against head past the loop body
Content-Language: en-US
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        linux-block@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
 <20220331220349.885126-2-jakobkoschel@gmail.com>
 <4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/22 4:28 PM, Christoph B?hmwalder wrote:
> Am 01.04.22 um 00:03 schrieb Jakob Koschel:
>> When list_for_each_entry() completes the iteration over the whole list
>> without breaking the loop, the iterator value will be a bogus pointer
>> computed based on the head element.
>>
>> While it is safe to use the pointer to determine if it was computed
>> based on the head element, either with list_entry_is_head() or
>> &pos->member == head, using the iterator variable after the loop should
>> be avoided.
>>
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element [1].
>>
> 
> Hi Jakob,
> 
> Both of these look good to me, thanks.
> 
> Reviewed-by: Christoph B?hmwalder <christoph.boehmwalder@linbit.com>

Applied both, but shortened title of this commit. Jakob, please keep it
within the usual 74 chars. In general, it's great to use a cover letter
for anything that's more than one patch. Just some pointers if you're
doing more of these.

-- 
Jens Axboe

