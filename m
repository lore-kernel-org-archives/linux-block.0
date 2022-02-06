Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1340EC433F5
	for <linux-block@archiver.kernel.org>; Sun,  6 Feb 2022 03:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiBFD5T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Feb 2022 22:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiBFD5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Feb 2022 22:57:18 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BF4C06173B
        for <linux-block@vger.kernel.org>; Sat,  5 Feb 2022 19:57:17 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so10008189pjb.5
        for <linux-block@vger.kernel.org>; Sat, 05 Feb 2022 19:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aRbUM2OkSJNzRmkAZ1wcN1ygc+lBSjgrwnIa5Qi6I/c=;
        b=pM8oYk8XBVqIlkzOiMITmkzX7l6EHdTiOQejlBIlHtPZS+PlQ1/f1M3JmxnYkltmGJ
         bAIxCI/L4yvSPMcOoQk1Hn29XAZ+aUCwt3/beVILtna1VMG22Ay42Rsotpfr2fRE+aRI
         zjE1UhsPTTpr8nHQxUzqV1gkex7ci6seGzE79xvDUqDibhShAErGc8ROIYYeRG6G/eLd
         a0lHf1MaKJE9wbzb8VVIyvQ7Abe6jPXVBWmwlmsT5XqYIGTQpOiOHQ7OtX1vClIhJm+d
         4E2nPzJBRGqS3JsTJMiec69oX5murMhxRP52qY0VKrvvU+a4TIVTYap0NH08xEzkVoCl
         xbdQ==
X-Gm-Message-State: AOAM530BQJm/4WQyZWqbgLemK+0Ps5OeFSpzpFxpxrb7YqqLIz46QRAV
        zBm5fU2brkFSWiIxcDnXkCs=
X-Google-Smtp-Source: ABdhPJzEWXrzA3Ymlxvd661PlinGyorNqwJHS7/8W+00fdSuYu+PPQme2mtebhBN8jvlu0UIoBS/jg==
X-Received: by 2002:a17:902:b941:: with SMTP id h1mr10459220pls.73.1644119837018;
        Sat, 05 Feb 2022 19:57:17 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id a3sm7145949pfk.73.2022.02.05.19.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 19:57:16 -0800 (PST)
Message-ID: <11565c22-33b2-dbf9-0409-b9926ff78997@acm.org>
Date:   Sat, 5 Feb 2022 19:57:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] blktests: replace module removal with patient module
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "dwagner@suse.de" <dwagner@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20211116172926.587062-1-mcgrof@kernel.org>
 <48b1d742-888c-ee14-297e-c63ae3bf37ed@nvidia.com>
 <Yf3iA/dDXOBJMXqU@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yf3iA/dDXOBJMXqU@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/22 18:33, Luis Chamberlain wrote:
> Bart, *poke*

My 2y old son is really good at taking up most of my spare time. Anyway, 
I will try to find some time to review this patch.

Bart.
