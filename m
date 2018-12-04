Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FBC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283D520851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283D520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeLDBfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:35:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36591 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:35:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so12851153oix.3
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=IuoTsUO3he/P9JWG5HFiqcJ1LNYC5cm2TeUr5RRa53AkhQr+7Grr9Jx0RwNeTkWZlt
         DAZGawr3bIEifA9+1kptnISrCn/KDJz2JUTkWWAN7584x+QJHig4IQ0zKHU6Apbm0Emn
         9Fjjc4hr3g8P+avRIU0KYeoixbbfz8oVlHxlJ73Qa1r0nkjbYI5OlWH8qzNAo22HEtPN
         +szJsjOCkECOQazE+Iy17am4Cprwrat0jAVWiOe4oo1EAZZ2Q4jtHpURkcvySh3GVEV6
         MUIdIlVYr+srXJTV7SfT1JmU4wmjwtozOPtkqAqnZmKaQsskwvkDjbz5zvHwX5bvHGaN
         IRFA==
X-Gm-Message-State: AA+aEWbMHC8IEucGRziGrQr+qGDCFicm18kR2K/GR3G0OC4RVBCsBZoY
        XGeVqmqk4HsB68FErolhKGo=
X-Google-Smtp-Source: AFSGD/XabgZT++kqpnVk+sOoBxX44r3cIZc1NgmlESJATKlz28hTi9KifTy2yqucowIQ86KwqQ7qwA==
X-Received: by 2002:aca:5681:: with SMTP id k123mr11758490oib.106.1543887351010;
        Mon, 03 Dec 2018 17:35:51 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b23sm5601580otq.5.2018.12.03.17.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:35:50 -0800 (PST)
Subject: Re: [PATCH 2/7] blk-mq: add mq_ops->commit_rqs()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-3-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <36208bf2-723c-aa1d-0005-51df24204883@grimberg.me>
Date:   Mon, 3 Dec 2018 17:35:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128133538.20329-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
