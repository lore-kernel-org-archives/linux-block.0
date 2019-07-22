Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EFBC7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 22:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CADB21985
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 22:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfGVWgg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:36:36 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37204 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfGVWgg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 18:36:36 -0400
Received: by mail-pl1-f170.google.com with SMTP id b3so19766695plr.4
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 15:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZSH/y6lzo3OVrB+7LdKq5eKo9+FLnxE8eH5ENXUlTU=;
        b=Yl8SwC3pw2ZHY6qBfj/vy14VNQdJfOBc9OYY7XrZnnMydRbdy/MsUQSUwlKQrGdPaE
         Ar5bHUEzaPmLM0+otsMDmE0ogBWuQnWdAaGIa9FzZQml+lElRoKhS5fiQ1NxO81hg7da
         SKQr3c9YDRik606cGnhplrgk8BpVjL44FB28DhddVKPOQVbHPt1ez4qzZhdFMyPQcR30
         rXzhHyJs0QGn/O+xX2hk9/zP3gxDXU93voe+KtqQzARSI5WqP37HUeP1ccIrwxmHnW/E
         sEsRG0SBE2EGhGTyWNHZ+xjtsPQanvOn/lxFMt7EtJ8W8JWSdxz+WItREaXIn+uDYxIF
         yWWw==
X-Gm-Message-State: APjAAAXe9shweT56ziSz0XcyPB9Jt8xSHwyZ9ELaDrYCJLI8FBpqrT2S
        9gC36usEW5pcNamiAblNV0oIzYrUlHk=
X-Google-Smtp-Source: APXvYqxRXRv60EiwFE5PtRhiAj8Ru7dka87acQoL/bEkbzIK2j3GVOVOEdpNn+wNGlMfaPcYyOhj3w==
X-Received: by 2002:a17:902:1566:: with SMTP id b35mr79499430plh.147.1563834994920;
        Mon, 22 Jul 2019 15:36:34 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e6sm45215160pfn.71.2019.07.22.15.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 15:36:34 -0700 (PDT)
Subject: Re: regression: block/001 lead kernel NULL pointer from v5.3-rc1
To:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org
References: <1106410976.2184883.1563817165884.JavaMail.zimbra@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2ef64389-39e0-455e-d972-0fcb72f76b54@acm.org>
Date:   Mon, 22 Jul 2019 15:36:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1106410976.2184883.1563817165884.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 10:39 AM, Yi Zhang wrote:
> With step[1], this kernel NULL pointer[2] can be triggered every time from v5.3-rc1, let me know if you need more info, thanks.

Have you already tried patch "[PATCH] scsi: fix the dma_max_mapping_size 
call" (https://marc.info/?l=linux-scsi&m=156378725427719)?

Bart.
