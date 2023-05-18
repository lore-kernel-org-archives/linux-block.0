Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDDAC7EE23
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjERSsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjERSsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 14:48:38 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92519E4A
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 11:48:37 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64ab2a37812so14245545b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 11:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684435717; x=1687027717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoLMxU2AiA8K3biCj8siCU8Ywa2niccHNWDQzYwRfBI=;
        b=ker5CWBRbiquLgIT97md4W84wWF2gCimDl2vCYBarlp24kCO0w1b6G+g+ZvnY9CNf0
         zGW8GvkSWULgWEpL0TOTxEQAgLbKryCekllvU3gSmyAeiLXg7yVD6NFa8HwnIlAcBAD3
         pqMKwjoFx+Bkfe14COgJFqAU6O6C7UAvVew2vpU6YIvYcmcXuE8eskS6zbRSJbPbeqIE
         D77/ILi1KFV4KV1VqrCtphxLUAiYksqQaEVhkgQd2vCmc5hp1988zKFaznVmsvpK3TnW
         Cu/p178jDFpJAUU8vbjiinNNMn7T8vY1PNlhvqZ7hLdUdc4h8hZBxOL04EJsiRcbWwg5
         rMSA==
X-Gm-Message-State: AC+VfDx5+bK7Tr6XrD/V1+WHooBFG+9//4gw3dw30ufT9iGwFwGPA/Qb
        Acpn4byAXCaDQtP/l9GdHLY=
X-Google-Smtp-Source: ACHHUZ5jtOv/LSIyvajTYHVQZHSeyh6zv6L3YJiVsZPy4YlWE3HAF7wLxtr307q/NjhFBnXTJu6AXQ==
X-Received: by 2002:a17:903:1d1:b0:1ad:bccc:af77 with SMTP id e17-20020a17090301d100b001adbcccaf77mr4276041plh.18.1684435716922;
        Thu, 18 May 2023 11:48:36 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b001ae365072cfsm1758352pld.219.2023.05.18.11.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 11:48:36 -0700 (PDT)
Message-ID: <ebe0037c-7ab7-afb0-f4a4-79e8815ef588@acm.org>
Date:   Thu, 18 May 2023 11:48:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 07/11] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-8-bvanassche@acm.org>
 <37120c5c-120f-3ff3-fcbf-1a52f389fe3e@kernel.org>
 <06e87316-4b22-b275-4223-775192e5ccac@acm.org>
 <5829b5a0-d411-9485-2fa0-7c723377abf1@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5829b5a0-d411-9485-2fa0-7c723377abf1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 15:15, Damien Le Moal wrote:
> Hmmm... mq-deadline is not supposed to mix up reads and writes in the same
> scheduling batch, and there is one sort_list (rbtree) per data direction. So we
> should not be seeing different data directions in this loop, no ?

Right, we don't need this patch. I will drop it.

Bart.

