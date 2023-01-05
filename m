Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F27BC4708E
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 21:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjAEVTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Jan 2023 16:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjAEVT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 16:19:29 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3175D435
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 13:19:27 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id c2so13103777plc.5
        for <linux-block@vger.kernel.org>; Thu, 05 Jan 2023 13:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOQ2HLCxzL2beoBReil+5Eiz0t4yNOfu4jZCHGn2sog=;
        b=YMmf+gL8Ng9OxLoPRG1pwohc+XNjUSMOp21NlXpPIic3Ra9clyxVhhlULI0gcjQiRo
         yGY7GfgvguGfAD8KzaRpZfYjGdJ2NMdpHzBuO+Tn8larF982+4XWG7Mk13+LHzE20p4z
         kAh4LOX9aFWPql8Bk8YMWNYwH1yFxeoPWcPGoT85u/6gpqr8F/W3bwPy9dkSf3DpJ/6u
         wrSqmegQ0uYgjpeW7AG0z294M9RSKkELVy3p7ePt3JeqXx03gLbDIODUhESpSa+oIVwy
         2jwBQ2TS0kou6iHcOQDw6YkW1F+kcTAwNS9DyVvrH/hPICcAxpYdvVRslNQx2ZUqEX3j
         jUMw==
X-Gm-Message-State: AFqh2kpoBPJiaT/x80RukIrHLx0a3X2lmxQ/4zY5/dUfR4w7WlzgURrT
        IAQ2umPETMCYk32UvHTgiSQ=
X-Google-Smtp-Source: AMrXdXtUaU2GV59+/0wk0//bz+FYRIqSruFpNod3uwd0e2ESMoLI9C6HSiterbhUYj1simh8r7MX4g==
X-Received: by 2002:a17:902:e84d:b0:192:8824:e516 with SMTP id t13-20020a170902e84d00b001928824e516mr47776514plg.51.1672953567218;
        Thu, 05 Jan 2023 13:19:27 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f9eb:49b6:75b:111e? ([2620:15c:211:201:f9eb:49b6:75b:111e])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b00189a7fbfd44sm26390367plm.211.2023.01.05.13.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 13:19:26 -0800 (PST)
Message-ID: <619f3afc-1121-1a80-7cd1-e8cefce93498@acm.org>
Date:   Thu, 5 Jan 2023 13:19:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCHv4 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     hch@lst.de, martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230105205146.3610282-1-kbusch@meta.com>
 <20230105205146.3610282-2-kbusch@meta.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230105205146.3610282-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/5/23 12:51, Keith Busch wrote:
> This is used as an unsigned value, so define it that way to avoid
> having to cast it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
