Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDEC07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 18:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457D20882
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 18:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D457D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLGSMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:12:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35565 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeLGSMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 13:12:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so4117703oif.2
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 10:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aELao7WI6GYmvS+KfTNsdss9koJmOjSjVdW+IPcoAdrQYOE7gOVPBIJUcx1a9A2/Q2
         8Omq5b0lMKnCvc9KAYb/axYeMRijh0CuBhS6PPG7ceZ2SGJEK5d2ja+W0/3VI50COCLM
         lqxQA7l87Bub+D4bc04NLK0KfbfXMLInmBGQx6LcTpCWmWZnUTF5tcdz0LsATHOdZfcA
         6Av4jQAboUZO4mfskKtsTeybr4rRUAjy2ggq05xFPDO37nEw/+yM0QndwvqKm28B0fiR
         YJmKWv5Er+6t6oSv5UBsp+oz6Q9nXMPSiKKWb30q4oXDJ72B2Bq8rThsPsZQUv2kBfyY
         jgZA==
X-Gm-Message-State: AA+aEWbS86gfW2Or1mdUQsUnOZ60y9y+vhQnV6NbOKxsDEHrmEiWLmoC
        XND3wQak/8Vaum8dFF4/Nzo=
X-Google-Smtp-Source: AFSGD/WUU0Oe00DWhZESNM1xolpw/KAdYIg59eOT4SCEn34pa0AkmhcBfwrYWo5uUulDvHcErnGvRw==
X-Received: by 2002:aca:e5cf:: with SMTP id c198mr1900536oih.21.1544206374132;
        Fri, 07 Dec 2018 10:12:54 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id p203sm4167868oic.49.2018.12.07.10.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:12:53 -0800 (PST)
Subject: Re: [PATCH V2] blk-mq: re-build queue map in case of kdump kernel
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, David Milburn <dmilburn@redhat.com>
References: <20181207030353.27575-1-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <99b2759a-1649-2ba9-84eb-5314c8d8e21d@grimberg.me>
Date:   Fri, 7 Dec 2018 10:12:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207030353.27575-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
