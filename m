Return-Path: <SRS0=nGPF=IF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B202C433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AF165172
	for <linux-block@archiver.kernel.org>; Sun,  7 Mar 2021 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCGTWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Mar 2021 14:22:36 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:34926 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhCGTWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Mar 2021 14:22:15 -0500
Received: by mail-pl1-f169.google.com with SMTP id d23so616100plq.2
        for <linux-block@vger.kernel.org>; Sun, 07 Mar 2021 11:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RlWewbSnlO8jQv/xhYrHQns3NqFumj4plP33DbefUM=;
        b=bVGvmfGMMMHRN/i/I1/U+6FvDh4gKtr3dI2bjhz9WUSVXU5lZG+LjdvuXH86YGWXFa
         ambKwihFk9965W3yyl9Ff/giXaJCWFJSYesH8ocNxfOrYPkNXrVNDduaDKwrZh3s3wmQ
         uo1cSr6R/oVuGQwxRRCfYLA4mANT5SOjTWDZhKm5GKfdEPQ0lsu9RcI2oh7ix6AoF0Dt
         XjVm48Sf3tvK7iIE3Cg9L9drioO5DNwmBmWfBm/qI1hFdKG7YRdyjN/9Wb89P33aA8nK
         LrIbWezeBM7fS5WirpFhzd2INEegpFirn4sFF0tVS44Mf/5J+GqZmULDB/tnPztCs/Ty
         RrYw==
X-Gm-Message-State: AOAM531D2hDvalvuqNVhyw5MUWRfY9o3W1WCQtByFpwX/3Sx6maEMOMZ
        0m/2mg+2soeJQ5i0P2jowccOrioM0WI=
X-Google-Smtp-Source: ABdhPJweBrPY9sAtv9j6XUyDYGiLY9s43gyz2bJuo4QoqkV4Lt638iSVDw5AlNeDa2lng9SuJaNvzw==
X-Received: by 2002:a17:902:ea09:b029:e6:1ef0:5c78 with SMTP id s9-20020a170902ea09b02900e61ef05c78mr2600738plg.12.1615144934457;
        Sun, 07 Mar 2021 11:22:14 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:78dd:acfd:a13b:b593? ([2601:647:4000:d7:78dd:acfd:a13b:b593])
        by smtp.gmail.com with ESMTPSA id o13sm8272297pfp.26.2021.03.07.11.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 11:22:13 -0800 (PST)
Subject: Re: [PATCH blktests v2] tests/srp/rc, tests/nvmeof-mp/rc: add fio
 check to group_requires
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@fb.com
Cc:     linux-block@vger.kernel.org
References: <20210307163142.6918-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4aabd75e-fe82-2341-d87f-581318276645@acm.org>
Date:   Sun, 7 Mar 2021 11:22:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210307163142.6918-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/21 8:31 AM, Yi Zhang wrote:
> Most of the srp and nvmeof-mp tests need fio, we need add fio
> check before running the tests

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
