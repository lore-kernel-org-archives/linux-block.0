Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C430CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB5F205ED
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbfJXRl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:41:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:41:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so9308570pgt.7
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMcyTj+Igo26pSD2m3juY7K786wQFq82aTRnWyvfbFw=;
        b=rIJV6Uw7qcpW+QYIf/wa3+9mO2D/1/B16CuC3B5k20/+tW26chkp/K1hMe5DPDU9q4
         +cbd+3zSdT3jtyWTzRJ34JDQ964d0/3sIPWAFmlyn5IUcfwOtLRWqG+4bT6fIqG9a1Oy
         ZBazuLhlPWCOSnzFeYxEu90+YNrcxrReGjOdxQ87HW9pFfwuonaCxUsFEOeTPHf8YcxP
         FXaDhhDVbQsHXNiyoLJzHwzelQKOCZwfz3dIN+x11cDXv6FG7CEcaWOXU6YOy5emGEcL
         zBQkRA25rrGrG0uSAmhFMpr6zqr0NbO5wJwblMHBe+4jLTd5ZdwIG7cIiUt8y90UG/o7
         Jnsw==
X-Gm-Message-State: APjAAAWRZLyGp2MreNh24J8f7Tw5dY8afLN7e8CeZ7Wgdt5UoJAHWTV5
        weRjuxBFxl5XokzVWcPVlB0=
X-Google-Smtp-Source: APXvYqz6OBLt4IbP0YCqkc17XZjrn8PshqXWq5EYaytvDm9h0OdfCcK80OxN4khlo1zYp4xVt5d4cg==
X-Received: by 2002:a65:6903:: with SMTP id s3mr17435247pgq.195.1571938911798;
        Thu, 24 Oct 2019 10:41:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d7sm14400119pgv.6.2019.10.24.10.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:41:50 -0700 (PDT)
Subject: Re: [PATCH blktests 1/2] Move and rename uptime_s()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-2-bvanassche@acm.org> <20191024172741.GA137052@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <931f12af-d28f-0b32-9b09-42ad206827e8@acm.org>
Date:   Thu, 24 Oct 2019 10:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024172741.GA137052@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 10:27 AM, Omar Sandoval wrote:
> On Mon, Oct 21, 2019 at 03:57:18PM -0700, Bart Van Assche wrote:
>> +# System uptime in seconds.
>> +_uptime_s() {
>> +	local a b
>> +
>> +	echo "$(</proc/uptime)" | {
> 
> What's wrong with cat /proc/uptime? Or even better,
> 
>    { read ... } < /proc/uptime

Hi Omar,

As you probably know 'cat' triggers a fork() system call but echo 
$(<...) not. This is a performance optimization. Input redirection would 
also work.

>> +		read -r a b && echo "$b" >/dev/null && echo "${a%%.*}";
> 
> What's the point of the echo "$b" here?

That echo "$b" statement suppresses a shellcheck warning about $b not 
being used.

> Seems like this could all be condensed to:
> 
>    { read -r s && echo "${s%%.*}" } < /proc/uptime
> 
> But that's more cryptic than it needs to be. Can we just do:
> 
>    awk '{ print int($1) }' /proc/uptime

That's a valid alternative, but an alternative that triggers a fork() 
system call. I don't have a strong opinion about which alternative to 
choose. Do you perhaps have a preference?

Thanks,

Bart.


