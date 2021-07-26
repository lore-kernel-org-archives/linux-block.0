Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA1EC4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDAF60F0F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZHRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 03:17:23 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42509 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhGZHRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 03:17:20 -0400
Received: by mail-lf1-f43.google.com with SMTP id u3so13860469lff.9;
        Mon, 26 Jul 2021 00:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bgh7g2bRbIRcIJQ3wHLFOCKDp96I67ZCmk6/nj8zq70=;
        b=j3Uey8OhHJEZw8FyJnXZcIOxjlAzEzsRxiGyGtku2UaBccfE7AApeR8GdQSlZT7v7A
         zTOKuLUdezicdHsnj8Xw37JLESn2yQL1hdTzO+/qnmorKaHLx5GL8VjW8olbGV1daJz+
         gjHn37PdTukwpyo8ByDQsFjEKsM/tsBJyzbbTPhhmD6dynhV6RYHzr29oYxwtBrPSolx
         Eq4UU7D2Txp4wkvtY7OnfXF8aVeoDgd1fJsdJALTDKV7SbbamwMnDUpG1wJPgJIk0R9z
         iYgFf3JJeyf93ofOvQSPkCWrgF8NdUhknXuLsUOmgjyWKGS8YzwBlDkz0sNI6m6MJUR2
         WOUg==
X-Gm-Message-State: AOAM5300ouw1EvyPUL6LINxMsaT1KW7i2Cs81sgbyZzOS3D+fUs8JQfI
        Akn3uzaNS74C4Bu00bhKY4Q=
X-Google-Smtp-Source: ABdhPJySagHfPM/5iL3RlRVr7JOA22yR5kRHYLUMZ9YRInyhzVj+2kCb4deMAFuGQI8/dkFC8M0PIw==
X-Received: by 2002:ac2:44c2:: with SMTP id d2mr12763402lfm.50.1627286267195;
        Mon, 26 Jul 2021 00:57:47 -0700 (PDT)
Received: from [192.168.140.89] ([46.175.31.194])
        by smtp.gmail.com with ESMTPSA id y7sm2968725lfg.256.2021.07.26.00.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:57:46 -0700 (PDT)
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
To:     markh@compro.net, linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jkosina@suse.cz>, Mark Hounschell <dmarkh@cfl.rr.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
Date:   Mon, 26 Jul 2021 10:57:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 7/23/21 9:47 PM, Mark Hounschell wrote:
> 
> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.

Thank you for the report, I'm looking into this.

> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.

If it's a project with open sources could you please give a link?

Regards,
Denis
