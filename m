Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D029C67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 17:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4FD20839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 17:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4FD20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeLLR6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:58:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34156 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeLLR6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 12:58:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so8959224plz.1
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 09:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WVJAP6YsYdTZR/TRF9eCikijygYqDwoTsYOUcVd1i6A=;
        b=KrGOVE87dN2RLpo0MmED9h2B/cLBpm7q39DdPcaOkjoKQIl0FUbHgtjn2IwFS+S+5U
         BPOvjULGoR+ZEnEEpsuR3SDk6msLjRqmLYjm70awpTqp40NNOzSeQjuQzL+SpdAbft4r
         5t0lzeZx0v43uSUathg6mXQuOitg4sm0s4nGnYIo+NDYedhwyU2XPtRHwFQhlWS94r5s
         2Y8Sb9oZA8arDIHQF5desgWjJweTO+2WURcS9yf346K7OBQZ+xCTUftoZca47AfrlO67
         ZYoEMXvoJzQB5g1W2t+aMJFlRKduWhAUEMwLgxxWzOx3Ma8aIDOuUm5Ny+OiSy30hI/t
         MINg==
X-Gm-Message-State: AA+aEWYJcMfuc8Cn8NTOpEqvhRMj5L3dS1tJ0cYurGD3nCB1lyWWc4xt
        1up5Plk0zpRkIb+6M4OdRyY=
X-Google-Smtp-Source: AFSGD/UYcB5hRFznHg8qM+5Tqe35iey+6/v8rQ95UM/TyjOG6mFybjWSJ1AMlUG1mGAAU2gjAs05Vw==
X-Received: by 2002:a17:902:541:: with SMTP id 59mr21057190plf.88.1544637523493;
        Wed, 12 Dec 2018 09:58:43 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id t13sm21529092pgr.42.2018.12.12.09.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 09:58:42 -0800 (PST)
Subject: Re: [PATCH v2 0/5] implement nvmf read/write queue maps
To:     James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
Date:   Wed, 12 Dec 2018 09:58:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Sagi,
> 
> What other wins are there for this split ?
> 
> I'm considering whether its worthwhile for fc as well, but the hol issue 
> doesn't exist with fc. What else is being resolved ?

I've pondered it myself, which is why I didn't add it to fc as well
(would have been easy enough I think). I guess that with this the
user can limit writes compared to read by assigning less queues as
jens suggested in his patches...
