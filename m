Return-Path: <SRS0=QBb8=4U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DEC3F2CD
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 01:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B7A24673
	for <linux-block@archiver.kernel.org>; Tue,  3 Mar 2020 01:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ZutnBTfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCCBWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:22:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41272 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCCBWo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 20:22:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id t14so536676plr.8
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 17:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WhEbWlEmBKMzZH7U4arFlyV9m+JED9PJgjCzvpK9LXQ=;
        b=ZutnBTfm9noQCdOa74+CERuz4XFanQntuWQtkiUcGTpbm41K8u6QSpv/GfXI4d3FeU
         bLRuMHvrTRcFBJTL8czu2dM4loKNWn/yQ1dPQH/tFWkqUHWi3rDyYt7aaOyokT9aZU1F
         Yl3gEkNS26QZJV6PtRyBda5Eq+0Y3fimbRMh++KxMdDhXeuzxIP0F/GhygZKhCZ53BWh
         LEkhZGFgVg/JmeGAy5eiifoOZHQs639InLCbHkU6VMuChhugVqhj0ShKH/wWw5LIeBun
         WVu4d7t8aPFXbWOTdpBC+9coeXwlYRfcU6pSY5J9v622Q+gP3V6dAi57nGfkSqjyMoHS
         1QGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WhEbWlEmBKMzZH7U4arFlyV9m+JED9PJgjCzvpK9LXQ=;
        b=HfnZdlmVuRzI7Blyqw113MrN6ZFdoeARelGzoaBKRZXXK1hlho86vXcxv4faIoQXms
         RIihoERAQObyo6loBqBZjao5/M70I1x5U5860GLmI/xvwUxc8DyV1gdyacOfd+oNu7B3
         LpUjyPiBbg9uz86vPLCyY0XrqENBMLfbzKihRi7bVLnpGyjkoZ6sDymTxm/X2qwQ2Cfb
         5YcT/IDwzS1TQ7zIAMze9YYs0XH/Go9vOscpQezey0Xd3m8nkAHHqYpAkAZUC/W36aza
         zDSEelyio5ezJsT78q+zp/IAeuB2HlcVIaeetZrarPmuKwZ6uLsyIcHhLGgRTPwnH2qT
         NmNg==
X-Gm-Message-State: ANhLgQ0bwG1bQP4+B9/e+THEpw1T6ObnFzcI8bcXuaQVQ2zc9LOZ0xFR
        jBOBs8S/LChComff/k/zZGeNbQ==
X-Google-Smtp-Source: ADFU+vvjc8kH/pghWZM6ALz+P4Vb4hgqPjnWt2UwzIjPMkIz29sZFUY8hCTKtif0S1tbnc/LppnnlA==
X-Received: by 2002:a17:90b:378d:: with SMTP id mz13mr1370790pjb.191.1583198563475;
        Mon, 02 Mar 2020 17:22:43 -0800 (PST)
Received: from ?IPv6:240e:82:3:5b12:940:b7e:a31d:58eb? ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id g19sm22044114pfh.134.2020.03.02.17.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 17:22:42 -0800 (PST)
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
To:     Coly Li <colyli@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     axboe@kernel.dk, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, hare@suse.de, mkoutny@suse.com,
        Oleg Nesterov <oleg@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz>
 <29a1c9fa-46e2-af5f-9531-c25dbb0a3dca@suse.de>
 <20200302134048.GK4380@dhcp22.suse.cz>
 <cc759569-e79e-a1a0-3019-0e07dd6957cb@suse.de>
 <20200302172840.GQ4380@dhcp22.suse.cz>
 <5693a819-e323-3232-2048-413566c2254f@suse.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <495d18c6-3776-33c7-c48b-bb85b31c3a96@cloud.ionos.com>
Date:   Tue, 3 Mar 2020 02:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5693a819-e323-3232-2048-413566c2254f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Coly,

On 3/2/20 6:47 PM, Coly Li wrote:
>> I have a vague recollection that there are mutlitple timeouts and
>> setting only some is not sufficient.
>>
> Let me try out how to extend udevd timeout.

Not sure if this link [1] helps or not, just FYI.

[1] https://github.com/jonathanunderwood/mdraid-safe-timeouts

Thanks,
Guoqing
