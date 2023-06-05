Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F318C77B73
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 21:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjFEVPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjFEVOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 17:14:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B5FA
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 14:14:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64ff1f11054so850847b3a.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 14:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685999671; x=1688591671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oqx+vgT1KOd/rG0v+EGrhyHZcbzQJ8RW6j/ejKPzyV0=;
        b=j8g3UuzxdgTGjVV1y3R5vC/zbawUoqd0GHOEGH735oclZN5uylfFW29k3ALNqymkKO
         zOI9IJNptXyqvXhuDUohGo6+XB+iqAPTdpS8xnzQbyN9ZzCJb2V48dzwfhNnt29AVlKP
         VLFoQVZ/RzXJ4vShqVQv27MswBglmWDfKZPdwKBYEJDj+Bem9CeQfIxfrgTssr6LpEO1
         NWES731IZKMXHlB1inaKp40+GtlmXq369msNQea0Zdy1Az6CPeljXQoJWOQ1BrI3+n99
         B7Jqj4uJoFy0784kDvEhQTE8TUuagtZ+Pp9TRXRtSLou5H05oXjMmV83/lNRGEwjJYGs
         gAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685999671; x=1688591671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqx+vgT1KOd/rG0v+EGrhyHZcbzQJ8RW6j/ejKPzyV0=;
        b=P8cxX/DN23/HF3Kxlrby1ju9clgL7mMq2IHeNwMfJrE57kYKCvITOvubTdsdxk6qZj
         CYZGnPluGPRBRbrvR5NKZbf9WwjxcBwUSOdh1dg3pkQtTKcRsBbNkNvuNjrsc1WVZkuT
         N0vHCw+/T7JIVC8s9vz4oCfmIMYTayJOIpkOHAdxS82hxFpQaMKB1qY5rehpSBSlEL9J
         gEOsTw9KYQVF4pA2r2B8nveOqh/aM8CEf8U6/t3SdEtYF8jjwSE5QbmkgxTwx+hGW0qE
         7rIoOpfYEpy5Af47bBNDJ8gxdY4nZeYXJE9yGYfeQMQ1Qp8drVLKRRmPzr706PzQAvId
         FFfA==
X-Gm-Message-State: AC+VfDxQDDaGsvNT25fe8Snh4banl3FGeQvNEzlWROurXKkC/XHYv23T
        KwaKXeUGDyOemfjk8YVY13Em4A==
X-Google-Smtp-Source: ACHHUZ7F4+qQ0Ki8xUwZZjZ6tfxl9MU00ff9sZzRn2/+Pmuj5tNT2z/CfpIZyNw6H1APR47vxOd/1A==
X-Received: by 2002:a05:6a00:139a:b0:656:39af:5137 with SMTP id t26-20020a056a00139a00b0065639af5137mr6836048pfg.0.1685999671519;
        Mon, 05 Jun 2023 14:14:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c1::173f? ([2620:10d:c090:400::5:ffbc])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b0064d4d11b8bfsm5604697pfo.59.2023.06.05.14.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:14:30 -0700 (PDT)
Message-ID: <e340332d-ef64-9fa9-b4d6-927a3c271730@kernel.dk>
Date:   Mon, 5 Jun 2023 15:14:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 RESEND 0/3] sed-opal: keyrings, discovery, revert, key
 store
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        keyrings@vger.kernel.org
References: <20230601223745.2136203-1-gjoyce@linux.vnet.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230601223745.2136203-1-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/1/23 4:37 PM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> This patchset has gone through numerous rounds of review and
> all comments/suggetions have been addressed. I believe that
> this patchset is ready for inclusion.
> 
> TCG SED Opal is a specification from The Trusted Computing Group
> that allows self encrypting storage devices (SED) to be locked at
> power on and require an authentication key to unlock the drive.
> 
> The current SED Opal implementation in the block driver
> requires that authentication keys be provided in an ioctl
> so that they can be presented to the underlying SED
> capable drive. Currently, the key is typically entered by
> a user with an application like sedutil or sedcli. While
> this process works, it does not lend itself to automation
> like unlock by a udev rule.
> 
> The SED block driver has been extended so it can alternatively
> obtain a key from a sed-opal kernel keyring. The SED ioctls
> will indicate the source of the key, either directly in the
> ioctl data or from the keyring.
> 
> Two new SED ioctls have also been added. These are:
>   1) IOC_OPAL_REVERT_LSP to revert LSP state
>   2) IOC_OPAL_DISCOVERY to discover drive capabilities/state
> 
> change log v4:
>         - rebase to 6.3-rc7
> 	- replaced "255" magic number with U8_MAX

None of this applies for for-6.5/block, and I'm a little puzzled
as to why you'd rebase to an old kernel rather than a 6.4-rc at
least?

Please resend one that is current.

-- 
Jens Axboe


